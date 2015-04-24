local class = require 'lib.middleclass'

local Entity = require 'entities.entity'
local Shotgun = require 'entities.weapons.shotgun'
local Uzi     = require 'entities.weapons.uzi'
local Handgun = require 'entities.weapons.handgun'
local Bazooka = require 'entities.weapons.bazooka'

local Pawn = class('Pawn', Entity)

local width, height = 16,16
local speed         = 200         -- pixels / second
local angularSpeed  = 2 * math.pi -- radians / second

function Pawn:initialize(camera, world, x,y)
  Entity.initialize(self, world, x,y,width,height)

  self.angle = 0

  self.weapons = {}

  self.desiredAngle = 0
  self.desiredMovementVector = {x=0,y=0}
  self.wantsToAttack = false
  self:addWeapon('uzi',     Uzi:new(world, x,y, 0))
  self:addWeapon('shotgun', Shotgun:new(world, x,y, 0))
  self:addWeapon('bazooka', Bazooka:new(world, x,y, 0))
  self:addWeapon('handgun', Handgun:new(world, x,y, 0))
end

function Pawn:addWeapon(name, weapon)
  self.weapons[name] = weapon
  self.weapon = self.weapon or weapon
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
  self.weapon = self.weapons[desiredWeaponName] or self.weapon
end

function Pawn:attack()
  if self.weapon then
    local x,y = self:getCenter()
    self.weapon:fire()
  end
end

function Pawn:update(dt)
  for _,weapon in pairs(self.weapons) do
    weapon:update(dt)
  end

  self:lookTowards(self.desiredAngle, dt)
  self:moveTowards(self.desiredMovementVector.x, self.desiredMovementVector.y, dt)

  if self.weapon then
    local hx,hy = self:getHandPosition()
    self.weapon:setCoords(hx, hy, self.angle)
  end

  if self.wantsToAttack then self:attack() end

  Entity.update(self, dt)
end

function Pawn:getHandPosition()
  local ARM_SIZE = 15
  local x,y = self:getCenter()

  local angle = self.angle

  local dx, dy = math.cos(angle), math.sin(angle)

  return x + dx * ARM_SIZE, y + dy * ARM_SIZE
end

function Pawn:draw()
  love.graphics.setColor(0,255,0)

  local x, y = self:getCenter()
  local radius = width / 2
  love.graphics.circle('line', x,y, radius)
  love.graphics.line(x,y, x + radius * math.cos(self.angle), y + radius * math.sin(self.angle))

  if self.weapon then
    self.weapon:drawHold()
  end

end

return Pawn
