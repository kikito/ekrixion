local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local Entity = class 'Entity'

function Entity:initialize(world, x,y,w,h)
  self.world = world
  self.x, self.y, self.w, self.h = x,y,w,h
  world:add(self, x,y,w,h)

  self.clocks = {}
end

function Entity:draw(drawDebug)
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

function Entity:updateClocks(dt)
  for name,clock in pairs(self.clocks) do
    if clock:update(dt) then
      self.clocks[name] = nil
    end
  end
end

function Entity:update(dt)
end

function Entity:setClock(name, time, callback, ...)
  self.clocks[name] = cron.after(time, callback, ...)
end

function Entity:getCenter()
  return self.x + self.w / 2, self.y + self.h / 2
end

function Entity:destroy()
  self.world:remove(self)
end

return Entity
