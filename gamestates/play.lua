local Map = require 'Map'

local Play = {}

function Play:enteredState()
  self.map = Map:new()
end

function Play:keypressed(key, isrepeat)
  if key == 'escape' then
    self:gotoState('Start')
  end
end

function Play:exitedState()
  self.map = nil
end

function Play:update(dt)
  self.map:update(dt)
end

function Play:draw()
  self.map:draw()
end

return Play
