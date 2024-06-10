{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.username = "dima.sukhikh";
  home.homeDirectory = "/home/dima.sukhikh";

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
    brightnessctl
    chromium
    crane
    direnv
    dive
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
    pamixer
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
    envExtra = ''
    [ -f "$HOME/.config/env" ] && source "$HOME/.config/env"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "ssh-agent"];
      theme = "dpoggi";
    };
  };
}
