(local home-path :/home/kat)

(local leader :<leader>n)

[{1 :vhyrro/luarocks.nvim
  :config true
  :priority 1000}
 {1 :nvim-neorg/neorg
  :dependencies [:nvim-lua/plenary.nvim
                 :luarocks.nvim
                 :benlubas/neorg-conceal-wrap]
  :lazy true
  :ft "norg"
  :cmd "Neorg"
  :keys [{1 (.. leader :jc)
          2 "<cmd>Neorg journal custom<CR>"
          :desc "Neorg -- Open calendar for journal"}
         {1 (.. leader :jo)
          2 "<cmd>Neorg journal toc open<CR>"
          :desc "Neorg -- Open table of contents for journal"}
         {1 (.. leader :i)
          2 "<cmd>Neorg inject-metadata<CR>"
          :desc "Neorg -- Inject metadata"}
         {1 (.. leader :u)
          2 "<cmd>Neorg update-metadata<CR>"
          :desc "Neorg -- Update metadata"}]
  :config #((. (require :neorg) :setup) 
            {:load {:core.defaults {}
                    :core.concealer {}
                    :external.conceal-wrap {}
                    :core.ui.calendar {}
                    :core.journal {:config {:journal_folder "Documents/neorg/Personal/journal"}}
                    :core.dirman 
                      {:config 
                       {:workspaces {:blog (.. home-path
                                               :/Documents/neorg/Blog)
                                     :fennel (.. home-path
                                              :/Documents/neorg/Fennel)
                                     :oblivion (.. home-path
                                                   :/Documents/neorg/Oblivion)
                                     :personal (.. home-path
                                                   :/Documents/neorg/Personal)
                                     :programming (.. home-path
                                                      :/Documents/neorg/Programming)
                                     :obl-ref (.. home-path
                                                  "/Repos/OBLIVION/oblivion-lang-ref")
                                     :wood (.. home-path
                                               :/Documents/neorg/Woodworking)
                                     :academics (.. home-path
                                                    :/Documents/neorg/Academics)
                                     :config (.. home-path
                                                 :/.config/nvim/docs)}
                        :index "main.norg"}}
                    :core.syntax {}
                    :core.integrations.treesitter {}
                    :core.keybinds {:config {:default_keybinds true}}
                    :core.summary {}
                    :core.completion {:config {:engine "nvim-cmp"}}}})}]

