;;; Boilerplate
(local icons (require :globals.icons))

;;; Module: Configuration for heirline
(local M {})

(fn M.gen-colors []
  (let [kat (. (require :katdotnvim.color) :kat)]
    {:bright_bg kat.bg.umbra.color
     :bright_fg kat.fg.umbra.color
     :normal_bg kat.bg.base.color
     :normal_fg kat.fg.base.color
     :brighter_bg kat.bg.shadow.color
     :brighter_fg kat.fg.shadow.color
     :light_red kat.red.mix_pink.color
     :red kat.red.base.color
     :dark_red kat.red.darken.color
     :cyan kat.blue.brighten.color
     :blue kat.blue.base.color
     :dark_blue kat.blue.darken.color
     :light_green kat.green.auto_match_fg.color
     :green kat.green.auto.color
     :dark_green kat.green.match_bg.color
     :light_orange kat.orange.match_fg.color
     :orange kat.orange.base.color
     :dark_orange kat.orange.match_bg.color
     :light_purple kat.purple.match_fg.color
     :purple kat.purple.base.color
     :dark_purple kat.purple.match_bg.color
     :light_pink kat.pink.match_fg.color
     :pink kat.pink.base.color
     :dark_purple kat.purple.match_bg.color
     :light_gray kat.bg.fifth.color
     :gray kat.bg.meld.color
     :dark_gray kat.bg.shadow.color
     :diag_warn kat.red.match_bg.color
     :diag_error kat.red.base.color
     :diag_hint kat.orange.base.color
     :diag_info kat.green.mix_blue.color
     :git_del kat.red.darken.color
     :git_add kat.green.auto.color
     :git_change kat.purple.base.color}))

(local delimiters icons.powerline-half-circle-thick)
(set M.providers {:delimiter {:left [delimiters.left nil]
                              :right [nil delimiters.right]
                              :both [delimiters.left delimiters.right]}
                  :truncate {:provider "<="}
                  :padding {:provider " "}
                  :even {:provider "%="}
                  :space " "})

(set M.ignored-type [:prompt
                     :help
                     :terminal
                     :quickfix])

M
