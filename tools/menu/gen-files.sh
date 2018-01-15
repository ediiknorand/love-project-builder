#!/bin/bash

tools_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../"
template_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../template/"
configlib_path="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
source "${configlib_path}/configlib.sh"

config_file="${1:-config.txt}"

# Default Values

start_state='Init'

# Interface Settings

project_name="$(load_setting project_name 'game' "${config_file}")"

window_title="$(load_setting window_title 'Game' "${config_file}")"
window_width="$(load_setting window_width '800' "${config_file}")"
window_height="$(load_setting window_height '600' "${config_file}")"
window_resizable="$(load_setting window_resizable false "${config_file}")"

input_mouse="$(load_setting input_mouse false "${config_file}")"
input_joystick="$(load_setting input_joystick false "${config_file}")"

# Generate Files

mkdir "${project_name}"
mkdir -p "${project_name}/util"
mkdir -p "${project_name}/states"
bash ${tools_path}/makefile.sh "${project_name}" > Makefile

# Interface
conf_options=""
[[ ${window_resizable} = true ]] && conf_options="${conf_options}r"
[[ ${input_mouse} = true ]] && conf_options="${conf_options}m"
[[ ${input_joystick} = true ]] && conf_options="${conf_options}j"

main_options=""
[[ ${input_mouse} = true ]] && main_options="${main_options}m"
[[ ${input_joystick} = true ]] && main_options="${main_options}j"

state_options=""
[[ ${input_mouse} = true ]] && state_options="${state_options}m"
[[ ${input_joystick} = true ]] && state_options="${state_options}j"

bash ${tools_path}/gen-lua/conf.sh \
  -w "${window_width}" \
  -h "${window_height}" \
  -t "${window_title}" \
  -"${conf_options}" \
  > "${project_name}/conf.lua"

bash ${tools_path}/gen-lua/main.sh \
  -w "${window_width}" \
  -h "${window_height}" \
  -s "${start_state}" \
  -"${main_options}" \
  > "${project_name}/main.lua"

bash ${tools_path}/gen-lua/state.sh -"${state_options}" \
  > "${project_name}/util/state.lua"

bash ${tools_path}/gen-lua/new-state.sh "${start_state}" \
  > "${project_name}/states/$(echo ${start_state} \
    | tr '[[:upper:]]' '[[:lower:]]').lua"

cp ${template_path}/util/class.lua "${project_name}/util/class.lua"
cp ${template_path}/util/stack.lua "${project_name}/util/stack.lua"
