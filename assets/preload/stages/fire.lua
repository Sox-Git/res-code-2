local xDad = -600;
local yDad = 150;
local xBF = -100;
local yBF = 175;
local xGF = -450;
local yGF = 125;

local ofsDad = 30;
local ofsBF = 30;
local ofsGF = 30;

local cameraMoves = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/burning/bg', -1600, -950);
		scaleObject('bg', 1.5, 1.5);
		setScrollFactor('bg', 0, 0);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('trees3', 'bgs/burning/trees3', -2100, -950);
			scaleObject('trees3', 1.3, 1.3);
			setScrollFactor('trees3', 1, 1);
			setProperty('trees3.antialiasing', true);
			addLuaSprite('trees3', false);
			
			makeLuaSprite('trees2', 'bgs/burning/trees2', -2100, -950);
			scaleObject('trees2', 1.3, 1.3);
			setScrollFactor('trees2', 1, 1);
			setProperty('trees2.antialiasing', true);
			addLuaSprite('trees2', false);
		end
		
		makeLuaSprite('trees1', 'bgs/burning/trees1', -2100, -950);
		scaleObject('trees1', 1.3, 1.3);
		setScrollFactor('trees1', 1, 1);
		setProperty('trees1.antialiasing', true);
		addLuaSprite('trees1', false);
		
		makeLuaSprite('floor', 'bgs/burning/floor', -2100, -950);
		scaleObject('floor', 1.3, 1.3);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false);
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "burning" then
		if curStep == 0 then
		end
	end
	
	if cameraMoves == true then
        if mustHitSection == false then
			if gfSection == false then
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xDad-ofsDad,yDad)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xDad+ofsDad,yDad)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xDad,yDad-ofsDad)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xDad,yDad+ofsDad)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xDad,yDad)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xGF-ofsGF,yGF)
				end
				if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xGF+ofsGF,yGF)
				end
				if getProperty('gf.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xGF,yGF-ofsGF)
				end
				if getProperty('gf.animation.curAnim.name') == 'singUP-alt' then
					triggerEvent('Camera Follow Pos',xGF,yGF-ofsGF)
				end
				if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xGF,yGF+ofsGF)
				end
				if getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xGF,yGF)
				end
			end
        else
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xBF-ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xBF+ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xBF,yBF-ofsBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xBF,yBF+ofsBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
                triggerEvent('Camera Follow Pos',xBF-ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
                triggerEvent('Camera Follow Pos',xBF+ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
                triggerEvent('Camera Follow Pos',xBF,yBF-ofsBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
                triggerEvent('Camera Follow Pos',xBF,yBF+ofsBF)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xBF,yBF)
            end
        end
	end
end