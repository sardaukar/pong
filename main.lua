local World = require 'world'
inspect = require 'inspect'

SCREEN = {
  width = 500,
  height = 300
}

function love.load()

  WORLD = World()

  sounds = {
    ball_hit = love.audio.newSource('sounds/ball_hits_paddle.wav','static'),
    ai_score = love.audio.newSource('sounds/ai_scores.wav','static'),
    p1_score = love.audio.newSource('sounds/player_scores.wav','static')
  }

  love.window.setTitle('PONG!')
  love.window.setMode(SCREEN.width, SCREEN.height)

  font = love.graphics.newFont(48)
  love.graphics.setFont(font)
end

function love.update(dt)
  WORLD:update(dt)
end

function love.draw()
  WORLD:draw()
end

function love.keypressed(key)
  WORLD:keypressed(key)
end

