{
  enable = true;

  settings = {
    general.import = ["~/.config/alacritty/theme.toml"];
    window = {
      dimensions = {
        columns = 150;
        lines = 50;
      };
      padding = {
        x = 5;
        y = 10;
      };
    };
    font = {
      size = 14.0;
      normal = {
        family = "GohuFont 14 Nerd Font Mono";
        style = "Regular";
      };
    };

    keyboard.bindings = [
      {
        # vertical split (C-f |)
        key = "D";
        mods = "Command";
        chars = "\\u0006\\u007c";
      }
      {
        # horizontal split (C-f -)
        key = "D";
        mods = "Command|Shift";
        chars = "\\u0006\\u002d";
      }

      {
        # move right (M-RightArrow)
        key = "Right";
        mods = "Command";
        chars = "\\u0006\\u001b\\u005b\\u0043";
      }
      {
        # move up (M-UpArrow)
        key = "Up";
        mods = "Command";
        chars = "\\u0006\\u001b\\u005b\\u0041";
      }
      {
        # move up (M-LeftArrow)
        key = "Left";
        mods = "Command";
        chars = "\\u0006\\u001b\\u005b\\u0044";
      }
      {
        # move up (M-DownArrow)
        key = "Down";
        mods = "Command";
        chars = "\\u0006\\u001b\\u005b\\u0042";
      }

      {
        # maximize pane (C-f z)
        key = "Return";
        mods = "Command";
        chars = "\\u0006\\u007a";
      }
    ];
  };
}
