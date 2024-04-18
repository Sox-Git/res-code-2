local xx = 450;
local yy = 490;
local ofs = 15;
local ofs2 = 15;
local xx2 = 800;
local yy2 = 490;
local followchars = true;
local zero = true;

function onCreate()
	makeLuaSprite('FG', 'bgs/you-cant-run/FG', -675, -295);
	scaleObject('FG', 0.82, 0.8);
	setScrollFactor('FG', 0.7, 0.9);
	setProperty('FG.antialiasing', true);
	addLuaSprite('FG', true);
	
	makeLuaSprite('crystallFG', 'bgs/you-cant-run/crystallFG', -675, -295);
	scaleObject('crystallFG', 0.82, 0.8);
	setScrollFactor('crystallFG', 0.7, 0.9);
	setProperty('crystallFG.antialiasing', true);
	addLuaSprite('crystallFG', true);
	
	makeLuaSprite('sky', 'bgs/you-cant-run/sky', -750, -500);
	scaleObject('sky', 1.2, 1.2);
	setScrollFactor('sky', 0.6, 0.9);
	setProperty('sky.antialiasing', true);
	addLuaSprite('sky', false);
	
	makeLuaSprite('hill2', 'bgs/you-cant-run/hill2', -700, -650);
	scaleObject('hill2', 1, 1);
	setScrollFactor('hill2', 0.7, 0.9);
	setProperty('hill2.antialiasing', true);
	addLuaSprite('hill2', false);
	
	makeLuaSprite('hill1', 'bgs/you-cant-run/hill1', -700, -650);
	scaleObject('hill1', 1, 1);
	setScrollFactor('hill1', 0.8, 0.9);
	setProperty('hill1.antialiasing', true);
	addLuaSprite('hill1', false);	
			
	makeLuaSprite('crystallBG', 'bgs/you-cant-run/crystallBG', -700, -650);
	scaleObject('crystallBG', 1, 1);
	setScrollFactor('crystallBG', 0.7, 1);
	setProperty('crystallBG.antialiasing', true);
	addLuaSprite('crystallBG', false);
	
	makeLuaSprite('trees', 'bgs/you-cant-run/trees', -700, -650);
	scaleObject('trees', 1, 1);
	setScrollFactor('trees', 0.7, 1);
	setProperty('trees.antialiasing', true);
	addLuaSprite('trees', false);
	
	makeLuaSprite('bush', 'bgs/you-cant-run/bush', -700, -650);
	scaleObject('bush', 1, 1);
	setScrollFactor('bush', 0.9, 1);
	setProperty('bush.antialiasing', true);
	addLuaSprite('bush', false);
	
	makeLuaSprite('floor', 'bgs/you-cant-run/floor', -700, -650);
	scaleObject('floor', 1, 1);
	setScrollFactor('floor', 1, 1);
	setProperty('floor.antialiasing', true);
	addLuaSprite('floor', false);
	
	makeAnimatedLuaSprite('GHZ_SKY', 'bgs/you-cant-run/GHZ_SKY', -1500, -550);
	addAnimationByPrefix('GHZ_SKY', 'idle', 'GHZ_SKY idle', 12, true);
	scaleObject('GHZ_SKY', 7, 7);
	setScrollFactor('GHZ_SKY', 0.8, 0.8);
	setProperty('GHZ_SKY.antialiasing', false);
	addLuaSprite('GHZ_SKY', false);
	
	if getPropertyFromClass('ClientPrefs', 'gore') == true then
		makeLuaSprite('GHZ', 'bgs/you-cant-run/GHZ_dead', -1500, -50);
		scaleObject('GHZ', 6, 6);
		setScrollFactor('GHZ', 1, 1);
		setProperty('GHZ.antialiasing', false);
		addLuaSprite('GHZ', false);
	else
		makeLuaSprite('GHZ', 'bgs/you-cant-run/GHZ', -1500, -50);
		scaleObject('GHZ', 6, 6);
		setScrollFactor('GHZ', 1, 1);
		setProperty('GHZ.antialiasing', false);
		addLuaSprite('GHZ', false);
	end
	
	makeAnimatedLuaSprite('GHZ_NIGHTSKY', 'bgs/you-cant-run/GHZ_NIGHTSKY', -1500, -550);
	addAnimationByPrefix('GHZ_NIGHTSKY', 'idle', 'GHZ_NIGHTSKY idle', 12, true);
	scaleObject('GHZ_NIGHTSKY', 7, 7);
	setScrollFactor('GHZ_NIGHTSKY', 0.8, 0.8);
	setProperty('GHZ_NIGHTSKY.antialiasing', false);
	addLuaSprite('GHZ_NIGHTSKY', false);
	
	if getPropertyFromClass('ClientPrefs', 'gore') == true then
		makeLuaSprite('GHZ_Night', 'bgs/you-cant-run/GHZ_dead_night', -1500, -50);
		scaleObject('GHZ_Night', 6, 6);
		setScrollFactor('GHZ_Night', 1, 1);
		setProperty('GHZ_Night.antialiasing', false);
		addLuaSprite('GHZ_Night', false);
	else
		makeLuaSprite('GHZ_Night', 'bgs/you-cant-run/GHZ_Night', -1500, -50);
		scaleObject('GHZ_Night', 6, 6);
		setScrollFactor('GHZ_Night', 1, 1);
		setProperty('GHZ_Night.antialiasing', false);
		addLuaSprite('GHZ_Night', false);
	end
	
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	setLuaSpriteScrollFactor('black',0,0)
	setObjectCamera('black', 'camOther')
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	
	setProperty('FG.alpha', 1)
	setProperty('crystallFG.alpha', 0)
	setProperty('sky.alpha', 1)
	setProperty('hill2.alpha', 1)
	setProperty('hill1.alpha', 1)
	setProperty('crystallBG.alpha', 0)
	setProperty('trees.alpha', 1)
	setProperty('bush.alpha', 1)
	setProperty('floor.alpha', 1)
	setProperty('GHZ_SKY.alpha', 0)
	setProperty('GHZ.alpha', 0)
	setProperty('GHZ_NIGHTSKY.alpha', 0)
	setProperty('GHZ_Night.alpha', 0)
	setProperty('black.alpha',0)
end

function opponentNoteHit()
	if zero == true then
		cameraShake('game', 0.005, 0.05)
	end
	if zero == false then
		cameraShake('game', 0, 0.05)
	end
end		

function onUpdate(elapsed)
	if songName == "you-cant-run" then
		if curStep == 528 then
			zero = false;
			yy = 700;
			xx = 500;
			yy2 = 700;
			setProperty('defaultCamZoom',0.7)
			setProperty('FG.alpha', 0)
			setProperty('sky.alpha', 0)
			setProperty('hill2.alpha', 0)
			setProperty('hill1.alpha', 0)
			setProperty('trees.alpha', 0)
			setProperty('bush.alpha', 0)
			setProperty('floor.alpha', 0)
			setProperty('GHZ_SKY.alpha', 1)
			setProperty('GHZ.alpha', 1)
			setProperty('boyfriend.y',750)
			setProperty('boyfriend.x',1300)
			setProperty('gf.y',535)
			setProperty('gf.x',630)			--y535 x560
			setProperty('dad.y',660)
			setProperty('dad.x',-120)
		end
		if curStep == 656 then
			setProperty('GHZ_SKY.alpha', 0)
			setProperty('GHZ.alpha', 0)
			setProperty('GHZ_NIGHTSKY.alpha', 1)
			setProperty('GHZ_Night.alpha', 1)
		end
		if curStep == 784 then
			zero = true;
			yy = 490;
			xx = 450;
			yy2 = 490;
			setProperty('defaultCamZoom',0.55)
			setProperty('crystallFG.alpha', 1)
			setProperty('crystallBG.alpha', 1)
			setProperty('FG.alpha', 1)
			setProperty('sky.alpha', 1)
			setProperty('hill2.alpha', 1)
			setProperty('hill1.alpha', 1)
			setProperty('trees.alpha', 1)
			setProperty('bush.alpha', 1)
			setProperty('floor.alpha', 1)
			setProperty('GHZ_NIGHTSKY.alpha', 0)
			setProperty('GHZ_Night.alpha', 0)
		end
		if curStep == 1407 then
			zero = false;
		end
		if curStep == 1423 then
			doTweenAlpha('black','black',0.4,4,'linear')
		end
		if curStep == 1439 then
			doTweenAlpha('black','black',1,2,'linear')
		end
	end
	
	if followchars == true then
        if mustHitSection == false then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'justdie' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end     
			if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'scream' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end        
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'laugh' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' or getProperty('dad.animation.curAnim.name') == 'end' then
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