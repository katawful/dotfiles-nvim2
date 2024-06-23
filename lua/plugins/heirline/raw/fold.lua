-- [nfnl] Compiled from fnl/plugins/heirline/raw/fold.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = require("globals.icons")
local conditions = autoload("heirline.conditions")
local utils = autoload("heirline.utils")
local M = {}
local function _2_()
  return options.get(foldenable)
end
local function _3_()
  local lnum = tostring(vim.v.lnum)
  local fillchars = options.get(fillchars)
  local foldchars
  local function _4_()
    local t_5_ = fillchars.foldopen
    return t_5_
  end
  local function _6_()
    local t_7_ = fillchars.foldclosed
    return t_7_
  end
  local function _8_()
    local t_9_ = fillchars.foldsep
    return t_9_
  end
  local function _10_()
    local t_11_ = fillchars.vert
    return t_11_
  end
  foldchars = {open = (_4_() or icons.ui["arrow-down"]), closed = (_6_() or icons.ui["arrow-right"]), sep = (_8_() or " "), vert = (_10_() or icons.ui.vert)}
  local fold_start = vim.fn.foldclosed(lnum)
  local fold_end = vim.fn.foldclosedend(lnum)
  local fold_level = vim.fn.foldlevel(lnum)
  local fold_open_3f = (vim.v.lnum ~= fold_start)
  local fold_3f = (string.find(vim.treesitter.foldexpr(vim.v.lnum), ">") ~= nil)
  if (fold_open_3f and fold_3f) then
    return utils["fold-spacing"](lnum)
  else
    return nil
  end
end
M.open = {condition = _2_, provider = _3_}
return nil
