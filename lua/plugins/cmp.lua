-- [nfnl] Compiled from fnl/plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local function _2_(_2410, _2420)
    _2420.abbr = string.sub(_2420.abbr, 1, 20)
    return _2420
  end
  local function _3_(_2410)
    return (require("luasnip")).lsp_expand(_2410.body)
  end
  local function _4_(_2410)
    if luasnip.jumpable(1) then
      return luasnip.jump(1)
    else
      return _2410()
    end
  end
  local function _6_(_2410)
    if luasnip.jumpable(-1) then
      return luasnip.jump(-1)
    else
      return _2410()
    end
  end
  local function _8_(_2410)
    if cmp.visible() then
      return cmp.select_next_item()
    else
      return _2410()
    end
  end
  local function _10_(_2410)
    if cmp.visible() then
      return cmp.select_prev_item()
    else
      return _2410()
    end
  end
  local function _12_()
    if cmp.visible() then
      return cmp.abort()
    else
      return nil
    end
  end
  return {formatting = {format = _2_}, window = {documentation = {max_width = 40, max_height = 30, border = "rounded"}, completion = {border = "none", max_width = 40, max_height = 30}}, snippet = {expand = _3_}, sources = cmp.config.sources({{name = "luasnip"}, {name = "nvim_lsp", max_item_count = 15}, {name = "latex_symbols", option = {strategy = 1}}}), mapping = {["<C-e>"] = cmp.mapping(_4_, {"i", "s"}), ["<C-y>"] = cmp.mapping(_6_, {"i", "s"}), ["<C-n>"] = cmp.mapping(_8_, {"i", "s"}), ["<C-p>"] = cmp.mapping(_10_, {"i", "s"}), ["<C-c>"] = cmp.mapping(_12_, {"i", "s"})}}
end
return {"hrsh7th/nvim-cmp", lazy = true, dependencies = {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp", "kdheepak/cmp-latex-symbols"}, opts = _1_}
