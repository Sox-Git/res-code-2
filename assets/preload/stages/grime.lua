local xx = 2000;
local yy = 1800;
local ofs = 15;
local ofs2 = 15;
local xx2 = 2450;
local yy2 = 1800;
local followchars = true;

function onCreate()
	addCharacterToList('grimeware','dad');

	makeLuaSprite('bg', 'bgs/grimeware/bg', -500, 630);
	scaleObject('bg', 1, 1);
	setScrollFactor('bg', 0.3, 1);
	setProperty('bg.antialiasing', true);
	addLuaSprite('bg', false);
	
	makeAnimatedLuaSprite('bgEyesLeft', 'bgs/grimeware/bg-eyes', 20, 800);
	scaleObject('bgEyesLeft', 1, 1);
	addAnimationByPrefix('bgEyesLeft', 'eyes', 'eyes', 24, true);
	setScrollFactor('bgEyesLeft', 0.3, 1);
	setProperty('bgEyesLeft.antialiasing', true);
	setProperty('bgEyesRight.alpha', 0.6);
	addLuaSprite('bgEyesLeft', false);
	
	makeAnimatedLuaSprite('bgEyesRight', 'bgs/grimeware/bg-eyes', 1800, 800);
	scaleObject('bgEyesRight', 1, 1);
	addAnimationByPrefix('bgEyesRight', 'eyes', 'eyes', 24, true);
	setScrollFactor('bgEyesRight', 0.3, 1);
	setProperty('bgEyesRight.antialiasing', true);
	setProperty('bgEyesRight.flipX', true);
	setProperty('bgEyesRight.alpha', 0.8);
	addLuaSprite('bgEyesRight', false);
	
	makeAnimatedLuaSprite('waterfall', 'bgs/grimeware/waterfall', 250, -4200);
	scaleObject('waterfall', 1, 1);
	addAnimationByPrefix('waterfall', 'waterfall', 'waterfall', 24, true);
	setScrollFactor('waterfall', 0.7, 1);
	setProperty('waterfall.antialiasing', true);
	addLuaSprite('waterfall', false);
	
	makeLuaSprite('ground', 'bgs/grimeware/ground', 700, 530);
	scaleObject('ground', 1, 1);
	setScrollFactor('ground', 1, 1);
	setProperty('ground.antialiasing', true);
	addLuaSprite('ground', false);
	
	makeLuaSprite('bgObj', 'bgs/grimeware/bg-objects', 700, 530);
	scaleObject('bgObj', 1, 1);
	setScrollFactor('bgObj', 1, 1);
	setProperty('bgObj.antialiasing', true);
	addLuaSprite('bgObj', false);
	
	makeLuaSprite('fgStones', 'bgs/grimeware/fg-stones', -400, -50);
	scaleObject('fgStones', 1.1, 1.1);
	setScrollFactor('fgStones', 0.5, 0.8);
	setProperty('fgStones.antialiasing', true);
	addLuaSprite('fgStones', true);
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onUpdate(elapsed)
	if songName == "envy" then
		if curStep == 512 then
			setProperty('defaultCamZoom',0.45)
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash','flashingshit',0,1,'linear')
			triggerEvent('Change Character', '1', 'grimeware');
			xx = 2200;
			yy = 1600;
			xx2 = 2400;
			yy2 = 1600;
			setProperty('waterfall.color', getColorFromHex('890000'))
			setProperty('bg.color', getColorFromHex('959595'))
		end
	end
	if songName == "gorefest" then
		if curStep == 0 then
		end
	end
	if songName == "lurk" then
		if curStep == 0 then
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