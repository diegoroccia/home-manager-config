{ inputs, config, pkgs, nixgl, ... }: {

  home.packages = with pkgs; [
    temurin-bin-23
  ];
}
