#!/bin/sh
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>t" -s "xfce4-terminal"
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Shift><Alt>t" -s "xfce4-terminal --drop-down"

# Change shortcuts to move window in workspaces
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Down" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Down" -s "move_window_down_workspace_key"
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Up" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Up" -s "move_window_up_workspace_key"
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Left" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Left" -s "move_window_left_workspace_key"
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Right" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Right" -s "move_window_right_workspace_key"