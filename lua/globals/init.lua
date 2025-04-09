-- [nfnl] Compiled from fnl/globals/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("globals.options")
require("globals.maps")
require("globals.autocmds")
return {home = vim.env.HOME, name = string.sub(vim.fn.system("uname -n"), 1, -2), ["git-path"] = (vim.env.HOME .. "/Repos/")}
