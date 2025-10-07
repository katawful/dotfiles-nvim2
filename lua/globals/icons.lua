-- [nfnl] fnl/globals/icons.fnl
local M = {}
M.ui = {prompt = "\239\129\148", vert = "\226\148\130", ["vert-double"] = "\226\149\145", ["block-left"] = "\226\148\131", linux = "\239\133\188", windows = "\239\133\186", file = "\239\135\137", save = "\239\131\135", spell = "\238\190\179", terminal = "\239\132\160", lock = "\239\128\163", search = "\239\128\130", ["list-ul"] = "\239\131\138", gear = "\239\128\147", lightbulb = "\238\169\161", tree = "\239\134\187", calendar = "\239\129\179", pencil = "\239\129\128", bug = "\239\134\136", plug = "\239\135\166", update = "\243\176\154\176", breadcrumb = "\243\176\132\190", ["sign-out"] = "\239\130\139", ["arrow-right"] = "\239\129\148", ["arrow-down"] = "\239\129\184", ["arrow-left"] = "\239\129\147", ["arrow-up"] = "\239\129\183", check = "\239\128\140", play = "\239\129\139", plus = "\239\129\140", minus = "\239\129\168", times = "\239\128\141", close = "\239\128\141", info = "\239\132\169", exclamation = "\239\132\170", question = "\239\132\168", location = "\238\172\154"}
do
  local _1_ = vim.loop.os_uname().sysname
  if (_1_ == "Linux") then
    M.os = "\239\133\188"
  elseif (_1_ == "Darwin") then
    M.os = "\239\133\185"
  elseif (_1_ == "Windows") then
    M.os = "\239\133\186"
  else
  end
end
M.keyboard = {Alt = "\243\176\152\181", Backspace = "\243\176\140\141", Caps = "\243\176\152\178", Control = "\243\176\152\180", Return = "\243\176\140\145", Shift = "\243\176\152\182", Space = "\243\177\129\144", Tab = "\243\176\140\146"}
M.file = {newfile = "\243\176\136\148", readonly = "\243\176\136\161", modified = "\243\176\157\146", unnamed = "\243\176\161\175", find = "\243\176\136\158", directory = "\243\176\137\139"}
M.git = {repositories = "\243\176\179\144", branch = "\238\156\165", compare = "\238\156\168", merge = "\238\156\167", diff = {diff = "\239\145\128", added = M.ui.plus, ignored = M.ui.times, modified = M.ui.exclamation, removed = M.ui.minus, renamed = M.ui["arrow-right"]}}
M["powerline-half-circle-thick"] = {left = "\238\130\182", right = "\238\130\180"}
M.lsp = {error = M.ui.close, hint = M.ui.lightbulb, info = M.ui.info, other = M.ui.question, warn = M.ui.exclamation}
M["lsp-progress"] = {"\239\132\140", "\243\176\170\158", "\243\176\170\159", "\243\176\170\159", "\243\176\170\160", "\243\176\170\161", "\243\176\170\162", "\243\176\170\163", "\243\176\170\164", "\243\176\170\164", "\243\176\170\165"}
M.lspconfig = {Error = M.lsp.error, Hint = M.lsp.hint, Info = M.lsp.info, Other = M.lsp.other, Warn = M.lsp.warn}
M.dap = {DapBreakpoint = "\238\171\152", DapBreakpointCondition = "\238\170\167", DapBreakpointRejected = "\238\174\140", DapLogPoint = "\238\170\171", DapStopped = "\238\171\143"}
M.nerdtree = {error = M.lsp.error, hint = M.lsp.hint, info = M.lsp.info, warning = M.lsp.warn}
M.telescope = {["prompt-prefix"] = (M.ui.search .. " "), ["selection-caret"] = (M.ui.prompt .. " ")}
return M
