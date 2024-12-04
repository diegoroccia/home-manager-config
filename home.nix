{ inputs, config, pkgs, ... }: {

  imports = [ ./development ./console ];

  targets.genericLinux.enable = true;

  nixGL.packages = inputs.nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  home = {
    username = "diegoroccia";
    homeDirectory = "/home/diegoroccia";
    preferXdgDirectories = true;
    stateVersion = "24.11";
    packages = with pkgs; [

      # Core
      gsettings-desktop-schemas
      dconf-editor
      dconf
      glibc
      dbus

      # GUI
      brightnessctl
      dunst
      hyprpicker
      hyprpaper
      waypaper
      obsidian
      blueman
      wlr-randr
      xfce.thunar
      xfce.tumbler
      flameshot
      grim
      slurp
      spotify
      spicetify-cli
      steam

      wireplumber
      pavucontrol

      # Security
      age
      age-plugin-yubikey
      bitwarden
      git-credential-gopass
      gopass
      gopass-jsonapi
      sops
      gnupg
      yubikey-manager
      age-plugin-yubikey
      pinentry-rofi
      qmk


      kyverno

      cargo
      nodejs_22


      # Fonts
      noto-fonts
      noto-fonts-emoji
      material-design-icons
      font-awesome
      weather-icons
      (nerdfonts.override {
        fonts = [
          "JetBrainsMono"
          "Noto"
        ];
      })
    ];
  };

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
  catppuccin.pointerCursor.enable = true;

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "macchiato";
      accent = "flamingo";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

  };

  qt.enable = true;
  qt.style.name = "kvantum";
  qt.platformTheme.name = "kvantum";


  accounts.email.accounts = {
    "diego.roccia@zalando.de" = {
      primary = true;
      address = "diego.roccia@zalando.de";
      realName = "Diego Roccia";
      passwordCommand = [
        "gopass"
        "-o"
        "personal/websites/google.com/diego.roccia@zalando.de"
      ];
      flavor = "gmail.com";
      imap.host = "imap.gmail.com";
      smtp.host = "smtp.gmail.com";
      neomutt = {
        enable = true;
        extraConfig = ''
          color status cyan default
        '';
      };
    };
  };

  programs = {
    home-manager.enable = true;
    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };
    bat.enable = true;
    btop.enable = true;

    chromium = {
      enable = true;
      package = pkgs.google-chrome;
    };

    browserpass.enable = true;
    firefox.enable = true;
    fzf.enable = true;
    direnv.enable = true;
    dircolors.enable = true;
    gh = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Diego Roccia";
      userEmail = "diego.roccia@gmail.com";
      includes = [
        {
          condition = "gitdir:~/code/personal/";
          contents = {
            user = {
              email = "diego.roccia@gmail.com";
              name = "Diego Roccia";
              signingKey = "0xC9A64AACCCCE89E3";
            };
          };
        }
        {
          condition = "hasconfig:remote.*.url:git@github.bus.zalan.do:*/**";
          contents = {
            user = {
              email = "diego.roccia@zalando.de";
              name = "Diego Roccia";
              signingKey = "0xF374048AA01A3277";
            };
          };
        }
        {
          condition = "hasconfig:remote.*.url:git@github.com:zalando-cn-*/**";
          contents = {
            user = {
              email = "diego.roccia@zalando.de";
              name = "Diego Roccia";
              signingKey = "0xF374048AA01A3277";
            };
          };
        }
        {
          condition = "gitdir:~/code/ghe/";
          contents = {
            user = {
              email = "diego.roccia@zalando.de";
              name = "Diego Roccia";
              signingKey = "0xF374048AA01A3277";
            };
          };
        }
      ];
      extraConfig = {
        url = {
          "git@github-zse:zalando-" = {
            insteadOf = "git@github.com:zalando-";
            name = "Diego Roccia";
            email = "diego.roccia@zalando.de";
          };
          "git@github-zcn:zalando-cn-" = {
            insteadOf = "git@github.com:zalando-cn-";
            name = "Diego Roccia";
            email = "diego.roccia@zalando.de";
          };
          "git@github.bus.zalan.do:" = {
            insteadOf = "https://github.bus.zalan.do/";
            name = "Diego Roccia";
            email = "diego.roccia@zalando.de";
          };
        };
        commit = {
          gpgSign = true;
        };
      };
    };
    lazygit.enable = true;
    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      colorTheme = "dark-blue-256";
    };

    go = {
      enable = true;
      goPrivate = [
        "github.bus.zalan.do"
      ];
    };

    rofi = {
      enable = true;
      pass = {
        enable = true;
      };
    };
    awscli = {
      enable = true;
    };

    ssh = {
      enable = true;
      extraConfig = (builtins.readFile ./resources/ssh/config);
    };
    gpg = {
      enable = true;
      mutableKeys = true;
      mutableTrust = true;
    };
    # ags = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     gtksourceview
    #     accountsservice
    #   ];
    #   systemd.enable = true;
    # };
    waybar = {
      enable = true;
      style = (builtins.readFile ./resources/waybar-style.css);
      settings = import ./resources/waybar-config.nix;

      systemd = {
        enable = true;
      };

    };
    wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;
      extraConfig = (builtins.readFile ./resources/wezterm.lua);
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
      "environment.d/envvars.conf" = {
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
          ZDOTDIR="$HOME/.config/zsh"
        '';
      };
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
      "containers/registries.conf" = {
        text = ''
          unqualified-search-registries = ["docker.io", "quay.io", "ghcr.io"]
        '';
      };
      "containers/policy.json" = {
        text = ''
          {
              "default": [
                  {
                      "type": "insecureAcceptAnything"
                  }
              ]
          }
        '';
      };
    };

    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      ];
      xdgOpenUsePortal = true;
      config.common.default = "*";
    };

    systemDirs = {
      data = [
        "${config.home.homeDirectory}/.local/share"
        "/usr/local/share"
      ];
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
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      pinentryPackage = pkgs.pinentry-rofi;
      sshKeys = [
        # "05836BF42B2E7EE37372720D3DA6FA89D446C46B"
        # "122C3431F75F2B750F4A72ABC03E38C79980F617"
        # "12CF5CC16E72856FB3E0576E17B5B7A0CF9B5DF1"
        # "25FB15E8D62F2883A52ACD1709FCE4562FAEF7CC"
        # "29648853DD76FEE00CAB329F30A100C8D835BCC6"
        "3D54CF1DF6DC06B40CF596714C77FC864BD2192D"
        "61BD77CB7E3C92ED808D07142022395009086AEA"
        "810816D8FF2104E331F9C823CC6723EB7BCA4E2D"
        "AEACECC48B2A943AC83D0BB1E471D9CD4E730CF3"
        "C0BC69655A10317768FB8C7DE11DCE26E8E3BFCB"
        "DBA1FC622050CAD3118969849DDEADB57A827AB0"
      ];
    };
    home-manager = {
      autoUpgrade = {
        enable = true;
        frequency = "weekly";
      };
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
    dunst.settings = (import ./resources/dunstrc.nix);
    network-manager-applet.enable = true;
    swayosd = {
      enable = true;
      stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
    };
    podman = {
      enable = true;

      containers = {
        homarr = {
          image = "ghcr.io/ajnart/homarr:latest";
          ports = [
            "7575:7575"
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "${config.xdg.dataHome}/homarr/configs:/app/data/configs"
            "${config.xdg.dataHome}/homarr/icons:/app/public/icons"
            "${config.xdg.dataHome}/homarr/data:/data"
          ];
          autoStart = true;
        };
      };
    };
  };

  systemd = {
    user = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    #package = (config.lib.nixGL.wrap pkgs.hyprland);
    package = (config.lib.nixGL.wrap inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland);
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
      inputs.hyprland-plugin-hyprfocus.packages.${pkgs.stdenv.hostPlatform.system}.hyprfocus
    ];
    extraConfig = (builtins.readFile ./resources/hyprland.conf);
  };
}

