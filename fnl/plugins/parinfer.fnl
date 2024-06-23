(import-macros lazy :nvim-anisole.macros.lazy)
(import-macros option :nvim-anisole.macros.options)
(import-macros map :nvim-anisole.macros.maps)

(lazy.spec.init nvim-parinfer
                (lazy.spec.repo.gh :gpanders/nvim-parinfer)
                (lazy.spec.startup (fn []
                                     (option.set :g {:parinfer_no_maps false})
                                     (map.create :i [:<C-t>
                                                     "<Plug>(parinfer-tab)"
                                                     "parinfer: indent"]
                                                    [:<C-d>
                                                     "<Plug>(parinfer-backtab)"
                                                     "parienfer: dedent"]))))
