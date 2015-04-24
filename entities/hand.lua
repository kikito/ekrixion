local class = require 'lib.middleclass'

local Hand = class('Hand')

function Hand:initialize(owner, armLength, angle)
  self.owner      = owner
  self.armLength  = armLength
  self.angle      = angle

  self:updatePosition()
end

function Hand:updatePosition()
  local owner      = self.owner
  local armLength  = self.armLength
  local x,y        = owner:getCenter()
  local angle      = owner.angle + self.angle

  local dx, dy = math.cos(angle), math.sin(angle)

  self.x = x + dx * armLength
  self.y = y + dy * armLength
end

function Hand:draw()
  love.graphics.setColor(0,255,0)
  love.graphics.circle('line', self.x, self.y, 3)
end


return Hand

