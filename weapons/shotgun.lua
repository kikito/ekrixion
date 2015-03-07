local class = require 'lib.middleclass'
local Weapon = require 'weapons.weapon'
local Pellet = require 'entities.projectiles.pellet'

local Shotgun = class('Shotgun', Weapon)

function Shotgun:initialize(world)
  Weapon:initialize(world, {
    spread   = 0.3,
    coolDown = 0.7,
    bulletsPerShot  = 6,
    projectileClass = Pellet
  })
end

return Shotgun

