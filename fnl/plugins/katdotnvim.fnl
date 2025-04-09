;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))
(local sys (autoload :globals.init))

(var M {})
(vim.inspect sys.home)
(vim.inspect :Kat-Arch)

(if (= sys.home :Kat-Arch)
    (set M {:enabled true
            :priority 1000
            :dir "~/Repos/NEOVIM/katdotnvim/"
            :config #(vim.cmd.colorscheme :kat.nvim)})
    (set M {1 :katawful/kat.nvim
            :enabled true
            :priority 1000
            :config #(vim.cmd.colorscheme :kat.nvim)}))

M
