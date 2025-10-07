-- [nfnl] fnl/plugins/heirline/utils.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local heir_utils = autoload("heirline.utils")
local M = {}
M.separate = function(amount, char)
  local str = ""
  for _ = 1, amount do
    str = string.format("%s%s", str, char)
  end
  return str
end
M["status-color"] = function(colors)
  do
    local statusline_hl = vim.api.nvim_get_hl(0, {name = "StatusLine"})
    statusline_hl["fg"] = colors.pink
    statusline_hl["bg"] = colors.pink
    vim.api.nvim_set_hl(0, "StatusLine", statusline_hl)
  end
  local statusline_hl = vim.api.nvim_get_hl(0, {name = "StatusLineNC"})
  statusline_hl["fg"] = colors.gray
  statusline_hl["bg"] = colors.gray
  return vim.api.nvim_set_hl(0, "StatusLineNC", statusline_hl)
end
M["get-win-for-buf"] = function(buf)
  local wins = vim.api.nvim_list_wins()
  local tabpage = vim.api.nvim_get_current_tabpage()
  for _, win in ipairs(wins) do
    if ((vim.api.nvim_win_get_tabpage(win) == tabpage) and (vim.api.nvim_win_get_buf(win) == buf)) then
      vim.api.nvim_set_current_win(win)
    else
    end
  end
  return nil
end
M["show-element?"] = function(number)
  return (#vim.api.nvim_list_tabpages() >= number)
end
M["hl-current-line"] = function(fg, _3fbg, _3fattr)
  if (vim.api.nvim_win_get_cursor(0)[1] == vim.v.lnum) then
    local output
    local _4_
    do
      local t_3_ = fg
      if (nil ~= t_3_) then
        t_3_ = t_3_.new
      else
      end
      _4_ = t_3_
    end
    local _7_
    do
      local t_6_ = _3fbg
      if (nil ~= t_6_) then
        t_6_ = t_6_.new
      else
      end
      _7_ = t_6_
    end
    output = {fg = _4_, bg = _7_}
    if _3fattr then
      local function _10_()
        local t_9_ = _3fattr
        if (nil ~= t_9_) then
          t_9_ = t_9_.new
        else
        end
        return t_9_
      end
      for k, v in pairs(_10_()) do
        output[k] = v
      end
    else
    end
    return output
  else
    local output
    local _14_
    do
      local t_13_ = fg
      if (nil ~= t_13_) then
        t_13_ = t_13_.default
      else
      end
      _14_ = t_13_
    end
    local _17_
    do
      local t_16_ = _3fbg
      if (nil ~= t_16_) then
        t_16_ = t_16_.default
      else
      end
      _17_ = t_16_
    end
    output = {fg = _14_, bg = _17_}
    if _3fattr then
      local function _20_()
        local t_19_ = _3fattr
        if (nil ~= t_19_) then
          t_19_ = t_19_.default
        else
        end
        return t_19_
      end
      for k, v in pairs(_20_()) do
        output[k] = v
      end
    else
    end
    return output
  end
end
M["get-window-bounds"] = function()
  local start = vim.fn.line("w0")
  local _end = vim.fn.line("w$")
  return {start = start, ["end"] = _end}
end
M["size-of-lnum"] = function()
  local _end = M["get-window-bounds"]()["end"]
  return #tostring(_end)
end
return M
