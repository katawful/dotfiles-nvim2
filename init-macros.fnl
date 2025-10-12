;; [nfnl-macro]

;; Module
(local M {:command {:run {}}
          :auto {:group {} :cmd {}}
          :options {:private {}}
          :maps {:private {}}})

(fn assert-arg [var# var-type# var-pos# macro#]
  "FN -- Handle `assert-compile` simpler"
  (if (= (type var-type#) :table)
      (let [type-results# (do
                            (local out# [])
                            (each [_ v# (ipairs var-type#)]
                              (if (= (type var#) v#)
                                  (table.insert out# true)
                                  false))
                            out#)
            possible-type-string# (do
                                    (var out# "")
                                    (each [_ v# (ipairs var-type#)]
                                      (set out# (.. out# v# " or ")))
                                    (set out# (string.sub out# 1 -5))
                                    out#)]
        (assert-compile (do
                          (var truthy# false)
                          (each [_ v# (ipairs type-results#)]
                            (if v#
                                (set truthy# true)))
                          truthy#)
                        (string.format "\"%s\" -- Expected %s for arg #%s, received %s"
                                       (tostring macro#) possible-type-string#
                                       var-pos# (type var#))))
      (assert-compile (= (type var#) var-type#)
                      (string.format "\"%s\" -- Expected %s for arg #%s, received %s"
                                     (tostring macro#) var-type# var-pos#
                                     (type var#)))))

(local truthy-functions {:bufexists true
                         :buflisted true
                         :bufloaded true
                         :did_filetype true
                         :empty true
                         :exists true
                         :eventhandler true
                         :filereadable true
                         :filewriteable true
                         :has true
                         :has_key true
                         :haslocaldir true
                         :hasmapto true
                         :hlexists true
                         :isdirectory true
                         :islocked true
                         :isnan true})

;;; COMMANDS

(lambda M.command.run.command [function ...]
  "Macro -- Runs a Ex command

```
@function: |Ex| # Ex function
@... # Arguments for Ex command
```

Can accept a table for functions that take key=val args"
  (let [passed-args# [...]
        args# []
        function (tostring function)
        bang?# (if (= (string.sub function -1) "!") true false)
        function (if bang?#
                     (string.sub function 0 -2)
                     function)]
    (each [_ arg# (ipairs passed-args#)]
      (if (= (type arg#) :string) (table.insert args# arg#)
          (sym? arg#) (table.insert args# arg#)
          (not (and (sequence? arg#) (list? arg#))) (each [key# val# (pairs arg#)]
                                                      (if (= (type key#)
                                                             :number)
                                                          (table.insert args#
                                                                        val#)
                                                          (table.insert args#
                                                                        (string.format "%s=%s"
                                                                                       key#
                                                                                       val#))))))
    `(vim.cmd {:cmd ,function :args ,args# :bang ,bang?#})))

(lambda M.command.run.cmd [function ...]
  "Macro -- Abbreviated M.command.run.command"
  `,(M.command.run.command function ...))

(lambda M.command.run.function [function ...]
  "Macro -- Runs a VimL function

```
@function: |Vimscript| # Vimscript function
@... # Arguments for Vimscript command
```

Returns boolean for builtin truthy/falsy functions such as 'has()'"
  (let [args# ...
        func# (tostring function)]
    (if (. truthy-functions func#)
        `(do
           (let [result# ((. vim.fn ,func#) ,...)]
             (if (= result# 0) false true)))
        `((. vim.fn ,func#) ,...))))

(lambda M.command.run.fn [function ...]
  "Macro -- Abbreviated M.command.run.function"
  `,(M.command.run.function function ...))

(lambda M.command.create [name callback desc ?args]
  "Macro -- Creates a user command

```
@name: |string| # Name for user command
@callback: |string| # The function that gets called on fire of user command
@desc: |string| # Description of user command
@?args: |opt table| # Opts table for vim.api.nvim_create_user_command
```"
  (assert-arg name :string 1 :create)
  (assert-arg callback [:table :function] 2 :create)
  (assert-arg desc :string 3 :create)
  (let [opts# {}]
    (tset opts# :desc desc)
    (when ?args
      (assert-arg ?args :table 4 :create)
      (each [k# v# (pairs ?args)]
        (tset opts# k# v#)))
    (if (?. ?args :buffer)
        (let [buffer# (if (= ?args.buffer true) 0
                          ?args.buffer)]
          (tset opts# :buffer nil)
          `(vim.api.nvim_buf_create_user_command ,buffer# ,name ,callback
                                                 ,opts#))
        `(vim.api.nvim_create_user_command ,name ,callback ,opts#))))

(lambda M.command.define [name command desc ?args]
  "Macro -- Defines a user command with a returned value

```
@name: |string| # Name for user command
@callback: |string| # The function that gets called on fire of user command
@desc: |string| # Description of user command
@?args: |opt table| # Opts table for vim.api.nvim_create_user_command
```

Returns a string of the user-command name"
  `(do
     ,(M.create name command desc ?args)
     ,name))

(lambda M.command.delete! [name ?buffer]
  "Macro -- delete a user command

```
@name: |string| # Name for user command
@?buffer(optional): |int| or |boolean| # Use a buffer
```

Buffer created user commands will fail if ?buffer is not provided"
  (assert-arg name :string 1 :delete!)
  (if ?buffer
      (do
        (assert-arg ?buffer [:boolean :number] 2 :delete!)
        (if (= ?buffer true)
            `(vim.api.nvim_buf_del_user_command ,name 0)
            `(vim.api.nvim_buf_del_user_command ,name ,?buffer)))
      `(vim.api.nvim_del_user_command ,name)))

(set M.cmd M.command)

;;; AUTO

(lambda M.auto.cmd.create [events pattern callback desc ?args]
  "Macro -- Creates an autocmd

```
@events: |string| or |seq of strings| # The autocmd event(s) to use
@pattern: |string| or |seq of strings| # The file pattern(s) to match against
@callback: |function| or |string| # The function or vimscript that gets called on fire of autocmd
@desc: |string| # Description of autocmd
@?args: |opt table| # Table of options for `vim.api.nvim_create_autocmd`
```"
  (assert-arg events [:string :table] 1 :cmd.create)
  (assert-arg pattern [:string :table] 2 :cmd.create)
  (assert-arg callback [:table :function :string] 3 :cmd.create)
  (assert-arg desc :string 4 :cmd.create)
  (let [opts# {}
        call-type# (if (= (type callback) :string) :command :callback)] ; if no desc string, just insert that table
    ;; if a desc string, add them all to the opts table
    (tset opts# :desc desc)
    (tset opts# call-type# callback)
    (tset opts# :pattern pattern)
    (when ?args
      (assert-arg ?args :table 5 :cmd.create)
      (each [k# v# (pairs ?args)]
        (tset opts# k# v#)))
    `(vim.api.nvim_create_autocmd ,events ,opts#)))

(lambda M.auto.group.define [name ?no-clear]
  "Macro -- Defines an auto group and returns the id

```
@name: |string| # Name of group
@?no-clear(optional): |boolean| # If true, don't clear out group. Opposite of default
```"
  (assert-arg name :string 1 :group.define)
  (when ?no-clear
    (assert-arg ?no-clear :boolean 2 :group.define))
  (if ?no-clear
      `(vim.api.nvim_create_augroup ,name {:clear true})
      `(vim.api.nvim_create_augroup ,name {:clear false})))

(lambda M.auto.group.fill [group ...]
  "Macro -- Fills cmd.create calls with an augroup

```
@group: |number| # id of augroup
@... # `cmd.create` calls only
```"
  (let [autocmds# [...]
        size# (length autocmds#)]
    ;; Recurse through macro to make static

    (fn recurse-output [autocmd# i#]
      (let [assertion (?. (?. autocmd# i#) 1)]
        (if assertion
            (assert-compile (string.find (tostring assertion) :cmd.create)
                            (string.format "\"do-augroup\" -- Expected `cmd.create` only, received %s"
                                           (tostring assertion)))))
      (if (< 0 i#)
          (let [current-autocmd# (. autocmd# i#)
                events# (. current-autocmd# 2)
                pattern# (. current-autocmd# 3)
                callback# (. current-autocmd# 4)
                desc# (. current-autocmd# 5)
                args# (if (?. current-autocmd# 6)
                          (. current-autocmd# 6)
                          {})]
            ;; Insert group to opts table
            (tset args# :group group)
            ;; If at one, end of recurse. Finish macro
            (if (= 1 i#)
                `(do
                   ,(M.auto.cmd.create events# pattern# callback# desc# args#)))
            `(do
               ,(M.auto.cmd.create events# pattern# callback# desc# args#)
               ,(recurse-output autocmd# (- i# 1))))))

    (recurse-output autocmds# size#)))

(lambda M.auto.cmd.clear! [tbl]
  "Macro -- Clears autocommands

```
@tbl: |table| # Options table for vim.api.nvim_clear_autocmds
```"
  (assert-arg tbl :table 1 :cmd.clear!)
  `(vim.api.nvim_clear_autocmds ,tbl))

(lambda M.auto.cmd.clear<-event! [events]
  "Macro -- Clears autocommands from events

```
@events: |string| or |seq table| # Events
```"
  (assert-arg events [:string :table] 1 :cmd.clear<-event!)
  `(vim.api.nvim_clear_autocmds {:event ,events}))

(lambda M.auto.cmd.clear<-pattern! [patterns]
  "Macro -- Clears autocommands from patterns

```
@patterns: |string| or |seq table| # File patterns to match
```"
  (assert-arg patterns [:string :table] 1 :cmd.clear<-pattern!)
  `(vim.api.nvim_clear_autocmds {:pattern ,patterns}))

(lambda M.auto.cmd.clear<-buffer! [buffers]
  "Macro -- Clears autocommands from buffers

```
@buffers: |number| or |boolean| # Buffer number or current buffer
```"
  (assert-arg buffers [:number :boolean] 1 :cmd.clear<-buffer!)
  (let [buffer# (if (= buffers true) 0
                    buffers)]
    `(vim.api.nvim_clear_autocmds {:buffer ,buffer#})))

(lambda M.auto.cmd.clear<-group! [groups]
  "Macro -- Clears autocommands from group

```
@groups: |string| or |number| # Augroups
```"
  (assert-arg groups [:string :number] 1 :cmd.clear<-group!)
  `(vim.api.nvim_clear_autocmds {:group ,groups}))

(lambda M.auto.group.delete! [augroup]
  "Macro -- Deletes augroup by id or name

```
@augroup: |string| or |number| # Augroup
```"
  (assert-arg augroup [:string :number] 1 :group.delete!)
  (if (= (type augroup) :string)
      `(vim.api.nvim_del_augroup_by_name ,augroup)
      `(vim.api.nvim_del_augroup_by_id ,augroup)))

(lambda M.auto.cmd.get [tbl]
  "Macro -- Gets autocommands

```
@tbl: |table| # Options table for vim.api.nvim_clear_autocmds
```"
  (assert-arg tbl :table 1 :cmd.get!)
  `(vim.api.nvim_get_autocmds ,tbl))

(lambda M.auto.cmd.get<-group [groups]
  "Macro -- Gets autocommand from group

```
@groups: |string| or |number| # Augroups
```"
  (assert-arg groups [:string :number] 1 :cmd.get<-group!)
  `(vim.api.nvim_get_autocmds {:group ,groups}))

(lambda M.auto.cmd.get<-pattern [patterns]
  "Macro -- Gets autocommands from patterns

```
@patterns: |string| or |seq table| # File patterns to match
```"
  (assert-arg patterns [:string :table] 1 :cmd.get<-pattern!)
  `(vim.api.nvim_get_autocmds {:pattern ,patterns}))

(lambda M.auto.cmd.get<-event [events]
  "Macro -- Gets autocommands from events

```
@events: |string| or |seq table| # Events
```"
  (assert-arg events [:string :table] 1 :cmd.get<-event!)
  `(vim.api.nvim_get_autocmds {:event ,events}))

(lambda M.auto.cmd.run [events ?args]
  "Macro -- Runs an autocommand

```
@events: |string| or |seq table| # Events
@?args: |key/val table| # Options table for vim.api.nvim_exec_autocmds
```"
  (assert-arg events [:string :table] 1 :cmd.run)
  (when ?args
    (assert-arg ?args :table 2 :cmd.run))
  (let [?args (if ?args ?args {})]
    `(vim.api.nvim_exec_autocmds ,events ,?args)))


(fn var-scope [list-item]
  "Group var scopes for easier management"
  (let [list-string (tostring list-item)]
    (if (or (= list-string :g) (= list-string :b) (= list-string :w)
            (= list-string :t) (= list-string :v) (= list-string :env))
        true
        false)))

(fn scope [opt]
  "Gets the scope of an option"
  (let [opt# (tostring opt)]
    (. (vim.api.nvim_get_option_info2 opt# {}) :scope)))

;;; OPTIONS

(lambda M.options.private.set-opt-auto [option value ?flag ?force]
  "Macro -- Sets an option with auto scope

```
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.options.private.set-opt-auto spell true)` -> will set spell locally
`(M.options.private.set-opt-auto mouse :nvi)` -> will set mouse globally

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs."
  (when ?flag
    (do
      ; (assert-arg ?flag :string 3 :private.set-opt-auto)
      (assert-compile (or (= (type ?flag) :string) (= (?. ?flag 1) :nil))
                      (string.format "\"options.private.set-opt-auto\" -- Expected string or nil for arg #3, receieved '%s'"
                                     ?flag) ?flag)
      (when (not= (?. ?flag 1) :nil)
        (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                            (= ?flag :remove))
                        (string.format "\"options.private.set-opt-auto\" -- Expected append, prepend, or remove; got '%s'"
                                       ?flag) ?flag))))
  (let [scope# (scope option)
        opt# (tostring option)
        flag# (if (= (type ?flag) :string)
                  ?flag
                  (?. ?flag 1))]
    (if (not= flag# "nil")
        (do
          (if ?force
              `(: (. vim.opt ,opt#) ,flag# ,value)
              (match scope#
                :win `(: (. vim.opt_local ,opt#) ,flag# ,value)
                :buf `(: (. vim.opt_local ,opt#) ,flag# ,value)
                :global `(: (. vim.opt_global ,opt#) ,flag# ,value))))
        (do
          (if ?force
              `(tset vim.opt ,opt# ,value)
              (match scope#
                :win `(tset vim.opt_local ,opt# ,value)
                :buf `(tset vim.opt_local ,opt# ,value)
                :global `(tset vim.opt_global ,opt# ,value)))))))

(lambda M.options.private.set-opts-auto [options ?flag ?force]
  "Macro -- Plural of set-opt-auto

```
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove, force) for the option
@?force(optional): |boolean| # Force set to global when possible?
```

Takes key-value table of options
Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.options.private.set-opt-auto spell true)` -> will set spell locally   
`(M.options.set-opt-auto mouse :nvi)` -> will set mouse globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs."
  (when ?flag
    (do
      ; (assert-arg ?flag :string 3 :private.set-opts-auto)
      (assert-compile (or (= (type ?flag) :string) (= (?. ?flag 1) :nil))
                      (string.format "\"options.private.set-opt-auto\" -- Expected string or nil for arg #3, receieved '%s'"
                                     ?flag) ?flag)
      (when (not= (?. ?flag 1) :nil)
        (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                            (= ?flag :remove))
                        (string.format "\"options.private.set-opts-auto\" -- Expected append, prepend, or remove; got '%s'"
                                       ?flag) ?flag))))
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs options)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. options v#)))
               out#)
        flag# (if (= (type ?flag) :string)
                  ?flag
                  (?. ?flag 1))
        size# (length key#)]
    ;; We recurse through this macro until all options are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [option# (. (. key# i#) 1)
                ; each option is a table, name is first value
                value# (. val# i#)
                scope# (scope option#)]
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                (if ?force
                    (if flag#
                        `(do
                           (: (. vim.opt ,option#) ,flag# ,value#))
                        `(do
                           (tset vim.opt ,option# ,value#)))
                    (= scope# :global)
                    (if flag#
                        `(do
                           (: (. vim.opt_global ,option#) ,flag# ,value#))
                        `(do
                           (tset vim.opt_global ,option# ,value#)))
                    (if flag#
                        `(do
                           (: (. vim.opt_local ,option#) ,flag# ,value#))
                        `(do
                           (tset vim.opt_local ,option# ,value#)))))
            (if ?force
                (if (= flag# :nil)
                    `(do
                       (tset vim.opt ,option# ,value#)
                       ,(recurse-output key# val# (- i# 1)))
                    `(do
                       (: (. vim.opt ,option#) ,flag# ,value#)
                       ,(recurse-output key# val# (- i# 1))))
                (= scope# :global)
                (if flag#
                    `(do
                       (: (. vim.opt_global ,option#) ,flag# ,value#)
                       ,(recurse-output key# val# (- i# 1)))
                    `(do
                       (tset vim.opt_global ,option# ,value#)
                       ,(recurse-output key# val# (- i# 1))))
                (if flag#
                    `(do
                       (: (. vim.opt_local ,option#) ,flag# ,value#)
                       ,(recurse-output key# val# (- i# 1)))
                    `(do
                       (tset vim.opt_local ,option# ,value#)
                       ,(recurse-output key# val# (- i# 1))))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(lambda M.options.private.set-var [scope variable value]
  "Macro -- Sets a Vim variable

```
@scope: |string| # The scope of the variable
@variable: |object| or |string| # The variable itself. Can be string or literal object
@value: |any| # The value of the option
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [var# (tostring variable)]
    (if (list? scope)
        ;; need to destruct the indexed list and inject the appropriate table
        (let [matched-scope# (tostring (. scope 2))
              index# (. scope 3)]
          (assert-compile (or (= matched-scope# :b) (= matched-scope# :w)
                              (= matched-scope# :t))
                          (string.format "\"options.private.set-var\" -- Expected b, w, or t scope; got %s"
                                         matched-scope#)
                          matched-scope#)
          `(tset (. (. vim ,matched-scope#) ,index#) ,var# ,value))
        (let [scope# (tostring scope)]
          (assert-compile (or (= scope# :g) (= scope# :b) (= scope# :w)
                              (= scope# :t) (= scope# :v) (= scope# :env))
                          (string.format "\"options.private.set-var\" -- Expected b, w, or t scope; got %s"
                                         scope#)
                          scope#)
          `(tset (. vim ,scope#) ,var# ,value)))))

(lambda M.options.private.set-vars [scope variables]
  "Macro -- Plural of private.set-var for one scope

```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs variables)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. variables v#)))
               out#)
        size# (length key#)]
    ;; We recurse through this macro until all variables are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [variable# (. key# i#)
                ; each variable is a table, name is first value
                value# (. val# i#)]
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                `,(M.options.private.set-var scope variable# value#)
                ;; For recursion
                `(do
                   ,(M.options.private.set-var scope variable# value#)
                   ,(recurse-output key# val# (- i# 1)))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(lambda M.options.set [...]
  "Macro -- Sets one or multiple options or variables

Since this macro supports 4 different modes of operation, plus a flag for the option settings,
we need to handle all of those.

1. Single option -> `(set option value ?flag)`
2. Multiple options -> `(set {option1 value option2 value} ?flag)`
3. Single var -> `(set scope variable value)`
4. Multiple vars -> `(set scope {var1 value var2 value})`

1.
```
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.options.set-opt-auto spell true)` -> will set spell locally   
`(M.options.set-opt-auto mouse :nvi)` -> will set mouse globally   


2.
```
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Takes key-value table of options

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.options.set-opt-auto spell true)` -> will set spell locally   
`(M.options.set-opt-auto mouse :nvi)` -> will set mouse globally   

3.
```
@scope: |string| # The scope of the variable
@variable: |object| or |string| # The variable itself. Can be string or literal object
@value: |any| # The value of the option
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

4.
```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.
"
  ;; Let's check to see what we have
  (let [lists [...]]
    (case (type (. lists 1))
      :string (do
                (if (var-scope (. lists 1))
                    (if (sym? (. lists 2))
                        `,(M.options.private.set-var (. lists 1) (. lists 2)
                                             (. lists 3))
                        `,(M.options.private.set-vars (. lists 1) (. lists 2)))))
      :table (do
               (if (list? (. lists 1))
                   (do
                     (if (sym? (. lists 2))
                         `,(M.options.private.set-var (. lists 1) (. lists 2)
                                              (. lists 3))
                         `,(M.options.private.set-vars (. lists 1) (. lists 2))))
                   (sym? (. lists 1))
                   `,(M.options.private.set-opt-auto (. lists 1) (. lists 2)
                                             (?. lists 3) (?. lists 4))
                   `,(M.options.private.set-opts-auto (. lists 1) (. lists 2)
                                              (?. lists 3) (?. lists 4)))))))

(lambda M.options.private.get-var [scope variable]
  "Macro -- Get the value of a Vim variable

```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [var# (tostring variable)]
    (if (list? scope)
        ;; need to destruct the indexed list and inject the appropriate table
        (let [matched-scope# (tostring (. scope 2))
              index# (. scope 3)]
          (assert-compile (or (= matched-scope# :b) (= matched-scope# :w)
                              (= matched-scope# :t))
                          (string.format "\"options.private.get-var\" -- Expected b, w, or t scope; got %s"
                                         matched-scope#)
                          matched-scope#)
          `(. (. (. vim ,matched-scope#) ,index#) ,var#))
        (let [scope# (tostring scope)]
          (assert-compile (or (= scope# :g) (= scope# :b) (= scope# :w)
                              (= scope# :t) (= scope# :v) (= scope# :env))
                          (string.format "\"options.private.get-var\" -- Expected b, w, or t scope; got %s"
                                         scope#)
                          scope#)
          `(. (. vim ,scope#) ,var#)))))

(lambda M.options.private.get-opt [option]
  "Macro -- Get an option's value

```
@option: |object| or |string| # The option, can be written literally
```"
  (let [opt# (tostring option)]
    `(: (. vim.opt ,opt#) :get)))

(lambda M.options.get [...]
  "Macro -- Gets the value of an option or a variable
1. Variable -> `(get scope variable)`
2. Option -> `(get option)`
```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [lists [...]]
    (case (type (. lists 1))
      :string `,(M.options.private.get-var (. lists 1) (. lists 2))
      :table (do
               (if (list? (. lists 1))
                   `,(M.options.private.get-var (. lists 1) (. lists 2))
                   `,(M.options.private.get-opt (. lists 1)))))))

(lambda M.maps.private.create-single-map [modes lhs rhs desc ?args]
  "Internal Macro -- Creates a map

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@lhs: |string| # Left hand of keymap
@rhs: |string| or |function| or |table| # Right hand of keymap
@desc: |string| # Description of keymap
@?args(optional): |opt table| # Opts table for vim.keymap.set
```"
  (assert-arg modes [:string :table] 1 :create-single-map)
  (assert-arg lhs :string 2 :create-single-map)
  (assert-arg rhs [:string :function :table] 3 :create-single-map)
  (assert-arg desc :string 4 :create-single-map)
  (let [opts# {}]
    (tset opts# :desc desc)
    (when ?args
      (assert-arg ?args :table 5 :create-single-map)
      (each [key val (pairs ?args)]
        (tset opts# key val)))
    `(vim.keymap.set ,modes ,lhs ,rhs ,opts#)))

;;; MAPS

(lambda M.maps.private.create-multi-map [modes ...]
  "Internal Macro -- Creates multiple maps

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@... # Stored as sequential tables, each table is the arguments of `create-single-map`
       minus the `modes` argument
```"
  (assert-arg modes [:string :table] 1 :create-single-map)
  (let [maps# [...]
        size# (length maps#)]
    (assert-compile (> size# 0)
                    (string.format "\"create-multi-map\" -- Expected a table of keymaps, received nil")
                    maps#)
    ;; Recurse through macro to make static, starting from first element

    (fn recurse-output [map# i#]
      (if (>= size# i#)
          (let [current-map# (. map# i#)
                lhs# (. current-map# 1)
                rhs# (. current-map# 2)
                desc# (. current-map# 3)
                args# (?. current-map# 4)]
            ;; If at one, end of recurse. Finish macro
            (if (= size# i#)
                `(do
                   ,(M.maps.private.create-single-map modes lhs# rhs# desc# args#)))
            `(do
               ,(M.maps.private.create-single-map modes lhs# rhs# desc# args#)
               ,(recurse-output map# (+ i# 1))))))

    (when (> size# 0)
      (recurse-output maps# 1))))

(fn M.maps.create [modes ...]
  "Macro -- Creates a map. Supports single and multiple map creations.

Arguments for single maps:

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@lhs: |string| # Left hand of keymap
@rhs: |string| or |function| or |table| # Right hand of keymap
@desc: |string| # Description of keymap
@?args(optional): |opt table| # Opts table for vim.keymap.set
```
Arguments for multiple maps:

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@... # Stored as sequential tables, each table is the arguments of single map mode
       minus the `modes` argument
```"
  (assert-arg modes [:string :table] 1 :create)
  (let [maps# [...]]
    (match (type (?. maps# 1))
      :string
      `,(M.maps.private.create-single-map modes (. maps# 1) (. maps# 2) (. maps# 3)
                                     (. maps# 4))
      :table `,(M.maps.private.create-multi-map modes ...))))

M
