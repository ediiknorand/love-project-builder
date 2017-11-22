local Animation = require 'graphics/animation'

local Sprite = Class()

function Sprite.__new(spritesheet, batch)
  local self = {}

  local tex_w = batch:getTexture():getWidth()
  local tex_h = batch:getTexture():getHeight()

  self.quad = love.graphics.newQuad(
    spritesheet.x,
    spritesheet.y,
    spritesheet.spr_w,
    spritesheet.spr_h,
    tex_w,
    tex_h
  )
  self.sheet = spritesheet
  self.batch = batch

  return self
end

function Sprite:set(col, row)
  row = row - 1
  col = col - 1

  self.quad:setViewport(
    self.sheet.x + col * self.sheet.spr_w,
    self.sheet.y + row * self.sheet.spr_h,
    self.sheet.spr_w,
    self.sheet.spr_h
  )

  if self.id and self.id > 0 then
    self.batch:set(
      self.id,
      self.quad,
      self.x,
      self.y,
      self.r,
      self.sx,
      self.sy,
      self.ox,
      self.oy,
      self.kx,
      self.ky
    )
  end
end

function Sprite:place(param_table)
  self.x  = param_table.x  or self.x  or 0
  self.y  = param_table.y  or self.y  or 0
  self.r  = param_table.r  or self.r  or 0
  self.sx = param_table.sx or self.sx or 1
  self.sy = param_table.sy or self.sy or 1
  self.ox = param_table.ox or self.ox or self.sheet.spr_w/2
  self.oy = param_table.oy or self.oy or self.sheet.spr_h/2
  self.kx = param_table.kx or self.kx or 1
  self.ky = param_table.ky or self.ky or 1

  if self.id and self.id > 0 then
    self.batch:set(
      self.id,
      self.quad,
      self.x,
      self.y,
      self.r,
      self.sx,
      self.sy,
      self.ox,
      self.oy,
      self.kx,
      self.ky
    )
  else
    self.id = self.batch:add(
      self.quad,
      self.x,
      self.y,
      self.r,
      self.sx,
      self.sy,
      self.ox,
      self.oy,
      self.kx,
      self.ky
    )
  end

  return self.id
end

function Sprite:set_animation(duration, row, start_f, end_f, reset_f)
  self.animation = Animation(duration, row, start_f, end_f, reset_f)
end

function Sprite:update(dt)
  if self.animation then
    local frame = self.animation:update(dt)
    self:set(frame, self.animation.row)
  end
end

return Sprite
