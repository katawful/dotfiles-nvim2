-- [nfnl] Compiled from fnl/globals/maps.fnl by https://github.com/Olical/nfnl, do not edit.
--[[ "Set the leader values" ]]
do
  vim.g["maplocalleader"] = ","
  vim.g["mapleader"] = " "
end
--[[ "Fix broken features from localleader, make fundamental :/; change" ]]
vim.keymap.set({"n", "v"}, "\\", ",", {desc = "Remap \\ to `,` so it is not lost with localleader", nowait = true})
vim.keymap.set({"n", "v"}, ";", ":", {desc = "Swap char-search with command-line enter", nowait = true})
return vim.keymap.set({"n", "v"}, ":", ";", {desc = "Swap command-line enter with char-search", nowait = true})
