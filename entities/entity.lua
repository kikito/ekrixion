local class = require 'lib.middleclass'
local media = require 'media'

local Entity = class 'Entity'

function Entity:initialize(world, x,y,w,h)
  self.world = world
  self.x, self.y, self.w, self.h = x,y,w,h
  world:add(self, x,y,w,h)
  self.sfx = {}
end

function Entity:draw(drawDebug)
end

function Entity:update(dt)
  self:updateSFX()
end

function Entity:updateSFX()
  local x,y = self:getCenter()
  for sfx in pairs(self.sfx) do
    if sfx:isStopped() then
      self.sfx[sfx] = nil
    else
      sfx:setPosition(x,y)
    end
  end
end

function Entity:playSFX(name)
  local x,y = self:getCenter()
  local sfx = media.sfx[name]:play()

  sfx:setAttenuationDistances(20, 600)
  sfx:setPosition(x,y,0)

  self.sfx[sfx] = true
  return sfx
end

function Entity:getCenter()
  return self.x + self.w / 2, self.y + self.h / 2
end

function Entity:destroy()
  self.world:remove(self)
end

return Entity
