local xx = 580;
local yy = 425;
local ofs = 15;
local ofs2 = 15;
local xx2 = 975;
local yy2 = 500;
local followchars = true;
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/sunshineEncore/sky', -970, -700);
		scaleObject('sky', 0.8, 0.8);
		setScrollFactor('sky', 0.5, 0.5);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false);
		
		makeLuaSprite('planets', 'bgs/sunshineEncore/planets', -700, -700);
		scaleObject('planets', 0.7, 0.7);
		setScrollFactor('planets', 0.8, 0.9);
		setProperty('planets.antialiasing', true);
		addLuaSprite('planets', false);
		
		makeLuaSprite('xterion', 'bgs/sunshineEncore/xterion', -730, -550);
		scaleObject('xterion', 0.6, 0.6);
		setScrollFactor('xterion', 0.8, 1);
		setProperty('xterion.alpha', 0);
		setProperty('xterion.antialiasing', true);
		addLuaSprite('xterion', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('terrain', 'bgs/sunshineEncore/terrain', -550, -550);
			scaleObject('terrain', 0.7, 0.6);
			setScrollFactor('terrain', 1, 1);
			setProperty('terrain.antialiasing', true);
			addLuaSprite('terrain', false);
		end
		
		makeLuaSprite('floor', 'bgs/tails-doll/bg', -750, -250);
		scaleObject('floor', 1.3, 1.3);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		setProperty('floor.alpha', 0);
		addLuaSprite('floor', false);
		
		makeLuaSprite('black', '', 0, 0);
		makeGraphic('black',1920,1080,'000000')
		addLuaSprite('black', false);
		screenCenter('black')
		setLuaSpriteScrollFactor('black',0,0)
		setProperty('black.scale.x',4)
		setProperty('black.scale.y',4)
		setProperty('black.alpha',0)
		
		makeLuaSprite('blk', '', 0, 0);
		makeGraphic('blk',1920,1080,'000000')
		addLuaSprite('blk', true);
		screenCenter('blk')
		setLuaSpriteScrollFactor('blk',0,0)
		setProperty('blk.scale.x',4)
		setProperty('blk.scale.y',4)
		setProperty('blk.alpha',0)
	end
end
    
function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 165)
	
	if songName == "sunshine-encore" then
		if curStep == 0 then
			setProperty('black.alpha', 1)
			doTweenAlpha('END1','scoreTxt', 0, 0.2,'linear')
			doTweenAlpha('END2','iconP1', 0, 0.2,'linear')
			doTweenAlpha('END3','iconP2', 0, 0.2,'linear')
			doTweenAlpha('END4','healthBar', 0, 0.2,'linear')
			doTweenAlpha('END5','healthBarBG', 0, 0.2,'linear')
		end
		if curStep == 32 then
			setProperty('defaultCamZoom',0.77)
		end
		if curStep == 64 then
			setProperty('defaultCamZoom',0.77)
		end
		if curStep == 128 then
			doTweenAlpha('blk1','blk', 1, 0.7,'linear')
		end
		if curStep == 136 then
			setProperty('black.alpha', 0)
			setProperty('blk.alpha', 0)
			setProperty('defaultCamZoom',0.67)
			doTweenAlpha('END1','scoreTxt', 1, 0.2,'linear')
			doTweenAlpha('END2','iconP1', 1, 0.2,'linear')
			doTweenAlpha('END3','iconP2', 1, 0.2,'linear')
			doTweenAlpha('END4','healthBar', 1, 0.2,'linear')
			doTweenAlpha('END5','healthBarBG', 1, 0.2,'linear')
		end
		if curStep == 264 then
			setProperty('defaultCamZoom',0.9)
		end
		if curStep == 328 then
			setProperty('defaultCamZoom',0.67)
		end
		if curStep == 336 then
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 344 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 352 then
			setProperty('defaultCamZoom',0.9)
		end
		if curStep == 360 then
			setProperty('defaultCamZoom',0.67)
		end
		if curStep == 368 then
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 376 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 384 then
			setProperty('defaultCamZoom',0.9)
		end
		if curStep == 391 then
			setProperty('defaultCamZoom',0.67)
		end
		if curStep == 456 then
			setProperty('blk.alpha', 1)
			doTweenAlpha('END1','scoreTxt', 0, 0.02,'linear')
			doTweenAlpha('END2','iconP1', 0, 0.02,'linear')
			doTweenAlpha('END3','iconP2', 0, 0.02,'linear')
			doTweenAlpha('END4','healthBar', 0, 0.02,'linear')
			doTweenAlpha('END5','healthBarBG', 0, 0.02,'linear')
			doTweenAlpha('END6','timeBar', 0, 0.02,'linear')
			doTweenAlpha('END7','timeBarBG', 0, 0.02,'linear')
			doTweenAlpha('END8','timeTxt', 0, 0.02,'linear')
			setProperty('botplayTxt.visible', false)
			noteTweenAlpha('OpponentStrums0',0 ,0 ,0.02, 'linear')
			noteTweenAlpha('OpponentStrums1',1 ,0 ,0.02, 'linear')
			noteTweenAlpha('OpponentStrums2',2 ,0 ,0.02, 'linear')
			noteTweenAlpha('OpponentStrums3',3 ,0 ,0.02, 'linear')
			noteTweenAlpha('playerStrums0',4 ,0 ,0.02, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,0.02, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,0.02, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,0.02, 'linear')
		end
		if curStep == 471 then
			doTweenAlpha('blk3','blk', 0, 0.2,'linear')
			doTweenAlpha('END1','scoreTxt', 1, 0.5,'quadInOut')
			doTweenAlpha('END2','iconP1', 1, 0.5,'quadInOut')
			doTweenAlpha('END3','iconP2', 1, 0.5,'quadInOut')
			doTweenAlpha('END4','healthBar', 1, 0.5,'quadInOut')
			doTweenAlpha('END5','healthBarBG', 1, 0.5,'quadInOut')
			doTweenAlpha('END6','timeBar', 1, 0.5,'quadInOut')
			doTweenAlpha('END7','timeBarBG', 1, 0.5,'quadInOut')
			doTweenAlpha('END8','timeTxt', 1, 0.5,'quadInOut')
			setProperty('botplayTxt.visible', true)
			
			noteTweenAlpha('OpponentStrums0',0 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('OpponentStrums1',1 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('OpponentStrums2',2 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('OpponentStrums3',3 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('playerStrums0',4 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('playerStrums1',5 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('playerStrums2',6 ,1 ,0.5, 'quadInOut')
			noteTweenAlpha('playerStrums3',7 ,1 ,0.5, 'quadInOut')
		end
		if curStep == 590 then
			doTweenAlpha('planets','planets', 0, 1.55,'linear')
			doTweenAlpha('sky','sky', 0, 1.55,'linear')
			doTweenAlpha('terrain','terrain', 0, 1.55,'linear')
			doTweenAlpha('floor','floor', 1, 1.55,'linear')
			doTweenAlpha('dad','dadGroup', 0.5, 1.55,'linear')
			doTweenAlpha('bf','boyfriendGroup', 0.5, 1.55,'linear')
			doTweenAlpha('END1','scoreTxt', 0, 1.55,'linear')
			doTweenAlpha('END2','iconP1', 0, 1.55,'linear')
			doTweenAlpha('END3','iconP2', 0, 1.55,'linear')
			doTweenAlpha('END4','healthBar', 0, 1.55,'linear')
			doTweenAlpha('END5','healthBarBG', 0, 1.55,'linear')
			doTweenAlpha('END6','timeBar', 0, 1.55,'linear')
			doTweenAlpha('END7','timeBarBG', 0, 1.55,'linear')
			doTweenAlpha('END8','timeTxt', 0, 1.55,'linear')
		end
		if curStep == 672 then
			setProperty('planets.alpha', 1)
			setProperty('xterion.alpha', 1)
			setProperty('sky.alpha', 1)
			setProperty('terrain.alpha', 1)
			setProperty('floor.alpha', 0)
			setProperty('dadGroup.alpha', 1)
			setProperty('boyfriendGroup.alpha', 1)
			doTweenAlpha('END1','scoreTxt', 1, 0.2,'linear')
			doTweenAlpha('END2','iconP1', 1, 0.2,'linear')
			doTweenAlpha('END3','iconP2', 1, 0.2,'linear')
			doTweenAlpha('END4','healthBar', 1, 0.2,'linear')
			doTweenAlpha('END5','healthBarBG', 1, 0.2,'linear')
			doTweenAlpha('END6','timeBar', 1, 0.2,'linear')
			doTweenAlpha('END7','timeBarBG', 1, 0.2,'linear')
			doTweenAlpha('END8','timeTxt', 1, 0.2,'linear')
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
			if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
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