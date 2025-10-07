-- [nfnl] fnl/plugins/alpha.fnl
local leader = "<leader>a"
local function _1_()
  require("alpha").setup(require("plugins.alpha.theme").config())
  local function _2_()
    return require("alpha").start(false, require("plugins.alpha.theme").config())
  end
  vim.api.nvim_create_user_command("Alpha", _2_, {bang = true, bar = true, desc = "alpha.nvim -- Open Alpha window", nargs = 0})
  local function _3_()
    return require("alpha").redraw(require("plugins.alpha.theme").config(), true)
  end
  return vim.api.nvim_create_user_command("AlphaReady", _3_, {bang = true, bar = true, desc = "alpha.nvim -- Redraw Alpha Window", nargs = 0})
end
return {"goolord/alpha-nvim", keys = {{(leader .. "o"), "<cmd>Alpha<CR>", desc = "alpha.nvim -- Open Alpha"}}, config = _1_, lazy = false}
