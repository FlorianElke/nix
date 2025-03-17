{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.05";

  programs.zsh = {
    enable = true;
    initExtra = ''
            export NVM_DIR="$HOME/.nvm"
      [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
      [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
    '';
    shellAliases = {
      ll = "ls -l";
      nix-recompile = "darwin-rebuild switch --flake ~/.config/nix#macos --impure";
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.git = {
    enable = true;
    userName = "Florian Elke";
    userEmail = "flo@gentlent.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager.enable = true;
}
