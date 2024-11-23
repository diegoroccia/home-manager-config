{ config, ... }: {

  services = {
    git-sync = {
      enable = true;
      repositories = {
        neovim = {
          path =
            "${config.home.homeDirectory}/.config/nvim";
          uri = "https://git.bluesman.it/diego/nvim.git";
      };
      };

  };
  };
}

