-- [nfnl] Compiled from fnl/plugins/neorg.fnl by https://github.com/Olical/nfnl, do not edit.
local sys = require("globals.init")
local leader = "<leader>n"
local work = (sys["git-path"] .. "/NOTES/Work")
local fennel = (sys["git-path"] .. "/NOTES/Fennel")
local oblivion = (sys["git-path"] .. "/NOTES/Oblivion")
local programming = (sys["git-path"] .. "/NOTES/Programming")
local academics = (sys["git-path"] .. "/NOTES/Academics")
local journal_folder = (sys["git-path"] .. "NOTES/Journal")
local function _1_()
  return require("neorg").setup({load = {["core.defaults"] = {}, ["core.concealer"] = {}, ["external.conceal-wrap"] = {}, ["core.ui.calendar"] = {}, ["core.journal"] = {config = {journal_folder = journal_folder}}, ["core.dirman"] = {config = {workspaces = {fennel = fennel, oblivion = oblivion, programming = programming, academics = academics, work = work}, index = "main.norg"}}, ["core.syntax"] = {}, ["core.integrations.treesitter"] = {}, ["core.keybinds"] = {config = {default_keybinds = true}}, ["core.summary"] = {}, ["core.completion"] = {config = {engine = "nvim-cmp"}}}})
end
return {{"vhyrro/luarocks.nvim", config = true, priority = 1000}, {"nvim-neorg/neorg", dependencies = {"nvim-lua/plenary.nvim", "luarocks.nvim", "benlubas/neorg-conceal-wrap"}, lazy = true, ft = "norg", cmd = "Neorg", keys = {{(leader .. "jc"), "<cmd>Neorg journal custom<CR>", desc = "Neorg -- Open calendar for journal"}, {(leader .. "jo"), "<cmd>Neorg journal toc open<CR>", desc = "Neorg -- Open table of contents for journal"}, {(leader .. "i"), "<cmd>Neorg inject-metadata<CR>", desc = "Neorg -- Inject metadata"}, {(leader .. "u"), "<cmd>Neorg update-metadata<CR>", desc = "Neorg -- Update metadata"}}, config = _1_}}
