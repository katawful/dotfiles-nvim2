(local leader :<leader>z)

{1 :folke/zen-mode.nvim
 :keys [{1 (.. leader :t)
         2 #((. (require :zen-mode) :toggle))
         :desc "ZenMode -- Toggle zen-mode"}]}
