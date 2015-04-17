local bump  = require 'lib.bump'

local CameraMan = require 'camera_man'
local Map = require 'map'

local Play = {}

function Play:enteredState()
  self.world = bump.newWorld()
  local width, height = 2000, 2000

  self.camera = CameraMan:new(self.world, width, height)

  self.map = Map:new(self.world, width, height, self.camera)

  self.camera:setPosition(self.map:getPlayerPosition())

  love.audio.setDistanceModel("linear clamped")
end

function Play:keypressed(key, isrepeat)
  if key == 'escape' then self:gotoState('Start')
  else
    self.map:keyPressed(key)
  end
end

function Play:exitedState()
  love.audio.setDistanceModel("none")
  self.map = nil
end

function Play:update(dt)
  self.map:update(dt, self.camera:getVisible())
  local cx,cy = self.map:getPlayerPosition()
  self.camera:setTarget(cx,cy)
  self.camera:reactToShakers(cx,cy)
  self.camera:update(dt)
end

function Play:draw()
  local drawDebug = false
  self.camera:draw(function(l,t,w,h)
    self.map:draw(drawDebug, l,t,w,h)
  end)
end

return Play
