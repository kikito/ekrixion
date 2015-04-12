local gamera = require 'lib.gamera'
local class  = require 'lib.middleclass'

local CameraMan = class('CameraMan')

local filter = function(_, other)
  return other.class.name == 'CameraShaker'
end

local function spring(value, velocity, target, dt)
  local omega   = math.pi * 8
  local zeta    = 0.23
  local f       = 1.0 + dt * zeta * omega * 2.0
  local dtoo    = dt * omega * omega
  local dtdtoo  = dt * dtoo
  local det     = f + dtdtoo
  value    = (f * value + dt * velocity + dtdtoo * target) / det
  velocity = (velocity + dtoo * (target - value)) / det
  return value, velocity
end

function CameraMan:initialize(world, width, height)
  self.camera = gamera.new(0,0,width,height)
  self.world = world
  self.x,  self.y  = 0,0
  self.vx, self.vy = 0,0
  self.tx, self.ty = 0,0
end

local methods = [[
  setWorld setWindow setAngle
  getScale getWorld getWindow getPosition getScale getAngle
  getVisible getVisibleCorners
  draw
  toWorld toScreen
]]

for name in methods:gmatch('%S+') do
  CameraMan[name] = function(self, ...)
    return self.camera[name](self.camera, ...)
  end
end

function CameraMan:shake(dx, dy)
  self.x = (math.random() - 0.5) * 10
  self.y = (math.random() - 0.5) * 10
end

function CameraMan:setTarget(x,y)
  self.tx, self.ty = x,y
end

function CameraMan:reactToShakers(x,y)
  local items, len = self.world:queryPoint(x,y,filter)

  for i=1, len do
    local cx,cy = items[i]:getCenter()
    local dx,dy = x - cx, y - cy
    self.x = self.x + dx
    self.y = self.y + dy
  end
end

function CameraMan:update(dt)
  self.x, self.vx = spring(self.x, self.vx, self.tx, dt)
  self.y, self.vy = spring(self.y, self.vy, self.ty, dt)

  self.camera:setPosition(self.x, self.y)
end

return CameraMan
