{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  nixGLIntel = inputs.nixGL.packages.${pkgs.system}.nixGLIntel;
in {

  home = {
    username = "diegoroccia";
    homeDirectory = "/home/diegoroccia";
    stateVersion = "24.05";
    packages = with pkgs; [
      hyprland
      wezterm
      # (config.lib.nixGL.wrap rofi)
      # (config.lib.nixGL.wrap rofi-pass)
      rofi-wayland
      rofi-vpn
      rofi-emoji
      rofi-rbw-wayland
      pinentry-rofi
      google-chrome
      dunst
      neovim
      wlogout
      hyprlock
      chezmoi
      obsidian
      cargo
      easyeffects
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
  };

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
    export XDG_DATA_DIRS="/home/diegoroccia/.nix-profile/share:$XDG_DATA_DIRS"
  '';

}
