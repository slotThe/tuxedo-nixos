{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-compat }: {

    packages.x86_64-linux.default =
      # Is there a simpler way to whitelist electron?
      (import nixpkgs {
        currentSystem = "x86_64-linux";
        localSystem = "x86_64-linux";
        config = {
          permittedInsecurePackages = [
            "electron-13.6.9"
            "nodejs-14.21.3"
            "openssl-1.1.1t"
            "openssl-1.1.1u"
            "openssl-1.1.1v"
            "openssl-1.1.1w"
          ];
        };
      }).pkgs.callPackage ./nix/tuxedo-control-center {};

    nixosModules.default = import ./nix/module.nix;
  };
}
