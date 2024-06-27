(import-macros option :nvim-anisole.macros.options)

(comment "Top Level")
(option.set {mouse :nvi
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
             cmdheight 2
             title true})

(option.set clipboard :unnamedplus :append)

(comment "Folding")
(option.set {foldenable false
             foldmethod :syntax
             foldcolumn :3})

(comment "List Characters")
(option.set {list true
             listchars {:tab "  "
                        :trail "■"
                        :extends ">"
                        :precedes "<"}})

(comment "Tabs")
(option.set {tabstop 4 shiftwidth 4 expandtab true})

(comment "Concealing")
(option.set {conceallevel 2 concealcursor ""})

(comment "Line Breaking")
(option.set {breakindent true linebreak true showbreak "=>"})

(comment "Extra")
(option.set inccommand :nosplit)
(option.set nrformats :octal :remove)

(vim.diagnostic.config {:virtual_text false})
(vim.lsp.inlay_hint.enable)

(option.set guifont ["FiraCode Nerd Font Mono" ":h12"])
(if vim.g.neovide
    (option.set :g {:neovide_cursor_animation_length 0.02
                    :neovide_cursor_trail_length 2
                    :neovide_cursor_vfx_mode :railgun
                    ;:neovide_cursor_transparency 0.75
                    :neovide_transparency 0.75
                    :neovide_cursor_vfx_particle_density 20
                    :neovide_cursor_vfx_particle_speed 10
                    :neovide_remember_window_size false
                    :neovide_remember_window_position false}))
