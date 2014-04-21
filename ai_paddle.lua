local Class = require 'hump.class'
local Paddle = require 'paddle'

local AiPaddle = Class {
  __includes = Paddle
}

function AiPaddle:init(...)
  Paddle.init(self, ...)

  self.type = 'ai'
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

  self.shape:moveTo(self.x+self.width/2,self.y+self.height/2)
end

function AiPaddle:draw()
  Paddle.draw(self)
end

return AiPaddle