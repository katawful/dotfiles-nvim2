(local icons (require :globals.icons))
(local config (require :plugins.heirline.config))
(local conditions (require :heirline.conditions))
(import-macros cmd :nvim-anisole.macros.commands)

(local M {})
(local colors config.colors)

(set M.static {:mode_colors_map {:n config.colors.purple
                                 :i config.colors.blue
                                 :v config.colors.red
                                 :V config.colors.red
                                 "\22" config.colors.cyan
                                 :c config.colors.green
                                 :s config.colors.light_red
                                 :S config.colors.light_red
                                 "\19" config.colors.purple
                                 :R config.colors.orange
                                 :r config.colors.orange
                                 :! config.colors.red
                                 :t config.colors.red}
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
