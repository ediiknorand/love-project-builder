-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local Animation = Class()

function Animation.__new(duration, row, start_f, end_f, reset_f)
  local self = {}

  self.duration  = duration or 1
  self.row       = row      or 1
  self.start_f   = start_f  or 1
  self.end_f     = end_f    or 1
  self.reset_f   = reset_f  or 1
  self.t         = 0
  self.current_f = self.start_f

  return self
end

function Animation:update(dt)
  self.t = self.t + dt

  if self.t >= self.duration then
    self.t = self.t - self.duration
    self.current_f = self.current_f + 1
    if self.current_f > self.end_f then
      self.current_f = self.reset_f
    end
  end

  return self.current_f
end

return Animation
