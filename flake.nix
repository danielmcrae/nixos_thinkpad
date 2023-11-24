{
  description = "System Flake";
  # Commands: sudo nixos-rebuild switch --flake .

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # nixos-unstable  23.05
    home-manager.url = "github:nix-community/home-manager/release-23.05"; # release-23.05
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixPad = lib.nixosSystem {
          system = "x86_64-linux";
            # inharit system; not working
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        daniel = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          # inharit pkgs; not working
          modules = [ ./home.nix ];
        };
      };
    };
}
