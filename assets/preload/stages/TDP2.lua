local beat = -1;
local flash = 2;
local flashAlpha = 0.15;

function onSongStart()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		noteTweenX("note4", 4, 370, 0.25, cubeInOut)
		noteTweenX("note5", 5, 510, 0.25, cubeInOut)
		noteTweenX("note6", 6, 650, 0.25, cubeInOut)
		noteTweenX("note7", 7, 790, 0.25, cubeInOut)
	end
end

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('ground', 'bgs/TDP2/ground', 800, 250);
		setLuaSpriteScrollFactor('ground', 1, 1);
		scaleObject('ground', 2.25, 2.25);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false);
		
		makeLuaSprite('light', 'bgs/TDP2/light', 800, 250);
		setLuaSpriteScrollFactor('light', 1, 1);
		scaleObject('light', 2.25, 2.25);
		setProperty('light.antialiasing', true);
		addLuaSprite('light', true);
		
		setProperty('ground.alpha',0)
		setProperty('light.alpha',0)
	end
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
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
	
	makeLuaSprite('flashin', 'RedVG', 0, 0, 'exe');
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.alpha',0)
	setObjectCamera('flashin', 'camOther')
	setGraphicSize('flashin', FlxG.width, FlxG.height)
end

function onBeatHit()
	if beat == -1 then
		if curBeat % 2 == 0 then
			cancelTween('zoomback');
			setProperty('camGame.zoom',1.85)
			doTweenZoom('zoomback', 'camGame',1.8, 0.5, 'quadOut')
		else
			cancelTween('zoomback');
			setProperty('camGame.zoom',1.85)
			doTweenZoom('zoomback', 'camGame',1.8, 0.5, 'quadOut')
		end
	end
	if beat == 1 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 2 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		else
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if flash == 1 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		end
	end
	if flash == 2 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		else
			cancelTween('flash');
			setProperty('flashin.alpha',flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		end
	end
end

function hideUi(yes)
	if yes == true then
		doTweenAlpha('timeBarBGDis','timeBarBG',0,0.08,'linear')
		doTweenAlpha('timeBarDis','timeBar',0,0.08,'linear')
		doTweenAlpha('timeTxtDis','timeTxt',0,0.08,'linear')
		doTweenAlpha('scoreTxtDis','scoreTxt',0,0.08,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',0,0.08,'linear')
		doTweenAlpha('healthBarDis','healthBar',0,0.08,'linear')
		doTweenAlpha('iconP1Dis','iconP1',0,0.08,'linear')
		doTweenAlpha('iconP2Dis','iconP2',0,0.08,'linear')
	end
	if yes == false then
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

function onUpdate()
	if songName == "soulless" then
		if curStep == 111 then
			beat = 0;
			flash = 0;
		end
		if curStep == 120 then
			doTweenAlpha('blackBG','blk',1,0.5,'linear')
		end
		if curStep == 126 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 128 then
			beat = 2;
			setProperty('blk.alpha',0)
			setProperty('ground.alpha',1)
			setProperty('light.alpha',1)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 160 then
			doTweenAlpha('CH','camHUD',1,2.7,'linear')
		end
		if curStep == 192 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 256 then
			beat = 0;
			cancelTween('flash');
			setProperty('flashin.alpha',0.30)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			doTweenAlpha('blackBG','blk',1,1.35,'linear')
			doTweenAlpha('CH','camHUD',0,1.35,'linear')
		end
		if curStep == 272 then
			setProperty('defaultCamZoom',0.8)
			setProperty('blk.alpha',0)
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 288 then
			doTweenAlpha('CH','camHUD',1,1.35,'linear')
		end
		if curStep == 384 then
			hideUi(true);
			beat = 0;
			setProperty('defaultCamZoom',1)
			doTweenAlpha('groundHide','ground',0,0.1,'linear')
			doTweenAlpha('lightHide','light',0,0.1,'linear')
			doTweenAlpha('blackBG','blk',0.8,1.3,'linear')
		end
		if curStep == 400 then
			hideUi(false);
			beat = 2;
			flash = 2;
			flashAlpha = 0.3;
			setProperty('blk.alpha',0)
			setProperty('defaultCamZoom',0.8)
			doTweenAlpha('groundShow','ground',1,0.1,'linear')
			doTweenAlpha('lightShow','light',1,0.1,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 528 then
			beat = 1;
			flash = 0;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 656 then
			doTweenAlpha('CH','camHUD',0,1.4,'linear')
			beat = 0;
			setProperty('defaultCamZoom',1)
			doTweenAlpha('groundHide','ground',0,0.1,'linear')
			doTweenAlpha('lightHide','light',0,0.1,'linear')
			doTweenAlpha('blackBG','blk',1,1.3,'linear')
		end
		if curStep == 672 then
			beat = 2;
			flash = 2;
			setProperty('blk.alpha',0)
			setProperty('defaultCamZoom',0.8)
			doTweenAlpha('groundShow','ground',1,0.1,'linear')
			doTweenAlpha('lightShow','light',1,0.1,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 788 then
			doTweenAlpha('CH','camHUD',1,1.4,'linear')
		end
		if curStep == 928 or curStep == 944 or curStep == 960 or curStep == 976 or curStep == 992 or curStep == 1008 or curStep == 1024 or curStep == 1040 or curStep == 1056 or curStep == 1072 or curStep == 1088 or curStep == 1104 or curStep == 1120 or curStep == 1136 or curStep == 1152 or curStep == 1168 then
			hideUi(false);
			beat = 2;
			flash = 0;
			setProperty('defaultCamZoom',0.95)
			doTweenAlpha('kklol','blk',0,0.1,'linear')
			doTweenAlpha('groundShow','ground',1,0.1,'linear')
			doTweenAlpha('lightShow','light',1,0.1,'linear')
		end
		if curStep == 938 or curStep == 954 or curStep == 970 or curStep == 986 or curStep == 1002 or curStep == 1018 or curStep == 1034 or curStep == 1050 or curStep == 1066 or curStep == 1082 or curStep == 1098 or curStep == 1114 or curStep == 1130 or curStep == 1146 or curStep == 1162 or curStep == 1178 then
			hideUi(true);
			beat = 0;
			setProperty('defaultCamZoom',0.8)
			doTweenAlpha('groundHide','ground',0,0.1,'linear')
			doTweenAlpha('lightHide','light',0,0.1,'linear')
			doTweenAlpha('kklol','blk',1,0.3,'linear')
		end
		if curStep == 1183 then
			setProperty('defaultCamZoom',0.95)
			setProperty('light.alpha',1)
			setProperty('ground.alpha',1)
			setProperty('camHUD.alpha',0)
			doTweenAlpha('blkmoment','blk',0,0.7,'linear')
			hideUi(false);
		end
		if curStep == 1300 then
			doTweenAlpha('CH','camHUD',1,1.3,'linear')
		end
		if curStep == 1312 then
			beat = 1;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1440 then
			beat = 2;
			flash = 2;
			setProperty('defaultCamZoom',0.8)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1568 then
			setProperty('defaultCamZoom',0.95)
			doTweenAlpha('groundHide','ground',0.7,0.1,'linear')
			doTweenAlpha('lightHide','light',0.7,0.1,'linear')
		end
		if curStep == 1696 then
			beat = 2;
			flash = 2;
			flashAlpha = 0.4;
			doTweenAlpha('groundShow','ground',1,0.1,'linear')
			doTweenAlpha('lightShow','light',1,0.1,'linear')
			setProperty('defaultCamZoom',0.8)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1815 then
			beat = 0;
			flash = 0;
		end
		if curStep == 1824 then
			beat = 2;
			flash = 2;
			setProperty('defaultCamZoom',0.9)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1952 then
			hideUi(true);
			beat = 0;
			flash = 0;
			setProperty('defaultCamZoom',0.85)
			doTweenAlpha('groundHide','ground',0.7,0.1,'linear')
			doTweenAlpha('lightHide','light',0.7,0.1,'linear')
		end
		if curStep == 1968 then
			doTweenAlpha('CH','camHUD',0,1.95,'linear')
			setProperty('defaultCamZoom',0.8)
			doTweenAlpha('groundHide','ground',1,0.5,'linear')
			doTweenAlpha('lightHide','light',1,0.5,'linear')
			doTweenAlpha('bnmkuygfd','blk',1,2.6,'linear')
		end
	end
end