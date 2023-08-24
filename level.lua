local Level = {
}

function Level:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Level:next_spawn(time)
  if self[1] and self[1] < time then
    enemy = self[1]
    table.remove(self, 1)
  end
end

function Level:next_level()
end

return Level
