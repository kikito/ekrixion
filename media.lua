local media = {}

local function newSource(name)
  local path = 'sfx/' .. name .. '.ogg'
  local source = love.audio.newSource(path)
  return multisource.new(source)
end

media.load = function()
  local names = [[
  ]]

  media.sfx = {}
  for name in names:gmatch('%S+') do
    media.sfx[name] = newSource(name)
  end

  --media.music = love.audio.newSource('sfx/wrath_of_the_djinn.xm')
  --media.music:setLooping(true)
end

media.cleanup = function()
  for _,sfx in pairs(media.sfx) do
    sfx:cleanup()
  end
end

media.countInstances = function()
  local count = 0
  for _,sfx in pairs(media.sfx) do
    count = count + sfx:countInstances()
  end
  return count
end

return media
