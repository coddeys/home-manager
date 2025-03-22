{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-unstable;
    # package = pkgs.emacs-unstable;
    package = pkgs.emacs;
    extraConfig = ''
      (package-initialize)
      (setq ring-bell-function 'ignore)
      (load-theme 'monokai t)
      (setq inhibit-startup-screen t)
      (global-set-key (kbd "M-<tab>") 'dabbrev-expand)
      (define-key minibuffer-local-map (kbd "M-<tab>") 'dabbrev-expand)
      (setq scroll-margin 0
          scroll-conservatively 100000
          scroll-preserg-screen-position 1)
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
      ;; (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
      ;; (setq evil-want-keybinding nil)
      ;; (evil-mode 1)
      ;; (when (require 'evil-collection nil t)
        ;; (evil-collection-init))
      ;; (setq evil-search-module 'evil-search)
      ;; (global-evil-leader-mode)
      ;; (evil-leader/set-leader "<SPC>")
      ;; (evil-leader/set-key
      ;; "f" 'find-file
      ;; "b" 'switch-to-buffer
      ;; "d" 'docker
      ;; "k" 'kill-buffer
      ;; "s" 'save-buffer
      ;; "2" 'split-window-below
      ;; "3" 'split-window-right
      ;; "0" 'delete-window
      ;; "o" 'other-window
      ;; "p" 'ace-window
      ;; "x" 'counsel-M-x
      ;; "a" 'align-regexp
      ;; "g" 'magit-status)

      (which-key-mode)
      (add-hook 'after-init-hook 'global-company-mode)
      (yas-global-mode 1)

      ;; TYPESCRIPT
      (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-ts-mode))
      (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
      (add-to-list 'auto-mode-alist '("\\.json\\'" . json-ts-mode))
      (add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-ts-mode))

      ;; Rust
      (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))


      (diminish 'apheleia-mode)
      (apheleia-global-mode +1)

      (setq magit-refresh-status-buffer nil)
      (global-set-key (kbd "C-c g") 'magit-status)
      (global-diff-hl-mode)

      (ivy-mode 1)
      (defvar ivy-use-virtual-buffers)
      (setq ivy-use-virtual-buffers t)
      (defvar ivy-count-format)
      (setq ivy-count-format "(%d/%d) ")
      (diminish 'ivy-mode)

      (global-set-key (kbd "C-s") 'swiper)
      (global-set-key (kbd "M-x") 'counsel-M-x)
      (global-set-key (kbd "C-c C-g") 'counsel-git)
      (global-set-key (kbd "C-c j") 'counsel-git-grep)
      (global-set-key (kbd "C-c k") 'counsel-ag)
      (global-set-key (kbd "C-x l") 'counsel-locate)
      (global-set-key  (kbd "C-c z") 'counsel-fzf )
      (global-set-key (kbd "C-x C-f") 'counsel-find-file)
      (global-set-key (kbd "C-x C-r") 'ivy-resume)

      ;; Elm
      (defvar elm-format-on-save)
      (setq elm-format-on-save 0)
      (add-hook 'elm-mode-hook 'elm-indent-mode)
      (add-hook 'elm-mode-hook 'my/elm-outline-mode)
      (defvar elm-format-command)
      (setq elm-format-command "elm-format")

      ;; jumping to visible text using a char-based decision tree
      (global-set-key (kbd "C-:") 'avy-goto-char)
      (global-set-key (kbd "C-'") 'avy-goto-char-2)
      (global-set-key (kbd "C-;") 'avy-goto-line)

      (avy-setup-default)
      (global-set-key (kbd "C-c C-j") 'avy-resume)

      (global-set-key (kbd "C-c %") 'anzu-query-replace)
      (global-anzu-mode +1)

      (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
      (global-set-key (kbd "C->") 'mc/mark-next-like-this)
      (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
      (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

      ;; Visually highlight the selected buffer.
      (dimmer-configure-hydra)
      (dimmer-configure-which-key)
      (dimmer-configure-magit)
      (dimmer-mode t)

      (editorconfig-mode 1)

      ;; treesit modes
      (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-ts-mode))
      (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-ts-mode))

      (require 'xah-fly-keys)
      (xah-fly-keys-set-layout "colemak-dh")
      (xah-fly-keys 1)
      (define-key key-translation-map (kbd "C-t") (kbd "C-g"))

      ;; put this AFTER loading Xah Fly Keys

      (define-key xah-fly-leader-key-map (kbd "SPC") 'nil)
      (define-key xah-fly-leader-key-map (kbd "RET") 'nil)
      (define-key xah-fly-leader-key-map (kbd "RET SPC") 'execute-extended-command)
      (define-key xah-fly-leader-key-map (kbd "SPC SPC") 'xah-fly-insert-mode-activate)
      (define-key xah-fly-leader-key-map (kbd "SPC e") 'avy-goto-line)
      (define-key xah-fly-leader-key-map (kbd "SPC o") 'avy-goto-char-2)

      (define-key xah-fly-leader-key-map (kbd "RET .") 'mc/mark-next-like-this)
      (define-key xah-fly-leader-key-map (kbd "RET ,") 'mc/mark-previous-like-this)
      (define-key xah-fly-leader-key-map (kbd "RET /") 'mc/mark-all-like-this)
      (define-key xah-fly-leader-key-map (kbd "RET ?") 'mc/edit-lines)

      (define-key xah-fly-leader-key-map (kbd "RET n") 'avy-goto-char-timer)
      (define-key xah-fly-leader-key-map (kbd "RET s") 'project-find-file)
      (define-key xah-fly-leader-key-map (kbd "RET g") 'project-find-regexp)
      (define-key xah-fly-leader-key-map (kbd "RET t t") 'project-switch-to-buffer)
      (define-key xah-fly-leader-key-map (kbd "RET t d") 'project-dired)
      (define-key xah-fly-leader-key-map (kbd "RET t k") 'project-kill-buffers)
      (define-key xah-fly-leader-key-map (kbd "RET t r") 'project-query-replace-regexp)
      (define-key xah-fly-leader-key-map (kbd "RET t v") 'project-vc-dir)
      (define-key xah-fly-leader-key-map (kbd "RET t s") 'project-shell)
      (define-key xah-fly-leader-key-map (kbd "RET t !") 'project-shell-command)
      (define-key xah-fly-leader-key-map (kbd "RET t &") 'project-async-shell-command)
      (define-key xah-fly-leader-key-map (kbd "RET t p") 'project-switch-project)
      (define-key xah-fly-leader-key-map (kbd "RET t s") 'project-shell)

      (define-key xah-fly-leader-key-map (kbd "SPC RET") 'execute-extended-command)
      (define-key xah-fly-leader-key-map (kbd "SPC n") 'move-to-window-line-top-bottom)
      (define-key xah-fly-leader-key-map (kbd "RET n") 'move-to-window-line-top-bottom)


      ;; Dired
      (setq dired-dwim-target t)
      (setq dired-listing-switches "-alh")
      (defun my-dired-init ()
        "to be run as hook for `dired-mode'."
        (dired-hide-details-mode 1))

      (add-hook 'dired-mode-hook 'my-dired-init)

      ;; latex
      (setq org-latex-compiler "lualatex")
      (setq org-preview-latex-default-process 'dvisvgm)

    '';

    extraPackages = (epkgs:
      (with epkgs; [
        apheleia
        ace-window
        anzu
        avy
        editorconfig
        xah-fly-keys
        diff-hl
        diminish
        dimmer
        docker
        dockerfile-mode
        magit
        monokai-theme
        multiple-cursors
        multi-vterm
        restclient
        scratch
        swiper
        speed-type
        counsel
        hydra
        ivy
        ivy-hydra
        which-key
        company
        treesit-grammars.with-all-grammars
        yasnippet
        vterm
        elm-mode
        dhall-mode
        nix-mode
        graphql-mode
        haml-mode
        haskell-mode
        purescript-mode
        markdown-mode
        slim-mode
        just-mode
        justl
        terraform-mode
        rust-mode
      ]));
  };
}
