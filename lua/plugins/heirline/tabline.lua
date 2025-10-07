-- [nfnl] fnl/plugins/heirline/tabline.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local conditions = autoload("heirline.conditions")
local heir_utils = autoload("heirline.utils")
local utils = autoload("plugins.heirline.utils")
local config = autoload("plugins.heirline.config")
local git = autoload("plugins.heirline.git")
local vi_mode = autoload("plugins.heirline.vi-mode")
local raw_file = autoload("plugins.heirline.file")
local delimiter = config.providers.delimiter
local M = {}
local function _2_(_241)
  _241.filename = vim.api.nvim_buf_get_name(_241.bufnr)
  return nil
end
local function _3_(_241)
  if _241.is_active then
    return "TabLineSel"
  else
    return "TabLine"
  end
end
local function _5_(_, minwid, _0, button)
  if (button == "m") then
    local function _6_()
      return vim.api.nvim_buf_delete(minwid, {force = false})
    end
    return vim.schedule(_6_)
  else
    return utils["get-win-for-buf"](minwid)
  end
end
local function _8_(_241)
  return _241.bufnr
end
M["tabline-name"] = {raw_file.bufnr, raw_file.icon, raw_file["short-name"], raw_file["bufnr-flags"], init = _2_, hl = _3_, on_click = {callback = _5_, minwid = _8_, name = "heirline_tabline_buffer_callback"}}
local function _9_(_, minwid)
  local function _10_()
    vim.api.nvim_buf_delete(minwid, {force = false})
    return vim.cmd({args = {}, bang = false, cmd = "redrawtabline"})
  end
  return vim.schedule(_10_)
end
local function _11_(_241)
  return _241.bufnr
end
local function _12_(_241)
  return not vim.api.nvim_buf_get_option(_241.bufnr, "modified")
end
M["tabline-close-button"] = {{provider = " "}, {provider = icons.ui.close, on_click = {callback = _9_, minwid = _11_, name = "heirline_tabline_close_buffer_callback"}}, condition = _12_}
local function _13_(_241)
  if _241.is_active then
    return heir_utils.get_highlight("TabLineSel").bg
  else
    return heir_utils.get_highlight("TabLine").bg
  end
end
local function _15_(_241)
  return _241.is_visible
end
M["tabline-block"] = {heir_utils.surround(delimiter.both, _13_, {M["tabline-name"], M["tabline-close-button"]}), condition = _15_, hl = {bg = "pink"}}
M["tabline-line"] = heir_utils.make_buflist(M["tabline-block"], {provider = "<", hl = {fg = "gray"}}, {provider = ">", hl = {fg = "gray"}})
local function _16_(_241)
  return ("%" .. _241.tabnr .. "T" .. _241.tabpage .. "%T")
end
local function _17_(_241)
  if _241.is_active then
    return "TabLineSel"
  else
    return "TabLine"
  end
end
M["tabline-page"] = {provider = _16_, hl = _17_}
M["tabline-page-close"] = {provider = "%999X\239\128\141%X", hl = "TabLine"}
local function _19_(_241)
  if _241.is_active then
    return "blue"
  else
    return "purple"
  end
end
local function _21_()
  return utils["show-element?"](2)
end
local function _22_()
  return "purple"
end
local function _23_()
  return utils["show-element?"](2)
end
local function _24_()
  return utils["show-element?"](0)
end
M["tabline-pages"] = {{provider = "%="}, heir_utils.make_tablist({heir_utils.surround(delimiter.both, _19_, M["tabline-page"]), hl = {bg = "pink"}, condition = _21_}), {heir_utils.surround(delimiter.both, _22_, M["tabline-page-close"]), condition = _23_, hl = {bg = "pink"}}, condition = _24_}
M.component = {M["tabline-line"], M["tabline-pages"]}
return M
