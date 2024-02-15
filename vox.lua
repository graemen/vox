-- scriptname: vox ex machina
-- v1.0.0 @graem
-- https://github.com/
-- graemen/vox

engine.name = 'VoxExMachina'

-- voice range is 0-5
local voice = 0
local voice_names = {"awb","bdl","clb","jmk","rms","slt"}

local mode = -1
local freq_modes = {"off", "rep", "add", "mul"}

local phrase = 1
local freq = 100
local scale = 1.0
local alpha = 0.55
local vox_params = paramset.new()

local cs_phrase = controlspec.new(1, 10, 'lin', 1 , 1, "")
local cs_freq = controlspec.new(1, 20000, 'exp', 1, 10, "")
local cs_scale = controlspec.new(0.001, 10.0, 'lin', 0.001, 1.0, "")
local cs_alpha = controlspec.new(0.001, 1.0, 'lin', 0.001, 0.55, "")

function set_phrase(cs, x)
	engine.phrase(cs:map(x))
        phrase = cs:map(x)
end

function set_freq(cs, x)
	engine.freq(cs:map(x))
	freq = cs:map(x)
end

function set_scale(cs, x)
	engine.scale(cs:map(x))
	scale = cs:map(x)
end

function set_alpha(cs, x)
	engine.alpha(cs:map(x))
	alpha = cs:map(x)
end

function init()
  -- initialization
  
  -- map our supercollider controls to norns parameters
  vox_params:add_control("phrase", cs_phrase)
  vox_params:set_action("phrase", function(x) set_phrase(cs_phrase, x) end)
  
  vox_params:add_control("freq", cs_freq)
  vox_params:set_action("freq", function(x) set_freq(cs_freq, x) end)

  vox_params:add_control("scale", cs_scale)
  vox_params:set_action("scale", function(x) set_scale(cs_scale, x) end)
  
  vox_params:add_control("alpha", cs_alpha)
  vox_params:set_action("alpha", function(x) set_alpha(cs_alpha, x) end)

end

function key(n,z)
  -- key actions: n = number, z = state
  if n == 2 and z == 1 then
        if voice == 5  then
	   voice = 0
	else
	  voice = voice + 1
	end
	engine.voice(voice)
  elseif n == 3 and z == 1 then
	if mode == 2 then
	 mode = -1
	else
	 mode = mode + 1
	end
	engine.mode(mode)
  end
  redraw()
end

local osc_in = function(path, args, from)
  if path == "/param/scale" then
    vox_params:set_raw("scale",args[1]/600)
  elseif path == "/param/alpha" then
    params:set_raw("alpha",args[1]/600)
  else
    print(path)
    tab.print(args)
  end
end

osc.event = osc_in

function enc(n,delta)
  -- encoder actions: n = number, d = delta
  -- map our encoder changes to parameters
  if n == 1 then
    if mode < 0 then
    	vox_params:delta("phrase", delta)
    else
  	vox_params:delta("freq", delta)
    end
  elseif n == 2 then
    vox_params:delta("scale", delta)
  elseif n == 3 then
    vox_params:delta("alpha", delta)
  end
  redraw()
end

function redraw()
  screen.clear()
  screen.aa(1)
  screen.level(15)
  screen.move(5, 15)
  screen.font_size(16)
  screen.text("Vox Ex Machina")
  -- controls
  screen.font_size(8)  
  screen.move(8,28)
  screen.text("vox: ")
  screen.move(80, 28)
  screen.text_right(voice_names[voice+1])
  
  screen.move(8,36)
  screen.text("wurd: " )
  screen.move(80, 36)
  screen.text_right(string.format("%d", phrase))
  screen.move(100,36)
  if mode >= 0 then
    screen.text_right(freq_modes[1])
  else
    screen.text_right("on")	
  end

  screen.move(8,44)
  screen.text("freq: ")
  screen.move(80,44)
  screen.text_right(string.format("%d", freq))
  screen.move(100,44)
  screen.text_right(freq_modes[mode+2])
 
  screen.move(8,52)
  screen.text("time: ")
  screen.move(80, 52)
  screen.text_right(string.format("%.3f", scale)) 
 
  screen.move(8,60)
  screen.text("shape: ")
  screen.move(80, 60)
  screen.text_right(string.format("%.3f", alpha))

  screen.update()
end

function cleanup()
  --delete temp label files
  folder = "/home/we/dust/data/vox/"
  util.os_capture("rm "..folder.."mage-*")
end
