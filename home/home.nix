{ pkgs, lib, inputs, ... }: {

  home = {
    username = "sri";
    homeDirectory = "/Users/sri";
    stateVersion = "25.05";
    activation = import ./activation.nix { inherit pkgs lib inputs; };
    
    file = {
      ".config/starship-dark.toml".source = (pkgs.formats.toml {}).generate "starship-dark.toml" 
        ((import ./starship.nix { inherit pkgs; }).settings // { palette = "rosepine"; });
      ".config/starship-light.toml".source = (pkgs.formats.toml {}).generate "starship-light.toml" 
        ((import ./starship.nix { inherit pkgs; }).settings // { palette = "rosepine_dawn"; });
    };
  };

  programs = {
    home-manager.enable = true;
    atuin = import ./atuin.nix { inherit pkgs; };
    awscli = import ./aws.nix { inherit pkgs; };
    mise = import ./mise.nix { inherit pkgs; };
    nushell = import ./nu.nix { inherit pkgs; };
    starship = import ./starship.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs; };
    tmux = import ./tmux.nix { inherit pkgs; };
    carapace = import ./carapace.nix { inherit pkgs; };
    bat = import ./bat.nix { inherit pkgs inputs; };
    direnv = import ./direnv.nix { inherit pkgs; };
    btop = import ./btop.nix { inherit pkgs; };
    yazi = import ./yazi.nix { inherit pkgs; };
    lazygit = import ./lazygit.nix { inherit pkgs; };
    k9s = import ./k9s.nix { inherit pkgs; };
    ripgrep = import ./ripgrep.nix { inherit pkgs; };
    vscode = import ./vscode.nix { inherit pkgs; };
  };

  imports = [
    ./jetbrains.nix
    ./sublime.nix
    ./apple-setup.nix
    ./wallpaper.nix
    ./karabiner.nix
    ./ghostty.nix
    ./opencode.nix
    ./docker-config.nix
  ];
}
