{ inputs, config, pkgs, nixgl, ... }: {

  home.packages = with pkgs; [
    nodejs_22
    yarn
  ];
}
