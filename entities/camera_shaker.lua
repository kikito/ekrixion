local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local Entity = require 'entities.entity'

local CameraShaker = class('CameraShaker', Entity)

function CameraShaker:initialize(world, x,y,size,duration)
  Entity.initialize(self, world, x-size/2, y-size/2, size, size)
  self.clock = cron.after(duration, function()
    self:destroy()
  end)
end

function CameraShaker:update(dt)
  self.clock:update(dt)
end

return CameraShaker

