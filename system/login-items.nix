{ pkgs, ... }: {
  system.activationScripts.loginItems.text = ''
    echo "Configuring login items..."
    
    # Check current WiFi network
    current_wifi=$(networksetup -getairportnetwork en0 | cut -d' ' -f4-)
    echo "Current WiFi network: $current_wifi"
    
    # List of applications to start at login
    # Format: "app_path|hidden_flag"
    # hidden_flag: true = hidden, false = visible
    
    LOGIN_ITEMS=(
      "/Applications/Raycast.app|true"
      "/Applications/1Password 7 - Password Manager.app|true"
      "/Applications/Bartender 4.app|true"
      "/Applications/LaunchBar.app|true"
      "/System/Volumes/Data/Applications/Nix Apps/iStat Menus.app|true"
      # Add more apps here in the format:
      # "/Applications/Your App Name.app|false"
    )
    
    # SMB shares to mount when on specific networks
    # Format: "network_name|smb_path|mount_point"
    SMB_SHARES=(
      "RUAKS|smb://ruak-nas.local|/Volumes/RUAK-NAS"
      # Add more shares here:
      # "MyNetwork|smb://my-server.local|/Volumes/MyServer"
    )
    
    # Remove existing login items first (optional - uncomment if needed)
    # sudo -u sri osascript -e 'tell application "System Events" to delete every login item'
    
    # Add each app to login items
    for item in "''${LOGIN_ITEMS[@]}"; do
      app_path=$(echo "$item" | cut -d'|' -f1)
      hidden_flag=$(echo "$item" | cut -d'|' -f2)
      
      if [ -d "$app_path" ]; then
        echo "Adding login item: $app_path (hidden: $hidden_flag)"
        sudo -u sri osascript -e "tell application \"System Events\" to make login item at end with properties {path:\"$app_path\", hidden:$hidden_flag}"
      else
        echo "Warning: $app_path not found, skipping..."
      fi
    done
    
    # Mount SMB shares based on current network
    for share in "''${SMB_SHARES[@]}"; do
      network_name=RUAKS
      smb_path=$(echo "$share" | cut -d'|' -f2)
      mount_point=$(echo "$share" | cut -d'|' -f3)
      
      if [[ "$current_wifi" == "$network_name" ]]; then
        echo "On $network_name network, mounting $smb_path..."
        
        # Create mount point if it doesn't exist
        sudo mkdir -p "$mount_point"
        
        # Check if already mounted
        if ! mount | grep -q "$mount_point"; then
          # Mount the SMB share (will prompt for credentials if needed)
          sudo -u sri osascript -e "tell application \"Finder\" to open location \"$smb_path\""
          echo "Mounted $smb_path"
        else
          echo "$smb_path already mounted"
        fi
      else
        echo "Not on $network_name network, skipping $smb_path"
      fi
    done
    
    echo "Login items configuration complete."
  '';
}
