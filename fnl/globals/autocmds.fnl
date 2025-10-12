(import-macros m :init-macros)


(comment "Highlight yank region upon yank")
(let [highlight (m.auto.group.define :highlight-on-yank true)]
  (m.auto.group.fill highlight
                   (m.auto.cmd.create :TextYankPost "*"
                                    #((. (require :vim.hl) :on_yank))
                                    "Highlight yank region")))

(comment "Make terminal defaults better")
(let [terminal (m.auto.group.define :terminal-settings true)]
  (m.auto.group.fill terminal
                   (m.auto.cmd.create :TermOpen "*"
                                    #(m.options.set {number false
                                                     relativenumber false
                                                     spell false
                                                     bufhidden :hide})
                                    "No number, relativenumber, and no spell. Bufhidden")))
