{
  description = "Florian Elke nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    alejandra.url = "github:kamadorueda/alejandra/3.1.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    alejandra,
    home-manager,
  }: let
    configuration = {
      pkgs,
      config,
      lib,
      ...
    }: {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = [
        pkgs.vim
        pkgs.mkalias
        pkgs.alejandra
        pkgs.git
      ];

      fonts.packages = with pkgs; [fira-code];

      users.users.florian = {
        home = lib.mkDefault "/Users/florian";
      };

      system.defaults = {
        dock.tilesize = 45;
        dock.show-recents = false;
        dock.persistent-others = [];
        dock.minimize-to-application = true;
        dock.orientation = "left";
        dock.persistent-apps = [
          "/Applications/Google Chrome.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/1Password.app"
          "/Applications/Warp.app"
          "/Applications/Spotify.app"
          "/Applications/Postman.app"
        ];
      };

      homebrew = {
        enable = true;
        brews = [
          "httpie"
          "nvm"
        ];
        casks = [
          "warp"
          "google-chrome"
          "visual-studio-code"
          "1password"
          "spotify"
          "chatgpt"
          "microsoft-teams"
          "font-fira-code"
          "flycut"
          "postman"
          "docker"
          "dbeaver-community"
        ];

        onActivation.cleanup = "zap";
      };

      nix.settings.experimental-features = "nix-command flakes";
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = false;
            user = "florian";
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.florian = import ./user.nix;
        }
      ];
    };
    darwinPackages = self.darwinConfigurations."macos".pkgs;
  };
}
