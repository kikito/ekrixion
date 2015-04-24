local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local SoundPlayer = require 'sound_player'

local Weapon = class('Weapon')

local function coolDownFinished(self)
  self.canFire = true
end

function Weapon:initialize(world, x,y,angle, options)
  self.world        = world
  self.x, self.y    = x,y
  self.angle        = angle
  self.options      = options
  self.soundPlayer  = SoundPlayer:new(x,y)
  self.canFire      = true
end

function Weapon:update(dt)
  if self.clock and self.clock:update(dt) then
    self.clock = nil
  end
end

function Weapon:setCoords(x,y,angle)
  self.x, self.y, self.angle = x,y,angle
  self.soundPlayer:setPosition(x,y)
end

function Weapon:fire()
  if self.canFire then
    local opts = self.options

    self.soundPlayer:play(opts.soundName)

    local x,y = self.x, self.y
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

function Weapon:draw()
  love.graphics.setColor(255,0,255)
  love.graphics.circle('line', self.x, self.y, 6)
end

return Weapon
