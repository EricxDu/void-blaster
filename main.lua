Weapon = require'weapon'
Enemy0 = require'enemy0'
Joystick = require'joystick'
Level = require'level'
Blaster = require'blaster'

global_progress = 0

global_drawable0 = lutro.graphics.newImage("page00.png")
qBomb0 = lutro.graphics.newQuad(64, 488, 8, 8, 1024, 768)
qGun0 = lutro.graphics.newQuad(96, 464, 8, 8, 1024, 768)
qBullet2 = lutro.graphics.newQuad(296, 432, 8, 8, 1024, 768)
qBullet3 = lutro.graphics.newQuad(96, 520, 8, 8, 1024, 768)
qFlame = lutro.graphics.newQuad(64, 456, 8, 16, 1024, 768)
qLevel = lutro.graphics.newQuad(0, 224, 256, 160, 1024, 768)
qPanel = lutro.graphics.newQuad(0, 0, 256, 32, 1024, 768)
qEnemy1 = lutro.graphics.newQuad(320, 424, 24, 16, 1024, 768)
qDeath1 = lutro.graphics.newQuad(352, 496, 16, 16, 1024, 768)
qDeath2 = lutro.graphics.newQuad(368, 496, 16, 16, 1024, 768)
qTurret1 = lutro.graphics.newQuad(176, 552, 16, 8, 1024, 768)
qTurret2 = lutro.graphics.newQuad(336, 552, 16, 8, 1024, 768)
qTurret3 = lutro.graphics.newQuad(464, 552, 16, 8, 1024, 768)
qTruck0 = lutro.graphics.newQuad(256, 568, 16, 8, 1024, 768)
qRocket0 = lutro.graphics.newQuad(944, 440, 16, 8, 1024, 768)

player0 = Blaster:new{
  lutro.graphics.newImage("page00.png"),
  lutro.graphics.newQuad(72, 448, 24, 32, 1024, 768),
  0, 0, 0, 1, 1, 0,
  x = 100,
  y = 100
}

bullets0 = {
  Weapon:new{global_drawable0, qGun0, x = 256, y = 256, dx = 150},
  Weapon:new{global_drawable0, qGun0, x = 256, y = 256, dx = 150},
  Weapon:new{global_drawable0, qGun0, x = 256, y = 256, dx = 150},
  Weapon:new{global_drawable0, qGun0, x = 256, y = 256, dx = 150},
  Weapon:new{global_drawable0, qGun0, x = 256, y = 256, dx = 150},
  Weapon:new{global_drawable0, qBomb0, x = 256, y = 256, dy = 100},
  Weapon:new{global_drawable0, qBomb0, x = 256, y = 256, dy = 100},
  Weapon:new{global_drawable0, qBomb0, x = 256, y = 256, dy = 100},
  Weapon:new{global_drawable0, qBomb0, x = 256, y = 256, dy = 100},
  Weapon:new{global_drawable0, qBomb0, x = 256, y = 256, dy = 100},
}

global_enemies0 = {}

function lutro.load()
  global_enemies0 = {}
  global_level = Level:new()
  global_queue = global_level:next()
  global_progress = 0
end

function lutro.update(dt)
  if Joystick.du then
    player0:accel(0, -dt)
  elseif Joystick.dd then
    player0:accel(0, dt)
  end
  if Joystick.dl then
    player0:accel(-dt, 0)
  elseif Joystick.dr then
    player0:accel(dt, 0)
  end
  if math.floor(lutro.timer.getTime() * 100 % 2) == 0 then
    player0[2]:setViewport(64, 448, 32, 32)
    player0[8] = 0
  else
    player0[2]:setViewport(72, 448, 24, 32)
    player0[8] = 8
  end
  player0:move(dt)
  player0[3] = player0.x
  player0[4] = player0.y
  player0:decel(dt)
  for i, obj in ipairs(bullets0) do
    obj:move(dt)
    obj[3] = obj.x
    obj[4] = obj.y
  end
  for i, obj in ipairs(global_enemies0) do
    obj:move(dt)
    obj[3] = obj.x
    obj[4] = obj.y
  end
  offset = math.floor(global_progress * 50) % 512
  qLevel:setViewport(offset, 32, 256, 160)
  local spawn = global_queue(global_progress)
  if spawn then
    local enemy = Enemy0:new{
      global_drawable0,
      qEnemy1,
      x = 255,
      y = spawn.height,
      dx = spawn.dx,
      dy = spawn.dy
    }
    table.insert(global_enemies0, enemy)
  end
  global_progress = global_progress + dt
end

function lutro.draw()
  lutro.graphics.translate(32, 24)
  lutro.graphics.draw(global_drawable0, qPanel, 0, 0)
  lutro.graphics.draw(global_drawable0, qLevel, 0, 32)
  lutro.graphics.draw(unpack(player0))
  for i, obj in ipairs(bullets0) do
    lutro.graphics.draw(unpack(obj))
  end
  for i, obj in ipairs(global_enemies0) do
    lutro.graphics.draw(unpack(obj))
  end
end

function Joystick.fire1()
  for i = 1, 3, 1 do
    local obj = bullets0[i]
    if obj:ready() then
      obj.x = player0.x + 24
      obj.y = player0.y + 16
      break
    end
  end
end

function Joystick.fire2()
  for i = 6, 7, 1 do
    local obj = bullets0[i]
    if obj:ready() then
      obj.x = player0.x + 8
      obj.y = player0.y + 24
      break
    end
  end
end
