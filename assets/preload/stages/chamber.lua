local zoom = 1;
local Ye = false;
local Bu = false;

function onCreate()
	if songName == "chaos" then
		precacheImage('characters/Fleetway/fleetway_com')
	end
end

function onStepHit()
	if songName == 'chaos' then
		if curStep == 256 then
			noteTweenAlpha("dissapear1", 0, 0, 0.5, "linear")
			noteTweenAlpha("dissapear2", 1, 0, 0.5, "linear")
			noteTweenAlpha("dissapear3", 2, 0, 0.5, "linear")
			noteTweenAlpha("dissapear4", 3, 0, 0.5, "linear")
		end
		if curStep == 264 then
			makeAnimatedLuaSprite('eat this!', 'characters/Fleetway/fleetway_com', 70, 0);
			setScrollFactor('eat this!', 1, 1);
			setObjectCamera('eat this!', 'camHUD')
			addAnimationByPrefix('eat this!', 'idle', 'cooking', 28, true);
			setProperty('eat this!.antialiasing', true);
			addLuaSprite('eat this!', true);
			scaleObject('eat this!', 1.3, 1.3)
			setScrollFactor('eat this!', 1, 1);
		end
		if curStep == 272 then
			noteTweenAlpha("dissapear1", 0, 1, 0.5, "linear")
			noteTweenAlpha("dissapear2", 1, 1, 0.5, "linear")
			noteTweenAlpha("dissapear3", 2, 1, 0.5, "linear")
			noteTweenAlpha("dissapear4", 3, 1, 0.5, "linear")	
		end
		if curStep == 280 then
			removeLuaSprite('eat this!')
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'RedVGin' then
		doTweenAlpha('In','vg',1,0.62,'linear')
		runTimer('RedVGout', 0.62, 1)
	end
	if tag == 'RedVGout' then
		doTweenAlpha('Out','vg',0,0.62,'linear')
		runTimer('RedVGin', 0.62, 1)
	end
	if tag == 'RedVGinFast' then
		doTweenAlpha('InF','vg',1,0.31,'linear')
		runTimer('RedVGoutFast', 0.31, 1)
	end
	if tag == 'RedVGoutFast' then
		doTweenAlpha('OutF','vg',0,0.31,'linear')
		runTimer('RedVGinFast', 0.31, 1)
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
end