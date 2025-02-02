{ inputs, config, pkgs, ... }: {

  xdg = {
    configFile = {
      "environment.d/hyprland.conf" = {
        text = ''
          PATH="$HOME/.nix-profile/bin:$PATH"
          NIXOS_OZONE_WL="1";
          WLR_RENDERER_ALLOW_SOFTWARE=1
          MOZ_ENABLE_WAYLAND=1
          GDK_BACKEND=wayland
          QT_QPA_PLATFORM=wayland
          SDL_VIDEODRIVER=wayland
          CLUTTER_BACKEND=wayland
          XDG_CURRENT_DESKTOP=Hyprland
          XDG_SESSION_TYPE=wayland
          XDG_SESSION_DESKTOP=Hyprland
          QT_AUTO_SCREEN_SCALE_FACTOR=1
          QT_QPA_PLATFORM=wayland
          QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          QT_QPA_PLATFORMTHEME=qt5ct
          XCURSOR_SIZE=24
        '';
      };
    };

    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
      xdgOpenUsePortal = true;
      config.common.default = "*";
    };
  };

  services = {
    wlsunset = {
      enable = true;
      latitude = 52.5200;
      longitude = 13.4050;
    };
    blueman-applet.enable = true;
    gnome-keyring = {
      enable = true;
    };
    hyprpaper = {
      enable = true;

      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = [
          "~/Pictures/wallpapers/0024.jpg"
          "~/Pictures/wallpapers/0004.jpg"
          "~/Pictures/wallpapers/0014.jpg"
          "~/Pictures/wallpapers/0044.jpg"
          "~/Pictures/wallpapers/0012.jpg"
        ];
        wallpaper = [ ", ~/Pictures/wallpapers/0012.jpg" ];
      };
    };

    dunst.enable = true;
    dunst.settings = (import ./dunstrc.nix);
    network-manager-applet.enable = true;
    swayosd = {
      enable = true;
      stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = (config.lib.nixGL.wrap  pkgs.hyprland);

   systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
    settings = {
      general = {
        border_size = 1;
        "col.active_border" = "$accent 45deg";
        "col.inactive_border" = "$base";
        gaps_in = 4;
        gaps_out = 10;
        layout = "dwindle";
        allow_tearing = true;
        resize_on_border = true;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      decoration = {
        rounding = 2;
        dim_inactive = false;
        blur = {
          special = true;
        };
        shadow = {
          enabled = true;
          color = "$accent";
          color_inactive = "$base";
          sharp = true;
          offset = "4 4";
          range = 0;
        };
      };
      animations = {
        enabled = true;
        bezier = "overshot,0.05,0.9,0.1,1.1";
        animation = [
          "windows,1,5,overshot,popin 80%"
          "workspaces,1,3,overshot,slide"
        ];
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      gestures = {
        workspace_swipe = true;
      };
      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
          disable_while_typing = true;
        };
        sensitivity = 0;
        numlock_by_default = true;
      };
      misc = {
        animate_manual_resizes = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        mouse_move_enables_dpms = true;
        mouse_move_focuses_monitor = true;
        vrr = 2;
      };
      bind = [
        "super, b, exec, pkill -SIGUSR1 waybar"
      ];
    };
    plugins = [
      # inputs.hyprland-plugin-hyprfocus.packages.${pkgs.system}.hyprfocus
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    extraConfig = (builtins.readFile ./hyprland.conf);
  };
}

