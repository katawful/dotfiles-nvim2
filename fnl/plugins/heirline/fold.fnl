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

(local colors config.colors)

(set M.component {:condition #(options.get foldenable)
                  :provider #(let [lnum (tostring vim.v.lnum)
                                   fillchars (options.get fillchars)
                                   foldchars {:open (or (?. fillchars.foldopen)
                                                        icons.ui.arrow-down)
                                              :closed (or (?. fillchars.foldclosed)
                                                          icons.ui.arrow-right)
                                              :sep (or (?. fillchars.foldsep)
                                                       " ")
                                              :vert (or (?. fillchars.vert)
                                                        icons.ui.vert)}
                                   fold-start (vim.fn.foldclosed lnum)
                                   fold-end (vim.fn.foldclosedend lnum)
                                   fold-level (vim.fn.foldlevel lnum)
                                   ; -1 is when the fold is open/non-existent
                                   fold-closed? (> fold-start -1)
                                   fold-open? (not= vim.v.lnum fold-start)
                                   fold? (not= (string.find (vim.treesitter.foldexpr vim.v.lnum) ">")
                                               nil)]
                               (if fold-closed?
                                   foldchars.closed
                                   (and fold-open? fold?)
                                   foldchars.open
                                   " "))
                  :hl #(utils.hl-current-line {:default colors.green
                                               :new colors.light_green}
                                              nil
                                              {:default {:bold false}
                                               :new {:bold true}})})
M

