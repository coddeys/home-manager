{ config, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-unstable;
    package = pkgs.emacs;
    extraConfig =  ''
  (package-initialize)
  (load-theme 'monokai t)
  (global-set-key (kbd "M-<tab>") 'dabbrev-expand)
  (define-key minibuffer-local-map (kbd "M-<tab>") 'dabbrev-expand)
  (setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (blink-cursor-mode 0)
  (global-hl-line-mode 1)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 8)
  (setq require-final-newline t)
  (global-so-long-mode 1)
  (global-auto-revert-mode t)
  (global-subword-mode t)
  (setq-default fill-column 80)
  (display-time-mode 1)
  (setq column-number-mode t)
  (setq default-input-method "russian-computer")
  (setq semantic-mode t)
  ;; don't kill emacs
  (defun dont-kill-emacs ()
    (interactive)
    (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))
  (global-set-key "\C-x\C-c" 'dont-kill-emacs)

  (diminish 'subword-mode)

  ;;EVIL-MODE
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (evil-mode 1)
  (when (require 'evil-collection nil t)
    (evil-collection-init))
  (setq evil-search-module 'evil-search)
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "s" 'save-buffer
  "2" 'split-window-below
  "3" 'split-window-right
  "0" 'delete-window
  "o" 'other-window
  "p" 'ace-window
  "x" 'counsel-M-x
  "a" 'align-regexp
  "g" 'magit-status)

  (which-key-mode)
  (add-hook 'after-init-hook 'global-company-mode)
  (yas-global-mode 1)

  ;; TYPESCRIPT
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
 
  ;; (cl-defmethod project-root ((project (head eglot-project)))
  ;;   (cdr project))
  ;; 
  ;; (defun my-project-try-tsconfig-json (dir)
  ;;   (when-let* ((found (locate-dominating-file dir "tsconfig.json")))
  ;;     (cons 'eglot-project found)))
  ;; 
  ;; (add-hook 'project-find-functions
  ;;           'my-project-try-tsconfig-json nil nil)
  
  (diminish 'apheleia-mode)
  (apheleia-global-mode +1)

  (setq magit-refresh-status-buffer nil)
  (global-set-key (kbd "C-c g") 'magit-status)
        '';

    extraPackages = (epkgs:
      (with epkgs; [
        apheleia
        evil
        evil-collection
        evil-leader
        diminish
        magit
        monokai-theme
        which-key
        company
        treesit-grammars.with-all-grammars
        yasnippet
        vterm
      ]));
  };
}
