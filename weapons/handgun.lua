local class = require 'lib.middleclass'
local Weapon = require 'weapons.weapon'
local Bullet = require 'entities.projectiles.bullet'

local Handgun = class('Handgun', Weapon)

function Handgun:initialize(world, camera)
  Weapon.initialize(self, world, camera, {
    spread   = 0.01, -- radians
    coolDown = 0.7, -- seconds
    bulletsPerShot  = 1,
    projectileClass = Bullet,
    soundName       = 'bullet-shot'
  })
end

return Handgun
