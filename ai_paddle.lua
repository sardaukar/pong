local Class = require 'hump.class'
local Paddle = require 'paddle'

local AiPaddle = Class {
  __includes = Paddle
}

function AiPaddle:init(...)
  Paddle.init(self, ...)
end

function AiPaddle:update(dt)
  if WORLD.objects.ball.y < self.y then
    self.y = self.y - (self.speed * dt)
  end
  if WORLD.objects.ball.speed.y > self.y then
    self.y = self.y + (self.speed * dt)
  end

  if self.y < 0 then
    self.y = 0
  elseif (self.y + self.height) > SCREEN.height then
    self.y = SCREEN.height - self.height
  end
end

function AiPaddle:draw()
  Paddle.draw(self)
end

return AiPaddle