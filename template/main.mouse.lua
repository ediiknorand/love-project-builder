function love.mousemoved(x, y, dx, dy)
  local w,h = love.graphics.getDimensions()
  State.get_current():mousemoved(x*v_width/w, y*v_height/h, dx, dy)
end

function love.mousepressed(x, y, button)
  local w,h = love.graphics.getDimensions()
  State.get_current():mousepressed(x*v_width/w, y*v_height/h, button)
end

function love.mousereleased(x, y, button)
  local w,h = love.graphics.getDimensions()
  State.get_current():mousereleased(x*v_width/w, y*v_height/h, button)
end
