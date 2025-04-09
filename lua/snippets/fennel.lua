-- [nfnl] Compiled from fnl/snippets/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local str = require("nfnl.string")
local function variable_naming(args)
  local mod_name
  local _2_
  do
    local t_1_ = args
    if (nil ~= t_1_) then
      t_1_ = t_1_[1]
    else
    end
    _2_ = t_1_
  end
  mod_name = _2_[1]
  local var_name = (string.upper(mod_name:sub(1, 1)) .. string.sub(mod_name, 2, -1))
  return sn(nil, {t(var_name)})
end
local function function_arg_docstring(args)
  local arguments
  local _5_
  do
    local t_4_ = args
    if (nil ~= t_4_) then
      t_4_ = t_4_[1]
    else
    end
    _5_ = t_4_
  end
  arguments = str.split(_5_[1], " ")
  local arguments0
  if (arguments[1] == "") then
    arguments0 = {}
  else
    arguments0 = arguments
  end
  local node_length = #arguments0
  local insert_nodes = {}
  if (node_length > 0) then
    for x = 1, node_length do
      table.insert(insert_nodes, sn(x, {t({"", ""}), t(("@" .. arguments0[x] .. ": ")), i(1, "type"), t(" -- "), i(2, "description")}))
    end
  else
  end
  return sn(nil, insert_nodes)
end
return {s("snipf", fmt("(<> {:trig \"<>\" :name \"<>\" :desc \"<>\"}\n  (fmt \"<>\"\n    [<>]\n    {:delimiters \"<>\"})\n  <>)<>", {c(1, {t("s"), t("autosnippet")}), i(2, "trig"), i(3, "trig"), i(4, "desc"), i(5, "fmt"), i(6, "inputs"), i(7, "<>"), i(8, "opts"), i(0)}, {delimiters = "<>"})), s("snipt", fmt("(<> <> [(t \"<>\")]<>)<>", {c(1, {t("s"), t("autosnippet")}), c(2, {i(nil, "Trigger-Text"), sn(nil, {t("{:trig "), i(1), t("}")})}), i(3, "Output-Text"), c(4, {t(""), sn(nil, {t(" {"), i(1), t("}")})}), i(0)}, {delimiters = "<>"})), s({trig = "module", name = "Create module", desc = "Creates a public module"}, {t("(local M {})")}), s({trig = "private", name = "Create private module", desc = "Creates a private module"}, {t("(local P {})")}), s({trig = "fn", name = "Function with args", desc = "Basic function with arguments and docstring"}, fmt("(fn <> [<>]\n \"FN: <> -- <><>\"\n  <>)", {i(1, "name"), c(2, {t(""), i(2, "args")}), rep(1), i(3, "description"), d(4, function_arg_docstring, {2}, {}), i(0, "body")}, {delimiters = "<>"})), s({trig = "infn", name = "inline function", desc = "Inline function that accepts args"}, fmt("(fn <> [<>]\n \"INLINE: <>\"\n    <>)", {i(1, "name"), c(2, {i(2, "args"), t("")}), rep(1), i(0, "body")}, {delimiters = "<>"})), s({trig = "lambda", name = "Lambda with args", desc = "Basic lambda with arguments and docstring"}, fmt("(\206\187 <> [<>]\n \"\206\187: <> -- <><>\"\n  <>)", {i(1, "name"), c(2, {t(""), i(2, "args")}), rep(1), i(3, "description"), d(4, function_arg_docstring, {2}, {}), i(0, "body")}, {delimiters = "<>"})), s({trig = "reqfn", name = "require as function", desc = "Runs require as a function instead of just a call"}, fmt("((. (require :<>) :<>)<>)", {i(1, "Module"), i(2, "Function"), c(3, {t(""), sn(nil, {t(" "), i(1, "Argument")})})}, {delimiters = "<>"})), s({trig = "ldmod", name = "load a module ", desc = "Loads a module into an appropriately named variable"}, fmt("(local <> (require :<>))", {d(1, variable_naming, {2}, {}), i(2, "module")}, {delimiters = "<>"}))}
