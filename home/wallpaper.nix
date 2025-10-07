{ pkgs, lib, ... }: 
let
  wallpaperDownloader = pkgs.callPackage ../pkgs/wallpaper-downloader.nix {};
in {
  home.activation.wallpaperSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Download time-of-day wallpapers if they don't exist
    WALLPAPER_DIR="$HOME/.local/share/wallpapers/time-of-day"
    
    if [ ! -d "$WALLPAPER_DIR" ] || [ -z "$(ls -A "$WALLPAPER_DIR" 2>/dev/null)" ]; then
      echo "Downloading time-of-day wallpapers..."
      ${wallpaperDownloader}
    else
      echo "Time-of-day wallpapers already exist in $WALLPAPER_DIR"
    fi
    
    # Set up wallpaper rotation if wallpapers exist
    if [ -d "$WALLPAPER_DIR" ] && [ "$(ls -A "$WALLPAPER_DIR" 2>/dev/null)" ]; then
      /usr/bin/osascript -e "
        tell application \"System Events\"
          tell every desktop
            set picture rotation to 1
            set random order to true
            set change interval to 1800
            set pictures folder to \"$WALLPAPER_DIR\"
          end tell
        end tell
      "
      echo "Wallpaper rotation configured for: $WALLPAPER_DIR"
    else
      echo "No wallpapers found, skipping wallpaper configuration"
    fi
  '';
}
