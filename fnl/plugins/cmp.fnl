{1 :hrsh7th/nvim-cmp
 :lazy true
 :dependencies [:saadparwaiz1/cmp_luasnip
                :hrsh7th/cmp-nvim-lsp
                :kdheepak/cmp-latex-symbols]
 :opts #(do (local cmp (require :cmp))
          (local luasnip (require :luasnip))
          {:formatting {:format #(do
                                   (set $2.abbr (string.sub $2.abbr 1 20))
                                   $2)}
           :window {:documentation {:max_width 40
                                    :max_height 30
                                    :border :rounded}
                    :completion {:border :none
                                 :max_width 40
                                 :max_height 30}}
           :snippet {:expand #((. (require :luasnip) :lsp_expand) $1.body)}
           :sources (cmp.config.sources [{:name "luasnip"}
                                         {:name "nvim_lsp"
                                          :max_item_count 15}
                                         {:name "latex_symbols"
                                          :option {:strategy 1}}])
           :mapping {:<C-e> (cmp.mapping #(if (luasnip.jumpable 1)
                                              (luasnip.jump 1)
                                              ($1))
                                         [:i :s])
                     :<C-y> (cmp.mapping #(if (luasnip.jumpable -1)
                                              (luasnip.jump -1)
                                              ($1))
                                         [:i :s])
                     :<C-n> (cmp.mapping #(if (cmp.visible)
                                              (cmp.select_next_item)
                                              ($1))
                                         [:i :s])
                     :<C-p> (cmp.mapping #(if (cmp.visible)
                                              (cmp.select_prev_item)
                                              ($1))
                                         [:i :s])
                     :<C-c> (cmp.mapping #(if (cmp.visible)
                                              (cmp.abort))
                                         [:i :s])}})}
