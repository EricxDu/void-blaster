--[[
Enemy0 is a physics object representing a destructible adversary.
--]]
local LEFT = -24
local TOP = 0
local RIGHT = 256
local BOTTOM = 192

local Enemy0 = {
  x = 0,
  y = 0,
  dx = 0,
  dy = 0
}

function Enemy0:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Enemy0:move(dt)
  if self.x > LEFT and self.x < RIGHT then
    self.x = self.x + self.dx * dt
  end
  if self.y > TOP and self.y < BOTTOM then
    self.y = self.y + self.dy * dt
  end
end

return Enemy0
