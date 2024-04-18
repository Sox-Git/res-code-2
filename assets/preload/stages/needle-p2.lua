function onCreate()
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	setObjectCamera('flashingshit', 'camHUD')
end

function onUpdate(elapsed)

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "spike-trap" then
		if curStep == 128 or curStep == 384 or curStep == 512 or curStep == 640 or curStep == 768 or curStep == 896 or curStep == 1152 or curStep == 1280 or curStep == 1416 or curStep == 1536 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flash','flashingshit',0,1.0,'linear')
		end
	end
end