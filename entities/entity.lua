local class = require 'lib.middleclass'

local Entity = class 'Entity'

function Entity:initialize(world, x,y,w,h)
  self.world = world
  self.x, self.y, self.w, self.h = x,y,w,h
  world:add(self, x,y,w,h)
end

function Entity:draw(drawDebug)
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

function Entity:update(dt)
end

function Entity:getCenter()
  return self.x + self.w / 2, self.y + self.h / 2
end

function Entity:destroy()
  self.world:remove(self)
end

return Entity
