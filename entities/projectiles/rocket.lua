local class      = require 'lib.middleclass'
local media      = require 'media'
local Projectile = require 'entities.projectiles.projectile'
local Puff       = require 'entities.puff'
local CameraShaker = require 'entities.camera_shaker'

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

  local size=40
  Puff:createMany(self.world,
    5,
    self.x-size, self.y-size, self.w+size, self.h+size,
    40, 60,
    0.5
  )

  local size = 200
  local cx, cy = self:getCenter()

  CameraShaker:new(self.world, cx, cy, 400, 0.1)

  self:playSFX('explosion')

  Projectile.destroy(self)
end

return Rocket
