(require :globals.options)
(require :globals.maps)
(require :globals.autocmds)

{:home vim.env.HOME
 :name (string.sub (vim.fn.system "uname -n") 1 -2)
 :git-path (.. vim.env.HOME "/Repos/")}
