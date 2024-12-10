{ pkgs, lib, buildGoModule }:

buildGoModule rec {
  pname = "zregistry";
  version = "0.0.25";

  ldFlags = "-mod=mod";


  overrideModAttrs = _: {
    buildInputs = [
      pkgs.openssh
    ];
    preBuild = ''
      export HOME=$(mktemp -d)
      export GOPRIVATE=github.bus.zalan.do
      export GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=no"
      git config --global url.ssh://git@github.bus.zalan.do/.insteadOf https://github.bus.zalan.do/
      env
    '';
    impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
      "GIT_PROXY_COMMAND"
      "SOCKS_SERVER"
      "SSH_AUTH_SOCK"
    ];
  };

  src = builtins.fetchGit {
    url = "git@github.bus.zalan.do:teapot/zregistry.git";
    ref = "ref/tags/v${version}";
    rev = "eaa68db31c5cf7555326ca500d66f88a1582a174";
  };


  GOPRIVATE = "github.bus.zalan.do";
  vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

  ldflags = [ "-X main.version=v${version}" ];

  doCheck = false;

  meta = with lib; {
    description = "Official language server for the Go language";
    homepage = "https://github.com/golang/tools/tree/master/gopls";
    changelog = "https://github.com/golang/tools/releases/tag/${src.rev}";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mic92 rski SuperSandro2000 zimbatm ];
    mainProgram = "gopls";
  };
}
