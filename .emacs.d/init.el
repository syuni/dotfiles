;;; init.el --- my emacs configuration
;; Author: syuni
;;; Commentary:
;;
;;; Code:

;; ### site environments ###



;; ### package management ###

;;; initialize
(setq-default package-archives
              '(("gnu" . "http://elpa.gnu.org/packages/")
                ("melpa" . "http://melpa.org/packages/")
                ("org" . "http://orgmode.org/elpa/")))

;;; straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(package-initialize)

;;; use-package
(straight-use-package 'use-package)

;;; fallback
(setq-default straight-use-package-by-default t)

;;; manual path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")



;; ### general settings ###

;;; splash
(setq-default inhibit-startup-screen t)

;;; backupfiles
(setq-default make-backup-files nil)
(setq-default auto-save-default nil)

;;; scratch default message
(setq-default initial-scratch-message "")

;;; "yes or no" to "y or n"
(defalias 'yes-or-no-p 'y-or-n-p)

;;; ui visualization
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-frame-parameter (selected-frame) 'alpha '(90 . 50))
(add-to-list 'default-frame-alist '(alpha . (90 . 50)))

;;; unbind suspend frame
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;;; text editing
(show-paren-mode t)
(global-hl-line-mode)
(setq-default calendar-week-start-day 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)
(global-set-key (kbd "M-SPC") 'cycle-spacing)

;;; word wrap
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows t)
(add-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'markdown-mode-hook #'visual-line-mode)
(add-hook 'gfm-mode-hook #'visual-line-mode)

;;; fonts
(set-face-attribute 'default nil
                    :family "Monaco Nerd Font"
                    :height 140)
(set-fontset-font nil 'japanese-jisx0208
                  (font-spec :family "Osaka"))
(set-fontset-font nil 'katakana-jisx0201
                  (font-spec :family "Osaka"))
;;; delete backword char if hit `\C-h`
(keyboard-translate ?\C-h ?\C-?)

;;; window
(global-set-key (kbd "C-c |") 'split-window-horizontally)
(global-set-key (kbd "C-c -") 'split-window-vertically)
(global-set-key (kbd "C-c c") 'delete-window)
(global-set-key (kbd "C-c C") 'delete-other-windows)
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c l") 'windmove-right)

;;; org-mode
(setq org-startup-indented t)
(setq org-startup-folded 'content)
(setq org-startup-with-inline-images t)
(setq org-indent-mode-turns-on-hiding-stars nil)
(setq org-indent-indentation-per-level 4)
(setq org-directory "~/Dropbox/org/")
(setq org-default-notes-file "notes.org")
(setq org-startup-folded 'content)
(global-set-key (kbd "C-c q") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-capture-templates
      '(("g" "GTD" entry
         (file+headline "~/Dropbox/org/gtd.org" "Inbox")
         "* TODO %?\n")
        ("n" "Note" entry
         (file+headline "~/Dropbox/org/notes.org" "Notes")
         "* %U\n%i%?\n")))
(setq org-agenda-files (list org-directory))
(setq org-agenda-todo-ignore-with-date t)
(setq org-agenda-start-on-weekday nil)
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c@)")))
(defun show-org-buffer (file)
  "Show an org-file FILE on the current buffer."
  (interactive)
  (if (get-buffer file)
      (let ((buffer (get-buffer file)))
        (switch-to-buffer buffer)
        (message "%s" file))
    (find-file (concat "~/Dropbox/org/" file))))
(global-set-key (kbd "C-M-^") '(lambda () (interactive)
                                 (show-org-buffer "notes.org")))
(global-set-key (kbd "C-M-&") '(lambda () (interactive)
                                 (show-org-buffer "gtd.org")))



;; ### packages ###

;;; exec path
(use-package exec-path-from-shell
  :ensure t
  :init
  (setq exec-path-from-shell-shell-name "/bin/bash")
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs '("GOROOT" "GOPATH"))))

;;; yasnippet
(use-package yasnippet
  :ensure t
  :init
  (setq yas-snippet-dirs '("~/Dropbox/snippets"))
  :config
  (bind-key "C-x y n" 'yas-new-snippet yas-minor-mode-map)
  (bind-key "C-x y v" 'yas-visit-snippet-file yas-minor-mode-map)
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t)
(use-package ivy-yasnippet
  :ensure t
  :config
  (bind-key "C-x y i" 'ivy-yasnippet))

;;; icons
(use-package all-the-icons
  :ensure t)

;;; color theme
(use-package zerodark-theme
  :ensure t
  :config
  (load-theme 'zerodark t)
  (zerodark-setup-modeline-format))

;;; ace-window
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (global-set-key (kbd "C-M-o") 'ace-swap-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-dispatch-always t)
  (ace-window-display-mode))

;;; parrot
(use-package parrot
  :ensure t
  :config
  (bind-keys ("C-c p" . parrot-rotate-prev-word-at-point)
             ("C-c n" . parrot-rotate-next-word-at-point))
  (parrot-mode))

;;; nlinum
(use-package nlinum
  :ensure t
  :config
  (global-nlinum-mode t)
  (setq nlinum-format "%5d "))

;;; parentheses
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;;; ciel
(use-package ciel
  :ensure t
  :bind (("C-c i" . ciel-ci)
         ("C-c o" . ciel-co)
         ("C-c r s" . ciel-copy-to-register)))

;;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-_") 'redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-M-z") 'redo)

;;; gtags
(use-package counsel-gtags
  :ensure t
  :defer t
  :hook ((c-mode-common-hook . counsel-gtags-mode)
         (c++-mode-hook . counsel-gtags-mode))
  :bind (("M-t" . counsel-gtags-find-definition)
         ("M-r" . counsel-gtags-find-reference)
         ("M-s" . counsel-gtags-find-symbol)
         ("C-t" . counsel-gtags-go-backward)
         ("C-M-t" . counsel-gtags-go-forward)))
(use-package gxref
  :ensure t
  :config
  (add-to-list 'xref-backend-functions 'gxref-xref-backend))

;; smooth-scrolling
(use-package smooth-scrolling
  :ensure t
  :init
  (setq smooth-scroll-margin 2)
  :config
  (smooth-scrolling-mode))

;;; which-key
(use-package which-key
  :ensure t
  :config
  (which-key-setup-minibuffer)
  (which-key-mode))

;;; ivy/counsel
(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (counsel-mode 1)
  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-x C-r") 'counsel-recentf)
  (global-set-key (kbd "C-x b") 'counsel-switch-buffer)
  (global-set-key (kbd "C-x M-b") 'counsel-switch-buffer-other-window)
  (global-set-key (kbd "C-c f") 'counsel-fzf))
(use-package all-the-icons-ivy
  :ensure t
  :init
  (setq all-the-icons-ivy-file-commands
        '(counsel-fzf
          counsel-switch-buffer
          counsel-switch-buffer-other-window
          counsel-find-file
          counsel-file-jump
          counsel-recentf
          counsel-projectile-find-file
          counsel-projectile-find-dir))
  :config
  (all-the-icons-ivy-setup))

;;; avy
(use-package avy
  :ensure t)

;;; migemo
(use-package migemo
  :ensure t
  :init
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  :config
  (load-library "migemo")
  (migemo-init))

;;; avy-migemo
;; (use-package avy-migemo
;;   :ensure t
;;   :config
;;   (require 'avy-migemo-e.g.ivy)
;;   (require 'avy-migemo-e.g.swiper)
;;   (bind-key "C-M-;" 'avy-migemo-goto-char-timer)
;;   (avy-migemo-mode 1))

;;; ddskk
(use-package ddskk
  :ensure t
  :bind (("C-x j" . skk-mode))
  :hook (text-mode . (lambda ()
                       (skk-mode)
                       (skk-latin-mode-on)))
  :init
  (setq skk-user-directory "~/Dropbox/skk")
  (setq skk-server-host "localhost")
  (setq skk-server-portnum 1178)
  (setq skk-jisyo-code 'utf-8)
  (setq default-input-method "japanese-skk")
  (setq skk-show-candidates-always-pop-to-buffer t)
  (setq skk-dcomp-activate t)
  (setq skk-dcomp-multiple-activate 10)
  (setq skk-dcomp-multiple-rows 10)
  (setq skk-egg-like-newline t)
  (setq skk-delete-implies-kakutei nil)
  (setq skk-use-look t)
  (setq skk-auto-insert-paren t)
  (setq skk-henkan-strict-okuri-precedence t)
  (setq skk-isearch-start-mode 'latin)
  (setq skk-search-katakana 'jisx0201-kana)
  :config
  (bind-key "C-j" 'skk-kakutei minibuffer-local-map)
  (add-hook 'isearch-mode-hook 'skk-isearch-mode-setup)
  (add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup))
(require 'skk-study)
(require 'skk-hint)

;;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup)))

;;; editorconfig
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;;; fly-chek
(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

;;; company
(use-package company
  :ensure t
  :bind (("C-M-i" . company-complete)
	     :map company-active-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous)
	     ("<tab>" . company-complete-selection)
	     :map company-search-map
	     ("C-n" . company-select-next)
	     ("C-p" . company-select-previous))
  :init
  (setq company-transformers '(company-sort-by-backend-importance))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (setq completion-ignore-case t)
  :config
  (global-company-mode))

;;; python
(use-package jedi-core
  :ensure t
  :init
  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t)
  :hook (python-mode . jedi:setup))
(use-package company-jedi
  :ensure t
  :config
  (add-to-list 'company-backends 'company-jedi))
(use-package virtualenvwrapper
  :ensure t)
(use-package auto-virtualenvwrapper
  :ensure t
  :config
  (add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate))

;;; emacs ipython notebook
(use-package ein
  :ensure t)

;;; julia
(use-package julia-mode
  :ensure t)

;;; golang
(use-package go-mode
  :ensure t
  :init
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (setq gofmt-command "goimports")
  :mode ("\\.go$" . go-mode)
  :config
  (bind-keys :map go-mode-map
             ("M-." . godef-jump)
             ("M-," . pop-tag-mark))
  (add-hook 'before-save-hook 'gofmt-before-save))
(use-package go-guru
  :ensure t
  :config
  (go-guru-hl-identifier-mode))
(use-package go-eldoc
  :ensure t
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))
(use-package company-go
  :ensure t
  :config
  (setq company-go-show-annotation t)
  (add-to-list 'company-backends 'company-go))
(use-package flycheck-golangci-lint
  :ensure t
  :init
  (setq flycheck-golangci-lint-enable-all t)
  :hook (go-mode . flycheck-golangci-lint-setup))

;;; rust
(use-package rust-mode
  :ensure t
  :defer t
  :config
  (setq rust-format-on-save t))
(use-package racer
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode))
(use-package flycheck-rust
  :ensure t
  :init
  (add-hook 'rust-mode-hook
            '(lambda ()
               (flycheck-rust-setup)
               (flycheck-select-checker 'rust))))

;;; html/javascript
(use-package web-mode
  :ensure t
  :init
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  :mode "\\.html$")
(use-package rjsx-mode
  :ensure t
  :mode "\\.js$"
  :interpreter "node"
  :init
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq js-indent-level 2)
  (setq sgml-basic-offset 2)
  (setq js2-include-browser-externs nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (setq js2-highlight-external-variables nil)
  (setq js2-include-jslint-globals nil)
  (setq js2-strict-trailing-comma-warning nil)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-strict-inconsistent-return-warning nil))
(use-package js-auto-format-mode
  :ensure t
  :config
  (add-hook 'js-mode-hook #'js-auto-format-mode)
  (add-hook 'js2-mode-hook #'js-auto-format-mode))
(use-package add-node-modules-path
  :ensure t
  :config
  (add-hook 'js-mode-hook #'add-node-modules-path)
  (add-hook 'js2-mode-hook #'add-node-modules-path))
(use-package tern
  :ensure t
  :commands (tern-mode)
  :hook ((js2-mode . tern-mode)
         (web-mode . tern-mode))
  :config
  (setq tern-command '("tern" "--no-port-file")))
(use-package company-tern
  :ensure t
  :config
  (add-to-list 'company-backends 'company-tern))

;;; json
(use-package json-mode
  :ensure t
  :init
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  :mode ("\\.json$" . json-mode))

;;; yaml
(use-package yaml-mode
  :ensure t
  :init
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  :mode ("\\.ya?ml$" . yaml-mode))

;;; writeroom
(bind-key "M-\\" 'writeroom-mode text-mode-map)
(use-package writeroom-mode
  :ensure t
  :defer t
  :init
  (setq writeroom-width 120)
  (setq writeroom-mode-line t)
  (setq writeroom-restore-window-config t)
  (setq writeroom-mode-line t)
  (autoload 'writeroom-mode "writeroom-mode" nil t))

;;; vmd
(use-package vmd-mode
  :ensure t
  :defer t
  :init
  (autoload 'vmd-mode "vmd-mode" nil t))

;;; markdown
(use-package markdown-mode
  :ensure t
  :init
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  :mode (("README\\.md\\'" . gfm-mode)
	     ("\\.md\\'" . markdown-mode)
	     ("\\.markdown\\'" . markdown-mode))
  :config
  (bind-key "M-p" 'vmd-mode markdown-mode-map)
  (bind-key "M-p" 'vmd-mode gfm-mode-map)
  (bind-key "M-\\" 'writeroom-mode markdown-mode-map)
  (bind-key "M-\\" 'writeroom-mode gfm-mode-map))

;;; pandoc
(use-package ox-pandoc
  :ensure t
  :config
  ;; default options for all output formats
  (setq org-pandoc-options '((standalone . t)))
  ;; cancel above settings only for 'docx' format
  (setq org-pandoc-options-for-docx '((standalone . nil)))
  ;; special settings for beamer-pdf and latex-pdf exporters
  (setq org-pandoc-options-for-beamer-pdf '((pdf-engine . "xelatex")))
  (setq org-pandoc-options-for-latex-pdf '((pdf-engine . "xelatex"))))

;;; powershell
(use-package powershell
  :ensure t
  :defer t)

;;; terraform
(use-package terraform-mode
  :ensure t
  :config
  (use-package company-terraform
    :ensure t
    :config
    (company-terraform-init)))

;;; protocol buffers
(use-package protobuf-mode
  :ensure t
  :defer t)

;;; docker
(use-package dockerfile-mode
  :ensure t)



;; ### myfunctions ###

;;; temporary buffer
(defun create-temporary-buffer ()
  (interactive)
  (switch-to-buffer (generate-new-buffer "*temp*"))
  (setq buffer-offer-save nil))
(global-set-key (kbd "C-c t") 'create-temporary-buffer)

;;; recent directories
(defun bjm/ivy-dired-recent-dirs ()
  "Present a list of recently used directories and open the selected one in dired"
  (interactive)
  (let ((recent-dirs
         (delete-dups
          (mapcar (lambda (file)
                    (if (file-directory-p file) file (file-name-directory file)))
                  recentf-list))))

    (let ((dir (ivy-read "Directory: "
                         recent-dirs
                         :re-builder #'ivy--regex
                         :sort nil
                         :initial-input nil)))
      (dired dir))))
(global-set-key (kbd "C-x C-d") 'bjm/ivy-dired-recent-dirs)

;;; rainbow delimiters
(use-package cl-lib
  :ensure t)
(use-package color
  :ensure t)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
     (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;;; post configuration
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(put 'dired-find-alternate-file 'disabled nil)

(provide 'init)
;;; init.el ends here

