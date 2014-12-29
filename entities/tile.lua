local class = require 'lib.middleclass'

local Entity = require 'entities.entity'

local Tile = class('Tile', Entity)

function Tile:initialize(world, x, y)
  local w = math.random(1, 10) * 10
  local h = math.random(1, 10) * 10
  Entity.initialize(self, world, x, y, w, h)
end

return Tile
