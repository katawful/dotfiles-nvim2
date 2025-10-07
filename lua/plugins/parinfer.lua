-- [nfnl] fnl/plugins/parinfer.fnl
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
