{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Theme repositories
    rose-btop = {
      url = "github:rose-pine/btop";
      flake = false;
    };
    rose-yazi = {
      url = "github:Msouza91/rose-pine.yazi";
      flake = false;
    };
    rose-bat = {
      url = "github:rose-pine/tm-theme";
      flake = false;
    };
    k9s-repo = {
      url = "github:derailed/k9s";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, vscode-extensions, home-manager, rose-btop, rose-yazi, rose-bat, k9s-repo }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ 
          vscode-extensions.overlays.default
        ];
      };
    in
    {
      # Custom packages
      packages.${system} = {
        time-of-day-wallpapers = pkgs.callPackage ./pkgs/wallpapers.nix {};
      };

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#darkstar
      darwinConfigurations."darkstar" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs pkgs; };
        modules = [
          ./hosts/darkstar/configuration.nix
          {
            nixpkgs.pkgs = pkgs;
            # Speed up builds
            nix.settings = {
              max-jobs = "auto";
              cores = 0;  # Use all available cores
              substituters = [
                "https://cache.nixos.org"
                "https://nix-community.cachix.org"
              ];
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs pkgs; };
              useGlobalPkgs = true;
              useUserPackages = false;
              backupFileExtension = "bak";
              users.kiran = import ./home/home.nix;
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "kiran";
            };
          }
        ];
      };
    };
}
