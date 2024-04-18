local xx = 1600;
local yy = 1400;
local ofs = 15;
local ofs2 = 15;
local xx2 = 2000;
local yy2 = 1450;
local followchars = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/endless-encore/bg', -1050, 150);
		scaleObject('bg', 2, 2);
		setScrollFactor('bg', 0.15, 0.8);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('bush3', 'bgs/endless-encore/bush3', -600, 300);
			scaleObject('bush3', 1.4, 1.3);
			setScrollFactor('bush3', 0.2, 0.9);
			setProperty('bush3.antialiasing', true);
			addLuaSprite('bush3', false);
			
			makeAnimatedLuaSprite('MajinBoppersBack', 'bgs/endless-encore/Majin Boppers Back', 200, 150);
			scaleObject('MajinBoppersBack', 1.4, 1.4);
			addAnimationByPrefix('MajinBoppersBack', 'beep', 'MajinBop2 instance 1', 24, false);
			setScrollFactor('MajinBoppersBack', 0.4, 0.9);
			setProperty('MajinBoppersBack.antialiasing', true);
			addLuaSprite('MajinBoppersBack', false);
			
			makeLuaSprite('bush2', 'bgs/endless-encore/bush2', 50, 110);
			scaleObject('bush2', 1.4, 1.3);
			setScrollFactor('bush2', 0.6, 0.9);
			setProperty('bush2.antialiasing', true);
			addLuaSprite('bush2', false);
		end
		
		makeAnimatedLuaSprite('MajinBoppersFront', 'bgs/endless-encore/Majin Boppers Front', 65, 0);
		scaleObject('MajinBoppersFront', 1.3, 1.3);
		addAnimationByPrefix('MajinBoppersFront', 'bop', 'MajinBop1 instance 1', 24, false);
		setScrollFactor('MajinBoppersFront', 0.75, 0.8);
		setProperty('MajinBoppersFront.antialiasing', true);
		addLuaSprite('MajinBoppersFront', false);
		
		makeLuaSprite('bush1', 'bgs/endless-encore/bush1', 100, 300);
		scaleObject('bush1', 1.4, 1.3);
		setScrollFactor('bush1', 1, 1);
		setProperty('bush1.antialiasing', true);
		addLuaSprite('bush1', false);
		
		makeLuaSprite('stagefront', 'bgs/endless-encore/stagefrontpng', -140, 100);
		scaleObject('stagefront', 1.5, 1.5);
		setScrollFactor('stagefront', 1, 1);
		setProperty('stagefront.antialiasing', true);
		addLuaSprite('stagefront', false);
		
		makeLuaSprite('stagecurtains', 'bgs/endless-encore/stagecurtains', -265, 190);
		scaleObject('stagecurtains', 1.4, 1.4);
		setScrollFactor('stagecurtains', 0.78, 0.78);
		setProperty('stagecurtains.antialiasing', true);
		addLuaSprite('stagecurtains', true);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('MajinFGone', 'bgs/endless-encore/majin FG1', 2050, 1700);
			scaleObject('MajinFGone', 1.8, 1.8);
			addAnimationByPrefix('MajinFGone', 'bup', 'majin front bopper1', 24, false);
			setScrollFactor('MajinFGone', 0.65, 1);
			setProperty('MajinFGone.antialiasing', true);
			addLuaSprite('MajinFGone', true);
			
			makeAnimatedLuaSprite('MajinFGtwo', 'bgs/endless-encore/majin FG2', -350, 1700);
			scaleObject('MajinFGtwo', 1.8, 1.8);
			addAnimationByPrefix('MajinFGtwo', 'bep', 'majin front bopper2', 24, false);
			setScrollFactor('MajinFGtwo', 0.65, 1);
			setProperty('MajinFGtwo.antialiasing', true);
			addLuaSprite('MajinFGtwo', true);
		end
		
		setProperty('bg.alpha', 0);
		setProperty('MajinBoppersFront.alpha', 0);
		setProperty('stagecurtains.alpha', 0);
		setProperty('stagefront.alpha', 0);
		setProperty('bush1.alpha', 0);
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('MajinBoppersBack.alpha', 0);
			setProperty('bush2.alpha', 0);
			setProperty('bush3.alpha', 0);
			setProperty('MajinFGone.alpha', 0);
			setProperty('MajinFGtwo.alpha', 0);
		end
		
		makeLuaSprite('dark', 'bgs/endless-encore/dark', 0, 550);
		scaleObject('dark', 2.49, 2.35);
		setScrollFactor('dark', 0, 0);
		setProperty('dark.alpha', 1);
		setProperty('dark.antialiasing', true);
		addLuaSprite('dark', true);
		screenCenter('dark', XY);
	end
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'00106f')
	addLuaSprite('blk', false);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('MajinBoppersFront', 'bop', true)
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				objectPlayAnimation('MajinBoppersBack', 'beep', true)
				objectPlayAnimation('MajinFGone', 'bup', true)
				objectPlayAnimation('MajinFGtwo', 'bep', true)
			end
		else
			objectPlayAnimation('MajinBoppersFront', 'bop', true)
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				objectPlayAnimation('MajinBoppersBack', 'beep', true)
				objectPlayAnimation('MajinFGone', 'bup', true)
				objectPlayAnimation('MajinFGtwo', 'bep', true)
			end
		end
	end
end

function onUpdate()
    
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "endless-encore" then
		if curStep == 0 then
			doTweenAlpha('camHUDT','camHUD',0,0.1,'linear')
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('stagecurtainsT','stagecurtains',1,0.15,'linear')
				doTweenAlpha('bgT','bg',1,0.15,'linear')
				doTweenAlpha('stagefront','stagefront',1,0.15,'linear')
			end
		end
		if curStep == 4 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('MajinBoppersBackT','MajinBoppersBack',1,0.15,'linear')
				end
				doTweenAlpha('MajinBoppersFrontT','MajinBoppersFront',1,0.15,'linear')
				doTweenAlpha('bush1T','bush1',1,0.15,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bush2T','bush2',1,0.15,'linear')
					doTweenAlpha('bush3T','bush3',1,0.15,'linear')
				end
			end
		end
		if curStep == 8 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				doTweenAlpha('MajinFGoneT','MajinFGone',1,0.15,'linear')
				doTweenAlpha('MajinFGtwoT','MajinFGtwo',1,0.15,'linear')
			end
		end
		if curStep == 12 then
			doTweenAlpha('camHUDT','camHUD',1,0.25,'linear')
		end
		if curStep == 528 then
			setProperty('defaultCamZoom',0.43)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('MajinFGoneT','MajinFGone',0,0.35,'linear')
					doTweenAlpha('MajinFGtwoT','MajinFGtwo',0,0.35,'linear')
					doTweenAlpha('MajinBoppersBackT','MajinBoppersBack',0,0.35,'linear')
				end
				doTweenAlpha('MajinBoppersFrontT','MajinBoppersFront',0,0.35,'linear')
				doTweenAlpha('bush1T','bush1',0,0.35,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bush2T','bush2',0,0.35,'linear')
					doTweenAlpha('bush3T','bush3',0,0.35,'linear')
				end
				doTweenAlpha('stagefront','stagefront',0,0.35,'linear')
				doTweenAlpha('stagecurtainsT','stagecurtains',0,0.35,'linear')
			end
		end
		if curStep == 784 then
			doTweenAlpha('camHUDT','camHUD',0,0.25,'linear')
		end
		if curStep == 792 then
			doTweenAlpha('camHUDT','camHUD',1,0.25,'linear')
		end
		if curStep == 800 then
			setProperty('defaultCamZoom',0.375)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('MajinFGoneT','MajinFGone',1,0.35,'linear')
					doTweenAlpha('MajinFGtwoT','MajinFGtwo',1,0.35,'linear')
					doTweenAlpha('MajinBoppersBackT','MajinBoppersBack',1,0.35,'linear')
				end
				doTweenAlpha('MajinBoppersFrontT','MajinBoppersFront',1,0.35,'linear')
				doTweenAlpha('bush1T','bush1',1,0.35,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bush2T','bush2',1,0.35,'linear')
					doTweenAlpha('bush3T','bush3',1,0.35,'linear')
				end
				doTweenAlpha('stagefront','stagefront',1,0.35,'linear')
				doTweenAlpha('stagecurtainsT','stagecurtains',1,0.35,'linear')
			end
		end
		if curStep == 1056 then
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			doTweenAlpha('dark','dark', 0,0.15, 'linear');
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('stagefront','stagefront',0,0.15,'linear')
				doTweenAlpha('stagecurtainsT','stagecurtains',0,0.15,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('MajinFGoneT','MajinFGone',0,0.15,'linear')
					doTweenAlpha('MajinFGtwoT','MajinFGtwo',0,0.15,'linear')
				end
			end
			doTweenAlpha('blk','blk',1,0.4,'linear')
			setProperty('defaultCamZoom',0.43)
		end
		if curStep == 1312 then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('dark','dark', 1,0.15, 'linear');
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('stagefront','stagefront',1,0.15,'linear')
				doTweenAlpha('stagecurtainsT','stagecurtains',1,0.15,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('MajinFGoneT','MajinFGone',1,0.15,'linear')
					doTweenAlpha('MajinFGtwoT','MajinFGtwo',1,0.15,'linear')
				end
			end
			doTweenAlpha('blk','blk',0,0.2,'linear')
			setProperty('defaultCamZoom',0.375)
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
			
            if getProperty('boyfriend.animation.curAnim.name') == 'hey' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
    
end