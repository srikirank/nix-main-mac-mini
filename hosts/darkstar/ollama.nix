# This file MUST be imported by nix-darwin, NOT home-manager
{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.ollama ];

  launchd.user.agents.ollama = {
    serviceConfig = {
      ProgramArguments = [ "/opt/homebrew/bin/ollama" "serve" ];
      KeepAlive = true;
      RunAtLoad = true;
      EnvironmentVariables = {
        OLLAMA_KV_CACHE_TYPE = "q8_0";
        OLLAMA_CONTEXT_LENGTH = "65536";
        OLLAMA_MODELS = "/Users/sri/.ollama/models";
        OLLAMA_METAL = "1";         # Enable Metal acceleration
        OLLAMA_MAX_VRAM = "48GiB";
        OLLAMA_KEEP_ALIVE = "3h";
        DYLD_LIBRARY_PATH = "/System/Library/Frameworks/Accelerate.framework/Versions/Current:/System/Library/Frameworks/Metal.framework/Versions/Current";
        OLLAMA_API_URL=  "http://localhost:11454";
      };
    };
  };
}