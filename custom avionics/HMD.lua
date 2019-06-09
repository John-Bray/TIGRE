size={512,512}

function draw() -- head mounted display
	drawAll(components) 
	
	local currentEng_kW_A			= math.floor( 0.5+ (get(engWattsA)/1000))
	local currentAlt = math.floor(get(altitude_m)*  3.2808399)	
	local currentNR = math.floor(get(NR))
	local trorqueLimit = math.floor(0.5 + 1332+(0.015*currentAlt)  +  currentNR-370) -- in kW
	local TqPercentA = math.floor((currentEng_kW_A/trorqueLimit)*100)	
			
		drawText(font_Sans24, 250, 248, '+', 0,1,0) 			--  gunsight
		drawRectangle(0, 480, 32, 32,    0.1, 1, 0.1, 1)		--  green box for the flightPathMarker

		textForPrinting = 'Hdg: '  .. math.floor(get(Hdg) +0.5)
		drawText(font_Sans24, 210, 400, textForPrinting, 0,1,0,1)
	
		textForPrinting = 'IAS: '  .. math.floor( get(IAS) )
		drawText(font_Sans24, 10,236, textForPrinting, 0.1, 1, 0.1, 1)
		
		textForPrinting = 'Tq: '  .. TqPercentA .. '%'
		drawText(font_Sans24, 50,110, textForPrinting, 0.1, 1, 0.1, 1)
		
		textForPrinting = 'Alt: '  .. math.floor(get(altitude_m)*  3.2808399)	
		drawText(font_Sans24, 380, 134, textForPrinting, 0,1,0,1)	
		textForPrinting = 'AGL: '  .. math.floor(get(m_agl) * 3.2808399)
		drawText(font_Sans24, 360, 110, textForPrinting, 0,1,0,1)	
		
		if get(parking_brake) == 1 then
		drawText(font_Sans24, 150, 40, '! PARKING BRAKE !', 0,1,0, 0.7)	
		end
		
	-- ========================================== GPS/FMS
	local maxWPID = countFMSEntries()-1
	if countFMSEntries() > 0 then
		for i=countFMSEntries(), 1, -1 do
			entryType, entryID, entryRef, entryAltitude, entryLat, entrynLon = getFMSEntryInfo(i)
			if destinationID == ''  then
				maxWPID = i
				i = countFMSEntries()
			end
		end
		local currentWPnumber = getDestinationFMSEntry() -- the id (number) of the next (current) waypoint in FMS
		currentWP_Type, currentWP_ID, currentWP_Ref, currentWP_Altitude, currentWP_Lat, currentWP_Lon = getFMSEntryInfo(currentWPnumber)
		drawText(font_Sans12,   200, 440, 'currentWP: ' .. currentWPnumber  .. '=' .. currentWP_ID, 0,1,0)
		local NmDegNext = LatLonToNmDegT(get(currentLAT), get(currentLON), currentWP_Lat, currentWP_Lon)
		currentDestinationString = string.format("%3.1f nm @ ", NmDegNext[1] ) .. ' '  .. string.format("%3.0f degM", NmDegNext[3])   
		drawText(font_Sans12,  200, 425, currentDestinationString ,0,1,0) 
		local headingOffset = NmDegNext[3] - get(Hdg)
		if headingOffset < -180 then headingOffset = headingOffset +360 end
		drawText(font_Sans12, 253, 383, '|', 0,1,0) 			--  heading line
		local WPX = 248
		if headingOffset > -15 and headingOffset <15 then -- let 15 deg =  the first 150px
			WPX = WPX+headingOffset*10
		else -- let the remaining 180 deg = 50px
			if headingOffset > 15 and headingOffset <180 then
					WPX = WPX+150+headingOffset*0.278
			else
				WPX = WPX-150+headingOffset*0.278
			end
		end
		drawText(font_Sans24, WPX,    373, '^', 0,1,0) 			--  WP pointer
		if headingOffset < -2 or headingOffset >2 then
			drawText(font_Sans12, WPX-5, 370, math.floor(headingOffset), 0,1,0) 			--  WP offset
		end
		-- not used: lleft in for info only
		departType, departID, departRef, departAltitude, departLat, departLon = getFMSEntryInfo(0)
		endexType,  endexID,  endexRef,   endexAltitude, endexLat, endexLon = getFMSEntryInfo(maxWPID-1 )		
		local NmDeg = LatLonToNmDegT(get(currentLAT), get(currentLON), endexLat, endexLon)
		finalDestinationString = string.format("%3.1f nm @ ", NmDeg[1] ) .. ' '  .. string.format("%3.1f degM /", NmDeg[3])   .. string.format("%3.1f degT", NmDeg[2])   
		--drawText(font_Sans12,  30, 345, finalDestinationString ,0,1,0)
	end -- of 	if countFMSEntries() > 0 
	-- ========================================== GPS/FMS

end
