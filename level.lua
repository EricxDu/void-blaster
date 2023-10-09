--[[
    This iterator steps through a queue to return spawns.
--]]
local function queue(tab)
  local n = 1
  return function (time)
    if tab[n] and tab[n].timer < time then
      n = n + 1
      return tab[n - 1]
    end
  end
end

local Level = {
  queue0 = {}
}

function Level:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

local level1 = {
  {5, 11, 17, 23, 29, 35, 41, 47, 53, 59}
}

local level0 = {
  {timer = 5, height = 40, dx = -32},
  {timer = 11, height = 72, dx = -32},
  {timer = 17, height = 104, dx = -32}
}

function Level:next()
  return queue(level0)
end

return Level
