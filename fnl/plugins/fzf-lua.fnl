(local fzf-leader :<leader>f)

(local fzf
       {1 :junegunn/fzf
        :build #(let [path (.. (vim.fn.stdpath :data) :/lazy/fzf)
                      install (.. path "/install")]
                  (vim.fn.system [install "--all"]))})

(local nvim-web-devicons
       {1 :nvim-tree/nvim-web-devicons})


{1 :ibhagwan/fzf-lua
 :dependencies [nvim-web-devicons fzf]
 :opts [:telescope]
 :init #((. (require :fzf-lua) :register_ui_select))
 :keys [{1 (.. fzf-leader :f)
         2 #((. (require :fzf-lua) :files))
         :mode [:n]
         :desc "fzf-lua: Files in cwd"}
        {1 (.. fzf-leader :b)
         2 #((. (require :fzf-lua) :buffers))
         :mode [:n]
         :desc "fzf-lua: Buffer list"}
        {1 (.. fzf-leader :h)
         2 #((. (require :fzf-lua) :help_tags))
         :mode [:n]
         :desc "fzf-lua: Help tags"}
        {1 (.. fzf-leader :g)
         2 #((. (require :fzf-lua) :live_grep))
         :mode [:n]
         :desc "fzf-lua: Live grep"}
        {1 :z=
         2 #((. (require :fzf-lua) :spell_suggest))
         :mode [:n]
         :desc "fzf-lua: Spell suggestion"}
        {1 (.. fzf-leader :m)
         2 #((. (require :fzf-lua) :manpages))
         :mode [:n]
         :desc "fzf-lua: Man pages"}
        {1 (.. fzf-leader "'")
         2 #((. (require :fzf-lua) :marks))
         :mode [:n]
         :desc "fzf-lua: Marks"}
        {1 (.. fzf-leader :c)
         2 #((. (require :fzf-lua) :command_history))
         :mode [:n]
         :desc "fzf-lua: Command history"}]}
