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

{1 :nvim-treesitter/nvim-treesitter
 ; :tag :v0.10.1
 :main :nvim-treesitter.configs
 :build ":TSUpdate"
 :dependencies [:nushell/tree-sitter-nu]
 :config #((. (require :nvim-treesitter.configs) :setup)
           {:auto_install true
            : ensure_installed
            :highlight {:additional_vim_regex_highlighting false
                        :disable (fn [lang buf] (disable-treesitter lang buf))
                        :enable true}
            :ignore_install [:javascript]
            :sync_install false})}
