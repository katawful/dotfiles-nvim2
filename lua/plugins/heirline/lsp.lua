-- [nfnl] Compiled from fnl/plugins/heirline/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icons = autoload("globals.icons")
local conditions = autoload("heirline.conditions")
local heir_utils = autoload("heirline.utils")
local utils = autoload("plugins.heirline.utils")
local config = autoload("plugins.heirline.config")
local n = autoload("nfnl.core")
local M = {}
local P = {}
M["get-name"] = function(_3fbuffer, _3fclient_number)
  local client_number = (_3fclient_number or 1)
  local buffer = (_3fbuffer or 0)
  local client = (vim.lsp.get_clients({bufnr = buffer}))[client_number]
  return client.config.name
end
M["get-namespace"] = function(lsp_name)
  _G.assert((nil ~= lsp_name), "Missing argument lsp-name on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:31")
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for name, id in pairs(vim.api.nvim_get_namespaces()) do
    local val_19_auto
    if string.match(name, (lsp_name .. ".%d/diagnostic/signs")) then
      val_19_auto = id
    else
      val_19_auto = nil
    end
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
M["get-sign"] = function(lsp_name, lnum)
  _G.assert((nil ~= lnum), "Missing argument lnum on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:39")
  _G.assert((nil ~= lsp_name), "Missing argument lsp-name on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:39")
  local id = M["get-namespace"](lsp_name, lnum)
  local lnum0 = (lnum + -1)
  if not n["empty?"](id) then
    return vim.api.nvim_buf_get_extmarks(0, id[1], {lnum0, 0}, {lnum0, -1}, {details = true})
  else
    return {}
  end
end
P["get-sign-detail"] = function(sign, detail)
  _G.assert((nil ~= detail), "Missing argument detail on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:58")
  _G.assert((nil ~= sign), "Missing argument sign on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:58")
  local priority = 0
  --[[ "heirline will break if it is passed an invalid hl-group" ]]
  local output = "MsgSeparator"
  for _, v in ipairs(sign) do
    local sign_details = v[4]
    if (sign_details.priority > priority) then
      priority = sign_details.priority
      output = sign_details[detail]
    else
    end
  end
  return output
end
M["get-sign-type"] = function(sign)
  _G.assert((nil ~= sign), "Missing argument sign on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:76")
  return P["get-sign-detail"](sign, "sign_hl_group")
end
M["get-sign-icon"] = function(sign)
  _G.assert((nil ~= sign), "Missing argument sign on /home/kat/.config/nvim/fnl/plugins/heirline/lsp.fnl:81")
  return string.sub(P["get-sign-detail"](sign, "sign_text"), 0, 1)
end
return M
