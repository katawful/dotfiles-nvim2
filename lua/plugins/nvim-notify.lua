-- [nfnl] fnl/plugins/nvim-notify.fnl
local function _1_()
  vim.notify = require("notify")
  return nil
end
return {"rcarriga/nvim-notify", config = _1_, enabled = false}
