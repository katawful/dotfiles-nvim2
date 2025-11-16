-- [nfnl] fnl/plugins/ui.fnl
local function _1_(_241, _242)
  require("ui").setup(_242)
  vim.opt_global["cmdheight"] = 1
  return nil
end
return {"OXY2DEV/ui.nvim", config = _1_, lazy = false}
