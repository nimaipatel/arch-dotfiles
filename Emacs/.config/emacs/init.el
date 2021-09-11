(setq native-comp-async-report-warnings-errors nil)

(setq gc-cons-threshold (* 50 1000 1000))

(defun np/display-startup-time ()
  (message "emacs loaded in %s with %d garbage collections."
    (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
      gcs-done))

(add-hook 'emacs-startup-hook #'np/display-startup-time)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(defun np/x-get-resource-live (name)
  "Read the name of a xresources variable from output of `xrdb -q`.
  This function doesn't cache old values like x-get-resource
  and instead searches the database again."
  (shell-command-to-string
(format "xrdb -q | grep '\*%s' | sed 's/^\*font://g ; s/^[ \t]*//;s/[ \t]*$//'" name)))

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")

(defun np/set-colors ()
  "Load colors from generated theme"
  (interactive)
  (load-theme 'base16-generated t))
(np/set-colors)

(defun np/get-x-font ()
  (shell-command-to-string
    "printf %s \"$(xrdb -q | grep '\*font:' | cut -d: -f2 | sed 's/^\t//g')\""))

(defun np/set-font ()
  (set-face-attribute 'default nil
                      :height 135
                      :font "Nimaiosevka Sans")

  (set-face-attribute 'fixed-pitch nil
                      :height 135
                      :font "Nimaiosevka Sans")

  (set-face-attribute 'variable-pitch nil
                      :height 135
                      :font "Nimaiosevka Aile"))
(np/set-font)

(if (daemonp)
  (add-hook 'after-make-frame-functions
    (lambda (frame)
      (with-selected-frame frame
        (np/set-font)))))

(defun np/set-colors-and-font ()
  (interactive)
  (np/set-colors)
  (np/set-font))

(define-key special-event-map [sigusr1] 'np/set-colors-and-font)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package all-the-icons)

(use-package all-the-icons-ivy-rich
  :init(all-the-icons-ivy-rich-mode))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package doom-modeline
  :init (doom-modeline-mode)
  :custom ((doom-modeline-height 15)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package man
  :config
  (set-face-attribute 'Man-overstrike nil :inherit font-lock-type-face :bold t)
  (set-face-attribute 'Man-underline nil :inherit font-lock-keyword-face :underline t))

(use-package frames-only-mode
  :init (frames-only-mode))

(setq blink-cursor-blinks 0)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(setq visible-bell nil)

(setq inhibit-startup-message t
      inhibit-startup-screen  t
      initial-scratch-message nil)

(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

(column-number-mode)

(use-package general
  :after evil
  :config (general-create-definer np/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC"))

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding  nil
        evil-want-C-u-scroll  t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-args
  :config
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
  (define-key evil-normal-state-map "]a" 'evil-forward-arg)
  (define-key evil-normal-state-map "[a" 'evil-backward-arg))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-goggles
  :config
  (evil-goggles-mode))

(use-package evil-nerd-commenter
  :init
  (setq evilnc-comment-text-object "c")
  (evilnc-default-hotkeys)
  :bind ("M-:" . evilnc-comment-or-uncomment-lines))

(use-package hydra
  :defer t)

(defhydra np/window-resize-hydra ()
  "Hydra to change window size using vi-like bindings"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)
  ("q" nil))

(np/leader-keys
  "r" '(np/window-resize-hydra/body :which-key "Resize Windows"))

(defhydra np/diagnostics-cycle ()
  "Cycle through diagnostics"
  ("n" next-error)
  ("j" next-error)
  ("p" previous-error)
  ("k" previous-error)
  ("q" nil))

(np/leader-keys
  "d" '(np/diagnostics-cycle/body :which-key "Cycle through diagnostics"))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
  :map ivy-minibuffer-map
  ("TAB" . ivy-alt-done)
  ("C-l" . ivy-alt-done)
  ("C-j" . ivy-next-line)
  ("C-k" . ivy-previous-line)
  :map ivy-switch-buffer-map
  ("C-k" . ivy-previous-line)
  ("C-l" . ivy-done)
  ("C-d" . ivy-switch-buffer-kill)
  :map ivy-reverse-i-search-map
  ("C-k" . ivy-previous-line)
  ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode))

(use-package ivy-rich
  :init (ivy-rich-mode))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  (prescient-persist-mode)
  (ivy-prescient-mode))

(use-package counsel
  :bind
  (:map minibuffer-local-map ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/dev")
  (setq projectile-project-search-path '("~/dev")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status)

(use-package yasnippet
  :init
  (setq yas-verbosity 2)
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package smartparens
  :hook
  (prog-mode . smartparens-mode))

(use-package lsp-mode
  :init (setq lsp-completion-provider :none)
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . np/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
    :after lsp)

(use-package lsp-ivy
    :after lsp)

(use-package company
  :init
  (setq company-backends
   '((company-capf :with company-yasnippet)
     (company-files :with company-yasnippet)))
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
    ("<tab>" . company-complete-selection))
   (:map lsp-mode-map
    ("C-SPC" . company-complete)
    ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (setq company-idle-delay nil))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package format-all
  :hook
  (prog-mode . format-all-mode))

(use-package typescript-mode
  :mode ("\\.js\\'" "\\.jsx\\'" "\\.ts\\'" "\\.tsx\\'")
  :hook (typescript-mode . lsp-deferred))

(use-package haskell-mode
  :mode ("\\.hs\\'")
  :hook (haskell-mode . lsp-deferred))

(use-package lsp-haskell
  :hook (haskell-mode . lsp-deferred))

(use-package dart-mode
  :hook (dart-mode . flutter-test-mode))

(use-package lsp-dart
  :hook (dart-mode . lsp-deferred))

(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload)))

(use-package flutter-l10n-flycheck
  :after flutter
  :config
  (flutter-l10n-flycheck-setup))

(use-package ccls
  :hook
  (c-mode . lsp-deferred)
  (c++-mode . lsp-deferred)
  (objc-mode . lsp-deferred))

(use-package python-mode
  :mode ("\\.py\\'")
  :hook (python-mode . lsp-deferred))

(use-package pipenv
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))

(use-package sh-mode
  :ensure nil
  :hook
  (sh-mode . lsp-deferred)
  (sh-mode . flycheck-mode))

(use-package html-mode
  :ensure nil
  :hook
  (html-mode . lsp-deferred))

(use-package css-mode
  :ensure nil
  :hook
  (css-mode . lsp-deferred))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

;; (use-package multi-vterm
;;   :after vterm)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-open
  :after dired
  :config
  (setq dired-open-extensions '(("png"  . "sxiv")
                                ("jpg"  . "sxiv")
                                ("jpeg" . "sxiv")
                                ("mp4"  . "mpv")
                                ("mkv"  . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

(use-package dired-single
  :commands (dired dired-jump))

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(use-package no-littering)

(setq auto-save-file-name-transforms
  `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))
