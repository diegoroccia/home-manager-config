{ lib, ... }:

with lib;
{
  imports = [
    ./go
    ./python
  ];
}
