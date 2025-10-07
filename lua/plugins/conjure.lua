-- [nfnl] fnl/plugins/conjure.fnl
local function _1_()
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  return nil
end
return {"Olical/conjure", ft = {"fennel"}, config = _1_}
