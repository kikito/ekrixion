local class = require 'lib.middleclass'

local PlayerBrain = class('Player')

function PlayerBrain:initialize(camera)
  self.camera = camera
  self.weaponName = 'uzi'
end

function PlayerBrain:setPosition(x,y)
  self.x, self.y = x,y
end

function PlayerBrain:getDesiredAngle()
  local tx, ty = self.camera:toWorld(love.mouse.getPosition())

  return  math.atan2(ty-self.y, tx-self.x)
end

function PlayerBrain:getDesiredMovementVector()
  local dx, dy = 0, 0
  if love.keyboard.isDown('d') then
    dx = 1
  elseif love.keyboard.isDown('a') or love.keyboard.isDown('q') then
    dx = -1
  end
  if love.keyboard.isDown('s') then
    dy = 1
  elseif love.keyboard.isDown('w') or love.keyboard.isDown('z') then
    dy = -1
  end
  return dx, dy
end

function PlayerBrain:getDesiredWeaponName()
  return self.weaponName
end

function PlayerBrain:wantsToAttack()
  return love.mouse.isDown('l')
end

local WEAPONS = {'handgun', 'uzi', 'shotgun', 'bazooka'}
function PlayerBrain:keyPressed(key)
  self.weaponName = WEAPONS[tonumber(key)] or self.weaponName
end

return PlayerBrain
