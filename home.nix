{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # autojump
    brightnessctl
    browsh
    bat
    direnv
    chromium
    cabal-install
    ctags
    dmenu
    exercism
    elm2nix
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-test
    entr
    fzf
    ghostscript
    imagemagick
    gawk
    gimp
    git
    # ghc
    libreoffice
    lf
    mplayer
    mpv
    mupdf
    ncdu
    ncmpcpp
    ncpamixer
    nodejs
    # niv
    # nixFlakes
    nodePackages.prettier
    ormolu
    pamixer
    pavucontrol
    ripgrep
    ruby_3_0
    rsync
    rtorrent
    stack
    tabbed
    tmate
    tmux
    termonad
    unzip
    vlc
    zathura
  #  youtube-dl
    zip
    zsh
    zsh-syntax-highlighting
  ];


  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.neovim = {
    enable = true;

    extraConfig = ''
      syntax on
      filetype plugin indent on

      set nocompatible
      set number
      set showmode
      set smartcase
      set smarttab
      set smartindent
      set autoindent
      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set laststatus=0

      hi Constant ctermfg=5*
      hi Comment ctermfg=2*
      hi Normal ctermbg=none
      set mouse=a

      let g:haskell_classic_highlighting = 1
      let g:haskell_indent_if = 3
      let g:haskell_indent_case = 2
      let g:haskell_indent_let = 4
      let g:haskell_indent_where = 6
      let g:haskell_indent_before_where = 2
      let g:haskell_indent_after_bare_where = 2
      let g:haskell_indent_do = 3
      let g:haskell_indent_in = 1
      let g:haskell_indent_guard = 2
      let g:haskell_indent_case_alternative = 1
      let g:cabal_indent_section = 2

    '';

    plugins = with pkgs.vimPlugins; [
      ctrlp
      editorconfig-vim
      gruvbox-community
      vim-nix
      fzf-vim
      haskell-vim
    ];

  };

  programs.emacs = {
    enable = true;
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
  (setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
  (setq-default tab-width 8)            ;; but maintain correct appearanc
  ;; Newline at end of file
  (setq require-final-newline t)
  (global-so-long-mode 1)


  ;; hippie expand is dabbrev expand on steroids
  (yas-global-mode 1)
  (setq hippie-expand-try-functions-list '(yas-hippie-try-expand
                                           try-expand-dabbrev
                                           try-expand-dabbrev-all-buffers
                                           try-expand-dabbrev-from-kill
                                           try-complete-file-name-partially
                                           try-complete-file-name
                                           try-expand-all-abbrevs
                                           try-expand-list
                                           try-expand-line
                                           try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol))
  ;; use hippie-expand instead of dabbrev
  (global-set-key (kbd "M-/") #'hippie-expand)


  (global-auto-revert-mode t)
  (global-subword-mode t)

  (setq-default fill-column 80)

  ;; don't kill emacs
  (defun dont-kill-emacs ()
    (interactive)
    (error (substitute-command-keys "To exit emacs: \\[kill-emacs]")))
  (global-set-key "\C-x\C-c" 'dont-kill-emacs)

  (display-time-mode 1)
  (setq column-number-mode t)
  (setq default-input-method "russian-computer")
  (setq semantic-mode t)



  (defun sort-words (reverse beg end)
    "Sort words in region alphabetically, in REVERSE if negative.
    Prefixed with negative \\[universal-argument], sorts in reverse.

    The variable `sort-fold-case' determines whether alphabetic case
    affects the sort order.

    See `sort-regexp-fields'."
    (interactive "*P\nr")
    (sort-regexp-fields reverse "\\w+" "\\&" beg end))

  (diminish 'auto-revert-mode)
  (diminish 'subword-mode)
  (diminish 'eldoc-mode)

  (ivy-mode 1)
  (defvar ivy-use-virtual-buffers)
  (setq ivy-use-virtual-buffers t)
  (defvar ivy-count-format)
  (setq ivy-count-format "(%d/%d) ")
  (defvar projectile-completion-system)
  (setq projectile-completion-system 'ivy)
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

  (defvar projectile-indexing-method)
  (setq projectile-indexing-method 'alien)
  (defvar projectile-sort-order)
  (setq projectile-sort-order 'recently-active)
  (counsel-projectile-mode +1)
  (defvar projectile-mode-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq-default projectile-mode-line-prefix " Proj")

  (add-hook 'ruby-mode-hook 'robe-mode)

  (setq-default dimmer-fraction 0.15)
  (add-hook 'after-init-hook 'dimmer-mode)

  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator "/")
  ;; rename after killing uniquified
  (setq uniquify-after-kill-buffer-p t)
  ;; don't muck with special buffers
  (setq uniquify-ignore-buffers-re "^\\*")


  (setq vc-handled-backends nil)
  (global-set-key (kbd "C-c g") 'magit-status)

  ;; Elm
  (defvar elm-format-on-save)
  (setq elm-format-on-save 0)
  (add-hook 'elm-mode-hook 'elm-indent-mode)
  (add-hook 'elm-mode-hook 'my/elm-outline-mode)
  ;; (add-to-list 'company-backends '( company-gtags
  ;;                                  company-etags
  ;;                                  company-keywords
  ;;                                  company-files
  ;;                                  company-dabbrev
  ;;                                  company-elm))
  (defvar elm-tags-on-save)
  (setq elm-tags-on-save t)
  (defvar elm-tags-exclude-elm-stuff)
  (setq elm-tags-exclude-elm-stuff nil)
  (defvar tags-revert-without-query)
  (setq tags-revert-without-query 1)
  (defvar elm-format-command)
  (setq elm-format-command "elm-format")


  (global-set-key (kbd "s-o") 'other-window)
  (global-set-key (kbd "M-p") 'ace-window)

  (smartparens-global-mode)
  (show-smartparens-global-mode t)
  (diminish 'smartparens-mode)

  (outline-minor-mode 1)

  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

  (global-set-key (kbd "C-c %") 'anzu-query-replace)
  (global-anzu-mode +1)

  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)

  (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . js2-mode))
  (setq js-indent-level 2)

  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "C-;") 'avy-goto-line)
  (avy-setup-default)
  (global-set-key (kbd "C-c C-j") 'avy-resume)

  (evil-mode 1)
        '';

    extraPackages = (epkgs:
      (with epkgs; [
        avy
        ace-window
        anzu
        avy
        company
        counsel
        counsel-projectile
        csv-mode
        dante
        diff-hl
        diminish
        dimmer
        docker
        dockerfile-mode
        elm-mode
        evil
        flycheck
        git-gutter
        graphql-mode
        haskell-mode
        hindent
        hydra
        indium
        ivy
        ivy-hydra
        kotlin-mode
        js2-mode
        json-mode
        vterm
        magit
        markdown-mode
        mmm-mode
        monokai-theme
        multiple-cursors
        nix-mode
        ormolu
        prettier-js
        projectile
        # projectile-rails
        rubocop
        restclient
        sass-mode
        scratch
        scss-mode
        smartparens
        swiper
        wgrep
        vterm
        yaml-mode
        yasnippet
      ]));
  };


  programs.firefox.enable = true;

  services.lorri.enable = true;

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
      ];
    };
  };


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "coddeys";
  home.homeDirectory = "/home/coddeys";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
