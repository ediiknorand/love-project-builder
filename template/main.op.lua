function love.load()
end

function love.update(dt)
  if dt <= 0 then
    dt = 1e-10
  end
  if dt > 1/30 then
    dt = 1/30
  end

  State.get_current():update(dt)
end

function love.draw()
  local w,h = love.graphics.getDimensions()
  love.graphics.push()
  love.graphics.scale(w/v_width, h/v_height)
  State.get_current():draw()
  love.graphics.pop()
end

function love.keypressed(key)
  State.get_current():keypressed(key)
end

function love.keyreleased(key)
  State.get_current():keyreleased(key)
end

function love.textinput(text)
  State.get_current():textinput(text)
end
