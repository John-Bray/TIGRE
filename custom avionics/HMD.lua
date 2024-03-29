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
		
	-- ========================================== GPS/FMS START
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
	-- ========================================== GPS/FMS END
		
	if get(IAS) < 60 and get(jb_yawControl) == 1 then
			drawText(font_Sans12, 215, 30, 'YAW DAMPER ON [' .. get(jb_yawControl) .. ']', 0,1,0,1) 		
		else
			drawText(font_Sans12, 215, 30, 'YAW DAMPER OFF [' .. get(jb_yawControl) .. ']', 0,1,0,0.5) 		
	end
	
	--local gunHdgAngle =  0.1 * math.floor( 10 *get(gunHdgRatio) *  get(gunHdgMax) )--  degrees, offset from centre line
	--local gunPitchAngle =  0.1 * math.floor( 10 *get(gunPitchRatio) *  get(gunPitchMax) )--  degrees, offset from centre line
	
	local testing = 0
	if testing == 1 then
		drawText(font_Sans12, 140, 112, 'headHdg ['      .. 0.1* math.floor(10*get(headHdg) ).. ']', 1,0,0,1) 	
		drawText(font_Sans12, 140, 100, 'gunHdgMax ['      .. 0.1* math.floor(10*get(gunHdgMax) ).. ']', 1,0.5,0,1) 	
		drawText(font_Sans12, 140, 88, 'gunHdgRatio ['      .. 0.01* math.floor(100*get(gunHdgRatio) ).. ']', 1,1,0,1) 	
		drawText(font_Sans12, 140, 76, 'gunHdgAngle [' .. 0.1* math.floor(10*get(gunHdgAngle)) .. ']', 0.5,1,0,1) 	
		drawText(font_Sans12, 20, 216, 'headPitch ['     .. 0.1* math.floor(10*get(headPitch) ).. ']', 1,0,0,1) 
		drawText(font_Sans12, 20, 204, 'gunPitchMax ['     .. 0.1* math.floor(10*get(gunPitchMax) ).. ']', 1,0.5,0,1) 
		drawText(font_Sans12, 20, 192, 'gunPitchRatio ['      .. 0.01* math.floor(100*get(gunPitchRatio) ).. ']', 1,1,0,1) 	
		drawText(font_Sans12, 20, 180, 'gunPitchAngle [' ..0.1* math.floor(10*get(gunPitchAngle) ).. ']', 0,1,0,1) 	
	end

end


function update()
	local currentAirSpeed   =  math.floor(get(IAS) )
	local currentPedals = get(pedals) 
	local currentYawRate   = get(yawRate)
	local GHR = 0 -- for gun heading ratio calcs
	local GPR = 0 -- for gun pitch ratio calcs

	
	-- YAW DAMPER
	if currentAirSpeed < 60 and get(jb_yawControl) == 1 then
		local maxYawRate = 60 - currentAirSpeed
		local yawSpeedFactor = 0.0166 * (60 - currentAirSpeed) -- 1 to 0
		local newPedals =  currentPedals - currentYawRate*0.001*yawSpeedFactor
		set(pedals, newPedals)
	end
	
	set(gunHdgMax, 90)
	set(gunPitchMax, 20)
	set(gunHdgRatio, 0.0) 
	set(gunPitchRatio, 0.0)
	
	if get(guns_armed) == 1 then
			-- gun turret
			if get(headHdg) < 180 then 
				GHR = get(headHdg) / get(gunHdgMax)
			else
				GHR = -( 360- get(headHdg)  )/ get(gunHdgMax)
			end
			if GHR > 1 then GHR = 1 end
			if GHR < -1 then GHR = -1 end
			set(gunHdgRatio, GHR)  
	
			--if get(headPitch) >=0 then 
				GPR = get(headPitch) / get(gunPitchMax)
			--else
			--	GPR = -( 360- get(headPitch)  )/ get(gunPitchMax)
			--end
			if GPR > 1 then GPR = 1 end
			if GPR < -1 then GPR = -1 end
			set(gunPitchRatio, GPR) 
	
			--used in the chassis in the model
			set(gunHdgAngle,  (  get(gunHdgRatio )  *  get( gunHdgMax  )  ) )
			set(gunPitchAngle, (  get(gunPitchRatio) *  get (gunPitchMax)  )  )

			--set(gunHdgRatio, get(pedals))  -- for testing
			
	end
	
end
