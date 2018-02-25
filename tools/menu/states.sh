#!/bin/bash

menulib_path="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
source "${menulib_path}/stateslib.sh"

states_file="${1:-states.txt}"

# States
declare -A states
load_states "${states_file}"

# Menu

options=( \
  "Add/Modify State"\
  "Remove State"\
)

PS3='>> '
select opt in "${options[@]}" "Show States" "Save" "Quit"; do
  case $REPLY in
  # Add/Modify State
  1) read -p 'Choose a name for the state: ' state_name
     state_type=$(select_state)
     states["${state_name}"]="${state_type}";;

  # Remove State
  2) read -p 'Choose a name of a state to remove: ' state_name
     unset states[${state_name}];;

  # Show States
  $(( ${#options[@]}+1 )) )
    for state in "${!states[@]}"; do
      echo "${state} - ${states[${state}]}"
    done;;

  # Save
  $(( ${#options[@]}+2 )) )
    save_states "${states_file}"
    echo "State list saved to ${states_file}";;

  # Quit
  $(( ${#options[@]}+3 )) ) exit 0;;

  # Invalid option
  *) echo "Invalid Option";;
  esac
done
