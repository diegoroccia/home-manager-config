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
          };
          "ssh://git@github.bus.zalan.do/" = {
            insteadOf = "https://github.bus.zalan.do/";
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
    mimeApps.enable = true;

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

  # services.gpg-agent = {

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
        preload = [
          "~/Pictures/wallpapers/wp7058517-dragon-ball-minimalist-art-wallpapers.jpg"
          "~/Pictures/wallpapers/wp4957443-minimalist-desktop-wallpapers.jpg"
          "~/Pictures/wallpapers/wp5693139-minimalist-desktop-hd-wallpapers.jpg"
        ];
        wallpaper = [
          "eDP-1,                                                 ~/Pictures/wallpapers/wp7058517-dragon-ball-minimalist-art-wallpapers.jpg"
          "desc:LG Electronics LG Ultra HD 0x000122C8,            ~/Pictures/wallpapers/wp4957443-minimalist-desktop-wallpapers.jpg"
          "desc:Lenovo Group Limited LEN T23i-20 VNA66F1D,        ~/Pictures/wallpapers/wp5693139-minimalist-desktop-hd-wallpapers.jpg"
        ];
      };
    };
    dunst.enable = true;
    dunst.settings = (import ./resources/dunstrc.nix);
    network-manager-applet.enable = true;
    swayosd = {
      enable = true;
      stylePath = "${pkgs.swayosd}/etc/xdg/swayosd/style.css";
    };
    podman = import ./podman.nix;
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
