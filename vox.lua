-- scriptname: vox ex machina
-- v1.0.0 @graem
-- https://github.com/
-- graemen/vox

engine.name = 'VoxExMachina'

local voice = 5
local voice_names = {"awb","bdl","clb","jmk","rms","slt"}

-- modes are -1, 0, 1, 2
local mode = 1
local freq_modes = {"off", "rep", "add", "mul"}

local mute = 1
local edit = 0

local phrase = 0 
local freq = 200
local freq_max = 20000
local scale = 1.0
local scale_max = 60.0
local gap = 2.0
local gap_max = 60.0
local alpha = 0.55
local alpha_max = 1.0

local vox_min = 0.01

local params = paramset.new()

-- discrete params
local cs_voice  = controlspec.new(0,  5, 'lin', 1, 0, "")
local cs_mode   = controlspec.new(-1, 2, 'lin', 1, 0, "")
local cs_phrase = controlspec.new(0,  15,'lin', 1, 0, "")
local cs_mute   = controlspec.new(0,  1,'lin', 1, 0, "")

-- continuous params - minimums are tested minimums 
local cs_freq   = controlspec.new(1,       freq_max,  'exp', 1,       200, "")
local cs_alpha  = controlspec.new(vox_min, alpha_max, 'lin', vox_min, 0.55, "")
local cs_scale  = controlspec.new(vox_min, scale_max, 'lin', vox_min, 1.0, "")
local cs_gap    = controlspec.new(vox_min, gap_max,   'lin', vox_min, 2.00, "")

-- edit control
local cs_netvoltage = controlspec.new(vox_min, 65535, 'lin', 1, 0, "")

local rx_osc = 0;

function set_mute(cs,x)
  if mute == 1 then 
    mute = 0 
  else
    mute = 1
  end;
  -- set audio levels to 1 or 0
  audio.level_dac(mute)
end

function set_voice(cs, x)
  engine.voice(cs:map(x))
  voice = cs:map(x)
end

function set_mode(cs, x)
  engine.mode(cs:map(x))
  mode = cs:map(x)
end

function set_phrase(cs, x)
  phrase = cs:map(x)
	if phrase == 0 then engine.zero(cs:map(x)) end
	if phrase == 1 then engine.one(cs:map(x)) end
	if phrase == 2 then engine.two(cs:map(x)) end
	if phrase == 3 then engine.three(cs:map(x)) end
	if phrase == 4 then engine.four(cs:map(x)) end
	if phrase == 5 then engine.five(cs:map(x)) end
	if phrase == 6 then engine.six(cs:map(x)) end
	if phrase == 7 then engine.seven(cs:map(x)) end
	if phrase == 8 then engine.eight(cs:map(x)) end
	if phrase == 9 then engine.nine(cs:map(x)) end
	if phrase == 10 then engine.aay(cs:map(x)) end
	if phrase == 11 then engine.bee(cs:map(x)) end
  if phrase == 12 then engine.see(cs:map(x)) end
  if phrase == 13 then engine.dee(cs:map(x)) end
  if phrase == 14 then engine.eee(cs:map(x)) end
  if phrase == 15 then engine.eff(cs:map(x)) end
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

function set_gap(cs, x)
	engine.gap(cs:map(x))
	gap = cs:map(x)
end

function set_edit(x)
  edit = edit + 1
	  if edit == 8 then
	      edit = 0
	  end
end

-- input one for gap, scale, alpha
function process_cv_stream(v)
	
  -- Input voltage 0 - 5    Pamela's Pro Workout
  -- Input voltage 0 - 10   Poly2 Gate and Pitch
  -- Input voltage 0 - 12   Poly2 CV  
	local volt = v/10.0 
	
  -- cv is applied to the selected
  if edit == 5 then
    set_scale(cs_scale, volt)
  elseif edit == 6 then
    set_alpha(cs_alpha, volt)
  elseif edit == 7 then
    set_gap(cs_gap, volt)
  else
   do end
  end  
  
  redraw()
end

-- input two stepped random for phrase, voice or freq cv control
function process_trigger_stream(v)
 	
  -- Input voltage 0 - 5    Pamela's Pro Workout
  -- Input voltage 0 - 10   Poly2 Gate and Pitch
  -- Input voltage 0 - 12   Poly2 CV  
  local volt = v/5.0 
  
    if edit == 1  then
      set_voice(cs_voice, volt)
    elseif edit == 2 then 
      set_phrase(cs_phrase, volt)
    elseif edit == 3 then 
      set_mode(cs_mode, volt)
    elseif edit == 4 then
      set_freq(cs_freq, volt)
    else
	    do end
    end

  redraw()
end



function init()
  -- font and size
  screen.font_face(0)
  screen.font_size(8)
  screen.aa(0)
  screen.line_width(1)

    -- reduce encoder 3 sensitivity
  norns.enc.sens(3, 3) 

  params:add_separator("Vox Ex Macina")
  
    -- map our supercollider controls to norns parameters
  --params:add_control("mute", cs_mute)
  --params:set_action("mute", function(x) set_mute(cs_mute, x) end)
  params:add {
    type = 'control',
    id = 'mute',
    name = 'mute',
    controlspec = cs_mute,
    action = function(x) set_mute(cs_mute, x) end
    }

  --params:add_control("voice", cs_voice)
  --params:set_action("voice", function(x) set_voice(cs_voice, x) end)
  params:add {
    type = 'control',
    id = 'voice',
    name = 'voice',
    controlspec = cs_voice,
    action = function(x) set_mute(cs_voice, x) end
    }

  --params:add_control("phrase", cs_phrase)
  --params:set_action("phrase", function(x) set_phrase(cs_phrase, x) end)
  params:add {
    type = 'control',
    id = 'phrase',
    name = 'phrase',
    controlspec = cs_phrase,
    action = function(x) set_phrase(cs_phrase, x) end
    }

  --params:add_control("freq", cs_freq)
  --params:set_action("freq", function(x) set_freq(cs_freq, x) end)
  params:add {
    type = 'control',
    id = 'freq',
    name = 'freq',
    controlspec = cs_freq,
    action = function(x) set_freq(cs_freq, x) end
    }

  --params:add_control("mode", cs_mode)
  --params:set_action("mode", function(x) set_mode(cs_mode, x) end)
params:add {
    type = 'control',
    id = 'mode',
    name = 'mode',
    controlspec = cs_mode,
    action = function(x) set_mode(cs_mode, x) end
    }

  --params:add_control("scale", cs_scale
  --params:set_action("scale", function(x) set_scale(cs_scale, x) end)
  params:add {
    type = 'control',
    id = 'scale',
    name = 'scale',
    controlspec = cs_scale,
    action = function(x) set_scale(cs_scale, x) end
    }

  --params:add_control("alpha", cs_alpha)
  --params:set_action("alpha", function(x) set_alpha(cs_alpha, x) end)
params:add {
    type = 'control',
    id = 'alpha',
    name = 'alpha',
    controlspec = cs_alpha,
    action = function(x) set_alpha(cs_alpha, x) end
    }

  --params:add_control("gap", cs_gap)
  --params:set_action("gap", function(x) set_gap(cs_gap, x) end)
	params:add {
    type = 'control',
    id = 'gap',
    name = 'gap',
    controlspec = cs_gap,
    action = function(x) set_gap(cs_gap, x) end
    }
  -- two crow inputs for cv of parameters
	
  -- input 1 is for clock
  --crow.input[1].mode("stream", 0.5)
  --crow.input[1].stream = process_trigger_stream
  
	-- input 2 is for cv 
  --crow.input[2].mode("stream", 0.1)
  --crow.input[2].stream = process_cv_stream
  
end


function key(n,z)
  -- key actions: n = button, z = state

  -- K3 parameter edit
  if n == 3 and z == 1 then 
    
     -- mute on/off
    if edit == 0 then
      if mute == 1 then 
        mute = 0 
      else 
        mute = 1
      end
      -- set audio levels to 1 or 0
      audio.level_dac(mute)
    end

    -- voice selection
    if edit == 1 then
      voice = voice + 1
      if voice > 5 then voice = 0 end    
      engine.voice(voice)
    end
    
    -- mode selection
    if edit == 3 then
      mode = mode + 1
      if mode > 2 then mode = -1 end
      engine.mode(mode)
    end
   
   -- freq selection
    if edit == 4 then
      freq = freq + 1
      if freq > freq_max then freq = 1 end 
      engine.freq(freq)
    end
    
    -- scale selection
    if edit == 5 then
      scale = scale + 0.1
      if scale > scale_max then scale = voxmin end 
      engine.scale(scale)
    end

  -- alpha selection
    if edit == 6 then
      alpha = alpha + 0.01
      if alpha > alpha_max then alpha = vox_min end 
      engine.alpha(alpha)
    end
    
    -- gap selection
    if edit == 7 then
      gap = gap + 1
      if gap > gap_max then gap = vox_min end 
      engine.gap(gap)
    end

   redraw()  
  end
    
end

function enc(n, delta)
  -- encoder actions: n = encoder, d = delta
  
  -- E2 parameter edit
  if n == 3 then
    if edit == 0 then
      params:delta("mute", delta)
    elseif edit == 1 then
      params:delta("voice", delta)
    elseif edit == 2  then
      params:delta("phrase", delta)
    elseif edit == 3 then
      params:delta("mode", delta)
    elseif edit == 4 then
      params:delta("freq", delta)
    elseif edit == 5 then
      params:delta("scale", delta)
    elseif edit == 6 then
      params:delta("alpha", delta)
    elseif edit == 7 then
      params:delta("gap", delta)
    else
      edit = 0 
    end  
  end
  
  -- E3 menu navigation
  if n == 2 then
    set_edit(edit)
  end
   redraw() 
end

-- OSC rx working
--NetVoltage: [ /netvoltage, 1701484416.0, 2, 9001, 45152, 4480, 4428 ]
--HexVoltage: [ /hexvoltage, 3, 0.55 ]
--VoxVoltage  [ /voxvoltage, ["on", "off"] ]

osc.event = function(path, args, from)
  --print("osc from " .. from[1] .. " port " .. from[2])
 
  -- network traffic mapping
  if path == "/netvoltage" then
    -- voice per protocol
    engine.voice(args[2])
    
    -- freq 0-20000 mapped from 1-65535
    set_freq(cs_freq, args[3]/3.3)
    
    -- scale 0-60 mapped from 1-65535
    set_scale(cs_scale, args[4]/10000.0)
    
    -- gap 0-60 mapped to packet_size_diff
    gap = (args[6] - args[5])/100.0 --packet size difference
    set_gap(cs_gap, gap)
    
    print("/netvoltage",args[1],args[2],args[3],args[4],args[5],args[6], gap) 
  
  -- files as hexadecimal  
  elseif path == "/hexvoltage" then
    
    set_phrase(cs_phrase, args[1])
    set_alpha(cs_alpha, args[2])
    set_voice(cs_voice, args[3])
    print("/hexvoltage", args[1]*15)
  
  -- mute control
  elseif path == "/voxvoltage" then
    
    set_mute(args[1])
    print("/voxvoltage", args[1])
  
  else
    print(path)
    tab.print(args)
  end
  
  rx_osc = 1;
  redraw()
end

function redraw()
  
  y1 = 16
  diff = 7
  y2 = y1+diff
  y3 = y2+diff
  y4 = y3+diff
  y5 = y4+diff
  y6 = y5+diff
  y7 = y6+diff
  
  x1 = 8
  x2 = 70
  x3 = 90
  
  indicator = " ~ "
  blank = "   "
  
  screen.aa(1)
  screen.level(15)
  screen.font_size(8)
  screen.clear()
  
  -- main interface
  screen.move(8, 8)
  
 -- mute display   
  if mute == 1 then screen.text("Vox Ex Machina !! ") else screen.text("Vox Ex Machina > ") end
 
 -- menu active indicator
  if edit == 0 then screen.text(indicator) else screen.text(blank) end
 
 -- clock bpm from crow
  screen.text(clock.get_tempo())
  
 -- osc rx display from net/hex/vox voltage
  if rx_osc == 1 then 
    screen.text(" v ")
    rx_osc = 0	
  end
 
  -- controls
  screen.move(x1,y1)
  screen.text("vox: ")
  screen.move(x2, y1)
  screen.text_right(voice_names[voice+1])
  screen.move(x3,y1)
  if edit == 1 then screen.text(indicator) else screen.text(blank) end
    
  screen.move(x1,y2)
  screen.text("hex: " )
  screen.move(x2, y2)
  screen.text_right(string.format("%d", phrase))
  screen.move(x3, y2)
  if edit == 2 then screen.text(indicator) else screen.text(blank) end
  
  screen.move(x1,y3)
  screen.text("sin: ")
  screen.move(x2,y3)
  screen.text_right(freq_modes[mode+2])
  screen.move(x3, y3)
  if edit == 3 then screen.text(indicator) else screen.text(blank) end
  
  screen.move(x1,y4)
  screen.text("frq: ")
  screen.move(x2,y4)
  screen.text_right(string.format("%d", freq))
  screen.move(x3, y4)
  if edit == 4 then screen.text(indicator) else screen.text(blank) end
 
  screen.move(x1,y5)
  screen.text("tim: ")
  screen.move(x2, y5)
  screen.text_right(string.format("%.2f", scale)) 
  screen.move(x3, y5)
  if edit == 5 then screen.text(indicator) else screen.text(blank) end
 
  screen.move(x1,y6)
  screen.text("shp: ")
  screen.move(x2, y6)
  screen.text_right(string.format("%.2f", alpha))
  screen.move(x3, y6)
  if edit == 6 then screen.text(indicator)  else screen.text(blank) end
  
  screen.move(x1, y7)
  screen.text("win: ")
  screen.move(x2, y7)
  screen.text_right(string.format("%.2f", gap))
  screen.move(x3, y7)
  if edit == 7 then screen.text(indicator) else screen.text(blank) end
   
  screen.update()
end

function cleanup()
  --delete temp label files
  folder = "/home/we/dust/data/vox/"
  util.os_capture("rm "..folder.."mage-*")
end
