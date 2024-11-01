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
      rofi-wayland
      dunst
      wlogout
      chezmoi
      gitFull
      git-lfs
      delta
      age
      age-plugin-yubikey
      jq
      yq-go
      hyprpicker
      chromium
      google-chrome
      gh
      fzf
      tmux
      cargo
      noto-fonts
      noto-fonts-emoji
      material-design-icons
      font-awesome
      weather-icons
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "FantasqueSansMono"
          "Hack"
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
    neomutt = {
      enable = true;
      vimKeys = true;
    };
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


  wayland.windowManager.hyprland = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.hyprland);
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
    extraConfig = ''
      general {
        border_size=2
        col.active_border=rgba(df8e1dff) 45deg
        col.inactive_border=rgba(595959aa)
        gaps_in=3
        gaps_out=40
        layout=master
      }
      env = wlr_renderer_allow_software=1
      env = moz_enable_wayland,1
      env = gdk_backend,wayland
      env = qt_qpa_platform,wayland
      env = sdl_videodriver,wayland
      env = clutter_backend,wayland
      env = xdg_current_desktop,hyprland
      env = xdg_session_type,wayland
      env = xdg_session_desktop,hyprland
      env = qt_auto_screen_scale_factor,1
      env = qt_qpa_platform,wayland;xcb
      env = qt_wayland_disable_windowdecoration,1
      env = qt_qpa_platformtheme=qt5ct
      env = xcursor_size,24
      env = gtk_theme,catppuccin-mocha-standard-teal-dark
      # env = gdk_scale,2


      xwayland {
        force_zero_scaling = true
      }

      $notifycmd = notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low

      # execute your favorite apps at launch
      exec = dbus-update-activation-environment --systemd --all
      exec = kanshi
      exec-once = wlsunset -o edp-1 -l 52.5 -l 13.4
      exec-once = ags
      exec-once = /usr/lib/polkit-1/polkitd --no-debug
      exec-once = nm-applet --indicator
      exec-once = blueman-applet
      exec = swaybg -i $(find ~/Pictures/wallpapers -iname \*.png | shuf -n1)
      exec-once = systemctl --user start xdg-desktop-portal-hyprland
      exec-once = systemctl --user start xdg-desktop-portal-wlr


      # for all categories, see https://wiki.hyprland.org/configuring/variables/
      input {
          kb_layout = us
          kb_variant = intl
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = false
              disable_while_typing = true
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      decoration {
          # see https://wiki.hyprland.org/configuring/variables/ for more

          rounding = 5

          drop_shadow = false
          shadow_range = 20 
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)

          dim_inactive = false

          # dim_special = 0.8
          blur {
           special = true
          }
      }

      animations {
          enabled = true

          bezier=overshot,0.05,0.9,0.1,1.1

          animation=windows,1,5,overshot,popin 80%
          animation=workspaces,1,3,overshot,slide
      }

      master {
          # see https://wiki.hyprland.org/configuring/master-layout/ for more
          orientation = left
          allow_small_split = true
          no_gaps_when_only = 0
      }

      gestures {
          workspace_swipe = true
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        mouse_move_enables_dpms = true
        # vfr = true
        # vrr = 0
        animate_manual_resizes = true
        mouse_move_focuses_monitor = true
        vrr = 2
      }
      #
      # xwayland {
      # force_zero_scaling = true
      # }

      # example windowrule v1
      # windowrule = float, ^(kitty)$
      # example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # see https://wiki.hyprland.org/configuring/window-rules/ for more

      windowrulev2 = monitor edp-1, title:^(telegram)(.*)$
      windowrulev2 = workspace 9, title:^(telegram)(.*)$
      windowrulev2 = noshadow, title:^(telegram)(.*)$
      windowrule = float,flameshot
      windowrule = move 0 0,flameshot
      windowrule = noanim,flameshot

      $terminal = wezterm

      # example binds, see https://wiki.hyprland.org/configuring/binds/ for more
      bind = super, return, exec, $terminal
      bind = super, q, killactive,
      bind = super_shift, e , exit,
      bind = super, v, togglefloating,
      bind = super, f, fullscreen,
      bind = super, m, fullscreen, 1
      bind = super, space, exec, rofi -show drun

      bind = super, h, movefocus, l
      bind = super, l, movefocus, r
      bind = super, k, movefocus, u
      bind = super, j, movefocus, d

      bind = super_shift, h, movewindow, l
      bind = super_shift, l, movewindow, r
      bind = super_shift, k, movewindow, u
      bind = super_shift, j, movewindow, d

      bind = super_shift, return, layoutmsg, swapwithmaster master

      bind= super alt, k, layoutmsg,addmaster
      bind= super alt, j, layoutmsg,removemaster

      bind = super, 1, workspace, 1
      bind = super, 2, workspace, 2
      bind = super, 3, workspace, 3
      bind = super, 4, workspace, 4
      bind = super, 5, workspace, 5
      bind = super, 6, workspace, 6
      bind = super, 7, workspace, 7
      bind = super, 8, workspace, 8
      bind = super, 9, workspace, 9
      bind = super, 0, workspace, 10

      bind = super, right, workspace, +1
      bind = super, left, workspace, -1

      # move active window to a workspace with mainmod + shift + [0-9]
      bind = super shift, 1, movetoworkspace, 1
      bind = super shift, 2, movetoworkspace, 2
      bind = super shift, 3, movetoworkspace, 3
      bind = super shift, 4, movetoworkspace, 4
      bind = super shift, 5, movetoworkspace, 5
      bind = super shift, 6, movetoworkspace, 6
      bind = super shift, 7, movetoworkspace, 7
      bind = super shift, 8, movetoworkspace, 8
      bind = super shift, 9, movetoworkspace, 9
      bind = super shift, 0, movetoworkspace, 10

      # scroll through existing workspaces with mainmod + scroll
      bind = super, mouse_down, workspace, e+1
      bind = super, mouse_up, workspace, e-1

      # move/resize windows with mainmod + lmb/rmb and dragging
      bindm = super, mouse:272, movewindow
      bindm = super, mouse:273, resizewindow

      bind = super, a, togglespecialworkspace
      bind = supershift, a, movetoworkspace, special
      bind = super, a, exec, $notifycmd 'toggled special workspace'
      bind = super, c, exec, hyprctl dispatch centerwindow

      bindl =, xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl =, xf86audiomicmute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindle =, xf86audioraisevolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      bindle =, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindle =, xf86monbrightnessup, exec, brightnessctl s +10%
      bindle =, xf86monbrightnessdown, exec, brightnessctl s 10%-

      bind =, print, exec, grim -g "$(slurp)" - | wl-copy --type=image/png

      bind = ctrl alt, l, exec, hyprlock
      bind = super, b, exec, ags -t outerbar

      $monitorlaptop = edp-1
      $monitor4k = desc:lg electronics lg ultra hd 0x000122c8
      $monitorvertical = desc:lenovo group limited len t23i-20 vna66f1d

      #monitor=$monitorlaptop,highres,0x0,auto
      #monitor=$monitor4k,2560x1440@59.951000,1280x0, auto
      #monitor=$monitorvertical,preferred,auto,auto,transform,1
      #monitor=,preferred,auto,1

      workspace = s[true], gapsout:100, rounding:false, bordersize:0
    '';
  };
}
