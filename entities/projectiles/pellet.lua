local class      = require 'lib.middleclass'
local Puff       = require 'entities.puff'
local Projectile = require 'entities.projectiles.projectile'

local Pellet = class('Pellet', Projectile)

local options = {
  width  = 4,
  height = 4,
  life   = 0.4,
  speed  = 1500,
  speedVariance = 800
}

function Pellet:initialize(world, camera,  x, y, angle)
  Projectile.initialize(self, world, camera, x, y, angle, options)

  self.trace_x, self.trace_y = self.x, self.y
  self.trace_speed = self.speed - 300 * math.random()
end

function Pellet:update(dt)
  Projectile.update(self, dt)

  local vx, vy = math.cos(self.angle), math.sin(self.angle)
  self.trace_x = self.trace_x + vx * dt * self.trace_speed
  self.trace_y = self.trace_y + vy * dt * self.trace_speed
end

function Pellet:draw()
  Projectile.draw(self)
  love.graphics.setColor(255,255,255)
  local w2,h2 = self.w/2, self.h/2
  love.graphics.line(self.x+w2, self.y+h2, self.trace_x+w2, self.trace_y+h2)
end

function Pellet:hit(other)
  Projectile.hit(self, other)

  self:playSFX('bullet-hit')

  Puff:createMany(self.world,
    3,
    self.x, self.y, self.w, self.h,
    4, 2,
    0.5
  )
end


return Pellet
