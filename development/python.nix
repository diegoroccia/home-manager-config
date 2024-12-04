{ inputs, config, pkgs, nixgl, ... }: {

  home.packages = with pkgs; [
      python3
      python39
      pipx
  ];
}
