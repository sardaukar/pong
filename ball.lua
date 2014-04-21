local Class = require 'hump.class'

local shapes = require 'collider.shapes'

local Ball = Class {}

function Ball:init(world, x, y)

  self.type = 'ball'

  self.width = 20
  self.height = 20

  self.speed = {
    x = -200,
    y = 200
  }

  self.color = {240, 204, 64}

  self.x = SCREEN.width / 2 - self.width / 2
  self.y = SCREEN.height / 2 - self.height / 2

  self.shape = shapes.newPolygonShape(
    self.x, self.y,
    self.x + self.width, self.y,
    self.x + self.width, self.y + self.height,
    self.x, self.y + self.height
    )

  self.shape.object = self

  world.collider:addShape(self.shape)

end

function Ball:update(dt)
  self.x = self.x + (self.speed.x * dt)
  self.y = self.y + (self.speed.y * dt)

  -- bounce off top
  if self.y < 0 then
    self:sound()
    self.speed.y = math.abs(self.speed.y)
  end

  -- bounce off bottom
  if (self.y + self.height) > SCREEN.height then
    self:sound()
    self.speed.y = -math.abs(self.speed.y)
  end

  -- reset if off-screen
  if self.x + self.width < 0 then
    WORLD.score.right = WORLD.score.right + 1
    sounds.ai_score:play()
    self:reset_position()
  elseif self.x > SCREEN.width then
    WORLD.score.left = WORLD.score.left + 1
    sounds.p1_score:play()
    self:reset_position()
  end

  self.shape:moveTo(self.x+self.width/2,self.y+self.height/2)
end

function Ball:reset_position()

  self.speed = {
    x = 200,
    y = -200
  }

  self.x = SCREEN.width / 2 - self.width / 2
  self.y = SCREEN.height / 2 - self.height / 2
end

function Ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:sound()
  sounds.ball_hit:stop()
  sounds.ball_hit:play()
end

return Ball