(import-macros cmd :nvim-anisole.macros.commands)

{1 :folke/ts-comments.nvim
 :opts {}
 :event "VeryLazy"
 :enabled (cmd.run.fn has "nvim-0.10.0")}
