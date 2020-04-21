-- chump
-- polyrhythmic delay

tempo = 80
drawCircle = false
rec = 0
pre = 1
play = 0


voice = 1
pos = 1 -- start position
scrubRate = .25 -- scrub rate
dt = 1/10 -- grain interval
inc = scrubRate * dt


function grain_func()
  print('grain func')
  softcut.position(voice, pos)
  pos = pos + inc
end

function init()
  --grain scrubbing metro
  m = metro.init()
  m.time = dt
  m.event = grain_func

  --master bpm
  --t = metro.init()
  --t.time = 60/tempo
  --t.event = count
  --t:start()
  
  softcut.buffer_clear()
  softcut.enable(1,1)
  softcut.buffer(1,1)
  softcut.level(1,1.0)
  softcut.loop(1,1)
  softcut.loop_start(1,1)
  softcut.loop_end(1,2)
  softcut.position(1,1)
  
  -- set input rec level: input channel, voice, level
  softcut.level_input_cut(1,1,1.0)
  softcut.level_input_cut(2,1,1.0)
  -- set voice 1 record level 
  softcut.rec_level(1,rec)
  -- set voice 1 pre level
  softcut.pre_level(1,pre)
  -- set record state of voice 1 to 1
  softcut.rec(1,1)

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
  screen.text('  scrub rate: ')
  screen.text(scrubRate)
  if drawCircle then
    screen.move(20, 20)
    screen.text('hello world')
  end
  if rec == 1 then
    screen.move(0,40)
    screen.text('recording')
  end
  if play == 1 then
    screen.move(0,60)
    screen.text('playing')
  end
  screen.update()
end

function enc(n, z)
  if n == 2 then
    tempo = util.clamp(tempo + z, 20, 200)
    --t.time = 60/tempo
  elseif n==3 then
    scrubRate= util.clamp(scrubRate + z*.01,.1, 1)
    inc = scrubRate * dt
  end
  redraw()
end

function key(n, z)
  if n == 3 and z==1 then
    --m:start()
    if play==0 then play = 1 else play = 0 end
    softcut.play (1,play)
  elseif n==2 and z==1 then
    if rec==0 then rec = 1 else rec = 0 end
    softcut.rec_level(1,rec)
  end
  redraw()
end