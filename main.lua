local World = require 'world'

inspect = require 'inspect'

local PlayState   = require 'states.play'
local PauseState  = require 'states.pause'

SCREEN = {
  width = 500,
  height = 300
}

function love.load()

  WORLD = World()

  states = {
    play  = PlayState(),
    pause = PauseState()
  }

  sounds = {
    ball_hit = love.audio.newSource('sounds/ball_hits_paddle.wav','static'),
    ai_score = love.audio.newSource('sounds/ai_scores.wav','static'),
    p1_score = love.audio.newSource('sounds/player_scores.wav','static')
  }

  love.window.setTitle('PONG!')
  love.window.setMode(SCREEN.width, SCREEN.height)

  font = love.graphics.newFont(48)
  love.graphics.setFont(font)

  curr_state = 'play'
end

function love.update(dt)
  states[curr_state]:update(dt)
end

function love.draw()
  states[curr_state]:draw()
end

function love.keypressed(key)
  states[curr_state]:keypressed(key)
end

