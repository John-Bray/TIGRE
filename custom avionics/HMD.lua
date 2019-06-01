size={256,256}

function draw() -- head mounted display
	drawAll(components) 
	
	local currentEng_kW_A			= math.floor( 0.5+ (get(engWattsA)/1000))
	local currentAlt = math.floor(get(altitude_m)*  3.2808399)	
	local currentNR = math.floor(get(NR))
	local trorqueLimit = math.floor(0.5 + 1332+(0.015*currentAlt)  +  currentNR-370) -- in kW
	local TqPercentA = math.floor((currentEng_kW_A/trorqueLimit)*100)

		--local currentAirSpeed   =  math.floor(get(IAS) )
		--local currentHdg   =  math.floor(get(Hdg) +0.5)
		--local currentAlt   = math.floor(get(altitude_m)*  3.2808399)	
		--local currentAGL = math.floor(get(m_agl) * 3.2808399)
		
		-- these are measurements in METRES from the CG set in Planemaker
		--local currentViewPointSTBD = 0.01 * math.floor(get(viewPointSTBD) * 100) -- metres to 2 dp
		--local currentViewPointUP = 0.01 * math.floor(get(viewPointUP) * 100) -- metres to 2 dp
		--local currentViewPointAFT = 0.01 * math.floor(get(viewPointAFT) * 100) -- metres to 2 dp	
		--textForPrinting = 'CG_Y: '  .. (0.01 * math.floor(get(acf_cgY_original) * 30.48) )  -- metres to 2 dp
		--drawText(font_Sans10, 100, 188, textForPrinting, 1, 0.1, 0.1, 1)			
		--textForPrinting = 'CG_Z: '  .. (0.01 * math.floor(get(acf_cgZ_original) * 30.48) )  -- metres to 2 dp
		--drawText(font_Sans10, 50, 138, textForPrinting,1, 0.1, 0.1, 1)	
		--textForPrinting = 'STBD: '  .. currentViewPointSTBD
		--drawText(font_Sans10, 150, 175, textForPrinting, 1, 0.1, 0.1, 1)	
		--textForPrinting = 'UP: '  .. currentViewPointUP
		--drawText(font_Sans10, 100, 200, textForPrinting, 1, 0.1, 0.1, 1)			
		--textForPrinting = 'AFT: '  .. currentViewPointAFT
		--drawText(font_Sans10, 50, 150, textForPrinting,1, 0.1, 0.1, 1)	
			
		drawText(font_Sans12, 125, 124, '+', 0,1,0)  -- gunsight
		drawRectangle(0, 256, 32, 32,    0.1, 1, 0.1, 1)	 -- the green box for the flightPathMarker

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
