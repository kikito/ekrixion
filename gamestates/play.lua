local gamera = require 'lib.gamera'
local Map = require 'Map'

local Play = {}

function Play:enteredState()
  self.map = Map:new()
  self.camera = gamera.new(0,0, self.map:getDimensions())
end

function Play:keypressed(key, isrepeat)
  if     key == 'escape' then self:gotoState('Start')
  elseif key == '1'      then self.map:setWeapon('handgun')
  elseif key == '2'      then self.map:setWeapon('uzi')
  elseif key == '3'      then self.map:setWeapon('shotgun')
  elseif key == '4'      then self.map:setWeapon('bazooka')
  end
end

function Play:exitedState()
  self.map = nil
end

function Play:update(dt)
  self.map:update(dt, self.camera:getVisible())
  self.camera:setPosition(self.map:getPlayerPosition())
end

function Play:draw()
  local drawDebug = false
  self.camera:draw(function(l,t,w,h)
    self.map:draw(drawDebug, l,t,w,h)
  end)
end

return Play
