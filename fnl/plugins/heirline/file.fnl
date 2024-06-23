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

;; Filename
;; Displays the filename with the following additions:
;; - Colored icon
;; - Modified status
(set M.block {:init #(set $1.filename (vim.api.nvim_buf_get_name 0))})

(set M.icon {:init #(let [extension (cmd.run.fn :fnamemodify
                                                $1.filename
                                                ":e")]
                      (set ($1.icon $1.icon_color)
                           ((. (require :nvim-web-devicons)
                               :get_icon_color)
                            $1.filename extension {:default true})))
             :provider #(and $1.icon (.. $1.icon " "))
             :hl #{:fg $1.icon_color}})

(set M.full-name {:init #(set $1.filename (vim.api.nvim_buf_get_name 0))
                  :condition #(or (not= vim.bo.filetype :help)
                                  (not= vim.bo.filetype ""))
                  :provider #(let [filename (cmd.run.fn :fnamemodify
                                                        $1.filename
                                                        ":.")]
                               (if (= filename "")
                                   icons.ui.file
                                   (not (conditions.width_percent_below
                                          (length filename)
                                          0.35))
                                   (cmd.run.fn :pathshorten filename)
                                   filename))
                  :hl {:fg :normal_fg}})

(set M.bufnr {:provider #(.. (tostring $1.bufnr) ". ")
              :hl {:fg :normal_fg}})

(set M.short-name {:provider #(if (= $1.filename "")
                                  icons.ui.file
                                  (cmd.run.fn fnamemodify $1.filename ":t"))
                   :hl #{:bold (or $1.is_active $1.is_visible) :italic true}})

(set M.flags [{:condition #vim.bo.modified
               :provider " 󰆓"
               :hl {:fg "red"}}
              {:condition #(or (not vim.bo.modifiable)
                               vim.bo.readonly)
               :provider " "
               :hl {:fg "orange"}}])

(set M.bufnr-flags [{:condition #(vim.api.nvim_buf_get_option
                                   $1.bufnr "modified")
                     :provider (.. " " icons.ui.save)
                     :hl {:fg "red"}}
                    {:condition #(or (not (vim.api.nvim_buf_get_option $1.bufnr
                                                                       :modifiable))
                                     (vim.api.nvim_buf_get_option $1.bufnr
                                                                   :readonly))
                     :provider #(if (= (vim.api.nvim_buf_get_option 
                                         $1.bufnr :buftype)
                                       :terminal)
                                    (.. " " icons.ui.terminal " ")
                                    (.. " " icons.ui.lock " "))
                     :hl {:fg "orange"}}])

;; File Details
(set M.ftype {:provider #(if (= vim.bo.filetype "")
                             (string.upper vim.bo.buftype)
                             (string.upper vim.bo.filetype))
              :hl {:fg :normal_fg
                   :bold true}})

(set M.encoding {:provider #vim.bo.fenc
                 :hl {:fg :normal_fg}})

(set M.format {:provider #(if (= vim.bo.fileformat :unix) icons.ui.linux icons.ui.windows)
               :hl {:fg :normal_fg}})

(set M.size {:provider #(let [suffix [:b :k :M :G :T :P :E]
                              fsize (cmd.run.fn :getfsize
                                                (vim.api.nvim_buf_get_name 0))
                              fsize (if (> 0 fsize) 0 fsize)]
                          (if (> 1024 fsize)
                              (.. fsize (. suffix 1))
                              (let [i (math.floor (/ (math.log fsize)
                                                     (math.log 1024)))]
                                (string.format "%.2g%s"
                                               (/ fsize
                                                  (math.pow 1024 i))
                                               (. suffix (+ i 1))))))
             :hl {:fg :orange}})

(set M.position {:provider "%5(%l/%3L%):%2c"
                 :hl {:fg :normal_fg}})


;; Specific Buffers
(set M.help {:provider #(string.format
                          "%s %s"
                          icons.ui.question
                          (cmd.run.fn :fnamemodify
                                      (vim.api.nvim_buf_get_name 0)
                                      ":t"))
             :hl {:fg :normal_fg
                  :bg :blue}})

(set M.terminal {:provider #(string.format
                              "%s %s"
                              icons.ui.terminal
                              (: (vim.api.nvim_buf_get_name 0) :gsub
                                 ".*:"
                                 ""))
                 :hl {:fg :normal_fg
                      :bg :blue}})

(set M.spell {:condition #vim.wo.spell
              :provider icons.ui.spell
              :hl {:bold true :fg :green}})


(set M.filedetails [(heir-utils.surround delimiter.left #:blue M.ftype)
                    {1 {:provider (. delimiter.both 2)}
                     :hl {:fg :blue :bg :dark_blue}}
                    {:provider " " :hl {:bg :dark_blue}}
                    {1 M.size :hl {:bg :dark_blue}}
                    {:provider " " :hl {:bg :dark_blue}}
                    {1 M.position :hl {:bg :dark_blue}}
                    {:provider " " :hl {:bg :dark_blue}}
                    {1 M.format :hl {:bg :dark_blue}}
                    {:provider " " :hl {:bg :dark_blue}}
                    {1 M.encoding :hl {:bg :dark_blue}}
                    {1 {:provider (. delimiter.both 2)}
                     :hl {:bg :pink :fg :dark_blue}}])

M
