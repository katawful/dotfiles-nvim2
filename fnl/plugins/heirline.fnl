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
(local file (autoload :plugins.heirline.file))
(local buffer (autoload :plugins.heirline.buffer))
(local tabline (autoload :plugins.heirline.tabline))
(local fold (autoload :plugins.heirline.fold))
(local lsp (autoload :plugins.heirline.lsp))

(fn line [_plugin _opts]

  ;; Store all used heirline elements into neatly organized tables
  (local components {})
  (local raw {})

  ;; Setup colors
  (set config.colors (config.gen-colors))
  (local colors config.colors)

  ((. (require :heirline) :load_colors) config.colors)
  (options.set showtabline 2)
  (let [heir (auto.group.define "UserHeirline" true)]
    (auto.group.fill heir
      (auto.cmd.create "ColorScheme"
                       nil
                       #(do
                          ;(set config.colors (config.gen-colors))
                          ;(print config.colors.normal_bg)
                          (line))
                       "heirline.nvim -- Reload colors on change")))

  (utils.status-color config.colors)

  ;; Configuration
  (local delimiter config.providers.delimiter)

  ;; Vi-Mode
  ;; Displays the current mode neovim is in
  (set raw.vi-mode vi-mode.component)

  (set raw.buffername buffer.component)

  ;; Construct components
  (set components.vi-mode [(heir-utils.surround delimiter.both
                                           #($1:mode_color)
                                           [raw.vi-mode])])

  (set components.filename [raw.buffername
                            {:provider (. delimiter.right 2)
                             :hl {:fg :blue}}])

  (set components.spell {1 (heir-utils.surround delimiter.both #:purple file.spell)
                         :condition #vim.wo.spell
                         :hl {:bg :pink}})

  (set components.tabline tabline.component)
  (set components.filedetails file.filedetails)

  (set raw.fold fold.component)
  (set raw.lnum {:condition #(options.get number)
                 :provider #(let [lnum (tostring vim.v.lnum)
                                  lnum-length (length lnum)
                                  lnum-size (utils.size-of-lnum)
                                  lnum (if (> lnum-size lnum-length)
                                           (.. " " lnum) lnum)]
                              lnum)
                 :hl #(utils.hl-current-line {:default config.colors.light_pink
                                              :new config.colors.pink}
                                             nil
                                             {:default {:bold false}
                                              :new {:bold true}})})

  (set raw.relnum {:condition #(options.get relativenumber)
                   :provider #(let [relnum (tostring vim.v.relnum)
                                    relnum (if (> (length relnum) 1)
                                               relnum
                                               (.. " " relnum))]
                                   relnum)
                   :hl #(utils.hl-current-line {:default config.colors.light_pink
                                                :new config.colors.pink}
                                               nil
                                               {:default {:bold false}
                                                :new {:bold true}})})

  (set raw.marks {:condition #(or (or (options.get number)
                                      (options.get relativenumber))
                                  (and (options.get number)
                                       (options.get relativenumber)))
                  :hl #(utils.hl-current-line {:default config.colors.blue
                                               :new config.colors.dark_blue}
                                              nil
                                              {:default {:bold false}
                                               :new {:bold true}})
                  :provider #(let [marks (vim.fn.getmarklist (vim.fn.bufname))
                                   ;; note that the 2nd index is for the line number
                                   lnum vim.v.lnum]
                               (var matched? false)
                               (var index 0)
                               (each [i mark (ipairs marks) &until matched?]
                                 (if (= (. (. mark :pos) 2) lnum)
                                     (do
                                       (set index i)
                                       (set matched? true))
                                     (do
                                       (set index 0)
                                       (set matched? false))))
                               (if matched?
                                   (string.sub (. (. marks index) :mark)
                                               2 2)
                                   " "))})

  (set raw.lsp-signs {:init #(set $1.sign (lsp.get-sign (lsp.get-name) vim.v.lnum))
                      :provider #(match (lsp.get-sign-icon $1.sign)
                                   :E icons.lsp.error
                                   :H icons.lsp.hint
                                   :I icons.lsp.info
                                   :O icons.lsp.other
                                   :W icons.lsp.warn
                                   _ " ")
                      :hl #(lsp.get-sign-type $1.sign)
                      :condition #(conditions.lsp_attached)})

  (set components.numbers {1 raw.lnum
                           2 raw.marks
                           3 raw.relnum})

  (set raw.gitsigns git.component)

  (set components.statuscolumn {1 raw.fold
                                2 {:provider " "
                                   :condition #(options.get foldenable)}
                                3 components.numbers
                                4 raw.gitsigns
                                5 raw.lsp-signs
                                :hl #(utils.hl-current-line nil
                                                            {:default config.colors.bright_bg
                                                             :new config.colors.normal_bg})})
                                ;:condition #(conditions.is_active)})

  ;; Return statusline
  {:tabline components.tabline
   :statusline {:static vi-mode.static
                :hl #(if (conditions.is_active)
                         :StatusLine
                         :StatusLineNC)
                :fallthrough true
                1 {:condition conditions.is_active
                   1 components.vi-mode}
                2 components.spell
                3 components.filename
                4 config.providers.even
                5 {:condition conditions.is_active
                   1 components.filedetails}}
   :statuscolumn components.statuscolumn})

{:dependencies [{:dir "~/Repos/NEOVIM/katdotnvim/"}
                [:nvim-tree/nvim-web-devicons]]
 :priority 1
 :opts #(line $1 $2)
 1 :rebelot/heirline.nvim}
