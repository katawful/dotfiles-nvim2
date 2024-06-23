(local icons (require :globals.icons))
(local config (require :plugins.heirline.config))
(local conditions (require :heirline.conditions))
(import-macros cmd :nvim-anisole.macros.commands)

(local M {})
(local colors config.colors)

(set M.static {:mode_colors_map {:n colors.purple
                                 :i colors.blue
                                 :v colors.red
                                 :V colors.red
                                 "\22" colors.cyan
                                 :c colors.green
                                 :s colors.light_red
                                 :S colors.light_red
                                 "\19" colors.purple
                                 :R colors.orange
                                 :r colors.orange
                                 :! colors.red
                                 :t colors.red}
                 :mode_color #(let [mode (or (and conditions.is_active
                                                  (cmd.run.fn :mode))
                                             :n)]
                                (. $1.mode_colors_map mode))})

(set M.component {:init #(set $1.mode (cmd.run.fn :mode 1))
                  :static {:mode_names {:n "N"
                                        :no "N?"
                                        :nov "N?"
                                        :noV "N?"
                                        :no\22 "N?"
                                        :niI "Ni"
                                        :niR "Nr"
                                        :niV "Nv"
                                        :nt "Nt"
                                        :v "V"
                                        :vs "Vs"
                                        :V "V_"
                                        :Vs "Vs"
                                        "\22" "B"
                                        "\22s" "B"
                                        :s "S"
                                        :S "S_"
                                        "\19" "^S"
                                        :i "I"
                                        :ic "Ic"
                                        :ix "Ix"
                                        :R "R"
                                        :Rc "Rc"
                                        :Rx "Rx"
                                        :Rv "Rv"
                                        :Rvc "Rv"
                                        :Rvx "Rv"
                                        :c "C"
                                        :cv "Ex"
                                        :r "..."
                                        :rm "M"
                                        :r? icons.ui.question
                                        :! icons.ui.exclamation
                                        :t "T"}}
                  :provider #(string.format "%s" (. $1.mode_names $1.mode))
                  :hl #{:bg ($1:mode_color)
                        :fg :normal_fg
                        :bold true}
                  :update {1 "ModeChanged"
                           :pattern "*:*"
                           :callback (vim.schedule_wrap
                                       #(cmd.run.cmd :redrawstatus))}})

M
