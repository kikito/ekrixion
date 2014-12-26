local bump  = require 'lib.bump'
local class = require 'lib.middleclass'

local Player = require 'entities.player'

local Map = class('Map')

function Map:initialize(player)
  self.world = bump.newWorld()
  self.player = Player:new(self.world, 100, 100)
end

function Map:draw()
  love.graphics.print("Map", 100, 100)
end

function Map:update(dt)
  self.player:update(dt)
end

function Map:draw()
  self.player:draw()
end


return Map
