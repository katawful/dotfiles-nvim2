(local sys (require :globals.init))

(local leader :<leader>n)
(local work (.. sys.git-path :/NOTES/Work))
(local fennel (.. sys.git-path :/NOTES/Fennel))
(local oblivion (.. sys.git-path :/NOTES/Oblivion))
(local programming (.. sys.git-path :/NOTES/Programming))
(local academics (.. sys.git-path :/NOTES/Academics))
(local journal_folder (.. sys.git-path :NOTES/Journal))

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
                    :core.journal {:config {: journal_folder}}
                    :core.dirman {:config {:workspaces {: fennel
                                                        : oblivion
                                                        : programming
                                                        : academics
                                                        : work}
                                              :index "main.norg"}}
                    :core.syntax {}
                    :core.integrations.treesitter {}
                    :core.keybinds {:config {:default_keybinds true}}
                    :core.summary {}
                    :core.completion {:config {:engine "nvim-cmp"}}}})}]

