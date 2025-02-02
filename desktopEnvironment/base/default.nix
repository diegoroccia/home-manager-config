{ inputs, config, pkgs, ... }: {

  home.packages = with pkgs; [
    brightnessctl
    dunst
    hyprpicker
    hyprpaper
    hyprlock
    waypaper
    obsidian
    blueman
    wlr-randr
    xfce.thunar
    xfce.tumbler
    flameshot
    grim
    slurp
#    spotify
#    spicetify-cli
    steam

    # cachix

    wireplumber
    pavucontrol

    # Fonts
    noto-fonts
    noto-fonts-emoji
    material-design-icons
    font-awesome
    weather-icons
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Noto" ]; })
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  catppuccin.flavor = "macchiato";
  catppuccin.accent = "flamingo";
  catppuccin.enable = true;
  catppuccin.cursors.enable = true;

  gtk = {
    enable = true;
    theme = {
        name =  "Flat-Remix-GTK-Teal-Dark";
        package = pkgs.flat-remix-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

  };

  qt.enable = true;
  qt.style.name = "kvantum";
  qt.platformTheme.name = "kvantum";


  programs = {
    chromium = {
      enable = true;
      package = pkgs.google-chrome;
    };
    browserpass.enable = true;
    firefox.enable = true;
    waybar = {
      enable = true;
      style = (builtins.readFile ./waybar-style.css);
      settings = import ./waybar-config.nix;

      systemd = {
        enable = true;
      };

    };
    rofi = {
      enable = true;
      pass = {
        enable = true;
      };
    };
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "google-chrome.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "inode/directory" = "thunar";
      };
    };
    configFile = {
      "environment.d/sway.conf" = {
        text = ''
          PATH="$HOME/.nix-profile/bin:$PATH"
          NIXOS_OZONE_WL="1";
          WLR_RENDERER_ALLOW_SOFTWARE=1
          MOZ_ENABLE_WAYLAND=1
          GDK_BACKEND=wayland
          QT_QPA_PLATFORM=wayland
          SDL_VIDEODRIVER=wayland
          CLUTTER_BACKEND=wayland
          XDG_SESSION_TYPE=wayland
          QT_AUTO_SCREEN_SCALE_FACTOR=1
          QT_QPA_PLATFORM=wayland
          QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          QT_QPA_PLATFORMTHEME=qt5ct
          XCURSOR_SIZE=24
        '';
      };
      # "environment.d/hyprland.conf" = {
      #   text = ''
      #     PATH="$HOME/.nix-profile/bin:$PATH"
      #     NIXOS_OZONE_WL="1";
      #     WLR_RENDERER_ALLOW_SOFTWARE=1
      #     MOZ_ENABLE_WAYLAND=1
      #     GDK_BACKEND=wayland
      #     QT_QPA_PLATFORM=wayland
      #     SDL_VIDEODRIVER=wayland
      #     CLUTTER_BACKEND=wayland
      #     XDG_CURRENT_DESKTOP=Hyprland
      #     XDG_SESSION_TYPE=wayland
      #     XDG_SESSION_DESKTOP=Hyprland
      #     QT_AUTO_SCREEN_SCALE_FACTOR=1
      #     QT_QPA_PLATFORM=wayland
      #     QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      #     QT_QPA_PLATFORMTHEME=qt5ct
      #     XCURSOR_SIZE=24
      #   '';
      # };
      "waypaper/config.ini" = {
        text = ''
          [Settings]
          language = en
          folder = ~/Pictures/wallpapers
          backend = hyprpaper
          monitors = All
          fill = Fill
          sort = name
          color = #ffffff
          subfolders = True
          number_of_columns = 3
          post_command =
          show_hidden = False
          show_gifs_only = False
          use_xdg_state = True
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
    blanket.enable = true;
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

    network-manager-applet.enable = true;
    swayosd = {
      enable = true;
      stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
    };
  };

}

