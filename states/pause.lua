local Class = require 'hump.class'

local PauseState = Class {}

function PauseState:init()
end

function PauseState:update(dt)
  --
end

function PauseState:draw()
  for name, object in pairs(WORLD.objects) do
    object:draw()
  end

  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, SCREEN.width, SCREEN.height)

  love.graphics.print( WORLD.score.left .. ':' .. WORLD.score.right, 210, 10 )
end

function PauseState:keypressed(key)
  if key == 'p' then
    WORLD.curr_state = 'play'
  end
end

return PauseState