local class = require 'lib.middleclass'
local Weapon = require 'weapons.weapon'
local Bullet = require 'entities.projectiles.bullet'

local Uzi = class('Uzi', Weapon)

function Uzi:initialize(world, camera)
  Weapon.initialize(self, world, camera, {
    spread   = 0.1, -- radians
    coolDown = 0.1, -- seconds
    bulletsPerShot  = 1,
    projectileClass = Bullet,
    soundName       = 'bullet-shot'
  })
end

return Uzi
