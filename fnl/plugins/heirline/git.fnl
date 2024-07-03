;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))

;;; Boilerplate
(local icons (autoload :globals.icons))
(local conditions (autoload :heirline.conditions))
(local heir-utils (autoload :heirline.utils))
(local utils (autoload :plugins.heirline.utils))
(local config (autoload :plugins.heirline.config))

;;; Macros
(import-macros lazy :nvim-anisole.macros.lazy)
(import-macros auto :nvim-anisole.macros.autocmds)
(import-macros cmd :nvim-anisole.macros.commands)
(import-macros options :nvim-anisole.macros.options)

;;; Components
(local git (autoload :plugins.heirline.git))
(local vi-mode (autoload :plugins.heirline.vi-mode))
(local delimiter config.providers.delimiter)
(local M {})
(local P {})

(fn P.hunk-deleted [hunk]
  "FN: P.hunk-deleted -- Return a modified deleted hunk
  @hunk: table -- a hunk as defined by gisigns.nvim"
  (let [removed hunk.removed start removed.start end (+ start removed.count)]
    {:type :delete : start : end}))

(fn P.hunk-added [hunk]
  "FN: P.hunk-added -- Return a modified added hunk
  @hunk: table -- a hunk as defined by gisigns.nvim"
  (let [added hunk.added start added.start end (+ start added.count)]
    {:type :add : start : end}))

(fn P.hunk-changed [hunk]
  "FN: P.hunk-changed -- Return a modified changed hunk
  @hunk: table -- a hunk as defined by gisigns.nvim"
  (let [added hunk.added
              added-start added.start
              added-end (+ added-start added.count)
              removed hunk.removed
              removed-start removed.start
              removed-end (+ removed-start removed.count)]
    {:type :change
     : added-start : added-end
     : removed-start : removed-end}))

(fn M.modify-hunk [hunk]
  "FN: modify-hunk -- Returns modified hunk table for statuscolumn

  The modified hunk table is defined as so:
  ```fennel
  {:type hunk-type
   :start hunk-line-number-start
   :end hunk-line-number-end}}
  ```
  @hunk: table -- a hunk as defined by gitsigns.nvim"
  (match (. hunk :type)
    :change (P.hunk-changed hunk)
    :add (P.hunk-added hunk)
    :delete (P.hunk-deleted hunk)))


(fn M.inside-hunk? [lnum start end]
  "FN: inside-hunk? -- Are we inside of a hunk currently?
  @lnum: int -- the line number
  @start: int -- the start line number of a hunk
  @end: int -- the end line number of a hunk"
  (and (>= lnum start) (<= lnum end)))

(set M.component {:init #(set $1.hunk
                              (let [hunks ((. (require :gitsigns) :get_hunks))]
                                (var result false)
                                (var out nil)
                                (when hunks (each [_ hunk (ipairs hunks) &until result]
                                              (let [hunk-mod (M.modify-hunk hunk)]
                                                (match hunk-mod.type
                                                  :change (when (or (M.inside-hunk?
                                                                      vim.v.lnum
                                                                      hunk-mod.added-start
                                                                      hunk-mod.added-end)
                                                                    (M.inside-hunk?
                                                                      vim.v.lnum
                                                                      hunk-mod.removed-start
                                                                      hunk-mod.removed-end))
                                                            (set result true)
                                                            (set out hunk-mod))
                                                  _ (do (when (M.inside-hunk? vim.v.lnum
                                                                              hunk-mod.start
                                                                              hunk-mod.end)
                                                          (set result true)
                                                          (set out hunk-mod)))))))
                                out))
                  :condition #vim.b.gitsigns_status
                  :provider #(if $1.hunk icons.ui.block-left config.providers.space)
                  :hl #(match (?. (?. $1 :hunk) :type)
                         :add (utils.hl-current-line {:default config.colors.dark_green
                                                      :new config.colors.green}
                                                     nil
                                                     {:default {:bold false}
                                                      :new {:bold true}})
                         :delete (utils.hl-current-line {:default config.colors.dark_red
                                                         :new config.colors.red}
                                                        nil
                                                        {:default {:bold false}
                                                         :new {:bold true}})
                         :change (if (M.inside-hunk? vim.v.lnum
                                                     $1.hunk.added-start
                                                     $1.hunk.added-end)
                                     (utils.hl-current-line {:default config.colors.dark_purple
                                                             :new config.colors.purple}
                                                            nil
                                                            {:default {:bold false}
                                                             :new {:bold true}})
                                     (M.inside-hunk? vim.v.lnum
                                                     $1.hunk.removed-start
                                                     $1.hunk.removed-end)
                                     (utils.hl-current-line {:default config.colors.dark_blue
                                                             :new config.colors.blue}
                                                            nil
                                                            {:default {:bold false}
                                                             :new {:bold true}}))
                         nil (utils.hl-current-line nil
                                                    {:default config.colors.bright_bg
                                                     :new config.colors.normal_bg}))})
M
