local Class = require 'hump.class'

local Paddle    = require 'paddle'
local AiPaddle  = require 'ai_paddle'
local Ball      = require 'ball'

local Collider = require 'collider'

local World = Class {}

function World:init(state)

  self.collider = Collider(2)

  self.objects = {
    paddle1 = Paddle(self, 0, (SCREEN.height / 2), 400 ),
    paddle2 = AiPaddle( self, (SCREEN.width - 20), (SCREEN.height / 2), 125 ),
    ball    = Ball(self, SCREEN.width / 2, SCREEN.height / 2)
  }

  self.collider:setCallbacks(collide)

  self.score = {
    left  = 0,
    right = 0
  }

end

function collide(dt, s1, s2, dx, dy)

  if s2.object.type == 'player' or s2.object.type == 'ai' then
    ball, paddle = s1.object, s2.object
  else
    ball, paddle = s2.object, s1.object
  end

  p_a = {
    x = ball.x + dx,
    y = ball.y + dy
  }

  p_b = {
    x = paddle.x + paddle.width/2,
    y = paddle.y + paddle.height/2
  }

  vx = p_a.x - p_b.x
  vy = p_a.y - p_b.y

  if paddle.type == 'player' then
    ball.speed.x = math.abs(ball.speed.x) + vx
  else
    ball.speed.x = -math.abs(ball.speed.x) + vx
  end

  ball:sound()
end

function World:draw()

  if coll then
    love.graphics.circle('fill', coll.x, coll.y, 20, 10)
    love.graphics.circle('fill', paddle.x, paddle.y, 20, 10)
  end

  for name, object in pairs(self.objects) do
    object:draw()
  end

  love.graphics.print( self.score.left .. ':' .. self.score.right, 210, 10 )

  --love.graphics.setColor(255,0,0)
  --self.collider._hash:draw("line", false)
end

function World:update(dt)
  for name, object in pairs(self.objects) do
    object:update(dt)
  end

  self.collider:update(dt)
end

return World