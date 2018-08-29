#!/bin/bash

state_name="${1:-Grid}State"

cat << EOF
-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local State = require 'util/state'
local ${state_name} = Class(State)

local Map = require 'grid/map'

function ${state_name}.__new(param_table)
  local self = {}

  self.map = Map(param_table.id)

  return self
end

return ${state_name}
EOF
