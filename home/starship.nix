{ pkgs, ... }: {
  enable = true;
  enableNushellIntegration = true;

  settings = {
    add_newline = true;
    command_timeout = 10000;
    palette = "adaptive";

    palettes.rosepine = {
      overlay = "#26233a";
      love = "#eb6f92";
      gold = "#f6c177";
      rose = "#ebbcba";
      pine = "#31748f";
      foam = "#9ccfd8";
      iris = "#c4a7e7";
    };

    palettes.rosepine_dawn = {
      overlay = "#f2e9e1";
      love = "#b4637a";
      gold = "#ea9d34";
      rose = "#d7827e";
      pine = "#286983";
      foam = "#56949f";
      iris = "#907aa9";
    };

    palettes.adaptive = {
      overlay = "#26233a";
      love = "#eb6f92";
      gold = "#f6c177";
      rose = "#ebbcba";
      pine = "#31748f";
      foam = "#9ccfd8";
      iris = "#c4a7e7";
    };

    format = ''$username$directory$git_branch$git_status$character'';
    right_format = ''$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$scala$conda$python$time'';

    character = {
      format = "$symbol  ";
      success_symbol = "[◎](fg:foam)";
      error_symbol = "[◎](fg:love)";
    };

    time = {
      disabled = false;
      format = "[](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
      style = "bg:overlay fg:rose";
      time_format = "%I:%M%P";
      use_12hr = true;
    };

    directory = {
      format = "[](fg:overlay)[ $path ]($style)[](fg:overlay) ";
      style = "bg:overlay fg:pine";
      truncation_length = 3;
      truncation_symbol = "…/";
    };

    directory.substitutions = {
      Documents = "󰈙";
      Downloads = " ";
      Music = " ";
      Pictures = " ";
    };

    git_branch = {
      format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay) ";
      style = "bg:overlay fg:foam";
      symbol = "";
    };

    git_status = {
      disabled = false;
      style = "bg:overlay fg:love";
      format = "[](fg:overlay)([$all_status$ahead_behind]($style))[](fg:overlay) ";
      up_to_date = "[ ✓ ](bg:overlay fg:iris)";
      untracked = "[?\($count\)](bg:overlay fg:gold)";
      stashed = "[$](bg:overlay fg:iris)";
      modified = "[!\($count\)](bg:overlay fg:gold)";
      renamed = "[»\($count\)](bg:overlay fg:iris)";
      deleted = "[✘\($count\)](style)";
      staged = "[++\($count\)](bg:overlay fg:gold)";
      ahead = "[⇡\(\${count}\)](bg:overlay fg:foam)";
      diverged = "⇕[\[](bg:overlay fg:iris)[⇡\(\${ahead_count}\)](bg:overlay fg:foam)[⇣\(\${behind_count}\)](bg:overlay fg:rose)[\]](bg:overlay fg:iris)";
      behind = "[⇣\(\${count}\)](bg:overlay fg:rose)";
    };

    username = {
      disabled = false;
      format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay) ";
      show_always = true;
      style_root = "bg:overlay fg:iris";
      style_user = "bg:overlay fg:iris";
    };

    c = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    elixir = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    elm = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    golang = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    haskell = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    java = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    julia = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    nodejs = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = "󰎙 ";
    };

    nim = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = "󰆥 ";
    };

    rust = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = "";
    };

    scala = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";

    };

    python = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
      disabled = false;
      symbol = " ";
    };

    conda = {
      style = "bg:overlay fg:pine";
      format = "[](fg:overlay)[$symbol$environment]($style)[](fg:overlay) ";
      disabled = false;
      symbol = "🅒 ";
    };
  };
}
