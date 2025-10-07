-- [nfnl] fnl/plugins/alpha/utils.fnl
local icons = require("globals.icons")
local devicons = require("nvim-web-devicons")
local plenary_path = require("plenary.path")
local M = {}
local leader = "<L>"
local function _1_(path, ext)
  return (string.find(path, "COMMIT_EDITMSG") or vim.tbl_contains({"gitcommit"}, ext))
end
M["mru-opts"] = {devicons = true, width = 60, position = "center", ["devicons-hl"] = true, ignore = _1_, autocd = false}
M["commit-opts"] = {width = 50, position = "center"}
M["button-opts"] = {align_keymap = "left", cursor = 0, position = "center", width = 60}
M.surround = function(str)
  return (" " .. str .. " ")
end
M["get-date"] = function()
  return os.date((M.surround(icons.ui.calendar) .. "%m/%d/%Y"))
end
M["get-cwd"] = function()
  return vim.fn.getcwd()
end
M["repo?"] = function(dir)
  local path = (vim.loop.cwd() .. "/.git")
  local ok_3f = vim.loop.fs_stat(path)
  if ok_3f then
    return true
  else
    return false
  end
end
local function nil_3f(...)
  local out = nil
  local nargs = select("#", ...)
  for i = 1, nargs do
    local v = select(i, ...)
    if (v ~= nil) then
      out = v
    else
    end
  end
  return out
end
local function get_extension(file)
  return vim.fn.fnamemodify(file, ":e")
end
local function get_filetype_color(ext)
  local theme
  if (vim.o.background == "light") then
    theme = require("nvim-web-devicons.icons-light")
  else
    theme = require("nvim-web-devicons.icons-default")
  end
  local icon
  do
    local t_5_
    do
      local t_6_ = theme
      if (nil ~= t_6_) then
        t_6_ = t_6_.icons_by_file_extension
      else
      end
      t_5_ = t_6_
    end
    if (nil ~= t_5_) then
      t_5_ = t_5_[ext]
    else
    end
    icon = t_5_
  end
  if icon then
    local _10_
    do
      local t_9_ = icon
      if (nil ~= t_9_) then
        t_9_ = t_9_.name
      else
      end
      _10_ = t_9_
    end
    return ("DevIcon" .. _10_)
  else
    return "DevIconDefault"
  end
end
local function get_icon(file)
  local nwd = require("nvim-web-devicons")
  local ext = get_extension(file)
  return nwd.get_icon(file, ext, {default = true})
end
local function button(keymap, val, rhs, rhs_opts, _3fopts)
  local keymap_trimmed = keymap:gsub("%s", ""):gsub(leader, "<leader>")
  local opts
  do
    local tbl_16_ = {}
    for k, v in pairs(M["button-opts"]) do
      local k_17_, v_18_ = nil, nil
      local _14_
      do
        local t_13_ = _3fopts
        if (nil ~= t_13_) then
          t_13_ = t_13_[k]
        else
        end
        _14_ = t_13_
      end
      if not _14_ then
        k_17_, v_18_ = k, v
      else
        local function _17_()
          local t_16_ = _3fopts
          if (nil ~= t_16_) then
            t_16_ = t_16_[k]
          else
          end
          return t_16_
        end
        k_17_, v_18_ = k, _17_()
      end
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts = tbl_16_
  end
  opts.shortcut = keymap
  local _22_
  do
    local t_21_ = opts.hl_shortcut
    _22_ = t_21_
  end
  if not _22_ then
    opts.hl_shortcut = {{"Constant", 0, #keymap}}
  else
  end
  if rhs then
    rhs_opts = nil_3f(rhs_opts, {noremap = true, nowait = true, silent = true})
    opts.keymap = {"n", keymap_trimmed, rhs, rhs_opts}
  else
  end
  local function on_press()
    local key = vim.api.nvim_replace_termcodes((rhs or (keymap_trimmed .. "<Ignore>")), true, false, true)
    return vim.api.nvim_feedkeys(key, "t", false)
  end
  return {on_press = on_press, opts = opts, type = "button", val = val}
end
local function file_button(file, keymap, pre_short_file, autocd)
  local short_file
  if pre_short_file then
    short_file = pre_short_file
  else
    short_file = file
  end
  local extension = get_extension(file)
  local filetype_hl = get_filetype_color(extension)
  local button_hl = {}
  local margin_length = #keymap
  local margin
  do
    local space = ""
    for n = 1, margin_length do
      space = (space .. " ")
    end
    margin = space
  end
  local icon_text
  if M["mru-opts"].devicons then
    local icon, hl = get_icon(file)
    local hl_option_type = type(M["mru-opts"]["devicons-hl"])
    if ((hl_option_type == "boolean") and hl and M["mru-opts"]["devicons-hl"]) then
      table.insert(button_hl, {hl, (margin_length * 2), ((margin_length * 2) + #icon + 1)})
    else
    end
    if (hl_option_type == "string") then
      table.insert(button_hl, {M["mru-opts"]["devicons-hl"], 0, #icon})
    else
    end
    icon_text = (margin .. icon .. " ")
  else
    icon_text = margin
  end
  local cd_cmd = ((autocd and " | cd %:p:h") or "")
  local button_element = button(keymap, (icon_text .. short_file), ("<cmd>e " .. vim.fn.fnameescape(file) .. cd_cmd .. " <CR>"))
  local pre_file_start = short_file:match(".*[/\\]")
  if pre_file_start then
    local file_start
    if (pre_file_start ~= nil) then
      file_start = #pre_file_start
    else
      file_start = (#margin + (#icon_text - 2) + #short_file)
    end
    local file_header_start = (3 + (#icon_text - 2))
    local file_header_end
    if (#margin == 3) then
      file_header_end = (file_start + #icon_text + 2)
    else
      file_header_end = (file_start + #icon_text + 1)
    end
    local file_name_start = file_header_end
    local file_name_end = (3 + (#icon_text - 2) + #short_file + 1)
    table.insert(button_hl, {"Directory", file_header_start, file_header_end})
    table.insert(button_hl, {filetype_hl, file_name_start, file_name_end})
  else
    local file_start = (#margin + #icon_text)
    local file_end = (file_start + #short_file)
    table.insert(button_hl, {filetype_hl, file_start, file_end})
  end
  button_element.opts.hl = button_hl
  return button_element
end
local function commit_button(hash, keymap, commit_text, command, pos)
  local button_hl = {}
  local button_element = button(keymap, commit_text, command)
  table.insert(button_hl, {"Tag", pos["hash-start"], pos["hash-end"]})
  table.insert(button_hl, {"MoreMsg", pos["commit-text-start"], pos["commit-text-end"]})
  button_element.opts.hl = button_hl
  return button_element
end
M.mru = function(dir, start, _3famount, _3fopts)
  _G.assert((nil ~= start), "Missing argument start on /home/kat/.config/nvim/fnl/plugins/alpha/utils.fnl:160")
  _G.assert((nil ~= dir), "Missing argument dir on /home/kat/.config/nvim/fnl/plugins/alpha/utils.fnl:160")
  local opts
  if _3fopts then
    local tbl_16_ = {}
    for k, v in pairs(M["mru-opts"]) do
      local k_17_, v_18_ = nil, nil
      local _33_
      do
        local t_32_ = _3fopts
        if (nil ~= t_32_) then
          t_32_ = t_32_[k]
        else
        end
        _33_ = t_32_
      end
      if not _33_ then
        k_17_, v_18_ = k, v
      else
        local function _36_()
          local t_35_ = _3fopts
          if (nil ~= t_35_) then
            t_35_ = t_35_[k]
          else
          end
          return t_35_
        end
        k_17_, v_18_ = k, _36_()
      end
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts = tbl_16_
  else
    opts = M["mru-opts"]
  end
  local amount
  if _3famount then
    amount = _3famount
  else
    amount = 10
  end
  local width
  local _43_
  do
    local t_42_ = opts
    if (nil ~= t_42_) then
      t_42_ = t_42_.width
    else
    end
    _43_ = t_42_
  end
  if _43_ then
    width = opts.width
  else
    width = 48
  end
  local val = {}
  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if (#oldfiles == amount) then break end
    local dir_cond
    if not dir then
      dir_cond = true
    else
      dir_cond = vim.startswith(v, dir)
    end
    local ignore = ((opts.ignore and opts.ignore(v, get_extension(v))) or false)
    local _47_
    do
      local result_9_auto = vim.fn.filereadable(v)
      if (result_9_auto == 0) then
        _47_ = false
      else
        _47_ = true
      end
    end
    if ((_47_ and dir_cond) and not ignore) then
      table.insert(oldfiles, v)
    else
    end
  end
  for i = 1, amount do
    local _52_
    do
      local t_51_ = oldfiles
      if (nil ~= t_51_) then
        t_51_ = t_51_[i]
      else
      end
      _52_ = t_51_
    end
    if not _52_ then break end
    local keymap = tostring((start + (i - 1)))
    local file_path
    if dir then
      file_path = vim.fn.fnamemodify(oldfiles[i], ":.")
    else
      file_path = vim.fn.fnamemodify(oldfiles[i], ":~")
    end
    local short_file_path
    do
      local target = file_path
      if (#target > width) then
        target = plenary_path.new(target):shorten(3, {-2, -1})
        if (#target > width) then
          target = plenary_path.new(target):shorten(2, {-1})
        else
        end
      else
      end
      short_file_path = target
    end
    local button_element = file_button(oldfiles[i], keymap, short_file_path, opts.autocd)
    val[i] = button_element
  end
  return {opts = opts, type = "group", val = val}
end
M["show-commits"] = function(start, _3famount, _3fopts)
  _G.assert((nil ~= start), "Missing argument start on /home/kat/.config/nvim/fnl/plugins/alpha/utils.fnl:205")
  local opts
  if _3fopts then
    local tbl_16_ = {}
    for k, v in pairs(M["commit-opts"]) do
      local k_17_, v_18_ = nil, nil
      local _58_
      do
        local t_57_ = _3fopts
        if (nil ~= t_57_) then
          t_57_ = t_57_[k]
        else
        end
        _58_ = t_57_
      end
      if not _58_ then
        k_17_, v_18_ = k, v
      else
        k_17_, v_18_ = k, _3fopts[k]
      end
      if ((k_17_ ~= nil) and (v_18_ ~= nil)) then
        tbl_16_[k_17_] = v_18_
      else
      end
    end
    opts = tbl_16_
  else
    opts = M["commit-opts"]
  end
  local width
  local _64_
  do
    local t_63_ = opts
    if (nil ~= t_63_) then
      t_63_ = t_63_.width
    else
    end
    _64_ = t_63_
  end
  if _64_ then
    width = opts.width
  else
    width = 48
  end
  local amount
  if _3famount then
    amount = _3famount
  else
    amount = 10
  end
  local _69_
  do
    local t_68_ = opts
    if (nil ~= t_68_) then
      t_68_ = t_68_.hl
    else
    end
    _69_ = t_68_
  end
  if not _69_ then
    opts["hl"] = {}
  else
  end
  local commits = vim.fn.systemlist(("git log --oneline | head -n" .. amount))
  local val = {}
  local commit_regex = vim.regex("^\\w\\{7}")
  for i = 1, amount do
    local commit = commits[i]
    if commit then
      local keymap = tostring((start + (i - 1)))
      local margin_length = (3 - #keymap)
      local margin
      do
        local space = ""
        for n = 1, margin_length do
          space = (space .. " ")
        end
        margin = space
      end
      local raw_hash_start, raw_hash_end = commit_regex:match_str(commit)
      local raw_hash_start0 = (raw_hash_start or 0)
      local raw_hash_end0 = (raw_hash_end or 0)
      local hash_start = (raw_hash_start0 + #keymap + margin_length)
      local hash_end = (hash_start + raw_hash_end0 + #keymap + margin_length)
      local hash = commit:sub(raw_hash_start0, (raw_hash_end0 - 1))
      local commit_text_start = (hash_end - #keymap - margin_length)
      local raw_commit_text = commit:sub(raw_hash_end0, -1)
      local commit_text
      do
        local target = raw_commit_text
        if (#target > width) then
          target = string.sub(target, 0, (width - 2))
          target = string.format("%s\226\128\166", target)
        else
        end
        commit_text = string.format("%s%s%s", margin, hash, target)
      end
      local commit_text_end = (#commit_text + commit_text_start)
      local command = string.format("<cmd>Git show %s<CR>", hash)
      local hl = {{"Function", hash_start, hash_end}}
      local pos = {["hash-start"] = hash_start, ["hash-end"] = hash_end, ["commit-text-start"] = commit_text_start, ["commit-text-end"] = commit_text_end}
      local button_element = commit_button(hash, keymap, commit_text, command, pos)
      table.insert(opts.hl, hl)
      val[i] = button_element
    else
    end
  end
  return {opts = opts, type = "group", val = val}
end
return M
