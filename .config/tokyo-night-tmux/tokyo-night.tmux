#!/usr/bin/env bash
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# title      Tokyo Night                                              +
# version    1.0.0                                                    +
# repository https://github.com/logico-dev/tokyo-night-          +
# author     Lógico                                                   +
# email      hi@logico.com.ar                                         +
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RESET="#[fg=brightwhite,bg=#15161e,nobold,noitalics,nounderscore,nodim]"

set -g status-left-length 80
set -g status-right-length 150

# Highlight colors
set -g mode-style "fg=#a9b1d6,bg=#2A2F41"

set -g message-style "bg=#7aa2f7,fg=#2A2F41"
set -g message-command-style "fg=#c0caf5,bg=#2A2F41"

set -g pane-border-style "fg=#2A2F41"
set -g pane-active-border-style "fg=#7aa2f7"

set -g status-style bg="#1A1B26"

SCRIPTS_PATH="$HOME/.config/tokyo-night-tmux/src"

window_id_style="none"

cmus_status="#($SCRIPTS_PATH/music-tmux-statusbar.sh)"
# git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
# wb_git_status="#($SCRIPTS_PATH/wb-git-status.sh #{pane_current_path} &)"
window_number="#($SCRIPTS_PATH/custom-number.sh #I $window_id_style)"

#+--- Bars LEFT ---+
# Session name
set -g status-left "#[fg=#1F2335,bg=#6441a5,bold] #{?client_prefix,󰠠 ,#[dim]󰤂 }#[fg=#ffffff,bg=#6441a5,bold,nodim]#S $RESET "

#+--- Windows ---+
# Focus
set -g window-status-current-format "#[fg=#44dfaf,bg=#1F2335]  #[fg=#a9b1d6]$window_number #[bold,nodim]#W#[nobold,dim] #{?window_last_flag,,} "
# Unfocused
set -g window-status-format "#[fg=#c0caf5,bg=default,none,dim] $window_number #W#[nobold,dim]#[fg=yellow,blink] #{?window_last_flag,󰁯 ,} "

#+--- Bars RIGHT ---+
# set -g status-right "$cmus_status#[fg=#a9b1d6,bg=#24283B]  %Y-%m-%d #[]❬ %H:%M $git_status$wb_git_status"
set -g status-right "$cmus_status#[fg=#a9b1d6,bg=#24283B]  %Y-%m-%d #[]❬ %H:%M"
set -g window-status-separator ""
