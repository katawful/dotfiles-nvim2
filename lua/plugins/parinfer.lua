-- [nfnl] Compiled from fnl/plugins/parinfer.fnl by https://github.com/Olical/nfnl, do not edit.
local nvim_parinfer = {}
nvim_parinfer[1] = "gpanders/nvim-parinfer"
local function _1_()
  vim.g["parinfer_no_maps"] = false
  vim.keymap.set("i", "<C-t>", "<Plug>(parinfer-tab)", {desc = "parinfer: indent"})
  return vim.keymap.set("i", "<C-d>", "<Plug>(parinfer-backtab)", {desc = "parienfer: dedent"})
end
nvim_parinfer["init"] = _1_
return nvim_parinfer
