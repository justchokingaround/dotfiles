;;; -*- lexical-binding: t; -*-
(setq user-full-name "chomsky"
      user-mail-address "ivanonarch@tutanota.com")
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/dox/org/")

;; UI Setup
;; Customize the hl-line face
(custom-set-faces
 '(hl-line ((t (:background "gray20" :underline nil)))))

(setq doom-font (font-spec :family "Liga SFMono Nerd Font" :size 20)
      doom-big-font (font-spec :family "Liga SFMono Nerd Font" :size 24)
      doom-variable-pitch-font (font-spec :family "Liga SFMono Nerd Font" :size 20)
      doom-serif-font (font-spec :family "Liga SFMono Nerd Font" :size 20 :weight 'medium))
(require 'whitespace)
(setq whitespace-line-column 99)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; padding
(setq-default left-margin-width 5 right-margin-width 5)
(set-window-buffer nil (current-buffer))
(modify-frame-parameters nil '((internal-border-width . 20)))

;; bar
(setq-default frame-title-format nil)
(tab-bar-mode 1)
(global-tab-line-mode -1)
(tab-line-mode -1)

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 101
  scroll-preserve-screen-position 1)

(setq fancy-splash-image (expand-file-name "lain.png" doom-user-dir))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(assoc-delete-all "Open project" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
(assoc-delete-all "Recently opened files" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)

(add-hook! '+doom-dashboard-mode-hook (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))

(scroll-bar-mode -1)

(setq global-auto-revert-non-file-buffers t
      auto-save-default t
      x-stretch-cursor t
      hscroll-margin 8
      scroll-margin 8)

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

;; Disable automatic workspace creation
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

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
;; (setq custom-safe-themes t)
;; (add-to-list 'custom-theme-load-path "~/.doom.d/themes")
(load-theme 'doom-horizon t)
