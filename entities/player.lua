local class = require 'lib.middleclass'

local Shotgun = require 'weapons.shotgun'
local Uzi     = require 'weapons.uzi'
local Handgun = require 'weapons.handgun'
local Bazooka = require 'weapons.bazooka'

local Entity = require 'entities.entity'

local Player = class('Player', Entity)

local width, height = 16,16
local speed         = 200         -- pixels / second
local angularSpeed  = 2 * math.pi -- radians / second

function Player:initialize(camera, world, x,y)
  Entity.initialize(self, world, x,y,width,height)

  self.camera = camera
  self.angle = 0

  self.weapons = {
    uzi     = Uzi:new(world, camera),
    shotgun = Shotgun:new(world, camera),
    bazooka = Bazooka:new(world, camera),
    handgun = Handgun:new(world, camera)
  }

  self.weapon = self.weapons.uzi
end

function Player:filter(other)
  if other.class.name == 'Tile' then return 'slide' end
end

function Player:setWeapon(name)
  self.weapon = assert(self.weapons[name])
end

function Player:update(dt)
  for _,weapon in pairs(self.weapons) do
    weapon:update(dt)
  end

  local tx, ty = self.camera:toWorld(love.mouse.getPosition())
  local cx, cy = self:getCenter()

  local target = math.atan2(ty-cy, tx-cx)
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

  local dx, dy = 0, 0
  if love.keyboard.isDown('d') then
    dx = 1
  elseif love.keyboard.isDown('a') or love.keyboard.isDown('q') then
    dx = -1
  end
  if love.keyboard.isDown('s') then
    dy = 1
  elseif love.keyboard.isDown('w') or love.keyboard.isDown('z') then
    dy = -1
  end

  if dx ~= 0 or dy ~= 0 then
    local a = math.atan2(dy, dx)
    local x,y = math.cos(a) * speed * dt, math.sin(a) * speed * dt
    self.x, self.y = self.world:move(self, self.x + x, self.y + y, self.filter)
  end

  if love.mouse.isDown('l') then
    local x,y = self:getCenter()
    self.weapon:attack(x,y,self.angle)
  end
end

function Player:draw()
  love.graphics.setColor(0,255,0)

  local x, y = self:getCenter()
  local radius = width / 2
  love.graphics.circle('line', x,y, radius)
  love.graphics.line(x,y, x + radius * math.cos(self.angle), y + radius * math.sin(self.angle))
end


return Player
