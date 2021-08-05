{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brave
    brightnessctl
    browsh
    direnv
    chromium
    cabal-install
    ctags
    dmenu
    exercism
    elm2nix
    elmPackages.elm
    elmPackages.elm-format
    entr
    fzf
    gawk
    gimp
    git
    ghc
    lf
    mpd
    mplayer
    mpv
    mupdf
    mysql
    ncdu
    ncmpcpp
    ncpamixer
    niv
    nodePackages.prettier
    ormolu
    pamixer
    pavucontrol
    ripgrep
    rsync
    rtorrent
    ruby
    stack
    slock
    tabbed
    tmate
    tmux
    unzip
    vlc
    zathura
    zip
    zsh
    zsh-syntax-highlighting
  ];


  programs.direnv.nix-direnv.enable = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      elm-vim
      fzf-vim
    ];
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;


    extraPackages = (epkgs:
      (with epkgs; [
        ace-window
        anzu
        avy
        company
        counsel
        counsel-projectile
        dante
        diff-hl
        diminish
        dimmer
        elm-mode
        flycheck
        git-gutter
        haskell-mode
        hindent
        hydra
        indium
        ivy
        ivy-hydra
        js2-mode
        json-mode
        magit
        markdown-mode
        mmm-mode
        monokai-theme
        multiple-cursors
        nix-mode
        ormolu
        prettier-js
        projectile
        restclient
        sass-mode
        scratch
        scss-mode
        smartparens
        swiper
        typescript-mode
        use-package
        wgrep
        yaml-mode
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
