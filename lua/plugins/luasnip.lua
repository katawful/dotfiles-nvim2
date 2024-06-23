-- [nfnl] Compiled from fnl/plugins/luasnip.fnl by https://github.com/Olical/nfnl, do not edit.
local template = {sources = {ultisnips = {"./vim-snippets/UltiSnips", (vim.fn.stdpath("config") .. "/UltiSnips")}, snipmate = {"vim-snippets/snippets"}}, output = {vscode_luasnip = {(vim.fn.stdpath("config") .. "/luasnip_snippets")}}}
local function _1_()
  return (require("snippet_converter")).setup({templates = {template}})
end
local function _2_()
  return vim.fn.system("make install_jsregexp")
end
local function _3_()
  do end (require("luasnip.loaders.from_vscode")).lazy_load()
  do end (require("luasnip.loaders.from_lua")).lazy_load({paths = {(vim.fn.stdpath("config") .. "/lua/snippets")}})
  do end (require("luasnip.loaders.from_snipmate")).lazy_load({paths = {(vim.fn.stdpath("data") .. "/lazy/vim-snippets/snippets")}})
  return (require("luasnip")).setup({enable_autosnippets = true})
end
local function _4_()
  return (require("luasnip")).expand()
end
local function _5_()
  if ((require("luasnip")).choice_active(-1) and (require("luasnip")).in_snippet()) then
    return (require("luasnip")).change_choice(1)
  else
    return nil
  end
end
local function _7_()
  if ((require("luasnip")).choice_active(-1) and (require("luasnip")).in_snippet()) then
    return (require("luasnip")).change_choice(-1)
  else
    return nil
  end
end
local function _9_()
  return (require("luasnip.loaders")).edit_snippet_files()
end
return {"L3MON4D3/LuaSnip", lazy = true, dependencies = {{"smjonas/snippet-converter.nvim", config = _1_}, "rafamadriz/friendly-snippets", "honza/vim-snippets"}, build = _2_, config = _3_, version = "v2.2.0", keys = {{"<C-s>", _4_, mode = {"i", "s"}, desc = "LuaSnip - Expand snippet"}, {"<C-f>", _5_, nowait = true, mode = {"i", "s"}, desc = "LuaSnip - Forward choice in snippet"}, {"<C-g>", _7_, nowait = true, mode = {"i", "s"}, desc = "LuaSnip - Previous choice in snippet"}, {"<leader>se", _9_, mode = {"n"}, desc = "LuaSnip - Edit snippets"}}}
