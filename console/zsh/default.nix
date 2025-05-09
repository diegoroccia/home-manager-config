{ pkgs, inputs, ... }: {

  home.packages = with pkgs; [
    onefetch
    chezmoi
    imgcat
    gh
    jq
    podman
    tmux
    # inputs.neovim-nightly.packages.${system}.default
    # neovim-unwrapped
    wl-clipboard
  ];

  programs = {
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = import ./oh-my-posh.nix;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      dotDir = ".config/zsh";
      initExtraFirst = (builtins.readFile ./zshrc);
      shellAliases = {
        "hms" = "home-manager switch -b backup --flake ~/.config/home-manager";
        "gp" = "git pull";
        "gpp" = "git push";
        "gcp" = "git commit -am '`date`'; git push";
        "vim" = "nvim";
        "v" = "nvim";
        "cat" = "bat";
        "zaws" = "zalando-aws-cli";
      };
      autosuggestion = {
                enable = true;
                strategy = [ "completion" "match_prev_cmd" "history"  ];
            };
      syntaxHighlighting.enable = true;
      history = {
        append = true;
        extended = true;
        ignoreDups = true;
        ignorePatterns = [
          "rm -rf"
          "rm *"
        ];
        share = true;
      };
      antidote = {
        enable = true;
        plugins = [
          "ohmyzsh/ohmyzsh path:lib"
          "ohmyzsh/ohmyzsh path:plugins/tmux"
          "ohmyzsh/ohmyzsh path:plugins/fzf"
          "ohmyzsh/ohmyzsh path:plugins/sudo"
          "ohmyzsh/ohmyzsh path:plugins/aws"
          "ohmyzsh/ohmyzsh path:plugins/kubectx"
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-completions"
          "catppuccin/zsh-syntax-highlighting path:themes/catppuccin_frappe-zsh-syntax-highlighting.zsh"
        ];
      };
    };
  };
}
