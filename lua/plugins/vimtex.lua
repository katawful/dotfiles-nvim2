-- [nfnl] Compiled from fnl/plugins/vimtex.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g["vimtex_view_general_viewer"] = "zathura"
  vim.g["vimtex_quickfix_mode"] = 0
  vim.g["vimtex_quickfix-mode"] = 1
  vim.g["vimtex_enabled"] = 1
  vim.g["vimtex_complete_close_braces"] = 1
  vim.g["vimtex_compiler_progname"] = "nvr"
  vim.g["vimtex_compiler_method"] = "latexmk"
  vim.g["vimtex_compiler_latexmk"] = {executable = "latexmk", options = {"-xelatex", "-file-line-error", "-synctex=1", "-interaction=nonstopmode"}}
  vim.g["tex_flavor"] = "latex"
  vim.g["tex_conceal"] = "abdmg"
  return nil
end
return {"lervag/vimtex", config = _1_}
