{
  description = "A very basic flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.snowfall-lib.mkFlake {
        inherit inputs;
        src = ./.;
        snowfall = {
            namespace = "azmo";
            meta = {
                name = "azmo-system-flake";
                title = "Flake for azmo's machines";
              };
          };
        channels-config = {
            # Allow unfree packages
            allowUnfree = true;
        };
        systems = {
            hosts = {
                vm-minimal = {};
              };
          # Modules that get imported to every NixOS system
            modules.nixos = with inputs; [
                disko.nixosModules.disko
            ];

          };

      };
}
