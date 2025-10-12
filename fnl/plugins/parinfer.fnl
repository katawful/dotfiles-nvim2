(import-macros m :init-macros)

{1 :gpanders/nvim-parinfer
 :init #(do (m.options.set :g {:parinfer_no_maps false})
          (when (= (m.options.get filetype)
                   :fennel)
            (m.maps.create :i [:<C-t>
                               "<Plug>(parinfer-tab)"
                               "parinfer: indent"]
                           [:<C-d>
                            "<Plug>(parinfer-backtab)"
                            "parienfer: dedent"])))}
