{ inputs, config, pkgs, ... }: {

    programs = {

        wezterm = {
          enable = true;
          enableZshIntegration = true;
          package = inputs.wezterm.packages.${pkgs.system}.default;
          extraConfig = (builtins.readFile ./wezterm.lua);
        };

        ghostty = {
        enable = true;
        installBatSyntax = true;
        enableZshIntegration = true;
        package = inputs.ghostty.packages.x86_64-linux.default;
        settings = {
                theme = "catppuccin-mocha";
                window-decoration = false;
                shell-integration = "detect";
                adjust-cell-height = "50%";
                window-padding-x = 10;
                window-padding-y = 10;
            };
        };
    };
}
