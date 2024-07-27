-- [nfnl] Compiled from fnl/globals/maps.fnl by https://github.com/Olical/nfnl, do not edit.
--[[ "Set the leader values" ]]
do
  vim.g["maplocalleader"] = ","
  vim.g["mapleader"] = " "
end
--[[ "Fix broken features from localleader, make fundamental :/; change" ]]
do
  vim.keymap.set({"n", "v"}, "\\", ",", {desc = "Remap \\ to `,` so it is not lost with localleader", nowait = true})
  vim.keymap.set({"n", "v"}, ";", ":", {desc = "Swap char-search with command-line enter", nowait = true})
  vim.keymap.set({"n", "v"}, ":", ";", {desc = "Swap command-line enter with char-search", nowait = true})
end
if vim.g.neovide then
  local function _1_()
    local scale_factor = vim.g.neovide_scale_factor
    vim.g["neovide_scale_factor"] = (scale_factor - 0.05)
    return nil
  end
  vim.keymap.set({"n", "v", "i"}, "<M-->", _1_, {desc = "Neovide -- Decrease scale factor", nowait = true})
  local function _2_()
    local scale_factor = vim.g.neovide_scale_factor
    vim.g["neovide_scale_factor"] = (scale_factor + 0.05)
    return nil
  end
  return vim.keymap.set({"n", "v", "i"}, "<M-=>", _2_, {desc = "Neovide -- Increase scale factor", nowait = true})
else
  return nil
end
