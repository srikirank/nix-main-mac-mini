{ ... }: {
  enable = true;
  onActivation.cleanup = "zap";
  onActivation.upgrade = true;
  onActivation.autoUpdate = true;
  brews = [
    "openjdk"
    "swagger-codegen"
    "pueue"
    "hey"
    "telnet"
    "maven"
    "gemini-cli"
    "opencode"
    "docker"
    "typescript"
    "code-cli"
    "cloudflare-wrangler"
  ];

  casks = [
    # Working casks
    "claude-code"
    "github"
    "cursor"
    "hyperwhisper"
    "visual-studio-code"
    "contexts"
    "ghostty@tip"
    "freeyourmusic"
    "handbrake-app"
    "istat-menus"
    "linear-linear"
    "raycast"
    "warp"
    "sublime-text"
    "postman"
    "spotify"
    "vlc"
    "lunar"
    "microsoft-word"
    "monodraw"
    "notion-calendar"
    "zen"
    "bartender"
    "google-drive"
    "docker-desktop"
    "dropbox"
    "google-chrome"
    # Working utilities
    "1password-cli"
    "devutils"
    "fantastical"
    "find-any-file"
    "forklift"
    "launchbar"
    "mongodb-realm-studio"
    "pdf-expert"
    "sf-symbols"
    "the-unarchiver"

    # Development
    "hoppscotch"
    "kiro-cli"
  ];
  masApps = {
    # Core apps - keep these
    "1password" = 1333542190;
    "bear" = 1091189122;
    "things3" = 904280696;
    "xcode" = 497799835;
    
    # Free Apple apps
    "keynote" = 409183694;
    "numbers" = 409203825;
    "pages" = 409201541;
    "flighty" = 1358823008;
    "infuse" = 1136220934;
    "whatsapp" = 310633997;

    # iPad Apps
#    "adblock" = 691121579;

    # Comment out potentially problematic paid apps
    # "craft" = 1487937127;
    # "leaf" = 576338668;
    "perplexity" = 6714467650;
    # "rakuten" = 1451893560;
    # "ray" = 6738274497;
    # "surfshark" = 1437809329;
    # "tampermonkey" = 1482490089;
    # "tz-converter" = 1255311569;
    # "wallpaper" = 1552826194;
    # "kindle" = 302584613;
  };
}
