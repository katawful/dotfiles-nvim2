(local template {:sources {:ultisnips 
                           ["./vim-snippets/UltiSnips"
                            (.. (vim.fn.stdpath :config)
                                "/UltiSnips")]
                           :snipmate [:vim-snippets/snippets]}
                 :output {:vscode_luasnip [(.. (vim.fn.stdpath :config)
                                               "/luasnip_snippets")]}})

{1 :L3MON4D3/LuaSnip
 :lazy true
 :dependencies [{1 :smjonas/snippet-converter.nvim
                 :config #(do ((. (require :snippet_converter) :setup)
                               {:templates [template]}))}
                :rafamadriz/friendly-snippets
                :honza/vim-snippets]
 :build #(do (vim.fn.system "make install_jsregexp"))
           ;(vim.fn.system (.. "rm -r "
                              ;(vim.fn.stdpath "data")
                              ;"/lazy/LuaSnip/syntax"))
 :config #(do
            ((. (require :luasnip.loaders.from_vscode) :lazy_load))
             ;{:paths [(.. (vim.fn.stdpath :config) "/luasnip_snippets")
             ;         (.. (vim.fn.stdpath :data) "/lazy/friendly-snippets/snippets")))
            ((. (require :luasnip.loaders.from_lua) :lazy_load)
             {:paths [(.. (vim.fn.stdpath :config) "/lua/snippets")]})
            ((. (require :luasnip.loaders.from_snipmate) :lazy_load)
             {:paths [(.. (vim.fn.stdpath :data) "/lazy/vim-snippets/snippets")]})
            (( . (require :luasnip) :setup) {:enable_autosnippets true}))
 :version "v2.2.0"
 :keys [{1 :<C-s>
         2 #((. (require :luasnip) :expand))
         :mode [:i :s]
         :desc "LuaSnip - Expand snippet"}
        {1 :<C-f>
         2 #(if (and ((. (require :luasnip) :choice_active) -1)
                     ((. (require :luasnip) :in_snippet)))
                ((. (require :luasnip) :change_choice) 1))
         :nowait true
         :mode [:i :s]
         :desc "LuaSnip - Forward choice in snippet"}
        {1 :<C-g>
         2 #(if (and ((. (require :luasnip) :choice_active) -1)
                     ((. (require :luasnip) :in_snippet)))
                ((. (require :luasnip) :change_choice) -1))
         :nowait true
         :mode [:i :s]
         :desc "LuaSnip - Previous choice in snippet"}
        {1 :<leader>se
         2 #((. (require :luasnip.loaders) :edit_snippet_files))
         :mode [:n]
         :desc "LuaSnip - Edit snippets"}]}
