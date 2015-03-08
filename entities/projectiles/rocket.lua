local class      = require 'lib.middleclass'
local media      = require 'media'
local Projectile = require 'entities.projectiles.projectile'
local Puff       = require 'entities.puff'

local Rocket = class('Rocket', Projectile)

local options = {
  width  = 15,
  height = 15,
  life   = 0.8,
  speed  = 1000
}

function Rocket:initialize(world, x, y, angle)
  Projectile.initialize(self, world, x, y, angle, options)
end

function Rocket:destroy()
  -- Todo: generalize into puffgroup/explosion
  for i=1,5 do
    Puff:new(self.world,
      self.x + (math.random() - 0.5) * 100,
      self.y + (math.random() - 0.5) * 100,
      40 + math.random() * 40,
      60 + math.random() * 60
    )
  end

  media.sfx.explosion:play()

  Projectile.destroy(self)
end

return Rocket
