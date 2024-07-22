(import-macros option :nvim-anisole.macros.options)
(import-macros map :nvim-anisole.macros.maps)

{1 :gpanders/nvim-parinfer
 :init #(do (option.set :g {:parinfer_no_maps false})
          (when (= (option.get filetype)
                   :fennel)
            (map.create :i [:<C-t>
                            "<Plug>(parinfer-tab)"
                            "parinfer: indent"]
                           [:<C-d>
                            "<Plug>(parinfer-backtab)"
                            "parienfer: dedent"])))}
