local class = require 'lib.middleclass'

local CrazyBrain = class('Crazy')

function CrazyBrain:initialize(body)
  self.angle = 0
  self.body = body
end

function CrazyBrain:update(dt)
  self.angle = self.angle + 0.5 * dt

  local body = self.body
  body.desiredAngle = self.angle
  body.wantsToAttack = true
end

return CrazyBrain
