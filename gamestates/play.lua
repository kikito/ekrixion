local Play = {}

function Play:enteredState()
  print('Hello')
end

function Play:keypressed(key, isrepeat)
  if key == 'escape' then
    self:gotoState('Start')
  end
end

return Play
