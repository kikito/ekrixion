local class = require 'lib.middleclass'
local cron = require 'lib.cron'

local Bullet = require 'entities.bullet'

local Uzi = class('Uzi')

local shootCoolDown = 0.1         -- secons

local function shootCoolDownFinished(self)
  self.canFire = true
end

function Uzi:initialize(world)
  self.world = world
  self.canFire = true
  self.spread = 0.2 -- radians
end

function Uzi:update(dt)
  if self.cooldown and self.cooldown:update(dt) then
    self.cooldown = nil
  end
end

function Uzi:shoot(x,y,angle)
  if self.canFire then
    angle = angle + self.spread * (math.random() - 0.5)
    Bullet:new(self.world, x, y, angle)
    self.canFire = false
    self.cooldown = cron.after(shootCoolDown, shootCoolDownFinished, self)
  end
end

return Uzi
