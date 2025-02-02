{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    # cachix-deploy-flake.url = "github:cachix/cachix-deploy-flake";
    # cachix-deploy-flake.inputs.home-manager.follows = "home-manager";
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    nixgl = {
      url = "github:nix-community/nixgl";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    catppuccin.url = "github:catppuccin/nix";
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay = {
          url = "github:oxalica/rust-overlay/master";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = { self, flake-utils, nixpkgs, home-manager, nixgl, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        overlays = [ nixgl.overlay ];
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      packages.x86_64-linux.default = self.homeConfigurations."diegoroccia".activationPackage;
      defaultPackage.x86_64-linux = self.homeConfigurations."diegoroccia".activationPackage;

      homeConfigurations."diegoroccia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit nixpkgs inputs nixgl;
        };
        modules = [
          ./home.nix
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.sops-nix.homeManagerModules.sops
          inputs.hyprland.homeManagerModules.default
        ];
      };
    };
}
