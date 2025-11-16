;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))
(local sys (autoload :globals.init))

(var M {})

(if (= sys.home :Kat-Arch)
    (set M {:enabled true
            :priority 1000
            :dir "~/Repos/NEOVIM/katdotnvim/"})
    (set M {1 :katawful/kat.nvim
            :enabled true
            :priority 1000}))

M
