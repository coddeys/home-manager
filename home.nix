{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full babel xetex setspace fontspec
                           chktex enumitem xifthen ifmtarg filehook
                           upquote tools ms geometry graphics oberdiek
                           fancyhdr lastpage xcolor etoolbox unicode-math
                           ucharcat sourcesanspro tcolorbox pgf environ
                           trimspaces parskip hyperref url euenc
                           collection-fontsrecommended ragged2e
                           framed paralist titlesec paratype inter;
    }
  );
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Modern Unix
    pocketbase
    bat
    eza
    lsd
    delta
    duf
    broot
    fd
    silver-searcher
    fzf
    mcfly
    choose
    jq
    sd
    cheat
    tldr
    vscodium
    bottom
    glances
    gtop
    hyperfine
    gping
    procs
    httpie
    curlie
    xh
    zoxide
    dog
    htop
    bob
    brave
    brightnessctl
    browsh
    bat
    direnv
    chromium
    dbeaver
    cargo
    ctags
    dmenu
    exercism
    elm2nix
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-test
    entr
    ghostscript
    imagemagick
    gawk
    gimp
    inkscape
    git
    gh
    ffmpeg
    keybase
    lf
    mpd
    mplayer
    mpv
    mupdf
    ncdu
    ncmpcpp
    ncpamixer
    nodejs
    nodePackages.prettier
    nodePackages.mermaid-cli
    nomad
    nixci
    nyxt
    ormolu
    just
    pamixer
    pandoc
    pavucontrol
    ripgrep
    rsync
    rtorrent
    tabbed
    tex
    texlab
    treefmt
    tmate
    texworks
    tmux
    tree
    unzip
    vault
    vlc
    zathura
    zip
    zsh
    zsh-syntax-highlighting
    deno
    overmind
    hivemind
  ];


  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-gstreamer
    ];
  };

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

  services.emacs.package = pkgs.emacs-unstable;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable;

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

  (global-flycheck-mode)


  (defvar projectile-indexing-method)
  (setq projectile-indexing-method 'alien)
  (defvar projectile-sort-order)
  (setq projectile-sort-order 'recently-active)
  (counsel-projectile-mode +1)
  (defvar projectile-mode-map)
  (define-key projectile-mode-map (kbd "M-p") 'projectile-command-map)
  (setq-default projectile-mode-line-prefix " Proj")
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)

  ;;(add-hook 'ruby-mode-hook 'robe-mode)
  ;;(add-hook 'ruby-mode-hook #'rubocop-mode)
  (setq rubocop-keymap-prefix (kbd "C-c C-x"))


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

  ;; (smartparens-global-mode)
  ;; (show-smartparens-global-mode t)
  ;; (diminish 'smartparens-mode)

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
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
  (setq js-indent-level 2)
  (setq typescript-indent-level 2)
  (setq web-mode-code-indent-level 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-sql-indent-offset 2)
  (setq css-indent-offset 2)

  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "C-;") 'avy-goto-line)
  (avy-setup-default)
  (global-set-key (kbd "C-c C-j") 'avy-resume)

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (evil-mode 1)
  (when (require 'evil-collection nil t)
    (evil-collection-init))
  (setq evil-search-module 'evil-search)
  ;; (evil-set-undo-system 'undo-tree)
  ;; (global-undo-tree-mode 1)

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
  "a" 'align-regexp)

  ;;(evil-set-initial-state 'ibuffer-mode 'normal)
  ;;(evil-set-initial-state 'shell-mode 'emacs)

  (which-key-mode)

  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  (add-hook 'typescript-mode-hook #'lsp)
  (add-hook 'ruby-mode-hook #'lsp)
  (add-hook 'js2-mode-hook #'lsp)
  (add-hook 'vue-mode-hook #'lsp)
  (add-hook 'js-mode-hook #'lsp)
  (add-hook 'elm-mode-hook #'lsp)
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'yaml-mode-hook #'lsp)
  (add-hook 'terraform-mode-hook #'lsp)
  (add-hook 'markdown-mode-hook #'lsp)
  (add-hook 'tex-mode-hook #'lsp)
  (add-hook 'latex-mode-hook #'lsp)
  (add-hook 'scss-mode-hook #'lsp)
  (add-hook 'css-mode-hook #'lsp)

  (add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))


  (setq backup-directory-alist '((".*" . "~/.trash")))

	(evil-leader/set-key
	"m"  'neotree-toggle
	"n"  'neotree-project-dir)

  (setq projectile-switch-project-action 'neotree-projectile-action)

  (with-eval-after-load 'flycheck
    (flycheck-grammarly-setup))
  (setq flycheck-grammarly-check-time 0.8)

  (global-set-key (kbd "<f8>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)

  (setq auto-save-file-name-transforms `((".", "~/.emacs-saves" t)))
  (setq backup-directory-alist `(("." . "~/.emacs-saves")))
  (setq backup-by-copying t)

  ;;disable backup
  (setq backup-inhibited t)
  ;;disable auto save
  (setq auto-save-default nil)

  ;; Drag-and-drop to `dired`
  (add-hook 'dired-mode-hook 'org-download-enable)
  (setq-default org-download-image-dir "~/code/imgs")
  (setq dired-listing-switches "-agG")
  (setq dired-dwim-target t)

  (org-babel-do-load-languages
     'org-babel-load-languages
     '((mermaid . t)
       (scheme . t)
       ))

  ;;Latex
  (defun my-latex ()
    (auto-fill-mode t)
    (add-to-list 'TeX-view-program-selection '(output-pdf "Zathura"))

  )

  (setq org-latex-compiler "lualatex")
  (setq org-preview-latex-default-process 'dvisvgm)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

  (setq TeX-parse-self t)
  (setq-default TeX-master nil)

  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)

  (add-hook 'LaTeX-mode-hook 'my-latex)

        '';

    extraPackages = (epkgs:
      (with epkgs; [
        ace-window
        anzu
        apheleia
        auctex
        avy
        avy
        company
        counsel
        counsel-projectile
        csv-mode
        dap-mode
        dhall-mode
        diff-hl
        diminish
        dimmer
        docker
        dockerfile-mode
        earthfile-mode
        editorconfig
        elm-mode
        evil
        evil-collection
        evil-leader
        flycheck
        flycheck-grammarly
        general
        git-gutter
        graphql-mode
        haml-mode
        haskell-mode
        hindent
        hydra
        ivy
        ivy-hydra
        js2-mode
        json-mode
        just-mode
        kotlin-mode
        lsp-haskell
        lsp-ivy
        lsp-mode
        lsp-tailwindcss
        lsp-treemacs
        lsp-ui
        magit
        markdown-mode
        minitest
        mmm-mode
        monokai-theme
        moom
        multi-vterm
        multiple-cursors
        neotree
        nix-mode
        ob-mermaid
        org-download
        org-tree-slide
        ormolu
        prettier-js
        projectile
        projectile-rails
        restclient
        robe
        rspec-mode
        rubocop
        sass-mode
        scratch
        scss-mode
        slim-mode
        smartparens
        solidity-mode
        swiper
        terraform-mode
        tex
        typescript-mode
        undo-tree
        vterm
        vue-mode
        web-mode
        wgrep
        which-key
        yaml-mode
        yasnippet
      ]));
  };


  programs.firefox.enable = true;

  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [
  #     dracula-theme.theme-dracula
  #     vscodevim.vim
  #     yzhang.markdown-all-in-one
  #   ];
  # };
  
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
  home.username = "dima.sukhikh";
  home.homeDirectory = "/home/dima.sukhikh";

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
