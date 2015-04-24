local class = require 'lib.middleclass'

local SoundPlayer = require 'sound_player'

local Entity = class 'Entity'

function Entity:initialize(world, x,y,w,h)
  self.world = world
  self.x, self.y, self.w, self.h = x,y,w,h
  self.soundPlayer = SoundPlayer:new(self:getCenter())
  world:add(self, x,y,w,h)
end

function Entity:draw(drawDebug)
end

function Entity:update(dt)
  self.soundPlayer:setPosition(self:getCenter())
  self.soundPlayer:update()
end

function Entity:playSFX(name)
  self.soundPlayer:play(name)
end

function Entity:getCenter()
  return self.x + self.w / 2, self.y + self.h / 2
end

function Entity:destroy()
  self.world:remove(self)
end

return Entity
