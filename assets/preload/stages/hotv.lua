local xx = 600;
local yy = 1250;
local ofs = 10;
local ofs2 = 10;
local xx2 = 900;
local yy2 = 1250;
local followchars = true;
local zoom = 2;
local majin = 1;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		--Endless Stuff
		makeLuaSprite('EndlessBG', 'bgs/hotv/endless-is-fun/sonicFUNsky', -550, 100);
		scaleObject('EndlessBG', 1.1, 1.0);
		setScrollFactor('EndlessBG', 1, 1);
		setProperty('EndlessBG.antialiasing', true);
		addLuaSprite('EndlessBG', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('EndlessBush1', 'bgs/hotv/endless-is-fun/Bush 1', -800, 1300);
			scaleObject('EndlessBush1', 1.35, 1.2);
			setScrollFactor('EndlessBush1', 0.6, 1);
			setProperty('EndlessBush1.antialiasing', true);
			addLuaSprite('EndlessBush1', false);
		
			makeAnimatedLuaSprite('EndlessMajinBoppersBack', 'bgs/hotv/endless-is-fun/Majin Boppers Back', 120, 400);
			addAnimationByPrefix('EndlessMajinBoppersBack', 'beep', 'MajinBop2 instance 1', 24, false);
			setScrollFactor('EndlessMajinBoppersBack', 0.7, 1);
			setProperty('EndlessMajinBoppersBack.antialiasing', true);
			addLuaSprite('EndlessMajinBoppersBack', false);
		
			makeLuaSprite('EndlessBush2', 'bgs/hotv/endless-is-fun/Bush2', -800, 1100);
			scaleObject('EndlessBush2', 1.35, 1.2);
			setScrollFactor('EndlessBush2', 0.8, 1);
			setProperty('EndlessBush2.antialiasing', true);
			addLuaSprite('EndlessBush2', false);
		end
		
		makeAnimatedLuaSprite('EndlessMajinBoppersFront', 'bgs/hotv/endless-is-fun/Majin Boppers Front', -280, 400);
		addAnimationByPrefix('EndlessMajinBoppersFront', 'bop', 'MajinBop1 instance 1', 24, false);
		setScrollFactor('EndlessMajinBoppersFront', 0.9,1);
		setProperty('EndlessMajinBoppersFront.antialiasing', true);
		addLuaSprite('EndlessMajinBoppersFront', false);
		
		makeLuaSprite('Endlessfloor', 'bgs/hotv/endless-is-fun/floor BG', -550, 1300);
		scaleObject('Endlessfloor', 1.0, 1.0);
		setScrollFactor('Endlessfloor', 1, 1);
		setProperty('Endlessfloor.antialiasing', true);
		addLuaSprite('Endlessfloor', false);
		
		--YCR Encore Stuff
		
		makeLuaSprite('YCREbg', 'bgs/hotv/ycrebg', -650, 350);
		scaleObject('YCREbg', 2, 1.6);
		setScrollFactor('YCREbg', 1, 1);
		setProperty('YCREbg.antialiasing', true);
		setProperty('YCREbg.alpha', 0);
		addLuaSprite('YCREbg', false);
		
		makeLuaSprite('YCREcity1', 'bgs/hotv/city1', -650, 350);
		scaleObject('YCREcity1', 2, 1.6);
		setScrollFactor('YCREcity1', 0.9, 1);
		setProperty('YCREcity1.antialiasing', true);
		setProperty('YCREcity1.alpha', 0);
		addLuaSprite('YCREcity1', false);
		
		makeLuaSprite('YCREcity2', 'bgs/hotv/city2', -650, 350);
		scaleObject('YCREcity2', 2, 1.6);
		setScrollFactor('YCREcity2', 1.07, 1);
		setProperty('YCREcity2.antialiasing', true);
		setProperty('YCREcity2.alpha', 0);
		addLuaSprite('YCREcity2', false);
		
		makeLuaSprite('YCREfloor', 'bgs/hotv/floor', -870, -950);
		scaleObject('YCREfloor', 2.3, 3);
		setScrollFactor('YCREfloor', 1, 1);
		setProperty('YCREfloor.antialiasing', true);
		setProperty('YCREfloor.alpha', 0);
		addLuaSprite('YCREfloor', false);

		--Endless Encore Stuff
		makeLuaSprite('EndlessEncoreBG', 'bgs/hotv/endless-is-fun-encore/bg', -1050, -100);
		scaleObject('EndlessEncoreBG', 1.5, 1.5);
		setScrollFactor('EndlessEncoreBG', 0.15, 0.8);
		setProperty('EndlessEncoreBG.antialiasing', true);
		addLuaSprite('EndlessEncoreBG', false);
		setProperty('EndlessEncoreBG.alpha',0)
		
		makeLuaSprite('EndlessEncorebush3', 'bgs/hotv/endless-is-fun-encore/bush3', -100, 80);
		scaleObject('EndlessEncorebush3', 1.2, 1.1);
		setScrollFactor('EndlessEncorebush3', 1, 1);
		setProperty('EndlessEncorebush3.antialiasing', true);
		addLuaSprite('EndlessEncorebush3', false);
		setProperty('EndlessEncorebush3.alpha',0)
		
		makeLuaSprite('EndlessEncorebush2', 'bgs/hotv/endless-is-fun-encore/bush2', 90, 80);
		scaleObject('EndlessEncorebush2', 1.2, 1.1);
		setScrollFactor('EndlessEncorebush2', 1, 1);
		setProperty('EndlessEncorebush2.antialiasing', true);
		addLuaSprite('EndlessEncorebush2', false);
		setProperty('EndlessEncorebush2.alpha',0)
		
		makeLuaSprite('EndlessEncorebush1', 'bgs/hotv/endless-is-fun-encore/bush1', 140, 180);
		scaleObject('EndlessEncorebush1', 1.2, 1.1);
		setScrollFactor('EndlessEncorebush1', 1, 1);
		setProperty('EndlessEncorebush1.antialiasing', true);
		addLuaSprite('EndlessEncorebush1', false);
		setProperty('EndlessEncorebush1.alpha',0)
		
		makeLuaSprite('EndlessEncorestagefront', 'bgs/hotv/endless-is-fun-encore/stagefrontpng', -100, -20);
		scaleObject('EndlessEncorestagefront', 1.3, 1.3);
		setScrollFactor('EndlessEncorestagefront', 1, 1);
		setProperty('EndlessEncorestagefront.antialiasing', true);
		addLuaSprite('EndlessEncorestagefront', false);
		setProperty('EndlessEncorestagefront.alpha',0)
		
		makeLuaSprite('EndlessEncorestagecurtains', 'bgs/hotv/endless-is-fun-encore/stagecurtains', -200, 0);
		scaleObject('EndlessEncorestagecurtains', 1.2, 1.2);
		setScrollFactor('EndlessEncorestagecurtains', 0.78, 0.78);
		setProperty('EndlessEncorestagecurtains.antialiasing', true);
		addLuaSprite('EndlessEncorestagecurtains', true);
		setProperty('EndlessEncorestagecurtains.alpha',0)
		
		makeLuaSprite('EndlessEncoredark', 'bgs/hotv/endless-is-fun-encore/dark', 0, 550);
		scaleObject('EndlessEncoredark', 2.49, 2.35);
		setScrollFactor('EndlessEncoredark', 0, 0);
		setProperty('EndlessEncoredark.alpha', 0);
		setProperty('EndlessEncoredark.antialiasing', true);
		addLuaSprite('EndlessEncoredark', true);
		screenCenter('EndlessEncoredark', XY);
		
		--Too Slow Stuff
		if getPropertyFromClass('ClientPrefs', 'gore') == true then
			makeLuaSprite('YOURETOOSLOW', 'bgs/hotv/too-slow', 400, 400);
			scaleObject('YOURETOOSLOW', 1.5, 1.5);
			setScrollFactor('YOURETOOSLOW', 1, 1);
			setProperty('YOURETOOSLOW.antialiasing', true);
			addLuaSprite('YOURETOOSLOW', false);
			setProperty('YOURETOOSLOW.alpha',0)
		else
			makeLuaSprite('YOURETOOSLOW', 'bgs/hotv/too-slow-non-gore', 400, 400);
			scaleObject('YOURETOOSLOW', 1.5, 1.5);
			setScrollFactor('YOURETOOSLOW', 1, 1);
			setProperty('YOURETOOSLOW.antialiasing', true);
			addLuaSprite('YOURETOOSLOW', false);
			setProperty('YOURETOOSLOW.alpha',0)
		end
		
		makeLuaSprite('YOURETOOSLOWUPPER', 'bgs/hotv/too-slow-upper', 400, 400);
		scaleObject('YOURETOOSLOWUPPER', 1.5, 1.5);
		setScrollFactor('YOURETOOSLOWUPPER', 1, 1);
		setProperty('YOURETOOSLOWUPPER.antialiasing', true);
		addLuaSprite('YOURETOOSLOWUPPER', true);
		setProperty('YOURETOOSLOWUPPER.alpha',0)
	end

	--Other Shit
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',4)
	setProperty('blk.scale.y',4)
	setProperty('blk.alpha',0)
end

function onBeatHit()
	if majin == 1 then
		if curBeat % 2 == 0 then
			objectPlayAnimation('EndlessMajinBoppersFront', 'bop', true)
			objectPlayAnimation('EndlessMajinBoppersBack', 'beep', true)
			objectPlayAnimation('EndlessMajinFGone', 'bup', true)
			objectPlayAnimation('EndlessMajinFGtwo', 'bep', true)
		end
	end
	
	if majin == 2 then
		if curBeat % 2 == 0 then
			objectPlayAnimation('EndlessMajinBoppersFront', 'bop', true)
			objectPlayAnimation('EndlessMajinBoppersBack', 'beep', true)
			objectPlayAnimation('EndlessMajinFGone', 'bup', true)
			objectPlayAnimation('EndlessMajinFGtwo', 'bep', true)
			
			objectPlayAnimation('EndlessEncoreMajinBoppersFront', 'bop', true)
			objectPlayAnimation('EndlessEncoreMajinBoppersBack', 'beep', true)
			objectPlayAnimation('EndlessEncoreMajinFGone', 'bup', true)
			objectPlayAnimation('EndlessEncoreMajinFGtwo', 'bep', true)
		else
			objectPlayAnimation('EndlessMajinBoppersFront', 'bop', true)
			objectPlayAnimation('EndlessMajinBoppersBack', 'beep', true)
			objectPlayAnimation('EndlessMajinFGone', 'bup', true)
			objectPlayAnimation('EndlessMajinFGtwo', 'bep', true)
			
			objectPlayAnimation('EndlessEncoreMajinBoppersFront', 'bop', true)
			objectPlayAnimation('EndlessEncoreMajinBoppersBack', 'beep', true)
			objectPlayAnimation('EndlessEncoreMajinFGone', 'bup', true)
			objectPlayAnimation('EndlessEncoreMajinFGtwo', 'bep', true)
		end
	end
end

function onUpdate()
    
	if zoom == 0 then
		doTweenZoom('ZOOMDAD', 'camGame',0.9, 0.08, 'quadOut')
	end
	if zoom == 1 then
		doTweenZoom('ZOOMDAD', 'camGame',0.7, 0.5, 'quadOut')
	end
	if zoom == 2 then
		doTweenZoom('ZOOMDAD', 'camGame',0.6, 0.1, 'quadOut')
	end
	if zoom == 3 then
		doTweenZoom('ZOOMDAD', 'camGame',0.425, 0.08, 'quadOut')
	end
	if zoom == 4 then
		doTweenZoom('ZOOMDAD', 'camGame',0.475, 0.1, 'quadOut')
	end
	
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "hill-of-the-void" then
		if curStep == 0 then
			doTweenY('bfTween', 'boyfriend', "1250", 0.001);
			doTweenY('dadTween', 'dad', "1150", 0.001);
			setProperty('camHUD.alpha',0)
			setProperty('flashingshit.color', getColorFromHex('0026FF'))
		end
		
		if curStep == 10 then
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			
			noteTweenAlpha('ON1','0',0,0.01,'linear');
			noteTweenAlpha('ON2','1',0,0.01,'linear');
			noteTweenAlpha('ON3','2',0,0.01,'linear');
			noteTweenAlpha('ON4','3',0,0.01,'linear');
			
			noteTweenAlpha('PN1','4',0,0.01,'linear');
			noteTweenAlpha('PN2','5',0,0.01,'linear');
			noteTweenAlpha('PN3','6',0,0.01,'linear');
			noteTweenAlpha('PN4','7',0,0.01,'linear');
		end
		
		if curStep == 12 then
			setProperty('camHUD.alpha',1)
		end
		
		if curStep == 79 then
			setProperty('camHUD.alpha',0)
		end
		
		if curStep == 80 then
			setProperty('iconP2.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
			setProperty('timeBar.alpha', 1);
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeTxt.alpha', 1);
			
			noteTweenAlpha('1ON1','0',1,0.01,'linear');
			noteTweenAlpha('2ON2','1',1,0.01,'linear');
			noteTweenAlpha('3ON3','2',1,0.01,'linear');
			noteTweenAlpha('4ON4','3',1,0.01,'linear');
			
			noteTweenAlpha('5PN1','4',1,0.01,'linear');
			noteTweenAlpha('6PN2','5',1,0.01,'linear');
			noteTweenAlpha('7PN3','6',1,0.01,'linear');
			noteTweenAlpha('8PN4','7',1,0.01,'linear');
		end
		
		if curStep == 256 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
			majin = 2;
		end
		
		if curStep == 368 then
			doTweenAlpha('blk','blk',1,1.0,'linear')
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
		end
		
		if curStep == 392 then
			yy = 1200;
			xx2 = 1100
			yy2 = 1200;
			setProperty('blk.alpha', 0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1.5,'linear')
			zoom = 0;
			doTweenY('dadTweenN', 'dad', "950", 0.001);
			doTweenY('dadTweenM', 'boyfriend', "1200", 0.001);
			doTweenX('dadTweenP', 'boyfriend', "1280", 0.001);
			
			setProperty('YCREbg.alpha',1)
			setProperty('YCREfloor.alpha',1)
			setProperty('YCREcity1.alpha',1)
			setProperty('YCREcity2.alpha',1)
			setProperty('EndlessBG.alpha',0)
			setProperty('EndlessBush1.alpha',0)
			setProperty('EndlessMajinBoppersBack.alpha',0)
			setProperty('EndlessBush2.alpha',0)
			setProperty('EndlessMajinBoppersFront.alpha',0)
			setProperty('Endlessfloor.alpha',0)
		end
		
		if curStep == 416 then
			zoom = 1;
		end
		
		if curStep == 448 then
			doTweenAlpha('camHUD','camHUD',1,1.5,'linear')
		end
		
		if curStep == 1150 then
			doTweenAlpha('bgT','blk',1,1.0,'linear')
		end
		
		if curStep == 1165 then
			zoom = 4;
			xx = 1400;
			yy = 1000;
			xx2 = 1700;
			yy2 = 1000;
		
			doTweenY('bfTweenY', 'boyfriend', "1050", 0.001);
			doTweenY('dadTweenY', 'dad', "800", 0.001);
			doTweenX('bfTweenX', 'boyfriend', "1900", 0.001);
			doTweenX('dadTweenX', 'dad', "700", 0.001);
			
			setProperty('YCREbg.alpha',0)
			setProperty('YCREfloor.alpha',0)
			setProperty('YCREcity1.alpha',0)
			setProperty('YCREcity2.alpha',0)
			setProperty('EndlessEncoreBG.alpha',1)
			setProperty('EndlessEncorebush3.alpha',1)
			setProperty('EndlessEncorebush2.alpha',1)
			setProperty('EndlessEncorebush1.alpha',1)
			setProperty('EndlessEncorestagefront.alpha',1)
			setProperty('EndlessEncorestagecurtains.alpha',1)
			setProperty('EndlessEncoredark.alpha',1)
		end
		
		if curStep == 1184 then
			doTweenAlpha('bgTw','blk',0,0.5,'linear')
		end
		
		if curStep == 1535 then
			setProperty('flashingshit.alpha',1)
		end
		
		if curStep == 1536 then
			zoom = 2;
			xx = 1700;
			yy = 1200;
			xx2 = 2000;
			yy2 = 1200;
			doTweenX('bfTweenXX', 'boyfriend',"2200", 0.001);
			doTweenX('dadTweenXX', 'dad', "1250", 0.001);
			doTweenY('dadTweenYY', 'dad', "950", 0.001);
			setProperty('YOURETOOSLOW.alpha',1)
			setProperty('YOURETOOSLOWUPPER.alpha',1)
			setProperty('EndlessEncoreBG.alpha',0)
			setProperty('EndlessEncorebush3.alpha',0)
			setProperty('EndlessEncorebush2.alpha',0)
			setProperty('EndlessEncorebush1.alpha',0)
			setProperty('EndlessEncorestagefront.alpha',0)
			setProperty('EndlessEncorestagecurtains.alpha',0)
			setProperty('EndlessEncoredark.alpha',0)
		end
		
		if curStep == 1537 then
			doTweenAlpha('flashingshit','flashingshit',0,1.5,'linear')
		end
		
		if curStep == 1696 then
			doTweenAlpha('CamHUDSUS','camHUD',0,2,'linear')
			doTweenAlpha('bgSUS','blk',1,2,'linear')
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