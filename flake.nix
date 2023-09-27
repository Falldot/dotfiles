{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nixos-hardware, ... } :
  # let
  #   inherit (self) outputs;

  #   lib = nixpkgs.lib // home-manager.lib;

  #   system = "x86_64-linux";

  #   pkgs = {
  #     inherit system;
  #     config.allowUnfree = true;
  #   };
  # in
  {
    # inherit lib;

    nixosConfigurations = {
      falldot = nixpkgs.lib.nixosSystem {
        # specialArgs = { inherit inputs outputs; };
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-ssd
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.falldot = import ./home/home.nix;
              extraSpecialArgs = {
                hidpi = true;
              };
            };
          }
          # {
          #   imports = [ 

          #   ];
          # }
        ];
      };
    };

    # homeConfigurations = {
    #   "falldot@falldot" = lib.homeManagerConfiguration {
    #     pkgs = pkgs.x86_64-linux;
    #     extraSpecialArgs = {
          # inherit inputs outputs;
          # hidpi = true;
    #     };
    #     modules = [
    #       ./home/home.nix
    #     ];
    #   };
    # };
  };
}
