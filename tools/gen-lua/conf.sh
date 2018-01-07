#!/bin/bash

OPTIND=1

window_width=800
window_height=600
window_title='Game'
window_resizable='false'
input_mouse='false'
input_joystick='false'

while getopts 'w:h:t:rmj' opt; do
  case "$opt" in
  w) window_width=$OPTARG
     ;;
  h) window_height=$OPTARG
     ;;
  t) window_title=$OPTARG
     ;;
  r) window_resizable='true'
     ;;
  m) input_mouse='true'
     ;;
  j) input_joystick='true'
     ;;
  \?) exit 1
     ;;
  esac
done
shift $((OPTIND - 1))

cat << EOF
-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

function love.conf(t)
  t.accelerometerjoystick = false

  t.window.title     = '${window_title}'
  t.window.width     = ${window_width}
  t.window.height    = ${window_height}
  t.window.resizable = ${window_resizable}
  t.window.minwidth  = ${window_width}
  t.window.minheight = ${window_height}

  t.modules.joystick = ${input_joystick}
  t.modules.mouse    = ${input_mouse}
  t.modules.physics  = false
  t.modules.system   = false
  t.modules.timer    = true
  t.modules.touch    = false
  t.modules.video    = false
  t.modules.thread   = false
end
EOF
