local class = require 'lib.middleclass'

local Pawn   = require 'entities.pawn'
local Tile   = require 'entities.tile'
local Target = require 'entities.target'

local PlayerBrain = require 'player_brain'
local CrazyBrain = require 'crazy_brain'

local Shotgun = require 'weapons.shotgun'
local Uzi     = require 'weapons.uzi'
local Handgun = require 'weapons.handgun'
local Bazooka = require 'weapons.bazooka'

local Map = class('Map')

function Map:initialize(world, width, height, camera)
  self.height  = height
  self.width   = width
  self.camera  = camera
  self.world   = world
  self.brains  = {}

  self.playerBody  = Pawn:new(camera, world, 1000, 1000)
  self.playerBrain = PlayerBrain:new(camera, self.playerBody)
  self.brains[self.playerBrain] = true

  self.playerBody:addWeapon('uzi',     Uzi:new(world, camera))
  self.playerBody:addWeapon('shotgun', Shotgun:new(world, camera))
  self.playerBody:addWeapon('bazooka', Bazooka:new(world, camera))
  self.playerBody:addWeapon('handgun', Handgun:new(world, camera))

  for i=1,100 do
    Tile:new(world,
             math.random(100, width - 100),
             math.random(100, height - 100))
  end

  for i=1,40 do
    Target:new(world,
               math.random(100, width - 100),
               math.random(100, height - 100))
  end

  for i=1,3 do
    local body = Pawn:new(camera,
      world,
      math.random(100, width - 100),
      math.random(100, height - 100))
    body:addWeapon('uzi', Uzi:new(world, camera))

    local brain = CrazyBrain:new(body)
    self.brains[brain] = true
  end
end

function Map:update(dt, l,t,w,h)
  local margin = 100
  local visibleThings, len = self.world:queryRect(l-margin,t-margin,w+2*margin,h+2*margin)

  for brain in pairs(self.brains) do
    brain:update(dt)
  end

  for i=1, len do
    visibleThings[i]:update(dt)
    if visibleThings[i] == self.playerBody then
      local x,y = self.playerBody:getCenter()
      love.audio.setPosition(x,y,15) -- random z value so that transitions to left/right are less jarring
    end
  end
end

function Map:draw(drawDebug, l,t,w,h)
  local visibleThings, len = self.world:queryRect(l,t,w,h)

  for i=1, len do
    visibleThings[i]:draw(drawDebug)
  end
end

function Map:getPlayerPosition()
  return self.playerBody:getCenter()
end

function Map:keyPressed(key)
  self.playerBrain:keyPressed(key)
end

return Map
