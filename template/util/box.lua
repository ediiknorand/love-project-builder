local Box = Class()

function Box.__new(w, h, x, y)
  return {
    x = x or 0,
    y = y or 0,
    w = w or 1,
    h = h or 1
  }
end

function Box:__add(coord)
  return Box(self.w, self.h, self.x + coord.x, self.y + coord.y)
end

function Box:__sub(coord)
  return Box(self.w, self.h, self.x - coord.x, self.y - coord.y)
end

function Box:__unm()
  return Box(self.w, self.h, -self.x, -self.y)
end

function Box:__mul(v)
  return Box(v*self.w, v*self.h, self.x, self.y)
end

function Box:__div(x)
  assert(
    x ~= 0,
    'Box.__div: cannot divide by 0'
  )
  return Box(self.w/v, self.h/v, self.x, self.y)
end

function Box:intersects(box)
  local intersects_x = self.x < box.x + box.w and box.x < self.x + self.w
  local intersects_y = self.y < box.y + box.h and box.y < self.y + self.h
  return intersects_x and intersects_y
end

function Box:enclose(box)
  local x = math.min(self.x, box.x)
  local y = math.min(self.y, box.y)
  local w = math.max(self.x + self.w, box.x + box.w) - x
  local h = math.max(self.y + self.h, box.y + box.h) - y
  return Box(w, h, x, y)
end

function Box:int()
  local x = math.floor(self.x)
  local y = math.floor(self.y)
  local w = math.ceil(self.x + self.w) - x
  local h = math.ceil(self.y + self.h) - y
  return Box(w, h, x, y)
end

return Box
