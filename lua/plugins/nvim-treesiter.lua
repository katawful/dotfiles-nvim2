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
local nvim_treesitter = {}
nvim_treesitter[1] = "nvim-treesitter/nvim-treesitter"
nvim_treesitter["tag"] = "v0.9.1"
nvim_treesitter["main"] = "nvim-treesitter.configs"
local function _2_(lang, buf)
  return disable_treesitter(lang, buf)
end
nvim_treesitter["opts"] = {auto_install = true, ensure_installed = ensure_installed, highlight = {disable = _2_, enable = true, additional_vim_regex_highlighting = false}, ignore_install = {"javascript"}, sync_install = false}
return nvim_treesitter
