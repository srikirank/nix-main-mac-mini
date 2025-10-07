{ pkgs, lib, stdenv, python3 }:

stdenv.mkDerivation rec {
  pname = "time-of-day-wallpapers";
  version = "1.0.0";

  nativeBuildInputs = [ python3 ];

  propagatedBuildInputs = with python3.pkgs; [
    requests
    tqdm
    urllib3
  ];

  unpackPhase = "true";

  buildPhase = ''
    # Create a filtered downloader script
    cat > filtered_downloader.py << 'EOF'
import json
import requests
import os
import re
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor
import urllib3

urllib3.disable_warnings()

def get_filtered_aerials():
    """Get aerials with Day, Night, Evening, Morning in their names"""
    try:
        response = requests.get("https://sylvan.apple.com/Aerials/resources-13/entries.json")
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
    """Download a single file with progress bar"""
    try:
        response = requests.get(url, stream=True)
        total_size = int(response.headers.get('content-length', 0))
        
        with open(filepath, 'wb') as f, tqdm(
            desc=name[:30],
            total=total_size,
            unit='B',
            unit_scale=True,
            unit_divisor=1024,
        ) as pbar:
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)
                    pbar.update(len(chunk))
        return True
    except Exception as e:
        print(f"Error downloading {name}: {e}")
        return False

def main():
    output_dir = os.environ.get("WALLPAPER_DIR", "./wallpapers")
    os.makedirs(output_dir, exist_ok=True)
    
    print("Fetching wallpaper list...")
    aerials = get_filtered_aerials()
    
    if not aerials:
        print("No wallpapers found matching criteria")
        return
    
    print(f"Found {len(aerials)} wallpapers with time-of-day keywords")
    
    # Download with threading
    max_workers = int(os.environ.get("DOWNLOAD_THREADS", "3"))
    
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = []
        for aerial in aerials:
            if aerial["url"]:
                filename = f"{aerial['id']}_{aerial['name'].replace(' ', '_').replace('/', '_')}.mov"
                filepath = os.path.join(output_dir, filename)
                
                if not os.path.exists(filepath):
                    future = executor.submit(download_file, aerial["url"], filepath, aerial["name"])
                    futures.append(future)
                else:
                    print(f"Skipping {aerial['name']} (already exists)")
        
        # Wait for all downloads
        for future in futures:
            future.result()
    
    print(f"Downloads completed. Files saved to: {output_dir}")

if __name__ == "__main__":
    main()
EOF
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/wallpapers
    
    # Run the filtered downloader
    export WALLPAPER_DIR=$out/share/wallpapers
    ${python3}/bin/python3 filtered_downloader.py
    
    # Create a simple script to access wallpapers
    cat > $out/bin/list-wallpapers << 'EOF'
#!/bin/sh
ls -la $out/share/wallpapers/
EOF
    chmod +x $out/bin/list-wallpapers
  '';

  meta = with lib; {
    description = "Time-of-day filtered Apple aerial wallpapers";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
