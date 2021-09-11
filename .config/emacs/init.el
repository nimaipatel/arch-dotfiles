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
  (setq np/x-font (np/get-x-font))
  (set-face-attribute 'default nil
                      :height 110
                      :font np/x-font)

  (set-face-attribute 'fixed-pitch nil
                      :height 110
                      :font np/x-font)

  (set-face-attribute 'variable-pitch nil
                      :height 110
                      :font np/x-font))
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

(dolist (mode '(org-mode-hook
                shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package general
  :after evil
  :config (general-create-definer np/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")

(np/leader-keys
  "e" '(lambda () (interactive)
    (find-file (expand-file-name "~/.config/emacs/emacs.org")))))

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
  :custom ((projectile-completion-system 'ivy))
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
  (org-mode . smartparens-mode)
  (prog-mode . smartparens-mode))

(defun np/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

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
    ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

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

(defun np/org-mode-setup ()
  (evil-local-set-key 'motion "j" 'evil-next-visual-line)
  (evil-local-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-local-set-key 'motion "$" 'evil-end-of-visual-line)
  (evil-local-set-key 'motion "0" 'evil-beginning-of-visual-line)
  (evil-local-set-key 'motion "^" 'evil-first-non-blank-of-visual-line)
  (org-indent-mode)
  (visual-line-mode))

(use-package org
  :init
  (setq org-src-strip-leading-and-trailing-blank-lines t
        org-src-preserve-indentation t)
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . np/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t))

(defun np/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
   visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . np/org-mode-visual-fill))

(with-eval-after-load 'org
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((emacs-lisp . t)
      (python     . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(defun np/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda ()
  (add-hook 'after-save-hook #'np/org-babel-tangle-config)))

  (with-eval-after-load 'org
    (require 'org-tempo)
    (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
    (add-to-list 'org-structure-template-alist '("bash" . "src bash"))
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
    (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
    (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
    (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
    (add-to-list 'org-structure-template-alist '("json" . "src json"))
    (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package org-make-toc
  :after org
  :hook (org-mode . org-make-toc-mode))

(use-package elfeed
  :init (setq-default elfeed-search-filter "")
  :commands (elfeed)
  :bind ("C-x w" . elfeed))
  :config
  (load-file "~/.config/emacs/elfeed-urls.el")

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

(use-package multi-vterm
  :after vterm)

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
