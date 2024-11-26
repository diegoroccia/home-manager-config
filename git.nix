{ config, ... }: {

  services = {
    git-sync = {
      enable = true;
      repositories = {
        neovim = {
          path = "${config.home.homeDirectory}/.config/nvim";
          uri = "ssh://git@192.168.1.11:222/diego/nvim.git";
        };
      };
    };
  };
}

