(local leader :<leader>z)

{1 :folke/zen-mode.nvim
 :opts {:window {:width 140}}
 :keys [{1 (.. leader :t)
         2 #((. (require :zen-mode) :toggle))
         :desc "ZenMode -- Toggle zen-mode"}]}
