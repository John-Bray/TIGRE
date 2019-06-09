size={256, 256}

function draw() 
	drawAll(components)                                                    --  screen #1 (Engines )
	local currentEng_kW_A			= math.floor( 0.5+ (get(engWattsA)/1000))
	local currentEng_kW_B			= math.floor( 0.5+ (get(engWattsB)/1000))
	local currentAlt = math.floor(get(altitude_m)*  3.2808399)	
	local currentNR = math.floor(get(NR))
	local trorqueLimit = math.floor(0.5 + 1332+(0.015*currentAlt)  +  currentNR-370) -- in kW
	local TqPercentA = math.floor((currentEng_kW_A/trorqueLimit)*100)
	local TqPercenttB= math.floor((currentEng_kW_B/trorqueLimit)*100)
	
	local currentNFA = math.floor(get(NFA))
	local currentNFB = math.floor(get(NFB))
	local currentNR = math.floor(get(NR))
	local currentfuelKg = math.floor(get(fuelKg))
	

	
	drawText(font_Sans12,   30, 235, 'Tq', 1,1,0.5)
	drawText(font_Sans12, 215, 235, 'Tq', 1,1,0.5)
	
	textForPrinting =  TqPercentA .. '% '
	drawText(font_Sans12,   25, 215, textForPrinting, 1,1,1)
	textForPrinting =  TqPercenttB .. '% '
	drawText(font_Sans12, 210, 215, textForPrinting, 1,1,1)
	
	drawText(font_Sans12,   120, 235, 'NR', 1,1,0.5)
	drawText(font_Sans24,   110, 195, currentNR, 1,1,1)
	

	drawText(font_Sans12,   30, 165, 'NF', 1,1,0.5)
	drawText(font_Sans12, 215, 165, 'NF', 1,1,0.5)	
	
	drawText(font_Sans12,   30, 140, currentNFA, 1,1,1)
	drawText(font_Sans12, 215, 140, currentNFB, 1,1,1)
	
	drawText(font_Sans12,   115, 120, 'FUEL', 1,1,0.5)
	drawText(font_Sans12,   115, 105, currentfuelKg, 1,1,1)

	drawText(font_Sans10,   140, 34, 'YAW', 1,1,0.5)
	drawText(font_Sans10,   140, 22, 'DAMPER', 1,1,0.5)

	
	
	
	
	
	
end