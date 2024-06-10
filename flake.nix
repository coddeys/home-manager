{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs.url = "github:nix-community/emacs-overlay";
    entangled.url = "github:entangled/entangled";
  };

  outputs = inputs@{nixpkgs, home-manager, ...}:
    let
      system = "x86_64-linux";
      user = "dima.sukhikh";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = with inputs; [
          emacs.overlay
        ];
      };
    in
      {
        homeConfigurations = {
          "dima.sukhikh" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./home.nix
            ];
          };
        };
      };
}
