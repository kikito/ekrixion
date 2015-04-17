local class = require 'lib.middleclass'

local Entity = require 'entities.entity'

local Tile = class('Tile', Entity)

function Tile:initialize(world, x, y)
  local w = math.random(1, 10) * 10
  local h = math.random(1, 10) * 10
  Entity.initialize(self, world, x, y, w, h)
end

function Tile:draw(drawDebug)
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

return Tile
