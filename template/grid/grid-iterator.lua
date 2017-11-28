local GridIterator = Class()

function GridIterator.__new(box)
  return {box=box:int()}
end

function GridIterator:iterate_x(direction)
  local x0, xf, xic

  if direction > 0 then
    x0 = self.box.x
    xf = self.box.x + self.box.w - 1
    xic = 1
  else
    x0 = self.box.x + self.box.w - 1
    xf = self.box.x
    xic = -1
  end

  for x = x0, xf, xic do
    for y = self.box.y, self.box.y + self.box.h - 1 do
      coroutine.yield(x+1, y+1)
    end
  end
end

function GridIterator:iterate_y(direction)
  local y0, yf, yic

  if direction > 0 then
    y0 = self.box.y
    yf = self.box.y + self.box.h - 1
    yic = 1
  else
    y0 = self.box.y + self.box.h - 1
    yf = self.box.y
    yic = -1
  end

  for y = y0, yf, yic do
    for x = self.box.x, self.box.x + self.box.w - 1 do
      coroutine.yield(x+1, y+1)
    end
  end
end

function GridIterator:__call(axis, direction)
  if axis == 'x' then
    return coroutine.wrap(function() self:iterate_x(direction or 1) end)
  elseif axis == 'y' then
    return coroutine.wrap(function() self:iterate_y(direction or 1) end)
  end
end

return GridIterator
