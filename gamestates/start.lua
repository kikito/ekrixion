local Start = {}

function Start:draw()
  love.graphics.print("Tough guy", 100,100)
  love.graphics.print("Press any key to start, esc to exit", 100, 150)
end

function Start:keypressed(key, isrepeat)
  if key == 'escape' then
    love.event.quit()
  else
    self:gotoState('Play')
  end
end

return Start
