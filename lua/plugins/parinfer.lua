-- [nfnl] Compiled from fnl/plugins/parinfer.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g["parinfer_no_maps"] = false
  if (vim.opt.filetype:get() == "fennel") then
    vim.keymap.set("i", "<C-t>", "<Plug>(parinfer-tab)", {desc = "parinfer: indent"})
    return vim.keymap.set("i", "<C-d>", "<Plug>(parinfer-backtab)", {desc = "parienfer: dedent"})
  else
    return nil
  end
end
return {"gpanders/nvim-parinfer", init = _1_}
