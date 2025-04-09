-- [nfnl] Compiled from fnl/plugins/kitty-scrollback.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return require("kitty-scrollback").setup()
end
return {"mikesmithgh/kitty-scrollback.nvim", enabled = true, lazy = true, cmd = {"KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth"}, config = _1_}
