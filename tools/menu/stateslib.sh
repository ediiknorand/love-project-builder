declare -A states_list

# State Types and Dependencies

states_list['Grid']='grid/collision.lua;'
states_list['Grid']+='grid/grid-iterator.lua;'
states_list['Grid']+='grid/map.lua;'
states_list['Grid']+='util/box.lua;'
states_list['Grid']+='util/unb-array.lua;'
states_list['Grid']+='util/unb-matrix.lua;'
states_list['Grid']+='graphics/animation.lua;'
states_list['Grid']+='graphics/sprite.lua;'
states_list['Grid']+='graphics/spritesheet.lua;'
states_list['Grid']+='graphics/tileset.lua'

# Functions

select_state() {
  select opt in "${!states_list[@]}"; do
    case $REPLY in
      *)
        if [[ -z $opt ]]; then
          echo 'Invalid Option' >&2
        else
          echo $opt
          break
        fi;;
    esac
  done
}

# Load and Save State List

load_states() {
  local states_file=$1
  if ! ls "${states_file}" &> /dev/null; then
    return
  fi
  while read -r line; do
    if echo ${line} | grep -iq '^[a-z]\+ [a-z]\+$'; then
      local state_name="$(echo ${line} | cut -d' ' -f1)"
      local state_type="$(echo ${line} | cut -d' ' -f2)"
      states["${state_name}"]="${state_type}"
    fi
  done <<< "$(cat "${states_file}")"
}

save_states() {
  local states_file=$1
  rm -f "${states_file}"
  for state_name in ${!states[@]}; do
    echo "${state_name} ${states[${state_name}]}" >> "${states_file}"
  done
}
