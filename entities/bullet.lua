local class = require 'lib.middleclass'

local Entity = require 'entities.entity'

local Bullet = class('Bullet', Entity)

local width, height = 8,8
local speed = 800

function Bullet:initialize(world, x, y, vx, vy)
  x,y = x - width / 2, y - height / 2
  Entity.initialize(self, world, x,y, width, height)

  local len = math.sqrt(vx * vx + vy * vy)
  self.vx, self.vy = vx/len, vy/len

  self:setClock('maxLife', 0.5, self.destroy, self)
end

function Bullet:filter(other)
  local kind = other.class.name
  if kind == 'Tile' or kind == 'Target' then return 'touch' end
end

function Bullet:update(dt)
  local goalX = self.x + self.vx * dt * speed
  local goalY = self.y + self.vy * dt * speed

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
