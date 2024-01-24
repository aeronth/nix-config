{ inputs, system, pkgs, extraArgs, ... }:

with inputs;

let
  imports = [
    ../home/home.nix
  ];

  mkHome = { hidpi }: (
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = extraArgs { inherit hidpi; };
      modules = [{ inherit imports; }];
    }
  );
in
{
  edp = mkHome { hidpi = false; };
  hdmi = mkHome { hidpi = true; };
}
