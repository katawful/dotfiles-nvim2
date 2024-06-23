(local {: autoload} (require :nfnl.module))
(local kat (. (autoload :katdotnvim.color) :kat))

(local colors
       {
        :blue (. (utils.get_highlight :Function) :fg)
        :cyan (. (utils.get_highlight :Special) :fg)
        :gray (. (utils.get_highlight :NonText) :fg)
        :green (. (utils.get_highlight :String) :fg)
        :orange (. (utils.get_highlight :Constant) :fg)
        :dark_red (. (utils.get_highlight :DiffDelete) :bg)
        :bright_bg (. (utils.get_highlight :Folded) :bg)
        :bright_fg (. (utils.get_highlight :Folded) :fg)
        :diag_error (. (utils.get_highlight :DiagnosticError) :fg)
        :diag_hint (. (utils.get_highlight :DiagnosticHint) :fg)
        :diag_info (. (utils.get_highlight :DiagnosticInfo) :fg)
        :diag_warn (. (utils.get_highlight :DiagnosticWarn) :fg)
        :git_add (. (utils.get_highlight :diffAdded) :fg)
        :git_change (. (utils.get_highlight :diffChanged) :fg)
        :git_del (. (utils.get_highlight :diffDeleted) :fg)
        :purple (. (utils.get_highlight :Statement) :fg)
        :red (. (utils.get_highlight :DiagnosticError) :fg)})  

(if (= vim.o.termguicolors true)
  (do
    (tset kat :normal {:a {:bg kat.purple.base.color
                           :fg kat.fg.auto.color
                           :gui :bold}
                       :b {:bg kat.blue.mix_shadow_bg_more.color
                           :fg kat.fg.auto.color}
                       :c {:bg kat.pink.base.color
                           :fg kat.fg.auto.color}})
    (tset kat :insert {:a {:bg kat.blue.base.color
                           :fg kat.fg.auto.color
                           :gui :bold}
                       :b {:bg kat.blue.mix_shadow_bg_more.color
                           :fg kat.fg.auto.color}
                       :c {:bg kat.blue.brighten.color
                           :fg kat.fg.auto.color}})
    (tset kat :visual {:a {:bg kat.red.base.color
                           :fg kat.fg.auto.color
                           :gui :bold}
                       :b {:bg kat.blue.mix_shadow_bg_more.color
                           :fg kat.fg.auto.color}
                       :c {:bg kat.purple.base.color
                           :fg kat.fg.auto.color}})
    (tset kat :replace {:a {:bg kat.orange.base.color
                            :fg kat.fg.auto.color
                            :gui :bold}
                        :b {:bg kat.blue.mix_shadow_bg_more.color
                            :fg kat.fg.auto.color}
                        :c {:bg kat.blue.brighten.color
                            :fg kat.fg.auto.color}})

    (tset kat :command {:a {:bg kat.green.match_bg.color
                            :fg kat.fg.auto.color
                            :gui :bold}
                        :b {:bg kat.blue.mix_shadow_bg_more.color
                            :fg kat.fg.auto.color}
                        :c {:bg kat.green.match_bg_less.color
                            :fg kat.fg.auto.color}})
    (tset kat :terminal {:a {:bg kat.pink.match_bg_less.color
                             :fg kat.fg.auto.color
                             :gui :bold}
                         :b {:bg kat.blue.mix_shadow_bg_more.color
                             :fg kat.fg.auto.color}
                         :c {:bg kat.red.match_bg.color
                             :fg kat.fg.auto.color}})
    (tset kat :inactive {:a {:bg kat.pink.mix_meld_fg.color
                             :fg kat.fg.base.color}
                         :b {:bg kat.fg.fifth.color
                             :fg kat.fg.base.color}
                         :c {:bg kat.fg.shadow.color
                             :fg kat.bg.base.color}}))
  (do
    (tset kat :normal {:a {:bg 6
                           :fg 7
                           :gui :bold}
                       :b {:bg 12
                           :fg 7}
                       :c {:bg 5
                           :fg 7}})
    (tset kat :insert {:a {:bg 4
                           :fg 7
                           :gui :bold}
                       :b {:bg 12
                           :fg 7}
                       :c {:bg 4
                           :fg 7}})
    (tset kat :visual {:a {:bg 1
                           :fg 7
                           :gui :bold}
                       :b {:bg 12
                           :fg 7}
                       :c {:bg 6
                           :fg 7}})
    (tset kat :replace {:a {:bg 3
                            :fg 7
                            :gui :bold}
                        :b {:bg 4
                            :fg 7}
                        :c {:bg 4
                            :fg 7}})

    (tset kat :command {:a {:bg 2
                            :fg 7
                            :gui :bold}
                        :b {:bg 12
                            :fg 7}
                        :c {:bg 10
                            :fg 7}})
    (tset kat :terminal {:a {:bg 13
                             :fg 7
                             :gui :bold}
                         :b {:bg 12
                             :fg 7}
                         :c {:bg 9
                             :fg 7}})
    (tset kat :inactive {:a {:bg 15
                             :fg 0}
                         :b {:bg 15
                             :fg 0}
                         :c {:bg 15
                             :fg 0}})))
colors
