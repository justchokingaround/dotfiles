(require-macros :macros)

;; You can use the `colorscheme` macro to load a custom theme, or load it manually
;; via require. This is the default:

(set! background :dark)
(colorscheme carbon)

;; The set! macro sets vim.opt options. By default it sets the option to true 
;; Appending `no` in front sets it to false. This determines the style of line 
;; numbers in effect. If set to nonumber, line numbers are disabled. For 
;; relative line numbers, set 'relativenumber`

(set! nonumber)

;; The let option sets global, or `vim.g` options. 
;; Heres an example with localleader, setting it to <space>m

(let! mapleader " ")
(let! maplocalleader " m")

;; map! is used for mappings
;; Heres an example, preseing esc should also remove search highlights

(map! [n] :<esc> :<esc><cmd>noh<cr> {:desc "No highlight escape"})

;; sometimes you want to modify a plugin thats loaded from within a module. For 
;; this you can use the `after` function

(after :neorg
       {:load {:core.norg.dirman {:config {:workspaces {:default "~/dox/neorg"}}}}})

;; Tabs stuff
(set! tabstop 2)
(set! softtabstop 2)
(set! shiftwidth 2)

;; Neovide stuff
(when vim.g.neovide
  (let! neovide_transparency "0.8")
  (let! neovide_no_idle "true")
  (let! neovide_refresh_rate "165")
  (set! guifont "Liga SFMono Nerd Font:h14"))

;; Custom keybinds
(map! [nt] "<A-i>" "<cmd>ToggleTerm direction=float<CR>")
(map! [n] "<leader>y" "<cmd>Trouble workspace_diagnostics<CR>")
(map! [n] :<leader>s
      "<cmd>Telescope lsp_document_symbols<CR>"
      {:desc "LSP Jump to symbol in file"})
(map! [n] :<leader>x "<cmd>bd<CR>"
      {:desc "Kill buffer"})
(map! [n] :<leader>e "<cmd>Neotree toggle<CR>"
      {:desc "Toggle neotree"})

;; QOL stuff
(map! [ni] "<C-s>" "<cmd>w<CR>")
(map! [n] "<Tab>" "<cmd>bn<CR>")
(map! [n] "<S-Tab>" "<cmd>bp<CR>")
(map! [n] "<" "<<")
(map! [n] ">" ">>")
(map! [n] "<leader>z"
      "<cmd>TZAtaraxis<CR><cmd>set nocursorline<CR>"
      {:desc "Toggle zen mode"})
;;(map! [n] ";" ";")

;; Fix cmp binds
(local cmp (autoload :cmp))
(after :cmp {:mapping {:<C-j> (cmp.mapping.select_next_item)
                       :<C-k> (cmp.mapping.select_prev_item)}})

;; Telescope stuff
;;(local telescope (autoload :telescope))
;;(local actions (autoload :telescope.actions))
;;(after :telescope {:defaults
;;                   {:mappings {:i
;;                               {:<C-j> (actions.move_selection_next)
;;                                :<C-k> (actions.move_selection_previous)}}}})
(map! [ni] "<C-j>" "telescope.actions.move_selection_next")
(map! [ni] "<C-k>" "telescope.actions.move_selection_previous")

;; Save cursor position
(vim.api.nvim_create_autocmd
  :BufReadPost
  {:pattern :*
   :group (vim.api.nvim_create_augroup :LastPosition {:clear true})
   :callback #(vim.cmd "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif")})

;; Highlight when yanking
(vim.api.nvim_create_autocmd
  :TextYankPost
  {:group (vim.api.nvim_create_augroup :yank_highlight {})
   :pattern :*
   :callback 
   (fn [] (vim.highlight.on_yank {:higroup :IncSearch :timeout 300}))})

;; Window navigation...
(map! [n] "<C-h>" "<C-w>h")
(map! [n] "<C-j>" "<C-w>j")
(map! [n] "<C-k>" "<C-w>k")
(map! [n] "<C-l>" "<C-w>l")

;; Window resizing
(map! [n] "<A-l>" ":vertical resize -5<cr>")
(map! [n] "<A-j>" ":resize -5<cr>")
(map! [n] "<A-k>" ":resize +5<cr>")
(map! [n] "<A-h>" ":vertical resize +5<cr>")
