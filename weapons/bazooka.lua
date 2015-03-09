local class = require 'lib.middleclass'
local Weapon = require 'weapons.weapon'
local Rocket = require 'entities.projectiles.rocket'

local Bazooka = class('Bazooka', Weapon)

function Bazooka:initialize(world, camera)
  Weapon.initialize(self, world, camera, {
    spread   = 0.01, -- radians
    coolDown = 0.7, -- seconds
    bulletsPerShot  = 1,
    projectileClass = Rocket,
    soundName = 'rocket-shot'
  })
end

return Bazooka
