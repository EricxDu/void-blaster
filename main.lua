Bullet = require'bullet'
Joystick = require'joystick'
Level = require'level'
Ship = require'ship'

global_start = lutro.timer.getTime()

iPage = lutro.graphics.newImage("page00.png")
qBomb = lutro.graphics.newQuad(64, 488, 8, 8, 1024, 768)
qBullet1 = lutro.graphics.newQuad(96, 464, 8, 8, 1024, 768)
qBullet2 = lutro.graphics.newQuad(296, 432, 8, 8, 1024, 768)
qBullet3 = lutro.graphics.newQuad(96, 520, 8, 8, 1024, 768)
qFlame = lutro.graphics.newQuad(64, 456, 8, 16, 1024, 768)
qLevel = lutro.graphics.newQuad(0, 224, 256, 160, 1024, 768)
qPanel = lutro.graphics.newQuad(0, 192, 256, 32, 1024, 768)
qEnemy1 = lutro.graphics.newQuad(320, 424, 24, 16, 1024, 768)
qDeath1 = lutro.graphics.newQuad(352, 496, 16, 16, 1024, 768)
qDeath2 = lutro.graphics.newQuad(368, 496, 16, 16, 1024, 768)
qGun1 = lutro.graphics.newQuad(176, 552, 16, 8, 1024, 768)
qGun2 = lutro.graphics.newQuad(336, 552, 16, 8, 1024, 768)
qGun3 = lutro.graphics.newQuad(464, 552, 16, 8, 1024, 768)
qTank = lutro.graphics.newQuad(256, 568, 16, 8, 1024, 768)
qRocket = lutro.graphics.newQuad(944, 440, 16, 8, 1024, 768)

player0 = Ship:new{
  lutro.graphics.newImage("page00.png"),
  lutro.graphics.newQuad(72, 448, 24, 32, 1024, 768),
  x = 100,
  y = 100
}

bullets0 = {
  Bullet:new{iPage, qBullet1, x = 256, y = 256, dx = 150},
  Bullet:new{iPage, qBullet1, x = 256, y = 256, dx = 150},
  Bullet:new{iPage, qBullet1, x = 256, y = 256, dx = 150},
  Bullet:new{iPage, qBullet1, x = 256, y = 256, dx = 150},
  Bullet:new{iPage, qBullet1, x = 256, y = 256, dx = 150},
  Bullet:new{iPage, qBomb, x = 256, y = 256, dy = 100},
  Bullet:new{iPage, qBomb, x = 256, y = 256, dy = 100},
  Bullet:new{iPage, qBomb, x = 256, y = 256, dy = 100},
  Bullet:new{iPage, qBomb, x = 256, y = 256, dy = 100},
  Bullet:new{iPage, qBomb, x = 256, y = 256, dy = 100},
}

function lutro.load()
  levelmap = Level:new{5, 11, 17, 23, 29, 35, 41, 47, 53, 59}
  global_start = lutro.timer.getTime()
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
  player0:move(dt, 4, 36, 228, 156)
  player0[3] = player0.x
  player0[4] = player0.y
  player0:decel(dt)
  for i, obj in ipairs(bullets0) do
    obj:move(dt)
    obj[3] = obj.x
    obj[4] = obj.y
  end
  offset = math.floor(lutro.timer.getTime() * 50 - global_start) % 512
  qLevel:setViewport(offset, 32, 256, 160)
  local spawn = Level:next_spawn(lutro.timer.getTime() - global_start)
  if spawn then
    print(spawn)
  end
end

function lutro.draw()
  lutro.graphics.translate(32, 24)
  lutro.graphics.draw(iPage, qPanel, 0, 0)
  lutro.graphics.draw(iPage, qLevel, 0, 32)
  lutro.graphics.draw(unpack(player0))
  for i, obj in ipairs(bullets0) do
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
