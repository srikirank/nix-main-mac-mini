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

      # Pull Ollama Models
      OLLAMA_BIN="/opt/homebrew/bin/ollama"
      $OLLAMA_BIN pull qwen3:30b-a3b    # Your main model
      $OLLAMA_BIN pull qwq:32b          # For deep reasoning/complex bug fixing
      $OLLAMA_BIN pull qwen3:4b         # For lightning-fast autocomplete
      $OLLAMA_BIN pull nomic-embed-text # Codebase indexing
      $OLLAMA_BIN pull gpt-oss:20b      # General versatile Coder

      # To force a restart of the agent:
      # Use a variable to avoid SC2046 and ensure we target the real user, not root
      TARGET_USER="sri"
      USER_ID=$(id -u "$TARGET_USER")
      PLIST="/Users/$TARGET_USER/Library/LaunchAgents/org.nixos.ollama.plist"

      echo "Refining AI Infrastructure for user $TARGET_USER (ID: $USER_ID)..."

      # Check if the service is already loaded in the GUI domain
      if /bin/launchctl print "gui/$USER_ID/org.nixos.ollama" >/dev/null 2>&1; then
        echo "Service exists. Kickstarting to reload environment (64k context)..."
        /bin/launchctl kickstart -k "gui/$USER_ID/org.nixos.ollama"
      else
        echo "Service not found. Bootstrapping fresh..."
        /bin/launchctl bootstrap "gui/$USER_ID" "$PLIST"
      fi

      echo "Checking Ollama models..."
      # Ensure Ollama is running (or start it briefly) before running these
      # We use 'ollama list' to check for existing models

      # Function to bake a Pro model
      bake_model() {
        local base=$1
        local target=$2
        if ! $OLLAMA_BIN list | grep -q "$target"; then
          echo "Baking $target with 64k context..."
          printf "FROM %s\nPARAMETER num_ctx 65536" "$base" > /tmp/Modelfile
          $OLLAMA_BIN create "$target" -f /tmp/Modelfile
          rm /tmp/Modelfile
        fi
      }

      # Bake your principal-engineer-grade models
      bake_model "qwen3:30b-a3b" "qwen3:pro"
      bake_model "qwq:32b" "qwq:pro"
      bake_model "gpt-oss:20b" "gpt-oss:pro"

      # Install Mise Tools
      /run/current-system/sw/bin/mise bin-paths
      /run/current-system/sw/bin/mise use --global go@latest
      /run/current-system/sw/bin/mise use --global python@latest
      /run/current-system/sw/bin/mise use --global node@latest
      /run/current-system/sw/bin/mise use --global java@21

      # Configure login items
      echo "=== Configuring login items ==="
      
      # Clear all existing login items first
      sudo -u sri osascript -e 'tell application "System Events" to delete login items 1 thru -1'
      
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
        sudo -u sri osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$app_path\", hidden:$hidden_flag}" 2>/dev/null || echo "    ⚠️  Failed to add: $app_path"
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
