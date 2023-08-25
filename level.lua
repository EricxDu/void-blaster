local enemy0 = {height = 40, timer = 320, dx = -64}
local enemy1 = {height = 72, timer = 384, dx = -64}
local enemy2 = {height = 104, timer = 448, dx = -64}

local Level = {
  queue0 = {}
}

function Level:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Level:level0()
  return {
    {timer = 5, height = 40, dx = -32},
    {timer = 11, height = 72, dx = -32},
    {timer = 17, height = 104, dx = -32}
  }
end

function Level:level1()
  return {5, 11, 17, 23, 29, 35, 41, 47, 53, 59}
end

function Level:spawn(time)
  if self.queue0[1] and self.queue0[1].timer < time then
    return table.remove(self.queue0, 1)
  end
end

function Level:next()
  print("nextlevel")
  self.queue0 = self.level0()
end

return Level
