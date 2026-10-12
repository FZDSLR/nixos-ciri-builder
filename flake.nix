{
  description = "Minimal NixOS configuration with mobile-nixos for Lenovo Chromebook Duet (ciri)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    mobile-nixos = {
      url = "github:FZDSLR/mobile-nixos/chromebook-ciri-7.3";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, mobile-nixos, ... }:
    {
      nixosConfigurations.nixos-ciri = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          (import "${mobile-nixos}/lib/configuration.nix" {
            device = "lenovo-ciri";
          })
          ./configuration.nix
        ];
      };

      packages.aarch64-linux.kpart =
        self.nixosConfigurations.nixos-ciri.config.mobile.outputs.depthcharge.kpart;
    };
}