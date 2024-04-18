local xx = 500;
local yy = 400;
local ofs = 25;
local ofs2 = 25;
local xx2 = 725;
local yy2 = 525;
local followchars = true;
local funny = false;
local funnyyyy = false;
local flash = 0;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		--Side
		makeLuaSprite('skySide', 'bgs/too-slow-encore/side/sky', -650, -700);
		scaleObject('skySide', 1, 1);
		setScrollFactor('skySide', 0.4, 0.8);
		setProperty('skySide.antialiasing', true);
		addLuaSprite('skySide', false)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('waterSide', 'bgs/too-slow-encore/side/water', -650, -700);
			scaleObject('waterSide', 1, 1);
			setScrollFactor('waterSide', 0.6, 0.85);
			setProperty('waterSide.antialiasing', true);
			addLuaSprite('waterSide', false)
			
			makeLuaSprite('waterfallSide', 'bgs/too-slow-encore/side/waterfall', -650, -700);
			scaleObject('waterfallSide', 1, 1);
			setScrollFactor('waterfallSide', 0.8, 0.9);
			setProperty('waterfallSide.antialiasing', true);
			addLuaSprite('waterfallSide', false)
		end
		
		makeLuaSprite('groundSide', 'bgs/too-slow-encore/side/ground', -650, -700);
		scaleObject('groundSide', 1, 1);
		setScrollFactor('groundSide', 1, 1);
		setProperty('groundSide.antialiasing', true);
		addLuaSprite('groundSide', false)
		
		--Classic
		makeLuaSprite('sky', 'bgs/too-slow-encore/sky', -620, -700);
		scaleObject('sky', 1, 1);
		setScrollFactor('sky', 0.3, 0.75);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('water', 'bgs/too-slow-encore/water', -620, -700);
			scaleObject('water', 1, 1);
			setScrollFactor('water', 0.5, 0.8);
			setProperty('water.antialiasing', true);
			addLuaSprite('water', false)
			
			makeLuaSprite('mountains', 'bgs/too-slow-encore/mountains', -650, -700);
			scaleObject('mountains', 1, 1);
			setScrollFactor('mountains', 0.6, 0.85);
			setProperty('mountains.antialiasing', true);
			addLuaSprite('mountains', false)
			
			makeLuaSprite('waterfall', 'bgs/too-slow-encore/waterfall', -650, -700);
			scaleObject('waterfall', 1, 1);
			setScrollFactor('waterfall', 0.8, 0.9);
			setProperty('waterfall.antialiasing', true);
			addLuaSprite('waterfall', false)
		end
		
		makeLuaSprite('ground', 'bgs/too-slow-encore/ground', -650, -700);
		scaleObject('ground', 1, 1);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false)
	end
	makeLuaSprite('redBG', '', 0, 0);
	makeGraphic('redBG',1920,1080,'FF0000')
	addLuaSprite('redBG', false);
	setLuaSpriteScrollFactor('redBG',0,0)
	setProperty('redBG.scale.x',2)
	setProperty('redBG.scale.y',2)
	setProperty('redBG.alpha',0)
	
	--Other Shit
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', false);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)

	makeLuaSprite('blkDuh', '', 0, 0);
	makeGraphic('blkDuh',1920,1080,'000000')
	addLuaSprite('blkDuh', true);
	setLuaSpriteScrollFactor('blkDuh',0,0)
	setProperty('blkDuh.scale.x',2)
	setProperty('blkDuh.scale.y',2)
	setProperty('blkDuh.alpha',0)
	
	setProperty('sky.alpha', 0);
	setProperty('water.alpha', 0);
	setProperty('mountains.alpha', 0);
	setProperty('waterfall.alpha', 0);
	setProperty('ground.alpha', 0);
	
	makeLuaSprite('flashin', 'RedVG', 0, 0, 'exe');
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.alpha',0)
	setObjectCamera('flashin', 'camHUD')
	setGraphicSize('flashin', FlxG.width, FlxG.height)
end

function onBeatHit()
	if funny == true then
		if curBeat % 2 == 0 then
			setProperty('camGame.angle',-0.7)
			doTweenAngle('rotateGame1', 'camGame',0, 0.15, 'quadOut')
			setProperty('camHUD.y',-5)
			doTweenY('xHud1','camHUD',0,0.15,'linear')
		else
			if curBeat % 1 == 0 then
				setProperty('camGame.angle',0.7)
				doTweenAngle('rotate2', 'camGame',0, 0.15, 'quadOut')
				setProperty('camHUD.y',5)
				doTweenY('xHud1','camHUD',0,0.15,'linear')
			end
		end
	end
	if funnyyyy == true then
		if curBeat % 2 == 0 then
			setProperty('iconP2.angle', -8);
			doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

			setProperty('iconP1.angle', -8);
			doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
		else
			if curBeat % 1 == 0 then
				setProperty('iconP2.angle', 8);
				doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

				setProperty('iconP1.angle', 8);
				doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
			end
		end
	end
	if flash == 1 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', 0.7)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if flash == 2 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', 0.8)
			doTweenAlpha('flash','flashin',0,0.4,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flash');
			setProperty('flashin.alpha',0.8)
			doTweenAlpha('flash','flashin',0,0.4,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "too-slow-encore" then
		if curStep == 0 then
			setProperty('gf.visible', false);
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skySide.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('waterSide.alpha', 1);
					setProperty('waterfallSide.alpha', 1);
				end
				setProperty('groundSide.alpha', 1);
				setProperty('sky.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('water.alpha', 0);
					setProperty('mountains.alpha', 0);
					setProperty('waterfall.alpha', 0);
				end
				setProperty('ground.alpha', 0);
			end
		end
		if curStep == 386 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skySide.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('waterSide.alpha', 0);
					setProperty('waterfallSide.alpha', 0);
				end
				setProperty('groundSide.alpha', 0);
				setProperty('sky.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('water.alpha', 1);
					setProperty('mountains.alpha', 1);
					setProperty('waterfall.alpha', 1);
				end
				setProperty('ground.alpha', 1);
			end
			setProperty('gf.visible', true);
			triggerEvent('Change Character', '0', 'bf-encore');
			setProperty('boyfriend.x', 790);
			setProperty('boyfriend.y', 365);
			setProperty('dad.x', -200);
			setProperty('dad.y', 120);
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 392 then
			doTweenAlpha('blk1','blk',0.7,0.5,'linear')
			doTweenAlpha('ch1','camHUD',0,0.25,'linear')
			setProperty('defaultCamZoom',1)
			xx = 100;
			yy = 520;
			xx2 = 100;
			yy2 = 520;
		end
		if curStep == 400 or curStep == 402 or curStep == 404 or curStep == 406 or curStep == 408 or curStep == 410 or curStep == 412 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.3,'linear')
		end
		if curStep == 412 then
			doTweenAlpha('blk2','blk',0,0.5,'linear')
			doTweenAlpha('ch2','camHUD',1,0.5,'linear')
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 416 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 928 then
			setProperty('dad.x', -128);
			setProperty('dad.y', 84.5);
		end
		if curStep == 1424 or curStep == 1428 or curStep == 1432 or curStep == 1436 or curStep == 1440 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.3,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 1420 then
			doTweenAlpha('blk3','blk',0.7,0.5,'linear')
			doTweenAlpha('ch3','camHUD',0.6,0.25,'linear')
			setProperty('defaultCamZoom',1)
			xx = 100;
			yy = 520;
			xx2 = 100;
			yy2 = 520;
		end
		if curStep == 1440 then
			doTweenAlpha('blk4','blk',0,0.5,'linear')
			doTweenAlpha('ch4','camHUD',1,0.5,'linear')
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 1888 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('ch5','camHUD',0,1.5,'linear')
			doTweenAlpha('duh','blkDuh',1,3.15,'linear')
		end
	end
	
	if songName == "too-slow-encore-alt" then
		if curStep == 0 then
			setProperty('gf.visible', false);
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skySide.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('waterSide.alpha', 1);
					setProperty('waterfallSide.alpha', 1);
				end
				setProperty('groundSide.alpha', 1);
				setProperty('sky.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('water.alpha', 0);
					setProperty('mountains.alpha', 0);
					setProperty('waterfall.alpha', 0);
				end
				setProperty('ground.alpha', 0);
			end
		end
		if curStep == 384 then
			doTweenAlpha('ch1','camHUD',0,0.25,'linear')
			doTweenAlpha('blkduhuh1','blkDuh',1,0.5,'linear')
		end
		if curStep == 399 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('skySide.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('waterSide.alpha', 0);
					setProperty('waterfallSide.alpha', 0);
				end
				setProperty('groundSide.alpha', 0);
				setProperty('sky.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('water.alpha', 1);
					setProperty('mountains.alpha', 1);
					setProperty('waterfall.alpha', 1);
				end
				setProperty('ground.alpha', 1);
			end
			setProperty('gf.visible', true);
			triggerEvent('Change Character', '0', 'bf-encore');
			setProperty('boyfriend.x', 790);
			setProperty('boyfriend.y', 365);
			setProperty('dad.x', -200);
			setProperty('dad.y', 320);
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 400 then
			doTweenAlpha('dgfhgj','blkDuh',0,0.2,'linear')
			doTweenAlpha('blk1','blk',0.7,0.3,'linear')
			setProperty('defaultCamZoom',1)
			xx = 100;
			yy = 520;
			xx2 = 100;
			yy2 = 520;
		end
		if curStep == 400 or curStep == 402 or curStep == 404 or curStep == 406 or curStep == 408 or curStep == 410 or curStep == 412 or curStep == 414 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.25,'linear')
		end
		if curStep == 416 then
			cancelTween('flsh');
			doTweenAlpha('blk2','blk',0,0.3,'linear')
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('chhh','camHUD',1,0.25,'linear')
			funny = true;
			funnyyyy = true;
			flash = 2;
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 672 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			funny = false;
			funnyyyy = false;
			flash = 1;
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
		end
		if curStep == 800 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			funny = true;
			funnyyyy = true;
			flash = 2;
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 928 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('redBG1','redBG',1,0.3,'linear')
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('gf.visible', false);
			funny = false;
			funnyyyy = false;
			flash = 0;
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
			doTweenAlpha('ch2','camHUD',0,1,'linear')
		end
		if curStep == 1008 then
			xx = 100;
			xx2 = 100;
		end
		if curStep == 1008 or curStep == 1016 or curStep == 1024 or curStep == 1032 or curStep == 1040 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.6,'linear')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 1048 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('redBG2','redBG',0,0.3,'linear')
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('gf.visible', true);
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
			doTweenAlpha('ch3','camHUD',1,0.5,'linear')
		end
		if curStep == 1056 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			funny = true;
			funnyyyy = true;
			flash = 2;
		end
		if curStep == 1172 then
			doTweenAlpha('ch4','camHUD',0.7,0.4,'linear')
			doTweenAlpha('blk3','blk',0.7,0.4,'linear')
			setProperty('defaultCamZoom',1)
			xx = 100;
			yy = 520;
			xx2 = 100;
			yy2 = 520;
			funny = false;
			funnyyyy = false;
			flash = 0;
		end
		if curStep == 1176 or curStep == 1178 or curStep == 1180 or curStep == 1182 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.25,'linear')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 1184 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('tupoiukjhg','blk',0,0.25,'linear')
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
			doTweenAlpha('ch5','camHUD',1,0.4,'linear')
			funny = true;
			funnyyyy = true;
			flash = 2;
		end
		if curStep == 1312 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
		end
		if curStep == 1494 then
			doTweenAlpha('ch4','camHUD',0.7,0.4,'linear')
			doTweenAlpha('blk3','blk',0.7,0.4,'linear')
			setProperty('defaultCamZoom',1)
			xx = 100;
			yy = 520;
			xx2 = 100;
			yy2 = 520;
			funny = false;
			funnyyyy = false;
			flash = 0;
		end
		if curStep == 1496 or curStep == 1498 or curStep == 1500 or curStep == 1502 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.25,'linear')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 1448 or curStep == 1464 or curStep == 1480 or curStep == 1504 or curStep == 1520 or curStep == 1536 or curStep == 1552 then
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 1456 or curStep == 1472 or curStep == 1488 or curStep == 1512 or curStep == 1528 or curStep == 1544 or curStep == 1568 then
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
		end
		if curStep == 1504 then
			doTweenAlpha('ertgf','blk',0,0.25,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			funny = true;
			funnyyyy = true;
			flash = 2;
			doTweenAlpha('ch5','camHUD',1,0.4,'linear')
		end
		if curStep == 1568 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			funny = false;
			funnyyyy = false;
			flash = 1;
		end
		if curStep == 1600 or curStep == 1664 then
			flash = 2;
		end
		if curStep == 1632 then
			flash = 1;
		end
		if curStep == 1677 then
			doTweenAlpha('ch6','camHUD',0.7,0.4,'linear')
			doTweenAlpha('blk3','blk',0.7,0.4,'linear')
			setProperty('defaultCamZoom',1)
			xx = 100;
			yy = 520;
			xx2 = 100;
			yy2 = 520;
			funny = false;
			funnyyyy = false;
			flash = 0;
		end
		if curStep == 1680 or curStep == 1682 or curStep == 1684 or curStep == 1686 or curStep == 1688 or curStep == 1690 or curStep == 1692 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.25,'linear')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 1696 then
			doTweenAlpha('ikjhgfd','blk',0,0.25,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			funny = true;
			funnyyyy = true;
			flash = 2;
			doTweenAlpha('ch7','camHUD',1,0.4,'linear')
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 1816 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('redBG3','redBG',1,0.3,'linear')
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('gf.visible', false);
			funny = false;
			funnyyyy = false;
			flash = 0;
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
			doTweenAlpha('ch8','camHUD',0,0.25,'linear')
		end
		if curStep == 1824 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.8)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('redBG4','redBG',0,0.3,'linear')
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('gf.visible', true);
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
			funny = true;
			funnyyyy = true;
			flash = 2;
			doTweenAlpha('ch9','camHUD',1,0.5,'linear')
		end
		if curStep == 1888 then
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
		end
		if curStep == 1920 then
			setProperty('defaultCamZoom',0.65)
			xx = 420;
			yy = 430;
			xx2 = 645;
			yy2 = 430;
		end
		if curStep == 1948 then
			funny = false;
			funnyyyy = false;
			flash = 0;
		end
		if curStep == 1958 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('redBG3','redBG',1,0.3,'linear')
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('gf.visible', false);
			funny = false;
			funnyyyy = false;
			flash = 0;
			setProperty('defaultCamZoom',0.8)
			xx = 360;
			yy = 550;
			xx2 = 585;
			yy2 = 550;
			doTweenAlpha('ch8','camHUD',0,1,'linear')
		end
		if curStep == 1961 then
			doTweenAlpha('blsfgfg','blkDuh',1,2.8,'linear')
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
			if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
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