{ pkgs, ... }:
{

  home.packages = with pkgs; [
    git-credential-gopass
    gopass
    gopass-jsonapi
  ];


  xdg = {
    configFile = {
      "gopass/gopass" = {
        text = (builtins.readFile ./gopass);
      };
    };
  };
}
