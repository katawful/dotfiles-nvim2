-- [nfnl] Compiled from fnl/plugins/zenmode.fnl by https://github.com/Olical/nfnl, do not edit.
local leader = "<leader>z"
local function _1_()
  return (require("zen-mode")).toggle()
end
return {"folke/zen-mode.nvim", keys = {{(leader .. "t"), _1_, desc = "ZenMode -- Toggle zen-mode"}}}
