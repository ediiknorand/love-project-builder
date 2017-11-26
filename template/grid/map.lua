local UnbMatrix = require 'util/unb-matrix'

local Map = Class()

local layers_mt = {
  __index = function(layer, index)
    if type(index) == 'number' then
      return UnbMatrix{{0}}
    end
    return nil
  end
}

function Map.__new(id)
  local self = {}

  local module = 'assets/maps/'.. id
  local map_data = require(module)
  package.loaded[module] = nil

  self.w = map_data.width
  self.h = map_data.height

  self.layers = {}
  for _,layer in ipairs(map_data).layers do
    if layer.type == 'tilelayer' then
      local index = tonumber(layer.name:match('%d+$'))
      self.layers[index] = UnbMatrix(
        layer.data,
        true,
        layer.width,
        layer.height
      )
    end
  end

  setmetatable(self.layers, layers_mt)

  return self
end
