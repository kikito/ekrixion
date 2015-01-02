local class = require 'lib.middleclass'

local Entity = require 'entities.entity'

local Bullet = class('Bullet', Entity)

local width, height = 8,8
local speed  = 800
local spread = 0.2 -- radians

function Bullet:initialize(world, x, y, angle)
  x,y = x - width / 2, y - height / 2
  Entity.initialize(self, world, x,y, width, height)
  self.angle = angle + spread * (math.random() - 0.5)
  self:setClock('maxLife', 0.5, self.destroy, self)
end

function Bullet:filter(other)
  local kind = other.class.name
  if kind == 'Tile' or kind == 'Target' then return 'touch' end
end

function Bullet:update(dt)
  local vx, vy = math.cos(self.angle), math.sin(self.angle)
  local goalX = self.x + vx * dt * speed
  local goalY = self.y + vy * dt * speed

  self.x, self.y, cols, len = self.world:move(self, goalX, goalY, self.filter)

  if len > 0 then
    self:destroy()
    for i=1, len do
      local other = cols[i].other
      if other.class.name == 'Target' then other:destroy() end
    end
  else
    self:updateClocks(dt)
  end
end

function Bullet:draw()
  love.graphics.setColor(255,255,255)
  local x, y = self:getCenter()
  local radius = width / 2
  love.graphics.circle('line', x,y, radius)
end

return Bullet
