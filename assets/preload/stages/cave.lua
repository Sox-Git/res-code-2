local xx = 640;
local yy = 1200;
local ofs = 40;
local ofs2 = 40;
local xx2 = 800;
local yy2 = 1200;
local followchars = true;

local leftSpike = false;
local rightSpike = false;
local leftBF = true;
local rightBF = false;
local oaoaoaoONE = false;
local oaoaoaoTWO = false;
local mechanicTime = false;
local canMove = false;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('circus', 'bgs/cave/circus-cave', -500, 150);
		scaleObject('circus', 0.35, 0.35);
		setScrollFactor('circus', 0.4, 0.7);
		setProperty('circus.antialiasing', true);
		addLuaSprite('circus', false)
		
		makeLuaSprite('water', 'bgs/cave/water-cave', -500, 200);
		scaleObject('water', 0.35, 0.35);
		setScrollFactor('water', 0.7, 0.75);
		setProperty('water.antialiasing', true);
		addLuaSprite('water', false)
		
		makeLuaSprite('cave', 'bgs/cave/cave', -400, 250);
		scaleObject('cave', 0.35, 0.35);
		setScrollFactor('cave', 1, 1);
		setProperty('cave.antialiasing', true);
		addLuaSprite('cave', false)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('caveFG', 'bgs/cave/fg', -350, 70);
			scaleObject('caveFG', 0.35, 0.35);
			setScrollFactor('caveFG', 0.8, 0.8);
			setProperty('caveFG.antialiasing', true);
			addLuaSprite('caveFG', true)
		end
	end
	makeLuaSprite('night', '', 0, 0);
	makeGraphic('night',1920,1080,'000000')
	addLuaSprite('night', true);
	setLuaSpriteScrollFactor('night',0,0)
	setProperty('night.scale.x',2)
	setProperty('night.scale.y',2)
	setProperty('night.alpha',0.4)
	
	makeLuaSprite('UI', 'bgs/cave/ui', 0, 0);
	setScrollFactor('UI', 0, 0);
	scaleObject('UI', 1, 1);
	setProperty('UI.antialiasing', true);
	addLuaSprite('UI', false)
	setObjectCamera('UI', 'camHUD')
	
	makeLuaSprite('UIYOUL', 'bgs/cave/ui-player', -70, 0);
	setScrollFactor('UIYOUL', 0, 0);
	scaleObject('UIYOUL', 1, 1);
	setProperty('UIYOUL.antialiasing', true);
	addLuaSprite('UIYOUL', false)
	setObjectCamera('UIYOUL', 'camHUD')
	
	makeLuaSprite('UIYOUR', 'bgs/cave/ui-player', 0, 0);
	setScrollFactor('UIYOUR', 0, 0);
	scaleObject('UIYOUR', 1, 1);
	setProperty('UIYOUR.antialiasing', true);
	addLuaSprite('UIYOUR', false)
	setObjectCamera('UIYOUR', 'camHUD')
	setProperty('UIYOUR.alpha',0)
	
	precacheImage('bgs/cave/spike_rock');
	precacheImage('bgs/cave/note-warn');
	precacheImage('bgs/cave/warning');
end

function Warning()
	canMove = true;
	
	if getRandomInt(1,2) == 1 then 
		leftSpike = true;
		rightSpike = false;
	else
		if getRandomInt(1,2) == 2 then 
			leftSpike = false;
			rightSpike = true;
		end
	end

	makeLuaSprite('warning', 'bgs/cave/warning', 0, 0);
	setScrollFactor('warning', 0, 0);
	scaleObject('warning', 1, 1);
	setProperty('warning.antialiasing', true);
	addLuaSprite('warning', false)
	setObjectCamera('warning', 'camHUD')
	
	if (leftSpike) then
		makeLuaSprite('spikeUI', 'bgs/cave/ui-spike', -70, 0);
	else
		if (rightSpike) then
			makeLuaSprite('spikeUI', 'bgs/cave/ui-spike', 0, 0);
		end
	end
	setScrollFactor('spikeUI', 0, 0);
	scaleObject('spikeUI', 1, 1);
	setProperty('spikeUI.antialiasing', true);
	addLuaSprite('spikeUI', false)
	setObjectCamera('spikeUI', 'camHUD')
	runTimer('THX', 1.5, 1)
	
	setProperty('warning.alpha',1)
	doTweenAlpha('warningTweenAlpha','warning',0,0.75,'linear')
	
	warnNote();
end

function spikeMechanic()
	mechanicTime = true;
	if mechanicTime then 
		if (leftSpike) then
			makeLuaSprite('spike', 'bgs/cave/spike_rock', 1000, 200);
		else
			if (rightSpike) then
				makeLuaSprite('spike', 'bgs/cave/spike_rock', 1300, 200);
			end
		end
		
		scaleObject('spike', 1, 1);
		setScrollFactor('spike', 1, 1);
		setProperty('spike.antialiasing', true);
		addLuaSprite('spike', false)
		
		doTweenY('spikeTween', 'spike', "1000", 0.4, 'quadIn');
	end
end

function warnNote()
	if canMove then 
		if (leftSpike) then
			makeLuaSprite('warn', 'bgs/cave/note-warn', 900, 1300);
		else
			if (rightSpike) then
				makeLuaSprite('warn', 'bgs/cave/note-warn', 1200, 1300);
			end
		end
		
		setScrollFactor('warn', 1, 1);
		scaleObject('warn', 1.5, 1.5);
		setProperty('warn.antialiasing', true);
		addLuaSprite('warn', true)
		
		setProperty('warn.alpha',1)
		doTweenAlpha('warnTweenAlpha','warn',0,0.5,'linear')
	end
end

function onTweenCompleted(tag)
	if tag == 'spikeTween' then
		if (leftSpike) and (leftBF) then
			setProperty('health', 0);
		end
		if (rightSpike) and (rightBF) then
			setProperty('health', 0);
		end
		
		if (leftSpike) and (rightBF) then
			doTweenY('spikeTweenDown', 'spike', "1300", 0.15, 'quadIn');
			doTweenAlpha('spikeTweenAlpha','spike',0,0.4,'linear')
		end
		if (rightSpike) and (leftBF) then
			doTweenY('spikeTweenDown', 'spike', "1300", 0.15, 'quadIn');
			doTweenAlpha('spikeTweenAlpha','spike',0,0.4,'linear')
		end
	end
	
	if tag == 'spikeTweenDown' then
		removeLuaSprite('spike', false);
		mechanicTime = false;
		canMove = false;
	end
	
	if tag == 'warningTweenAlpha' then
		spikeMechanic();
		removeLuaSprite('warning', false);
	end
	
	if tag == 'warnTweenAlpha' then
		setProperty('warn.alpha',1)
		doTweenAlpha('warnTweenAlphaa','warn',0,0.5,'linear')
	end
	
	if tag == 'warnTweenAlphaa' then
		setProperty('warn.alpha',1)
		doTweenAlpha('warnTweenAlphaaa','warn',0,0.5,'linear')
	end
	
	if tag == 'warnTweenAlphaaa' then
		removeLuaSprite('warn', false);
	end
end

function onTimerCompleted(tag)
	if tag == 'jeez1' then
		oaoaoaoONE = false;
	end
	if tag == 'jeez2' then
		oaoaoaoTWO = false;
	end
	if tag == 'aaaa1' then
		doTweenX('boyfriendTween', 'boyfriend', 800, 0.2, 'quadOut');
	end
	if tag == 'aaaa2' then
		doTweenX('boyfriendTween', 'boyfriend', 1050, 0.2, 'quadOut');
	end
	if tag == 'THX' then
		doTweenAlpha('heh','spikeUI',0,1,'linear')
	end
end

function onUpdate()
	if songName == "coulrophobia" then
		if curStep == 256 or curStep == 384 or curStep == 512 or curStep == 768 or curStep == 816 or curStep == 1024 or curStep == 1152 or curStep == 1280 or curStep == 1440 or curStep == 1552 then
			Warning();
		end
	end
	
	if canMove then
		if rightBF and oaoaoaoTWO == false then
			if keyJustPressed('space') then
				leftBF = true;
				rightBF = false;
				setProperty('UIYOUL.alpha',1)
				setProperty('UIYOUR.alpha',0)
				triggerEvent('Play Animation','dodgeR','bf')
				runTimer('aaaa1', 0.2, 1)
				oaoaoaoONE = true;
				runTimer('jeez1', 0.03, 1)
			end
		end
		
		if leftBF and oaoaoaoONE == false then
			if keyJustPressed('space') then
				rightBF = true;
				leftBF = false;
				setProperty('UIYOUL.alpha',0)
				setProperty('UIYOUR.alpha',1)
				triggerEvent('Play Animation','dodgeR','bf')
				runTimer('aaaa2', 0.2, 1)
				oaoaoaoTWO = true;
				runTimer('jeez2', 0.03, 1)
			end
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

			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
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

            if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeR' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeL' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
    
end