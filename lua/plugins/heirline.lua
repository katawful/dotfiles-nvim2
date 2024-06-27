-- [nfnl] Compiled from fnl/plugins/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local conditions = autoload("heirline.conditions")
local heir_utils = autoload("heirline.utils")
local utils = autoload("plugins.heirline.utils")
local config = autoload("plugins.heirline.config")
local git = autoload("plugins.heirline.git")
local vi_mode = autoload("plugins.heirline.vi-mode")
local file = autoload("plugins.heirline.file")
local buffer = autoload("plugins.heirline.buffer")
local tabline = autoload("plugins.heirline.tabline")
local fold = autoload("plugins.heirline.fold")
local lsp = autoload("plugins.heirline.lsp")
local function line(_plugin, _opts)
  local components = {}
  local raw = {}
  config.colors = config["gen-colors"]()
  local colors = config.colors
  do end (require("heirline")).load_colors(colors)
  do end (vim.opt_global)["showtabline"] = 2
  do
    local heir = vim.api.nvim_create_augroup("UserHeirline", {clear = true})
    local function _2_()
      heir_utils.on_colorscheme(colors)
      return utils["status-color"](colors)
    end
    vim.api.nvim_create_autocmd("ColorScheme", {callback = _2_, desc = "heirline.nvim -- Reload colors on change", group = heir, pattern = nil})
  end
  utils["status-color"](colors)
  local delimiter = config.providers.delimiter
  raw["vi-mode"] = vi_mode.component
  raw.buffername = buffer.component
  local function _3_(_241)
    return _241:mode_color()
  end
  components["vi-mode"] = {heir_utils.surround(delimiter.both, _3_, {raw["vi-mode"]})}
  components.filename = {raw.buffername, {provider = delimiter.right[2], hl = {fg = "blue"}}}
  local function _4_()
    return "purple"
  end
  local function _5_()
    return vim.wo.spell
  end
  components.spell = {heir_utils.surround(delimiter.both, _4_, file.spell), condition = _5_, hl = {bg = "pink"}}
  components.tabline = tabline.component
  components.filedetails = file.filedetails
  raw.fold = fold.component
  local function _6_()
    return (vim.opt.number):get()
  end
  local function _7_()
    local lnum = tostring(vim.v.lnum)
    local lnum_length = #lnum
    local lnum_size = utils["size-of-lnum"]()
    local lnum0
    if (lnum_size > lnum_length) then
      lnum0 = (" " .. lnum)
    else
      lnum0 = lnum
    end
    return lnum0
  end
  local function _9_()
    return utils["hl-current-line"]({default = colors.light_pink, new = colors.pink}, nil, {default = {bold = false}, new = {bold = true}})
  end
  raw.lnum = {condition = _6_, provider = _7_, hl = _9_}
  local function _10_()
    return (vim.opt.relativenumber):get()
  end
  local function _11_()
    local relnum = tostring(vim.v.relnum)
    local relnum0
    if (#relnum > 1) then
      relnum0 = relnum
    else
      relnum0 = (" " .. relnum)
    end
    return relnum0
  end
  local function _13_()
    return utils["hl-current-line"]({default = colors.light_pink, new = colors.pink}, nil, {default = {bold = false}, new = {bold = true}})
  end
  raw.relnum = {condition = _10_, provider = _11_, hl = _13_}
  local function _14_()
    return (((vim.opt.number):get() or (vim.opt.relativenumber):get()) or ((vim.opt.number):get() and (vim.opt.relativenumber):get()))
  end
  local function _15_()
    return utils["hl-current-line"]({default = colors.blue, new = colors.dark_blue}, nil, {default = {bold = false}, new = {bold = true}})
  end
  local function _16_()
    local marks = vim.fn.getmarklist(vim.fn.bufname())
    local lnum = vim.v.lnum
    local matched_3f = false
    local index = 0
    for i, mark in ipairs(marks) do
      if matched_3f then break end
      if (mark.pos[2] == lnum) then
        index = i
        matched_3f = true
      else
        index = 0
        matched_3f = false
      end
    end
    if matched_3f then
      return string.sub(marks[index].mark, 2, 2)
    else
      return " "
    end
  end
  raw.marks = {condition = _14_, hl = _15_, provider = _16_}
  local function _19_(_241)
    _241.sign = lsp["get-sign"](lsp["get-name"](), vim.v.lnum)
    return nil
  end
  local function _20_(_241)
    local _21_ = lsp["get-sign-icon"](_241.sign)
    if (_21_ == "E") then
      return icons.lsp.error
    elseif (_21_ == "H") then
      return icons.lsp.hint
    elseif (_21_ == "I") then
      return icons.lsp.info
    elseif (_21_ == "O") then
      return icons.lsp.other
    elseif (_21_ == "W") then
      return icons.lsp.warn
    elseif true then
      local _ = _21_
      return " "
    else
      return nil
    end
  end
  local function _23_(_241)
    return lsp["get-sign-type"](_241.sign)
  end
  local function _24_()
    return conditions.lsp_attached()
  end
  raw["lsp-signs"] = {init = _19_, provider = _20_, hl = _23_, condition = _24_}
  components.numbers = {raw.lnum, raw.marks, raw.relnum}
  raw.gitsigns = git.component
  local function _25_()
    return (vim.opt.foldenable):get()
  end
  local function _20_()
    return utils["hl-current-line"](nil, {default = colors.bright_bg, new = colors.normal_bg})
  end
  components.statuscolumn = {raw.fold, {provider = " ", condition = _19_}, components.numbers, raw.gitsigns, hl = _20_}
  local function _21_()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end
  return {tabline = components.tabline, statusline = {{components["vi-mode"], condition = conditions.is_active}, components.spell, components.filename, config.providers.even, {components.filedetails, condition = conditions.is_active}, static = vi_mode.static, hl = _21_, fallthrough = true}, statuscolumn = components.statuscolumn}
end
local function _23_(_241, _242)
  return line(_241, _242)
end
return {"rebelot/heirline.nvim", dependencies = {{dir = "~/Repos/NEOVIM/katdotnvim/"}, {"nvim-tree/nvim-web-devicons"}}, priority = 1, opts = _23_}
