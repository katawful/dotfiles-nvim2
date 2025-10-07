-- [nfnl] fnl/plugins/kitty-scrollback.fnl
local function _1_()
  return require("kitty-scrollback").setup()
end
return {"mikesmithgh/kitty-scrollback.nvim", enabled = true, lazy = true, cmd = {"KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth"}, config = _1_}
