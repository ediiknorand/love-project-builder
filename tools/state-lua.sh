#!/bin/bash

OPTIND=1

template_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../template/"
state_callbacks_file="${template_path}/util/state.callbacks.lua"
state_op_file="${template_path}/util/state.op.lua"

state_joystick_file="${template_path}/util/state.joystick.lua"
state_mouse_file="${template_path}/util/state.mouse.lua"

state_callbacks="$(cat "${state_callbacks_file}")"
state_op="$(cat "${state_op_file}")"

while getopts 'mj' obj; do
  case "$obj" in
  m) state_mouse=$(cat "${state_mouse_file}")
     ;;
  j) state_joystick=$(cat "${state_joystick_file}")
     ;;
  \?) exit 1
     ;;
  esac
done
shift $((OPTIND - 1))

cat << EOF
-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local Stack = require 'util/stack'

local State = Class()

local state_stack = Stack()

function State.__new(param_table)
  assert(
    type(param_table) == 'table',
    'Bad argument #1: table expected'
  )
  return param_table
end

${state_callbacks}
${state_mouse:--- No -m (mouse) option used}
${state_joystick:--- No -j (joystick) option used}

${state_op}

return State
EOF
