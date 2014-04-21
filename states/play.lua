local Class = require 'hump.class'

local PlayState = Class {}

function PlayState:init()
  self.background_color = {39, 77, 126}
end

function PlayState:update(dt)
  WORLD:update(dt)
end

function PlayState:draw()
  love.graphics.setBackgroundColor(self.background_color)

  WORLD:draw()
end

function PlayState:keypressed(key)
  if key == 'q' or key == 'escape' then
    love.event.quit()
  end

  if key == 'p' then
    curr_state = 'pause'
  end
end

return PlayState