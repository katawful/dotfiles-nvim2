-- [nfnl] Compiled from fnl/plugins/conjure.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  return nil
end
return {"Olical/conjure", ft = {"fennel"}, config = _1_}
