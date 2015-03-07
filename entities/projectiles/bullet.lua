local class      = require 'lib.middleclass'
local Projectile = require 'entities.projectiles.projectile'

local Bullet = class('Bullet', Projectile)

function Bullet:initialize(world, x, y, angle)
  Projectile.initialize(self, world, x, y, angle, {
    width  = 8,
    height = 8,
    life   = 0.6,
    speed  = 800
  })
end

return Bullet
