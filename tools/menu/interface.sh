#!/bin/bash

configlib_path="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
source "${configlib_path}/configlib.sh"

config_file="${1:-config.txt}"

# Settings

project_name="$(load_setting project_name 'game' "${config_file}")"

window_title="$(load_setting window_title 'Game' "${config_file}")"
window_width="$(load_setting window_width '800' "${config_file}")"
window_height="$(load_setting window_height '600' "${config_file}")"
window_resizable="$(load_setting window_resizable false "${config_file}")"

input_mouse="$(load_setting input_mouse false "${config_file}")"
input_joystick="$(load_setting input_joystick false "${config_file}")"

# Menu

options=( \
  "Project Name"\
  "Window Title"\
  "Window Dimensions"\
  "Resizable Window"\
  "Enable Mouse"\
  "Enable Joystick"\
)

echo 'Love Project Builder - Interface'
PS3='>> '
select opt in "${options[@]}" "Show Settings" "Save" "Quit"; do
  case $REPLY in
  # Project name
  1) read -p 'Choose a name for the project: ' project_name;;

  # Window Title
  2) read -p 'Choose a title: ' window_title;;

  # Window dimensions
  3) window_width=''
     while ! [[ "$window_width" =~ ^[0-9]+$ ]]; do
       read -p 'Choose a window width value: ' window_width
     done
     window_height=''
     while ! [[ "$window_height" =~ ^[0-9]+$ ]]; do
       read -p 'Choose a window height value: ' window_height
     done;;

  # Resizable window
  4) read -p 'Resizable window? [Y/N]: ' yn
       case $yn in
         [Yy]*) window_resizable=true ;;
         [Nn]*) window_resizable=false;;
       esac;;

  # Enable mouse
  5) read -p 'Enable mouse? [Y/N]: ' yn
       case $yn in
         [Yy]*) input_mouse=true ;;
         [Nn]*) input_mouse=false;;
       esac;;

  # Enable joystick
  6) read -p 'Enable joystick? [Y/N]: ' yn
       case $yn in
         [Yy]*) input_joystick=true ;;
         [Nn]*) input_joystick=false;;
       esac;;

  # Show settings
  $(( ${#options[@]}+1 )) )
    echo "Project Name: ${project_name}"
    echo "Window Title: ${window_title}"
    echo "Window Dimensions: ${window_width}x${window_height}"
    echo "Resizable Window: ${window_resizable}"
    echo "Enable Mouse: ${input_mouse}"
    echo "Enable Joystick: ${input_joystick}";;

  # Save settings
  $(( ${#options[@]}+2 )) )
    if ! ls "${config_file}" &> /dev/null; then
      touch "${config_file}"
    fi
    save_setting project_name     "${project_name}"     "${config_file}"
    save_setting window_title     "${window_title}"     "${config_file}"
    save_setting window_width     "${window_width}"     "${config_file}"
    save_setting window_height    "${window_height}"    "${config_file}"
    save_setting window_resizable "${window_resizable}" "${config_file}"
    save_setting input_mouse      "${input_mouse}"      "${config_file}"
    save_setting input_joystick   "${input_joystick}"   "${config_file}";;

  # Quit
  $(( ${#options[@]}+3 )) ) exit 0;;

  # Invalid option
  *) echo "Invalid Option";;

  esac
done
