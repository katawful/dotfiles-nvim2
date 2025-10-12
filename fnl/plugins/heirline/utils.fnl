(local {: autoload} (require :nfnl.module))
(local icons (autoload :globals.icons))
(local heir-utils (autoload :heirline.utils))

;;; Module: plugins.heirline.utils
;; Various utilities for heirline
;;; separate: Creates a string of separator characters
;; @param amount -- integer amount of separator characters to create
;; @param char -- the string character to specify, presumes 1 string long
;; @return str -- separator string
;;; status-colors: Change the statusline colors to something desirable
;; @param colors -- table of colors
;;; get-win-for-buf: Get the window specified for a visible buffer
;; @param buf -- the buffer number handle
;;; show-element?: Is number of tabpages more than the number passed
;; @param number -- number to compare against
;; @return boolean -- true if tabpages is more than number
;;; hl-current-line -- returns an appropriate color table based on the current line
;; @param hex -- the color for the background
;; @param hex -- the color for the foreground
;; @param table -- a table of highlight attributes
(local M {})

(fn M.separate [amount char]
 "FN: separate -- Create a separator string for char of amount
@amount: int -- Amount of separator characters
@char: string -- String to write"
  (var str "")
  (for [_ 1 amount]
    (set str (string.format "%s%s" str char)))
  str)

(fn M.status-color [colors]
  "FN: status-color -- Change the statusline colors to something desirable
@color: table -- Table of colors"
  ;; Change StatusLine colors to something I desire
  (let [statusline-hl (vim.api.nvim_get_hl 0 {:name "StatusLine"})]
    (tset statusline-hl :fg colors.pink)
    (tset statusline-hl :bg colors.pink)
    (vim.api.nvim_set_hl 0 :StatusLine statusline-hl))
  (let [statusline-hl (vim.api.nvim_get_hl 0 {:name "StatusLineNC"})]
    (tset statusline-hl :fg colors.gray)
    (tset statusline-hl :bg colors.gray)
    (vim.api.nvim_set_hl 0 :StatusLineNC statusline-hl)))

(fn M.get-win-for-buf [buf]
  "FN: get-win-for-buf -- Get the window specified for a visible buffer
@buf: int -- Buffer handle"
   (let [wins (vim.api.nvim_list_wins)
         tabpage (vim.api.nvim_get_current_tabpage)]
     (each [_ win (ipairs wins)]
       (if (and (= (vim.api.nvim_win_get_tabpage win) tabpage)
                (= (vim.api.nvim_win_get_buf win) buf))
           (vim.api.nvim_set_current_win win)))))

(fn M.show-element? [number]
  "FN: show-element? -- Is number of tabpages more than number passed
@number: int -- Number to compare against"
   (>= (length (vim.api.nvim_list_tabpages)) number))

(fn M.hl-current-line [fg ?bg ?attr]
 "FN: M.hl-current-line -- Returns a highlight for the current line
@fg: table -- table of colors for the foreground. 2 keys: 'default', 'new'
@?bg: table -- (optional) table of color for the background. 2 keys: 'default', 'new'
@?attr: table -- (optional) table of table of text attributes. 2 keys: 'default', 'new'"
  (if (= (. (vim.api.nvim_win_get_cursor 0) 1) vim.v.lnum)
    (let [output {:fg (?. fg :new) :bg (?. ?bg :new)}] 
      (when ?attr (each [k v (pairs (?. ?attr :new))] (tset output k v)))
      output)
    (let [output {:fg (?. fg :default) :bg (?. ?bg :default)}]
      (when ?attr (each [k v (pairs (?. ?attr :default))] (tset output k v)))
      output)))

(fn M.get-window-bounds []
 "FN: M.get-window-bounds -- Get the absolute size boundaries of window
@window: int -- window id, pass 0 for current window"
  (let [start (vim.fn.line "w0")
        end (vim.fn.line "w$")]
    {: start : end}))

(fn M.size-of-lnum []
 "FN: M.size-of-lnum -- Get the length of the largest lnum
@window: int -- window id, pass 0 for current window"
  (let [end (. (M.get-window-bounds) :end)]
    (length (tostring end))))

M
