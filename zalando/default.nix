{ config, pkgs, lib, ... }:

let
  zregistry = (pkgs.callPackage ./zregistry.nix { });
in
{

  home.packages = [
    zregistry
  ];


}
