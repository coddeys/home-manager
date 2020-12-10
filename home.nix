{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brave
    brightnessctl
    browsh
    chromium
    ctags
    dmenu
    elm2nix
    elmPackages.elm
    elmPackages.elm-format
    entr
    firefox
    fzf
    gawk
    ghc
    git
    gradle
    mpd
    mplayer
    mysql
    ncdu
    ncmpcpp
    ncpamixer
    nodejs
    ormolu
    pamixer
    pavucontrol
    slock
    tabbed
    tmate
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
