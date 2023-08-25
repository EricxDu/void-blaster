local Joystick = {
  cd = false,
  cl = false,
  sl = false,
  sr = false,
  du = false,
  dd = false,
  dl = false,
  dr = false,
  cr = false,
  cu = false
}

function Joystick.fire1()
--[[ Override to get triggers --]]
end

function Joystick.fire2()
--[[ Override to get triggers --]]
end

function lutro.joystickpressed(n, b)
  if b == 0 then
    Joystick.cd = true
    Joystick.fire1()
  elseif b == 1 then
    Joystick.cl = true
    Joystick.fire2()
  elseif b == 4 then
    Joystick.du = true
  elseif b == 5 then
    Joystick.dd = true
  elseif b == 6 then
    Joystick.dl = true
  elseif b == 7 then
    Joystick.dr = true
  elseif b == 8 then
    Joystick.cr = true
    Joystick.fire1()
  elseif b == 9 then
    Joystick.cu = true
    Joystick.fire2()
  end
end

function lutro.joystickreleased(n, b)
  if b == 0 then
    Joystick.cd = false
  elseif b == 4 then
    Joystick.du = false
  elseif b == 5 then
    Joystick.dd = false
  elseif b == 6 then
    Joystick.dl = false
  elseif b == 7 then
    Joystick.dr = false
  elseif b == 8 then
    Joystick.cr = false
  elseif b == 9 then
    Joystick.cu = false
  end
end

return Joystick
