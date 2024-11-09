{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
  };

  outputs = { nixpkgs, home-manager, nixgl, catppuccin, ... }@inputs:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ nixgl.overlay ];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    in
    {
      homeConfigurations."diegoroccia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit nixpkgs inputs nixgl;
        };
        modules = [ 
          ./home.nix 
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
}
