(import-macros m :init-macros)

(comment "Set the leader values")
(m.options.set :g {mapleader " " maplocalleader ","})

(comment "Fix broken features from localleader, make fundamental :/; change")
(m.maps.create [:n :v] 
               ["\\" "," "Remap \\ to `,` so it is not lost with localleader"
                {:nowait true}]
               [";" ":" "Swap char-search with command-line enter"
                {:nowait true}]
               [":" ";" "Swap command-line enter with char-search"
                {:nowait true}])

(when vim.g.neovide
  (m.maps.create [:n :v :i]
                 ["<M-->"
                  #(let [scale-factor (m.options.get :g neovide_scale_factor)]
                     (m.options.set :g neovide_scale_factor (- scale-factor 0.05)))
                  "Neovide -- Decrease scale factor"
                  {:nowait true}]
                 ["<M-=>"
                  #(let [scale-factor (m.options.get :g neovide_scale_factor)]
                     (m.options.set :g neovide_scale_factor (+ scale-factor 0.05)))
                  "Neovide -- Increase scale factor"
                  {:nowait true}]))
