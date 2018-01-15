load_setting() {
  local var_name=$1
  local default_value=$2
  local conf_file=$3
  if ! ls "${conf_file}" &> /dev/null; then
    echo ${default_value}
    return
  fi
  if ! grep "^${var_name} " "${conf_file}" &> /dev/null; then
    echo ${default_value}
    return
  fi
  grep "^${var_name} .*$" "${conf_file}" | cut -d' ' -f2-
}

save_setting() {
  local var_name=$1
  local value=$2
  local conf_file=$3
  if ! grep "^${var_name} " "${conf_file}" &> /dev/null; then
    echo "${var_name} ${value}" >> "${conf_file}"
  else
    cat "${conf_file}" \
    | sed "s/^\(${var_name}\) .*$/\1 ${value}/" \
    > "${conf_file}.tmp"
    mv "${conf_file}.tmp" "${conf_file}"
  fi
}
