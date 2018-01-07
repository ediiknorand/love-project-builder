#!/bin/bash

state_name=${1:-Init}

cat << EOF
-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local State = require 'util/state'
local ${state_name} = Class(State)

return ${state_name}
EOF
