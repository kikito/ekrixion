local class = require 'lib.middleclass'
local Weapon = require 'entities.weapons.weapon'
local Bullet = require 'entities.projectiles.bullet'

local Handgun = class('Handgun', Weapon)

local OPTIONS = {
  spread   = 0.01, -- radians
  coolDown = 0.7, -- seconds
  bulletsPerShot  = 1,
  projectileClass = Bullet,
  soundName       = 'bullet-shot'
}

function Handgun:initialize(world, x, y, angle)
  Weapon.initialize(self, world, x, y, angle, OPTIONS)
end

return Handgun
