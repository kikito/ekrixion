local class = require 'lib.middleclass'
local Weapon = require 'weapons.weapon'
local Pellet = require 'entities.projectiles.pellet'

local Shotgun = class('Shotgun', Weapon)

function Shotgun:initialize(world, camera)
  Weapon.initialize(self, world, camera, {
    spread   = 0.3,
    coolDown = 0.7,
    bulletsPerShot  = 6,
    projectileClass = Pellet,
    soundName = 'shotgun-shot'
  })
end

function Shotgun:attack(x,y,angle)
  if Weapon.attack(self, x,y,angle) then
    self.camera:shake(2)
    return true
  end
end

return Shotgun

