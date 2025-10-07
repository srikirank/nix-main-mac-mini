{ pkgs, lib, writeShellScript, python3 }:

writeShellScript "download-time-of-day-wallpapers" ''
  set -e
  
  WALLPAPER_DIR="$HOME/.local/share/wallpapers/time-of-day"
  mkdir -p "$WALLPAPER_DIR"
  
  # Create Python downloader script
  cat > /tmp/wallpaper_downloader.py << 'EOF'
import json
import requests
import os
import sys
from concurrent.futures import ThreadPoolExecutor
import urllib3

urllib3.disable_warnings()

def get_filtered_aerials():
    """Get aerials with Day, Night, Evening, Morning in their names"""
    try:
        print("Fetching wallpaper list from Apple...")
        response = requests.get("https://sylvan.apple.com/Aerials/resources-13/entries.json", timeout=30)
        data = response.json()
        
        keywords = ["Day", "Night", "Evening", "Morning"]
        filtered_aerials = []
        
        for asset in data.get("assets", []):
            label = asset.get("accessibilityLabel", "")
            if any(keyword.lower() in label.lower() for keyword in keywords):
                filtered_aerials.append({
                    "name": label,
                    "url": asset.get("url4KSDR240FPS", asset.get("url1080pSDR", "")),
                    "id": asset.get("id", "")
                })
        
        return filtered_aerials
    except Exception as e:
        print(f"Error fetching aerials: {e}")
        return []

def download_file(url, filepath, name):
    """Download a single file"""
    try:
        if os.path.exists(filepath):
            print(f"Skipping {name} (already exists)")
            return True
            
        print(f"Downloading {name}...")
        response = requests.get(url, stream=True, timeout=300)
        total_size = int(response.headers.get('content-length', 0))
        
        with open(filepath, 'wb') as f:
            downloaded = 0
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)
                    downloaded += len(chunk)
                    if total_size > 0:
                        percent = (downloaded / total_size) * 100
                        print(f"\r{name[:30]}: {percent:.1f}%", end="", flush=True)
        
        print(f"\n✓ Downloaded {name}")
        return True
    except Exception as e:
        print(f"\n✗ Error downloading {name}: {e}")
        return False

def main():
    output_dir = sys.argv[1] if len(sys.argv) > 1 else "./wallpapers"
    os.makedirs(output_dir, exist_ok=True)
    
    aerials = get_filtered_aerials()
    
    if not aerials:
        print("No wallpapers found matching criteria")
        return
    
    print(f"Found {len(aerials)} wallpapers with time-of-day keywords")
    
    # Download with limited threading to be nice to Apple's servers
    max_workers = 2
    
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = []
        for aerial in aerials:
            if aerial["url"]:
                filename = f"{aerial['id']}_{aerial['name'].replace(' ', '_').replace('/', '_')}.mov"
                filepath = os.path.join(output_dir, filename)
                future = executor.submit(download_file, aerial["url"], filepath, aerial["name"])
                futures.append(future)
        
        # Wait for all downloads
        success_count = sum(1 for future in futures if future.result())
    
    print(f"\nDownload completed: {success_count}/{len(futures)} wallpapers downloaded to {output_dir}")

if __name__ == "__main__":
    main()
EOF

  # Run the Python script
  ${python3}/bin/python3 /tmp/wallpaper_downloader.py "$WALLPAPER_DIR"
  
  # Clean up
  rm -f /tmp/wallpaper_downloader.py
  
  echo "Time-of-day wallpapers are available in: $WALLPAPER_DIR"
''
