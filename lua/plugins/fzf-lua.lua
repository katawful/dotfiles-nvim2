-- [nfnl] Compiled from fnl/plugins/fzf-lua.fnl by https://github.com/Olical/nfnl, do not edit.
local fzf_leader = "<leader>f"
local fzf
local function _1_()
  local path = (vim.fn.stdpath("data") .. "/lazy/fzf")
  local install = (path .. "/install")
  return vim.fn.system({install, "--all"})
end
fzf = {"junegunn/fzf", build = _1_}
local nvim_web_devicons = {"nvim-tree/nvim-web-devicons"}
local function _2_()
  return require("fzf-lua").register_ui_select()
end
local function _3_()
  return require("fzf-lua").files()
end
local function _4_()
  return require("fzf-lua").files({no_ignore = true})
end
local function _5_()
  return require("fzf-lua").buffers()
end
local function _6_()
  return require("fzf-lua").help_tags()
end
local function _7_()
  return require("fzf-lua").live_grep()
end
local function _8_()
  return require("fzf-lua").spell_suggest()
end
local function _9_()
  return require("fzf-lua").manpages()
end
local function _10_()
  return require("fzf-lua").marks()
end
local function _11_()
  return require("fzf-lua").command_history()
end
local function _12_()
  return require("fzf-lua").resume()
end
return {"ibhagwan/fzf-lua", dependencies = {nvim_web_devicons, fzf}, opts = {"telescope"}, init = _2_, keys = {{(fzf_leader .. "f"), _3_, mode = {"n"}, desc = "fzf-lua: Files in cwd"}, {(fzf_leader .. "F"), _4_, mode = {"n"}, desc = "fzf-lua: Files with no ignore"}, {(fzf_leader .. "b"), _5_, mode = {"n"}, desc = "fzf-lua: Buffer list"}, {(fzf_leader .. "h"), _6_, mode = {"n"}, desc = "fzf-lua: Help tags"}, {(fzf_leader .. "g"), _7_, mode = {"n"}, desc = "fzf-lua: Live grep"}, {"z=", _8_, mode = {"n"}, desc = "fzf-lua: Spell suggestion"}, {(fzf_leader .. "m"), _9_, mode = {"n"}, desc = "fzf-lua: Man pages"}, {(fzf_leader .. "'"), _10_, mode = {"n"}, desc = "fzf-lua: Marks"}, {(fzf_leader .. "c"), _11_, mode = {"n"}, desc = "fzf-lua: Command history"}, {(fzf_leader .. "r"), _12_, mode = {"n"}, desc = "fzf-lua: Resume last search"}}}
