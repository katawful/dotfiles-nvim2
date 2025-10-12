(local core (require :nfnl.core))
(local config (require :nfnl.config))
(local fs (require :nfnl.fs))
(local default (config.default {}))
(tset default :rtp-patterns [(.. (fs.path-sep) "nfnl$")])

(tset default :compiler-options {:compilerEnv _G})

default
