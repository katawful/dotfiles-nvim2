-- [nfnl] fnl/plugins/katdotnvim.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local sys = autoload("globals.init")
local M = {}
if (sys.home == "Kat-Arch") then
  local function _2_()
    return vim.cmd.colorscheme("kat.nvim")
  end
  M = {enabled = true, priority = 1000, dir = "~/Repos/NEOVIM/katdotnvim/", config = _2_}
else
  local function _3_()
    return vim.cmd.colorscheme("kat.nvim")
  end
  M = {"katawful/kat.nvim", enabled = true, priority = 1000, config = _3_}
end
return M
