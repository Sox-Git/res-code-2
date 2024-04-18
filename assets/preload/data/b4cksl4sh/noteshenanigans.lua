function onStepHit()
	if curStep == 1440 then
		noteTweenAlpha("dissapear1", 0, 0, 1, "linear")
		noteTweenAlpha("dissapear2", 1, 0, 1, "linear")
		noteTweenAlpha("dissapear3", 2, 0, 1, "linear")
		noteTweenAlpha("dissapear4", 3, 0, 1, "linear")
				
		noteTweenX('bfnotemove1', 4, 265, 1, 'quartInOut')
		noteTweenX('bfnotemove2', 5, 375, 1, 'quartInOut')
		noteTweenX('bfnotemove3', 6, 485, 1, 'quartInOut')
		noteTweenX('bfnotemove4', 7, 595, 1, 'quartInOut')	
	end
	if curStep == 1488 then
		noteTweenX('bfnotemove1', 4, 35, 1, "quartInOut")
		noteTweenX('bfnotemove2', 5, 195, 1, "quartInOut")
		noteTweenX('bfnotemove3', 6, 645, 1, "quartInOut")
		noteTweenX('bfnotemove4', 7, 805, 1, "quartInOut")	
	end
	if curStep == 1552 or curStep == 1584 or curStep == 1616 or curStep == 1648 or curStep == 1680 or curStep == 1712 or curStep == 1744 or curStep == 1776 or curStep == 1808 then
		noteTweenY("bfnotemovedown1", 4, 465, 0.5, "quartInOut")
		noteTweenY("bfnotemovedown2", 5, 465, 0.5, "quartInOut")
		noteTweenY("bfnotemovedown3", 6, 465, 0.5, "quartInOut")
		noteTweenY("bfnotemovedown4", 7, 465, 0.5, "quartInOut")
		
		setPropertyFromGroup('playerStrums',0,'downScroll',true)
		setPropertyFromGroup('playerStrums',1,'downScroll',true)
		setPropertyFromGroup('playerStrums',2,'downScroll',true)
		setPropertyFromGroup('playerStrums',3,'downScroll',true)
	end
	if curStep == 1568 or curStep == 1600 or curStep == 1632 or curStep == 1664 or curStep == 1696 or curStep == 1728 or curStep == 1760 or curStep == 1792 then
		noteTweenY("heightreset1", 4, 51, 0.5, "quartInOut")
		noteTweenY("heightreset2", 5, 51, 0.5, "quartInOut")
		noteTweenY("heightreset3", 6, 51, 0.5, "quartInOut")
		noteTweenY("heightreset4", 7, 51, 0.5, "quartInOut")
		
		setPropertyFromGroup('playerStrums',0,'downScroll',false)
		setPropertyFromGroup('playerStrums',1,'downScroll',false)
		setPropertyFromGroup('playerStrums',2,'downScroll',false)
		setPropertyFromGroup('playerStrums',3,'downScroll',false)
	end
	if curStep == 1824 then
		noteTweenX('bfnotemove1', 4, 265, 0.01, 'quartInOut')
		noteTweenX('bfnotemove2', 5, 375, 0.01, 'quartInOut')
		noteTweenX('bfnotemove3', 6, 485, 0.01, 'quartInOut')
		noteTweenX('bfnotemove4', 7, 595, 0.01, 'quartInOut')	
	end
	if getPropertyFromClass('ClientPrefs', 'downScroll') == true and curStep == 1825 then	
		noteTweenY("bfnotemovedown1", 4, 465, 0.01, "quartInOut")
		noteTweenY("bfnotemovedown2", 5, 465, 0.01, "quartInOut")
		noteTweenY("bfnotemovedown3", 6, 465, 0.01, "quartInOut")
		noteTweenY("bfnotemovedown4", 7, 465, 0.01, "quartInOut")

		setPropertyFromGroup('playerStrums',0,'downScroll',true)
		setPropertyFromGroup('playerStrums',1,'downScroll',true)
		setPropertyFromGroup('playerStrums',2,'downScroll',true)
		setPropertyFromGroup('playerStrums',3,'downScroll',true)	
	end	
	if getPropertyFromClass('ClientPrefs', 'downScroll') == false and curStep == 1825 then
		setPropertyFromGroup('playerStrums',0,'downScroll',false)
		setPropertyFromGroup('playerStrums',1,'downScroll',false)
		setPropertyFromGroup('playerStrums',2,'downScroll',false)
		setPropertyFromGroup('playerStrums',3,'downScroll',false)
		
		noteTweenY("heightreset1", 4, 51, 0.5, "quartInOut")
		noteTweenY("heightreset2", 5, 51, 0.5, "quartInOut")
		noteTweenY("heightreset3", 6, 51, 0.5, "quartInOut")
		noteTweenY("heightreset4", 7, 51, 0.5, "quartInOut")
	end
end