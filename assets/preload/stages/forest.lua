local xx = 1080;
local yy = 1150;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1275;
local yy2 = 1180;
local followchars = true;
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('ground', 'bgs/amy/ground', 0, 0);
		scaleObject('ground', 1, 1);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false);
		
		makeLuaSprite('bgtrees', 'bgs/amy/bg-trees', 0, 0);
		scaleObject('bgtrees', 1, 1);
		setScrollFactor('bgtrees', 1, 1);
		setProperty('bgtrees.antialiasing', true);
		addLuaSprite('bgtrees', false);
		
		makeLuaSprite('fgtrees', 'bgs/amy/fg-trees', 0, 0);
		scaleObject('fgtrees', 1, 1);
		setScrollFactor('fgtrees', 1, 1);
		setProperty('fgtrees.antialiasing', true);
		addLuaSprite('fgtrees', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('fgfg', 'bgs/amy/fgfg', -35, 20);
			scaleObject('fgfg', 1, 1);
			setScrollFactor('fgfg', 0.95, 1);
			setProperty('fgfg.antialiasing', true);
			addLuaSprite('fgfg', true);
			
			makeLuaSprite('fg', 'bgs/amy/fg', -90, 400);
			scaleObject('fg', 1, 0.8);
			setScrollFactor('fg', 0.84, 1);
			setProperty('fg.antialiasing', true);
			addLuaSprite('fg', true);
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