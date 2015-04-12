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

function Handgun:attack(attacker, x,y,angle)
  if Weapon.attack(self, attacker, x,y,angle) then
    self.camera:shake()
    return true
  end
end


return Handgun
