;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))
(local sys (autoload :globals.init))

(import-macros map :nvim-anisole.macros.maps)

(var M nil)

(fn on_attach [client bufnr]
  (set vim.opt_local.omnifunc "v:lua.vim.lsp.omnifunc")
  (set vim.opt_local.signcolumn "yes")
  (local luasnip (require :luasnip))
  (local cmp (require :cmp))
  (map.create :n [:gD vim.lsp.buf.declaration "LSP -- goto declaration"
                  {:buffer true :noremap true :silent true}]
                 [:gd vim.lsp.buf.definition "LSP -- goto definition"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lh" vim.lsp.buf.hover "LSP -- hover"
                  {:buffer true :noremap true :silent true}]
                 [:gi vim.lsp.buf.implementation "LSP -- goto implementation"
                  {:buffer true :noremap true :silent true}]
                 [:g? vim.lsp.buf.signature_help "LSP -- signature"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lwa" vim.lsp.buf.add_workspace_folder "LSP -- add workspace folder"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lwr" vim.lsp.buf.remove_workspace_folder "LSP -- remove workspace folder"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lwl"
                  #(vim.notify (vim.inspect (vim.lsp.buf.list_workspace_folders)))
                  "LSP -- list workspace folders"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lD" vim.lsp.buf.type_definition "LSP -- type definition"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>la" vim.lsp.buf.code_action "LSP -- code action"
                  {:buffer true :noremap true :silent true}]
                 [:<leader>lgr vim.lsp.buf.references "LSP -- goto reference"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>le" vim.diagnostic.open_float "LSP -- open diagnostic"
                  {:buffer true :noremap true :silent true}]
                 ["[d" vim.diagnostic.goto_prev "LSP -- goto next diagnostic"
                  {:buffer true :noremap true :silent true}]
                 ["]d" vim.diagnostic.goto_next "LSP -- goto previous diagnostic"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lq" vim.diagnostic.setloclist "LSP -- fill loclist with diagnostics"
                  {:buffer true :noremap true :silent true}]
                 ["<leader>lf" vim.lsp.buf.format "LSP -- format"
                  {:buffer true :noremap true :silent true}])
  1)

(if (= sys.home :Kat-Arch)
    (set M {1 :williamboman/mason.nvim
            :dependencies ["williamboman/mason-lspconfig.nvim"
                           "neovim/nvim-lspconfig"]
            :ft [:fennel
                 :c
                 :cpp
                 :lua
                 :typescript
                 :javascript]
            :config #(do ((. (require :mason) :setup))
                       ((. (require :mason-lspconfig) :setup)
                        {:ensure_installed [:fennel_language_server
                                            :lua_ls
                                            :ts_ls
                                            :eslint
                                            :clangd]
                         :opts {:inlay_hints {:enabled true}}})
                       (local lspconfig (require :lspconfig))
                       (local runtime-path (vim.api.nvim_list_runtime_paths))
                       (table.insert runtime-path "/home/kat/Repos/NEOVIM/love2d.nvim/love2d/library")
                       (local capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))
                       (lspconfig.lua_ls.setup
                         {: on_attach
                          : capabilities
                          :settings {:Lua {:workspace {:library runtime-path}
                                           :diagnostics {:globals ["vim"]}}}})
                       (lspconfig.ts_ls.setup
                         {: on_attach
                          : capabilities})
                       (lspconfig.clangd.setup
                         {: on_attach
                          : capabilities})
                       (lspconfig.fennel_language_server.setup
                        {: on_attach
                         : capabilities
                         :settings {:fennel {:workspace {:library runtime-path
                                                         :checkThirdParty false}
                                             :diagnostics {:globals ["vim" "love"]}}}}))}))

M
