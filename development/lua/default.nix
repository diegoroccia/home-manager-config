{ inputs, config, pkgs, nixgl, ... }: {

  home.packages = with pkgs; [
        luajit
        love
  ];
}
