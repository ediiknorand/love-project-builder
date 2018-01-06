-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local UnbArray = Class()

function UnbArray.__new(array)
  local self = {}

  for _,v in ipairs(array) do
    table.insert(self, v)
  end

  return self
end

function UnbArray:__index(index)
  return 0
end

return UnbArray
