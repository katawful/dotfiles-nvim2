(import-macros auto :nvim-anisole.macros.autocmds)
(import-macros option :nvim-anisole.macros.options)


(comment "Highlight yank region upon yank")
(let [highlight (auto.group.define :highlight-on-yank true)]
  (auto.group.fill highlight
                   (auto.cmd.create :TextYankPost "*"
                                    #((. (require :vim.hl) :on_yank))
                                    "Highlight yank region")))

(comment "Make terminal defaults better")
(let [terminal (auto.group.define :terminal-settings true)]
  (auto.group.fill terminal
                   (auto.cmd.create :TermOpen "*"
                                    #(option.set {number false
                                                  relativenumber false
                                                  spell false
                                                  bufhidden :hide})
                                    "No number, relativenumber, and no spell. Bufhidden")))
