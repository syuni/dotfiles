;; init.el --- my emacs configuration
;; Author: syuni
;;; Commentary:
;;
;;; Code:


;;; Fonts

(set-face-attribute 'default nil
                    :family "Hack Nerd Font"
                    :height 120)
(set-fontset-font nil 'japanese-jisx0208
                  (font-spec :family "Rounded Mgen+ 1m"))
(set-fontset-font nil 'katakana-jisx0201
                  (font-spec :family "Rounded Mgen+ 1m"))


;;; Encoding

(prefer-coding-system 'utf-8)


;;; Performance

(setq-default gc-cons-threshold 100000000)
(setq-default read-process-output-max (* 1024 1024))


;;; Startup

(setq-default inhibit-startup-screen t)
(setq-default initial-scratch-message "")


;;; Don't make backup files

(setq-default make-backup-files nil)
(setq-default auto-save-default nil)


;;; Custom file

(setq-default custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)


;;; Confirm

(defalias 'yes-or-no-p 'y-or-n-p)


;;; UI

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


;;; Global keys

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)


;;; Global text edit settings

(keyboard-translate ?\C-h ?\C-?)
(show-paren-mode t)
(global-hl-line-mode)
(global-display-line-numbers-mode)
(electric-pair-mode t)
(setq-default scroll-conservatively 1)
(setq-default scroll-margin 1)
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq truncate-lines t)
(setq truncate-partial-width-windows t)


;;; Packages

(let ((default-directory  "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(setq-default package-archives
              '(("gnu" . "http://elpa.gnu.org/packages/")
                ("melpa" . "http://melpa.org/packages/")
                ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package org
  :ensure nil
  :custom
  (org-directory "~/org/")
  (org-default-notes-file (concat org-directory "notes.org"))
  (org-startup-truncated nil)
  (org-src-fontify-natively t)
  (org-confirm-babel-evaluate nil)
  (org-clock-out-remove-zero-time-clocks t)
  (org-startup-indented t)
  (org-startup-folded 'content)
  :custom-face
  (org-document-title ((t (:height 1.5))))
  (org-level-1 ((t (:inherit outline-1 :height 1.3))))
  (org-level-2 ((t (:inherit outline-2 :height 1.2))))
  (org-level-3 ((t (:inherit outline-3 :height 1.1))))
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c l" . org-store-link)
   ("C-c o i" . org-clock-in)
   ("C-c o o" . org-clock-out)
   ("C-c o e" . org-set-effort)
   ("C-c o p" . org-pomodoro))
  :config
  (use-package org-bullets
    :ensure t
    :hook (org-mode . org-bullets-mode))
  (use-package org-pomodoro
    :ensure t
    :custom
    (org-pomodoro-ask-upon-killing t)
    (org-pomodoro-format " %s")
    (org-pomodoro-short-break-format " %s")
    (org-pomodoro-long-break-format  " %s")
    :custom-face
    (org-pomodoro-mode-line ((t (:foreground "#e06c75"))))
    (org-pomodoro-mode-line-break ((t (:foreground "#98c379"))))
    :hook
    (org-pomodoro-started . (lambda () (notifications-notify
                                        :app-name "org-pomodoro"
					:title "Let's focus for 25 minutes!")))
    (org-pomodoro-finished . (lambda () (notifications-notify
                                         :app-name "org-pomodoro"
					 :title "Well done! Take a break.")))))

(use-package ddskk
  :ensure t
  :bind ("C-x C-j" . skk-mode)
  :custom
  (skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")
  (skk-user-directory "~/.ddskk")
  (skk-isearch-start-mode 'latin)
  (skk-search-katakana 'jisx0201-kana)
  (skk-japanese-message-and-error nil)
  (skk-status-indicator nil)
  (skk-egg-like-newline t)
  (skk-auto-insert-paren t)
  (skk-henkan-strict-okuri-precedence t)
  :config
  (use-package skk-study)
  (use-package skk-hint))

(use-package smart-jump
  :ensure t
  :config
  (smart-jump-setup-default-registers))

(use-package evil
  :ensure t
  :custom
  (evil-want-keybinding nil)
  (evil-undo-system 'undo-fu)
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  (evil-move-beyond-eol t)
  :config
  (evil-mode 1)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "o") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "C-v") 'neotree-enter-vertical-split)
  (evil-define-key 'normal neotree-mode-map (kbd "C-x") 'neotree-enter-horizontal-split)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "R") 'neotree-refresh)
  (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
  (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
  (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "SPC")
    (evil-leader/set-key
      "ll" 'my/flycheck-list-errors-toggle
      "ln" 'flycheck-next-error
      "lp" 'flycheck-previous-error
      "cl" 'evilnc-comment-or-uncomment-lines
      "cp" 'evilnc-comment-or-uncomment-paragraphs
      "cr" 'comment-or-uncomment-region
      "h" 'lsp-ui-doc-show))
  (use-package evil-nerd-commenter
    :ensure t)
  (use-package undo-fu
    :ensure t)
  (use-package evil-surround
    :ensure t
    :config (global-evil-surround-mode 1))
  (use-package evil-matchit
    :ensure t
    :config (global-evil-matchit-mode 1)))

(use-package key-chord
  :ensure t
  :custom
  (key-chord-one-key-delay 0.3)
  (key-chord-two-keys-delay 0.3)
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-define evil-normal-state-map "gd" 'smart-jump-go)
  (key-chord-define evil-normal-state-map "gr" 'smart-jump-references))

(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  (doom-themes-neotree-file-icons t)
  :config
  (load-theme 'doom-one t)
  (doom-themes-neotree-config)
  (doom-themes-org-config)
  (use-package doom-modeline
    :ensure t
    :hook (after-init . doom-modeline-mode)))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package neotree
  :ensure t
  :bind ("C-q" . neotree-toggle)
  :custom
  (neo-show-hidden-files t))

(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode))

(use-package nyan-mode
  :ensure t
  :custom
  (nyan-animate-nyancat t)
  :config
  (nyan-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :ensure t
  :hook (after-init . rainbow-mode))

(use-package presentation
  :ensure t)

(use-package git-gutter
  :ensure t
  :custom
  (git-gutter:modified-sign " ")
  (git-gutter:added-sign    " ")
  (git-gutter:deleted-sign  " ")
  :custom-face
  (git-gutter:modified ((t (:background "#e5c07b"))))
  (git-gutter:added    ((t (:background "#98c379"))))
  (git-gutter:deleted  ((t (:background "#e06c75"))))
  :config
  (global-git-gutter-mode +1))

(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer))

(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character))

(use-package ace-window
  :ensure t
  :bind ("C-x o" . ace-window)
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :custom-face
  (aw-leading-char-face ((t (:inherit font-lock-keyword-face :bold t :height 3.0))))
  (aw-minibuffer-leading-char-face ((t (:inherit font-lock-keyword-face :bold t :height 2.0))))
  (aw-mode-line-face ((t (:inherit mode-line-emphasis :bold t)))))

(use-package anzu
  :ensure t
  :bind
  ("C-r" . anzu-query-replace-regexp)
  ("C-M-r" . anzu-query-replace-at-cursor-thing)
  :hook
  (after-init . global-anzu-mode))

(use-package ivy
  :ensure t
  :custom
  (ivy-initial-inputs-alist nil)
  (ivy-wrap t)
  (ivy-use-virtual-buffers nil)
  (enable-recursive-minibuffers t)
  :config
  (ivy-mode 1)
  (use-package all-the-icons-ivy-rich
    :ensure t
    :config (all-the-icons-ivy-rich-mode 1))
  (use-package ivy-rich
    :ensure t
    :config (ivy-rich-mode 1))
  (use-package swiper
    :ensure t
    :bind (("C-s" . swiper)
           ("C-M-s" . swiper-thing-at-point)))
  (use-package counsel-ghq
    :ensure nil
    :bind ("C-x g" . counsel-ghq))
  (use-package counsel
    :ensure t
    :bind (("M-x" . counsel-M-x)
           ("C-x b" . counsel-switch-buffer)
           ("C-x B" . counsel-switch-buffer-other-window)
           ("C-x C-f" . counsel-find-file)
           ("C-x C-r" . counsel-recentf))))

(use-package imenu-list
  :ensure t
  :bind ("C-'" . imenu-list-smart-toggle)
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize nil))

(use-package tree-sitter
  :ensure t
  :hook (after-init . global-tree-sitter-mode)
  :config
  (add-hook 'tree-sitter-after-on-hook 'tree-sitter-hl-mode)
  (use-package tree-sitter-langs
    :ensure t))

(use-package flycheck
  :ensure t
  :config
  (defun my/flycheck-list-errors-toggle ()
    (interactive)
    (let ((flycheck-errors-window (get-buffer-window flycheck-error-list-buffer)))
      (if (not (window-live-p flycheck-errors-window))
          (call-interactively 'flycheck-list-errors)
        (delete-window flycheck-errors-window))))
  (global-flycheck-mode))

(use-package reformatter
  :ensure t)

(reformatter-define go-format
  :program "goimports"
  :group 'go
  :lighter "GoFmt")
(reformatter-define python-black
  :program "black"
  :args '("-q" "-")
  :group 'python
  :lighter "PyBlack")
(reformatter-define python-isort
  :program "isort"
  :args '("-q" "-")
  :group 'python
  :lighter "PyIsort")
(reformatter-define rust-format
  :program "rustfmt"
  :group 'rust
  :lighter "RustFmt")
(reformatter-define terraform-format
  :program "terraform"
  :args '("fmt" "-no-color" "--check=true" "-")
  :group 'terraform
  :lighter "TfFmt")

(use-package lsp-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (rust-mode . lsp-deferred)
         (web-mode . lsp-deferred)
         (js2-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (terraform-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :custom
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  (lsp-completion-provider :capf)
  (lsp-enable-snippet nil)
  (lsp-auto-guess-root t)
  (lsp-response-timeout 10)
  (lsp-enable-indentation t)
  (lsp-enable-text-document-color t)
  (lsp-headerline-breadcrumb-enable t)
  (lsp-headerline-breadcrumb-segments '(project file symbols))
  (lsp-rust-clippy-preference 'on)
  :config
  (use-package lsp-ui
    :ensure t
    :custom
    (lsp-ui-doc-enable nil)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-doc-use-webkit t)
    (lsp-ui-doc-border nil)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-max-width 160)
    (lsp-ui-doc-max-height 160)
    (lsp-ui-sideline-enable t)
    (lsp-ui-sideline-update-mode 'line)
    (lsp-ui-imenu-enable nil)
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-fontify 'on-demand)
    :bind
    ("C-c C-d" . lsp-ui-peek-find-definitions)
    ("C-c C-r" . lsp-ui-peek-find-references)
    ("C-c C-i"   . lsp-ui-peek-find-implementation)
    :hook
    (lsp-mode . lsp-ui-mode)))

(use-package company
  :ensure t
  :bind (("C-SPC" . company-complete)
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("<return>" . company-complete-selection)
         ("<tab>" . company-complete-common-or-cycle)
         :map company-search-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :hook (after-init . global-company-mode)
  :custom
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (company-selection-wrap-around t)
  (completion-ignore-case t)
  :config
  (use-package company-box
    :ensure t
    :after (company all-the-icons)
    :hook ((company-mode . company-box-mode))
    :custom
    (company-box-icons-alist 'company-box-icons-all-the-icons)
    (company-box-scrollbar nil)
    (company-box-show-single-candidate t)
    (company-box-doc-enable t)
    (company-box-doc-delay 0.1)))

(use-package go-mode
  :ensure t
  :hook (go-mode . go-format-on-save-mode)
  :config
  (use-package gotest
    :ensure t
    :bind (:map go-mode-map
                ("C-c C-n" . go-run)
                ("C-c ."   . go-test-current-test)
                ("C-c f"   . go-test-current-file)
                ("C-c a"   . go-test-current-project))))

(use-package rust-mode
  :ensure t
  :hook (rust-mode . rust-format-on-save-mode)
  :bind (:map rust-mode-map
              ("C-c C-n" . rust-run)
              ("C-c ." . rust-test)))

(use-package auto-virtualenvwrapper
  :ensure t
  :hook (python-mode . auto-virtualenvwrapper-activate))

(use-package python-mode
  :ensure nil
  :hook ((python-mode . python-black-on-save-mode)
	 (python-mode . python-isort-on-save-mode)))

(use-package lsp-python-ms
  :ensure t
  :custom
  (lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp-deferred))))

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'"
         "\\.jsx\\'"
         "\\.tsx\\'"
         "\\.vue\\'"))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'")

(use-package terraform-mode
  :ensure t
  :mode "\\.tf\\'"
  :hook (terraform-mode . terraform-format-on-save-mode))

(provide 'init)

;;; init.el ends here
