-- [nfnl] fnl/plugins/heirline/file.fnl
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
local function _2_(_241)
  _241.filename = vim.api.nvim_buf_get_name(0)
  return nil
end
M.block = {init = _2_}
local function _3_(_241)
  local filename = vim.fn.expand("%:p")
  local extension = vim.fn.fnamemodify(filename, ":e")
  _241.icon, _241.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, {default = true})
  return nil
end
local function _4_(_241)
  return (_241.icon and (_241.icon .. " "))
end
local function _5_(_241)
  return {fg = _241.icon_color}
end
M.icon = {init = _3_, provider = _4_, hl = _5_}
local function _6_(_241)
  _241.filename = vim.api.nvim_buf_get_name(0)
  return nil
end
local function _7_()
  return ((vim.bo.filetype ~= "help") or (vim.bo.filetype ~= ""))
end
local function _8_(_241)
  local filename = vim.fn.fnamemodify(_241.filename, ":.")
  if (filename == "") then
    return icons.ui.file
  elseif not conditions.width_percent_below(#filename, 0.35) then
    return vim.fn.pathshorten(filename)
  else
    return filename
  end
end
M["full-name"] = {init = _6_, condition = _7_, provider = _8_, hl = {fg = "normal_fg"}}
local function _10_(_241)
  return (tostring(_241.bufnr) .. ". ")
end
M.bufnr = {provider = _10_, hl = {fg = "normal_fg"}}
local function _11_(_241)
  if (_241.filename == "") then
    return icons.ui.file
  else
    return vim.fn.fnamemodify(_241.filename, ":t")
  end
end
local function _13_(_241)
  return {bold = (_241.is_active or _241.is_visible), italic = true}
end
M["short-name"] = {provider = _11_, hl = _13_}
local function _14_()
  return vim.bo.modified
end
local function _15_()
  return (not vim.bo.modifiable or vim.bo.readonly)
end
M.flags = {{condition = _14_, provider = " \243\176\134\147", hl = {fg = "red"}}, {condition = _15_, provider = " \239\128\163", hl = {fg = "orange"}}}
local function _16_(_241)
  return vim.api.nvim_buf_get_option(_241.bufnr, "modified")
end
local function _17_(_241)
  return (not vim.api.nvim_buf_get_option(_241.bufnr, "modifiable") or vim.api.nvim_buf_get_option(_241.bufnr, "readonly"))
end
local function _18_(_241)
  if (vim.api.nvim_buf_get_option(_241.bufnr, "buftype") == "terminal") then
    return (" " .. icons.ui.terminal .. " ")
  else
    return (" " .. icons.ui.lock .. " ")
  end
end
M["bufnr-flags"] = {{condition = _16_, provider = (" " .. icons.ui.save), hl = {fg = "red"}}, {condition = _17_, provider = _18_, hl = {fg = "orange"}}}
local function _20_()
  if (vim.bo.filetype == "") then
    return string.upper(vim.bo.buftype)
  else
    return string.upper(vim.bo.filetype)
  end
end
M.ftype = {provider = _20_, hl = {fg = "normal_fg", bold = true}}
local function _22_()
  return vim.bo.fenc
end
M.encoding = {provider = _22_, hl = {fg = "normal_fg"}}
local function _23_()
  if (vim.bo.fileformat == "unix") then
    return icons.ui.linux
  else
    return icons.ui.windows
  end
end
M.format = {provider = _23_, hl = {fg = "normal_fg"}}
local function _25_()
  local suffix = {"b", "k", "M", "G", "T", "P", "E"}
  local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
  local fsize0
  if (0 > fsize) then
    fsize0 = 0
  else
    fsize0 = fsize
  end
  if (1024 > fsize0) then
    return (fsize0 .. suffix[1])
  else
    local i = math.floor((math.log(fsize0) / math.log(1024)))
    return string.format("%.2g%s", (fsize0 / math.pow(1024, i)), suffix[(i + 1)])
  end
end
M.size = {provider = _25_, hl = {fg = "orange"}}
M.position = {provider = "%5(%l/%3L%):%2c", hl = {fg = "normal_fg"}}
local function _28_()
  return string.format("%s %s", icons.ui.question, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"))
end
M.help = {provider = _28_, hl = {fg = "normal_fg", bg = "blue"}}
local function _29_()
  return string.format("%s %s", icons.ui.terminal, vim.api.nvim_buf_get_name(0):gsub(".*:", ""))
end
M.terminal = {provider = _29_, hl = {fg = "normal_fg", bg = "blue"}}
local function _30_()
  return vim.wo.spell
end
M.spell = {condition = _30_, provider = icons.ui.spell, hl = {bold = true, fg = "green"}}
local function _31_()
  return "blue"
end
M.filedetails = {heir_utils.surround(delimiter.left, _31_, M.ftype), {{provider = delimiter.both[2]}, hl = {fg = "blue", bg = "dark_blue"}}, {provider = " ", hl = {bg = "dark_blue"}}, {M.size, hl = {bg = "dark_blue"}}, {provider = " ", hl = {bg = "dark_blue"}}, {M.position, hl = {bg = "dark_blue"}}, {provider = " ", hl = {bg = "dark_blue"}}, {M.format, hl = {bg = "dark_blue"}}, {provider = " ", hl = {bg = "dark_blue"}}, {M.encoding, hl = {bg = "dark_blue"}}, {{provider = delimiter.both[2]}, hl = {bg = "pink", fg = "dark_blue"}}}
return M
