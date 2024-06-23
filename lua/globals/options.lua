-- [nfnl] Compiled from fnl/globals/options.fnl by https://github.com/Olical/nfnl, do not edit.
--[[ "Top Level" ]]
do
  vim.opt["virtualedit"] = "block"
  vim.opt["updatetime"] = 100
  vim.opt["undofile"] = true
  vim.opt["title"] = true
  vim.opt["termguicolors"] = true
  vim.opt["smoothscroll"] = true
  vim.opt["signcolumn"] = "yes:1"
  vim.opt["relativenumber"] = true
  vim.opt["number"] = true
  vim.opt["mouse"] = "nvi"
  vim.opt["modeline"] = true
  vim.opt["hidden"] = false
  vim.opt["cmdheight"] = 2
end
do end (vim.opt_global.clipboard):append("unnamedplus")
--[[ "Folding" ]]
do
  vim.opt["foldmethod"] = "syntax"
  vim.opt["foldenable"] = false
  vim.opt["foldcolumn"] = "3"
end
--[[ "List Characters" ]]
do
  vim.opt["listchars"] = {tab = "  ", trail = "\226\150\160", extends = ">", precedes = "<"}
  vim.opt["list"] = true
end
--[[ "Tabs" ]]
do
  vim.opt["tabstop"] = 4
  vim.opt["shiftwidth"] = 4
  vim.opt["expandtab"] = true
end
--[[ "Concealing" ]]
do
  vim.opt["conceallevel"] = 2
  vim.opt["concealcursor"] = ""
end
--[[ "Line Breaking" ]]
do
  vim.opt["showbreak"] = "=>"
  vim.opt["linebreak"] = true
  vim.opt["breakindent"] = true
end
--[[ "Extra" ]]
vim.opt_global["inccommand"] = "nosplit"
do end (vim.opt_local.nrformats):remove("octal")
vim.diagnostic.config({virtual_text = false})
vim.lsp.inlay_hint.enable()
do end (vim.opt_global)["guifont"] = {"FiraCode Nerd Font Mono", ":h10"}
if vim.g.neovide then
  vim.g["neovide_transparency"] = 0.75
  vim.g["neovide_remember_window_size"] = false
  vim.g["neovide_remember_window_position"] = false
  vim.g["neovide_cursor_vfx_particle_speed"] = 10
  vim.g["neovide_cursor_vfx_particle_density"] = 20
  vim.g["neovide_cursor_vfx_mode"] = "railgun"
  vim.g["neovide_cursor_trail_length"] = 2
  vim.g["neovide_cursor_animation_length"] = 0.02
  return nil
else
  return nil
end
