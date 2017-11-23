local UnbArray = require 'util/unb-array'

local UnbMatrix = Class()

function UnbMatrix.__new(matrix, contiguous, width, height)
  local self = {}

  if not contiguous then
    for _,row in ipairs(matrix) do
      table.insert(self, UnbArray(row))
    end
    self.w = #self[1] or width
    self.h = #self    or height

    return self
  end

  for y=1, height do
    local row = {}

    for x=1, width do
      table.insert(row, matrix[x + (y-1)*width])
    end
    table.insert(self, UnbArray(row))
  end
  self.w = #self[1] or width
  self.h = #self    or height

  return self
end

function UnbMatrix:__index(index)
  return UnbArray{}
end

return UnbMatrix
