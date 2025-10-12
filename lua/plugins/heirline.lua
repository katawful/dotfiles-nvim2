-- [nfnl] fnl/plugins/heirline.fnl
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
  require("heirline").load_colors(config.colors)
  do
    vim.opt_global["showtabline"] = 2
  end
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
    return vim.opt.number:get()
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
  local function _9_(_self, _minwid, _nclicks, _button, _mod)
    local mouse_lnum = vim.fn.getmousepos().line
    return vim.api.nvim_win_set_cursor(0, {mouse_lnum, 0})
  end
  local function _10_()
    return utils["hl-current-line"]({default = config.colors.light_pink, new = config.colors.pink}, nil, {default = {bold = false}, new = {bold = true}})
  end
  raw.lnum = {condition = _6_, provider = _7_, on_click = {callback = _9_, name = "heirline_statuscolumn_number_callback"}, hl = _10_}
  local function _11_()
    return vim.opt.relativenumber:get()
  end
  local function _12_()
    local relnum = tostring(vim.v.relnum)
    local relnum0
    if (#relnum > 1) then
      relnum0 = relnum
    else
      relnum0 = (" " .. relnum)
    end
    return relnum0
  end
  local function _14_(_self, _minwid, _nclicks, _button, _mod)
    local mouse_lnum = vim.fn.getmousepos().line
    return vim.api.nvim_win_set_cursor(0, {mouse_lnum, 0})
  end
  local function _15_()
    return utils["hl-current-line"]({default = config.colors.light_pink, new = config.colors.pink}, nil, {default = {bold = false}, new = {bold = true}})
  end
  raw.relnum = {condition = _11_, provider = _12_, on_click = {callback = _14_, name = "heirline_statuscolumn_number_callback"}, hl = _15_}
  local function _16_(_241)
    do
      local tbl_21_ = {}
      local i_22_ = 0
      for _, mark in ipairs(vim.fn.getmarklist(vim.fn.bufname())) do
        local val_23_ = {name = string.sub(mark.mark, 2, 2), buf = mark.pos[1], lnum = mark.pos[2], col = mark.pos[3]}
        if (nil ~= val_23_) then
          i_22_ = (i_22_ + 1)
          tbl_21_[i_22_] = val_23_
        else
        end
      end
      _241.marks = tbl_21_
    end
    return nil
  end
  local function _18_(self, _minwid, _nclicks, _button, _mod)
    local mouse_lnum = vim.fn.getmousepos().line
    local mark
    local function _19_(_241)
      return (_241.lnum == mouse_lnum)
    end
    mark = n.first(n.filter(_19_, self.marks))
    if (not n["empty?"](mark) and (mouse_lnum == mark.lnum)) then
      return vim.api.nvim_win_set_cursor(0, {mark.lnum, (mark.col - 1)})
    else
      return vim.api.nvim_win_set_cursor(0, {mouse_lnum, 0})
    end
  end
  local function _21_()
    return ((vim.opt.number:get() or vim.opt.relativenumber:get()) or (vim.opt.number:get() and vim.opt.relativenumber:get()))
  end
  local function _22_()
    return utils["hl-current-line"]({default = config.colors.blue, new = config.colors.dark_blue}, nil, {default = {bold = false}, new = {bold = true}})
  end
  local function _23_(_241)
    local mark
    local function _24_(_2410)
      return (_2410.lnum == vim.v.lnum)
    end
    mark = n.first(n.filter(_24_, _241.marks))
    if not n["empty?"](mark) then
      return mark.name
    else
      return " "
    end
  end
  raw.marks = {init = _16_, on_click = {callback = _18_, name = "heirline_statuscolumn_marks_callback"}, condition = _21_, hl = _22_, provider = _23_}
  local function _26_(_241)
    _241.sign = lsp["get-sign"](lsp["get-name"](), vim.v.lnum)
    return nil
  end
  local function _27_()
    local mouse_lnum = vim.fn.getmousepos().line
    vim.api.nvim_win_set_cursor(0, {mouse_lnum, 0})
    return vim.diagnostic.open_float({source = true, border = "solid"})
  end
  local function _28_(_241)
    local _29_ = lsp["get-sign-icon"](_241.sign)
    if (_29_ == "E") then
      return icons.lsp.error
    elseif (_29_ == "H") then
      return icons.lsp.hint
    elseif (_29_ == "I") then
      return icons.lsp.info
    elseif (_29_ == "O") then
      return icons.lsp.other
    elseif (_29_ == "W") then
      return icons.lsp.warn
    else
      local _ = _29_
      return " "
    end
  end
  local function _31_(_241)
    return lsp["get-sign-type"](_241.sign)
  end
  local function _32_()
    return conditions.lsp_attached()
  end
  raw["lsp-signs"] = {init = _26_, on_click = {name = "heirline_statuscolumn_lsp_callback", callback = _27_}, provider = _28_, hl = _31_, condition = _32_}
  components.numbers = {raw.lnum, raw.marks, raw.relnum}
  raw.gitsigns = git.component
  local function _33_()
    return vim.opt.foldenable:get()
  end
  local function _34_()
    return utils["hl-current-line"](nil, {default = config.colors.bright_bg, new = config.colors.normal_bg})
  end
  components.statuscolumn = {raw.fold, {provider = " ", condition = _33_}, components.numbers, raw.gitsigns, raw["lsp-signs"], hl = _34_}
  local function _35_()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end
  return {tabline = components.tabline, statusline = {{components["vi-mode"], condition = conditions.is_active}, components.spell, components.filename, config.providers.even, {components.filedetails, condition = conditions.is_active}, static = vi_mode.static, hl = _35_, fallthrough = true}, statuscolumn = components.statuscolumn}
end
local function _37_(_241, _242)
  return line(_241, _242)
end
return {"rebelot/heirline.nvim", priority = 1, opts = _37_}
