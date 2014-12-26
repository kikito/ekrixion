local class = require 'lib.middleclass'

local Player = class 'Player'

local width, height = 16,16
local speed         = 200

function Player:initialize(world, x,y)
  self.x, self.y = x,y
  self.world = world
  world:add(self, self.x, self.y, width, height)
end

function Player:update(dt)
  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    dx = speed * dt
  elseif love.keyboard.isDown('left') then
    dx = -speed * dt
  end
  if love.keyboard.isDown('down') then
    dy = speed * dt
  elseif love.keyboard.isDown('up') then
    dy = -speed * dt
  end

  if dx ~= 0 or dy ~= 0 then
    self.x, self.y = self.world:move(self, self.x + dx, self.y + dy)
  end
end

function Player:draw()
  love.graphics.rectangle('line', self.x, self.y, width, height)
end

return Player
