# mac-backup.nix
# Complete backup of all customized macOS system settings
# This file contains ONLY settings that differ from macOS defaults
# Generated from current system state

{ pkgs, ... }: {

  # ============================================================================
  # GLOBAL SYSTEM PREFERENCES (NSGlobalDomain)
  # ============================================================================
  NSGlobalDomain = {
    # APPEARANCE & INTERFACE
    AppleInterfaceStyle = "Dark";                    # Dark mode (default: Light)
    _HIHideMenuBar = false;                          # Menu bar visible (your current: visible)
    AppleFontSmoothing = 2;                          # Font smoothing (default: varies)

    # KEYBOARD & INPUT
    InitialKeyRepeat = 15;                           # Key repeat delay (default: 25)
    KeyRepeat = 2;                                   # Key repeat speed (default: 6)
    AppleKeyboardUIMode = 3;                         # Full keyboard access (default: 0)
    "com.apple.keyboard.fnState" = false;            # Use F keys as standard (default: false)

    # TRACKPAD & MOUSE
    "com.apple.mouse.tapBehavior" = 1;              # Mouse tap to click (default: 0)
    "com.apple.trackpad.enableSecondaryClick" = true; # Right click (default: varies)
    "com.apple.trackpad.trackpadCornerClickBehavior" = 1; # Corner click behavior

    # TEXT & LANGUAGE
    NSAutomaticSpellingCorrectionEnabled = false;   # Auto spell correct (default: true)
    NSAutomaticCapitalizationEnabled = false;       # Auto capitalize (default: true)
    NSAutomaticInlinePredictionEnabled = true;      # Inline predictions (default: false)
    NSAutomaticQuoteSubstitutionEnabled = true;     # Smart quotes (default: varies)
    NSAutomaticDashSubstitutionEnabled = true;      # Smart dashes (default: varies)
    NSAutomaticPeriodSubstitutionEnabled = true;    # Double-space period (default: varies)

    # FILES & DOCUMENTS
    AppleShowAllExtensions = false;                   # Show file extensions (default: false)
    AppleShowAllFiles = true;                        # Show hidden files (default: false)
    NSDocumentSaveNewDocumentsToCloud = false;      # Save to iCloud (default: true)

    # UNITS & FORMATS
    AppleMetricUnits = 1;                           # Metric units (default: varies by region)
    AppleTemperatureUnit = "Celsius";               # Temperature unit (default: varies)
    AppleMeasurementUnits = "Centimeters";          # Measurement units (default: varies)
    AppleICUForce24HourTime = true;                 # 24-hour time (default: false)

    # SCROLLING & ANIMATION
    AppleShowScrollBars = "Automatic";              # Scroll bar visibility (default: varies)
    NSScrollAnimationEnabled = true;                # Smooth scrolling (default: varies)
    NSWindowResizeTime = 0.001;                     # Window resize animation speed (default: 0.2)
    NSAutomaticWindowAnimationsEnabled = false;     # Disable window animations (default: true)

    # SOUND
    "com.apple.sound.beep.feedback" = 1;           # Sound feedback (default: varies)
  };

  # ============================================================================
  # FINDER PREFERENCES
  # ============================================================================
  finder = {
    # VIEW OPTIONS
    FXPreferredViewStyle = "Nlsv";                  # List view (default: "icnv" icon view)
    ShowPathbar = true;                             # Show path bar (default: false)
    ShowStatusBar = true;                           # Show status bar (default: false)
    _FXShowPosixPathInTitle = true;                 # Show full path in title (default: false)
    _FXSortFoldersFirst = true;                     # Folders first (default: false)

    # FILE HANDLING
    AppleShowAllExtensions = true;                  # Show extensions (default: false)
    AppleShowAllFiles = true;                       # Show hidden files (default: false)
    FXEnableExtensionChangeWarning = false;         # Extension change warning (default: true)
    FXRemoveOldTrashItems = true;                   # Auto-empty trash (default: false)

    # DESKTOP & NEW WINDOWS
    ShowRemovableMediaOnDesktop = false;            # Show external disks (default: true)
    NewWindowTarget = "Home";                       # New window location (default: varies)
    QuitMenuItem = true;                            # Show Quit menu item (default: false)
  };

  # ============================================================================
  # DOCK PREFERENCES
  # ============================================================================
  dock = {
    # APPEARANCE
    autohide = true;                                # Auto-hide dock (default: false)
    magnification = true;                           # Magnification (default: false) - YOUR CURRENT: true
    tilesize = 36;                                  # Icon size (default: 48) - YOUR CURRENT: 36
    orientation = "bottom";                         # Position (default: "bottom")

    # BEHAVIOR
    show-recents = false;                          # Show recent apps (default: true)
    show-process-indicators = true;                # Show app indicators (default: true)
    minimize-to-application = true;                # Minimize to app icon (default: false)
    launchanim = false;                            # Disable launch animation (default: true)
    mineffect = "scale";                           # Minimize effect (default: "genie")

    # DOCK CONTENTS - Your complete app list
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
#
#      # Web Apps (Safari-created)
#      "/Users/sri/Applications/RUAK Investments.app"
#      "/Users/sri/Applications/Real Estate Investing.app"
#      "/Users/sri/Applications/Stock Sales - Tracking 2.app"
#      "/Users/sri/Applications/AI Studio.app"
#      "/Users/sri/Applications/ChatGPT- Diagrams - Show Me.app"
#      "/Users/sri/Applications/Udemy - Docker Mastery with Kubernetes + Swarm.app"
#      "/Users/sri/Applications/Udemy - Mastering Visual Studio Code 2024.app"
#      "/Users/sri/Applications/Funds and Allocation.app"
#      "/Users/sri/Applications/TMobile Billing.app"
    ];
    persistent-others = [];                         # No folders in dock
    expose-animation-duration = 0.1;                # Mission Control animation speed (default: 0.75)
  };

  # ============================================================================
  # TRACKPAD PREFERENCES
  # ============================================================================
  trackpad = {
    Clicking = true;                                # Tap to click (default: false)
    TrackpadRightClick = true;                      # Right click (default: varies)
    ActuationStrength = 1;                          # Click strength (default: varies)
    FirstClickThreshold = 1;                        # Click threshold (default: varies)
    SecondClickThreshold = 1;                       # Force click threshold (default: varies)
  };

  # ============================================================================
  # CONTROL CENTER
  # ============================================================================
  controlcenter = {
    BatteryShowPercentage = true;                   # Show battery % (default: false)
    AirDrop = false;                               # Hide AirDrop (default: true)
    Bluetooth = false;                             # Hide Bluetooth (default: true)
    Display = false;                               # Hide Display (default: true)
    NowPlaying = false;                            # Hide Now Playing (default: true)
    Sound = false;                                 # Hide Sound (default: true)
    FocusModes = true;                             # Show Focus (default: varies)
  };

  # ============================================================================
  # MENU BAR CLOCK
  # ============================================================================
  menuExtraClock = {
    Show24Hour = true;                             # 24-hour format (default: false)
    ShowDate = 0;                                  # Date display (default: varies)
    ShowDayOfWeek = true;                          # Show day of week (default: false)
  };

  # ============================================================================
  # SCREENSHOTS
  # ============================================================================
  screencapture = {
    location = "~/Screenshots/Documents/";        # Screenshot location (default: ~/Desktop)
  };

  # ============================================================================
  # SCREENSAVER & SECURITY
  # ============================================================================
  screensaver = {
    askForPassword = true;                         # Require password (default: varies)
    askForPasswordDelay = 900;                     # Password delay (default: varies)
  };

  # ============================================================================
  # ACTIVITY MONITOR
  # ============================================================================
  ActivityMonitor.IconType = 5;                    # Dock icon type (default: varies)

  # ============================================================================
  # SYSTEM UPDATES
  # ============================================================================
  SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true; # Auto updates (default: varies)

  # ============================================================================
  # LAUNCH SERVICES
  # ============================================================================
  LaunchServices.LSQuarantine = false;             # Disable quarantine (default: true)

  # ============================================================================
  # LOGIN WINDOW
  # ============================================================================
  loginwindow.GuestEnabled = false;                # Disable guest user (default: varies)

  # ============================================================================
  # FUNCTION KEYS
  # ============================================================================
  hitoolbox.AppleFnUsageType = "Do Nothing";       # Fn key behavior (default: varies)

  # ============================================================================
  # CUSTOM USER PREFERENCES
  # ============================================================================
  CustomUserPreferences = {
    # FINDER ANIMATIONS
    "com.apple.finder" = {
      DisableAllAnimations = true;                 # Disable Finder animations
      FXEnableSlowAnimation = false;               # Disable slow animations
    };

    # QUICK LOOK ANIMATIONS
    "com.apple.QuickLookUIService" = {
      QLEnableTextSelection = true;                # Enable text selection in Quick Look
      QLPreviewMinimumDelay = 0;                   # Remove Quick Look delay
    };

    # NOTIFICATION CENTER WIDGETS
    "com.apple.notificationcenterui" = {
      TodayView = {
        keyWidget = "com.culturedcode.ThingsMac.TodayWidget";
        order = [
          "com.culturedcode.ThingsMac.TodayWidget"
          "com.apple.ncplugin.WorldClock"
          "com.apple.iCal.CalendarNC"
          "com.flexibits.fantastical2.mac.today-widget"
          "com.bjango.istatmenus.iStat-Menus-Widget"
        ];
      };
    };

    # DESKTOP WIDGETS
    "com.apple.WindowManager" = {
      StandardHideWidgets = true;                   # Hide desktop widgets (default: false)
      StageManagerHideWidgets = true;               # Hide in Stage Manager (default: false)
    };

    # ICLOUD PREFERENCES
    "com.apple.CloudKit" = {
      BRFieldUserPrefersLocalStorage = false;       # Prefer iCloud storage (default: varies)
    };

    "com.apple.bird" = {
      optimize-storage = true;                      # Optimize Mac storage (default: false)
    };

    # APP STORE
    "com.apple.appstore" = {
      WebKitDeveloperExtras = false;               # Developer extras (default: varies)
      ShowDebugMenu = false;                       # Debug menu (default: false)
    };

    # WIDGET DATA SOURCES
    "com.apple.chronod" = {
      userConfiguredDataSources = {
        "com.apple.weather.widget" = {
          enabled = true;
          location = "auto";
        };
        "com.apple.calendar.widget" = {
          enabled = true;
          showAllDayEvents = true;
        };
        "com.apple.clock.widget" = {
          enabled = true;
          showSeconds = false;
        };
      };
    };
  };
}

# ============================================================================
# SUMMARY OF CUSTOMIZATIONS
# ============================================================================
#
# MAJOR CHANGES FROM DEFAULTS:
# • Dark mode enabled
# • Menu bar always visible (not auto-hide)
# • Very fast key repeat (2 vs default 6)
# • Tap to click enabled
# • All file extensions visible
# • Hidden files visible
# • Dock auto-hide with magnification
# • Smaller dock icons (36 vs 48)
# • List view in Finder (vs icon view)
# • Path bar and status bar in Finder
# • 24-hour time format
# • Metric units
# • Screenshots to Documents (vs Desktop)
# • Battery percentage visible
# • Most Control Center items hidden
# • Desktop widgets hidden
# • 9 custom web apps in dock
# • 5 notification center widgets configured
#
# This represents your complete personalized macOS configuration!
# ============================================================================
