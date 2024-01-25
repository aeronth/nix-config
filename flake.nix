{
  description = "aeronth's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs:
    let
      system = "linux-aarch64";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = import ./lib/overlays.nix { inherit inputs system; };
      };

      extraArgs = { hidpi }: {
        inherit hidpi;
      };
    in
    {
      homeConfigurations =
        import ./outputs/home-conf.nix { inherit inputs system pkgs extraArgs; };

      nixosConfigurations =
        import ./outputs/nixos-conf.nix { inherit inputs system pkgs extraArgs; };

    };
}
