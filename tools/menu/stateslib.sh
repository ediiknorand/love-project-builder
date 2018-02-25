declare -A states_list

# State Types and Dependencies
# TODO: implement dependencies

states_list['Test']='states/test.lua'

# Functions

select_state() {
  PS3='>>> '
  select opt in "${!states_list[@]}"; do
    case $REPLY in
      *)
        if [[ -z $opt ]]; then
          echo 'Invalid option' >&2
        else
          echo $opt
          break
        fi;;
    esac
  done
  PS3='>> '
}

# Load and Save State List

load_states() {
  local states_file=$1
  if ! ls "${states_file}" &> /dev/null; then
    return
  fi
  while read -r line; do
    if echo ${line} | grep -q '^[A-Z][a-z]\+ [A-Z][a-z]\+$'; then
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
