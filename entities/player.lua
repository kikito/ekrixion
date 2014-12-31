local class = require 'lib.middleclass'

local Entity = require 'entities.entity'
local Bullet = require 'entities.bullet'

local Player = class('Player', Entity)

local width, height = 16,16
local speed         = 200         -- pixels / second
local angularSpeed  = 2 * math.pi -- radians / second
local shootCoolDown = 0.1         -- secons

local function shootCoolDownFinished(self)
  self.canFire = true
end

function Player:initialize(world, x,y)
  Entity.initialize(self, world, x,y,width,height)
  self.angle = 0
  self.canFire = true
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

  if dx ~= 0 or dy ~= 0 then
    local target = math.atan2(dy,dx)
    local angle  = self.angle

    local pi    = math.pi
    local diff  = (target - angle + pi) % (2 * pi) - pi
    local adiff = math.abs(diff)

    if adiff < angularSpeed * dt then
      self.angle = target
    else
      local w = diff > 0 and angularSpeed or -angularSpeed
      self.angle = self.angle + w * dt
    end

    if adiff < pi / 4 then
      local x,y = math.cos(self.angle) * speed * dt, math.sin(self.angle) * speed * dt

      self.x, self.y = self.world:move(self, self.x + x, self.y + y, self.filter)
    end
  end

  if self.canFire and love.keyboard.isDown(' ') then
    local x,y = self:getCenter()
    Bullet:new(self.world, x, y, math.cos(self.angle), math.sin(self.angle))
    self.canFire = false
    self:setClock('shootCoolDown', shootCoolDown, shootCoolDownFinished, self)
  end

  self:updateClocks(dt)
end

function Player:draw()
  love.graphics.setColor(0,255,0)
  local x, y = self:getCenter()
  local radius = width / 2
  love.graphics.circle('line', x,y, radius)
  love.graphics.line(x,y, x + radius * math.cos(self.angle), y + radius * math.sin(self.angle))
end



return Player
