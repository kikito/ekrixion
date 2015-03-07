local class      = require 'lib.middleclass'
local Projectile = require 'entities.projectiles.projectile'

local Pellet = class('Pellet', Projectile)

function Pellet:initialize(world, x, y, angle)
  Projectile.initialize(self, world, x, y, angle, {
    width  = 2,
    height = 2,
    life   = 0.4,
    speed  = 1200 + 300 * math.random()
  })
end

return Pellet
