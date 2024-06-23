-- [nfnl] Compiled from fnl/plugins/nvim-notify.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.notify = require("notify")
  return nil
end
return {"rcarriga/nvim-notify", config = _1_}
