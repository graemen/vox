-- scriptname: vox ex machina
-- v1.0.0 @graem
-- https://github.com/
-- graemen/vox

engine.name = 'VoxExMachina'

-- voice range is 0-5
local voice = 5
local voice_names = {"awb","bdl","clb","jmk","rms","slt"}


local mode = 2
local freq_modes = {"off", "rep", "add", "mul"}

local edit = 0
local phrase = 0 
local freq = 200
local scale = 1.0
local alpha = 0.55
local gap = 2.0
local params = paramset.new()


local cs_phrase = controlspec.new(0,    15,    'lin', 1,   0, "")
local cs_freq   = controlspec.new(1,    20000, 'exp', 1,    200, "")
local cs_scale  = controlspec.new(0.01, 10.0,  'lin', 0.01, 1.0, "")
local cs_alpha  = controlspec.new(0.01, 1.0,   'lin', 0.01, 0.55, "")
local cs_gap    = controlspec.new(0.5,  60.00, 'exp', 0.01, 2.00, "")

local rx_osc = 0;

function set_toggle()
  engine.toggle()
end

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

function set_gap(cs, x)
	engine.gap(cs:map(x))
	gap = cs:map(x)
end

-- input one shape/alpha
function process_cv_stream(v)
	
	-- Input voltage range 0..5V Pamela's Pro Workout
  -- Input voltage range for Poly2 Gate 0-10V, Pitch 0-10V, CV 0-12V 
  local min_voltage = 0.0 
  local max_voltage = 10.0
  
  -- Scale and translate the voltage to 0-1 to work as input to control specs
  local volt = v/max_voltage 
	
  -- cv is applied to the one being edited
  -- cv applied to shape only see OSC for other param control 
  --if edit == 3 then
  --  set_gap(cs_gap, volt)
  --elseif edit == 4 then
  --  set_freq(cs_freq, volt)
  --elseif edit == 5 then
  --  set_scale(cs_scale, volt)
  --elseif edit == 6 then
  --  set_alpha(cs_alpha, volt)
  --else
   --do end
  --end  
  
  -- update display
  redraw()
end

-- input two stepped random for phrase selection
function process_phrase_stream(v)
  -- Input voltage range 0..5V Pamela's Pro Workout
    -- Input voltage range for Poly2 Gate 0-10V, Pitch 0-10V, CV 0-12V 
  local min_voltage = 0.0 
  local max_voltage = 10.0
  
  -- Scale and translate the voltage to 0-1 to work as input to control specs
  local volt = v/max_voltage 
  
  -- set the phrase
  set_phrase(cs_phrase, volt)
	
  -- update display
  redraw()
end



function init()
  -- initialization
  
  -- map our supercollider controls to norns parameters
  params:add_control("toggle")
  params:set_action("toggle", function(x) set_toggle() end)
  
  params:add_control("phrase", cs_phrase)
  params:set_action("phrase", function(x) set_phrase(cs_phrase, x) end)
  
  params:add_control("freq", cs_freq)
  params:set_action("freq", function(x) set_freq(cs_freq, x) end)

  params:add_control("scale", cs_scale)
  params:set_action("scale", function(x) set_scale(cs_scale, x) end)
  
  params:add_control("alpha", cs_alpha)
  params:set_action("alpha", function(x) set_alpha(cs_alpha, x) end)

  params:add_control("gap", cs_scale)
  params:set_action("gap", function(x) set_gap(cs_gap, x) end)
	
  -- two crow inputs for cv of parameters
	
  -- stepped random voltage in for random phrase
  --crow.input[1].mode("stream", 0.5)
  --crow.input[1].stream = process_phrase_stream
  
	-- cv for varying the alpha/shape
  --crow.input[2].mode("stream", 0.1)
  --crow.input[2].stream = process_cv_stream
  
  
end


function key(n,z)
-- key actions: n = button, z = state
  if n == 2 and z == 1 then
	  edit = edit + 1
	  if edit == 8 then
	      edit = 0
	  end
  end

  -- when K3 enter is pressed
  if n ==  3 and z == 1 then 

     -- toggle engine on/off
    if edit == 0 then
      engine.toggle()
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
   
  end
  redraw()
end

function enc(n, delta)
  -- encoder actions: n = encoder, d = delta
  -- map our encoder changes to parameters
  if n == 2 then
    if edit == 1 then
      edit = 1
    elseif edit == 2  then
      params:delta("phrase", delta)
    elseif edit == 3 then
      edit = 3
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
  redraw()
end

-- OSC rx working
--NetVoltage: [ /netvoltage, 1701484416.0, 10, 9001, 45152, 4480, 4428 ]
--HexVoltage: [ /hexvoltage, 3, 0.55 ]
--VoxVoltage  [ /voxvoltage, ["on", "off"] ]

osc.event = function(path, args, from)
  --print("osc from " .. from[1] .. " port " .. from[2])
 if path == "/netvoltage" then
    dst = args[3]/6000
    src = args[4]/6000
    sz_diff = (args[6] - args[5])/10.0
    
    if edit == 3 then 
      set_freq(cs_freq, src)
    elseif edit == 4 then
      set_scale(cs_scale, dst)
    --elseif edit == 5 then
      --params:delta("alpha", src/6000.0)
    elseif edit == 6 then
      set_gap(cs_gap, sz_diff)
    else
      do end
    end
    print("/netvoltage", src, dst, sz_diff) 
  
  elseif path == "/hexvoltage" then
    set_phrase(cs_phrase, args[1])
    set_alpha(cs_alpha, args[2])
    engine.voice(args[3])
    print("/hexvoltage", args[1]*15, args[2])
  
  elseif path == "/voxvoltage" then
    set_toggle()
    print("/voxvoltage")
  
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
  
  indicator = "+"
  indicator_cv = "O"
  blank = " "
  
  screen.aa(1)
  screen.level(15)
  screen.font_size(8)
  screen.clear()
  
  -- main interface
  screen.move(8, 8)
  if rx_osc == 0 then screen.text("Vox Ex Machina   ") end
  if rx_osc == 1 then 
    screen.text("Vox Ex Machina H ")
    rx_osc = 0	
  end
  
  if engine.isRunning then screen.text("^v^ ") else screen.text("off ") end
  if edit == 0 then screen.text(indicator) else screen.text(" ") end
  
  -- controls
  screen.move(x1,y1)
  screen.text("vox: ")
  screen.move(x2, y1)
  screen.text_right(voice_names[voice+1])
  screen.move(x3,y1)
  if edit == 1 then screen.text(indicator) else screen.text(" ") end
    
  screen.move(x1,y2)
  screen.text("hex: " )
  screen.move(x2, y2)
  screen.text_right(string.format("%d", phrase))
  screen.move(x3, y2)
  if edit == 2 then screen.text(indicator_cv) else screen.text(" ") end
  
  screen.move(x1,y3)
  screen.text("sin: ")
  screen.move(x2,y3)
  screen.text_right(freq_modes[mode+2])
  screen.move(x3, y3)
  if edit == 3 then screen.text(indicator) else screen.text(" ") end
  
  screen.move(x1,y4)
  screen.text("frq: ")
  screen.move(x2,y4)
  screen.text_right(string.format("%d", freq))
  screen.move(x3, y4)
  if edit == 4 then screen.text(indicator_cv) else screen.text(" ") end
 
  screen.move(x1,y5)
  screen.text("tim: ")
  screen.move(x2, y5)
  screen.text_right(string.format("%.2f", scale)) 
  screen.move(x3, y5)
  if edit == 5 then screen.text(indicator_cv) else screen.text(" ") end
 
  screen.move(x1,y6)
  screen.text("shp: ")
  screen.move(x2, y6)
  screen.text_right(string.format("%.2f", alpha))
  screen.move(x3, y6)
  if edit == 6 then screen.text(indicator_cv)  else screen.text(" ") end
  
  screen.move(x1, y7)
  screen.text("win: ")
  screen.move(x2, y7)
  screen.text_right(string.format("%.2f", gap))
  screen.move(x3, y7)
  if edit == 7 then screen.text(indicator_cv) else screen.text(" ") end
   
  screen.update()
end

function cleanup()
  --delete temp label files
  folder = "/home/we/dust/data/vox/"
  util.os_capture("rm "..folder.."mage-*")
end
