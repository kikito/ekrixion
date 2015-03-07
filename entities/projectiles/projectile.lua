local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local Entity = require 'entities.entity'

local Projectile = class('Projectile', Entity)

function Projectile:initialize(world, x, y, angle, opt)

  local width  = opt.width  or 8
  local height = opt.height or 8
  x,y = x - width / 2, y - height / 2

  Entity.initialize(self, world, x,y, width, height)

  self.angle  = angle
  self.life   = opt.life or 0.5
  self.speedVariance = opt.speedVariance or 0
  self.speed  = opt.speed  or 800

  self.speed = self.speed + (math.random() - 0.5) * self.speedVariance

  self.clock = cron.after(0.5, self.destroy, self)
end

function Projectile:update(dt)

  local vx, vy = math.cos(self.angle), math.sin(self.angle)
  local goalX = self.x + vx * dt * self.speed
  local goalY = self.y + vy * dt * self.speed

  self.x, self.y, cols, len = self.world:move(self, goalX, goalY, self.filter)

  if len > 0 then
    self:destroy()
    for i=1, len do
      local other = cols[i].other
      if other.class.name == 'Target' then other:destroy() end
    end
  else
    self.clock:update(dt)
  end
end

function Projectile:filter(other)
  local kind = other.class.name
  if kind == 'Tile' or kind == 'Target' then return 'touch' end
end

function Projectile:draw()
  love.graphics.setColor(255,255,255)
  local x, y = self:getCenter()
  local radius = self.w / 2
  love.graphics.circle('line', x,y, radius)
end

return Projectile

