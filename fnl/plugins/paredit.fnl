(import-macros lazy :nvim-anisole/macros/lazy)

(lazy.spec.init nvim-paredit
                (lazy.spec.repo.gh :julienvincent/nvim-paredit)
                (lazy.spec.enable? false)
                (lazy.spec.lazy? false)
                (lazy.spec.config true)
                (lazy.spec.opts {:filetypes [:clojure :fennel]
                                 :use_default_keys true}))
