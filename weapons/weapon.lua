local class = require 'lib.middleclass'
local cron  = require 'lib.cron'

local media = require 'media'

local Bullet = require 'entities.projectiles.bullet'

local Weapon = class('Weapon')

local function coolDownFinished(self)
  self.canFire = true
end

function Weapon:initialize(world, camera, opts)
  self.canFire = true
  self.world = world
  self.camera = camera

  self.spread          = opts.spread   or 0.1 -- radians
  self.coolDown        = opts.coolDown or 0.1 -- seconds
  self.bulletsPerShot  = opts.bulletsPerShot or 1
  self.projectileClass = opts.projectileClass or Bullet
  self.soundName       = opts.soundName
end

function Weapon:update(dt)
  if self.clock and self.clock:update(dt) then
    self.clock = nil
  end
end

function Weapon:attack(x,y,angle)
  if self.canFire then
    media.sfx[self.soundName]:play()

    for i=1, self.bulletsPerShot do
      local a = angle + self.spread * (math.random() - 0.5)
      self.projectileClass:new(self.world, self.camera, x, y, a)
    end

    self.canFire = false
    self.clock = cron.after(self.coolDown, coolDownFinished, self)

    return true
  end
end

return Weapon
