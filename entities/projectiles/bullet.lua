local class      = require 'lib.middleclass'

local Projectile = require 'entities.projectiles.projectile'
local Puff       = require 'entities.puff'

local Bullet = class('Bullet', Projectile)

local options = {
  width  = 8,
  height = 8,
  life   = 0.6,
  speed  = 800
}

function Bullet:initialize(world, camera,  x, y, angle)
  Projectile.initialize(self, world, camera, x, y, angle, options)
end

function Bullet:hit(other)
  Projectile.hit(self, other)

  self:playSFX('bullet-hit')

  Puff:createMany(self.world,
    3,
    self.x, self.y, self.w, self.h,
    5, 3,
    0.5
  )
end

return Bullet
