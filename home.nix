{ inputs, pkgs, config, nixgl, ... }: {

  home = {
    username = "diegoroccia";
    homeDirectory = "/home/diegoroccia";
    preferXdgDirectories = true;
    stateVersion = "24.11";
    packages = with pkgs; [
	  hyprland
	  wezterm
	  rofi-wayland
	  dunst
	  wlogout
	  hyprlock
	  chezmoi
	];
  };

  programs.home-manager.enable = true;

#   programs.wezterm = {
#       enable = true;
#       package = inputs.wezterm.packages.${pkgs.system}.default;
#       enableZshIntegration = true;
#       extraConfig = ''
# local wezterm = require("wezterm")
# local config = wezterm.config_builder() or {}
#
# config.enable_wayland = true
# config.automatically_reload_config = true
# config.front_end = "WebGpu"
#
# -- don't care about tabs
# config.enable_tab_bar = true
# config.use_fancy_tab_bar = true
# config.show_tabs_in_tab_bar = true
# config.show_new_tab_button_in_tab_bar = true
#
# -- colorscheme
# -- config.color_scheme = "Catppuccin Mocha"
# config.color_scheme = "Catppuccin Macchiato"
#
# config.font = wezterm.font_with_fallback({
# 	{
# 		family = "JetBrains Mono",
# 		weight = "Regular",
# 		harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
# 	},
# 	{ family = "Noto Color Emoji", weight = "Regular" },
# 	"Symbols Nerd Font Mono",
# 	"Powerline Extra Symbols",
# 	"codicon",
# 	"Noto Sans Symbols",
# 	"Noto Sans Symbols2",
# 	"Font Awesome 6 Free",
# })
#
# config.line_height = 1.5
# config.underline_position = "-5px"
# -- config.underline_thickness = "100%"
# config.command_palette_font_size = 12
#
# config.window_padding = {
# 	left = 20,
# 	right = 20,
# 	top = 20,
# 	bottom = 20,
# }
#
# config.keys = require("keys")
#
# -- config.default_prog = { "tmux" }
#
# config.tiling_desktop_environments = {
# 	"X11 LG3D",
# 	"X11 bspwm",
# 	"X11 i3",
# 	"X11 dwm",
# 	"Wayland",
# }
#
# config.adjust_window_size_when_changing_font_size = false
#
# return config
#
#     '';
#   };

  fonts.fontconfig.enable = true;

  programs.go = {
    enable = true;
  };

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
    XDG_DATA_DIRS="/home/diegoroccia/.nix-profile/share:$XDG_DATA_DIRS"
  '';

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

}
