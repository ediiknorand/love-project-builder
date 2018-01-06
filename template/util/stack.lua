-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local Stack = Class()

function Stack.__new()
  return {top=0, stack={}}
end

function Stack:push(value)
  assert(
    value ~= nil,
    'Attempting to push nil value onto the stack'
  )
  self.top = self.top + 1
  self.stack[self.top] = value
end

function Stack:pop()
  local value = self.stack[self.top]

  if value == nil then
    print('Warning: Attempting to pop a value from an empty stack!')
    return
  end

  self.stack[self.top] = nil
  self.top = self.top - 1
  return value
end

function Stack:peek()
  return self.stack[self.top]
end

return Stack
