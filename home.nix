{ config, pkgs, inputs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
  });
in
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

  services.emacs.enable = true;

  home.packages = with pkgs; [
    bat
    bottom
    brave
    brightnessctl
    chromium
    crane
    deno
    devenv
    direnv
    dive
    dhall
    dmenu
    docker-compose
    entr
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-optimize-level-2
    elmPackages.elm-review
    elmPackages.elm-test
    elmPackages.elm-language-server
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
    nixd
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.prettier
    pamixer
    rtorrent
    # pkgs."ruby-3.3.2"
    silver-searcher
    tmate
    tmux
    vlc
    termonad
    watchexec
    zathura
    skopeo
    w3m
    # betterlockscreen
    # rofi
    # dbeaver-bin
    tex
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
