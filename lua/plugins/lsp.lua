-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local sys = autoload("globals.init")
local M = nil
local function on_attach(client, bufnr)
  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.opt_local.signcolumn = "yes"
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  do
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = true, desc = "LSP -- goto declaration", noremap = true, silent = true})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = true, desc = "LSP -- goto definition", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {buffer = true, desc = "LSP -- hover", noremap = true, silent = true})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = true, desc = "LSP -- goto implementation", noremap = true, silent = true})
    vim.keymap.set("n", "g?", vim.lsp.buf.signature_help, {buffer = true, desc = "LSP -- signature", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, {buffer = true, desc = "LSP -- add workspace folder", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, {buffer = true, desc = "LSP -- remove workspace folder", noremap = true, silent = true})
    local function _2_()
      return vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end
    vim.keymap.set("n", "<leader>lwl", _2_, {buffer = true, desc = "LSP -- list workspace folders", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, {buffer = true, desc = "LSP -- type definition", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {buffer = true, desc = "LSP -- code action", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lgr", vim.lsp.buf.references, {buffer = true, desc = "LSP -- goto reference", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, {buffer = true, desc = "LSP -- open diagnostic", noremap = true, silent = true})
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer = true, desc = "LSP -- goto next diagnostic", noremap = true, silent = true})
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer = true, desc = "LSP -- goto previous diagnostic", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, {buffer = true, desc = "LSP -- fill loclist with diagnostics", noremap = true, silent = true})
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {buffer = true, desc = "LSP -- format", noremap = true, silent = true})
  end
  return 1
end
if (sys.home == "Kat-Arch") then
  local function _3_()
    require("mason").setup()
    require("mason-lspconfig").setup({ensure_installed = {"fennel_language_server", "lua_ls", "ts_ls", "eslint", "clangd"}, opts = {inlay_hints = {enabled = true}}})
    local lspconfig = require("lspconfig")
    local runtime_path = vim.api.nvim_list_runtime_paths()
    table.insert(runtime_path, "/home/kat/Repos/NEOVIM/love2d.nvim/love2d/library")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    lspconfig.lua_ls.setup({on_attach = on_attach, capabilities = capabilities, settings = {Lua = {workspace = {library = runtime_path}, diagnostics = {globals = {"vim"}}}}})
    lspconfig.ts_ls.setup({on_attach = on_attach, capabilities = capabilities})
    lspconfig.clangd.setup({on_attach = on_attach, capabilities = capabilities})
    return lspconfig.fennel_language_server.setup({on_attach = on_attach, capabilities = capabilities, settings = {fennel = {workspace = {library = runtime_path, checkThirdParty = false}, diagnostics = {globals = {"vim", "love"}}}}})
  end
  M = {"williamboman/mason.nvim", dependencies = {"williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig"}, ft = {"fennel", "c", "cpp", "lua", "typescript", "javascript"}, config = _3_}
else
end
return M
