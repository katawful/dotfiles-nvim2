(import-macros cmd :nvim-anisole.macros.commands)

(local leader :<leader>a)

{1 :goolord/alpha-nvim
 :keys [{1 (.. leader :o)
         2 :<cmd>Alpha<CR>
         :desc "alpha.nvim -- Open Alpha"}]
 :lazy false
 :config (fn [] ((. (require :alpha) :setup)
                 ((. (require :plugins.alpha.theme) :config)))
           (cmd.create :Alpha
                       #((. (require :alpha) :start)
                         false
                         ((. (require :plugins.alpha.theme) :config)))
                       "alpha.nvim -- Open Alpha window"
                       {:bang true
                        :nargs 0
                        :bar true})
           (cmd.create :AlphaReady
                       #((. (require :alpha) :redraw)
                         ((. (require :plugins.alpha.theme) :config))
                         true) 
                       "alpha.nvim -- Redraw Alpha Window"
                       {:bang true
                        :nargs 0
                        :bar true}))}
