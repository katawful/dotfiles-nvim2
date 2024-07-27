(import-macros maps :nvim-anisole.macros.maps)
(import-macros options :nvim-anisole.macros.options)

(comment "Set the leader values")
(options.set :g {mapleader " " maplocalleader ","})

(comment "Fix broken features from localleader, make fundamental :/; change")
(maps.create [:n :v] 
             ["\\" "," "Remap \\ to `,` so it is not lost with localleader"
              {:nowait true}]
             [";" ":" "Swap char-search with command-line enter"
              {:nowait true}]
             [":" ";" "Swap command-line enter with char-search"
              {:nowait true}])

(when vim.g.neovide
  (maps.create [:n :v :i]
               ["<M-->"
                #(let [scale-factor (options.get :g neovide_scale_factor)]
                   (options.set :g neovide_scale_factor (- scale-factor 0.05)))
                "Neovide -- Decrease scale factor"
                {:nowait true}]
               ["<M-=>"
                #(let [scale-factor (options.get :g neovide_scale_factor)]
                   (options.set :g neovide_scale_factor (+ scale-factor 0.05)))
                "Neovide -- Increase scale factor"
                {:nowait true}]))
