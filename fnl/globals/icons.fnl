(local M {})

(set M.ui {
           :prompt :   ; nf-fa-chevron-right
           :vert :│ ; nf-md-dots-vertical
           :vert-double :║
           :block-left :┃ ; box-drawing-left
           :linux : ; nf-fa-linux
           :windows : ; nf-fa-windows
           :file : ; nf-fa-file-code
           :save : ; nf-fa-save
           :spell : ; nf-fa-spell-check
           :terminal : ; nf-fa-terminal
           :lock : ; nf-fa-lock
           :search :   ; nf-fa-search
           :list-ul :   ; nf-fa-list-ul
           :gear :   ;nf-fa-gear
           :lightbulb :   ; nf-cod-lightbulb
           :tree :   ; nf-fa-tree
           :calendar :   ; nf-fa-calendar
           :pencil :   ; nf-fa-pencil
           :bug :   ; nf-fa-bug
           :plug :   ; nf-fa-plug
           :update :󰚰   ; nf-md-update
           :breadcrumb :󰄾   ; nf-md-chevron-double-right
           :sign-out :   ; nf-fa-sign-out
           :arrow-right :   ; nf-fa-chevron-right
           :arrow-down : ; nf-na-chevron-down
           :arrow-left :   ; nf-fa-chevron-left
           :arrow-up : ; nf-na-chevron-up
           :check :   ; nf-fa-check
           :play :   ; nf-fa-play
           :plus :   ; nf-fa-plus
           :minus :   ; nf-fa-minus
           :times :   ; nf-fa-times
           :close : ; nf-fa-close
           :info :   ; nf-fa-info
           :exclamation :   ; nf-fa-exclamation
           :question :   ; nf-fa-question
           :location :})   ; nf-cod-location

(match (. (vim.loop.os_uname) :sysname)
  :Linux (set M.os :)
  :Darwin (set M.os :)
  :Windows (set M.os :))

(set M.keyboard {
                 :Alt :󰘵   ; nf-md-apple-keyboard-option
                 :Backspace :󰌍   ; nf-md-keyboard-return
                 :Caps :󰘲   ; nf-md-apple-keyboard-caps
                 :Control :󰘴   ; nf-md-apple-keyboard-control
                 :Return :󰌑   ; nf-md-keyboard-return
                 :Shift :󰘶   ; nf-md-apple-keyboard-shift
                 :Space :󱁐   ;nf-md-keyboard-space
                 :Tab :󰌒})   ; nf-md-keyboard-tab

(set M.file {
             :newfile :󰈔   ; nf-md-file
             :readonly :󰈡   ; nf-md-file-lock
             :modified :󰝒   ; nf-md-file-plus
             :unnamed :󰡯   ; nf-md-file-question
             :find :󰈞   ; nf-md-file-find
             :directory :󰉋})   ; nf-md-folder

(set M.git {
            :repositories :󰳐   ; nf-md-source-repository-multiple
            :branch :   ; nf-dev-git-branch
            :compare :   ; nf-dev-git-compare
            :merge :   ; nf-dev-git-merge
            :diff {
                   :diff :   ; nf-oct-diff
                   :added M.ui.plus
                   :ignored M.ui.times
                   :modified M.ui.exclamation
                   :removed M.ui.minus
                   :renamed M.ui.arrow-right}})

(set M.powerline-half-circle-thick {
                                    :left :   ; nf-ple-left-half-circle-thick
                                    :right :})   ; nf-ple-right-half-circle-thick

(set M.lsp {
            :error M.ui.close
            :hint M.ui.lightbulb
            :info M.ui.info
            :other M.ui.question
            :warn M.ui.exclamation})

(set M.lsp-progress [
                     :   ; nf-fa-circle-o
                     :󰪞   ; nf-md-circle-slice-1
                     :󰪟   ; nf-md-circle-slice-2
                     :󰪟   ; nf-md-circle-slice-2
                     :󰪠   ; nf-md-circle-slice-3
                     :󰪡   ; nf-md-circle-slice-4
                     :󰪢   ; nf-md-circle-slice-5
                     :󰪣   ; nf-md-circle-slice-6
                     :󰪤   ; nf-md-circle-slice-7
                     :󰪤   ; nf-md-circle-slice-7
                     :󰪥])   ; nf-md-circle-slice-8

(set M.lspconfig {
                  :Error M.lsp.error
                  :Hint M.lsp.hint
                  :Info M.lsp.info
                  :Other M.lsp.other
                  :Warn M.lsp.warn})

(set M.dap {
            :DapBreakpoint :   ; nf-cod-debug
            :DapBreakpointCondition :   ; nf-cod-debug-breakpoint-conditional
            :DapBreakpointRejected :   ; nf-cod-debug-breakpoint-unsupported
            :DapLogPoint :   ; nf-cod-debug-breakpoint-log
            :DapStopped :})   ; nf-cod-debug-continue

(set M.nerdtree {
                 :error M.lsp.error
                 :hint M.lsp.hint
                 :info M.lsp.info
                 :warning M.lsp.warn})

(set M.telescope {
                  :prompt-prefix (.. M.ui.search  " ")
                  :selection-caret (.. M.ui.prompt " ")})

M
