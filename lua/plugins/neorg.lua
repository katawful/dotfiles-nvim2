-- [nfnl] Compiled from fnl/plugins/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local home_path = "/home/kat"
local leader = "<leader>n"
local blog = (home_path .. "/Documents/Blog")
local fennel = (home_path .. "/Documents/Fennel")
local oblivion = (home_path .. "/Documents/Oblivion")
local personal = (home_path .. "/Documents/Personal")
local programming = (home_path .. "/Documents/Programming")
local obl_ref = (home_path .. "/Repos/OBLIVION/oblivion-lang-ref")
local wood = (home_path .. "/Documents/Woodworking")
local academics = (home_path .. "/Documents/Academics")
local config = (home_path .. "/.config/nvim/docs")
local journal_folder = "/Documents/Journal"
local function _1_()
  return require("neorg").setup({load = {["core.defaults"] = {}, ["core.concealer"] = {}, ["external.conceal-wrap"] = {}, ["core.ui.calendar"] = {}, ["core.journal"] = {config = {journal_folder = journal_folder}}, ["core.dirman"] = {config = {workspaces = {blog = blog, fennel = fennel, oblivion = oblivion, personal = personal, programming = programming, ["obl-ref"] = obl_ref, wood = wood, academics = academics, config = config}, index = "main.norg"}}, ["core.syntax"] = {}, ["core.integrations.treesitter"] = {}, ["core.keybinds"] = {config = {default_keybinds = true}}, ["core.summary"] = {}, ["core.completion"] = {config = {engine = "nvim-cmp"}}}})
end
return {{"vhyrro/luarocks.nvim", config = true, priority = 1000}, {"nvim-neorg/neorg", dependencies = {"nvim-lua/plenary.nvim", "luarocks.nvim", "benlubas/neorg-conceal-wrap"}, lazy = true, ft = "norg", cmd = "Neorg", keys = {{(leader .. "jc"), "<cmd>Neorg journal custom<CR>", desc = "Neorg -- Open calendar for journal"}, {(leader .. "jo"), "<cmd>Neorg journal toc open<CR>", desc = "Neorg -- Open table of contents for journal"}, {(leader .. "i"), "<cmd>Neorg inject-metadata<CR>", desc = "Neorg -- Inject metadata"}, {(leader .. "u"), "<cmd>Neorg update-metadata<CR>", desc = "Neorg -- Update metadata"}}, config = _1_}}
