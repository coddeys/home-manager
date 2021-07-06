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
    gradle
    jq
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
    nodejs
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
    enable = false;

    extraPackages = (epkgs:
      (with epkgs; [
        scratch
        diminish
        hydra
        ivy
        ivy-hydra
        swiper
        counsel
        wgrep
        projectile
        counsel-projectile
        anzu
        dimmer
        restclient
        yaml-mode
        avy
        ace-window
        magit
        js2-mode
        indium
        prettier-js
        typescript-mode
        json-mode
        haskell-mode
        hindent
        ormolu
        dante
        flycheck
        company
        smartparens
        multiple-cursors
        diff-hl
        git-gutter
        markdown-mode
        mmm-mode
        elm-mode
        sass-mode
        scss-mode
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
