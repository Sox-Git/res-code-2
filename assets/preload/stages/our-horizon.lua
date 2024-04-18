function onStepHit()
	if curStep == 1 then
		setProperty('camHUD.alpha',0)
	end
	if curStep == 10 then
		doTweenAlpha('camHUD', 'camHUD', 1, 1)
	end
	if curStep == 2336 then
		setProperty('dadGroup.x', 140)
		setProperty('dadGroup.y', 105)
	end
end
function onSongStart()
	setProperty('camHUD.alpha',0)
end
function noteMiss(id, direction, noteType, sustain)
	if curStep >= 1005 and curStep <= 1016 then
		setProperty('health',0)
	end
end