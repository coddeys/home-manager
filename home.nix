{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brave
    brightnessctl
    browsh
    cabal-install
    chromium
    ctags
    dmenu
    elm2nix
    elmPackages.elm
    elmPackages.elm-format
    entr
    fzf
    gawk
    # ghc
    gimp
    git
    gradle
    jq
    mpd
    mplayer
    mpv
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
    slock
    tabbed
    tmate
    tmux
    unzip
    vlc
    zip
    zsh-syntax-highlighting
  ];

  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      fzf-vim
    ];
  };

  programs.firefox.enable = true;

  services.lorri.enable = true;

  # xsession = {
  #   enable = true;
  #   windowManager.xmonad = {
  #     enable = true;
  #     extraPackages = haskellPackages: [
  #       haskellPackages.xmonad-contrib
  #     ];
  #   };
  # };

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
