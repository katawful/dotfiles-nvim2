-- [nfnl] fnl/plugins/katdotnvim.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local sys = autoload("globals.init")
local M = {}
if (sys.home == "Kat-Arch") then
  M = {enabled = true, priority = 1000, dir = "~/Repos/NEOVIM/katdotnvim/"}
else
  M = {"katawful/kat.nvim", enabled = true, priority = 1000}
end
return M
