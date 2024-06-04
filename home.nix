{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "dima";
  home.homeDirectory = "/home/dima";

  targets.genericLinux.enable = true;

  home.stateVersion = "24.05";

  imports = [
   ./emacs.nix
    ./vim.nix
  ];

  home.packages = with pkgs; [
    bat
    bottom
    brave
    chromium
    direnv
    dmenu
    docker-compose
    entr
    exercism
    ffmpeg
    fzf
    gimp
    git
    imagemagick
    htop
    jq
    just
    mpd
    mplayer
    mpv
    mupdf
    ncdu
    ncmpcpp
    pavucontrol
    rtorrent
    silver-searcher
    tmate
    tmux
    vlc
    zathura
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;


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

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "ssh-agent"];
      theme = "dpoggi";
    };
  };
}
