local class = require 'lib.middleclass'
local Weapon = require 'entities.weapons.weapon'
local Pellet = require 'entities.projectiles.pellet'
local CameraShaker = require 'entities.camera_shaker'

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

function Shotgun:fire()
  if self.canFire then
    CameraShaker:new(self.world, self.x, self.y, 40, 0.1)
  end

  Weapon.fire(self)
end


return Shotgun

