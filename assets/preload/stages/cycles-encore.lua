local xx = 1250;
local yy = 1350;
local xx2 = 1650;
local yy2 = 1550;
local ofs = 15;
local ofs2 = 15;
local followchars = true;
local zoom = 1

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/cycles-encore/BG', 0, 0);
		scaleObject('bg', 1.2, 1.2);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false)
		setProperty('bg.alpha',1)
		
		makeLuaSprite('TreesB2', 'bgs/cycles-encore/TreesB2', 0, 0);
		scaleObject('TreesB2', 1.2, 1.2);
		setScrollFactor('TreesB2', 1, 1);
		setProperty('TreesB2.antialiasing', true);
		addLuaSprite('TreesB2', false)
		setProperty('TreesB2.alpha', 1)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('Floor2', 'bgs/cycles-encore/Floor2', 0, 0);
			scaleObject('Floor2', 1.2, 1.2);
			setScrollFactor('Floor2', 1, 1);
			setProperty('Floor2.antialiasing', true);
			addLuaSprite('Floor2', false)
			setProperty('Floor2.alpha',1)
		end
		
		makeLuaSprite('TreesB1', 'bgs/cycles-encore/TreesB1', 0, 0);
		scaleObject('TreesB1', 1.2, 1.2);
		setScrollFactor('TreesB1', 1, 1);
		setProperty('TreesB1.antialiasing', true);
		addLuaSprite('TreesB1', false)
		setProperty('TreesB1.alpha',1)
		
		makeLuaSprite('Floor', 'bgs/cycles-encore/Floor', 0, 0);
		scaleObject('Floor', 1.2, 1.2);
		setScrollFactor('Floor', 1, 1);
		setProperty('Floor.antialiasing', true);
		addLuaSprite('Floor', false)
		setProperty('Floor.alpha',1)
		
		makeAnimatedLuaSprite('Alice', 'bgs/cycles-encore/Alice', 850, 1300);
		scaleObject('Alice', 1.0, 1.0);
		luaSpriteAddAnimationByIndices('Alice', 'left', 'idle', '0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14', '20')
		luaSpriteAddAnimationByIndices('Alice', 'right', 'idle', '15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29', '20');
		setProperty('Alice.antialiasing', true);
		addLuaSprite('Alice', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('FloorF1', 'bgs/cycles-encore/FloorF1', 0, 550);
			scaleObject('FloorF1', 1.2, 1.2);
			setScrollFactor('FloorF1', 1, 1);
			setProperty('FloorF1.antialiasing', true);
			addLuaSprite('FloorF1', true)
			setProperty('FloorF1.alpha',1)

			makeLuaSprite('TreesF1', 'bgs/cycles-encore/TreesF1', -320, -200);
			scaleObject('TreesF1', 1.2, 1.2);
			setScrollFactor('TreesF1', 0.7, 0.8);
			setProperty('TreesF1.antialiasing', true);
			addLuaSprite('TreesF1', true)
			setProperty('TreesF1.alpha',1)
		end
	end
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		if curBeat % 2 == 0 then
			if curBeat % 4 == 0 then
				objectPlayAnimation('Alice', 'left', false)
			else
				objectPlayAnimation('Alice', 'right', false)
			end
		end
	end
end

function onUpdate()
	if zoom == 1 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.5)
		else
			setProperty('defaultCamZoom',0.65)
		end
	end

	if songName == "cycles-encore" then
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
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
        triggerEvent('Camera Follow Pos','','')
	end
end