size={256,256}

function draw() -- head mounted display
	drawAll(components) 
	
	local currentEng_kW_A			= math.floor( 0.5+ (get(engWattsA)/1000))
	local currentAlt = math.floor(get(altitude_m)*  3.2808399)	
	local currentNR = math.floor(get(NR))
	local trorqueLimit = math.floor(0.5 + 1332+(0.015*currentAlt)  +  currentNR-370) -- in kW
	local TqPercentA = math.floor((currentEng_kW_A/trorqueLimit)*100)	
			
		drawText(font_Sans12, 125, 124, '+', 0,1,0) 			-- gunsight
		drawRectangle(0, 256, 32, 32,    0.1, 1, 0.1, 1)		-- the green box for the flightPathMarker

		textForPrinting = 'Hdg: '  .. math.floor(get(Hdg) +0.5)
		drawText(font_Sans10, 105, 200, textForPrinting, 0,1,0,1)
	
		textForPrinting = 'IAS: '  .. math.floor( get(IAS) )
		drawText(font_Sans10, 5,118, textForPrinting, 0.1, 1, 0.1, 1)
		
		textForPrinting = 'Tq: '  .. TqPercentA .. '%'
		drawText(font_Sans10, 25,55, textForPrinting, 0.1, 1, 0.1, 1)
		
		textForPrinting = 'Alt: '  .. math.floor(get(altitude_m)*  3.2808399)	
		drawText(font_Sans10, 190, 67, textForPrinting, 0,1,0,1)	
		textForPrinting = 'AGL: '  .. math.floor(get(m_agl) * 3.2808399)
		drawText(font_Sans10, 180, 55, textForPrinting, 0,1,0,1)	
		
		if get(parking_brake) == 1 then
		drawText(font_Sans12, 75, 20, '! PARKING BRAKE !', 0,1,0, 0.7)	
		end

end
