local Class = require 'hump.class'

local Ball = Class {}

function Ball:init(x, y)

  self.width = 20
  self.height = 20

  self.speed = {
    x = -200,
    y = 200
  }

  self.color = {240, 204, 64}

  self.x = SCREEN.width / 2 - self.width / 2
  self.y = SCREEN.height / 2 - self.height / 2
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

  -- bounce off paddle1
  if self.x <= WORLD.objects.paddle1.width and
    (self.y + self.height) >= WORLD.objects.paddle1.y and
    self.y < (WORLD.objects.paddle1.y + WORLD.objects.paddle1.height)
  then
    self:sound()
    self.speed.x = math.abs(self.speed.x)
  end

  -- bounce off paddle2
  if (self.x + self.width) >= (SCREEN.width - WORLD.objects.paddle2.width) and
    (self.y + self.height) >= WORLD.objects.paddle2.y and
    self.y < (WORLD.objects.paddle2.y + WORLD.objects.paddle2.height)
  then
    self:sound()
    self.speed.x = -math.abs(self.speed.x)
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
end

function Ball:reset_position()
  --print(inspect(self))
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