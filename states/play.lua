local Class = require 'hump.class'

local PlayState = Class {}

function PlayState:init()
  self.background_color = {39, 77, 126}
end

function PlayState:update(dt, world)
  for name, object in pairs(world.objects) do
    object:update(dt, world)
  end
end

function PlayState:draw()
  love.graphics.setBackgroundColor(self.background_color)

  for name, object in pairs(WORLD.objects) do
    object:draw()
  end

  love.graphics.print( WORLD.score.left .. ':' .. WORLD.score.right, 210, 10 )

end

function PlayState:keypressed(key)
  if key == 'q' or key == 'escape' then
    love.event.quit()
  end

  if key == 'p' then
    WORLD.curr_state = 'pause'
  end
end

return PlayState