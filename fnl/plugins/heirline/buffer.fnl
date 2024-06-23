;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))

;;; Boilerplate
(local icons (autoload :globals.icons))
(local conditions (autoload :heirline.conditions))
(local heir-utils (autoload :heirline.utils))
(local utils (autoload :plugins.heirline.utils))
(local config (autoload :plugins.heirline.config))

;;; Components
(local file (autoload :plugins.heirline.file))
(local M {})
(local delimiter config.providers.delimiter)


(set M.component [[{1 (heir-utils.surround delimiter.left #:dark_blue file.icon)
                    :condition #(not (conditions.buffer_matches {:buftype config.ignored-type}))}
                   {1 (heir-utils.surround delimiter.left #:blue file.full-name)
                    :condition #(not (conditions.buffer_matches {:buftype config.ignored-type}))
                    :hl {:bg :dark_blue}}
                   {1 file.flags
                    :condition #(not (conditions.buffer_matches {:buftype config.ignored-type}))
                    :hl {:bg :blue}}]
                  {1 (heir-utils.surround delimiter.left #:blue file.help)
                   :condition #(conditions.buffer_matches {:buftype [:help]})
                   :hl {:bg :pink}}
                  {1 (heir-utils.surround delimiter.left #:blue file.terminal)
                   :condition #(conditions.buffer_matches {:buftype [:terminal]})
                   :hl {:bg :pink}}])
M
