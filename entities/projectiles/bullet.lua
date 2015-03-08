local class      = require 'lib.middleclass'
local media      = require 'media'

local Projectile = require 'entities.projectiles.projectile'
local Puff       = require 'entities.puff'

local Bullet = class('Bullet', Projectile)

local options = {
  width  = 8,
  height = 8,
  life   = 0.6,
  speed  = 800
}

function Bullet:initialize(world, x, y, angle)
  Projectile.initialize(self, world, x, y, angle, options)
end

function Bullet:hit(other)
  Projectile.hit(self, other)

  media.sfx['bullet-hit']:play()

  for i=1,3 do
    Puff:new(
      self.world,
      self.x + (math.random() - 0.5) * self.w,
      self.y + (math.random() - 0.5) * self.h,
      5 + math.random() * 5,
      3 + math.random() * 3,
      math.random()
    )
  end

end

return Bullet
