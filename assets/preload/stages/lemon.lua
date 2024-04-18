function onCreate()
	makeLuaSprite('bg', '', 0, 0);
	makeGraphic('bg',1920,1080,'353535')
	addLuaSprite('bg', false);
	setLuaSpriteScrollFactor('bg',0,0)
	setProperty('bg.scale.x',2)
	setProperty('bg.scale.y',2)
	setProperty('bg.alpha',1)
	
	makeLuaSprite('flashingshit1', '', 0, 0);
	makeGraphic('flashingshit1',1920,1080,'273249')
	addLuaSprite('flashingshit1', false);
	setLuaSpriteScrollFactor('flashingshit1',0,0)
	setProperty('flashingshit1.scale.x',2)
	setProperty('flashingshit1.scale.y',2)
	setProperty('flashingshit1.alpha',0)
	
	makeLuaSprite('flashingshit2', '', 0, 0);
	makeGraphic('flashingshit2',1920,1080,'31331B')
	addLuaSprite('flashingshit2', false);
	setLuaSpriteScrollFactor('flashingshit2',0,0)
	setProperty('flashingshit2.scale.x',2)
	setProperty('flashingshit2.scale.y',2)
	setProperty('flashingshit2.alpha',0)
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "soured" then
		if curStep == 2 then
			doTweenY('bfTween', 'boyfriend', "1100", 0.001);
		end
		if curStep == 12 then
			doTweenY('bfTween', 'boyfriend', "663.5", 2.4);
		end
	end
end

function onBeatHit()
	if curBeat % 2 == 0 then
		if mustHitSection == false then
			setProperty('flashingshit1.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit1',0,1.0,'linear')
		end
	else
		if mustHitSection == true then
			setProperty('flashingshit2.alpha',1)
			doTweenAlpha('flashingshit2','flashingshit2',0,1.0,'linear')
		end
	end
end