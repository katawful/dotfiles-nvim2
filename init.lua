-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {path = {}}
--[[ "Create necessary paths" ]]
M.path.lazy = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
M.path.package = (vim.fn.stdpath("data") .. "/lazy")
M["config-name"] = "nvim"
M.path.nfnl = (vim.env.HOME .. "/.config/" .. M["config-name"] .. "/.nfnl.fnl")
M.path.macros = (vim.env.HOME .. "/Repos/NEOVIM/nvim-anisole-macros")
--[[ "Install lazy for later. This is the recommended install method, not fennel specific" ]]
local function lazy_install()
  if not vim.loop.fs_stat(M.path.lazy) then
    return vim.fn.system({"git", "clone", "--filter=blob:none", "--single-branch", "https://github.com/folke/lazy.nvim.git", M.path.lazy})
  else
    return nil
  end
end
--[[ "Allow installation of bootstrapping plugins
      Macros and nfnl for compilation are installed this way" ]]
local function ensure(repo, package, dir)
  if not dir then
    vim.fn.system({"git", "clone", "--filter=blob:none", "--single-branch", ("https://github.com/" .. repo .. ".git"), (M.path.package .. "/" .. package)})
    return (vim.opt.runtimepath):prepend((M.path.package .. "/" .. package))
  else
    local install_path = string.format("%s/%s", M.path.package, package)
    vim.fn.system(string.format("rm -r %s", install_path))
    vim.fn.system(string.format("ln -s %s %s", repo, M.path.package))
    return (vim.opt.runtimepath):prepend(install_path)
  end
end
--[[ "nfnl requires a config file to work, simply add that" ]]
local function nfnl_config()
  if not vim.loop.fs_stat(M.path.nfnl) then
    vim.fn.system(("touch " .. M.path.nfnl))
    return vim.fn.system(("bash -c 'echo \"{}\" >> " .. M.path.nfnl .. "'"))
  else
    return nil
  end
end
--[[ "Bootstrap Lazy and fennel environment" ]]
lazy_install()
ensure(M.path.macros, "nvim-anisole-macros", true)
ensure("Olical/nfnl", "nfnl")
nfnl_config()
do end (vim.opt.runtimepath):prepend(M.path.lazy)
--[[ "Intialize config" ]]
require("globals")
do end (require("lazy")).setup("plugins", {change_detection = {notify = false}})
return M
