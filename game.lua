local class    = require 'lib.middleclass'
local Stateful = require 'lib.stateful'

local Start    = require 'gamestates.start'
local Play     = require 'gamestates.play'

local Game = class('Game'):include(Stateful)

function Game:initialize()
  self:gotoState('Start')
end

function Game:update(dt)
end

function Game:draw()
end

function Game:keypressed(key, isrepeat)
end

Game:addState('Start', Start)
Game:addState('Play', Play)

return Game
