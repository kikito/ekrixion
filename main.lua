local Game  = require 'game'
local media = require 'media'

local game

function love.load()
  game = Game:new()
  media.load()
end

function love.update(dt)
  game:update(dt)
  media.cleanup()
end

function love.draw()
  game:draw()
end

function love.keypressed(key, isrepeat)
  game:keypressed(key, isrepeat)
end
