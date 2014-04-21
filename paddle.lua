local Class = require 'hump.class'

local shapes = require 'collider.shapes'

local Paddle = Class {}

function Paddle:init(world, x, y, speed)
  self.width = 20
  self.height = 72

  self.x = x
  self.y = y

  self.type = 'player'

  self.shape = shapes.newPolygonShape(
    x,y,
    x+self.width, y,
    x+self.width, y+self.height,
    x, y+self.height
    )

  self.shape.object = self

  world.collider:addShape(self.shape)

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

  self.shape:moveTo(self.x + self.width/2,self.y + self.height/2)
end

function Paddle:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle