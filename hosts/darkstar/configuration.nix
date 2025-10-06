{ pkgs, config, inputs, ... }: {

  # Set the home directory for the user.
  users.users.sri.home = "/Users/sri";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Enable sudo authentication via Touch ID.
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    primaryUser = "sri";
    startup.chime = false;
    defaults = import ../../system/mac.nix { inherit pkgs; };
    
    # Backup conflicting files and install dependencies before activation
    activationScripts.preActivation.text = ''
      echo "Backing up existing system files..."
      mkdir -p /etc/nix-darwin-backup
      
      # Backup and remove conflicting files
      for file in bashrc zshrc shells; do
        if [ -f "/etc/$file" ]; then
          cp "/etc/$file" "/etc/nix-darwin-backup/$file.backup" 2>/dev/null || true
          rm -f "/etc/$file"
        fi
      done
      
      # Install Xcode Command Line Tools if missing
      if ! xcode-select -p >/dev/null 2>&1; then
        echo "Xcode Command Line Tools not found."
        
        # Check if Xcode app is installed
        if [ -d "/Applications/Xcode.app" ]; then
          echo "Xcode app found. Setting up Command Line Tools..."
          sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
        else
          echo "⚠️  Xcode will be installed from App Store. After installation, run:"
          echo "    sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer"
          echo "    Then re-run this command."
        fi
      else
        echo "✅ Xcode Command Line Tools are installed at: $(xcode-select -p)"
      fi
      
      # Install Rosetta if missing on Apple Silicon
      if [[ $(uname -m) == "arm64" ]] && ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
        echo "Installing Rosetta..."
        softwareupdate --install-rosetta --agree-to-license 2>/dev/null || {
          echo "⚠️  Rosetta installation failed. Please run: softwareupdate --install-rosetta"
          exit 1
        }
      fi
    '';
    
    activationScripts.postActivation.text = ''
      echo "Setting up LaunchBar sync..."
      
      # Create LaunchBar symlink for iCloud sync
      LAUNCHBAR_SUPPORT="/Users/sri/Library/Application Support/LaunchBar"
      ICLOUD_LAUNCHBAR="/Users/sri/Library/Mobile Documents/com~apple~CloudDocs/Apps/LaunchBar"
      
      # Create iCloud folder if it doesn't exist
      sudo -u sri mkdir -p "$ICLOUD_LAUNCHBAR"
      
      # Remove existing LaunchBar folder if it's not a symlink
      if [ -d "$LAUNCHBAR_SUPPORT" ] && [ ! -L "$LAUNCHBAR_SUPPORT" ]; then
        echo "Moving existing LaunchBar data to iCloud..."
        sudo -u sri mv "$LAUNCHBAR_SUPPORT" "$ICLOUD_LAUNCHBAR.backup"
      fi
      
      # Create symlink if it doesn't exist
      if [ ! -L "$LAUNCHBAR_SUPPORT" ]; then
        echo "Creating LaunchBar iCloud symlink..."
        sudo -u sri ln -sf "$ICLOUD_LAUNCHBAR" "$LAUNCHBAR_SUPPORT"
      fi
      
      # Set screenshot format to JPG
      echo "Setting screenshot format to JPG..."
      sudo -u sri defaults write com.apple.screencapture type jpg
      
      echo "Configuring Finder sidebar..."
      # Add sidebar items using mysides
      if command -v mysides >/dev/null 2>&1; then
        sudo -u sri mysides add ~/Documents 2>/dev/null || true
        sudo -u sri mysides add ~/Downloads 2>/dev/null || true  
        sudo -u sri mysides add ~/Movies 2>/dev/null || true
        sudo -u sri mysides add ~ 2>/dev/null || true
        echo "Added sidebar items with mysides"
      else
        echo "mysides not found - install with: brew install mysides"
      fi
    '';
  };
  
  # Keyboard settings
  system.keyboard.enableKeyMapping = true;

  # Packages
  homebrew = import ../../pkgs/brew.nix { inherit pkgs; };
  fonts = import ../../pkgs/fonts.nix { inherit pkgs; };

  # Environment
  environment = {
    shells = with pkgs; [
      fish
      nushell
      zsh
    ];
    systemPackages = import ../../pkgs/system.nix { inherit pkgs inputs; };
  };
}
