{
  enable = true;
  containers = {
    homarr = {
      image = "ghcr.io/ajnart/homarr:latest";
      ports = [
        "7575:7575"
      ];
      autoStart = true;
    };
  };
}
