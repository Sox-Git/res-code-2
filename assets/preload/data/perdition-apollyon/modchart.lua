function onCreatePost()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false and getPropertyFromClass('ClientPrefs', 'downScroll') == false then
		noteTweenX('MiddleSatanosX0', 0, 415, 0.01, 'quartInOut')
		noteTweenX('MiddleSatanosX1', 1, 525, 0.01, 'quartInOut')
		noteTweenX('MiddleSatanosX2', 2, 635, 0.01, 'quartInOut')
		noteTweenX('MiddleSatanosX3', 3, 745, 0.01, 'quartInOut')

		noteTweenX('MiddleXBF0', 4, 415, 0.01, 'quartInOut')
		noteTweenX('MiddleXBF1', 5, 525, 0.01, 'quartInOut')
		noteTweenX('MiddleXBF2', 6, 635, 0.01, 'quartInOut')
		noteTweenX('MiddleXBF3', 7, 745, 0.01, 'quartInOut')

		noteTweenY("SatanosY1", 0, 565, 0.01, "linear")
		noteTweenY("SatanosY2", 1, 565, 0.01, "linear")
		noteTweenY("SatanosY3", 2, 565, 0.01, "linear")
		noteTweenY("SatanosY4", 3, 565, 0.01, "linear")

		setPropertyFromGroup('opponentStrums',0,'downScroll',true)
		setPropertyFromGroup('opponentStrums',1,'downScroll',true)
		setPropertyFromGroup('opponentStrums',2,'downScroll',true)
		setPropertyFromGroup('opponentStrums',3,'downScroll',true)
	end
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false and getPropertyFromClass('ClientPrefs', 'downScroll') == false then
		noteTweenX('MiddleSatanosX0', 0, 415, 0.01, 'quartInOut')
		noteTweenX('MiddleSatanosX1', 1, 525, 0.01, 'quartInOut')
		noteTweenX('MiddleSatanosX2', 2, 635, 0.01, 'quartInOut')
		noteTweenX('MiddleSatanosX3', 3, 745, 0.01, 'quartInOut')

		noteTweenX('MiddleXBF0', 4, 415, 0.01, 'quartInOut')
		noteTweenX('MiddleXBF1', 5, 525, 0.01, 'quartInOut')
		noteTweenX('MiddleXBF2', 6, 635, 0.01, 'quartInOut')
		noteTweenX('MiddleXBF3', 7, 745, 0.01, 'quartInOut')

		noteTweenY("SatanosY1", 0, 50, 0.01, "linear")
		noteTweenY("SatanosY2", 1, 50, 0.01, "linear")
		noteTweenY("SatanosY3", 2, 50, 0.01, "linear")
		noteTweenY("SatanosY4", 3, 50, 0.01, "linear")

		setPropertyFromGroup('opponentStrums',0,'downScroll', false)
		setPropertyFromGroup('opponentStrums',1,'downScroll', false)
		setPropertyFromGroup('opponentStrums',2,'downScroll', false)
		setPropertyFromGroup('opponentStrums',3,'downScroll', false)
	end
end

function onUpdate(elapsed)
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false and getPropertyFromClass('ClientPrefs', 'downScroll') == false then
		if curStep == 160 then --m1
			noteTweenX('SatanosNormalX1', 0, 90, 1, 'linear');
			noteTweenX('SatanosNormalX2', 1, 205, 1, 'linear');
			noteTweenX('SatanosNormalX3', 2, 315, 1, 'linear');
			noteTweenX('SatanosNormalX4', 3, 425, 1, 'linear');

			noteTweenX('BFNormalX1', 4, 730, 1, 'linear');
			noteTweenX('BFNormalX2', 5, 845, 1, 'linear');
			noteTweenX('BFNormalX3', 6, 955, 1, 'linear');
			noteTweenX('BFNormalX4', 7, 1065, 1, 'linear');
		end
		if curStep == 415 then --m2
			doTweenAlpha('hud', 'camHUD', 0, 0.5, 'linear')
		end
		if curStep == 430 then --m3
			setPropertyFromGroup('opponentStrums',0,'downScroll',false)
			setPropertyFromGroup('opponentStrums',1,'downScroll',false)
			setPropertyFromGroup('opponentStrums',2,'downScroll',false)
			setPropertyFromGroup('opponentStrums',3,'downScroll',false)

			setPropertyFromGroup('playerStrums',2,'downScroll',true)
			setPropertyFromGroup('playerStrums',3,'downScroll',true)
			setPropertyFromGroup('playerStrums',0,'downScroll',false)
			setPropertyFromGroup('playerStrums',1,'downScroll',false)

			noteTweenY("MiddleBFY1", 4, 300, 0.01, "linear")
			noteTweenY("MiddleBFY2", 5, 300, 0.01, "linear")
			noteTweenY("MiddleBFY3", 6, 300, 0.01, "linear")
			noteTweenY("MiddleBFY4", 7, 300, 0.01, "linear")

			noteTweenX('SatanosInvert1', 0, 730, 0.01, 'linear');
			noteTweenX('SatanosInvert2', 1, 845, 0.01, 'linear');
			noteTweenX('SatanosInvert3', 2, 955, 0.01, 'linear');
			noteTweenX('SatanosInvert4', 3, 1065, 0.01, 'linear');

			noteTweenAlpha("Satanos0Alpha1", 0, 0.01, 0.01, "linear")
			noteTweenAlpha("Satanos0Alpha2", 1, 0.01, 0.01, "linear")
			noteTweenAlpha("Satanos0Alpha3", 2, 0.01, 0.01, "linear")
			noteTweenAlpha("Satanos0Alpha4", 3, 0.01, 0.01, "linear")

			noteTweenX('MiddleXBF1', 4, 415, 0.01, 'quartInOut')
			noteTweenX('MiddleXBF2', 5, 525, 0.01, 'quartInOut')
			noteTweenX('MiddleXBF3', 6, 635, 0.01, 'quartInOut')
			noteTweenX('MiddleXBF4', 7, 745, 0.01, 'quartInOut')	
		end
		if curStep == 432 then --m4
			doTweenAlpha('hud', 'camHUD', 1, 0.5, 'linear')
		end
		if curStep == 560 then --m5
			noteTweenY("UpScrollBF1", 4, 50, 1, "linear")
			noteTweenY("UpScrollBF2", 5, 50, 1, "linear")
			noteTweenY("DownScrollBF3", 6, 565, 1, "linear")
			noteTweenY("DownScrollBF4", 7, 565, 1, "linear")
		end
		if curStep == 688 then --m6
			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
			 
			noteTweenY("UpScrollSatanos1", 0, 50, 1, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 1, "linear")
			noteTweenY("DownScrollSatanos3", 2, 565, 1, "linear")
			noteTweenY("DownScrollSatanos4", 3, 565, 1, "linear")

			noteTweenY("DownScrollBF1", 4, 565, 1, "linear")
			noteTweenY("DownScrollBF2", 5, 565, 1, "linear")
			noteTweenY("UpScrollBF3", 6, 50, 1, "linear")
			noteTweenY("UpScrollBF4", 7, 50, 1, "linear")

			noteTweenX('SatanosNormalX1', 0, 90, 1, 'linear');
			noteTweenX('SatanosNormalX2', 1, 205, 1, 'linear');
			noteTweenX('SatanosNormalX3', 2, 315, 1, 'linear');
			noteTweenX('SatanosNormalX4', 3, 425, 1, 'linear');

			noteTweenX('BFNormalX1', 4, 730, 1, 'linear');
			noteTweenX('BFNormalX2', 5, 845, 1, 'linear');
			noteTweenX('BFNormalX3', 6, 955, 1, 'linear');
			noteTweenX('BFNormalX4', 7, 1065, 1, 'linear');	

			noteTweenAlpha("Satanos1Alpha1", 0, 1, 1, "linear")
			noteTweenAlpha("Satanos1Alpha2", 1, 1, 1, "linear")
			noteTweenAlpha("Satanos1Alpha3", 2, 1, 1, "linear")
			noteTweenAlpha("Satanos1Alpha4", 3, 1, 1, "linear")
		end
		if curStep == 944 then --m7
			noteTweenY("UpScrollSatanos1", 0, 50, 1.5, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 1.5, "linear")
			noteTweenY("UpScrollSatanos3", 2, 50, 1.5, "linear")
			noteTweenY("UpScrollSatanos4", 3, 50, 1.5, "linear")
			noteTweenY("UpScrollBF1", 4, 50, 1.5, "linear")
			noteTweenY("UpScrollBF2", 5, 50, 1.5, "linear")
			noteTweenY("UpScrollBF3", 6, 50, 1.5, "linear")
			noteTweenY("UpScrollBF4", 7, 50, 1.5, "linear")

			noteTweenAlpha("Satanos0Alpha1", 0, 0.01, 1.5, "linear")
			noteTweenAlpha("Satanos0Alpha2", 1, 0.01, 1.5, "linear")
			noteTweenAlpha("Satanos0Alpha3", 2, 0.01, 1.5, "linear")
			noteTweenAlpha("Satanos0Alpha4", 3, 0.01, 1.5, "linear")

			noteTweenX('MiddleSatanosX0', 0, 415, 1.5, 'quartInOut')
			noteTweenX('MiddleSatanosX1', 1, 525, 1.5, 'quartInOut')
			noteTweenX('MiddleSatanosX2', 2, 635, 1.5, 'quartInOut')
			noteTweenX('MiddleSatanosX3', 3, 745, 1.5, 'quartInOut')

			noteTweenX('MiddleXBF0', 4, 415, 1.5, 'quartInOut')
			noteTweenX('MiddleXBF1', 5, 525, 1.5, 'quartInOut')
			noteTweenX('MiddleXBF2', 6, 635, 1.5, 'quartInOut')
			noteTweenX('MiddleXBF3', 7, 745, 1.5, 'quartInOut')

			setPropertyFromGroup('opponentStrums', 0, 'downScroll',false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll',false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll',false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll',false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
		end
		if curStep == 1068 then --m8
			noteTweenY("DownScrollBF1", 4, 565, 0.25, "linear")
			noteTweenY("UpScrollBF2", 5, 50, 0.25, "linear")
			noteTweenY("DownScrollBF3", 6, 565, 0.25, "linear")
			noteTweenY("UpScrollBF4", 7, 50, 0.25, "linear")

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
		end
		if curStep == 1136 then --m9
			noteTweenY("UpScrollBF1", 4, 50, 0.25, "linear")
			noteTweenY("DownScrollBF2", 5, 565, 0.25, "linear")
			noteTweenY("UpScrollBF3", 6, 50, 0.25, "linear")
			noteTweenY("DownScrollBFBF4", 7, 565, 0.25, "linear")

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)
		end
		if curStep == 1200 then --m10
			noteTweenY("UpScrollSatanos1", 0, 50, 0.15, "BackIn")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.15, "BackIn")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.15, "BackIn")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.15, "BackIn")

			noteTweenAlpha("Satanos1Alpha1", 0, 1, 0.15, "linear")
			noteTweenAlpha("Satanos1Alpha2", 1, 1, 0.15, "linear")
			noteTweenAlpha("Satanos1Alpha3", 2, 1, 0.15, "linear")
			noteTweenAlpha("Satanos1Alpha4", 3, 1, 0.15, "linear")

			noteTweenY("UpScrollBF1", 4, 50, 0.15, "BackIn")
			noteTweenY("UpScrollBF2", 5, 50, 0.15, "BackIn")
			noteTweenY("UpScrollBF3", 6, 50, 0.15, "BackIn")
			noteTweenY("UpScrollBF4", 7, 50, 0.15, "BackIn")

			noteTweenX('BFInvert1', 4, 90, 0.15, 'BackIn');
			noteTweenX('BFInvert2', 5, 205, 0.15, 'BackIn');
			noteTweenX('BFInvert3', 6, 315, 0.15, 'BackIn');
			noteTweenX('BFInvert4', 7, 425, 0.15, 'BackIn');

			noteTweenX('SatanosInvert1', 0, 730, 0.15, 'BackIn');
			noteTweenX('SatanosInvert2', 1, 845, 0.15, 'BackIn');
			noteTweenX('SatanosInvert3', 2, 955, 0.15, 'BackIn');
			noteTweenX('SatanosInvert4', 3, 1065, 0.15, 'BackIn');

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
		end
		if curStep == 1456 or curStep == 1488 or curStep == 1520 then --m11
			noteTweenY("UpScrollSatanos1", 0, 50, 0.05, "BackIn")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.05, "BackIn")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.05, "BackIn")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF1", 4, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF2", 5, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF3", 6, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF4", 7, 50, 0.05, "BackIn")

			noteTweenAlpha("Satanos0Alpha1", 0, 0.3, 0.05, "BackIn")
			noteTweenAlpha("Satanos0Alpha2", 1, 0.3, 0.05, "BackIn")
			noteTweenAlpha("Satanos0Alpha3", 2, 0.3, 0.05, "BackIn")
			noteTweenAlpha("Satanos0Alpha4", 3, 0.3, 0.05, "BackIn")

			noteTweenX('MiddleSatanosX0', 0, 415, 0.5, 'BackIn')
			noteTweenX('MiddleSatanosX1', 1, 525, 0.5, 'BackIn')
			noteTweenX('MiddleSatanosX2', 2, 635, 0.5, 'BackIn')
			noteTweenX('MiddleSatanosX3', 3, 745, 0.5, 'BackIn')

			noteTweenX('MiddleXBF0', 4, 415, 0.5, 'BackIn')
			noteTweenX('MiddleXBF1', 5, 525, 0.5, 'BackIn')
			noteTweenX('MiddleXBF2', 6, 635, 0.5, 'BackIn')
			noteTweenX('MiddleXBF3', 7, 745, 0.5, 'BackIn')

			setPropertyFromGroup('opponentStrums', 0, 'downScroll',false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll',false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll',false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll',false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
		end
		if curStep == 1472 or curStep == 1504 or curStep == 1584 then --m12
			noteTweenY("DownScrollSatanos1", 0, 565, 0.05, "BackIn")
			noteTweenY("DownScrollSatanos2", 1, 565, 0.05, "BackIn")
			noteTweenY("DownScrollSatanos3", 2, 565, 0.05, "BackIn")
			noteTweenY("DownScrollSatanos4", 3, 565, 0.05, "BackIn")
			noteTweenY("DownScrollBF1", 4, 565, 0.05, "BackIn")
			noteTweenY("DownScrollBF2", 5, 565, 0.05, "BackIn")
			noteTweenY("DownScrollBF3", 6, 565, 0.05, "BackIn")
			noteTweenY("DownScrollBF4", 7, 565, 0.05, "BackIn")

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)
		end
		if curStep == 1600 then --m13
			noteTweenY("UpScrollSatanos1", 0, 50, 0.05, "BackIn")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.05, "BackIn")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.05, "BackIn")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF1", 4, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF2", 5, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF3", 6, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF4", 7, 50, 0.05, "BackIn")

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
		end
		if curStep == 1644 then --m14
			noteTweenAlpha("Satanos1Alpha1", 0, 1, 1, "linear")
			noteTweenAlpha("Satanos1Alpha2", 1, 1, 1, "linear")
			noteTweenAlpha("Satanos1Alpha3", 2, 1, 1, "linear")
			noteTweenAlpha("Satanos1Alpha4", 3, 1, 1, "linear")

			noteTweenY("DownScrollSatanos1", 0, 565, 0.05, "BackIn")
			noteTweenY("DownScrollSatanos2", 1, 565, 0.05, "BackIn")
			noteTweenY("DownScrollSatanos3", 2, 565, 0.05, "BackIn")
			noteTweenY("DownScrollSatanos4", 3, 565, 0.05, "BackIn")

			noteTweenY("UpScrollBF1", 4, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF2", 5, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF3", 6, 50, 0.05, "BackIn")
			noteTweenY("UpScrollBF4", 7, 50, 0.05, "BackIn")

			noteTweenX('BFInvert1', 4, 90, 0.15, 'BackIn');
			noteTweenX('BFInvert2', 5, 205, 0.15, 'BackIn');
			noteTweenX('BFInvert3', 6, 315, 0.15, 'BackIn');
			noteTweenX('BFInvert4', 7, 425, 0.15, 'BackIn');

			noteTweenX('SatanosInvert1', 0, 730, 0.15, 'BackIn');
			noteTweenX('SatanosInvert2', 1, 845, 0.15, 'BackIn');
			noteTweenX('SatanosInvert3', 2, 955, 0.15, 'BackIn');
			noteTweenX('SatanosInvert4', 3, 1065, 0.15, 'BackIn');

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)
		end
		if curStep == 1744 then --m15
			noteTweenAlpha("Satanos1Alpha1", 0, 1, 0.01, "linear")
			noteTweenAlpha("Satanos1Alpha2", 1, 1, 0.01, "linear")
			noteTweenAlpha("Satanos1Alpha3", 2, 1, 0.01, "linear")
			noteTweenAlpha("Satanos1Alpha4", 3, 1, 0.01, "linear")

			noteTweenX('SatanosNormalX1', 0, 90, 0.01, 'linear');
			noteTweenX('SatanosNormalX2', 1, 205, 0.01, 'linear');
			noteTweenX('SatanosNormalX3', 2, 315, 0.01, 'linear');
			noteTweenX('SatanosNormalX4', 3, 425, 0.01, 'linear');

			noteTweenX('BFNormalX1', 4, 730, 0.01, 'linear');
			noteTweenX('BFNormalX2', 5, 845, 0.01, 'linear');
			noteTweenX('BFNormalX3', 6, 955, 0.01, 'linear');
			noteTweenX('BFNormalX4', 7, 1065, 0.01, 'linear');	

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)

			noteTweenY("UpScrollSatanos1", 0, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.01, "linear")

			noteTweenY("DownScrollBF1", 4, 565, 0.01, "linear")
			noteTweenY("DownScrollBF2", 5, 565, 0.01, "linear")
			noteTweenY("DownScrollBF3", 6, 565, 0.01, "linear")
			noteTweenY("DownScrollBF4", 7, 565, 0.01, "linear")
		end
		if curStep == 1868 then --m16
			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)

			noteTweenY("UpScrollSatanos1", 0, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.01, "linear")

			noteTweenY("DownScrollBF1", 4, 565, 0.01, "linear")
			noteTweenY("DownScrollBF2", 5, 565, 0.01, "linear")
			noteTweenY("DownScrollBF3", 6, 565, 0.01, "linear")
			noteTweenY("DownScrollBF4", 7, 565, 0.01, "linear")
		end
		if curStep == 2032 then --m17
			triggerEvent('WiggleNotes', '30', '25');

			noteTweenAlpha("Satanos1Alpha1", 0, 1, 0.5, "linear")
			noteTweenAlpha("Satanos1Alpha2", 1, 1, 0.5, "linear")
			noteTweenAlpha("Satanos1Alpha3", 2, 1, 0.5, "linear")
			noteTweenAlpha("Satanos1Alpha4", 3, 1, 0.5, "linear")

			noteTweenX('MiddleSatanosX0', 0, 415, 1, 'quartInOut')
			noteTweenX('MiddleSatanosX1', 1, 525, 1, 'quartInOut')
			noteTweenX('MiddleSatanosX2', 2, 635, 1, 'quartInOut')
			noteTweenX('MiddleSatanosX3', 3, 745, 1, 'quartInOut')

			noteTweenX('MiddleXBF0', 4, 415, 1, 'quartInOut')
			noteTweenX('MiddleXBF1', 5, 525, 1, 'quartInOut')
			noteTweenX('MiddleXBF2', 6, 635, 1, 'quartInOut')
			noteTweenX('MiddleXBF3', 7, 745, 1, 'quartInOut')
		end
		if curStep == 2096 then --m18
			noteTweenX('RandomSatanosX0', 0, 745, 0.4, 'quartInOut')
			noteTweenX('RandomSatanosX1', 1, 635, 0.4, 'quartInOut')
			noteTweenX('RandomSatanosX2', 2, 525, 0.4, 'quartInOut')
			noteTweenX('RandomSatanosX3', 3, 415, 0.4, 'quartInOut')

			noteTweenX('RandomXBF0', 4, 745, 0.4, 'quartInOut')
			noteTweenX('RandomXBF1', 5, 635, 0.4, 'quartInOut')
			noteTweenX('RandomXBF2', 6, 525, 0.4, 'quartInOut')
			noteTweenX('RandomXBF3', 7, 415, 0.4, 'quartInOut')
		end
		if curStep == 2160 or curStep == 2352 then --m19
			noteTweenX('SatanosNormalX1', 0, 90, 1, 'linear');
			noteTweenX('SatanosNormalX2', 1, 205, 1, 'linear');
			noteTweenX('SatanosNormalX3', 2, 315, 1, 'linear');
			noteTweenX('SatanosNormalX4', 3, 425, 1, 'linear');

			noteTweenX('BFNormalX1', 4, 730, 1, 'linear');
			noteTweenX('BFNormalX2', 5, 845, 1, 'linear');
			noteTweenX('BFNormalX3', 6, 955, 1, 'linear');
			noteTweenX('BFNormalX4', 7, 1065, 1, 'linear');
		end
		if curStep == 2304 then --m20
			noteTweenX('SatanosRandomX1', 0, 425, 1, 'linear');
			noteTweenX('SatanosRandomX2', 1, 315, 1, 'linear');
			noteTweenX('SatanosRandomX3', 2, 205, 1, 'linear');
			noteTweenX('SatanosRandomX4', 3, 90, 1, 'linear');

			noteTweenX('BFRandomX1', 4, 1065, 1, 'linear');
			noteTweenX('BFRandomX2', 5, 955, 1, 'linear');
			noteTweenX('BFRandomX3', 6, 845, 1, 'linear');
			noteTweenX('BFRandomX4', 7, 730, 1, 'linear');
		end
		if curStep == 2356 then --m21
			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', true)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', true)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)

			noteTweenY("MiddleBFY1", 4, 300, 0.10, "linear")
			noteTweenY("MiddleBFY2", 5, 300, 0.10, "linear")
			noteTweenY("MiddleBFY3", 6, 300, 0.10, "linear")
			noteTweenY("MiddleBFY4", 7, 300, 0.10, "linear")

			noteTweenY("MiddleSatanosY1", 0, 300, 0.10, "linear")
			noteTweenY("MiddleSatanosY2", 1, 300, 0.10, "linear")
			noteTweenY("MiddleSatanosY3", 2, 300, 0.10, "linear")
			noteTweenY("MiddleSatanosY4", 3, 300, 0.10, "linear")    
		end
		if curStep == 2416 then --m22
			noteTweenX('SatanosNormalX1', 0, 90, 0.01, 'linear');
			noteTweenX('SatanosNormalX2', 1, 205, 0.01, 'linear');
			noteTweenX('SatanosNormalX3', 2, 315, 0.01, 'linear');
			noteTweenX('SatanosNormalX4', 3, 425, 0.01, 'linear');

			noteTweenX('BFNormalX1', 4, 730, 0.01, 'linear');
			noteTweenX('BFNormalX2', 5, 845, 0.01, 'linear');
			noteTweenX('BFNormalX3', 6, 955, 0.01, 'linear');
			noteTweenX('BFNormalX4', 7, 1065, 0.01, 'linear');	

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)

			noteTweenY("UpScrollSatanos1", 0, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.01, "linear")

			noteTweenY("DownScrollBF1", 4, 565, 0.01, "linear")
			noteTweenY("DownScrollBF2", 5, 565, 0.01, "linear")
			noteTweenY("DownScrollBF3", 6, 565, 0.01, "linear")
			noteTweenY("DownScrollBF4", 7, 565, 0.01, "linear")
		end
		if curStep == 2432 then --m23
			noteTweenX('MiddleSatanosX0', 0, 415, 0.3, 'quartInOut')
			noteTweenX('MiddleSatanosX1', 1, 525, 0.3, 'quartInOut')
			noteTweenX('MiddleSatanosX2', 2, 635, 0.3, 'quartInOut')
			noteTweenX('MiddleSatanosX3', 3, 745, 0.3, 'quartInOut')

			noteTweenX('NOBFX0', 4, 2000, 0.3, 'quartInOut')
			noteTweenX('NOBFX1', 5, 2000, 0.3, 'quartInOut')
			noteTweenX('NOBFX2', 6, 2000, 0.3, 'quartInOut')
			noteTweenX('NOBFX3', 7, 2000, 0.3, 'quartInOut')

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)

			noteTweenY("UpScrollSatanos1", 0, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.01, "linear")

			noteTweenY("UpScrollBF1", 4, 50, 0.01, "linear")
			noteTweenY("UpScrollBF2", 5, 50, 0.01, "linear")
			noteTweenY("UpScrollBF3", 6, 50, 0.01, "linear")
			noteTweenY("UpScrollBF4", 7, 50, 0.01, "linear")
		end
		if curStep == 2448 then --m24
			noteTweenX('NOSatanosX0', 0, -1000, 0.05, 'quartInOut')
			noteTweenX('NOSatanosX1', 1, -1000, 0.05, 'quartInOut')
			noteTweenX('NOSatanosX2', 2, -1000, 0.05, 'quartInOut')
			noteTweenX('NOSatanosX3', 3, -1000, 0.05, 'quartInOut')

			noteTweenX('MiddleXBF0', 4, 415, 0.05, 'quartInOut')
			noteTweenX('MiddleXBF1', 5, 525, 0.05, 'quartInOut')
			noteTweenX('MiddleXBF2', 6, 635, 0.05, 'quartInOut')
			noteTweenX('MiddleXBF3', 7, 745, 0.05, 'quartInOut')

			setPropertyFromGroup('opponentStrums', 0, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 1, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 2, 'downScroll', false)
			setPropertyFromGroup('opponentStrums', 3, 'downScroll', false)

			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)

			noteTweenY("UpScrollSatanos1", 0, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos2", 1, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos3", 2, 50, 0.01, "linear")
			noteTweenY("UpScrollSatanos4", 3, 50, 0.01, "linear")

			noteTweenY("UpScrollBF1", 4, 50, 0.01, "linear")
			noteTweenY("UpScrollBF2", 5, 50, 0.01, "linear")
			noteTweenY("UpScrollBF3", 6, 50, 0.01, "linear")
			noteTweenY("UpScrollBF4", 7, 50, 0.01, "linear")
		end
		if curStep == 2464 then --m25
			noteTweenX('SatanosNormalX1', 0, 90, 0.05, 'linear');
			noteTweenX('SatanosNormalX2', 1, 205, 0.05, 'linear');
			noteTweenX('SatanosNormalX3', 2, 315, 0.05, 'linear');
			noteTweenX('SatanosNormalX4', 3, 425, 0.05, 'linear');

			noteTweenX('BFNormalX1', 4, 730, 0.05, 'linear');
			noteTweenX('BFNormalX2', 5, 845, 0.05, 'linear');
			noteTweenX('BFNormalX3', 6, 955, 0.05, 'linear');
			noteTweenX('BFNormalX4', 7, 1065, 0.05, 'linear');
		end
		if curStep == 2551 then --m26
			noteTweenY("NOBFY1", 4, -150, 0.01, "linear")
			noteTweenY("NOBFY2", 5, -150, 0.01, "linear")
			noteTweenY("NOBFY3", 6, -150, 0.01, "linear")
			noteTweenY("NOBFY4", 7, -150, 0.01, "linear")
		end
		if curStep == 2553 then --m27
			noteTweenY("SHHHH1", 4, 800, 0.0001, "linear")
			noteTweenY("SHHHH2", 5, 800, 0.0001, "linear")
			noteTweenY("SHHHH3", 6, 800, 0.0001, "linear")
			noteTweenY("SHHHH4", 7, 800, 0.0001, "linear")
		end
		if curStep == 2558 then --m28
			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)

			noteTweenY("DownScrollBF1", 4, 565, 0.2, "linear")
			noteTweenY("DownScrollBF2", 5, 565, 0.2, "linear")
			noteTweenY("DownScrollBF3", 6, 565, 0.2, "linear")
			noteTweenY("DownScrollBF4", 7, 565, 0.2, "linear")
		end
		if curStep == 2576 then --m29
			noteTweenY("NOBFY1", 4, 800, 0.01, "linear")
			noteTweenY("NOBFY2", 5, 800, 0.01, "linear")
			noteTweenY("NOBFY3", 6, 800, 0.01, "linear")
			noteTweenY("NOBFY4", 7, 800, 0.01, "linear")
		end
		if curStep == 2579 then --m30
			noteTweenY("SHHHH1", 4, -300, 0.0001, "linear")
			noteTweenY("SHHHH2", 5, -300, 0.0001, "linear")
			noteTweenY("SHHHH3", 6, -300, 0.0001, "linear")
			noteTweenY("SHHHH4", 7, -300, 0.0001, "linear")
		end
		if curStep == 2581 then --m31
			setPropertyFromGroup('playerStrums', 0, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 1, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 2, 'downScroll', false)
			setPropertyFromGroup('playerStrums', 3, 'downScroll', false)	
			noteTweenY("UpScrollBF1", 4, 50, 0.2, "linear")
			noteTweenY("UpScrollBF2", 5, 50, 0.2, "linear")
			noteTweenY("UpScrollBF3", 6, 50, 0.2, "linear")
			noteTweenY("UpScrollBF4", 7, 50, 0.2, "linear")
			end
		if curStep == 2671 then --m32
			noteTweenY("NOSATANOSY1", 0, 800, 0.05, "linear")
			noteTweenY("NOSATANOSY2", 1, 800, 0.05, "linear")
			noteTweenY("NOSATANOSY3", 2, 800, 0.05, "linear")
			noteTweenY("NOSATANOSY4", 3, 800, 0.05, "linear")
		end
		if curStep == 2672 then --m33
			triggerEvent('WiggleNotes', '50', '45');
			noteTweenX('MiddleXBF0', 4, 415, 0.5, 'quartInOut')
			noteTweenX('MiddleXBF1', 5, 525, 0.5, 'quartInOut')
			noteTweenX('MiddleXBF2', 6, 635, 0.5, 'quartInOut')
			noteTweenX('MiddleXBF3', 7, 745, 0.5, 'quartInOut')
			noteTweenX('NOSatanosX0', 0, -1000, 0.0001, 'quartInOut')
			noteTweenX('NOSatanosX1', 1, -1000, 0.0001, 'quartInOut')
			noteTweenX('NOSatanosX2', 2, -1000, 0.0001, 'quartInOut')
			noteTweenX('NOSatanosX3', 3, -1000, 0.0001, 'quartInOut')
		end
		if curStep == 2736 then --m34
			setPropertyFromGroup('playerStrums', 1, 'downScroll', true)
			noteTweenY("DownScrollBF2", 5, 565, 0.3, "BackIn")
		end
		if curStep == 2744 then --m35
			noteTweenY("DownScrollBF4", 7, 565, 0.3, "BackIn")
			setPropertyFromGroup('playerStrums', 3, 'downScroll', true)	
		end
		if curStep == 2747 then --m36
			noteTweenY("DownScrollBF3", 6, 565, 0.3, "BackIn")
			setPropertyFromGroup('playerStrums', 2, 'downScroll', true)
		end
		if curStep == 2752 then --m37
			noteTweenY("DownScrollBF1", 4, 565, 0.3, "BackIn")
			setPropertyFromGroup('playerStrums', 0, 'downScroll', true)
		end
	end
end