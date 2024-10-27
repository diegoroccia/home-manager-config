{ inputs, config, pkgs, nixgl, ... }: {


  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  #nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = [ "mesa" ];

  home = {
    username = "diegoroccia";
    homeDirectory = "/home/diegoroccia";
    preferXdgDirectories = true;
    stateVersion = "24.11";
    packages = with pkgs; [
	  (config.lib.nixGL.wrap hyprland)
	  inputs.wezterm.packages.${pkgs.system}.default
	  rofi-wayland
	  dunst
	  wlogout
	  hyprlock
	  chezmoi
	];
  };


  programs.mpv = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.mpv;
  };

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  programs.go = {
    enable = true;
  };

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
    XDG_DATA_DIRS="/home/diegoroccia/.nix-profile/share:$XDG_DATA_DIRS"
    NIXOS_OZONE_WL="1";
  '';

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

}
