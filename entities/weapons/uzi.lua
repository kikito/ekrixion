local class = require 'lib.middleclass'
local Weapon = require 'entities.weapons.weapon'
local Bullet = require 'entities.projectiles.bullet'

local Uzi = class('Uzi', Weapon)

local OPTIONS = {
  spread   = 0.1, -- radians
  coolDown = 0.2, -- seconds
  bulletsPerShot  = 1,
  projectileClass = Bullet,
  soundName       = 'bullet-shot'
}

function Uzi:initialize(world, x, y, angle)
  Weapon.initialize(self, world, x, y, angle, OPTIONS)
end

return Uzi
