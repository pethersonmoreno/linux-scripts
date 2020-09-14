#!/bin/sh
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>t" -s "xfce4-terminal"
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Shift><Alt>t" -n -t "string" -s "xfce4-terminal --drop-down"

# Change shortcuts to move window in workspaces
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Down" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Down" -n -t "string" -s "move_window_down_workspace_key"
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Up" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Up" -n -t "string" -s "move_window_up_workspace_key"
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Left" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Left" -n -t "string" -s "move_window_left_workspace_key"
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Shift><Control><Alt>Right" -s ""
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt><Super>Right" -n -t "string" -s "move_window_right_workspace_key"

# Disable shortcuts
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F1" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F2" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F3" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F4" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F5" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F6" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F7" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F8" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F9" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F10" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F11" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary>F12" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>Home" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>End" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_1" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_2" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_3" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_4" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_5" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_6" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_7" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_8" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Primary><Alt>KP_9" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>Insert" -r
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Alt>Delete" -r


# Example to delete a property
# xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/default/<Shift><Control><Alt>Down" -r