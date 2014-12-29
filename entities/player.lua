local class = require 'lib.middleclass'

local Entity = require 'entities.entity'
local Bullet = require 'entities.bullet'

local Player = class('Player', Entity)

local width, height = 16,16
local speed         = 200

function Player:initialize(world, x,y)
  Entity.initialize(self, world, x,y,width,height)
end

function Player:filter(other)
  if other.class.name == 'Tile' then return 'slide' end
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

  if love.keyboard.isDown(' ') then
    local x,y = self:getCenter()
    Bullet:new(self.world, x, y, 10, 0)
  end
end



return Player
