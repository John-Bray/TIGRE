size={256,192}

function draw() 
	drawAll(components) 
	local textForPrinting			= '-'
	local currentPedals 			= 0.1*math.floor(get(pedals) *1000)
	local currentPitch				= 0.1*math.floor(10*get(collectivePitch))
	local currentThrottle			=  math.floor(get(throttle)       *100)  -- convert tp percentage
	local currentPitchCyclic	=  math.floor(get(pitchCyclic) *100)  -- convert tp percentage
	local currentRollCyclic		=  math.floor(get(rollCyclic)    *100)  -- convert tp percentage
	local currentTRPtitch		=  0.1*math.floor(get(TRPtitch)    *10)  -- 1dp
	
	local    xStart = 128
	local    yStart = 90
	local  xWidth = 0
	local yHeight = 0

	drawText(font_Sans10, 5, 180,  'Blades' , 1,1,1)
	textForPrinting = currentPitch ..'deg'
	drawText(font_Sans10, 5, 170, textForPrinting, 1,1,1)		
	drawRectangle(5, 5, 10, ((currentPitch+2)*10), 0.4, 0.1, 0.1, 1)
			
	textForPrinting = 'Roll: '  .. currentRollCyclic ..'%'
	drawText(font_Sans10, 100, 170, textForPrinting, 1,1,1)	
	if currentRollCyclic > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = currentRollCyclic	
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 180, xWidth, 8, 0.1, 0.4, 0.1, 1)	
	else --NEG-- PORT RED
		xWidth = -currentRollCyclic
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 180, xWidth, 8, 0.4, 0.1, 0.1, 1)		
	end	
	
	textForPrinting = 'Pitch: '  .. currentPitchCyclic ..'%'
	drawText(font_Sans10, 190, (90+0.85*currentPitchCyclic), textForPrinting, 1,1,1)
		if currentPitchCyclic > 0 then --POS-- UP BLUE
		yStart = 90
		yHeight = currentPitchCyclic	
		drawRectangle(240, yStart, 8, yHeight, 0.2, 0.2, 0.4, 1)	
	else --NEG-- DOWN BROWN
		yHeight = -currentPitchCyclic
		yStart = 90 - yHeight
		drawRectangle(240, yStart, 8, yHeight,  0.3, 0.2, 0.1, 1)		
	end	
	
	textForPrinting = 'Pedals: '  .. currentPedals ..'%   ' .. currentTRPtitch .. 'deg TR pitch'
	drawText(font_Sans10, 100, 15, textForPrinting, 1,1,1)	
	if currentPedals > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = currentPedals	
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 5, xWidth, 8, 0.1, 0.4, 0.1, 1)	
	else --NEG-- PORT RED
		xWidth = -currentPedals
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 5, xWidth, 8, 0.4, 0.1, 0.1, 1)		
	end
	
	if get(jb_yawControl) == 1 then
		drawText(font_Sans12, 20, 17,  'INSTRUCTOR', 1,0,0)	 
		drawText(font_Sans12, 20,   5,  'ASSISTED',       1,0,0)	 
	else
		drawText(font_Sans10, 20, 15,  'student',    0,0.5,0)	 
		drawText(font_Sans10, 20,   5,  'controlled', 0,0.5,0)	 
	end
	
end
