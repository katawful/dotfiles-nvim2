-- [nfnl] Compiled from fnl/globals/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
--[[ "Highlight yank region upon yank" ]]
do
  local highlight = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true})
  local function _1_()
    return (require("vim.highlight")).on_yank()
  end
  vim.api.nvim_create_autocmd("TextYankPost", {callback = _1_, desc = "Highlight yank region", group = highlight, pattern = "*"})
end
--[[ "Make terminal defaults better" ]]
local terminal = vim.api.nvim_create_augroup("terminal-settings", {clear = true})
local function _2_()
  vim.opt["spell"] = false
  vim.opt["relativenumber"] = false
  vim.opt["number"] = false
  vim.opt["bufhidden"] = "hide"
  return nil
end
return vim.api.nvim_create_autocmd("TermOpen", {callback = _2_, desc = "No number, relativenumber, and no spell. Bufhidden", group = terminal, pattern = "*"})
