-- [nfnl] fnl/plugins/heirline/buffer.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local conditions = autoload("heirline.conditions")
local heir_utils = autoload("heirline.utils")
local utils = autoload("plugins.heirline.utils")
local config = autoload("plugins.heirline.config")
local file = autoload("plugins.heirline.file")
local M = {}
local delimiter = config.providers.delimiter
local function _2_()
  return config.colors.dark_blue
end
local function _3_()
  return not conditions.buffer_matches({buftype = config["ignored-type"]})
end
local function _4_()
  return config.colors.blue
end
local function _5_()
  return not conditions.buffer_matches({buftype = config["ignored-type"]})
end
local function _6_()
  return not conditions.buffer_matches({buftype = config["ignored-type"]})
end
local function _7_()
  return config.colors.blue
end
local function _8_()
  return conditions.buffer_matches({buftype = {"help"}})
end
local function _9_()
  return config.colors.blue
end
local function _10_()
  return conditions.buffer_matches({buftype = {"terminal"}})
end
M.component = {{{heir_utils.surround(delimiter.left, _2_, file.icon), condition = _3_}, {heir_utils.surround(delimiter.left, _4_, file["full-name"]), condition = _5_, hl = {bg = config.colors.dark_blue}}, {file.flags, condition = _6_, hl = {bg = "blue"}}}, {heir_utils.surround(delimiter.left, _7_, file.help), condition = _8_, hl = {bg = config.colors.pink}}, {heir_utils.surround(delimiter.left, _9_, file.terminal), condition = _10_, hl = {bg = config.colors.pink}}}
return M
