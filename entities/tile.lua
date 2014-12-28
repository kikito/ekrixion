local class = require 'lib.middleclass'

local Tile = class 'Tile'

function Tile:initialize(world, x, y)
  self.x, self.y = x,y
  self.world = world
  self.width = math.random(1, 10) * 10
  self.height = math.random(1, 10) * 10
  world:add(self, self.x, self.y, self.width, self.height)
end

function Tile:draw()
  love.graphics.setColor(100,100,100)
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

function Tile:update(dt)
end

return Tile
