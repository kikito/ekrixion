local Game  = require 'game'

local game

function love.load()
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, isrepeat)
  game:keypressed(key, isrepeat)
end
