#!/bin/bash

OPTIND=1

template_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../template/"
main_op_file="${template_path}/main.op.lua"

main_mouse_file="${template_path}/main.mouse.lua"
main_joystick_file="${template_path}/main.joystick.lua"

main_op="$(cat "${main_op_file}")"

window_width=800
window_height=600

while getopts 'w:h:s:mj' opt; do
  case "$opt" in
  w) window_width=$OPTARG
     ;;
  h) window_height=$OPTARG
     ;;
  s) start_state=$OPTARG
     start_state_filename="$(echo "${start_state}" | tr '[[:upper:]]' '[[:lower:]]')"
     start_state_require="local ${start_state} = require 'states/${start_state_filename}'"
     ;;
  m) main_mouse="$(cat "${main_mouse_file}")"
     ;;
  j) main_joystick="$(cat "${main_joystick_file}")"
     ;;
  \?) exit 1
     ;;
  esac
done
shift $((OPTIND - 1))

cat << EOF
-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

Class = require 'util/class'
local State = require 'util/state'
${start_state_require:--- No -s (Start State) option used}

v_width = ${window_width}
v_height = ${window_height}

State.push(${start_state:-State}{})

${main_op}

${main_mouse:--- No -m (mouse) option used}

${main_joystick:--- No -j (joystick) option used}
EOF
