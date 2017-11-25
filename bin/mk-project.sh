#!/bin/bash

# Default values
project_name="${1:-game}"

window_title='Game'
window_width=800
window_height=600
window_resizable=false

input_mouse=false
input_joystick=false

tools_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../tools/"
template_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../template/"

# Default template

echo 'Create a new project using the default settings?'
select yn in "Yes" "No"; do
  case $yn in
  Yes) bash ${tools_path}/makefile.sh ${project_name} > Makefile
       mkdir ${project_name}
       mkdir -p ${project_name}/util
       bash ${tools_path}/conf-lua.sh     > ${project_name}/conf.lua
       bash ${tools_path}/main-lua.sh     > ${project_name}/main.lua
       cp ${template_path}/util/class.lua   ${project_name}/util/class.lua
       cp ${template_path}/util/stack.lua   ${project_name}/util/stack.lua
       bash ${tools_path}/state-lua.sh    > ${project_name}/util/state.lua
       exit 0 ;;
  No ) break  ;;
  esac
done

# Configure

echo 'Choose a name for the project:'
read -p '> ' project_name

echo 'Choose a title for the project:'
read -p '> ' window_title

window_width=''
echo 'Choose a window width value:'
while ! [[ "$window_width" =~ ^[0-9]+$ ]]; do
  read -p '> ' window_width
done

window_height=''
echo 'Choose a window height value:'
while ! [[ "$window_height" =~ ^[0-9]+$ ]]; do
  read -p '> ' window_height
done

echo 'Resizable window?'
select yn in "Yes" "No"; do
  case $yn in
  Yes) window_resizable=true
       break ;;
  No ) window_resizable=false
       break ;;
  esac
done

echo 'Mouse available?'
select yn in "Yes" "No"; do
  case $yn in
  Yes) input_mouse=true
       break ;;
  No ) input_mouse=false
       break ;;
  esac
done

echo 'Joystick available?'
select yn in "Yes" "No"; do
  case $yn in
  Yes) input_joystick=true
       break ;;
  No ) input_joystick=false
       break ;;
  esac
done

echo 'Choose a name for the initial state:'
read -p '> ' start_state

# Generate options

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

# Core files

echo 'Project name: '${project_name}
echo 'Window title: '${window_title}
echo 'Window size: '${window_width}x${window_height}
echo 'Conf options: '${conf_options}
echo 'Main options: '${main_options}
echo 'State options: '${state_options}
echo 'Start state: '${start_state}

mkdir "${project_name}"
mkdir -p "${project_name}/util"
mkdir -p "${project_name}/states"

bash ${tools_path}/makefile.sh "${project_name}" > Makefile

bash ${tools_path}/conf-lua.sh \
  -w "${window_width}" \
  -h "${window_height}" \
  -t "${window_title}" \
  -"${conf_options}" \
  > "${project_name}/conf.lua"

bash ${tools_path}/main-lua.sh \
  -w "${window_width}" \
  -h "${window_height}" \
  -s "${start_state}" \
  -"${main_options}" \
  > "${project_name}/main.lua"

bash ${tools_path}/state-lua.sh -"${state_options}" \
  > "${project_name}/util/state.lua"

bash ${tools_path}/new-state-lua.sh "${start_state}" \
  > "${project_name}/states/$(echo ${start_state} \
    | tr '[[:upper:]]' '[[:lower:]]').lua"

cp ${template_path}/util/class.lua "${project_name}/util/class.lua"
cp ${template_path}/util/stack.lua "${project_name}/util/stack.lua"
