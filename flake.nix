{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR"; # Nix User Repository
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }:
    let
      user = "leon";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit lib pkgs system;

          specialArgs = {
            inherit nixpkgs user;
          };

          modules = [ 
            # Enable NUR repos via config.nur.repos.<...>
            nur.nixosModules.nur

            ./configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager.users.${user} = { config, lib, pkgs, ... }: {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
