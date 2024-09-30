{ pkgs, ... }: {
  enable = true;
  aggressiveResize = true;
  baseIndex = 1;
  clock24 = true;
  escapeTime = 0;
  mouse = true;
  shortcut = "C-f";
  historyLimit = 50000;
  sensibleOnTop = false;
  plugins = with pkgs; [
    { plugin = tmuxPlugins.yank; }
  ];

  extraConfig = ''
    set -g renumber-windows on
    set -g allow-rename off
    set -gw word-separators ' @"=()[]_-:,.'
    set -agw word-separators "'"

    bind | split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"
    unbind '"'
    unbind %

    bind c new-window -c "#{pane_current_path}"
    bind -r p previous-window
    bind -r n next-window

    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    set -gw monitor-activity on
    set -g visual-activity on

    bind r source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display-message "tmux config reloaded!"

    unbind a
    bind a set-window-option synchronize-panes \; display-message "synchronize-panes is #{?pane_synchronized,on,off}"

    setw -g mode-keys vi
    bind -T copy-mode-vi v send -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
    bind P paste-buffer
    bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

    set-option -g default-command "reattach-to-user-namespace -l $SHELL"

    set-option -g default-terminal "screen-256color"

    # statusbar
    set -g status on
    set -g status-interval 1
    set -g status-justify centre
    set -g status-keys vi
    set -g status-position top
    set-option -g status-style bg='#1b1c36',fg='#ecf0c1'

    set -g status-right-length 140
    set -g status-right-style default
    set -g status-right "%H:%M:%S %d-%m-%Y"

    set -g window-status-format ' #I #W '

    # Active window
    set-option -g window-status-current-style bg='#686f9a',fg='#ffffff'
    set -g window-status-current-format ' #I #W '

    # Active pane
    set -g pane-active-border-style "fg=#5ccc96"
    # Inactive pane
    set -g pane-border-style "fg=#686f9a"

    # Message
    set-option -g message-style bg='#686f9a',fg='#ecf0c1'
    set-option -g message-command-style bg='#686f9a',fg='#ecf0c1'

    # When commands are run
    set -g message-style "fg=#0f111b,bg=#686f9a"
  '';
}
