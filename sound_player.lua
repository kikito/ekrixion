local media = require 'media'
local class = require 'lib.middleclass'

local SoundPlayer = class 'SoundPlayer'

function SoundPlayer:initialize(x,y)
  self.x, self.y = x,y
  self.sources = {}
end

function SoundPlayer:setPosition(x,y)
  self.x, self.y = x,y
end

function SoundPlayer:update()
  local x,y = self.x, self.y
  for source in pairs(self.sources) do
    if source:isStopped() then
      self.sources[source] = nil
    else
      source:setPosition(x,y)
    end
  end
end

function SoundPlayer:play(soundName)
  local x,y = self.x, self.y
  local source = media.sfx[soundName]:play()

  source:setAttenuationDistances(20, 600)
  source:setPosition(x,y,0)

  self.sources[source] = true
  return source
end

return SoundPlayer
