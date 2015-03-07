local class = require 'lib.middleclass'
local Weapon = require 'weapons.weapon'
local Bullet = require 'entities.projectiles.bullet'

local Uzi = class('Uzi', Weapon)

function Uzi:initialize(world)
  Weapon:initialize(world, {
    spread   = 0.1, -- radians
    coolDown = 0.1, -- seconds
    bulletsPerShot  = 1,
    projectileClass = Bullet
  })
end

return Uzi
