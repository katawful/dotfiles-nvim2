-- [nfnl] Compiled from fnl/plugins/alpha/theme.fnl by https://github.com/Olical/nfnl, do not edit.
local utils = require("plugins.alpha.utils")
local fortune = require("alpha.fortune")
local icons = require("globals.icons")
local devicons = require("nvim-web-devicons")
local lazy_plugin = require("lazy")
local lazy_stats = require("lazy.stats")
local M = {opts = {position = "center", ["list-amount"] = 5, color = {["function"] = "Normal", bookmark = "Normal", button = "Normal"}}}
local P = {}
local system = {home = vim.env.HOME}
local theme = {["empty-line"] = {type = "padding", val = 1}, ["no-line"] = {type = "padding", val = 0}}
local strings
local function _1_()
  return (require("fzf-lua")).files()
end
local function _2_()
  return (require("fzf-lua")).help_tags()
end
local function _3_()
  return (require("fzf-lua")).buffers()
end
local function _4_()
  return (require("lazy")).update()
end
strings = {edit = {text = " Edit new file", length = #" Edit new file"}, quit = {text = " Quit window", length = #" Quit window"}, functions = {text = "Functions", length = #"Functions", files = {text = " \239\146\129 Search Files", length = #" \239\146\129 Search Files", val = _1_}, help = {text = " \243\176\152\165 Search Help Tags", length = #" \243\176\152\165 Search Help Tags", val = _2_}, buffers = {text = " \238\156\134 Search Buffers", length = #" \238\156\134 Search Buffers", val = _3_}, update = {text = string.format(" %s %s", icons.ui.update, "Update Plugins"), length = #"    Update Plugins", val = _4_}}, ["recent-files"] = {text = "Recent files in: ", length = #"Recent files in: "}, ["recent-commits"] = {text = "Recent commits in: ", length = #"Recent commits in: "}, bookmarks = {text = "Bookmarks", length = #"Bookmarks", config = {sway = {text = " Sway Config", dir = (system.home .. "/.config/sway/"), val = (system.home .. "/.config/sway/config"), length = #" Sway Config"}, neovim = {text = " Neovim Config", dir = (system.home .. "/.config/nvim"), val = (system.home .. "/.config/nvim/init.fnl"), length = #" Neovim Config"}}}, header = {val = {"\226\150\136\226\150\136\226\150\136\226\149\151   \226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\151   \226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\150\136\226\149\151   \226\150\136\226\150\136\226\150\136\226\149\151     \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\149\151   \226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\149\151     \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151", "\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151  \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145   \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\150\136\226\150\136\226\149\145    \226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151  \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157\226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\149\144\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\145     \226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157", "\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145   \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\149\145    \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\148\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\145   \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145     \226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151  ", "\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\149\151 \226\150\136\226\150\136\226\149\148\226\149\157\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\149\148\226\149\157\226\150\136\226\150\136\226\149\145    \226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145   \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145     \226\150\136\226\150\136\226\149\148\226\149\144\226\149\144\226\149\157  ", "\226\150\136\226\150\136\226\149\145 \226\149\154\226\150\136\226\150\136\226\150\136\226\150\136\226\149\145 \226\149\154\226\150\136\226\150\136\226\150\136\226\150\136\226\149\148\226\149\157 \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145 \226\149\154\226\149\144\226\149\157 \226\150\136\226\150\136\226\149\145    \226\150\136\226\150\136\226\149\145  \226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145 \226\149\154\226\150\136\226\150\136\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\149\145\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\145\226\149\154\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\148\226\149\157\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\150\136\226\149\151", "\226\149\154\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\144\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\144\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\157\226\149\154\226\149\144\226\149\157     \226\149\154\226\149\144\226\149\157    \226\149\154\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\157\226\149\154\226\149\144\226\149\157  \226\149\154\226\149\144\226\149\144\226\149\144\226\149\157\226\149\154\226\149\144\226\149\157\226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157 \226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157 \226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157\226\149\154\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\157"}}, bee = {val = {"      AAAA", "AAAAAA  AAAA", "AA    AAAA  AAAA        KKHHKKHHHH", "AAAA    AAAA  AA    HHBBKKKKKKKKKKKKKK", "  AAAAAA      AAKKBBHHKKBBYYBBKKKKHHKKKKKK", "      AAAA  BBAAKKHHBBBBKKKKBBYYBBHHHHKKKKKK", "        BBAABBKKYYYYHHKKYYYYKKKKBBBBBBZZZZZZ", "    YYBBYYBBKKYYYYYYYYYYKKKKBBKKAAAAZZOOZZZZ", "    XXXXYYYYBBYYYYYYYYBBBBBBKKKKBBBBAAAAZZZZ", "    XXXXUUUUYYYYBBYYYYYYBBKKBBZZOOAAZZOOAAAAAA", "  ZZZZZZXXUUXXXXYYYYYYYYBBAAAAZZOOOOAAOOZZZZAAAA", "  ZZUUZZXXUUUUXXXXUUXXFFFFFFFFAAAAOOZZAAZZZZ  AA", "    RRRRUUUUZZZZZZZZXXOOFFFFOOZZOOAAAAAAZZZZAA", "    CCSSUUUUZZXXXXZZXXOOFFFFOOZZOOOOZZOOAAAA", "    CCCCUUUUUUUUUURRRROOFFFFOOZZOOOOZZOOZZZZ", "    CCCCUUUUUUUUSSCCCCEEQQQQOOZZOOOOZZOOZZZZ", "    CCCCUUGGUUUUCCCCCCEEQQQQOOZZOOOOZZEEZZ", "    RRRRGGGGUUGGCCCCCCOOOOOOOOZZOOEEZZII", "      IIRRGGGGGGCCCCCCOOOOOOOOZZEEII", "            GGRRCCCCCCOOOOEEEEII  II", "                RRRRRREEEE  IIII", "                      II"}}, catsleep = {val = {"                                                  ", "                           |\\      _,,,---,,_     ", "                     ZZZzz /,`.-'`'    -.  ;-;;,_ ", "                          |,4-  ) )-,_. ,\\ (  `'-'", "                         '---''(_/--'  `-'\\_)     "}}}
P["alpha-autocmd"] = function()
  local alpha_aug = vim.api.nvim_create_augroup("UserAlphaNvim", {clear = false})
  local old_cmdheight = (vim.opt.cmdheight):get()
  local old_tabline = (vim.opt.tabline):get()
  local old_showtabline = (vim.opt.showtabline):get()
  local old_statusbar = (vim.opt.laststatus):get()
  local old_titlestring = (vim.opt.titlestring):get()
  local old_fillchars = (vim.opt.fillchars):get()
  local function _5_()
    vim.opt["titlestring"] = old_titlestring
    vim.opt["tabline"] = old_tabline
    vim.opt["showtabline"] = old_showtabline
    vim.opt["laststatus"] = old_statusbar
    vim.opt["fillchars"] = old_fillchars
    vim.opt["cmdheight"] = old_cmdheight
    return nil
  end
  vim.api.nvim_create_autocmd("User", {callback = _5_, desc = "Disable visual options on Alpha open", group = alpha_aug, pattern = "AlphaClosed"})
  local function _6_()
    vim.opt["titlestring"] = "Anisole"
    vim.opt["tabline"] = ""
    vim.opt["showtabline"] = 0
    vim.opt["laststatus"] = 0
    vim.opt["fillchars"] = {eob = " "}
    vim.opt["cmdheight"] = 0
    return nil
  end
  return vim.api.nvim_create_autocmd("User", {callback = _6_, desc = "Disable visual options on Alpha open", group = alpha_aug, pattern = "AlphaReady"})
end
P["get-plugin-count"] = function()
  return lazy_plugin.stats().count
end
P["get-startup-time"] = function()
  return lazy_plugin.stats().times.LazyStart
end
P["info-string"] = function()
  local version = vim.version()
  local nvim_version_str = (utils.surround(devicons.get_icon_by_filetype("vim", {})) .. "v" .. version.major .. "." .. version.minor .. "." .. version.patch)
  return (utils["get-date"]() .. utils.surround(icons.ui.plug) .. P["get-plugin-count"]() .. utils.surround("plugins loaded in:") .. string.format("%.1f", P["get-startup-time"]()) .. utils.surround("ms") .. nvim_version_str)
end
P["fortune-generate"] = function(art)
  local message = fortune({max_width = 60})
  for _, v in ipairs(art) do
    table.insert(message, v)
  end
  return message
end
theme["recent-files"] = function(dir, start, amount, opts)
  local function _7_()
    return {utils.mru(dir, start, amount, opts)}
  end
  return {type = "group", val = {{type = "text", val = (strings["recent-files"].text .. dir), opts = {hl = {{"Label", 0, strings["recent-files"].length}, {"Directory", strings["recent-files"].length, (strings["recent-files"].length + #dir)}}, position = M.opts.position, shrink_margin = false}}, theme["empty-line"], {type = "group", val = _7_}}}
end
theme["recent-commits"] = function(start, _3famount, _3fopts)
  if utils["repo?"](utils["get-cwd"]()) then
    local function _8_()
      return {utils["show-commits"](start, _3famount, _3fopts)}
    end
    return {type = "group", val = {{type = "text", val = (strings["recent-commits"].text .. utils["get-cwd"]()), opts = {hl = {{"Label", 0, strings["recent-commits"].length}, {"Directory", strings["recent-commits"].length, (strings["recent-commits"].length + #utils["get-cwd"]())}}, position = M.opts.position, shrink_margin = false}}, theme["empty-line"], {type = "group", val = _8_}}}
  else
    return theme["no-line"]
  end
end
P["open-bookmark"] = function(path, dir)
  vim.fn.chdir(dir)
  return vim.cmd({args = {path}, bang = true, cmd = "edit"})
end
P["create-bookmark"] = function(bookmark, keymap)
  local text = strings.bookmarks.config[bookmark].text
  local val = strings.bookmarks.config[bookmark].val
  local dir = strings.bookmarks.config[bookmark].dir
  local text_length = strings.bookmarks.config[bookmark].length
  local function _10_()
    return P["open-bookmark"](val, dir)
  end
  local function _11_()
    return P["open-bookmark"](val, dir)
  end
  return {type = "button", val = text, on_press = _10_, opts = {keymap = {"n", keymap, "", {noremap = true, nowait = true, silent = true, callback = _11_}}, shortcut = keymap, align_shortcut = "left", hl_shortcut = "Constant", hl = {{M.opts.color.bookmark, 1, text_length}}, width = 60, position = M.opts.position}}
end
theme.bookmarks = function(_3fopts)
  local bkmrk = strings.bookmarks
  return {type = "group", val = {theme["empty-line"], {type = "text", val = bkmrk.text, opts = {hl = {{"Label", 0, bkmrk.length}}, position = M.opts.position}}, {type = "group", val = {P["create-bookmark"]("sway", "c"), P["create-bookmark"]("neovim", "n")}}}}
end
P["create-function"] = function(_function, keymap)
  local text = strings.functions[_function].text
  local val = strings.functions[_function].val
  local text_length = strings.functions[_function].length
  local function _12_()
    return val()
  end
  local function _13_()
    return val()
  end
  return {type = "button", val = text, on_press = _12_, opts = {keymap = {"n", keymap, "", {noremap = true, nowait = true, silent = true, callback = _13_}}, shortcut = keymap, align_shortcut = "left", hl_shortcut = "Constant", hl = {{M.opts.color["function"], 1, text_length}}, width = 60, position = M.opts.position}}
end
theme.functions = function(_3fopts)
  local funcs = strings.functions
  return {type = "group", val = {theme["empty-line"], {type = "text", val = funcs.text, opts = {hl = {{"Label", 0, funcs.length}}, position = M.opts.position}}, {type = "group", val = {P["create-function"]("files", "f"), P["create-function"]("buffers", "b"), P["create-function"]("help", "h"), P["create-function"]("update", "u")}}}}
end
theme.logo = {type = "text", val = strings.bee.val, opts = {position = M.opts.position, hl = "Constant"}}
theme.info = {type = "text", val = P["info-string"](), opts = {position = M.opts.position, hl = "Repeat"}}
theme["fortune-message"] = {type = "text", val = P["fortune-generate"](strings.catsleep.val), opts = {position = M.opts.position, hl = "String"}}
theme.header = {type = "group", val = {{type = "padding", val = 5}, theme.info, theme["empty-line"], theme.logo, theme["fortune-message"], theme["empty-line"]}}
local current_list = 0
P["update-list-number"] = function(amount)
  current_list = (current_list + amount)
  return current_list
end
P["reset-list-number"] = function()
  current_list = 0
  return nil
end
M.config = function()
  P["reset-list-number"]()
  local function _14_()
    return vim.cmd({args = {}, bang = false, cmd = "enew"})
  end
  local function _15_()
    return vim.cmd({args = {}, bang = false, cmd = "enew"})
  end
  local _16_
  if not (utils["repo?"](utils["get-cwd"]()) or (system.home == utils["get-cwd"]())) then
    _16_ = theme["recent-files"](system.home, P["update-list-number"](M.opts["list-amount"]), M.opts["list-amount"], {position = M.opts.position, autocd = true, width = 50})
  else
    _16_ = nil
  end
  local function _18_()
    return vim.cmd({args = {}, bang = false, cmd = "quit"})
  end
  local function _19_()
    return vim.cmd({args = {}, bang = false, cmd = "quit"})
  end
  return {layout = {theme.header, theme.functions(), theme["empty-line"], {type = "button", val = strings.edit.text, on_press = _14_, opts = {keymap = {"n", "e", "", {noremap = true, nowait = true, callback = _15_, silent = true}}, shortcut = "e", align_shortcut = "left", hl_shortcut = "Constant", hl = {{M.opts.color.button, 1, strings.edit.length}}, width = 60, position = M.opts.position}}, theme["empty-line"], theme["recent-files"](utils["get-cwd"](), 0, M.opts["list-amount"], {position = M.opts.position, width = 50, autocd = true}), theme["empty-line"], _16_, theme["no-line"], theme["recent-commits"](P["update-list-number"](M.opts["list-amount"]), M.opts["list-amount"], {}), theme.bookmarks(), theme["empty-line"], {type = "button", val = strings.quit.text, on_press = _18_, opts = {keymap = {"n", "q", "", {noremap = true, nowait = true, callback = _19_, silent = true}}, shortcut = "q", align_shortcut = "left", hl_shortcut = "Constant", hl = {{M.opts.color.button, 1, strings.quit.length}}, width = 60, position = M.opts.position}}}, opts = {setup = P["alpha-autocmd"], keymap = {press = "<CR>", press_queue = "<M-CR>"}}}
end
return M
