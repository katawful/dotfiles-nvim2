-- [nfnl] Compiled from fnl/plugins/heirline/vi-mode.fnl by https://github.com/Olical/nfnl, do not edit.
local icons = require("globals.icons")
local config = require("plugins.heirline.config")
local conditions = require("heirline.conditions")
local M = {}
local colors = config.colors
local function _1_(_241)
  local mode = ((conditions.is_active and vim.fn.mode()) or "n")
  return (_241.mode_colors_map)[mode]
end
M.static = {mode_colors_map = {n = colors.purple, i = colors.blue, v = colors.red, V = colors.red, ["\22"] = colors.cyan, c = colors.green, s = colors.light_red, S = colors.light_red, ["\19"] = colors.purple, R = colors.orange, r = colors.orange, ["!"] = colors.red, t = colors.red}, mode_color = _1_}
local function _2_(_241)
  _241.mode = vim.fn.mode(1)
  return nil
end
local function _3_(_241)
  return string.format("%s", (_241.mode_names)[_241.mode])
end
local function _4_(_241)
  return {bg = _241:mode_color(), fg = "normal_fg", bold = true}
end
local function _5_()
  return vim.cmd({args = {}, bang = false, cmd = "redrawstatus"})
end
M.component = {init = _2_, static = {mode_names = {n = "N", no = "N?", nov = "N?", noV = "N?", ["no\\22"] = "N?", niI = "Ni", niR = "Nr", niV = "Nv", nt = "Nt", v = "V", vs = "Vs", V = "V_", Vs = "Vs", ["\22"] = "B", ["\22s"] = "B", s = "S", S = "S_", ["\19"] = "^S", i = "I", ic = "Ic", ix = "Ix", R = "R", Rc = "Rc", Rx = "Rx", Rv = "Rv", Rvc = "Rv", Rvx = "Rv", c = "C", cv = "Ex", r = "...", rm = "M", ["r?"] = icons.ui.question, ["!"] = icons.ui.exclamation, t = "T"}}, provider = _3_, hl = _4_, update = {"ModeChanged", pattern = "*:*", callback = vim.schedule_wrap(_5_)}}
return M
