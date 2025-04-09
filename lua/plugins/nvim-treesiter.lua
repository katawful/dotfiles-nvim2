-- [nfnl] Compiled from fnl/plugins/nvim-treesiter.fnl by https://github.com/Olical/nfnl, do not edit.
local ensure_installed = {"c", "markdown", "markdown_inline", "bash", "lua", "vim", "vimdoc", "query", "cpp", "javascript", "json", "fennel"}
local function disable_treesitter(lang, buf)
  local max_filesize = (100 * 4096)
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if (ok and stats and (stats.size > max_filesize)) then
    return true
  else
    return false
  end
end
local function _2_()
  local function _3_(lang, buf)
    return disable_treesitter(lang, buf)
  end
  return require("nvim-treesitter.configs").setup({auto_install = true, ensure_installed = ensure_installed, highlight = {disable = _3_, enable = true, additional_vim_regex_highlighting = false}, ignore_install = {"javascript"}, sync_install = false})
end
return {"nvim-treesitter/nvim-treesitter", main = "nvim-treesitter.configs", build = ":TSUpdate", dependencies = {"nushell/tree-sitter-nu"}, config = _2_}
