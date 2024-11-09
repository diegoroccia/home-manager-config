{ inputs, config, pkgs, nixgl, ... }: {

  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  home = {
    username = "diegoroccia";
    homeDirectory = "/home/diegoroccia";
    preferXdgDirectories = true;
    stateVersion = "23.05";
    packages = with pkgs; [

      # GUI
      inputs.wezterm.packages.${pkgs.system}.default
      ags
      dunst
      google-chrome
      hyprpicker
      rofi-wayland

      # Security
      age
      age-plugin-yubikey
      bitwarden
      git-credential-gopass
      gopass
      gopass-jsonapi
      sops

      # Console
      btop
      chezmoi
      fzf
      gh
      git
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
    go = {
      enable = true;
    };
    awscli = {
      enable = true;
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = import ./oh-my-posh.nix;
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

  xdg.mimeApps.enable = true;

  xdg.configFile = {
    "environment.d/envvars.conf" = {
      text = ''
        PATH="$HOME/.nix-profile/bin:$PATH"
        XDG_DATA_DIRS="/home/diegoroccia/.nix-profile/share:$XDG_DATA_DIRS"
        NIXOS_OZONE_WL="1";
      '';
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
    xdgOpenUsePortal = true;
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
    dunst.enable = true;
    dunst.settings = (import ./resources/dunstrc.nix);
    network-manager-applet.enable = true;
    swayosd.enable = true;
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
