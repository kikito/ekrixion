local class = require 'lib.middleclass'

local PlayerBrain = class('Player')

function PlayerBrain:initialize(camera, body)
  self.camera = camera
  self.weaponName = 'uzi'
  self.body = body
end

function PlayerBrain:update(dt)
  local body = self.body

  body:setWeapon(self.weaponName)

  body.desiredAngle = self:getDesiredAngle()
  body.desiredMovementVector.x,
  body.desiredMovementVector.y = self:getDesiredMovementVector()

  body.wantsToAttack = self:wantsToAttack()
end

function PlayerBrain:getDesiredAngle()
  local tx, ty = self.camera:toWorld(love.mouse.getPosition())
  local x,y = self.body:getCenter()

  return  math.atan2(ty-y, tx-x)
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

function PlayerBrain:wantsToAttack()
  return love.mouse.isDown('l')
end

local WEAPONS = {'handgun', 'uzi', 'shotgun', 'bazooka'}
function PlayerBrain:keyPressed(key)
  self.weaponName = WEAPONS[tonumber(key)] or self.weaponName
end

return PlayerBrain
