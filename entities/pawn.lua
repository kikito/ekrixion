local class = require 'lib.middleclass'

local Shotgun = require 'weapons.shotgun'
local Uzi     = require 'weapons.uzi'
local Handgun = require 'weapons.handgun'
local Bazooka = require 'weapons.bazooka'

local Entity = require 'entities.entity'

local Pawn = class('Pawn', Entity)

local width, height = 16,16
local speed         = 200         -- pixels / second
local angularSpeed  = 2 * math.pi -- radians / second

function Pawn:initialize(camera, brain, world, x,y)
  Entity.initialize(self, world, x,y,width,height)

  self.angle = 0

  self.weapons = {
    uzi     = Uzi:new(world, camera),
    shotgun = Shotgun:new(world, camera),
    bazooka = Bazooka:new(world, camera),
    handgun = Handgun:new(world, camera)
  }

  self.brain = brain
end

function Pawn:filter(other)
  if other.class.name == 'Tile' then return 'slide' end
end

function Pawn:setWeapon(name)
  self.weapon = assert(self.weapons[name])
end

function Pawn:lookTowards(desiredAngle, dt)
  local angle  = self.angle

  local pi    = math.pi
  local diff  = (desiredAngle - angle + pi) % (2 * pi) - pi
  local adiff = math.abs(diff)

  if adiff < angularSpeed * dt then
    self.angle = desiredAngle
  else
    local w = diff > 0 and angularSpeed or -angularSpeed
    self.angle = self.angle + w * dt
  end
end

function Pawn:moveTowards(dx,dy, dt)
  if dx ~= 0 or dy ~= 0 then
    local a = math.atan2(dy, dx)
    local x,y = math.cos(a) * speed * dt, math.sin(a) * speed * dt
    self.x, self.y = self.world:move(self, self.x + x, self.y + y, self.filter)
  end
end

function Pawn:setWeapon(desiredWeaponName)
  self.weapon = self.weapons[self.brain:getDesiredWeaponName()]
end

function Pawn:attack()
  local x,y = self:getCenter()
  self.weapon:attack(x,y,self.angle)
end

function Pawn:update(dt)
  for _,weapon in pairs(self.weapons) do
    weapon:update(dt)
  end

  self.brain:setPosition(self:getCenter())
  self.brain:update(dt)

  local desiredAngle = self.brain:getDesiredAngle()
  self:lookTowards(desiredAngle, dt)

  local dx,dy = self.brain:getDesiredMovementVector()
  self:moveTowards(dx,dy, dt)

  self:setWeapon(self.brain:getDesiredWeaponName())

  if self.brain:wantsToAttack() then self:attack() end
end

function Pawn:draw()
  love.graphics.setColor(0,255,0)

  local x, y = self:getCenter()
  local radius = width / 2
  love.graphics.circle('line', x,y, radius)
  love.graphics.line(x,y, x + radius * math.cos(self.angle), y + radius * math.sin(self.angle))
end

return Pawn
