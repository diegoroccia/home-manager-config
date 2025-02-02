{pkgs, ... }: {

  home.packages = with pkgs; [
        nushell

        ];

  programs.nushell = {
        enable = true;
    };
}
