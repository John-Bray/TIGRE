size={256,256}

function draw() -- head mounted display
	drawAll(components) 
		local currentAirSpeed   =  math.floor(get(IAS) )
		local currentHdg   =  math.floor(get(Hdg) +0.5)
		local currentAlt   = math.floor(get(altitude_m)*  3.2808399)	
		local currentAGL = math.floor(get(m_agl) * 3.2808399)
		
		drawText(font_Sans10, 124, 124, '+', 0,1,0)
		drawRectangle(0, 256, 32, 32,    0.1, 1, 0.1, 1)	
	
		textForPrinting = 'IAS: '  .. currentAirSpeed
		drawText(font_Sans10, 5, 5, textForPrinting, 0.1, 1, 0.1, 1)
	
		textForPrinting = 'Hdg: '  .. currentHdg
		drawText(font_Sans10, 100, 140, textForPrinting, 0,1,0,1)
		
		textForPrinting = 'Alt: '  .. currentAlt
		drawText(font_Sans10, 200, 20, textForPrinting, 0,1,0,1)	
		textForPrinting = 'AGL: '  .. currentAGL
		drawText(font_Sans10, 200, 5, textForPrinting, 0,1,0,1)	
		
		if get(parking_brake) == 1 then
		drawText(font_Sans24, 20, 70, '! PARKING BRAKE !', 0,1,0, 0.5)	
		end

end
