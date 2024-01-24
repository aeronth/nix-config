{ inputs, system, pkgs, extraArgs, ... }:

with inputs;

let
  inherit (nixpkgs.lib) nixosSystem;
  inherit (pkgs) lib;

  appleModules = [
    ../system/configuration.nix
  ];

  edpHomeModules = [
    home-manager.nixosModules.home-manager
    (import ./home-module.nix {
      inherit inputs system;
      extraSpecialArgs = extraArgs { hidpi = false; };
    })
  ];

  vmUser = {
    users.users.aeronth.initialPassword = "test";
  };
in
{
  edp-apple = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = appleModules ++ edpHomeModules ++ [ vmUser ];
  };
}
