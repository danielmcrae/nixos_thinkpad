{
  description = "System Flake";
  # Commands: sudo nixos-rebuild switch --flake .

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # nixos-unstable  23.05
    home-manager.url = "github:nix-community/home-manager/release-23.05"; # release-23.05, 23.11
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
          system = "${system}";     # inharit system; not working?
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        daniel = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};     
          modules = [ ./home.nix ];
        };
      };
    };
}
