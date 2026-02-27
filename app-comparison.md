# Application Comparison: Installed vs Nix Configuration

## 📊 Summary
- **Total Installed Apps**: 88 apps
- **Apps in Nix Config**: 20 apps  
- **Missing from Nix**: 68 apps
- **Coverage**: 23%

## 🔍 Apps Missing from Nix Configuration

| App Name | Category | Location | Recommendation |
|----------|----------|----------|----------------|
| **1Password for Safari** | Security | /Applications | ✅ Add to Nix (essential) |
| **Alfred 5** | Productivity | /Applications | ⚠️ Conflicts with Raycast |
| **Amazon Q** | AI/Development | /Applications | ✅ Add to Nix (work tool) |
| **Authy** | Security | /Applications | ✅ Add to Nix (2FA) |
| **Bartender 6** | System Utility | /Applications | ✅ Add to Nix (menu bar) |
| **Beeper** | Communication | /Applications | ✅ Add to Nix (messaging) |
| **Blackmagic Disk Speed Test** | System Utility | /Applications | 🤔 Optional (testing) |
| **BrowserExtension** | Browser Utility | /Applications | ❌ Skip (generic) |
| **calibre** | Media/Books | /Applications | ✅ Add to Nix (ebook mgmt) |
| **Capital One Shopping** | Finance | /Applications | 🤔 Optional (browser ext) |
| **CheatSheet** | Productivity | /Applications | ✅ Add to Nix (shortcuts) |
| **Comet** | Browser | /Applications | ✅ Add to Nix (browser) |
| **Dark Night** | System Utility | /Applications | 🤔 Optional (dark mode) |
| **DevUtils** | Development | /Applications | ✅ Add to Nix (dev tools) |
| **Dropbox** | Cloud Storage | /Applications | ✅ Add to Nix (storage) |
| **Eno From Capital One** | Finance | /Applications | 🤔 Optional (banking) |
| **ExpressVPN** | Security/VPN | /Applications | ✅ Add to Nix (VPN) |
| **Fantastical 2** | Productivity | /Applications | ✅ Add to Nix (calendar) |
| **Find Any File** | System Utility | /Applications | ✅ Add to Nix (search) |
| **ForkLift** | File Management | /Applications | ✅ Add to Nix (FTP/file mgr) |
| **Google Chrome** | Browser | /Applications | ✅ Add to Nix (browser) |
| **Google Docs** | Productivity | /Applications | 🤔 Optional (web app) |
| **Google Drive** | Cloud Storage | /Applications | ✅ Add to Nix (storage) |
| **Google Sheets** | Productivity | /Applications | 🤔 Optional (web app) |
| **Google Slides** | Productivity | /Applications | 🤔 Optional (web app) |
| **HandBrake** | Media | /Applications | ✅ Add to Nix (video convert) |
| **ImageOptim** | Media | /Applications | ✅ Add to Nix (image opt) |
| **InjectionIII** | Development | /Applications | 🤔 Optional (iOS dev) |
| **iTerm** | Terminal | /Applications | ⚠️ You have Ghostty |
| **JetBrains Toolbox** | Development | /Applications | ✅ Add to Nix (IDE mgmt) |
| **Keynote** | Productivity | /Applications | ✅ Add to Nix (presentations) |
| **Kindle** | Media/Books | /Applications | ✅ Add to Nix (reading) |
| **LaunchBar** | Productivity | /Applications | ⚠️ Conflicts with Raycast |
| **MacForge** | System Utility | /Applications | 🤔 Optional (system mods) |
| **Microsoft Teams** | Communication | /Applications | ✅ Add to Nix (work) |
| **MongoDB Realm Studio** | Development | /Applications | ✅ Add to Nix (database) |
| **Native SQLite Manager** | Development | /Applications | ✅ Add to Nix (database) |
| **NightOwl** | System Utility | /Applications | 🤔 Optional (dark mode) |
| **Noizio** | Productivity | /Applications | 🤔 Optional (ambient sound) |
| **Numbers** | Productivity | /Applications | ✅ Add to Nix (spreadsheets) |
| **Ollama** | AI/Development | /Applications | ✅ Add to Nix (AI models) |
| **Pages** | Productivity | /Applications | ✅ Add to Nix (documents) |
| **PDF Expert** | Productivity | /Applications | ✅ Add to Nix (PDF editor) |
| **Pythonista** | Development | /Applications | 🤔 Optional (iOS Python) |
| **Recharge** | System Utility | /Applications | 🤔 Optional (battery) |
| **Remote Desktop - VNC** | System Utility | /Applications | ✅ Add to Nix (remote access) |
| **Safari** | Browser | /Applications | ✅ Already in dock config |
| **SF Symbols** | Development | /Applications | ✅ Add to Nix (design) |
| **Spectacle** | System Utility | /Applications | ⚠️ Deprecated (use Rectangle) |
| **Spotify** | Media | /Applications | ✅ Add to Nix (music) |
| **Syncplay** | Media | /Applications | 🤔 Optional (sync video) |
| **The Camelizer** | Shopping | /Applications | 🤔 Optional (price tracking) |
| **The Unarchiver** | System Utility | /Applications | ✅ Add to Nix (archives) |
| **Tunnelblick** | Security/VPN | /Applications | ✅ Add to Nix (OpenVPN) |
| **uTorrent Web** | Media | /Applications | 🤔 Optional (torrents) |
| **Vimari** | Browser Utility | /Applications | 🤔 Optional (Safari vim) |
| **VLC** | Media | /Applications | ✅ Add to Nix (video player) |
| **Wave** | Finance | /Applications | ✅ Add to Nix (accounting) |
| **WhatsApp** | Communication | /Applications | ✅ Add to Nix (messaging) |
| **Xcode** | Development | /Applications | ✅ Add to Nix (iOS dev) |
| **zoom.us** | Communication | /Applications | ✅ Add to Nix (video calls) |

## 📱 User Applications (~/Applications)

| App Name | Category | Status |
|----------|----------|--------|
| **AppCleaner** | System Utility | ✅ Add to Nix |
| **ChatGPT** | AI | ✅ Add to Nix |
| **IntelliJ IDEA Ultimate** | Development | ✅ Add to Nix |
| **LaunchControl** | System Utility | ✅ Add to Nix |
| **Panda** | System Utility | 🤔 Optional |
| **Visual Studio Code** | Development | ✅ Already in config |
| **Web Apps** | Various | ✅ Already in dock config |

## 🎯 Recommended Additions to Nix Config

### High Priority (Essential Tools)
```nix
casks = [
  # Security & VPN
  "1password"
  "authy" 
  "expressvpn"
  "tunnelblick"
  
  # Development
  "amazon-q"
  "devutils"
  "jetbrains-toolbox"
  "mongodb-realm-studio"
  "sf-symbols"
  "xcode"
  
  # Communication
  "beeper"
  "microsoft-teams"
  "whatsapp"
  "zoom"
  
  # Productivity
  "bartender"
  "cheatsheet"
  "fantastical"
  "pdf-expert"
  
  # Media
  "calibre"
  "handbrake"
  "spotify"
  "vlc"
  
  # System Utilities
  "appcleaner"
  "find-any-file"
  "forklift"
  "imageoptim"
  "the-unarchiver"
  
  # Cloud Storage
  "dropbox"
  "google-drive"
  
  # Browsers
  "comet"
  "google-chrome"
];

masApps = {
  "keynote" = 409183694;
  "numbers" = 409203825;
  "pages" = 409201541;
  "kindle" = 302584613;
  "wave" = 1368932954;
};
```

### Medium Priority (Nice to Have)
- Remote Desktop VNC
- Native SQLite Manager
- Blackmagic Disk Speed Test
- Recharge

### Low Priority (Optional/Redundant)
- Alfred 5 (you have Raycast)
- LaunchBar (you have Raycast)  
- iTerm (you have Ghostty)
- Spectacle (deprecated)
- Google Docs/Sheets/Slides (web versions work)

## 📋 Action Items

1. **Review High Priority list** - Add essential tools to your Nix config
2. **Remove redundant apps** - Clean up conflicting productivity tools
3. **Update brew.nix** - Add selected applications
4. **Test rebuild** - Ensure all apps install correctly
5. **Clean up manually installed apps** - Let Nix manage everything

This will give you **~50 additional apps** in your declarative configuration, bringing coverage to **~80%**!
