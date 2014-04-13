local Class = require 'hump.class'

local Paddle    = require 'paddle'
local AiPaddle  = require 'ai_paddle'
local Ball      = require 'ball'

local PlayState   = require 'play'
local PauseState  = require 'pause'

local World = Class {}

function World:init(state)
  self.objects = {
    paddle1 = Paddle( 0, (SCREEN.height / 2), 400 ),
    paddle2 = AiPaddle( (SCREEN.width - 20), (SCREEN.height / 2), 125 ),
    ball    = Ball(SCREEN.width / 2, SCREEN.height / 2)
  }

  self.states = {
    play  = PlayState(),
    pause = PauseState()
  }

  self.score = {
    left  = 0,
    right = 0
  }

  self.curr_state = 'play'

end

function World:draw()
  self.states[self.curr_state]:draw()
end

function World:update(dt)
  self.states[self.curr_state]:update(dt, self)
end

function World:keypressed(key)
  self.states[self.curr_state]:keypressed(key)
end


return World