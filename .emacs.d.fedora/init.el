
;;; -*- lexical-binding: t -*-
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ;; ("org" . "https://orgmode.org/elpa/")
                         ))
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents) ; Update package list
  (package-install 'use-package))

;; Configure use-package to always install packages if they are missing
(setq use-package-always-ensure t)

;; --------------------------------------
;; Basic UI Configuration
;; --------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-line-numbers-type 'relative)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(cmake-mode company consult d-mode evil-collection ligature
		lsp-sourcekit lsp-ui marginalia naysayer-theme
		orderless swift-mode treesit-auto vertico))
 '(tool-bar-mode nil))

;; Enable column number display in the mode-line
;; This shows the current column number, usually prefixed with C:
(column-number-mode 1)

;; Enable line numbers globally in the margin (fringe)
;; This uses the modern, built-in display-line-numbers-mode
(global-display-line-numbers-mode 1)

(setq display-line-numbers-type 'relative) ; Show relative line numbers

;; Disable unwanted graphical UI elements
(scroll-bar-mode -1)   ; Disable the scroll bar
(tool-bar-mode -1)     ; Disable the tool bar (row of icons)
(tooltip-mode -1)      ; Disable tooltips (pop-up help text on hover)

;; Optional: If you also want to disable the menu bar (File, Edit, etc.)
(menu-bar-mode -1)

;; --------------------------------------
;; Indentation
;; --------------------------------------
; (setq tab-stop-list (number-sequence 4 200 4))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq standard-indent 4)
(setq indent-line-function 'insert-tab)

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Set the basic indentation offset for C-like modes
            (setq c-basic-offset 4)
            ;; Optionally, ensure spaces are used within this mode too
            ;; (useful if some other package tries to change it)
            (setq indent-tabs-mode nil)))

;; --------------------------------------
;; Ligature support
;; --------------------------------------
(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;; --------------------------------------
;; Backup and Autosave Configuration
;; --------------------------------------

;; --- Backup Configuration ---

;; Define the central directory for backups
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))
      ;; This line sets backups for all files (matched by ".")
      ;; to go into a subdirectory named "backups" inside your emacs configuration directory
      ;; (e.g., ~/.emacs.d/backups/ or ~/.config/emacs/backups/).

;; Ensure the backup directory exists (optional, but good practice)
;; Emacs usually creates it, but doing it explicitly avoids potential issues.
(make-directory (cdr (assoc "." backup-directory-alist)) t)

;; Make backups of files (~ files)
(setq make-backup-files t)

;; Use numbered version backups (file.~1~, file.~2~, etc.) instead of file~
(setq version-control t)

;; Keep a reasonable number of backups
(setq kept-new-versions 5)  ; Keep the 5 newest versions
(setq kept-old-versions 5)  ; Keep the 5 oldest versions (when cleaning up)

;; Don't delete old versions automatically when saving
;; Set to t if you want Emacs to prune older versions beyond the kept counts on each save
(setq delete-old-versions nil) ; Set to t to automatically prune

;; How backups are made: Copying is safer, especially on modern filesystems or with links.
(setq backup-by-copying t)


;; --- Auto-Save Configuration (#file# files) ---

;; **Option 1: Centralize Auto-Save Files (Recommended)**
;; Store auto-save files (#file#) in a central directory too.
;; This preserves crash recovery ability without cluttering working directories.
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-saves/" user-emacs-directory) t)))
      ;; This directs autosaves for all files to a subdirectory named "auto-saves"
      ;; inside your emacs configuration directory.

;; Ensure the auto-save directory exists
(make-directory (cadr (assoc ".*" auto-save-file-name-transforms)) t)

;; Ensure auto-save is enabled (it usually is by default)
(setq auto-save-default t)
;; Set the interval (optional, default is 300 changes or 30 seconds idle)
;; (setq auto-save-interval 200) ; Autosave after 200 characters typed
;; (setq auto-save-timeout 20)   ; Autosave after 20 seconds idle


;; **Option 2: Disable Auto-Save Files (Not Recommended)**
;; Uncomment the following line INSTEAD of Option 1 if you REALLY want to disable them.
;; WARNING: This means you cannot recover unsaved work if Emacs crashes!
;; (setq auto-save-default nil)


;; --- Lockfile Configuration (.#file files) ---
;; These are distinct from #autosave# files. They prevent concurrent editing.
;; While not explicitly requested, some users like to disable these too,
;; especially on unreliable network drives. Disabling is generally NOT recommended
;; unless you understand the risks.
;; (setq create-lockfiles nil)

;; --------------------------------------
;; Essential Packages
;; --------------------------------------

;; --- Evil Mode (Vi(m) emulation) ---
(use-package evil
  :ensure t
  :init
  ;; Some recommended settings for better integration
  (setq evil-want-integration t) ;; Integrate with various Emacs modes
  (setq evil-want-keybinding nil) ;; Don't install global C- and M- bindings
  :config
  ;; Enable Evil mode globally
  (evil-mode 1)
  ;; Optional: You might want evil-collection later for even better integration
  ;; with packages like Magit, Company, etc. You'd add:
  (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))
  )

;; --- Company Mode (Completion Framework) ---
(use-package company
  :ensure t
  :after evil ;; Load after evil if you want evil-collection integration later
  :hook (after-init . global-company-mode) ;; Enable globally after init
  ;; Alternatively, enable only in specific modes:
  ;; :hook ((prog-mode . company-mode)
  ;;        (text-mode . company-mode))
  :bind (:map company-active-map
         ("C-n". company-select-next)
         ("C-p". company-select-previous)
         ("M-<". company-select-first)
         ("M->". company-select-last))
  :config
  ;; Configure Company behavior
  (setq company-minimum-prefix-length 1) ;; Start completing after 1 character
  (setq company-idle-delay 0.2)         ;; Wait 0.2 seconds before auto-completing
  ;; Optional: Enable tooltips for documentation
  ;; (setq company-tooltip-align-annotations t)
  ;; (setq company-format-margin-function #'company-marginalia-format-margin) ; Requires marginalia package

  ;; Optional: If using evil, evil-collection provides better keybindings.
  ;; If not using evil-collection, you might want manual bindings like:
  ;; (with-eval-after-load 'evil
  ;;    (define-key evil-insert-state-map (kbd "C-SPC") #'company-complete))
  )

;; --- LSP Mode (Language Server Protocol support) ---
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred) ;; Define commands that trigger loading
  :hook ((prog-mode . lsp-deferred)) ;; Automatically start LSP in programming modes
  :init
  ;; Optional: Set preferences BEFORE lsp-mode loads
  ;; Example: Use `pylsp` instead of `pyright` for Python
  ;; (setq lsp-python-ms-python-executable "pylsp")
  ;; Example: Disable LSP logging unless debugging
  (setq lsp-log-io nil)
  :config
  ;; Optional: Set keymap prefix (useful with which-key)
  (setq lsp-keymap-prefix "C-c l") ;; Or "s-l" (Super key), etc.

  ;; Recommended: Enable LSP semantic highlighting (needs theme support)
  (setq lsp-semantic-tokens-enable t)

  ;; --- IMPORTANT ---
  ;; You need to install language servers EXTERNALLY for LSP to work!
  ;; Examples:
  ;; - Python: pip install 'python-lsp-server[all]'
  ;; - Go: go install golang.org/x/tools/gopls@latest
  ;; - Rust: rustup component add rust-analyzer
  ;; - Typescript: npm install -g typescript-language-server typescript
  ;; Check lsp-mode documentation or M-x lsp-install-server for more.
  )

;; Optional but highly recommended UI companion for LSP
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after lsp-mode ;; Ensure lsp-mode is loaded first
  :config
  ;; Configure lsp-ui features (enable/disable as needed)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-flycheck-enable t) ;; Show diagnostics via Flycheck/Flymake
  (setq lsp-ui-imenu-enable t)
  (setq lsp-headerline-breadcrumb-enable t)
  ;; Call lsp-ui-mode when lsp-mode starts
  (add-hook 'lsp-mode-hook #'lsp-ui-mode))

;; Optional: Needed by lsp-ui flycheck integration (or use built-in flymake)
;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))

;; Optional: Link company and lsp
;; lsp-mode usually configures company automatically if company is loaded.
;; If completion isn't working, you might explicitly add company-lsp:
;; (use-package company-lsp
;;   :ensure t
;;   :after (company lsp-mode)
;;   :config
;;   (push 'company-lsp company-backends)) ;; Add lsp backend to company

;; --- LSP servers ---
(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/home/jiten/Git/swift/usr/bin/sourcekit-lsp"))

;; ------------------------
;; DLang (serve-d)
;; ------------------------
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(d-mode . "d"))
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "/home/jiten/Git/serve-d/serve-d")
                     :activation-fn (lsp-activate-on "d")
                     :server-id '/home/jiten/Git/serve-d/serve-d)))

;; Load sourcekit-lsp on swift file
(use-package swift-mode
  :hook (swift-mode . (lambda () (lsp))))

;; Load c++ mode for `.cppm` files
(add-to-list 'auto-mode-alist '("\\.cppm\\'" . c++-mode))

;; --- Theme ---
;; Load the theme last, or at least after font settings
(use-package naysayer-theme
  :ensure t
  :config
  ;; Load the theme. The 't' suppresses the confirmation prompt.
  (load-theme 'naysayer t))

;; --- Vertico/Consult for Fuzzy Completion ---

;; Vertico: Vertical Completion UI
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  ;; Optional: More vertico config
  ;; (setq vertico-cycle t) ; Cycle through candidates
  )

;; Consult: Useful commands, including find-file alternative
(use-package consult
  :ensure t
  :bind (;; Override C-x C-f with consult-find or consult-file
         ;; consult-find searches using find command (can be slow on large dirs)
         ;; consult-file uses Emacs's built-in file listing (faster for local)
         ;; Choose one:
         ; ("C-x C-f" . consult-file)
         ("C-x C-f" . consult-find)

         ;; Other useful consult bindings:
         ;; ("M-x" . consult-M-x)
         ("C-x b" . consult-buffer)      ; Filter buffers, previews
         ("C-c s" . consult-ripgrep)   ; Needs ripgrep installed
         ("C-c j" . consult-imenu)
         ("<search>" . consult-line)      ; Search current buffer lines
         )
  :config
  ;; Optional configuration for consult-file
  ;; (setq consult-file-show-hidden t)
  )

;; Orderless: Advanced completion style for fuzzy/flex matching
(use-package orderless
  :ensure t
  :init
  ;; Configure orderless completion style
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))

;; Marginalia: Annotations in the minibuffer (highly recommended with Vertico)
(use-package marginalia
  :ensure t
  :after vertico ; Ensure vertico is loaded first if setting variables
  ;; Or:
  ;; :bind (:map minibuffer-local-map
  ;;       ("M-A" . marginalia-cycle)) ; If you want a keybinding
  :init
  (marginalia-mode 1))

;; Treesitter
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrainsMono Nerd Font Mono" :foundry "JB" :slant normal :weight regular :height 143 :width normal)))))
