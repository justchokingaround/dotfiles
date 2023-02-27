;;; -*- lexical-binding: t; -*-
(setq user-full-name "chokerman"
      user-mail-address "ivanonarch@tutanota.com")
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dox/org/")

;; UI Setup
(setq default-frame-alist '((internal-border-width . 10)))
(setq initial-frame-alist default-frame-alist)
(setq doom-font (font-spec :family "Liga SFMono Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "Liga SFMono Nerd Font" :size 18)
      doom-big-font (font-spec :family "Liga SFMono Nerd Font" :size 24))

(setq global-auto-revert-non-file-buffers t
      x-stretch-cursor t
      hscroll-margin 8
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position 'always
      auto-window-vscroll nil
      fast-but-imprecise-scrolling nil
      scroll-margin 8)

(setq fancy-splash-image (expand-file-name "lain.png" doom-user-dir))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(assoc-delete-all "Open project" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)

(add-hook! '+doom-dashboard-mode-hook (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

(scroll-bar-mode -1)
(global-visual-line-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-auto-revert-mode 1)
(window-divider-mode 1)
(global-subword-mode 1)

;; (after! doom-modeline
;;   (setq doom-modeline-persp-name t))
(after! doom-modeline
  (setq display-time-string-forms
        '((propertize (concat " 🕘 " 24-hours ":" minutes))))
  (display-time-mode 1) ; Enable time in the mode-line

  (doom-modeline-def-modeline 'main
   '(bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
   '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker "   ")))

(setq global-auto-revert-non-file-buffers t
      auto-save-default t
      x-stretch-cursor t
      hscroll-margin 8
      scroll-margin 8)

;; Org Mode Setup
(setq org-agenda-files (expand-file-name "agenda.org" org-directory)
      org-ellipsis " ▼ "
      org-src-tab-acts-natively t
      org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆"))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0)))))

(require 'org-auto-tangle)

(add-hook 'org-mode-hook 'org-auto-tangle-mode)
(add-hook 'org-mode-hook 'parinfer-rust-mode)

;; Quality of life setup
(setq confirm-kill-emacs nil)

(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

;; Completion setup
(setq which-key-idle-delay 0.4
     which-key-idle-secondary-delay 0.05)

(after! marginalia
  (setq marginalia-align 'right
        marginalia-align-offset -1))

(after! company
  (setq company-idle-delay 0.2
        company-tooltip-limit 10
        company-box-enable-icon nil
        company-box-doc-enable t
        company-tooltip-minimum-width 40))

(setq company-global-modes
      '(not org-mode))

(after! vertico
  (setq vertico-count 10))

(after! lsp-mode
  (setq lsp-idle-delay 0.1
        lsp-log-io nil
        lsp-enable-symbol-highlighting t
        lsp-headerline-breadcrumb-enable nil))

(require 'elcord)
(setq elcord-quiet t
      elcord-client-id "901554978374688778"
      elcord-idle-message "Idle"
      elcord-idle-timer 180
      elcord-refresh-rate 10
      elcord--editor-name "Emacs"
      elcord-editor-icon "emacs_papirus_icon"
      elcord-display-buffer-details nil)
;; (elcord-mode)

(add-hook 'sh-mode-hook 'flymake-shellcheck-load)

(defun my-tab ()
  (interactive)
  (or (copilot-accept-completion)
      (company-indent-or-complete-common nil)))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map company-active-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)
         :map company-mode-map
         ("<tab>" . 'my-tab)
         ("TAB" . 'my-tab)))

(map! :leader
      :desc "Save file" "w" #'save-buffer)
(map! :i "C-s" #'save-buffer
      :desc "Save file" "C-s" #'save-buffer)
(map! :n "C-s" #'save-buffer
      :desc "Save file" "C-s" #'save-buffer)

(map! :map evil-normal-state-map
      "C-a" #'evil-numbers/inc-at-pt
      "C-x" #'evil-numbers/dec-at-pt)

;; custom theme
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.doom.d/themes")
(load-theme 'doom-horizon)
