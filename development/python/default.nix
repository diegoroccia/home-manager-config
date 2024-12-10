{ inputs, config, pkgs, nixgl, ... }: {

  home.packages = with pkgs; [
    python3
    pipx
  ];
}
