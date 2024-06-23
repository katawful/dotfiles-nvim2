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
(local raw-file (autoload :plugins.heirline.file))
(local delimiter config.providers.delimiter)
(local M {})

(set M.tabline-name {:init #(set $1.filename (vim.api.nvim_buf_get_name
                                               $1.bufnr))
                     :hl #(if $1.is_active "TabLineSel" "TabLine")
                     :on_click {:callback (fn [_ minwid _ button]
                                            (if (= button "m")
                                                (vim.schedule
                                                  #(vim.api.nvim_buf_delete
                                                     minwid {:force false}))
                                                (utils.get-win-for-buf minwid)))
                                :minwid #$1.bufnr
                                :name "heirline_tabline_buffer_callback"}
                     1 raw-file.bufnr
                     2 raw-file.icon
                     3 raw-file.short-name
                     4 raw-file.bufnr-flags})

(set M.tabline-close-button
   {:condition #(not (vim.api.nvim_buf_get_option $1.bufnr "modified"))
    1 {:provider " "}
    2 {:provider icons.ui.close
       :on_click {:callback (fn [_ minwid]
                              (vim.schedule
                                #(do (vim.api.nvim_buf_delete minwid
                                                              {:force false})
                                   (cmd.run.cmd :redrawtabline))))
                  :minwid #$1.bufnr
                  :name "heirline_tabline_close_buffer_callback"}}})

(set M.tabline-block {1 (heir-utils.surround delimiter.both
                                      #(if $1.is_active
                                           (. (heir-utils.get_highlight
                                                "TabLineSel") :bg)
                                           (. (heir-utils.get_highlight
                                                "TabLine") :bg))
                                      [M.tabline-name
                                       M.tabline-close-button])
                      :condition #$1.is_visible
                      :hl {:bg :pink}})

(set M.tabline-line (heir-utils.make_buflist M.tabline-block
                                      {:provider "<" :hl {:fg "gray"}}
                                      {:provider ">" :hl {:fg "gray"}}))

(set M.tabline-page {:provider #(.. "%" $1.tabnr "T" $1.tabpage "%T")
                     :hl #(if $1.is_active "TabLineSel" "TabLine")})

(set M.tabline-page-close {:provider "%999X%X" :hl "TabLine"})

(set M.tabline-pages {:condition #(utils.show-element? 0)
                      1 {:provider "%="}
                      2 (heir-utils.make_tablist {1 (heir-utils.surround
                                                      delimiter.both
                                                      #(if $1.is_active
                                                           :blue
                                                           :purple)
                                                      M.tabline-page)
                                                  :hl {:bg :pink}
                                                  :condition #(utils.show-element? 2)})
                      3 {1 (heir-utils.surround
                             delimiter.both
                             #:purple
                             M.tabline-page-close)
                         :condition #(utils.show-element? 2)
                         :hl {:bg :pink}}})

(set M.component [M.tabline-line M.tabline-pages])

M
