local gamera = require 'lib.gamera'
local class  = require 'lib.middleclass'

local CameraMan = class('CameraMan')

local MAX_SHAKE_INTENSITY = 20  -- pixels
local MAX_SHAKE_FREQUENCY = 0.1 -- seconds
local ATENUATION_SPEED    = 30  -- pixels / second

local function doShake(self)
  self.shakeX = (math.random() - 0.5) * self.shakeIntensity
  self.shakeY = (math.random() - 0.5) * self.shakeIntensity
  self.timeSinceLastShake = 0
end

function CameraMan:initialize(world, width, height)
  self.camera = gamera.new(0,0,width,height)
  self.world = world
  self.shakeIntensity = 0
  self.shakeX = 0
  self.shakeY = 0
  self.timeSinceLastShake = 0
end

local methods = [[
  setWorld setWindow setPosition setAngle
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

function CameraMan:shakeBig()
  self:shake(MAX_SHAKE_INTENSITY)
end

function CameraMan:shakeMedium()
  self:shake(MAX_SHAKE_INTENSITY/2)
end

function CameraMan:shakeSmall()
  self:shake(MAX_SHAKE_INTENSITY/3.5)
end

function CameraMan:shake(intensity)
  self.shakeIntensity = math.min(MAX_SHAKE_INTENSITY, self.shakeIntensity + intensity)
  doShake(self)
end

function CameraMan:update(dt)
  self.shakeIntensity = math.max(0 , self.shakeIntensity - ATENUATION_SPEED * dt)

  self.timeSinceLastShake = self.timeSinceLastShake + dt + math.random() * dt

  if self.timeSinceLastShake >= MAX_SHAKE_FREQUENCY then
    doShake(self)
  end

  local x,y = self.camera:getPosition()
  self:setPosition(x + self.shakeX, y + self.shakeY)
end

return CameraMan
