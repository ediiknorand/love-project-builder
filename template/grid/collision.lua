local Collision = Class()

local GridIterator = require 'grid/grid-iterator'

function Collision.__new(box)
  return {present = box}
end

function Collision:set_future(dt, direction)
  self.dt = dt
  self.future_x  = self.present + {x = direction.x * dt, y = 0}
  self.future_y  = self.present + {x = 0, y = direction.y * dt}
  self.future_xy = self.present + {x = direction.x * dt, y = direction.y * dt}
  self.direction = {x = direction.x, y = direction.y}
end

function Collision:get_direction()
  local dx = self.future_x - self.present.x
  local dy = self.future_y - self.present.y
  return {x = dx / self.dt, y = dy / self.dt}
end

function Collision:get_collision_by_axis(axis)
  if axis == 'x' then
    return self.collision_left or self.collision_right
  elseif axis == 'y' then
    return self.collision_up   or self.collision_down
  end
  return (self.collision_up   or self.collision_down)
     and (self.collision_left or self.collision_right)
end

local function get_direction_name(axis, direction)
  if     axis == 'x' and direction > 0 then
    return 'right'
  elseif axis == 'x' and direction < 0 then
    return 'left'
  elseif axis == 'y' and direction < 0 then
    return 'down'
  elseif axis == 'y' and direction > 0 then
    return 'up'
  end
  return nil
end

local function get_length_name(axis)
  if axis == 'x' then return 'w' end
  if axis == 'y' then return 'h' end
  return nil
end

local function calculate_collision(collision, grid, axis)
  local subgrid = collision.present:enclose(collision['future_'..axis])
  local iter    = GridIterator(subgrid)
  local d_axis  = axis:sub(1,1)

  for x,y in iter(d_axis, collision.direction[d_axis]) do
    if grid[y][x] > 0 then

      local v = d_axis == 'x' and x or y
      if collision.direction[d_axis] > 0 then
        collision['collision_'..get_direction_name(d_axis,  1)] = true
        collision['future_'..axis][d_axis] =
          v - collision.['future_'..axis][get_length_name(d_axis)] - 1
      else
        collision['collision_'..get_direction_name(d_axis, -1)] = true
        collision['future_'..axis][d_axis] = v
      end

    end
  end
end

function Collision:set_grid_collision(grid)
  calculate_collision(self, grid,  'x')
  calculate_collision(self, grid,  'y')
  calculate_collision(self, grid, 'xy')
end

return Collision
