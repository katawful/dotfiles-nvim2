-- [nfnl] fnl/plugins/autopairs.fnl
return {"windwp/nvim-autopairs", dependencies = {"windwp/nvim-ts-autotag", config = true}, config = true, opts = {disable_filetype = {"lisp", "fennel", "clojure", "query", "scheme"}}}
