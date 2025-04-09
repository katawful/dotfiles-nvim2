-- [nfnl] Compiled from fnl/plugins/heirline/git.fnl by https://github.com/Olical/nfnl, do not edit.
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
local P = {}
P["hunk-deleted"] = function(hunk)
  local removed = hunk.removed
  local start = removed.start
  local _end = (start + removed.count)
  return {type = "delete", start = start, ["end"] = _end}
end
P["hunk-added"] = function(hunk)
  local added = hunk.added
  local start = added.start
  local _end = (start + added.count)
  return {type = "add", start = start, ["end"] = _end}
end
P["hunk-changed"] = function(hunk)
  local added = hunk.added
  local added_start = added.start
  local added_end = (added_start + added.count)
  local removed = hunk.removed
  local removed_start = removed.start
  local removed_end = (removed_start + removed.count)
  return {type = "change", ["added-start"] = added_start, ["added-end"] = added_end, ["removed-start"] = removed_start, ["removed-end"] = removed_end}
end
M["modify-hunk"] = function(hunk)
  local _2_ = hunk.type
  if (_2_ == "change") then
    return P["hunk-changed"](hunk)
  elseif (_2_ == "add") then
    return P["hunk-added"](hunk)
  elseif (_2_ == "delete") then
    return P["hunk-deleted"](hunk)
  else
    return nil
  end
end
M["inside-hunk?"] = function(lnum, start, _end)
  return ((lnum >= start) and (lnum <= _end))
end
local function _4_(_241)
  do
    local hunks = require("gitsigns").get_hunks()
    local result = false
    local out = nil
    if hunks then
      for _, hunk in ipairs(hunks) do
        if result then break end
        local hunk_mod = M["modify-hunk"](hunk)
        local _5_ = hunk_mod.type
        if (_5_ == "change") then
          if (M["inside-hunk?"](vim.v.lnum, hunk_mod["added-start"], hunk_mod["added-end"]) or M["inside-hunk?"](vim.v.lnum, hunk_mod["removed-start"], hunk_mod["removed-end"])) then
            result = true
            out = hunk_mod
          else
          end
        else
          local _0 = _5_
          if M["inside-hunk?"](vim.v.lnum, hunk_mod.start, hunk_mod["end"]) then
            result = true
            out = hunk_mod
          else
          end
        end
      end
    else
    end
    _241.hunk = out
  end
  return nil
end
local function _10_()
  return vim.b.gitsigns_status
end
local function _11_(_241)
  if _241.hunk then
    return icons.ui["block-left"]
  else
    return config.providers.space
  end
end
local function _13_(_241)
  local _14_
  do
    local t_15_
    do
      local t_16_ = _241
      if (nil ~= t_16_) then
        t_16_ = t_16_.hunk
      else
      end
      t_15_ = t_16_
    end
    if (nil ~= t_15_) then
      t_15_ = t_15_.type
    else
    end
    _14_ = t_15_
  end
  if (_14_ == "add") then
    return utils["hl-current-line"]({default = config.colors.dark_green, new = config.colors.green}, nil, {default = {bold = false}, new = {bold = true}})
  elseif (_14_ == "delete") then
    return utils["hl-current-line"]({default = config.colors.dark_red, new = config.colors.red}, nil, {default = {bold = false}, new = {bold = true}})
  elseif (_14_ == "change") then
    if M["inside-hunk?"](vim.v.lnum, _241.hunk["added-start"], _241.hunk["added-end"]) then
      return utils["hl-current-line"]({default = config.colors.dark_purple, new = config.colors.purple}, nil, {default = {bold = false}, new = {bold = true}})
    elseif M["inside-hunk?"](vim.v.lnum, _241.hunk["removed-start"], _241.hunk["removed-end"]) then
      return utils["hl-current-line"]({default = config.colors.dark_blue, new = config.colors.blue}, nil, {default = {bold = false}, new = {bold = true}})
    else
      return nil
    end
  elseif (_14_ == nil) then
    return utils["hl-current-line"](nil, {default = config.colors.bright_bg, new = config.colors.normal_bg})
  else
    return nil
  end
end
M.component = {init = _4_, condition = _10_, provider = _11_, hl = _13_}
return M
