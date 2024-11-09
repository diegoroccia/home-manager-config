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
      inputs.wezterm.packages.${pkgs.system}.default
      ags
      rofi-wayland
      dunst
      chezmoi
      sops
      age
      age-plugin-yubikey
      jq
      hyprpicker
      google-chrome
      gh
      fzf

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
  };

  fonts.fontconfig.enable = true;

  xdg.configFile."environment.d/envvars.conf".text = ''
    PATH="$HOME/.nix-profile/bin:$PATH"
    XDG_DATA_DIRS="/home/diegoroccia/.nix-profile/share:$XDG_DATA_DIRS"
    NIXOS_OZONE_WL="1";
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
    xdgOpenUsePortal = true;
  };

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };

  services = {
    wlsunset = {
      enable = true;
      latitude = 52.5200;
      longitude = 13.4050;
    };
    blanket.enable = true;
    blueman-applet.enable = true;
    dunst.enable = true;
    dunst.settings = (builtins.fromTOML (builtins.readFile ./resources/dunstrc.toml));
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
