(local M {:path {}})

(comment "Create necessary paths")
(set M.path.lazy (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim))
(set M.path.package (.. (vim.fn.stdpath :data) :/lazy))
(set M.config-name :nvim)
(set M.path.nfnl (.. vim.env.HOME :/.config/ M.config-name :/.nfnl.fnl))
(set M.path.macros (.. vim.env.HOME "/Repos/NEOVIM/nvim-anisole-macros"))

(comment "Install lazy for later. This is the recommended install method, not fennel specific")
(fn lazy-install []
  (when (not (vim.uv.fs_stat M.path.lazy))
    (vim.fn.system [:git
                    :clone
                    "--filter=blob:none"
                    :--single-branch
                    "https://github.com/folke/lazy.nvim.git"
                    M.path.lazy])))

(comment "Allow installation of bootstrapping plugins
      Macros and nfnl for compilation are installed this way")
(fn ensure [repo package dir]
 (if (not dir)
     (do
       (vim.fn.system [:git
                       :clone
                       "--filter=blob:none"
                       :--single-branch
                       (.. "https://github.com/" repo :.git)
                       (.. M.path.package "/" package)])
       (vim.opt.runtimepath:prepend (.. M.path.package "/" package)))
     (let [install-path (string.format "%s/%s" M.path.package
                         package)]
       (vim.fn.system (string.format "rm -r %s" install-path))
       (vim.fn.system (string.format "ln -s %s %s" repo
                       M.path.package))
       (vim.opt.runtimepath:prepend install-path))))

(comment "nfnl requires a config file to work, simply add that")
(fn nfnl-config []
  (when (not (vim.uv.fs_stat M.path.nfnl))
    (vim.fn.system (.. "touch " M.path.nfnl))
    (vim.fn.system (.. "bash -c 'echo \"{}\" >> " M.path.nfnl "'"))))

(comment "Bootstrap Lazy and fennel environment")
(lazy-install)
(if (= (string.sub (vim.fn.system "uname -n") 1 -2) :Kat-Arch)
    (ensure M.path.macros :nvim-anisole-macros true)
    (ensure :katawful/nvim-anisole-macros :nvim-anisole-macros))
(ensure :Olical/nfnl :nfnl)
(nfnl-config)
(vim.opt.runtimepath:prepend M.path.lazy)


(comment "Intialize config")
(require :globals)
((. (require "lazy") :setup) :plugins {:change_detection {:notify false}})

M
