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
                  (font-spec :family "Noto Sans Mono CJK JP"))
(set-fontset-font nil 'katakana-jisx0201
                  (font-spec :family "Noto Sans Mono CJK JP"))


;;; Encoding

(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)


;;;

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


;;; Unbind global keys

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))


;;; Global text edit settings

(keyboard-translate ?\C-h ?\C-?)
(show-paren-mode t)
(global-hl-line-mode)
(global-display-line-numbers-mode)
(electric-pair-mode)
(setq-default scroll-conservatively 1)
(setq-default scroll-margin 2)
(setq-default scroll-preserve-screen-position t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)


;;; Packages

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

(use-package ddskk
  :ensure t
  :bind ("C-x C-j" . skk-mode)
  :custom
  (skk-user-directory "~/.ddskk")
  (skk-jisyo-code 'utf-8)
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

(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-org-config)
  (use-package doom-modeline
    :ensure t
    :hook (after-init . doom-modeline-mode)))

(use-package hide-mode-line
  :ensure t
  :hook
  ((neotree-mode imenu-list-minor-mode) . hide-mode-line-mode))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package neotree
  :ensure t
  :custom
  (neo-show-hidden-files t)
  (neo-theme 'icons))

(use-package which-key
  :ensure t
  :hook (after-init . which-key-mode))

(use-package nyan-mode
  :ensure t
  :custom
  (nyan-animate-nyancat t)
  :hook
  (doom-modeline-mode . nyan-mode))

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
  (git-gutter:modified ((t (:background "#f1fa8c"))))
  (git-gutter:added    ((t (:background "#50fa7b"))))
  (git-gutter:deleted  ((t (:background "#ff79c6"))))
  :config
  (global-git-gutter-mode +1))

(use-package evil
  :ensure t
  :custom
  (evil-undo-system 'undo-fu)
  (evil-want-C-u-scroll t)
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
      "t" 'neotree-toggle
      "ll" 'my/flycheck-list-errors-toggle
      "ln" 'flycheck-next-error
      "lp" 'flycheck-previous-error
      "ci" 'evilnc-comment-or-uncomment-lines
      "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
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
  (key-chord-define evil-normal-state-map "gd" 'lsp-ui-peek-find-definitions)
  (key-chord-define evil-normal-state-map "gt" 'lsp-find-type-definition)
  (key-chord-define evil-normal-state-map "gr" 'lsp-ui-peek-find-references)
  (key-chord-define evil-normal-state-map "gi" 'lsp-ui-peek-find-implementation))

(use-package ivy
  :ensure t
  :custom
  (ivy-use-virtual-buffers t)
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
    :bind ("C-s" . swiper))
  (use-package counsel
    :ensure t
    :bind (("M-x" . counsel-M-x)
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
(reformatter-define terraform-format
                    :program "terraform"
                    :args '("fmt" "-no-color" "--check=true" "-")
                    :group 'terraform
                    :lighter "TfFmt")

(use-package lsp-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
         (python-mode . lsp-deferred)
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
  :config
  (use-package lsp-ui
    :ensure t
    :custom
    (lsp-ui-doc-enable nil)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-doc-use-webkit nil)
    (lsp-ui-doc-border nil)
    (lsp-ui-doc-position 'top)
    (lsp-ui-doc-max-width 160)
    (lsp-ui-doc-max-height 160)
    (lsp-ui-sideline-enable t)
    (lsp-ui-sideline-update-mode 'line)
    (lsp-ui-imenu-enable nil)
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-fontify 'on-demand)
    :hook
    (lsp-mode . lsp-ui-mode)))

(use-package company
  :ensure t
  :bind (("C-SPC" . company-complete)
	     :map company-active-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     ("<tab>" . company-complete-selection)
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
    (company-box-backends-colors nil)
    (company-box-show-single-candidate t)
    (company-box-doc-enable t)))

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook (go-mode . go-format-on-save-mode)
  :config
  (use-package gotest
    :ensure t
    :bind (:map go-mode-map
                ("C-c C-n" . go-run)
                ("C-c ."   . go-test-current-test)
                ("C-c f"   . go-test-current-file)
                ("C-c a"   . go-test-current-project))))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :custom
  (lsp-pyright-venv-path ".venv"))

(use-package terraform-mode
  :ensure t
  :mode "\\.tf\\'"
  :hook (terraform-mode . terraform-format-on-save-mode))

(provide 'init)

;;; init.el ends here
