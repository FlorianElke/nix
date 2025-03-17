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
