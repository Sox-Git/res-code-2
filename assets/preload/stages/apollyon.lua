local xx = 550;
local yy = 550;
local ofs = 10;
local ofs2 = 10;
local xx2 = 700;
local yy2 = 550;
local followchars = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/apollyon-p3/sky', -1000, -400);
		scaleObject('sky', 1.4, 1.4);
		setScrollFactor('sky', 0, 0);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('moon', 'bgs/apollyon-p3/moon', -850, -400);
			scaleObject('moon', 1.3, 1.3);
			setScrollFactor('moon', 0.1, 0.1);
			setProperty('moon.antialiasing', true);
			addLuaSprite('moon', false);
			
			makeLuaSprite('mountins', 'bgs/apollyon-p3/mountins', -800, -250);
			scaleObject('mountins', 1.3, 1.3);
			setScrollFactor('mountins', 0.1, 1);
			setProperty('mountins.antialiasing', true);
			addLuaSprite('mountins', false);
			
			makeLuaSprite('bg', 'bgs/apollyon-p3/bg', -900, -400);
			scaleObject('bg', 1.3, 1.3);
			setScrollFactor('bg', 0.4, 0.7);
			setProperty('bg.antialiasing', true);
			addLuaSprite('bg', false);
		end
		
		makeLuaSprite('ground', 'bgs/apollyon-p3/ground', -1000, -400);
		scaleObject('ground', 1.5, 1.4);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('FRock1', 'bgs/apollyon-p3/FRock1', -900, -600);
			scaleObject('FRock1', 1.4, 1.4);
			setScrollFactor('FRock1', 0.7, 0.4);
			setProperty('FRock1.antialiasing', true);
			addLuaSprite('FRock1', true);
			
			makeLuaSprite('FRock', 'bgs/apollyon-p3/FRock', -1000, -600);
			scaleObject('FRock', 1.4, 1.4);
			setScrollFactor('FRock', 0.4, 0.4);
			setProperty('FRock.antialiasing', true);
			addLuaSprite('FRock', true);
		end
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "broken-heart" then
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