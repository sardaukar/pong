local Class = require 'hump.class'

local Paddle    = require 'paddle'
local AiPaddle  = require 'ai_paddle'
local Ball      = require 'ball'

local World = Class {}

function World:init(state)
  self.objects = {
    paddle1 = Paddle( 0, (SCREEN.height / 2), 400 ),
    paddle2 = AiPaddle( (SCREEN.width - 20), (SCREEN.height / 2), 125 ),
    ball    = Ball(SCREEN.width / 2, SCREEN.height / 2)
  }

  self.score = {
    left  = 0,
    right = 0
  }

end

return World