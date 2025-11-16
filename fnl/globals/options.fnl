(import-macros m :init-macros)

(comment "Top Level")
(m.options.set {mouse :nvi
                termguicolors true
                signcolumn "yes:1"
                number true
                relativenumber true
                smoothscroll true
                modeline true
                undofile true
                virtualedit "block"
                hidden false
                updatetime 100
                cmdheight 1
                title true}
               nil true)

(m.options.set clipboard :unnamedplus :append true)


(comment "Folding")
(m.options.set {foldenable false
                foldmethod :syntax
                foldcolumn :3}
               nil true)

(comment "List Characters")
(m.options.set {list true
                listchars {:tab "  "
                           :trail "■"
                           :extends ">"
                           :precedes "<"}}
            nil true)

(comment "Tabs")
(m.options.set {tabstop 4 shiftwidth 4 expandtab true} nil true)

(comment "Concealing")
(m.options.set {conceallevel 2 concealcursor ""} nil true)

(comment "Line Breaking")
(m.options.set {breakindent true linebreak true showbreak "=>"} nil true)

(comment "Extra")
(m.options.set {inccommand :nosplit background :light} nil true)
(m.options.set nrformats :octal :remove true)

(vim.diagnostic.config {:virtual_text false})
(vim.lsp.inlay_hint.enable)

(comment "GUI")
(if vim.g.neovide
    (m.options.set :g {:neovide_cursor_animation_length 0.02
                       :neovide_cursor_trail_length 2
                       :neovide_cursor_vfx_mode :railgun
                       :neovide_cursor_vfx_particle_density 20
                       :neovide_cursor_vfx_particle_speed 10
                       :neovide_text_gamma 0.8
                       :neovide_text_contrast 0.1
                       :neovide_remember_window_size true
                       :neovide_remember_window_position false}))
