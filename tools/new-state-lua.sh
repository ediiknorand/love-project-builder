#!/bin/bash

state_name=${1:-Init}

cat << EOF
local State = require 'util/state'
local ${state_name} = Class(State)

return ${state_name}
EOF
