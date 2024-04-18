local xx = 600;
local yy = 100;
local ofs = 0;
local ofs2 = 10;
local xx2 = 600;
local yy2 = 100;
local followchars = true;
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('city', 'bgs/fof/city', -145, -300);
		scaleObject('city', 1.2, 1.2);
		setScrollFactor('city', 0.5, 0.5);
		setProperty('city.antialiasing', true);
		addLuaSprite('city', false);
		
		makeLuaSprite('bg', 'bgs/fof/bg', -145, -450);
		scaleObject('bg', 1.2, 1.2);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		makeLuaSprite('table', 'bgs/fof/table', -165, -450);
		scaleObject('table', 1.2, 1.2);
		setScrollFactor('table', 1, 1);
		setProperty('table.antialiasing', true);
		addLuaSprite('table', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('mrcrabs', 'bgs/fof/mrcrabs', -145, -450);
			scaleObject('mrcrabs', 1.2, 1.2);
			setScrollFactor('mrcrabs', 1, 1);
			setProperty('mrcrabs.antialiasing', true);
			addLuaSprite('mrcrabs', false);
		end
		
		if getPropertyFromClass('ClientPrefs', 'gore') == true then
			makeLuaSprite('sonic', 'bgs/fof/sonic', -145, -450);
			scaleObject('sonic', 1.2, 1.2);
			setScrollFactor('sonic', 0.95, 1);
			setProperty('sonic.antialiasing', true);
			addLuaSprite('sonic', false);
		end
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('tv', 'bgs/fof/tv', 542, -418);
			addAnimationByPrefix('tv', 'idle', 'idle', 24, true);
			objectPlayAnimation('tv', 'idle', true)
			scaleObject('tv', 1.2, 1.2);
			setScrollFactor('tv', 0.95, 1);
			setProperty('tv.antialiasing', true);
			addLuaSprite('tv', false);

			makeLuaSprite('fishF1', 'bgs/fof/fishF1', -145, -450);
			scaleObject('fishF1', 1.2, 1.2);
			setScrollFactor('fishF1', 0.95, 1);
			setProperty('fishF1.antialiasing', true);
			addLuaSprite('fishF1', false);
		end
		
		makeLuaSprite('light', 'bgs/fof/light', -350, -450);
		scaleObject('light', 1.2, 1.2);
		setScrollFactor('light', 0.95, 1);
		setProperty('light.antialiasing', true);
		setBlendMode('light','ADD')
		setProperty('light.alpha', 0.75)
		addLuaSprite('light', false);
		
		makeLuaSprite('vinevrom', 'bgs/fof/vinevrom', -90, 400);
		scaleObject('vinevrom', 1, 0.8);
		setScrollFactor('vinevrom', 0.84, 1);
		setProperty('vinevrom.antialiasing', true);
		setObjectCamera('vinevrom', 'camHUD')
		setGraphicSize('vinevrom', 1280, 720)
		screenCenter('vinevrom')
		addLuaSprite('vinevrom', true);
	end
	
	makeLuaSprite('redthing', '', 0, 0);
	makeGraphic('redthing',1920,1080,'FF0000')
	setLuaSpriteScrollFactor('redthing',0,0)
	setProperty('redthing.scale.x',2)
	setProperty('redthing.scale.y',2)
	setObjectCamera('redthing', 'camHUD')
	setGraphicSize('redthing', 1280, 720)
	setBlendMode('redthing','MULTIPLY')
	addLuaSprite('redthing', true);
	setProperty('redthing.alpha',0)
end

function starvedLights()
	doTweenAlpha('lightBye','light',0,1,'linear')
	doTweenAlpha('cityBye','city',0,1,'linear')
	doTweenAlpha('bgBye','bg',0,1,'linear')
	doTweenAlpha('tableBye','table',0,1,'linear')
	doTweenAlpha('mrcrabsBye','mrcrabs',0,1,'linear')
	doTweenAlpha('tvBye','tv',0,1,'linear')
	doTweenAlpha('fishF1Bye','fishF1',0,1,'linear')
	doTweenAlpha('redthingHi','redthing',1,1,'linear')
end

function starvedLightsFinale()
	doTweenAlpha('lightHi','light',1,1,'linear')
	doTweenAlpha('cityHi','city',1,1,'linear')
	doTweenAlpha('bgHi','bg',1,1,'linear')
	doTweenAlpha('tableHi','table',1,1,'linear')
	doTweenAlpha('mrcrabsHi','mrcrabs',1,1,'linear')
	doTweenAlpha('tvHi','tv',1,1,'linear')
	doTweenAlpha('fishF1Hi','fishF1',1,1,'linear')
	doTweenAlpha('redthingBye','redthing',0,1,'linear')
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 123)
	
	if songName == "fight-or-flight" then
		if curStep == 1184 or curStep == 1471 then
			starvedLights();
		end
		if curStep == 1439 or curStep == 1983 then
			starvedLightsFinale();
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