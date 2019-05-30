size={256,192}

function draw() -- yaw / pedals
	drawAll(components) 

	drawText(font_Sans12, 15, 5, 'Pedals' ,0.2,0.2,1)
	
	-- sim/flightmodel/position/R  in deg/sec	The yaw rotation rate is (relative to the flight)
	local currentAirSpeed   =  math.floor(get(IAS) )
	local currentPedals = 0.1*math.floor(get(pedals) *1000)
	local currentYawRate   = 0.01 * math.floor(get(yawRate)*100) -- 2 dp
	local currentYawForce  = math.floor(get(yawForce) ) -- Nm	The yaw moment total.
	local currentTRPtitch		=  0.1*math.floor(get(TRPtitch)    *10)  -- 1dp
	local currentTR_rpm		=  math.floor(get(TR_rpm) )  -- 1dp

	local textForPrinting= '-'
	local xStart = 128
	local xWidth = 0

	textForPrinting = 'IAS: '  .. currentAirSpeed
	drawText(font_Sans10, 100, 180, textForPrinting, 1,1,1)
	drawRectangle(128, 170, currentAirSpeed, 8, 0.8, 0, 0.7, 1)

	textForPrinting = 'Pedals: '  .. currentPedals ..'%   ' .. currentTRPtitch .. 'deg TR pitch  ' .. currentTR_rpm .. 'rpm'
	drawText(font_Sans10, 70, 150, textForPrinting, 1,1,1)	
		if currentPedals > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = currentPedals	
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 140, xWidth, 8, 0.5, 0.8, 0.5, 1)	
	else --NEG-- PORT RED
		xWidth = -currentPedals
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 140, xWidth, 8, 0.8, 0.5, 0.5, 1)		
	end
	
	textForPrinting = 'YawForce: '  .. currentYawForce .. ' Nm'
	drawText(font_Sans10, 100, 120, textForPrinting, 1,1,1)
	if currentYawForce > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = currentYawForce*0.005
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 110, xWidth, 8, 0.5, 0.8, 0.5, 1)	
	else --NEG-- PORT RED
		xWidth = -currentYawForce*0.005
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 110, xWidth, 8, 0.8, 0.5, 0.5, 1)		
	end
	
	textForPrinting = 'YawRate: '  .. currentYawRate .. '  Deg/sec'
	drawText(font_Sans10, 100, 90, textForPrinting, 1,1,1)	
	if currentYawRate > 0 then --POS-- STBD GREEN
		xStart = 128
		xWidth = math.floor(currentYawRate*10)
		if xWidth > 100 then xWidth = 100 end
		drawRectangle(xStart, 80, xWidth, 8, 0.5, 0.8, 0.5, 1)	
	else --NEG-- PORT RED
		xWidth = -currentYawRate*10
		if xWidth > 100 then xWidth = 100 end
		xStart = 128 - xWidth
		drawRectangle(xStart, 80, xWidth, 8, 0.8, 0.5, 0.5, 1)		
	end
	
		if get(jb_yawControl) == 1 then
			drawText(font_Sans12, 56, 5,  'DAMPER ON', 1,0,0)	 
		else
			drawText(font_Sans10, 56, 5,  'damper off', 0,0.5,0)	 
		end
	
end

function update()
		local currentAirSpeed   =  math.floor(get(IAS) )
		local currentPedals = get(pedals) 
		local currentYawRate   = get(yawRate)

	if currentAirSpeed < 60 and get(jb_yawControl) == 1 then
		local maxYawRate = 60 - currentAirSpeed
		local yawSpeedFactor = 0.0166 * (60 - currentAirSpeed) -- 1 to 0
		local newPedals =  currentPedals - currentYawRate*0.001*yawSpeedFactor
		set(pedals, newPedals)
	end
end

