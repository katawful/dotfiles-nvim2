(import-macros m :init-macros)
{1 :OXY2DEV/ui.nvim
 :lazy false
 :config #(do ((. (require "ui") :setup) $2)
            (m.options.set {cmdheight 1}))}
