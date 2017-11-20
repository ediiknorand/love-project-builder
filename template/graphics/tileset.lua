local Tileset = Class()

function Tileset.__new(param_table)
  local self = {}

  -- TODO: get texture width/height from atlas
  local tex = love.graphics.newImage(param_table.filename)

  local tile_w = param_table.tile_w or 32
  local tile_h = param_table.tile_h or 32

  for row=0,param_table.rows-1 do
    for col=0,param_table.cols-1 do
      local quad = love.graphics.newQuad(
        param_table.x + col * tile_w,
        param_table.y + row * tile_h,
        tile_w,
        tile_h,
        tex:getWidth(),
        tex:getHeight()
      )
      table.insert(self, quad)
    end
  end

  self.tile_w = tile_w
  self.tile_h = tile_h

  return self
end

function Tileset:populate(tilemap, batch, x, y, cols, rows)
  x = x or 1
  y = y or 1
  cols = cols or tilemap.w
  rows = rows or tilemap.h

  for col=x,x+cols do
    for row=y,y+rows do
      if tilemap[row][col] and tilemap[row][col] > 0 then
        batch:add(
          self[tilemap[row][col]],
          (col-1) * self.tile_w,
          (row-1) * self.tile_h
        )
      end
    end
  end
end

return Tileset
