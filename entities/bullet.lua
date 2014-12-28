local class = require 'lib.middleclass'

local Bullet = class('Bullet')

local width, height = 8,8
local speed = 500
local maxLife = 0.5 -- seconds

function Bullet:initialize(world, x, y, vx, vy)
  x,y = x - width / 2, y - height / 2

  self.x, self.y = x, y
  self.world = world

  local len = math.sqrt(vx * vx + vy * vy)
  self.vx, self.vy = vx/len, vy/len

  self.world:add(self, x, y, width, height)

  self.lived = 0
end

function Bullet:filter(other)
  if other.class.name == 'Tile' then return 'touch' end
end

function Bullet:update(dt)

  local goalX = self.x + self.vx * dt * speed
  local goalY = self.y + self.vy * dt * speed

  self.x, self.y, _, len = self.world:move(self, goalX, goalY, self.filter)

  self.lived = self.lived + dt

  if len > 0 or self.lived >= maxLife then
    self:destroy()
  end
end

function Bullet:destroy()
  self.world:remove(self)
end

function Bullet:draw()
  love.graphics.setColor(255, 255, 0)
  love.graphics.rectangle('line', self.x, self.y, width, height)
end

return Bullet
