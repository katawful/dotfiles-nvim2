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


(set M.component [[{1 (heir-utils.surround delimiter.left #config.colors.dark_blue file.icon)
                    :condition #(not (conditions.buffer_matches {:buftype config.ignored-type}))}
                   {1 (heir-utils.surround delimiter.left #config.colors.blue file.full-name)
                    :condition #(not (conditions.buffer_matches {:buftype config.ignored-type}))
                    :hl {:bg config.colors.dark_blue}}
                   {1 file.flags
                    :condition #(not (conditions.buffer_matches {:buftype config.ignored-type}))
                    :hl {:bg :blue}}]
                  {1 (heir-utils.surround delimiter.left #config.colors.blue file.help)
                   :condition #(conditions.buffer_matches {:buftype [:help]})
                   :hl {:bg config.colors.pink}}
                  {1 (heir-utils.surround delimiter.left #config.colors.blue file.terminal)
                   :condition #(conditions.buffer_matches {:buftype [:terminal]})
                   :hl {:bg config.colors.pink}}])
M
