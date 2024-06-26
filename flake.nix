{
  description = "Basic nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pkgs.nixos-shell
      ];
    };

    nixosConfigurations = {
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ({pkgs, ...}: {
            boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_9;
          })
        ];
      };
    };
  };
}
