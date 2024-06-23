(import-macros cmd :nvim-anisole.macros.commands)
(local icons (require :globals.icons))
(local devicons (require :nvim-web-devicons))
(local plenary-path (require :plenary.path))

(local M {})
(local leader :<L>)

(set M.mru-opts
       {:autocd false
        :devicons true
        :width 60
        :position :center
        :devicons-hl true
        :ignore (fn [path ext]
                  (or (string.find path :COMMIT_EDITMSG)
                      (vim.tbl_contains [:gitcommit] ext)))})  

(set M.commit-opts {:width 50 :position :center})

(set M.button-opts {:align_keymap :left
                    :cursor 0
                    :position :center
                    :width 60})

(fn M.surround [str]
  "FN -- surround a string in spaces"
  (.. " " str " "))

(fn M.get-date []
    (os.date (.. (M.surround icons.ui.calendar) "%m/%d/%Y")))

(fn M.get-cwd [] "FN -- Get current directory"
    (cmd.run.fn :getcwd))

(fn M.repo? [dir] "FN -- Is dir a git repo?"
    (let [path (.. (vim.loop.cwd) :/.git)
          ok? (vim.loop.fs_stat path)]
         (if ok? true false)))

(fn nil? [...] "FN -- Check if passed objects evaluate to nil"
    (var out nil)
    (let [nargs (select "#" ...)]
         (for [i 1 nargs]
              (local v (select i ...))
              (when (not= v nil) (set out v)))
         out))

(fn get-extension [file] "FN -- Get the file extension"
   (cmd.run.fn fnamemodify file ":e"))

(fn get-filetype-color [ext]
    "FN -- From nvim-web-devicons but simplified
This function simply gets an icon, of the right color, using a file extension"
    (let [theme (if (= vim.o.background :light)
                    (require :nvim-web-devicons.icons-light)
                    (require :nvim-web-devicons.icons-default))
          icon (?. (?. theme :icons_by_file_extension) ext)]
         (if icon
             (.. "DevIcon" (?. icon :name))
             "DevIconDefault")))

(fn get-icon [file]
    "FN -- Gets the direct icon of a filetype"
    (let [nwd (require :nvim-web-devicons)
          ext (get-extension file)]
         (nwd.get_icon file ext {:default true})))

(fn button [keymap val rhs rhs-opts ?opts]
    "FN -- Create and return a alpha.nvim button"
    (let [keymap-trimmed (: (keymap:gsub "%s" "") :gsub leader :<leader>)
          opts (collect [k v (pairs M.button-opts)]
                 (if (not (?. ?opts k))
                     (values k v)
                     (values k (?. ?opts k))))]
      (set opts.shortcut keymap)
      (when (not (?. opts.hl_shortcut))
            (set opts.hl_shortcut [[:Constant 0 (length keymap)]]))
      (when rhs
            (set-forcibly! rhs-opts
                           (nil? rhs-opts
                                 {:noremap true :nowait true :silent true}))
            (set opts.keymap [:n keymap-trimmed rhs rhs-opts]))

      (fn on_press []
          (let [key (vim.api.nvim_replace_termcodes (or rhs (.. keymap-trimmed :<Ignore>))
                                                    true false true)]
               (vim.api.nvim_feedkeys key :t false)))

      {: on_press : opts :type :button : val}))  

(fn file-button [file keymap pre-short-file autocd]
    "FN -- Generate a presentable button for a single file"
    ;; Build button info
    (let [short-file (if pre-short-file pre-short-file file)
          extension (get-extension file)
          filetype-hl (get-filetype-color extension)
          button-hl {}
          margin-length (length keymap)
          margin (faccumulate [space "" n 1 margin-length] (.. space " "))
          icon-text (if M.mru-opts.devicons
                        (let [(icon hl) (get-icon file)
                              hl-option-type (type M.mru-opts.devicons-hl)]
                             (when (and (= hl-option-type :boolean)
                                        hl
                                        M.mru-opts.devicons-hl)
                                   (table.insert button-hl [hl (* margin-length 2)
                                                               (+ (* margin-length 2)
                                                                  (length icon) 1)]))
                             (when (= hl-option-type :string)
                                   (table.insert button-hl
                                                 [M.mru-opts.devicons-hl 0 (length icon)]))
                             (.. margin icon " "))
                        margin)
           cd-cmd (or (and autocd " | cd %:p:h") "")
           button-element (button keymap
                                    (.. icon-text short-file)
                                    (.. "<cmd>e " (cmd.run.fn fnameescape file)
                                        cd-cmd
                                        " <CR>"))

           ;; Build positions for file elements
           pre-file-start (short-file:match ".*[/\\]")]
      (if pre-file-start
          ;; If there's a dir path we need to color all of that
          (let [file-start (if (not= pre-file-start nil)
                               (length pre-file-start)
                               (+ (length margin)
                                  (- (length icon-text) 2)
                                  (length short-file)))
                file-header-start (+ 3 (- (length icon-text) 2))
                file-header-end (if (= (length margin) 3)
                                    (+ file-start (length icon-text) 2)
                                    (+ file-start (length icon-text) 1))
                file-name-start file-header-end
                file-name-end (+ 3 (- (length icon-text) 2) (length short-file) 1)]
            (table.insert button-hl
                          [:Directory file-header-start file-header-end])
            (table.insert button-hl
                          [filetype-hl file-name-start file-name-end]))
          ;; If there isn't, we are just highlighting a file
          (let [file-start (+ (length margin)
                              (length icon-text))
                file-end (+ file-start (length short-file))]
            (table.insert button-hl
                          [filetype-hl file-start file-end])))

      (set button-element.opts.hl button-hl)
      button-element))

(fn commit-button [hash keymap commit-text command pos]
    "FN -- Construct a alpha.nvim button for a single commit"
    (let [button-hl {}
          button-element (button keymap commit-text command)]
         (table.insert button-hl [:Tag pos.hash-start pos.hash-end])
         (table.insert button-hl [:MoreMsg pos.commit-text-start pos.commit-text-end])
         (set button-element.opts.hl button-hl)
         button-element))

(lambda M.mru [dir start ?amount ?opts]
        "FN -- Construct a alpha.nvim group of most recently used files"
        (let [opts (if ?opts (collect [k v (pairs M.mru-opts)]
                                      (if (not (?. ?opts k))
                                          (values k v)
                                          (values k (?. ?opts k))))
                       M.mru-opts)
              amount (if ?amount ?amount 10)
              width (if (?. opts :width) opts.width 48)
              val {}
              oldfiles []]

          ;; Build oldfiles, skipping ignored values
          (each [_ v (pairs vim.v.oldfiles) &until (= (length oldfiles) amount)]
              (let [dir-cond (if (not dir)
                                 true
                                 (vim.startswith v dir))
                    ignore (or (and opts.ignore
                                    (opts.ignore v (get-extension v)))
                               false)]

                (when (and (and (cmd.run.fn filereadable v)
                                dir-cond)
                           (not ignore))
                      (table.insert oldfiles v))))

          ;; Build file path and button for output table
          (for [i 1 amount &until (not (?. oldfiles i))]
            (let [keymap (tostring (+ start (- i 1)))
                  file-path (if dir
                                (cmd.run.fn fnamemodify (. oldfiles i) ":.")
                                (cmd.run.fn fnamemodify (. oldfiles i) ":~"))
                  short-file-path (do (var target file-path)
                                      (when (> (length target) width)
                                            (set target (: (plenary-path.new target)
                                                           :shorten 3 [-2 -1]))
                                       (when (> (length target) width)
                                             (set target (: (plenary-path.new target)
                                                            :shorten 2 [-1]))))
                                      target)
                  button-element (file-button (. oldfiles i) keymap short-file-path opts.autocd)]

                 (tset val i button-element)))
          {: opts :type :group : val}))

(lambda M.show-commits [start ?amount ?opts]
        "FN -- Construct a alpha.nvim group of most recent git commits"
        (let [opts (if ?opts (collect [k v (pairs M.commit-opts)]
                                      (if (not (?. ?opts k))
                                          (values k v)
                                          (values k (. ?opts k))))
                       M.commit-opts)
              width (if (?. opts :width) opts.width 48)
              amount (if ?amount ?amount 10)]
             (when (not (?. opts :hl))
                   (tset opts :hl []))

             (let [commits (vim.fn.systemlist (.. "git log --oneline | head -n" amount))
                   val []
                   commit-regex (vim.regex "^\\w\\{7}")]
               (for [i 1 amount]
                    (let [commit (. commits i)]
                      (when commit
                        (let [keymap (tostring (+ start (- i 1)))
                              ;; Margin
                              margin-length (- 3 (length keymap))
                              margin (faccumulate [space "" n 1 margin-length] (.. space " "))
                              ;; Hash
                              (raw-hash-start raw-hash-end) (commit-regex:match_str commit)
                              raw-hash-start (or raw-hash-start 0)
                              raw-hash-end (or raw-hash-end 0)
                              hash-start (+ raw-hash-start
                                            (length keymap)
                                            margin-length)
                              hash-end (+ hash-start raw-hash-end 
                                          (length keymap)
                                          margin-length)
                              hash (commit:sub raw-hash-start (- raw-hash-end 1))
                              ;; Commit text
                              commit-text-start (- hash-end (length keymap) margin-length)
                              raw-commit-text (commit:sub raw-hash-end -1)
                              commit-text (do (var target raw-commit-text)
                                              (when (> (length target) width)
                                                    (set target (string.sub target 0 (- width 2)))
                                                    (set target (string.format "%s…" target)))
                                              (string.format "%s%s%s" margin hash target))
                              commit-text-end (+ (length commit-text) commit-text-start)
                              ;; Command
                              command (string.format "<cmd>Git show %s<CR>" hash)
                              hl [[:Function hash-start hash-end]]
                              pos {: hash-start
                                   : hash-end
                                   : commit-text-start
                                   : commit-text-end}
                              button-element (commit-button hash keymap commit-text command pos)]
                          (table.insert opts.hl hl)
                          (tset val i button-element)))))
               {: opts :type :group : val})))

M
