;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))
(local sys (autoload :globals.init))

(var M {})

(if (= sys.home :Kat-Arch)
    (set M {:dir "~/Repos/NEOVIM/nvim-anisole-macros/"})
    (set M [:katawful/nvim-anisole-macros/]))

M
