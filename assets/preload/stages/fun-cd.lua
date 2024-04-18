local xx = 880;
local yy = 750;
local ofs = 10;
local ofs2 = 10;
local xx2 = 1075;
local yy2 = 810;
local followchars = true;
local zoom = 1;
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/endless-us/bg', -200, 0);
		scaleObject('bg', 1.3, 1.3);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		makeLuaSprite('fun', 'bgs/endless-us/fun', 280, 0);
		scaleObject('fun', 0.7, 0.7);
		setScrollFactor('fun', 1, 0.5);
		setProperty('fun.antialiasing', true);
		setProperty('fun.alpha',0.8)
		addLuaSprite('fun', false);
		
		makeAnimatedLuaSprite('static', 'bgs/omw/staticOMW', -400, -400);
		scaleObject('static', 6, 6);
		addAnimationByPrefix('static', 'sshh', 'stat', 24, true);
		setScrollFactor('static', 0, 0);
		setProperty('static.antialiasing', false);
		setProperty('static.alpha',0.7)
		setBlendMode('static','MULTIPLY')
		addLuaSprite('static', false);
		
		makeLuaSprite('cd', 'bgs/endless-us/cd', 100, 50);
		scaleObject('cd', 0.9, 0.9);
		setScrollFactor('cd', 1, 1);
		setProperty('cd.antialiasing', true);
		addLuaSprite('cd', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('light', 'bgs/endless-us/light', 0, 0);
			addAnimationByPrefix('light', 'idle', 'light idle', 30, true);
			setProperty('light.antialiasing', true);
			addLuaSprite('light', true);
			setScrollFactor('light', 0, 0);
			setGraphicSize('light', 1920, 1080)
			screenCenter('light')
			setBlendMode('light','ADD')
			setProperty('light.alpha', 0.75)
		end
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if zoom == 1 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.68)
		else
			setProperty('defaultCamZoom',0.75)
		end
	end
	
	if songName == "endless-us" then
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