local class = require 'lib.middleclass'

local Player = class 'Player'

local width, height = 16,16
local speed         = 200

function Player:initialize(world, x,y)
  self.x, self.y = x,y
  self.world = world
  world:add(self, self.x, self.y, width, height)
end

function Player:filter(other)
  return false
end

function Player:update(dt)
  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    dx = 1
  elseif love.keyboard.isDown('left') then
    dx = -1
  end
  if love.keyboard.isDown('down') then
    dy = 1
  elseif love.keyboard.isDown('up') then
    dy = -1
  end

  local len = math.sqrt(dx*dx + dy*dy)
  if len > 0 then
    dx = dx * speed * dt / len
    dy = dy * speed * dt / len

    self.x, self.y = self.world:move(self, self.x + dx, self.y + dy, self.filter)
  end
end

function Player:draw()
  love.graphics.setColor(0,255,0)
  love.graphics.rectangle('line', self.x, self.y, width, height)
end

function Player:getCenter()
  return self.x + width / 2, self.y + height / 2
end

return Player
