-- chump
-- polyrhythmic delay

tempo = 80
drawCircle = false

function init()
  r = metro.init()
  r.time = 60/tempo
  r.event = count
  r:start()
  redraw()
end

function count()
  drawCircle = not drawCircle
  redraw()
end

function redraw()
  screen.clear()
  screen.level(15)
  screen.move(0, 5)
  screen.text('bpm: ')
  screen.text(tempo)
  if drawCircle then
    screen.move(20, 20)
    screen.text('hello world')
  end
  screen.update()
end

function enc(n, z)
  if n == 2 then
    tempo = util.clamp(tempo + z, 20, 200)
    r.time = 60/tempo
  end
  redraw()
end
