(import-macros lazy :nvim-anisole/macros/lazy)

(lazy.spec.init nfnl
                (lazy.spec.repo.gh :Olical/nfnl)
                (lazy.spec.load.filetype :fennel))
