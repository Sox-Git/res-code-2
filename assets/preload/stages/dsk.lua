local xx = 400;
local yy = 500;
local ofs = 15;
local ofs2 = 15;
local xx2 = 700;
local yy2 = 500;
local followchars = true;
local zoom = -1;

function onCreate()
	makeLuaSprite('FG1', 'bgs/dsk/FG1', -750, -550);
	scaleObject('FG1', 1, 1);
	setScrollFactor('FG1', 0.7, 0.9);
	setProperty('FG1.antialiasing', true);
	addLuaSprite('FG1', true);
	
	makeLuaSprite('sky', 'bgs/dsk/sky', -750, -200);
	scaleObject('sky', 1.5, 1.5);
	setScrollFactor('sky', 0.5, 0.7);
	setProperty('sky.antialiasing', true);
	addLuaSprite('sky', false);
	
	makeLuaSprite('rock1', 'bgs/dsk/rock1', -800, -440);
	scaleObject('rock1', 1, 0.9);
	setScrollFactor('rock1', 0.5, 1);
	setProperty('rock1.antialiasing', true);
	addLuaSprite('rock1', false);
	
	makeLuaSprite('rock2', 'bgs/dsk/rock2', -800, -440);
	scaleObject('rock2', 1, 0.9);
	setScrollFactor('rock2', 0.6, 1);
	setProperty('rock2.antialiasing', true);
	addLuaSprite('rock2', false);
	
	makeLuaSprite('rock3', 'bgs/dsk/rock3', -800, -440);
	scaleObject('rock3', 1, 0.9);
	setScrollFactor('rock3', 0.7, 1);
	setProperty('rock3.antialiasing', true);
	addLuaSprite('rock3', false);
	
	makeLuaSprite('rock4', 'bgs/dsk/rock4', -800, -440);
	scaleObject('rock4', 1, 0.9);
	setScrollFactor('rock4', 0.9, 1);
	setProperty('rock4.antialiasing', true);
	addLuaSprite('rock4', false);
	
	makeLuaSprite('tree1', 'bgs/dsk/tree1', -800, -480);
	scaleObject('tree1', 1, 0.9);
	setScrollFactor('tree1', 1, 1);
	setProperty('tree1.antialiasing', true);
	addLuaSprite('tree1', false);
	
	makeLuaSprite('tree2', 'bgs/dsk/tree2', -800, -480);
	scaleObject('tree2', 1, 0.9);
	setScrollFactor('tree2', 1, 1);
	setProperty('tree2.antialiasing', true);
	addLuaSprite('tree2', false);
	
	makeLuaSprite('floor', 'bgs/dsk/floor', -800, -480);
	scaleObject('floor', 1, 0.9);
	setScrollFactor('floor', 1, 1);
	setProperty('floor.antialiasing', true);
	addLuaSprite('floor', false);
	
	makeLuaSprite('flashRed', '', 0, 0);
	makeGraphic('flashRed',1920,1080,'FF0000')
	addLuaSprite('flashRed', true);
	setLuaSpriteScrollFactor('flashRed',0,0)
	setProperty('flashRed.scale.x',2)
	setProperty('flashRed.scale.y',2)
	setProperty('flashRed.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onUpdate(elapsed)
	if zoom == -1 then
		doTweenZoom('zoom1', 'camGame',0.57, 0.1, 'quadInOut')
	end
	if zoom == 0 then
		doTweenZoom('zoom2', 'camGame',0.7, 0.1, 'quadInOut')
	end
	if zoom == 1 then
		doTweenZoom('zoom3', 'camGame',0.85, 0.1, 'quadInOut')
	end

	if songName == "miasma" then
		if curStep == 0 then
			setProperty('camHUD.alpha', 0);
		end
		if curStep == 50 then
			noteTweenAlpha('opponentStrums0',0 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,0.5 ,0.005, 'linear')
			
			noteTweenAlpha('playerStrums0',4 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0.5 ,0.005, 'linear')
		end
		if curStep == 53 then
			doTweenAlpha('cam0','camHUD',1,1,'linear')
		end
		if curStep == 128 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash1','flashingshit',0,1,'linear')
			
		end
		if curStep == 256 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash1','flashingshit',0,1,'linear')
			
			zoom = 1;
		end
		if curStep == 512 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash1','flashingshit',0,1,'linear')
		end
		if curStep == 512 or curStep == 544 or curStep == 576 or curStep == 608 then
			zoom = 0;
		end
		if curStep == 528 or curStep == 560 or curStep == 592 or curStep == 624  then
			zoom = 1;
		end
		if curStep == 641 then
			
		end
		if curStep == 645 then
			zoom = -1;
		end
		if curStep == 896 then
			zoom = 0;
		end
		if curStep == 1024 then
			
			zoom = 1;
		end
		if curStep == 1156 then
			
			zoom = 0;
		end
		if curStep == 1408 then
			
			zoom = -1;
			doTweenAlpha('cam1','camHUD',0,1,'linear')
			doTweenAlpha('bl','Blacky',1,1,'linear')
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
            if getProperty('boyfriend.animation.curAnim.name') == 'hey' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
        triggerEvent('Camera Follow Pos','','')
	end
end