-- [nfnl] fnl/plugins/catppuccin.fnl
local function _1_()
  return vim.cmd.colorscheme("catppuccin-latte")
end
return {"catppuccin/nvim", name = "catppuccin", priority = 1000, config = _1_}
