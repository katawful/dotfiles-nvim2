(import-macros option :nvim-anisole.macros.options)
(import-macros auto :nvim-anisole.macros.autocmds)
(import-macros cmd :nvim-anisole.macros.commands)
(local utils (require :plugins.alpha.utils))
(local fortune (require :alpha.fortune))
(local icons (require :globals.icons))
(local devicons (require :nvim-web-devicons))
(local lazy-plugin (require :lazy))
(local lazy-stats (require :lazy.stats))

(local M {:opts {:position :center
                 :list-amount 5
                 :color {:function :Normal
                         :bookmark :Normal
                         :button :Normal}}})
(local P {})
(local system {:home vim.env.HOME})
(local theme {:empty-line {:type :padding :val 1}
              :no-line {:type :padding :val 0}})

(local strings {:edit {:text " Edit new file"
                       :length (length " Edit new file")}
                :quit {:text " Quit window"
                       :length (length " Quit window")}
                :functions {:text "Functions"
                            :length (length "Functions")
                            :files {:text "  Search Files"
                                    :length (length "  Search Files")
                                    :val #((. (require :fzf-lua) :files))}
                            :help {:text " 󰘥 Search Help Tags"
                                   :length (length " 󰘥 Search Help Tags")
                                   :val #((. (require :fzf-lua) :help_tags))}
                            :buffers {:text "  Search Buffers"
                                      :length (length "  Search Buffers")
                                      :val #((. (require :fzf-lua) :buffers))}
                            :update {:text (string.format " %s %s" icons.ui.update
                                                                   "Update Plugins")
                                     :length (length "    Update Plugins")
                                     :val #((. (require :lazy) :update))}}
                :recent-files {:text "Recent files in: "
                               :length (length "Recent files in: ")}
                :recent-commits {:text "Recent commits in: "
                                 :length (length "Recent commits in: ")}
                :bookmarks {:text "Bookmarks"
                            :length (length "Bookmarks")
                            :config {:sway {:text " Sway Config"
                                            :dir (.. system.home "/.config/sway/")
                                            :val (.. system.home "/.config/sway/config")
                                            :length (length " Sway Config")}
                                     :neovim {:text " Neovim Config"
                                              :dir (.. system.home "/.config/nvim")
                                              :val (.. system.home "/.config/nvim/init.fnl")
                                              :length (length " Neovim Config")}}}
                :header {:val [
                               "███╗   ██╗██╗   ██╗██╗███╗   ███╗     █████╗ ███╗   ██╗██╗███████╗ ██████╗ ██╗     ███████╗"
                               "████╗  ██║██║   ██║██║████╗ ████║    ██╔══██╗████╗  ██║██║██╔════╝██╔═══██╗██║     ██╔════╝"
                               "██╔██╗ ██║██║   ██║██║██╔████╔██║    ███████║██╔██╗ ██║██║███████╗██║   ██║██║     █████╗  "
                               "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╔══██║██║╚██╗██║██║╚════██║██║   ██║██║     ██╔══╝  "
                               "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ██║  ██║██║ ╚████║██║███████║╚██████╔╝███████╗███████╗"
                               "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝"]}
                :bee {:val ["      AAAA"
                            "AAAAAA  AAAA"
                            "AA    AAAA  AAAA        KKHHKKHHHH"
                            "AAAA    AAAA  AA    HHBBKKKKKKKKKKKKKK"
                            "  AAAAAA      AAKKBBHHKKBBYYBBKKKKHHKKKKKK"
                            "      AAAA  BBAAKKHHBBBBKKKKBBYYBBHHHHKKKKKK"
                            "        BBAABBKKYYYYHHKKYYYYKKKKBBBBBBZZZZZZ"
                            "    YYBBYYBBKKYYYYYYYYYYKKKKBBKKAAAAZZOOZZZZ"
                            "    XXXXYYYYBBYYYYYYYYBBBBBBKKKKBBBBAAAAZZZZ"
                            "    XXXXUUUUYYYYBBYYYYYYBBKKBBZZOOAAZZOOAAAAAA"
                            "  ZZZZZZXXUUXXXXYYYYYYYYBBAAAAZZOOOOAAOOZZZZAAAA"
                            "  ZZUUZZXXUUUUXXXXUUXXFFFFFFFFAAAAOOZZAAZZZZ  AA"
                            "    RRRRUUUUZZZZZZZZXXOOFFFFOOZZOOAAAAAAZZZZAA"
                            "    CCSSUUUUZZXXXXZZXXOOFFFFOOZZOOOOZZOOAAAA"
                            "    CCCCUUUUUUUUUURRRROOFFFFOOZZOOOOZZOOZZZZ"
                            "    CCCCUUUUUUUUSSCCCCEEQQQQOOZZOOOOZZOOZZZZ"
                            "    CCCCUUGGUUUUCCCCCCEEQQQQOOZZOOOOZZEEZZ"
                            "    RRRRGGGGUUGGCCCCCCOOOOOOOOZZOOEEZZII"
                            "      IIRRGGGGGGCCCCCCOOOOOOOOZZEEII"
                            "            GGRRCCCCCCOOOOEEEEII  II"
                            "                RRRRRREEEE  IIII"
                            "                      II"]}
  
                :catsleep {:val ["                                                  "
                                 "                           |\\      _,,,---,,_     "
                                 "                     ZZZzz /,`.-'`'    -.  ;-;;,_ "
                                 "                          |,4-  ) )-,_. ,\\ (  `'-'"
                                 "                         '---''(_/--'  `-'\\_)     "]}})

(fn P.alpha-autocmd []
    (let [alpha-aug (auto.group.define "UserAlphaNvim")
          old-cmdheight (option.get cmdheight)
          old-tabline (option.get tabline)
          old-showtabline (option.get showtabline)
          old-statusbar (option.get laststatus)
          old-titlestring (option.get titlestring)
          old-fillchars (option.get fillchars)]
         (auto.group.fill alpha-aug
                          (auto.cmd.create :User :AlphaReady
                                           #(do (option.set {cmdheight 0
                                                             tabline ""
                                                             titlestring "Anisole"
                                                             showtabline 0
                                                             laststatus 0
                                                             fillchars {:eob " "}}))
                                           "Disable visual options on Alpha open")
                          (auto.cmd.create :User :AlphaClosed
                                           #(do (option.set {cmdheight old-cmdheight
                                                             tabline old-tabline
                                                             titlestring old-titlestring
                                                             showtabline old-showtabline
                                                             laststatus old-statusbar
                                                             fillchars old-fillchars}))
                                           "Disable visual options on Alpha open"))))


(fn P.get-plugin-count []
    (. (lazy-plugin.stats) :count))

(fn P.get-startup-time []
    (. (. (lazy-plugin.stats) :times) :LazyStart))

(fn P.info-string []
    (let [version (vim.version)
          nvim-version-str (.. (utils.surround (devicons.get_icon_by_filetype :vim {}))
                               :v
                               version.major
                               :.
                               version.minor
                               :.
                               version.patch)]
      (.. (utils.get-date)
          (utils.surround icons.ui.plug)
          (P.get-plugin-count)
          (utils.surround "plugins loaded in:")
          (string.format "%.1f" (P.get-startup-time))
          (utils.surround :ms)
          nvim-version-str)))

(fn P.fortune-generate [art]
    (let [message (fortune {:max_width 60})]
        (each [_ v (ipairs art)]
          (table.insert message v))
        message))

(fn theme.recent-files [dir start amount opts]
    {:type :group
     :val [{:type :text
            :val (.. strings.recent-files.text dir)
            :opts {:hl [["Label"
                         0
                         strings.recent-files.length]
                        ["Directory"
                         strings.recent-files.length
                         (+ strings.recent-files.length
                            (length dir))]]
                   :shrink_margin false
                   :position M.opts.position}}
           theme.empty-line
           {:type "group"
            :val (fn [] [(utils.mru dir start amount opts)])}]})

(fn theme.recent-commits [start ?amount ?opts]
    (if (utils.repo? (utils.get-cwd))
        {:type :group
         :val [{:type :text
                :val (.. strings.recent-commits.text (utils.get-cwd))
                :opts {:hl [["Label"
                             0
                             strings.recent-commits.length]
                            ["Directory"
                             strings.recent-commits.length
                             (+ strings.recent-commits.length
                                (length (utils.get-cwd)))]]
                       :shrink_margin false
                       :position M.opts.position}}
               theme.empty-line
               {:type :group
                :val (fn [] [(utils.show-commits start ?amount ?opts)])}]}
        theme.no-line))

(fn P.open-bookmark [path dir]
    (cmd.run.fn :chdir dir)
    (cmd.run.cmd :edit! path))

(fn P.create-bookmark [bookmark keymap]
    (let [text (. (. strings.bookmarks.config bookmark) :text)
          val (. (. strings.bookmarks.config bookmark) :val)
          dir (. (. strings.bookmarks.config bookmark) :dir)
          text-length (. (. strings.bookmarks.config bookmark) :length)]
         {:type :button
          :val text
          :on_press #(P.open-bookmark val dir)
          :opts {:keymap [:n keymap "" {:noremap true :nowait true :silent true
                                        :callback #(P.open-bookmark val dir)}]
                 :shortcut keymap
                 :align_shortcut :left
                 :hl_shortcut :Constant
                 :hl [[M.opts.color.bookmark 1 text-length]]
                 :width 60
                 :position M.opts.position}}))

(fn theme.bookmarks [?opts]
    (local bkmrk strings.bookmarks)
    {:type :group
     :val [theme.empty-line
           {:type :text
            :val bkmrk.text
            :opts {:hl [["Label" 0 bkmrk.length]]
                   :position M.opts.position}}
           {:type :group
            :val [(P.create-bookmark :sway :c)
                  (P.create-bookmark :neovim :n)]}]})

(fn P.create-function [function keymap]
    (let [text (. (. strings.functions function) :text)
          val (. (. strings.functions function) :val)
          text-length (. (. strings.functions function) :length)]
         {:type :button
          :val text
          :on_press #(val)
          :opts {:keymap [:n keymap "" {:noremap true :nowait true :silent true
                                        :callback #(val)}]
                 :shortcut keymap
                 :align_shortcut :left
                 :hl_shortcut :Constant
                 :hl [[M.opts.color.function 1 text-length]]
                 :width 60
                 :position M.opts.position}}))

(fn theme.functions [?opts]
    (local funcs strings.functions)
    {:type :group
     :val [theme.empty-line
           {:type :text
            :val funcs.text
            :opts {:hl [["Label" 0 funcs.length]]
                   :position M.opts.position}}
           {:type :group
            :val [(P.create-function :files :f)
                  (P.create-function :buffers :b)
                  (P.create-function :help :h)
                  (P.create-function :update :u)]}]})

(set theme.logo {:type "text"
                 :val strings.bee.val
                 :opts {:position M.opts.position
                        :hl "Constant"}})

(set theme.info {:type "text"
                 :val (P.info-string)
                 :opts {:position M.opts.position
                        :hl :Repeat}})

(set theme.fortune-message {:type "text"
                            :val (P.fortune-generate strings.catsleep.val)
                            :opts {:position M.opts.position
                                   :hl :String}})

(set theme.header {:type "group"
                   :val [{:type :padding :val 5}
                         theme.info
                         theme.empty-line
                         ; theme.logo
                         theme.fortune-message
                         theme.empty-line]})

;;; Normalize keymapping index
(var current-list 0)
(fn P.update-list-number [amount]
    (set current-list (+ current-list amount))
    current-list)
(fn P.reset-list-number [] (set current-list 0))

(fn M.config []
  (P.reset-list-number)
  {:layout [theme.header
            (theme.functions)
            theme.empty-line
            {:type :button
             :val strings.edit.text
             :on_press (fn [] (cmd.run.cmd :enew))
             :opts {:keymap [:n :e "" {:noremap true
                                       :nowait true
                                       :callback #(cmd.run.cmd :enew)
                                       :silent true}]
                    :shortcut :e
                    :align_shortcut :left
                    :hl_shortcut :Constant
                    :hl [[M.opts.color.button 1 strings.edit.length]]
                    :width 60
                    :position M.opts.position}}
            theme.empty-line
            (theme.recent-files (utils.get-cwd) 0 M.opts.list-amount
                          {:position M.opts.position
                           :width 50
                           :autocd true})
            theme.empty-line
            (if (not (or (utils.repo? (utils.get-cwd))
                         (= system.home (utils.get-cwd))))
                (theme.recent-files system.home
                              (P.update-list-number M.opts.list-amount)
                              M.opts.list-amount
                              {:position M.opts.position
                               :autocd true
                               :width 50}))
            theme.no-line
            (theme.recent-commits (P.update-list-number M.opts.list-amount) M.opts.list-amount {})
            (theme.bookmarks)
            theme.empty-line
            {:type :button
             :val strings.quit.text
             :on_press #(cmd.run.cmd :quit)
             :opts {:keymap [:n :q "" {:noremap true
                                       :nowait true
                                       :callback #(cmd.run.cmd :quit)
                                       :silent true}]
                    :shortcut :q
                    :align_shortcut :left
                    :hl_shortcut :Constant
                    :hl [[M.opts.color.button 1 strings.quit.length]]
                    :width 60
                    :position M.opts.position}}]

   :opts {:setup P.alpha-autocmd
          :keymap {:press "<CR>"
                   :press_queue "<M-CR>"}}})

M
