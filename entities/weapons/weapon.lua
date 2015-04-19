local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local Entity = require 'entities.entity'

local Weapon = class('Weapon', Entity)

local function coolDownFinished(self)
  self.canFire = true
end

local SIZE = 4

function Weapon:initialize(world, x, y, angle, options)
  Entity.initialize(self, world, x-SIZE/2, x-SIZE/2, SIZE, SIZE)
  self.angle = angle
  self.canFire = true
  self.options = options
end

function Weapon:update(dt)
  if self.clock and self.clock:update(dt) then
    self.clock = nil
  end
end

function Weapon:setCoords(x,y,angle)
  self.x, self.y, self.angle = x-SIZE/2, y-SIZE/2, angle
  self.world:update(self, self.x, self.y)
end

function Weapon:attack()
  if self.canFire then
    local opts = self.options

    self:playSFX(opts.soundName)

    local x,y = self:getCenter()
    local angle = self.angle
    local projectileClass, spread = opts.projectileClass, opts.spread

    for i=1, opts.bulletsPerShot do
      local a = angle + spread * (math.random() - 0.5)
      projectileClass:new(self.world, x, y, a)
    end

    self.canFire = false
    self.clock = cron.after(opts.coolDown, coolDownFinished, self)

    return true
  end
end

function Weapon:drawHold()
  love.graphics.setColor(255,0,255)
  love.graphics.circle('line', self.x+SIZE/2, self.y+SIZE/2, SIZE)
end

return Weapon
