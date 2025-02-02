{
  mainBar = {
    margin = "5 5 0 5";
    modules-left = [ "sway/workspaces" "hyprland/workspaces" "hyprland/window" ];
    modules-center = [ ];
    modules-right = [ "pulseaudio" "battery" "clock" "tray" ];

    "hyprland/workspaces" = {
      disable-scroll = true;
    };

    "sway/workspaces" = {
      disable-scroll = true;
    };

    "sway/language" = {
      format = "{} ";
      min-length = 5;
      tooltip = false;
    };

    "keyboard-state" = {
      capslock = true;
      format = "{name} {icon} ";
      format-icons = {
        locked = " ";
        unlocked = "";
      };
    };

    "clock" = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format = "{:%a, %d %b, %I:%M %p}";
    };

    pulseaudio = {
      reverse-scrolling = 1;
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = "婢 {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "奄" "奔" "墳" ];
      };
      on-click = "pavucontrol";
      min-length = 13;
    };

    temperature = {
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format-icons = [ "" "" "" "" "" ];
      tooltip = false;
    };

    backlight = {
      device = "intel_backlight";
      format = "{percent}% {icon}";
      format-icons = [ "" "" "" "" "" "" "" ];
      min-length = 7;
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
    };

    tray = {
      icon-size = 16;
      spacing = 0;
    };
  };
}
