size={512,404}

local needle2 = loadImage('needle2.png')
local lower2   = loadImage('screen_2.png')

function draw() 
	drawAll(components)                                                    -- lower screen
	
	if get(batteryON) > 0 then
		
			drawTexture(lower2, 0, 0, 512, 404)
	
			local EOT = math.floor(get(OAT) + get(engOilTemp))
			needleAngle = -77+(EOT/120)*158
			drawRotatedTexture(needle2, needleAngle, 108, 235, 8, 135)
			drawText(font_Sans36,  70,234, EOT, 1,1,1)
	
			local EOP = get(engOilPressure)/14.5
			needleAngle = -77+(EOP/12)*158
			drawRotatedTexture(needle2, needleAngle, 390, 235, 8, 135)	
			drawText(font_Sans36, 350,234, string.format("%.1f", EOP), 1,1,1)
	
			drawText(font_Sans36, 45,124,  math.floor(get(DCvoltage)), 0.8,0.8,0.8)
			drawText(font_Sans36, 270,124, math.floor(get(DCcurrent)), 0.8,0.8,0.8)

			local Kg_per_Hr = 3600*get(fuelFlow)
			drawText(font_Sans36, 15,21, string.format("%.1f", Kg_per_Hr ), 1,1,1)	
			local endHoursDecimal = get(fuelKg) / Kg_per_Hr
	
			local endHours = math.floor(endHoursDecimal)
			drawText(font_Sans36, 377,21, endHours, 1,1,1)
			local endMinutes = math.floor(60*(endHoursDecimal - endHours))
			drawText(font_Sans36, 413,21, endMinutes, 1,1,1)
	
	end
	
end
