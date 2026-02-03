{ ... }: {
  home.file.".docker/config.json".text = builtins.toJSON {
  };
}
