local xx = 800;
local yy = 150;
local ofs = 10;
local ofs2 = 10;
local xx2 = 1200;
local yy2 = 200;
local followchars = true;
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('Sky', 'bgs/apollyon-p1/Sky', -950, -550);
		scaleObject('Sky', 5, 5);
		setScrollFactor('Sky', 1.0, 1.0);
		setProperty('Sky.antialiasing', false);
		addLuaSprite('Sky', false);
		
		makeLuaSprite('hill', 'bgs/apollyon-p1/Hilltop mountains', -950, -650);
		scaleObject('hill', 7, 7);
		setScrollFactor('hill', 0.95, 1.2);
		setProperty('hill.antialiasing', false);
		addLuaSprite('hill', false);
		
		makeLuaSprite('mount', 'bgs/apollyon-p1/Mountains_', 700, -590);
		scaleObject('mount', 7, 7);
		setScrollFactor('mount', 1.05, 1.2);
		setProperty('mount.antialiasing', false);
		addLuaSprite('mount', false);
		
		makeLuaSprite('side', 'bgs/apollyon-p1/One side', -2500, -700);
		scaleObject('side', 6, 6);
		setScrollFactor('side', 1.0, 1.0);
		setProperty('side.antialiasing', false);
		addLuaSprite('side', false);
		
		makeAnimatedLuaSprite('lova', 'bgs/apollyon-p1/lova', 1000, 500);
		addAnimationByPrefix('lova', 'idle', 'lova idle', 8, true);
		scaleObject('lova', 7, 7);
		setScrollFactor('lova', 1, 1);
		setProperty('lova.alpha', 1)
		setProperty('lova.antialiasing', false);
		addLuaSprite('lova', false);
		
		makeLuaSprite('main', 'bgs/apollyon-p1/Main Stage', -3000, -1850);
		scaleObject('main', 7.4, 7.4);
		setScrollFactor('main', 1.0, 1.0);
		setProperty('main.antialiasing', false);
		addLuaSprite('main', false);
		
		makeLuaSprite('blk', '', 0, 0);
		makeGraphic('blk',1920,1080,'000000')
		addLuaSprite('blk', true);
		screenCenter('blk')
		setLuaSpriteScrollFactor('blk',0,0)
		setProperty('blk.scale.x',4)
		setProperty('blk.scale.y',4)
		setProperty('blk.alpha',0)
		setObjectCamera('blk', 'camOther')
		
		runTimer('Side Down', 0.1, 1)
	end
end

function onTimerCompleted(tag)
	if tag == 'Side Up' then
		doTweenY('side-TweenUp', 'side', -700, 2.5, 'sineInOut')
		runTimer('Side Down', 2.5, 1)
	end
	if tag == 'Side Down' then
		doTweenY('side-TweenDown', 'side', -500, 2.5, 'sineInOut')
		runTimer('Side Up', 2.6, 1)
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "genesis" then 
		if curStep == 1936 then
			doTweenZoom('bom', 'camGame',0.9, 1.5, 'linear')
		end
		if curStep == 1950 then
			setProperty('blk.alpha', 1)
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