local xx = 1600;
local yy = 1400;
local ofs = 25;
local ofs2 = 25;
local xx2 = 1600;
local yy2 = 1400;
local followchars = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/knuckles_alt/bg', -600, 0);
		scaleObject('bg', 1, 1);
		setScrollFactor('bg', 0.4, 0.7);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		makeLuaSprite('hills', 'bgs/knuckles_alt/hills', -250, 0);
		scaleObject('hills', 1, 1);
		setScrollFactor('hills', 0.75, 0.9);
		setProperty('hills.antialiasing', true);
		addLuaSprite('hills', false);

		makeLuaSprite('ground', 'bgs/knuckles_alt/ground', 0, 0);
		scaleObject('ground', 1, 1);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('fgO', 'bgs/knuckles_alt/fg-1', 200, 200);
			scaleObject('fgO', 1, 1);
			setScrollFactor('fgO', 1.2, 1.1);
			setProperty('fgO.antialiasing', true);
			addLuaSprite('fgO', true);
			
			makeLuaSprite('fgT', 'bgs/knuckles_alt/fg-2', 300, 300);
			scaleObject('fgT', 1, 1);
			setScrollFactor('fgT', 1.3, 1.2);
			setProperty('fgT.antialiasing', true);
			addLuaSprite('fgT', true);
		end
	end

	makeLuaSprite('blackscreen', '', 0, 0);
	makeGraphic('blackscreen',1920,1080,'000000')
	addLuaSprite('blackscreen', true);
	setLuaSpriteScrollFactor('blackscreen',0,0)
	setProperty('blackscreen.scale.x',2)
	setProperty('blackscreen.scale.y',2)
	setProperty('blackscreen.alpha',0)

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)

	setProperty('gfGroup.alpha', 0);
end

function onUpdate()
    
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "tribal" then
		if curStep == 32 or curStep == 96 or curStep == 160 or curStep == 224 then
			setProperty('defaultCamZoom',0.5)
			xx = 1500;
			yy = 1650;
			xx2 = 1700;
			yy2 = 1650;
		end
		if curStep == 64 or curStep == 128 or curStep == 192 then
			setProperty('defaultCamZoom',0.4)
			xx = 1600;
			yy = 1400;
			xx2 = 1600;
			yy2 = 1400;
		end
		if curStep == 248 then
			setProperty('defaultCamZoom',0.6)
			xx = 1500;
			yy = 1700;
			xx2 = 1700;
			yy2 = 1700;
		end
		if curStep == 256 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1.5,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 1500;
			yy = 1650;
			xx2 = 1700;
			yy2 = 1650;
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