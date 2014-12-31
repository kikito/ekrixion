local class = require 'lib.middleclass'

local Entity = require 'entities.entity'

local Target = class('Target', Entity)

local width, height = 32,32

function Target:initialize(world,x,y)
  Entity.initialize(self, world, x,y,width,height)
end

function Target:draw()
  love.graphics.setColor(255,0,0)

  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

return Target
