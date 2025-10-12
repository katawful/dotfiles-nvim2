;;; Autoload -- improves performance for this plugin
(local {: autoload} (require :nfnl.module))

;;; Boilerplate
(local icons (autoload :globals.icons))
(local conditions (autoload :heirline.conditions))
(local heir-utils (autoload :heirline.utils))
(local utils (autoload :plugins.heirline.utils))
(local config (autoload :plugins.heirline.config))
(local n (autoload :nfnl.core))

;;; Components
(local M {})
(local P {})

(λ M.get-name [?buffer ?client-number]
  "λ: M.get-name -- Returns the lsp name of a buffer of a specific client number
@?buffer: int -- the buffer in question. Default: 0
@?client-number: int -- the client to request. Default 1"
  (let [client-number (or ?client-number 1)
        buffer (or ?buffer 0)
        client (. (vim.lsp.get_clients {:bufnr buffer}) client-number)]
    client.config.name))

(λ M.get-namespace [lsp-name]
 "λ: M.get-namespace -- Return sign namespace number for lsp
@lsp-name: string -- name of lsp"
  (icollect [name id (pairs (vim.api.nvim_get_namespaces))]
    (if (string.match name
                     (.. lsp-name ".%d/diagnostic/signs"))
        id)))

(λ M.get-sign [lsp-name lnum]
 "λ: M.get-sign -- Returns the sign information based on the lsp-name and the line number
Neovim LSP integration does not create a sign namespace until signs actually
exist. We must see if there even is an existing id before we use it. Returning
an empty table will simply skip over it in any call that uses this until signs
exist. We also make sure to set the component condition to when the lsp is
available
@lsp-name: string -- name of lsp
@lnum: int -- line number"
  (let [id (M.get-namespace lsp-name lnum)
        lnum (+ lnum -1)]
    (if (not (n.empty? id))
       (vim.api.nvim_buf_get_extmarks 0
                                      (. id 1)
                                      [lnum 0]
                                      [lnum -1]
                                      {:details true})
       {})))

(λ P.get-sign-detail [sign detail]
 "λ: P.get-sign-detail -- Get a specific detail of signs based on priority for the line
We need to keep track of priority so that we can display the most important one
in the sign column.
This is currently quite roughly put together
@sign: table -- a table of signs, with the `details` flag enabled
@detail: string -- the key from the details table to use"
  (var priority 0)
  (comment "heirline will break if it is passed an invalid hl-group")
  (var output "MsgSeparator")
  (each [_ v (ipairs sign)]
    (let [sign-details (. v 4)]
      (if (> sign-details.priority priority)
          (do (set priority sign-details.priority)
            (set output (. sign-details detail))))))
  output)


(λ M.get-sign-type [sign]
 "λ: M.get-sign-type -- Returns the type of sign as provided. Presumes diagnostic sign
@sign: table -- a table of signs, with the `details` flag enabled"
  (P.get-sign-detail sign :sign_hl_group))

(λ M.get-sign-icon [sign]
 "λ: M.get-sign-icon -- Get the sign icon provided by vim.diagnostic for this sign
There is an extra space after the sign text, at least by default. Just grab that
first character, should be fine for any sign icon setup
@sign: table -- a table of signs, with the `details` flag enabled"
  (string.sub (P.get-sign-detail sign :sign_text) 0 1))

M
