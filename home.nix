{ inputs, config, pkgs, nixgl, ... }: {

  imports = [ inputs.ags.homeManagerModules.default ];

  targets.genericLinux.enable = true;

  nixGL.packages = nixgl.packages;
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
      dconf

      # GUI
      dunst
      hyprpicker
      hyprpaper
      networkmanagerapplet
      waypaper
      obsidian
      waybar

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

      kyverno

      python3
      pipx
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

  catppuccin.flavor = "macchiato";
  catppuccin.accent = "lavender";
  catppuccin.enable = true;
  catppuccin.pointerCursor.enable = true;

  gtk.enable = true;
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
    ags = {
      enable = true;
      extraPackages = with pkgs; [
        gtksourceview
        accountsservice
      ];
      systemd.enable = true;
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
          GTK_THEME=Catppuccin-Mocha-Standard-Teal-Dark
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
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
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
    extraConfig = (builtins.readFile ./resources/hyprland.conf);
    settings = {
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        # no_gaps_when_only = "yes";
      };


      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
        force_no_accel = 1;
        numlock_by_default = true;
      };
      misc = {
        vrr = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
      };

    };
  };
}

