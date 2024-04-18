local dark = false;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeAnimatedLuaSprite('schoolhouse', 'bgs/educator/schoolhouse', -1000, -450);
		addAnimationByPrefix('schoolhouse', '1', 'anim first', 3, true);
		addAnimationByPrefix('schoolhouse', '2', 'anim second', 3, true);
		scaleObject('schoolhouse', 3.25, 3.25);
		setProperty('schoolhouse.antialiasing', false);
		setScrollFactor('schoolhouse', 1, 1);
		luaSpritePlayAnimation('schoolhouse', '1');
		addLuaSprite('schoolhouse', false);
		
		setProperty('flashingshit.alpha',0)		
		
		if songName == "playful" then
			makeLuaSprite('refBG', 'bgs/educator/reference-bg', -1000, -500);
			setLuaSpriteScrollFactor('refBG', 0.9, 0.9);
			scaleObject('refBG', 2.5, 2.5);
			setProperty('refBG.alpha',0)
			setProperty('refBG.antialiasing', false);
			addLuaSprite('refBG', false);
			
			makeLuaSprite('refFloor', 'bgs/educator/reference-floor', -1000, -450);
			setLuaSpriteScrollFactor('refFloor', 1, 1);
			scaleObject('refFloor', 3.25, 3.25);
			setProperty('refFloor.alpha',0)
			setProperty('refFloor.antialiasing', false);
			addLuaSprite('refFloor', false);
		end
	end
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "expulsion" then
		if curStep == 68 then
			doTweenAlpha('camHUD1','camHUD',0,0.8,'linear')
		end
	
		if curStep == 128 then
			doTweenAlpha('camHUD2','camHUD',1,1,'linear')
		end
	
		if curStep == 384 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1.0,'linear')
			luaSpritePlayAnimation('schoolhouse', '2');
			dark = true;
		end
		
		if curStep == 640 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit2','flashingshit',0,1.0,'linear')
			luaSpritePlayAnimation('schoolhouse', '1');
			dark = false;
		end
		
		if curStep == 896 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit3','flashingshit',0,1.0,'linear')
			luaSpritePlayAnimation('schoolhouse', '2');
			dark = true;
		end
		
		if curStep == 1152 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit4','flashingshit',0,1.0,'linear')
			luaSpritePlayAnimation('schoolhouse', '1');
			dark = false;
		end
		
		if curStep == 1216 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit5','flashingshit',0,1.0,'linear')
			luaSpritePlayAnimation('schoolhouse', '2');
			dark = true;
		end
		
		if curStep == 1472 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit6','flashingshit',0,1.0,'linear')
			luaSpritePlayAnimation('schoolhouse', '1');
			dark = false;
		end
		
		if curStep == 1746 then
			doTweenAlpha('camHUD2','camHUD',0,2,'linear')
		end
	end
	
	if songName == "playful" then
		if curStep == 768 then
			doTweenAlpha('refBGT','refBG',1,15,'linear')
			doTweenAlpha('refFloorT','refFloor',1,15,'linear')
		end
		
		if curStep == 896 then
			doTweenAlpha('refBGT','refBG',0,2,'linear')
			doTweenAlpha('refFloorT','refFloor',0,4,'linear')
		end
	
		if curStep == 1024 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1.0,'linear')
			
			luaSpritePlayAnimation('schoolhouse', '2');
			dark = true;
		end

		if curStep == 1280 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit2','flashingshit',0,1.0,'linear')
			
			luaSpritePlayAnimation('schoolhouse', '1');
			dark = false;
		end
	end
end

function opponentNoteHit()
	if dark == true then
		health = getProperty('health')
		if getProperty('health') > 0.3 then
			setProperty('health', health- 0.020);
		end
	end
	if dark == false then
		health = getProperty('health')
		if getProperty('health') > 0.3 then
			setProperty('health', health- 0.005);
		end
	end
end