{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.05"; # Please read the comment before changing.

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      nix-recompile = "darwin-rebuild switch --flake ~/.config/nix#macos --impure";
    };
    shellInit = ''
           export NVM_DIR="$([ -z "~" ] && printf %s "~/.nvm" || printf %s "~/nvm")"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
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
