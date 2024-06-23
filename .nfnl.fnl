(local core (require :nfnl.core))
(local config (require :nfnl.config))
(local fs (require :nfnl.fs))
(local default (config.default {}))
(tset default :rtp-patterns [(.. (fs.path-sep) "nfnl$")])

(tset default :rtp-patterns (core.concat default.rtp-patterns ["/nvim-anisole-macros$"]))
(tset default :fennel-macro-path (.. default.fennel-macro-path ";" vim.env.HOME "/Repos/NEOVIM/nvim-anisole-macros/fnl/?.fnl"))
(tset default :compiler-options {:compilerEnv _G})

default
