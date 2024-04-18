function onUpdate(elapsed)
	if songName == "fight-or-flight" or songName == "expulsion" or songName == "playful" then
		if curStep == 0 then
			setProperty('scoreTxt.y', 695);
			setProperty('timeBarBGBG.y', 670);
			setProperty('timeBar.y', 670);
			setProperty('timeBarBG.y', 670);
			setProperty('timeTxt.y', 657);
		end
	else
		if getPropertyFromClass('PlayState', 'VHSui') == false and getPropertyFromClass('PlayState', 'devoidUI') == false and getPropertyFromClass('PlayState', 'xenoEncUI') == false and getPropertyFromClass('PlayState', 'xenoEncFix') == false then
			if curStep == 0 then
				if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
					setProperty('scoreTxt.y', 695);
				else
					setProperty('scoreTxt.y', 8);
				end
			end
		end
	end
end