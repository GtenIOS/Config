{ config, pkgs, ... }:

{
  home.username = "jiten";
  home.homeDirectory = "/home/jiten";

  home.packages = with pkgs; [
    firefox
    hyprland
    waybar
    kitty
    rofi
    pavucontrol
    fzf
    ripgrep
    bat
  ];

  programs.git = { 
    enable = true;
    userName = "GtenIOS";
    userEmail = "jdevlani@yahoo.in";
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin"
    '';
  };

  # Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai_pro";
      editor = {
        line-number = "relative";
        mouse = true;
        true-color = true;
        cursorline = true;
        rulers = [ 80 ];
        bufferline = "multiple";
        indent-guides = {
          render = true;
          character = "╎"; # Some characters that work well: "╎", "▏", "┆", "┊", "⸽"
          skip-levels = 1;
        };
        soft-wrap.enable = true;
        lsp.display-inlay-hints = true;
        file-picker.hidden = false;
      };
      keys = {
        normal = {
          "S-up" = "jump_view_up";
          "S-down" = "jump_view_down";
          "S-left" = "jump_view_left";
          "S-right" = "jump_view_right";
          "A-left" = ":bp";
          "A-right" = ":bn";
          "C-q" = ":bc";
          "C-s" = ":w";
        };
        insert = {
          j = { j = "normal_mode"; }; # Maps `jj` to exit insert mode
          "left" = "move_char_left";
          "down" = "move_line_down";
          "up" = "move_line_up";
          "right" = "move_char_right";
        };
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
  };

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
