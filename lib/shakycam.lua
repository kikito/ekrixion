--[[
-- skakycam lib
-- This is a small wrapper over gamera.lua that implements screen shake
-- * camera:shake() increases the intensity of the vibration
-- * camera:update(dt) decreases the intensity of the vibration slightly and moves the camera position according to the shake
-- ]]

local maxShake = 5
local atenuationSpeed = 4

local sakycam = {}

local ShakyCam = {}

function doShake(self, dt)
  local x,y = self.camera:getPosition()

  x = x + (200 * (math.random() - 0.5) * self.shakeIntensity) * dt
  y = y + (200 * (math.random() - 0.5) * self.shakeIntensity) * dt
  self:setPosition(x,y)
end

local methods = [[
  setWorld setWindow setPosition setAngle
  getScale getWorld getWindow getPosition getScale getAngle
  getVisible getVisibleCorners
  draw
  toWorld toScreen
]]

for name in methods:gmatch('%S+') do
  ShakyCam[name] = function(self, ...)
    return self.camera[name](self.camera, ...)
  end
end


function ShakyCam:shake(intensity)
  intensity = intensity or 3
  self.shakeIntensity = math.min(maxShake, self.shakeIntensity + intensity)
end

function ShakyCam:update(dt)
  self.shakeIntensity = math.max(0 , self.shakeIntensity - atenuationSpeed * dt)

  if self.shakeIntensity > 0 then
    doShake(self, dt)
  end
end

sakycam.new = function(camera)
  return setmetatable({camera = camera, shakeIntensity = 0}, {__index = ShakyCam})
end

return sakycam
