local Class = require 'hump.class'

local Paddle = Class {}

function Paddle:init(x, y, speed)
  self.width = 20
  self.height = 70

  self.x = x
  self.y = y

  self.speed = speed
  self.color = {240, 125, 64}
end

function Paddle:update(dt)
  if love.keyboard.isDown('w') then
    self.y = self.y - (self.speed * dt)
  end
  if love.keyboard.isDown('s') then
    self.y = self.y + (self.speed * dt)
  end

  if self.y < 0 then
    self.y = 0
  elseif (self.y + self.height) > SCREEN.height then
    self.y = SCREEN.height - self.height
  end
end

function Paddle:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle