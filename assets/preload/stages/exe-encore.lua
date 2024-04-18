local xx = 550;
local yy = 350;
local ofs = 15;
local ofs2 = 15;
local xx2 = 975;
local yy2 = 415;
local followchars = true;
local zoom = 0;
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('skyP1', 'bgs/faker-encore/skyP1', -700, -700);
		scaleObject('skyP1', 1.4, 1.6);
		setScrollFactor('skyP1', 0.6, 0.6);
		setProperty('skyP1.antialiasing', true);
		addLuaSprite('skyP1', false);
		
		makeLuaSprite('eclipiceP1', 'bgs/faker-encore/eclipiceP1', -600, -220);
		scaleObject('eclipiceP1', 1.3, 1.3);
		setScrollFactor('eclipiceP1', 0.6, 0.6);
		setProperty('eclipiceP1.antialiasing', true);
		addLuaSprite('eclipiceP1', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('moutainsP1', 'bgs/faker-encore/moutainsP1', -700, -550);
			scaleObject('moutainsP1', 0.87, 0.87);
			setScrollFactor('moutainsP1', 0.7, 0.55);
			setProperty('moutainsP1.antialiasing', true);
			addLuaSprite('moutainsP1', false);
		end
		
		makeLuaSprite('moundP1', 'bgs/faker-encore/moundP1', -600, -200);
		scaleObject('moundP1', 1.2, 1.2);
		setScrollFactor('moundP1', 0.8, 0.8);
		setProperty('moundP1.antialiasing', true);
		addLuaSprite('moundP1', false);

		makeLuaSprite('ringsP1', 'bgs/faker-encore/ringsP1', -600, -200);
		scaleObject('ringsP1', 1.2, 1.2);
		setScrollFactor('ringsP1', 0.8, 0.8);
		setProperty('ringsP1.antialiasing', true);
		addLuaSprite('ringsP1', false);
		
		makeLuaSprite('treesP1', 'bgs/faker-encore/treesP1', -700, -400);
		scaleObject('treesP1', 1.5, 1.5);
		setScrollFactor('treesP1', 0.9, 1);
		setProperty('treesP1.antialiasing', true);
		addLuaSprite('treesP1', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('groundP1', 'bgs/faker-encore/groundP1', -700, -400);
			scaleObject('groundP1', 1.5, 1.5);
			setScrollFactor('groundP1', 1, 1);
			setProperty('groundP1.antialiasing', true);
			addLuaSprite('groundP1', false);
		end
		
		makeLuaSprite('bgP1', 'bgs/faker-encore/bgP1', -700, -400);
		scaleObject('bgP1', 1.5, 1.5);
		setScrollFactor('bgP1', 1, 1);
		setProperty('bgP1.antialiasing', true);
		addLuaSprite('bgP1', false);
		
		makeLuaSprite('skyP2', 'bgs/faker-encore/skyP2', -700, -700);
		scaleObject('skyP2', 1.4, 1.6);
		setScrollFactor('skyP2', 0.6, 0.6);
		setProperty('skyP2.antialiasing', true);
		addLuaSprite('skyP2', false);
		
		makeLuaSprite('eclipiceP2', 'bgs/faker-encore/eclipiceP2', -600, -220);
		scaleObject('eclipiceP2', 1.3, 1.3);
		setScrollFactor('eclipiceP2', 0.6, 0.6);
		setProperty('eclipiceP2.antialiasing', true);
		addLuaSprite('eclipiceP2', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('moutainsP2', 'bgs/faker-encore/moutainsP2', -700, -550);
			scaleObject('moutainsP2', 0.87, 0.87);
			setScrollFactor('moutainsP2', 0.7, 0.55);
			setProperty('moutainsP2.antialiasing', true);
			addLuaSprite('moutainsP2', false);
		end
		
		makeLuaSprite('moundP2', 'bgs/faker-encore/moundP2', -600, -200);
		scaleObject('moundP2', 1.2, 1.2);
		setScrollFactor('moundP2', 0.8, 0.8);
		setProperty('moundP2.antialiasing', true);
		addLuaSprite('moundP2', false);
		
		makeLuaSprite('ringsP2', 'bgs/faker-encore/ringsP2', -600, -200);
		scaleObject('ringsP2', 1.2, 1.2);
		setScrollFactor('ringsP2', 0.8, 0.8);
		setProperty('ringsP2.antialiasing', true);
		addLuaSprite('ringsP2', false);
		
		makeLuaSprite('treesP2', 'bgs/faker-encore/treesP2', -700, -400);
		scaleObject('treesP2', 1.5, 1.5);
		setScrollFactor('treesP2', 0.9, 1);
		setProperty('treesP2.antialiasing', true);
		addLuaSprite('treesP2', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('groundP2', 'bgs/faker-encore/groundP2', -700, -400);
			scaleObject('groundP2', 1.5, 1.5);
			setScrollFactor('groundP2', 1, 1);
			setProperty('groundP2.antialiasing', true);
			addLuaSprite('groundP2', false);
		end
		
		makeLuaSprite('bgP2', 'bgs/faker-encore/bgP2', -700, -400);
		scaleObject('bgP2', 1.5, 1.5);
		setScrollFactor('bgP2', 1, 1);
		setProperty('bgP2.antialiasing', true);
		addLuaSprite('bgP2', false);
		
		setProperty('skyP2.alpha',0);
		setProperty('eclipiceP2.alpha',0);
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('moutainsP2.alpha',0);
		end
		setProperty('moundP2.alpha',0);
		setProperty('ringsP2.alpha',0);
		setProperty('treesP2.alpha',0);
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('groundP2.alpha',0);
		end
		setProperty('bgP2.alpha',0);
	end
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', false);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	
	makeLuaSprite('jover', 'bgs/faker-encore/jover', 0, 0);
	scaleObject('jover', 0.69, 0.69);
	setScrollFactor('jover', 1, 1);
	setProperty('jover.antialiasing', true);
	setProperty('jover.alpha',0);
	setObjectCamera('jover', 'camHUD');
	addLuaSprite('jover', true)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('blkD', '', 0, 0);
	makeGraphic('blkD',1920,1080,'000000')
	addLuaSprite('blkD', true);
	setLuaSpriteScrollFactor('blkD',0,0)
	setProperty('blkD.scale.x',2)
	setProperty('blkD.scale.y',2)
	setObjectCamera('blkD', 'camOther');
	setProperty('blkD.alpha',0)
	
	makeLuaSprite('blkS', '', 0, 0);
	makeGraphic('blkS',1920,1080,'000000')
	addLuaSprite('blkS', true);
	setLuaSpriteScrollFactor('blkS',0,0)
	setProperty('blkS.scale.x',2)
	setProperty('blkS.scale.y',2)
	setProperty('blkS.alpha',0)
	
	makeLuaSprite('dafukEyes', 'bgs/faker-encore/dafuk-eyes', 420, 250);
	setScrollFactor('dafukEyes', 0, 0);
	setProperty('dafukEyes.antialiasing', true);
	setProperty('dafukEyes.alpha',0);
	setObjectCamera('dafukEyes', 'camHUD');
	addLuaSprite('dafukEyes', true)
	
	makeLuaSprite('dafuk', 'bgs/faker-encore/dafuk', 420, 250);
	setScrollFactor('dafuk', 0, 0);
	setProperty('dafuk.antialiasing', true);
	setProperty('dafuk.alpha',0);
	setObjectCamera('dafuk', 'camHUD');
	addLuaSprite('dafuk', true)
	
	runTimer('Rings Down', 0.1, 1)
end

function dafukOnScreen(enable)
	if enable == true then
		doTweenAlpha('dafukEnable','dafuk',1,0.08,'linear')
		doTweenAlpha('dafukEyesEnable','dafukEyes',1,0.08,'linear')
		doTweenAlpha('blkDEnable','blkS',1,0.08,'linear')
		
		noteTweenAlpha('opponentArrowsDis0',0 ,0.2 ,0.08, 'linear')
		noteTweenAlpha('opponentArrowsDis1',1 ,0.2 ,0.08, 'linear')
		noteTweenAlpha('opponentArrowsDis2',2 ,0.2 ,0.08, 'linear')
		noteTweenAlpha('opponentArrowsDis3',3 ,0.2 ,0.08, 'linear')
		
		noteTweenAlpha('playerArrowsDis0',4 ,0.2 ,0.08, 'linear')
		noteTweenAlpha('playerArrowsDis1',5 ,0.2 ,0.08, 'linear')
		noteTweenAlpha('playerArrowsDis2',6 ,0.2 ,0.08, 'linear')
		noteTweenAlpha('playerArrowsDis3',7 ,0.2 ,0.08, 'linear')
		
		doTweenAlpha('timeBarBGDis','timeBarBG',0,0.08,'linear')
		doTweenAlpha('timeBarDis','timeBar',0,0.08,'linear')
		doTweenAlpha('timeTxtDis','timeTxt',0,0.08,'linear')
		doTweenAlpha('scoreTxtDis','scoreTxt',0,0.08,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',0,0.08,'linear')
		doTweenAlpha('healthBarDis','healthBar',0,0.08,'linear')
		doTweenAlpha('iconP1Dis','iconP1',0,0.08,'linear')
		doTweenAlpha('iconP2Dis','iconP2',0,0.08,'linear')
	end
	if enable == false then
		doTweenAlpha('dafukDisable','dafuk',0,0.08,'linear')
		doTweenAlpha('dafukEyesDisable','dafukEyes',0,1.2,'linear')
		doTweenAlpha('blkDDisable','blkS',0,0.08,'linear')
		
		noteTweenAlpha('opponentArrowsEnb0',0 ,1 ,0.08, 'linear')
		noteTweenAlpha('opponentArrowsEnb1',1 ,1 ,0.08, 'linear')
		noteTweenAlpha('opponentArrowsEnb2',2 ,1 ,0.08, 'linear')
		noteTweenAlpha('opponentArrowsEnb3',3 ,1 ,0.08, 'linear')
		
		noteTweenAlpha('playerArrowsEnb0',4 ,1 ,0.08, 'linear')
		noteTweenAlpha('playerArrowsEnb1',5 ,1 ,0.08, 'linear')
		noteTweenAlpha('playerArrowsEnb2',6 ,1 ,0.08, 'linear')
		noteTweenAlpha('playerArrowsEnb3',7 ,1 ,0.08, 'linear')
		
		doTweenAlpha('timeBarBGEnb','timeBarBG',1,0.08,'linear')
		doTweenAlpha('timeBarEnb','timeBar',1,0.08,'linear')
		doTweenAlpha('timeTxtEnb','timeTxt',1,0.08,'linear')
		doTweenAlpha('scoreTxtEnb','scoreTxt',1,0.08,'linear')
		doTweenAlpha('healthBarBGEnb','healthBarBG',1,0.08,'linear')
		doTweenAlpha('healthBarEnb','healthBar',1,0.08,'linear')
		doTweenAlpha('iconP1Enb','iconP1',1,0.08,'linear')
		doTweenAlpha('iconP2Enb','iconP2',1,0.08,'linear')
	end
end

function onTimerCompleted(tag)
	if tag == 'Rings Up' then
		doTweenY('RingsP1-TweenUp', 'ringsP1', -170, 2.5, 'quadInOut')
		doTweenY('RingsP2-TweenUp', 'ringsP2', -170, 2.5, 'quadInOut')
		runTimer('Rings Down', 2.5, 1)
	end
	if tag == 'Rings Down' then
		doTweenY('RingsP1-TweenDown', 'ringsP1', -220, 2.5, 'quadInOut')
		doTweenY('RingsP2-TweenDown', 'ringsP2', -220, 2.5, 'quadInOut')
		runTimer('Rings Up', 2.0, 1)
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 165)
	
	if zoom == 1 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.55)
		else
			setProperty('defaultCamZoom',0.65)
		end
	end
	
	if songName == "faker-encore" then	
		if curStep == 256 then
		    doTweenAlpha('blk','blk',0.4,0.3,'linear')
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 384 then
			doTweenAlpha('blk','blk',0,0.4,'linear')
		    setProperty('defaultCamZoom',0.65)
		end
		if curStep == 512 then--512
			doTweenAlpha('jover','jover',1,0.55,'linear')
			doTweenAlpha('blkD','blkD',1,0.75,'linear')
		end
	    if curStep == 576 then--576
			zoom = 1;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skyP2.alpha',1);
				setProperty('eclipiceP2.alpha',1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('moutainsP2.alpha',1);
				end
				setProperty('moundP2.alpha',1);
				setProperty('ringsP2.alpha',1);
				setProperty('treesP2.alpha',1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('groundP2.alpha',1);
				end
				setProperty('bgP2.alpha',1);
				setProperty('skyP1.alpha',0);
				setProperty('eclipiceP1.alpha',0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('moutainsP1.alpha',0);
				end
				setProperty('moundP1.alpha',0);
				setProperty('ringsP1.alpha',0);
				setProperty('treesP1.alpha',0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('groundP1.alpha',0);
				end
				setProperty('bgP1.alpha',0);
			end
			setProperty('defaultCamZoom',0.65)
			doTweenAlpha('blkD','blkD',0,0.65,'linear')
			xx = 550;
			yy = 200;
			xx2 = 975;
			yy2 = 415;
		end
		if curStep == 704 then--704
		    doTweenAlpha('blkD','blkD',0.8,0.01,'linear')
		end
		if curStep == 705 then--705
			doTweenAlpha('blkD','blkD',0,0.42,'linear')
		end
		if curStep == 959 then
		    doTweenAlpha('blk','blk',0.4,0.3,'linear')
			setProperty('blkD.alpha', 1)
		end
		if curStep == 960 then --960
			zoom = 0;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skyP2.alpha',0);
				setProperty('eclipiceP2.alpha',0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('moutainsP2.alpha',0);
				end
				setProperty('moundP2.alpha',0);
				setProperty('ringsP2.alpha',0);
				setProperty('treesP2.alpha',0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('groundP2.alpha',0);
				end
				setProperty('bgP2.alpha',0);
				setProperty('skyP1.alpha',1);
				setProperty('eclipiceP1.alpha',1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('moutainsP1.alpha',1);
				end
				setProperty('moundP1.alpha',1);
				setProperty('ringsP1.alpha',1);
				setProperty('treesP1.alpha',1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('groundP1.alpha',1);
				end
				setProperty('bgP1.alpha',1);
			end
			setProperty('defaultCamZoom',0.8)
			doTweenAlpha('blkD','blkD',0,0.3,'linear')
			xx = 550;
			yy = 350;
			xx2 = 975;
			yy2 = 415;
		end
		if curStep == 961 then--559
			doTweenAlpha('jover','jover',0,0.5,'linear')
		end	
		if curStep == 987 then
			dafukOnScreen(true);
		end
		if curStep == 991 then
			dafukOnScreen(false);
		end
		if curStep == 1088 then
			setProperty('defaultCamZoom',0.65);
			doTweenAlpha('blk','blk',0,0.3,'linear')
		end
		if curStep == 1215 then--1210
			doTweenAlpha('jover','jover',1,0.5,'linear')
		    setProperty('blkD.alpha', 1)
		end
		if curStep == 1216 then --1216
			zoom = 1;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skyP2.alpha',1);
				setProperty('eclipiceP2.alpha',1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('moutainsP2.alpha',1);
				end
				setProperty('moundP2.alpha',1);
				setProperty('ringsP2.alpha',1);
				setProperty('treesP2.alpha',1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('groundP2.alpha',1);
				end
				setProperty('bgP2.alpha',1);
				setProperty('skyP1.alpha',0);
				setProperty('eclipiceP1.alpha',0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('moutainsP1.alpha',0);
				end
				setProperty('moundP1.alpha',0);
				setProperty('ringsP1.alpha',0);
				setProperty('treesP1.alpha',0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('groundP1.alpha',0);
				end
				setProperty('bgP1.alpha',0);
			end
			setProperty('defaultCamZoom',0.65)
			doTweenAlpha('blkD','blkD',0,0.65,'linear')
			xx = 550;
			yy = 200;
			xx2 = 975;
			yy2 = 415;
		end
		if curStep == 1344 then--1220
		    doTweenAlpha('blkD','blkD',0.8,0.01,'linear')
		end
		if curStep == 1345 then--1221
			doTweenAlpha('blkD','blkD',0,0.4,'linear')
		end
		if curStep == 1476 then--1476
		    doTweenAlpha('blkD','blkD',1,0.5,'linear')
		end
		if curStep == 1478 then
		    doTweenAlpha('ch1','camHUD',0,0.3,'linear')
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