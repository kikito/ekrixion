local class      = require 'lib.middleclass'
local Projectile = require 'entities.projectiles.projectile'

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

return Bullet
