{ pkgs, config, inputs, ... }: {

  # Set the home directory for the user.
  users.users.kiran.home = "/Users/kiran";

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

    primaryUser = "kiran";
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
      LAUNCHBAR_SUPPORT="/Users/kiran/Library/Application Support/LaunchBar"
      ICLOUD_LAUNCHBAR="/Users/kiran/Library/Mobile Documents/com~apple~CloudDocs/Apps/LaunchBar"
      
      # Create iCloud folder if it doesn't exist
      sudo -u kiran mkdir -p "$ICLOUD_LAUNCHBAR"
            
      # Create symlink if it doesn't exist
      if [ ! -L "$LAUNCHBAR_SUPPORT" ]; then
        echo "Creating LaunchBar iCloud symlink..."
        sudo -u kiran ln -sf "$ICLOUD_LAUNCHBAR" "$LAUNCHBAR_SUPPORT"
      fi
      
      # Set screenshot format to JPG
      echo "Setting screenshot format to JPG..."
      sudo -u kiran defaults write com.apple.screencapture type jpg


      MISE_BIN="/run/current-system/sw/bin/mise"

      if command -v mise &> /dev/null; then
        echo "Installing mise tools..."
        $MISE_BIN install -y
      fi

      # Configure login items
      echo "=== Configuring login items ==="
      
      # Clear all existing login items first
      sudo -u kiran osascript -e 'tell application "System Events" to repeat while (count of login items) > 0' -e 'delete login item 1' -e 'end repeat'
      
      LOGIN_ITEMS=(
        "/Applications/Raycast.app|true"
        "/Applications/1Password 7.app|true"
        "/Applications/Bartender 6.app|true"
        "/Applications/LaunchBar.app|true"
        "/System/Volumes/Data/Applications/Things3.app|true"
        "/System/Volumes/Data/Applications/Google Drive.app|true"
        "/System/Volumes/Data/Applications/Dropbox.app|true"
      )
      
      for item in "''${LOGIN_ITEMS[@]}"; do
        app_path=$(echo "$item" | cut -d'|' -f1)
        hidden_flag=$(echo "$item" | cut -d'|' -f2)
        
        echo "  Adding: $app_path (hidden: $hidden_flag)"
        sudo -u kiran osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$app_path\", hidden:$hidden_flag}" 2>/dev/null || echo "    ⚠️  Failed to add: $app_path"
      done
      
      echo "=== Login items configuration complete ==="
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
