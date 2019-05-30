size={256,192}

function draw()  -- pitch + power
	drawAll(components) 
	local textForPrinting			= '-'
	local currentPitch				= 0.1*math.floor(10*get(collectivePitch))
	local currentEngTq			= math.floor(get(engTq))
	local currentEng_kW_A			= math.floor( 0.5+ (get(engWattsA)/1000))
	local currentEng_kW_B			= math.floor( 0.5+ (get(engWattsB)/1000))

	local currentNR = math.floor(get(NR))
	local currentThrottle			=  math.floor(get(throttle)       *100)  -- convert tp percentage
	local currentAlt = math.floor(get(altitude_m)*  3.2808399)	
	local angularVelocity = 0.1 * math.floor(0.5+   (10* 2 * 3.14159 * get(NR)/60 )  ) -- RadiansPerSecond
	local currentPedals 			= 0.1*math.floor(get(pedals) *1000)
	local currentTRPtitch		=  0.1*math.floor(get(TRPtitch)    *10)  -- 1dp
	
	local    xStart = 128
	local    yStart = 90
	local  xWidth = 0
	local yHeight = 0

	drawText(font_Sans12, 15, 5, 'Power' , 1,0,0)
	
	textForPrinting = 'Rotor speed: '  .. currentNR .. 'rpm = ' .. angularVelocity .. ' Radians/second'
	drawText(font_Sans10, 10, 150, textForPrinting, 1,1,1)	
	
	textForPrinting = 'Engine Power: '  .. currentEng_kW_A .. 'kW  --- ' .. currentEng_kW_B .. 'kW'
	drawText(font_Sans10, 10, 140, textForPrinting, 1,1,1)
	
	local torqueCalc =  math.floor (get(engWattsA) / angularVelocity)
	textForPrinting = 'Power / Angular velocity = '  .. torqueCalc .. 'Nm'
	drawText(font_Sans10, 10, 130, textForPrinting, 1,1,1)	

	textForPrinting = 'Engine Torque: '  .. currentEngTq .. 'Nm (from XP dataref)'
	drawText(font_Sans10, 10, 120, textForPrinting, 1,1,1)	
	
	textForPrinting = 'Altitude: '  .. currentAlt .. 'ft'
	drawText(font_Sans10, 10, 100, textForPrinting, 1,1,1)	
	
	-- Engine max is set at  504hp = 376kW
	--local trorqueLimit = math.floor(0.5 + 300+(0.015*currentAlt)  +  currentNR-410) -- EC20
	
		-- Powerplant: 1 × Turbomeca Astazou IIIA turboshaft, 440 kW (590 hp) NR should be 386 [SA341G]
	--local trorqueLimit = math.floor(0.5 + 400+(0.015*currentAlt)  +  currentNR-386) 
	
	local trorqueLimit = math.floor(0.5 + 1332+(0.015*currentAlt)  +  currentNR-370) 
	

	textForPrinting = 'Torque limit is at: '  .. trorqueLimit .. 'kW ('.. math.floor(0.5 + (1.341* trorqueLimit)) .. 'hp)'
	drawText(font_Sans10, 10, 90, textForPrinting, 1,1,1)	
	local TqPercent = math.floor((currentEng_kW_A/trorqueLimit)*100)
	local TqPercenttB= math.floor((currentEng_kW_B/trorqueLimit)*100)
	
	textForPrinting = 'Torque: '  .. TqPercent .. '% --- '  .. TqPercenttB .. '%'
	drawText(font_Sans10, 10, 70, textForPrinting, 1,1,1)	
	
	
	textForPrinting = 'Blade pitch: '  .. currentPitch .. 'deg'
	drawText(font_Sans10, 10, 30, textForPrinting, 1,1,1)	

	textForPrinting = 'Engine Throttle: '  .. currentThrottle .. '%'
	drawText(font_Sans10, 10, 20, textForPrinting, 1,1,1)
	
end
	
	