function love.mousemoved(x, y, dx, dy)
  local w,h = love.graphics.getDimensions()
  State.getCurrentState():mousemoved(x*vWidth/w, y*vHeight/h, dx, dy)
end

function love.mousepressed(x, y, button)
  local w,h = love.graphics.getDimensions()
  State.getCurrentState():mousepressed(x*vWidth/w, y*vHeight/h, button)
end

function love.mousereleased(x, y, button)
  local w,h = love.graphics.getDimensions()
  State.getCurrentState():mousereleased(x*vWidth/w, y*vHeight/h, button)
end
