#!/bin/bash

menu_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../tools/menu/"

# Main menu

options=( \
  "Interface Settings"\
  "States"\
)

echo 'Love Project Builder'
PS3='> '
select opt in "${options[@]}" "Generate files" "Quit"; do
  case $REPLY in
  1) bash ${menu_path}/interface.sh;;
  2) bash ${menu_path}/states.sh;;
  $(( ${#options[@]}+1 )) )
    bash "${menu_path}/gen-files.sh";;
  $(( ${#options[@]}+2 )) ) exit 0;;
  *) echo "Invalid Option"
     continue;;
  esac
done
