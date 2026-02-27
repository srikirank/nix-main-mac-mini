{ pkgs, ... }: {
  NSGlobalDomain = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    AppleMetricUnits = 1;
    AppleShowScrollBars = "Automatic";
    NSScrollAnimationEnabled = true;
    NSDocumentSaveNewDocumentsToCloud = false;
    NSAutomaticInlinePredictionEnabled = true;
    NSAutomaticQuoteSubstitutionEnabled = true;
    NSAutomaticDashSubstitutionEnabled = true;
    NSAutomaticSpellingCorrectionEnabled = false;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = true;
    InitialKeyRepeat = 15;  # Delay before repeat starts (lower = faster)
    KeyRepeat = 2;          # Repeat speed (1 = fastest, 2 = very fast)
    
    # Speed up animations
    NSWindowResizeTime = 0.001;
    NSAutomaticWindowAnimationsEnabled = false;
    
    # Additional cursor/navigation enhancements
    AppleKeyboardUIMode = 3;              # Full keyboard access for navigation
    AppleTemperatureUnit = "Celsius";
    AppleMeasurementUnits = "Centimeters";
    # AppleInterfaceStyle = "Dark"; # Commented out to use System Auto
    AppleFontSmoothing = 2;
    _HIHideMenuBar = false;
    AppleICUForce24HourTime = false;
  };
  finder = {
    _FXShowPosixPathInTitle = true;
    _FXSortFoldersFirst = true;
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "clmv";
    FXRemoveOldTrashItems = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    ShowPathbar = true;
    ShowStatusBar = true;
    ShowRemovableMediaOnDesktop = false;
    NewWindowTarget = "Home";
    QuitMenuItem = true;
  };
  controlcenter = {
    BatteryShowPercentage = true;
    AirDrop = false;
    Bluetooth = false;
    Display = false;
    NowPlaying = false;
    Sound = true;
    FocusModes = true;
  };
  ActivityMonitor.IconType = 5;
  hitoolbox.AppleFnUsageType = "Do Nothing";
  LaunchServices.LSQuarantine = false;
  loginwindow.GuestEnabled = false;
  menuExtraClock = {
    Show24Hour = false;
    ShowDate = 0;
    ShowDayOfWeek = true;
  };
  screencapture.location = "/tmp/";
  screensaver = {
    askForPassword = true;
    askForPasswordDelay = 900;
  };
  SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  trackpad = {
    ActuationStrength = 1;
    Clicking = true;
    FirstClickThreshold = 1;
    SecondClickThreshold = 1;
    TrackpadRightClick = true;
    # Enable three-finger gestures
    TrackpadThreeFingerTapGesture = 2;         # Look up & data detectors
  };
  dock = {
    autohide = true;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.5;
    magnification = true;
    minimize-to-application = true;
    mineffect = "genie";
    show-recents = false;
    show-process-indicators = true;
    launchanim = true;
    orientation = "bottom";
    tilesize = 40;
    # Disable window tiling
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    persistent-apps = [
      "/Applications/Ghostty.app"
      "/Applications/Bear.app"
      "/Applications/Copilot.app"
      "/Applications/Nix Apps/Visual Studio Code.app"
      "/Applications/Sublime Text.app"
      "/Applications/Hoppscotch.app"
      "/System/Applications/Mail.app"
      "/System/Applications/Messages.app"
      "/System/Applications/Photos.app"
      "/System/Applications/Music.app"
      "/System/Applications/Passwords.app"
      "/Applications/Raycast.app"
      "/System/Cryptexes/App/System/Applications/Safari.app"
      "/System/Applications/System Settings.app"

#      # Web Apps (created from websites)
#      "/Users/kiran/Applications/RUAK Investments.app"
#      "/Users/kiran/Applications/Real Estate Investing.app"
#      "/Users/kiran/Applications/Stock Sales - Tracking 2.app"
#      "/Users/kiran/Applications/AI Studio.app"
#      "/Users/kiran/Applications/ChatGPT- Diagrams - Show Me.app"
#      "/Users/kiran/Applications/Udemy - Docker Mastery with Kubernetes + Swarm.app"
#      "/Users/kiran/Applications/Udemy - Mastering Visual Studio Code 2024.app"
#      "/Users/kiran/Applications/Funds and Allocation.app"
#      "/Users/kiran/Applications/TMobile Billing.app"
    ];
    persistent-others = [];
  };
}
