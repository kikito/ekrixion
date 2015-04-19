local class = require 'lib.middleclass'
local Weapon = require 'entities.weapons.weapon'
local Pellet = require 'entities.projectiles.pellet'

local Shotgun = class('Shotgun', Weapon)

local OPTIONS = {
  spread   = 0.3,
  coolDown = 0.7,
  bulletsPerShot  = 6,
  projectileClass = Pellet,
  soundName = 'shotgun-shot'
}

function Shotgun:initialize(world, x, y, angle)
  Weapon.initialize(self, world, x, y, angle, OPTIONS)
end

return Shotgun

