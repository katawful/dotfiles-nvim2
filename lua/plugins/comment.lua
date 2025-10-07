-- [nfnl] fnl/plugins/comment.fnl
local _1_
do
  local result_9_auto = vim.fn.has("nvim-0.10.0")
  if (result_9_auto == 0) then
    _1_ = false
  else
    _1_ = true
  end
end
return {"folke/ts-comments.nvim", opts = {}, event = "VeryLazy", enabled = _1_}
