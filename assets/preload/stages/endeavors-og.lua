local xx = 600;
local yy = 700;
local ofs = 15;
local ofs2 = 15;
local xx2 = 800;
local yy2 = 700;
local followchars = true;
local flash = 0;
local flashAlpha = 0;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		--Fun Never Ends
		makeLuaSprite('FunNeverEnds', 'bgs/endeavors/cool-text', 100, 0);
		scaleObject('FunNeverEnds', 4, 4);
		setScrollFactor('FunNeverEnds', 0.5, 0.5);
		setProperty('FunNeverEnds.antialiasing', false);
		addLuaSprite('FunNeverEnds', false);
		
		makeLuaSprite('ColMajinFunNeverEnds', 'bgs/endeavors/col', 200, 950);
		scaleObject('ColMajinFunNeverEnds', 1.1, 1.1);
		setScrollFactor('ColMajinFunNeverEnds', 1, 1);
		setProperty('ColMajinFunNeverEnds.antialiasing', true);
		addLuaSprite('ColMajinFunNeverEnds', false);
		
		makeLuaSprite('ColBFFunNeverEnds', 'bgs/endeavors/col', 1070, 950);
		scaleObject('ColBFFunNeverEnds', 1.1, 1.1);
		setScrollFactor('ColBFFunNeverEnds', 1, 1);
		setProperty('ColBFFunNeverEnds.antialiasing', true);
		addLuaSprite('ColBFFunNeverEnds', false);

		setProperty('FunNeverEnds.alpha',0)
		setProperty('ColMajinFunNeverEnds.alpha',0)
		setProperty('ColBFFunNeverEnds.alpha',0)

		--Present
		makeLuaSprite('floor', 'bgs/endeavors/present/floor', -1200, -400);
		scaleObject('floor', 1, 1);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false);
		
		makeLuaSprite('rocks', 'bgs/endeavors/present/rocks', -440, -320);
		scaleObject('rocks', 1, 1);
		setScrollFactor('rocks', 1, 1);
		setProperty('rocks.antialiasing', true);
		addLuaSprite('rocks', false);
		
		makeLuaSprite('lightfg', 'bgs/endeavors/present/light-fg', -600, 100);
		scaleObject('lightfg', 1, 1);
		setScrollFactor('lightfg', 1, 1);
		setProperty('lightfg.antialiasing', true);
		addLuaSprite('lightfg', true);

		makeLuaSprite('columnsfg', 'bgs/endeavors/present/columns-fg', -360, -315);
		scaleObject('columnsfg', 1, 1);
		setScrollFactor('columnsfg', 0.6, 1);
		setProperty('columnsfg.antialiasing', true);
		addLuaSprite('columnsfg', true);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('MajLeft', 'bgs/endeavors/present/majin-left', -350, 630);
			addAnimationByPrefix('MajLeft', 'idle', 'idle', 24, true);
			scaleObject('MajLeft', 1, 1);
			setScrollFactor('MajLeft', 0.6, 1);
			setProperty('MajLeft.antialiasing', true);
			addLuaSprite('MajLeft', true);

			makeAnimatedLuaSprite('MajRight', 'bgs/endeavors/present/majin-right', 1370, 450);
			addAnimationByPrefix('MajRight', 'idle', 'idl', 24, true);
			scaleObject('MajRight', 1, 1);
			setScrollFactor('MajRight', 0.6, 1);
			setProperty('MajRight.antialiasing', true);
			addLuaSprite('MajRight', true);
		end

		setProperty('floor.alpha',0)
		setProperty('rocks.alpha',0)
		setProperty('lightfg.alpha',0)
		setProperty('columnsfg.alpha',0)
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('MajLeft.alpha',0)
			setProperty('MajRight.alpha',0)
		end

		--Hype
		makeLuaSprite('HSkyTwo', 'bgs/endeavors/hype/sky-2', -450, -750);
		scaleObject('HSkyTwo', 1, 1);
		setScrollFactor('HSkyTwo', 0.3, 0.6);
		setProperty('HSkyTwo.antialiasing', true);
		addLuaSprite('HSkyTwo', false);
		
		makeLuaSprite('HSkyOne', 'bgs/endeavors/hype/sky-1', -350, -550);
		scaleObject('HSkyOne', 1, 1);
		setScrollFactor('HSkyOne', 0.7, 0.8);
		setProperty('HSkyOne.antialiasing', true);
		addLuaSprite('HSkyOne', false);
		
		makeLuaSprite('HGround', 'bgs/endeavors/hype/ground', -650, -580);
		scaleObject('HGround', 1, 1);
		setScrollFactor('HGround', 1, 1);
		setProperty('HGround.antialiasing', true);
		addLuaSprite('HGround', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('HMajLeft', 'bgs/endeavors/hype/majon', 50, 250);
			addAnimationByPrefix('HMajLeft', 'idle', 'BINBON MAJON', 24, true);
			scaleObject('HMajLeft', 1, 1);
			setScrollFactor('HMajLeft', 0.9, 1);
			setProperty('HMajLeft.antialiasing', true);
			setProperty('HMajLeft.flipX', true);
			addLuaSprite('HMajLeft', false);
			
			makeAnimatedLuaSprite('HMajRight', 'bgs/endeavors/hype/majon', 1270, 250);
			addAnimationByPrefix('HMajRight', 'idle', 'BINBON MAJON', 24, true);
			scaleObject('HMajRight', 1, 1);
			setScrollFactor('HMajRight', 0.9, 1);
			setProperty('HMajRight.antialiasing', true);
			addLuaSprite('HMajRight', false);
			
			makeAnimatedLuaSprite('HEgg', 'bgs/endeavors/hype/egg-dj', 515, 210);
			addAnimationByPrefix('HEgg', 'idle', 'eggy dance', 24, false);
			scaleObject('HEgg', 1, 1);
			setScrollFactor('HEgg', 1, 1);
			setProperty('HEgg.antialiasing', true);
			addLuaSprite('HEgg', false);
		end
		
		makeLuaSprite('HColumns', 'bgs/endeavors/hype/columns', -200, -670);
		scaleObject('HColumns', 1, 1);
		setScrollFactor('HColumns', 1, 1);
		setProperty('HColumns.antialiasing', true);
		addLuaSprite('HColumns', false);
		
		makeLuaSprite('HLight', 'bgs/endeavors/hype/light', -800, -1000);
		scaleObject('HLight', 1, 1);
		setScrollFactor('HLight', 1, 1);
		setProperty('HLight.antialiasing', true);
		addLuaSprite('HLight', true);
		
		makeLuaSprite('HColumnsFG', 'bgs/endeavors/hype/columns-fg', -1300, -670);
		scaleObject('HColumnsFG', 1, 1);
		setScrollFactor('HColumnsFG', 0.55, 1);
		setProperty('HColumnsFG.antialiasing', true);
		addLuaSprite('HColumnsFG', true);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			if getRandomInt(1,2) == 1 then 
				makeAnimatedLuaSprite('HMajLeftFG', 'bgs/endeavors/hype/majin', -1250, 50);
				addAnimationByPrefix('HMajLeftFG', 'idle', 'majin dance ', 24, true);
				scaleObject('HMajLeftFG', 1, 1);
				setScrollFactor('HMajLeftFG', 0.55, 1);
				setProperty('HMajLeftFG.antialiasing', true);
				setProperty('HMajLeftFG.flipX', true);
				addLuaSprite('HMajLeftFG', true);
			else
				makeAnimatedLuaSprite('HMajLeftFG', 'bgs/endeavors/hype/majin-left-pog', -1450, 450);
				addAnimationByPrefix('HMajLeftFG', 'idle', 'meme majin', 24, true);
				scaleObject('HMajLeftFG', 0.9, 0.9);
				setScrollFactor('HMajLeftFG', 0.55, 1);
				setProperty('HMajLeftFG.antialiasing', true);
				addLuaSprite('HMajLeftFG', true);
			end
			
			makeAnimatedLuaSprite('HMajRightFG', 'bgs/endeavors/hype/majin', 1750, 50);
			addAnimationByPrefix('HMajRightFG', 'idle', 'majin dance ', 24, true);
			scaleObject('HMajRightFG', 1, 1);
			setScrollFactor('HMajRightFG', 0.55, 1);
			setProperty('HMajRightFG.antialiasing', true);
			addLuaSprite('HMajRightFG', true);
		end
		
		setProperty('HSkyTwo.alpha',0)
		setProperty('HSkyOne.alpha',0)
		setProperty('HGround.alpha',0)
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('HMajLeft.alpha',0)
			setProperty('HMajRight.alpha',0)
			setProperty('HEgg.alpha',0)
		end
		setProperty('HColumns.alpha',0)
		setProperty('HLight.alpha',0)
		setProperty('HColumnsFG.alpha',0)
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('HMajLeftFG.alpha',0)
			setProperty('HMajRightFG.alpha',0)
		end
	end

	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',1)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('flashin', 'blueVg', 0, 0, 'exe');
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.alpha',0)
	setObjectCamera('flashin', 'camOther')
	setGraphicSize('flashin', FlxG.width, FlxG.height)
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('HEgg', 'idle', false)
		else
			objectPlayAnimation('HEgg', 'idle', false)
		end
	end
	if flash == 1 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if flash == 2 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flash');
			setProperty('flashin.alpha',flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "endeavors-og" then
		if curStep == 0 then
			setProperty('camHUD.alpha',0)
		end
		if curStep == 1 then
			doTweenAlpha('blkBegin','blk',0,2.5,'linear')
		end
		if curStep == 16 then
			doTweenAlpha('camHUD1','camHUD',1,0.5,'linear')
			setProperty('defaultCamZoom',0.8)
			setProperty('blk.alpha',0)
			setProperty('flashingshit.color', getColorFromHex('0026FF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			flash = 2;
			flashAlpha = 0.4;
		end
		if curStep == 272 then
			cancelTween('flsh');
			flash = 0;
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1232 or curStep == 1360 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 264 then
			setProperty('blk.alpha',1)
			flash = 0;
		end
		if curStep == 272 then
			setProperty('EndeavorsOGBG.alpha',0)
			setProperty('EndeavorsOGFG.alpha',0)
			flash = 2;
			flashAlpha = 0.6;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('blk.alpha',0)
			setProperty('defaultCamZoom',0.65)
			xx = 800;
			yy = 650;
			xx2 = 1100;
			yy2 = 700;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('floor.alpha',1)
				setProperty('rocks.alpha',1)
				setProperty('lightfg.alpha',1)
				setProperty('columnsfg.alpha',1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('MajLeft.alpha',1)
					setProperty('MajRight.alpha',1)
				end
			end
			setProperty('boyfriend.x', 1150);
			setProperty('dad.x', 210);
		end
		if curStep == 400 or curStep == 528 or curStep == 592 or curStep == 720 or curtep == 848 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',0.6)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 520 or curStep == 1352 then
			flash = 0;
			cancelTween('flsh')
		end
		if curStep == 592 or curStep == 1232 or curStep == 1360 then
			flash = 2;
			flashAlpha = 0.4;
		end
		if curStep == 844 then
			setProperty('blk.alpha',1)
			flash = 0;
			cancelTween('flsh')
		end
		if curStep == 848 then
			setProperty('blk.alpha',0)
			flash = 2;
			flashAlpha = 0.4;
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 800;
			yy = 650;
			xx2 = 1100;
			yy2 = 700;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('floor.alpha',0)
				setProperty('rocks.alpha',0)
				setProperty('lightfg.alpha',0)
				setProperty('columnsfg.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('MajLeft.alpha',0)
					setProperty('MajRight.alpha',0)
				end
				setProperty('FunNeverEnds.alpha',1)
				setProperty('ColMajinFunNeverEnds.alpha',1)
				setProperty('ColBFFunNeverEnds.alpha',1)
			end
			setProperty('boyfriend.x', 1150);
			setProperty('dad.x', 210);
		end
		if curStep == 1096 then
			flash = 0;
			setProperty('blk.alpha',1)
		end
		if curStep == 1104 then
			cancelTween('flsh');
			setProperty('blk.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.45)
			flash = 1;
			flashAlpha = 0.7;
			xx = 800;
			yy = 500;
			xx2 = 1100;
			yy2 = 550;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('floor.alpha',0)
				setProperty('rocks.alpha',0)
				setProperty('lightfg.alpha',0)
				setProperty('columnsfg.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('MajLeft.alpha',0)
					setProperty('MajRight.alpha',0)
				end
				setProperty('HSkyTwo.alpha',1)
				setProperty('HSkyOne.alpha',1)
				setProperty('HGround.alpha',1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('HMajLeft.alpha',1)
					setProperty('HMajRight.alpha',1)
					setProperty('HEgg.alpha',1)
				end
				setProperty('HColumns.alpha',1)
				setProperty('HLight.alpha',1)
				setProperty('HColumnsFG.alpha',1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('HMajLeftFG.alpha',1)
					setProperty('HMajRightFG.alpha',1)
				end
			end
			setProperty('boyfriend.x', 1150);
			setProperty('dad.x', 210);
		end
		if curStep == 1488 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			flash = 1;
			flashAlpha = 0.3;
		end
		if curStep == 1614 then
			flash = 0;
			cancelTween('flsh')
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