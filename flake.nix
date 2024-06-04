{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, home-manager, ...}:
    let
      system = "x86_64-linux";
      user = "dima.sukhikh";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        homeConfigurations = {
          "dima.sukhikh" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
          };
        };
      };
}
