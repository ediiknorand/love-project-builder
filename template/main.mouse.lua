function love.mousemoved(x, y, dx, dy)
  local w,h = love.graphics.getDimensions()
  State.get_current():mousemoved(x*vWidth/w, y*vHeight/h, dx, dy)
end

function love.mousepressed(x, y, button)
  local w,h = love.graphics.getDimensions()
  State.get_current():mousepressed(x*vWidth/w, y*vHeight/h, button)
end

function love.mousereleased(x, y, button)
  local w,h = love.graphics.getDimensions()
  State.get_current():mousereleased(x*vWidth/w, y*vHeight/h, button)
end
