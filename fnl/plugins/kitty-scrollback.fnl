{1 :mikesmithgh/kitty-scrollback.nvim
 :enabled true
 :lazy true
 :cmd [:KittyScrollbackGenerateKittens
        :KittyScrollbackCheckHealth]
 :config #((. (require :kitty-scrollback) :setup))}
