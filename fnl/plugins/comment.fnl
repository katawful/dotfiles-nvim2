(import-macros m :init-macros)

{1 :folke/ts-comments.nvim
 :opts {}
 :event "VeryLazy"
 :enabled (m.cmd.run.fn has "nvim-0.10.0")}
