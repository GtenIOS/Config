;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; evil leader (must be initialised before evil modee)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "e" 'find-file)
(evil-leader/set-key "o" 'Files)
(evil-leader/set-key "c" 'global-hl-line-mode)
(evil-leader/set-key "h" 'split-window-vertically)
(evil-leader/set-key "v" 'split-window-horizontally)

;; Enable Evil
(require 'evil)
(evil-mode 1)
(setq evil-want-fine-undo t)
(advice-add 'undo-auto--last-boundary-amalgamating-number
            :override #'ignore)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq mac-command-modifier 'super)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e1b843dd5b1c7b565c9e07e0ecb2fe02440abd139206bd238a2fc0a068b48f84" "d14f3df28603e9517eb8fb7518b662d653b25b26e83bd8e129acea042b774298" "30b14930bec4ada72f48417158155bc38dd35451e0f75b900febd355cda75c3e" default))
 '(display-line-numbers-type 'relative)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(evil-leader clues-theme evil-commentary all-the-icons-dired dired-sidebar all-the-icons git-gutter affe fzf flycheck yasnippet company lsp-ui lsp-mode rustic solarized-theme gruvbox-theme evil))
 '(toggle-scroll-bar nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Victor Mono"))))
 '(font-lock-comment-face ((t (:inherit default :slant italic :family "Victor Mono"))))
 '(font-lock-constant-face ((t (:slant italic :weight bold :family "Victor Mono"))))
 '(font-lock-function-name-face ((t (:slant italic :weight bold :family "Victor Mono"))))
 '(font-lock-keyword-face ((t (:slant italic :weight bold :family "Victor Mono"))))
 '(font-lock-preprocessor-face ((t (:weight bold :family "Victor Mono"))))
 '(font-lock-string-face ((t (:slant italic :family "Victor Mono"))))
 '(hl-todo ((t (:slant italic :weight bold :family "Victor Mono"))))
 '(info-colors-lisp-code-block ((t (:inherit font-lock-variable-name-face))))
 '(markdown-code-face ((t (:inherit font-lock-constant-face)))))

;; Solarized theme
;;(load-theme 'solarized-light t)
;; (load-theme 'gruvbox-dark-soft t)
(load-theme 'classic t)

;; Rust
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last))
  (:map company-mode-map
	("<tab>". tab-indent-or-complete)
	("TAB". tab-indent-or-complete)))

(defun company-yasnippet-or-completion ()
  (interactive)
  (or (do-yas-expand)
      (company-complete-common)))

(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "::") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas/minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package flycheck :ensure)

;; fzf
(use-package fzf :ensure)
;; (defalias 'Files 'fzf-find-file)

;; Back up files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; File finder
(use-package affe
  :config
  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key (kbd "M-.")))

;; -*- lexical-binding: t -*-
(defun affe-orderless-regexp-compiler (input _type)
  (setq input (orderless-pattern-compiler input))
  (cons input (lambda (str) (orderless--highlight input str))))
(setq affe-regexp-compiler #'affe-orderless-regexp-compiler)

;;Exit insert mode by pressing j and then k quickly
(use-package key-chord :ensure
  :config
  (setq key-chord-two-keys-delay 0.2)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))

;; Sidebar
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'all-the-icons-dired)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package all-the-icons-dired :ensure)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(evil-commentary-mode)

;; Shit + Arrow to navigate to windows
(windmove-default-keybindings)

;; Set current working directory
(defvar cwd)

(defun set-cwd (dirname &optional switches)
  "Sets a \"default\" directory for `my-find-file', interactive
  code taken from `dired' command."
  (interactive (dired-read-dir-and-switches ""))
  (setq cwd dirname))

(defun Files ()
  "Emulates a \"default\" directory style like vim, see `my-cd'."
  (interactive)
  (if (boundp 'cwd)
   	  (progn 
		  (cd cwd)
		  (call-interactively 'fzf-find-file))
      (progn 
	      (call-interactively 'set-cwd)
		  (cd cwd)
		  (call-interactively 'fzf-find-file))))
