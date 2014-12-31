local bump  = require 'lib.bump'
local class = require 'lib.middleclass'

local Player = require 'entities.player'
local Tile   = require 'entities.tile'
local Target = require 'entities.target'

local Map = class('Map')

local width, height = 2000, 2000

function Map:initialize(player)
  self.world = bump.newWorld()
  self.player = Player:new(self.world, 100, 100)

  for i=1,100 do
    Tile:new(self.world,
             math.random(100, width - 100),
             math.random(100, height - 100))
  end

  for i=1,40 do
    Target:new(self.world,
               math.random(100, width - 100),
               math.random(100, height - 100))
  end
end

function Map:draw()
  love.graphics.print("Map", 100, 100)
end

function Map:update(dt, l,t,w,h)
  local visibleThings, len = self.world:queryRect(l,t,w,h)

  for i=1, len do
    visibleThings[i]:update(dt)
  end
end

function Map:draw(drawDebug, l,t,w,h)
  local visibleThings, len = self.world:queryRect(l,t,w,h)

  for i=1, len do
    visibleThings[i]:draw(drawDebug)
  end
end

function Map:getDimensions()
  return width, height
end

function Map:getPlayerPosition()
  return self.player:getCenter()
end



return Map
