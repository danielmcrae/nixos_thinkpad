{
  description = "System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    home-manager.url = "github:nix-community/home-manager/release-23.05"; 
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
          system = "${system}";     
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
