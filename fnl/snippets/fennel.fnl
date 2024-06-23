;local ls (require :luasnip))
;local s ls.snippet)
;local sn ls.snippet_node)
;local isn ls.indent_snippet_node)
;local t ls.text_node)
;local i ls.insert_node)
;local f ls.function_node)
;local c ls.choice_node)
;local d ls.dynamic_node)
;local r ls.restore_node)
;local events (require :luasnip.util.events))
;local ai (require :luasnip.nodes.absolute_indexer))
;local extras (require :luasnip.extras))
;local l extras.lambda)
;local rep extras.rep)
;local p extras.partial)
;local m extras.match)
;local n extras.nonempty)
;local dl extras.dynamic_lambda)
;local fmt (. (require :luasnip.extras.fmt) :fmt))
;local fmta (. (require :luasnip.extras.fmt) :fmta))
;local conds (require :luasnip.extras.expand_conditions))
;local postfix (. (require :luasnip.extras.postfix) :postfix))
;local types (require :luasnip.util.types))
;local parse (. (require :luasnip.util.parser) :parse_snippet))
;local ms ls.multi_snippet)
;local k (. (require :luasnip.nodes.key_indexer) :new_key))  
(local str (require :nfnl.string))

(fn variable-naming [args]
 "INLINE: variable-naming"
    (let [mod-name (. (?. args 1) 1)
          var-name (.. (string.upper (mod-name:sub 1 1)) (string.sub mod-name 2 -1))]
      (sn nil [(t var-name)])))

(fn function-arg-docstring [args]
  (let [arguments (str.split (. (?. args 1) 1) " ")
        arguments (if (= (. arguments 1) "")
                      {}
                      arguments)
        node-length (length arguments)
        insert-nodes {}]
    (when (> node-length 0)
      (for [x 1 node-length]
        (table.insert insert-nodes
                      (sn x [(t ["" ""])
                             (t (.. "@" (. arguments x) ": "))
                             (i 1 "type")
                             (t " -- ")
                             (i 2 "description")]))))
    (sn nil insert-nodes)))

[
 (s "snipf"
    (fmt "(<> {:trig \"<>\" :name \"<>\" :desc \"<>\"}
  (fmt \"<>\"
    [<>]
    {:delimiters \"<>\"})
  <>)<>"
         [(c 1 [(t :s) (t :autosnippet)])
          (i 2 :trig) (i 3 :trig) (i 4 :desc) (i 5 :fmt) (i 6 :inputs)
          (i 7 "<>") (i 8 :opts) (i 0)]
         {:delimiters "<>"}))

 (s "snipt"
    (fmt "(<> <> [(t \"<>\")]<>)<>"
         [(c 1 [(t :s) (t :autosnippet)])
          (c 2 [(i nil "Trigger-Text") (sn nil [(t "{:trig ") (i 1) (t "}")])])
          (i 3 :Output-Text)
          (c 4 [(t "") (sn nil [(t " {") (i 1) (t "}")])])
          (i 0)]
         {:delimiters "<>"}))

 (s {:trig "module"
     :name "Create module"
     :desc "Creates a public module"} [(t "(local M {})")])

 (s {:trig "private"
     :name "Create private module"
     :desc "Creates a private module"} [(t "(local P {})")])

 (s {:trig "fn"
     :name "Function with args"
     :desc "Basic function with arguments and docstring"}
    (fmt "(fn <> [<>]
 \"FN: <> -- <><>\"
  <>)"
         [(i 1 "name")
          (c 2 [(t "") (i 2 "args")])
          (rep 1)
          (i 3 "description")
          (d 4 function-arg-docstring [2] {})
          (i 0 "body")]
         {:delimiters "<>"}))

 (s {:trig "infn"
     :name "inline function"
     :desc "Inline function that accepts args"}
    (fmt "(fn <> [<>]
 \"INLINE: <>\"
    <>)"
         [(i 1 "name")
          (c 2 [(i 2 "args") (t "")])
          (rep 1)
          (i 0 "body")]
         {:delimiters "<>"}))

 (s {:trig "lambda"
     :name "Lambda with args"
     :desc "Basic lambda with arguments and docstring"}
    (fmt "(λ <> [<>]
 \"λ: <> -- <><>\"
  <>)"
         [(i 1 "name")
          (c 2 [(t "") (i 2 "args")])
          (rep 1)
          (i 3 "description")
          (d 4 function-arg-docstring [2] {})
          (i 0 "body")]
         {:delimiters "<>"}))

 (s {:trig "reqfn" :name "require as function" :desc "Runs require as a function instead of just a call"}
   (fmt "((. (require :<>) :<>)<>)"
     [(i 1 :Module)
      (i 2 :Function)
      (c 3 [(t "") (sn nil [(t " ") (i 1 "Argument")])])]
     {:delimiters "<>"}))

 (s {:trig "ldmod" :name "load a module " :desc "Loads a module into an appropriately named variable"}
   (fmt "(local <> (require :<>))"
     [(d 1 variable-naming [2] {})
      (i 2 "module")]
     {:delimiters "<>"}))]
