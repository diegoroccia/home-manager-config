{ inputs, config, pkgs, nixgl, lib, ... }: {

  imports = [ inputs.ags.homeManagerModules.default ];

  targets.genericLinux.enable = true;

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  catppuccin.flavor = "macchiato";
  catppuccin.accent = "lavender";
  catppuccin.enable = true;
  catppuccin.pointerCursor.enable = true;

  home = {
    username = "diegoroccia";
    homeDirectory = "/home/diegoroccia";
    preferXdgDirectories = true;
    stateVersion = "24.11";
    packages = with pkgs; [

      # Core
      gsettings-desktop-schemas
      dconf
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr

      # GUI
      inputs.wezterm.packages.${pkgs.system}.default
      dunst
      google-chrome
      hyprpicker
      rofi-wayland
      networkmanagerapplet
      waypaper



      # Security
      age
      age-plugin-yubikey
      bitwarden
      git-credential-gopass
      gopass
      gopass-jsonapi
      sops

      # Console
      chezmoi
      gh
      imgcat
      jq
      podman
      onefetch

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
    };

    go = {
      enable = true;
      goPrivate = [
        "github.bus.zalan.do"
      ];
    };
    awscli = {
      enable = true;
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = import ./oh-my-posh.nix;
    };
    ags = {
      enable = true;
      extraPackages = with pkgs; [
        gtksourceview
        accountsservice
      ];
      systemd.enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      dotDir = ".config/zsh";
      initExtra = (builtins.readFile ./resources/zshrc);
      shellAliases = {
        "hms" = "home-manager switch -b backup --flake ~/.config/home-manager";
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        append = true;
        extended = true;
        ignoreDups = true;
        ignorePatterns = [
          "rm -rf"
          "rm *"
        ];
        share = true;
      };
      antidote = {
        enable = true;
        plugins = [
          "ohmyzsh/ohmyzsh path:lib"
          "ohmyzsh/ohmyzsh path:plugins/tmux"
          "ohmyzsh/ohmyzsh path:plugins/fzf"
          "ohmyzsh/ohmyzsh path:plugins/sudo"
          "ohmyzsh/ohmyzsh path:plugins/aws"
          "ohmyzsh/ohmyzsh path:plugins/kubectx"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-completions"
          "catppuccin/zsh-syntax-highlighting path:themes/catppuccin_frappe-zsh-syntax-highlighting.zsh"
        ];
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
      };
    };
    configFile = {
      "environment.d/envvars.conf" = {
        text = ''
          PATH="$HOME/.nix-profile/bin:$PATH"
          #XDG_DATA_DIRS="/home/diegoroccia/.nix-profile/share:$XDG_DATA_DIRS:/home/diegoroccia/.nix-profile/share/gsettings-schemas/gsettings-desktop-schemas-47.1"
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
    };

    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
      ];
      configPackages = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
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
    hyprpaper = {
      enable = true;

      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        # preload = [
        #   "~/Pictures/wallpapers/wp7058517-dragon-ball-minimalist-art-wallpapers.jpg"
        #   "~/Pictures/wallpapers/wp4957443-minimalist-desktop-wallpapers.jpg"
        #   "~/Pictures/wallpapers/wp5693139-minimalist-desktop-hd-wallpapers.jpg"
        # ];
        # wallpaper = [
        #   "eDP-1,                                                 ~/Pictures/wallpapers/wp7058517-dragon-ball-minimalist-art-wallpapers.jpg"
        #   "desc:LG Electronics LG Ultra HD 0x000122C8,            ~/Pictures/wallpapers/wp4957443-minimalist-desktop-wallpapers.jpg"
        #   "desc:Lenovo Group Limited LEN T23i-20 VNA66F1D,        ~/Pictures/wallpapers/wp5693139-minimalist-desktop-hd-wallpapers.jpg"
        # ];
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
    package = (config.lib.nixGL.wrap pkgs.hyprland);
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
    extraConfig = (builtins.readFile ./resources/hyprland.conf);
  };
}

