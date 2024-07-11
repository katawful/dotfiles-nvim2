-- [nfnl] Compiled from fnl/plugins/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local conditions = autoload("heirline.conditions")
local heir_utils = autoload("heirline.utils")
local utils = autoload("plugins.heirline.utils")
local config = autoload("plugins.heirline.config")
local n = autoload("nfnl.core")
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
  do end (require("heirline")).load_colors(config.colors)
  do end (vim.opt_global)["showtabline"] = 2
  do
    local heir = vim.api.nvim_create_augroup("UserHeirline", {clear = true})
    local function _2_()
      return line()
    end
    vim.api.nvim_create_autocmd("ColorScheme", {callback = _2_, desc = "heirline.nvim -- Reload colors on change", group = heir, pattern = nil})
  end
  utils["status-color"](config.colors)
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
    return utils["hl-current-line"]({default = config.colors.light_pink, new = config.colors.pink}, nil, {default = {bold = false}, new = {bold = true}})
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
    return utils["hl-current-line"]({default = config.colors.light_pink, new = config.colors.pink}, nil, {default = {bold = false}, new = {bold = true}})
  end
  raw.relnum = {condition = _10_, provider = _11_, hl = _13_}
  local function _14_(_241)
    do
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _, mark in ipairs(vim.fn.getmarklist(vim.fn.bufname())) do
        local val_19_auto = {name = string.sub(mark.mark, 2, 2), buf = mark.pos[1], lnum = mark.pos[2], col = mark.pos[3]}
        if (nil ~= val_19_auto) then
          i_18_auto = (i_18_auto + 1)
          do end (tbl_17_auto)[i_18_auto] = val_19_auto
        else
        end
      end
      _241.marks = tbl_17_auto
    end
    return nil
  end
  local function _16_(self, _minwid, _nclicks, _button, _mod)
    local mouse_lnum = vim.fn.getmousepos().line
    local mark
    local function _17_(_241)
      return (_241.lnum == mouse_lnum)
    end
    mark = n.first(n.filter(_17_, self.marks))
    local function _18_()
      return not n["empty?"](mark)
    end
    if (_18_() and (mouse_lnum == mark.lnum)) then
      return vim.api.nvim_win_set_cursor(0, {mark.lnum, (mark.col - 1)})
    else
      return vim.api.nvim_win_set_cursor(0, {mouse_lnum, 0})
    end
  end
  local function _20_()
    return (((vim.opt.number):get() or (vim.opt.relativenumber):get()) or ((vim.opt.number):get() and (vim.opt.relativenumber):get()))
  end
  local function _21_()
    return utils["hl-current-line"]({default = config.colors.blue, new = config.colors.dark_blue}, nil, {default = {bold = false}, new = {bold = true}})
  end
  local function _22_(_241)
    local mark
    local function _23_(_2410)
      return (_2410.lnum == vim.v.lnum)
    end
    mark = n.first(n.filter(_23_, _241.marks))
    if not n["empty?"](mark) then
      return mark.name
    else
      return " "
    end
  end
  raw.marks = {init = _14_, on_click = {callback = _16_, name = "heirline_statuscolumn_marks_callback"}, condition = _20_, hl = _21_, provider = _22_}
  local function _25_(_241)
    _241.sign = lsp["get-sign"](lsp["get-name"](), vim.v.lnum)
    return nil
  end
  local function _26_(_241)
    local _27_ = lsp["get-sign-icon"](_241.sign)
    if (_27_ == "E") then
      return icons.lsp.error
    elseif (_27_ == "H") then
      return icons.lsp.hint
    elseif (_27_ == "I") then
      return icons.lsp.info
    elseif (_27_ == "O") then
      return icons.lsp.other
    elseif (_27_ == "W") then
      return icons.lsp.warn
    elseif true then
      local _ = _27_
      return " "
    else
      return nil
    end
  end
  local function _29_(_241)
    return lsp["get-sign-type"](_241.sign)
  end
  local function _30_()
    return conditions.lsp_attached()
  end
  raw["lsp-signs"] = {init = _25_, provider = _26_, hl = _29_, condition = _30_}
  components.numbers = {raw.lnum, raw.marks, raw.relnum}
  raw.gitsigns = git.component
  local function _31_()
    return (vim.opt.foldenable):get()
  end
  local function _32_()
    return utils["hl-current-line"](nil, {default = config.colors.bright_bg, new = config.colors.normal_bg})
  end
  components.statuscolumn = {raw.fold, {provider = " ", condition = _31_}, components.numbers, raw.gitsigns, raw["lsp-signs"], hl = _32_}
  local function _33_()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end
  return {tabline = components.tabline, statusline = {{components["vi-mode"], condition = conditions.is_active}, components.spell, components.filename, config.providers.even, {components.filedetails, condition = conditions.is_active}, static = vi_mode.static, hl = _33_, fallthrough = true}, statuscolumn = components.statuscolumn}
end
local function _35_(_241, _242)
  return line(_241, _242)
end
return {"rebelot/heirline.nvim", dependencies = {{dir = "~/Repos/NEOVIM/katdotnvim/"}, {"nvim-tree/nvim-web-devicons"}}, priority = 1, opts = _35_}
