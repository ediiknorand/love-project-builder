-- Generated with Love Project Builder
-- https://github.com/ediiknorand/love-project-builder

local Sprite = require 'graphics/sprite'

local Spritesheet = Class()

function Spritesheet.__new(param_table)
  -- param_table keys:
  --   filename,
  --   x, y, spr_w, spr_h,
  --   cols, rows

  local self = {}

  -- TODO: get texture width/height from atlas
  local tex = love.graphics.newImage(param_table.filename)
  self.x      = param_table.x      or 0
  self.y      = param_table.y      or 0
  self.cols   = param_table.cols   or 1
  self.rows   = param_table.rows   or 1
  self.spr_w  = param_table.spr_w  or tex:getWith() - self.x
  self.spr_h  = param_table.spr_h  or tex:getHeight() - self.y

  return self
end

function Spritesheet:new_sprite(batch)
  return Sprite(self, batch)
end

return Spritesheet
