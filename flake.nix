{
  description = "System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-master";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let 
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixPad = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };




}
