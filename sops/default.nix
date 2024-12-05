{ config, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.gnupg.home = "${config.home.homeDirectory}/.gnupg";
  sops.gnupg.sshKeyPaths = [];
  sops.secrets.password = { };

}
