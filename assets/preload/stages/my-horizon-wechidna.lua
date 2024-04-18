local xx = 1550;
local yy = 1625;
local xx2 = 1650;
local yy2 = 1625;
local ofs = 25;
local ofs2 = 25;
local followchars = true;
local wechBeastMoment = false;

function onCreate()
	if getProperty('boyfriend.curCharacter') == 'bf' then
		addCharacterToList('bf-scared', 'boyfriend');
	end
	if getProperty('boyfriend.curCharacter') == 'bf_merphi' then
		addCharacterToList('bf_merphi_chaos', 'boyfriend');
	end
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/Wechidna/sky', -820, -950);
		scaleObject('sky', 1.0, 1.0);
		setScrollFactor('sky', 0.1, 0.1);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false)
		
		makeLuaSprite('building', 'bgs/Wechidna/building', -600, -900);
		scaleObject('building', 1.0, 1.0);
		setScrollFactor('building', 0.3, 0.3);
		setProperty('building.antialiasing', true);
		addLuaSprite('building', false)
		
		makeLuaSprite('B', 'bgs/Wechidna/bg-building', -400, -600);
		scaleObject('B', 1.0, 1.0);
		setScrollFactor('B', 0.5, 0.5);
		setProperty('B.antialiasing', true);
		addLuaSprite('B', false)
		
		makeLuaSprite('floor', 'bgs/Wechidna/floor', 0, 0);
		scaleObject('floor', 1.0, 1.0);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false)
		
		makeLuaSprite('BGT', 'bgs/Wechidna/bg-trees', 0, 0);
		scaleObject('BGT', 1.0, 1.0);
		setScrollFactor('BGT', 1, 1);
		setProperty('BGT.antialiasing', true);
		addLuaSprite('BGT', false)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('BGG', 'bgs/Wechidna/bg-grass', 0, 0);
			scaleObject('BGG', 1.0, 1.0);
			setScrollFactor('BGG', 1, 1);
			setProperty('BGG.antialiasing', true);
			addLuaSprite('BGG', false)
			
			makeLuaSprite('BGS', 'bgs/Wechidna/bg-smth', 0, 0);
			scaleObject('BGS', 1.0, 1.0);
			setScrollFactor('BGS', 1, 1);
			setProperty('BGS.antialiasing', true);
			addLuaSprite('BGS', false)
		
			makeLuaSprite('FGT', 'bgs/Wechidna/fg-trees', -200, 0);
			scaleObject('FGT', 1.0, 1.0);
			setScrollFactor('FGT', 0.8, 1);
			setProperty('FGT.antialiasing', true);
			addLuaSprite('FGT', true)

			makeLuaSprite('FGS', 'bgs/Wechidna/fg-smth', -250, -125);
			scaleObject('FGS', 1.0, 1.0);
			setScrollFactor('FGS', 0.7, 0.9);
			setProperty('FGS.antialiasing', true);
			addLuaSprite('FGS', true)

			makeLuaSprite('FGG', 'bgs/Wechidna/fg-grass', -360, -240);
			scaleObject('FGG', 1.0, 1.0);
			setScrollFactor('FGG', 0.6, 0.8);
			setProperty('FGG.antialiasing', true);
			addLuaSprite('FGG', true)
		end
	end

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('bg', '', 0, 0);
	makeGraphic('bg',1920,1080,'000000')
	addLuaSprite('bg', true);
	setLuaSpriteScrollFactor('bg',0,0)
	setProperty('bg.scale.x',2)
	setProperty('bg.scale.y',2)
	setProperty('bg.alpha',1)
	
end

function onUpdate()
	if wechBeastMoment == true then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.5)
		else
			setProperty('defaultCamZoom',0.7)
		end
	end
	
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if curStep == 1 then
		doTweenAlpha('start','bg',0,0.5,'linear')
		setProperty('dad.color', getColorFromHex('FFBABA'))
		setProperty('boyfriend.color', getColorFromHex('FFBABA'))
		setProperty('gf.color', getColorFromHex('FFBABA'))
	end
    if curStep == 767 then
		doTweenAlpha('boom','bg',1,1.0,'linear')
		doTweenAlpha('ch1','camHUD',0,1.0,'linear')
	end    
	if curStep == 921 then
		doTweenAlpha('ch2','camHUD',1,0.4,'linear')
	end
    if curStep == 924 then
		setProperty('dad.color', getColorFromHex('FFBABA'))
		wechBeastMoment = true;
		setProperty('dad.y',430)
		setProperty('dad.x',140)
		xx = 1550;
		yy = 1350;
		xx2 = 1650;
		yy2 = 1650;
		setProperty('bg.alpha',0)
		setProperty('flashingshit.alpha',1)
		doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
		if getProperty('boyfriend.curCharacter') == 'bf' then
			triggerEvent('Change Character','bf','bf-scared')
		end
		if getProperty('boyfriend.curCharacter') == 'bf_merphi' then
			triggerEvent('Change Character','bf','bf_merphi_chaos')
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

            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
    
end