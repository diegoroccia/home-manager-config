{ inputs, config, pkgs, ... }: {

  imports = [ 
    ./sops
    ./development 
    ./console 
    ./desktopEnvironment
  ];

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
      ripgrep
      silver-searcher

      kyverno

      cargo
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

    systemDirs = {
      data = [
        "${config.home.homeDirectory}/.local/share"
        "/usr/local/share"
      ];
    };
  };

  services = {
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
}

