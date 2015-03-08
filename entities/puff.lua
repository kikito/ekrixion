local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local Entity = require 'entities.entity'

local Puff = class('Puff', Entity)

local up_speed = 30

function Puff.static:createMany(world, how_many,
                                area_x, area_y, area_w, area_h,
                                w, h,
                                duration)
  for i=1, how_many do
    Puff:new(
      world,
      area_x + math.random() * area_w,
      area_y + math.random() * area_h,
      w + math.random() * w,
      h + math.random() * h,
      duration + math.random() * duration
    )
  end
end

function Puff:initialize(world, x,y,w,h, duration)
  x = x - w/2
  y = y - h/2

  Entity.initialize(self, world, x,y,w,h)

  duration = duration or 1

  self.clock = cron.after(duration, Puff.destroy, self)
end

function Puff:update(dt)
  self.y = self.y - up_speed * dt
  self.world:update(self, self.x, self.y)

  self.clock:update(dt)
end

return Puff
