-- [nfnl] fnl/plugins/zenmode.fnl
local leader = "<leader>z"
local function _1_()
  return require("zen-mode").toggle()
end
return {"folke/zen-mode.nvim", opts = {window = {width = 140}}, keys = {{(leader .. "t"), _1_, desc = "ZenMode -- Toggle zen-mode"}}}
