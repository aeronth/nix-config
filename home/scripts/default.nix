let
  scripts = { config, lib, pkgs, ... }:
    let
      hcr = pkgs.callPackage ./changes-report.nix { inherit config pkgs; };
      szp = pkgs.callPackage ./show-zombie-parents.nix { inherit pkgs; };
    in
    {
      home.packages = [
        hcr # home-manager changes report between generations
        szp # show zombie parents
      ] ++ (pkgs.sxm.scripts or [ ]);
    };
in
[ scripts ]
