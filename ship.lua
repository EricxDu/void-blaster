--[[
Ship is a physics object representing the player's shooting starship.
--]]
local Ship = {
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  speed = 500,
  max_speed = 100
}

function Ship:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Ship:accel(dx, dy)
  if math.abs(self.dx) < self.max_speed then
    self.dx = self.dx + dx * self.speed
  end
  if math.abs(self.dy) < self.max_speed then
    self.dy = self.dy + dy * self.speed
  end
end

function Ship:decel(dt)
  self.dx = self.dx * 0.90
  self.dy = self.dy * 0.90
end

function Ship:move(dt, left, top, right, bottom)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
  if self.x < left then
    self.x = left
    self.dx = 0
  elseif self.x > right then
    self.x = right
    self.dx = 0
  end
  if self.y < top then
    self.y = top
    self.dy = 0
  elseif self.y > bottom then
    self.y = bottom
    self.dy = 0
  end
end

return Ship
