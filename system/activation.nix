{ pkgs, ... }: {
  system.activationScripts.loginItems.text = ''
    # Clear all existing login items
    /usr/bin/osascript -e 'tell application "System Events" to delete every login item'
    
    # Add desired login items
    /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Raycast.app", hidden:false}'
  '';
}
