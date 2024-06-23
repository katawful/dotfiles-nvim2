-- [nfnl] Compiled from fnl/plugins/heirline/fold.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local conditions = autoload("heirline.conditions")
local heir_utils = autoload("heirline.utils")
local utils = autoload("plugins.heirline.utils")
local config = autoload("plugins.heirline.config")
local git = autoload("plugins.heirline.git")
local vi_mode = autoload("plugins.heirline.vi-mode")
local delimiter = config.providers.delimiter
local M = {}
local colors = config.colors
local function _2_()
  return (vim.opt.foldenable):get()
end
local function _3_()
  local lnum = tostring(vim.v.lnum)
  local fillchars = (vim.opt.fillchars):get()
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
  local fold_closed_3f = (fold_start > -1)
  local fold_open_3f = (vim.v.lnum ~= fold_start)
  local fold_3f = (string.find(vim.treesitter.foldexpr(vim.v.lnum), ">") ~= nil)
  if fold_closed_3f then
    return foldchars.closed
  elseif (fold_open_3f and fold_3f) then
    return foldchars.open
  else
    return " "
  end
end
local function _13_()
  return utils["hl-current-line"]({default = colors.green, new = colors.light_green}, nil, {default = {bold = false}, new = {bold = true}})
end
M.component = {condition = _2_, provider = _3_, hl = _13_}
return M
