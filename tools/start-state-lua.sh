#!/bin/bash

start_state=${1:-Init}

cat << EOF
local State = require 'util/state'
local ${start_state} = Class(State)

return ${start_state}
EOF
