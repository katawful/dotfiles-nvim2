(import-macros lazy :nvim-anisole/macros/lazy)

(local ensure_installed [
                         :c
                         :markdown
                         :markdown_inline
                         :bash
                         :lua
                         :vim
                         :vimdoc
                         :query
                         :cpp
                         :javascript
                         :json
                         :fennel])

(fn disable-treesitter [lang buf]
    (local max-filesize (* 100 4096))
    (local (ok stats)
           (pcall vim.loop.fs_stat
                  (vim.api.nvim_buf_get_name buf)))
    (if (and ok stats
             (> stats.size max-filesize))
        true
        false))

(lazy.spec.init nvim-treesitter
        (lazy.spec.repo.gh :nvim-treesitter/nvim-treesitter)
        (lazy.spec.repo.tag :v0.9.1)
        (lazy.spec.module :nvim-treesitter.configs)
        (lazy.spec.opts {:auto_install true
                         : ensure_installed
                         :highlight {:additional_vim_regex_highlighting false
                                     :disable (fn [lang buf] (disable-treesitter lang buf))
                                     :enable true}
                         :ignore_install [:javascript]
                         :sync_install false}))
