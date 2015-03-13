local class = require 'lib.middleclass'

local CrazyBrain = class('Crazy')

function CrazyBrain:initialize()
  self.weaponName = 'uzi'
  self.angle = 0
end

function CrazyBrain:update(dt)
  self.angle = self.angle + 0.5 * dt
end

function CrazyBrain:setPosition(x,y)
  self.x, self.y = x,y
end

function CrazyBrain:getDesiredAngle()
  return self.angle
end

function CrazyBrain:getDesiredMovementVector()
  return 0,0
end

function CrazyBrain:getDesiredWeaponName()
  return self.weaponName
end

function CrazyBrain:wantsToAttack()
  return true
end

return CrazyBrain
