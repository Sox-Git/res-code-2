local xx = 500;
local yy = 400;
local ofs = 10;
local ofs2 = 10;
local xx2 = 1200;
local yy2 = 450;
local zoom = 0;
local followchars = true;
function onCreate()
---550
	makeLuaSprite('light1', 'bgs/Fate/light1', -820, -200);
	scaleObject('light1', 1.3, 1);
	setScrollFactor('light1', 1, 1);
	setProperty('light1.alpha', 1);
	setProperty('light1.antialiasing', true);
	
	makeAnimatedLuaSprite('VHS', 'bgs/omw/staticOMW', -880, -800);
	scaleObject('VHS', 8, 8);
	addAnimationByPrefix('VHS', 'sshh', 'stat', 24, true);
	setScrollFactor('VHS', 1, 1);
	setProperty('VHS.antialiasing', false);
	setProperty('VHS.alpha', 0)
	
	makeAnimatedLuaSprite('static', 'staticBACKGROUND2', -880, -800, 'exe');
	scaleObject('static', 3, 3);
	setScrollFactor('static', 1, 1);
	addAnimationByPrefix('static', 'static', 'menuSTATICNEW instance 1', 24, true);
	setProperty('static.antialiasing', true);
	setProperty('static.alpha', 0);	
	
	makeLuaSprite('im1', 'bgs/Fate/image1', -580, -750);
	scaleObject('im1', 1, 1);
	setScrollFactor('im1', 1, 1);
	setProperty('im1.antialiasing', true);
	
	makeLuaSprite('im2', 'bgs/Fate/image2', -380, -550);
	scaleObject('im2', 1, 1);
	setScrollFactor('im2', 1, 1);
	setProperty('im2.antialiasing', true);
	
	makeLuaSprite('im3', 'bgs/Fate/image3', -180, -750);
	scaleObject('im3', 1, 1);
	setScrollFactor('im3', 1, 1);
	setProperty('im3.antialiasing', true);
	
	makeLuaSprite('im4', 'bgs/Fate/image4', -380, -550);
	scaleObject('im4', 1, 1);
	setScrollFactor('im4', 1, 1);
	setProperty('im4.antialiasing', true);
	
	makeLuaSprite('im5', 'bgs/Fate/image5', -380, -750);
	scaleObject('im5', 1, 1);
	setScrollFactor('im5', 1, 1);
	setProperty('im5.antialiasing', true);
	
	makeLuaSprite('im6', 'bgs/Fate/image6', -380, -750);
	scaleObject('im6', 1, 1);
	setScrollFactor('im6', 1, 1);
	setProperty('im6.antialiasing', true);

	makeLuaSprite('floor', 'bgs/Fate/floor', -820, -900);
	scaleObject('floor', 1.3, 1.1);
	setScrollFactor('floor', 1, 1);
	setProperty('floor.antialiasing', true);
	
	makeLuaSprite('lg1', 'bgs/Fate/light1-grass', -820, -900);
	scaleObject('lg1', 1.3, 1.1);
	setScrollFactor('lg1', 1, 1);
	setProperty('lg1.antialiasing', true);
	setBlendMode('lg1','MULTIPLY')
	setProperty('lg1.alpha',0)
	
	makeLuaSprite('lg2', 'bgs/Fate/light2-grass', -820, -900);
	scaleObject('lg2', 1.3, 1.1);
	setScrollFactor('lg2', 1, 1);
	setProperty('lg2.antialiasing', true);
	setBlendMode('lg2','MULTIPLY')
	setProperty('lg2.alpha',0)
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',1)
	
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	setProperty('black.alpha',1)
	
	makeLuaSprite('jscare', 'bgs/Fate/jscare');
	setProperty('jscare.antialiasing', true);
	setScrollFactor('jscare', 0, 0);
	setGraphicSize('jscare', 2200, 1238)
	screenCenter('jscare')
	setProperty('jscare.alpha', 0)
	
	addLuaSprite('light1', false);
	addLuaSprite('im1', false);
	addLuaSprite('im2', false);
	addLuaSprite('im3', false);
	addLuaSprite('im4', false);
	addLuaSprite('im5', false);
	addLuaSprite('im6', false);
	addLuaSprite('VHS', false)
	addLuaSprite('static', false);
	addLuaSprite('floor', false);
	addLuaSprite('lg1', false);
	addLuaSprite('lg2', false);
	addLuaSprite('blk', false);
	addLuaSprite('black', true);
	addLuaSprite('jscare', true);
	
	setProperty('camHUD.alpha', 0)
	
	runTimer('Image Up', 0.1, 1)
end

function onTimerCompleted(tag)
	if tag == 'Image Up' then
		doTweenY('Im1-TweenUp', 'im1', -800, 2.5, 'sineInOut')
		doTweenY('Im2-TweenUp', 'im2', -600, 2, 'sineInOut')
		doTweenY('Im3-TweenUp', 'im3', -800, 2.5, 'sineInOut')
		doTweenY('Im4-TweenUp', 'im4', -600, 2, 'sineInOut')
		doTweenY('Im5-TweenUp', 'im5', -790, 2.5, 'sineInOut')
		doTweenY('Im6-TweenUp', 'im6', -800, 3, 'sineInOut')
		runTimer('Image Down', 2.5, 1)
	end
	if tag == 'Image Down' then
		doTweenY('Im1-TweenDown', 'im1', -750, 2.5, 'sineInOut')
		doTweenY('Im2-TweenDown', 'im2', -550, 2, 'sineInOut')
		doTweenY('Im3-TweenDown', 'im3', -750, 2.5, 'sineInOut')
		doTweenY('Im4-TweenDown', 'im4', -550, 2, 'sineInOut')
		doTweenY('Im5-TweenDown', 'im5', -750, 2, 'sineInOut')
		doTweenY('Im6-TweenDown', 'im6', -750, 3, 'sineInOut')
		runTimer('Image Up', 2.6, 1)
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if zoom == 1 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.5)
		else
			setProperty('defaultCamZoom',0.6)
		end
	end
	
	if songName == "fate" then
		if curStep == 63 then
			doTweenAlpha('black','black', 0, 16, 'linear')
		end
		if curStep == 140 then
			doTweenAlpha('camHUD','camHUD', 1, 1, 'linear')
		end
		if curStep == 224 then
			doTweenAlpha('camHUD','camHUD', 0, 1, 'linear')
		end
		if curStep == 280 then
			setProperty('black.alpha',1)
		end
		if curStep == 284 then
			zoom = 1
			setProperty('black.alpha',0)
			setProperty('blk.alpha',0)
			setProperty('camHUD.alpha',1)
		end
		if curStep == 544 then
			doTweenZoom('ZOOMDAD', 'camGame',0.8, 1.12, 'quadOut')
			doTweenY('light1-TweenUp', 'light1', -550, 0.5, 'sineInOut')
			doTweenAlpha('lg1','lg1', 1, 0.3, 'linear')
		end
		if curStep == 672 then
			doTweenY('light1-TweenDown', 'light1', -200, 0.5, 'sineInOut')
			doTweenAlpha('lg1','lg1', 0, 0.3, 'linear')
		end
		if curStep == 796 then
			zoom = 0
		end
		if curStep == 800 then
			doTweenAlpha('camHUD','camHUD', 0, 1.5, 'linear')
			doTweenZoom('ZOOMDAD', 'camGame',0.7, 5.3, 'quadOut')
		end
		if curStep == 872 then
			setProperty('jscare.alpha', 1)
		end
		if curStep == 892 then
			zoom = 1
			setProperty('jscare.alpha', 0)
			setProperty('VHS.alpha', 1)
			setProperty('lg2.alpha', 1)
		end
		if curStep == 944 then
			doTweenAlpha('camHUD','camHUD', 1, 1, 'linear')
		end
		if curStep == 1215 then
			zoom = 0
		end
		if curStep == 1472 then
			zoom = 1
			doTweenZoom('ZOOMDAD', 'camGame',0.8, 1.12, 'quadOut')
			setProperty('VHS.alpha', 0)
			setProperty('static.alpha', 1)
			setProperty('lg2.alpha', 0)
			setProperty('lg1.alpha', 1)
		end
	end
	if followchars == true then
        if mustHitSection == false then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs2,yy2)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs2,yy2)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs2)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs2)
            end
			if getProperty('boyfriend.curCharacter') == 'singLEFTmiss' then
                triggerEvent('Camera Follow Pos',xx2-ofs2,yy2)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
                triggerEvent('Camera Follow Pos',xx2+ofs2,yy2)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs2)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
        triggerEvent('Camera Follow Pos','','')
	end
end