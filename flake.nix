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
        # For `nix run .` later
        # defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

        homeConfigurations = {
          "dima.sukhikh" = home-manager.lib.homeManagerConfiguration {
            # Note: I am sure this could be done better with flake-utils or something
            inherit pkgs;
            modules = [ ./home.nix ]; # Defined later
          };
        };
      };
}
