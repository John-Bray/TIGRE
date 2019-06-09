size={440,256}

function draw() 
	drawAll(components) 
	drawText(font_led_24,  30, 232, string.format("%.2f", 0.01*get(COM1) ), 1,1,1)
	drawText(font_led_24, 140, 232, string.format("%.2f", get(COM1_SBY_M)+0.001*get(COM1_SBY_k) ), 0.5,0.5,0.5)
	drawText(font_led_24, 240, 232, string.format("%.2f", 0.01*get(NAV1) ), 1,1,1)
	drawText(font_led_24, 350, 232, string.format("%.2f", get(NAV1_SBY_M)+0.01*get(NAV1_SBY_k) ), 0.5,0.5,0.5)
	drawText(font_led_24,  40, 200, string.format("%.2f", 0.01*get(COM2) ), 1,0.1,0.1)
	drawText(font_led_24, 170, 200, string.format("%.2f", get(COM2_SBY_M)+0.001*get(COM2_SBY_k) ), 0.7,0.0,0.0)
	local SQK_1 = math.floor(  get(SQK)                              /1000 )
	local SQK_2 = math.floor( (get(SQK) -1000*SQK_1)                 / 100 )
	local SQK_3 = math.floor( (get(SQK) -1000*SQK_1 -100*SQK_2)      /  10 )
	local SQK_4 = math.floor( (get(SQK) -1000*SQK_1 -100*SQK_2 -10*SQK_3)  )
	drawText(font_led_24,  12, 168, SQK_1 , 1,1,1)
	drawText(font_led_24, 112, 168, SQK_2 , 1,1,1)
	drawText(font_led_24, 212, 168, SQK_3 , 1,1,1)
	drawText(font_led_24, 312, 168, SQK_4 , 1,1,1)
	
	--local transponder_mode_int = get(transponder_mode)
	--local transponder_mode_txt = '-'
	-- Transponder mode (off=0,stdby=1,on=2,test=3)
	--if transponder_mode_int == 0 then transponder_mode_txt = 'OFF' end
	--if transponder_mode_int == 1 then transponder_mode_txt ='SBY' end
	--if transponder_mode_int == 2 then transponder_mode_txt = 'ON' end
	--if transponder_mode_int == 3 then transponder_mode_txt = 'TST' end

	
	--drawText(font_led_24,  12, 100, transponder_mode_int , 1,0,1)
	--drawText(font_led_24,  30, 100, transponder_mode_txt , 1,1,1)
	
	
end
