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

  Puff:createMany(self.world,
    3,
    self.x, self.y, self.w, self.h,
    5, 3,
    0.5
  )
end

return Bullet
