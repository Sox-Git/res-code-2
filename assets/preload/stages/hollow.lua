local xx = 600;
local yy = 450;
local ofs = 25;
local ofs2 = 25;
local xx2 = 700;
local yy2 = 450;
local followchars = true;
local beat = 0;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/devoid-bg/sky', -900, -550);
		scaleObject('sky', 1, 1);
		setScrollFactor('sky', 0.2, 0.6);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false)

		makeLuaSprite('floor', 'bgs/devoid-bg/floor', -800, -550);
		scaleObject('floor', 1.0, 1.0);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false)
		
		makeLuaSprite('fg', 'bgs/devoid-bg/fg', -800, -550);
		scaleObject('fg', 1.0, 1.0);
		setScrollFactor('fg', 0.4, 0.7);
		setProperty('fg.antialiasing', true);
		addLuaSprite('fg', true)
		
		makeLuaSprite('skyD', 'bgs/devoid-bg/sky-dark', -900, -550);
		scaleObject('skyD', 1, 1);
		setScrollFactor('skyD', 0.2, 0.6);
		setProperty('skyD.antialiasing', true);
		addLuaSprite('skyD', false)

		makeLuaSprite('floorD', 'bgs/devoid-bg/floor-dark', -800, -550);
		scaleObject('floorD', 1.0, 1.0);
		setScrollFactor('floorD', 1, 1);
		setProperty('floorD.antialiasing', true);
		addLuaSprite('floorD', false)
		
		makeLuaSprite('fgD', 'bgs/devoid-bg/fg-dark', -800, -550);
		scaleObject('fgD', 1.0, 1.0);
		setScrollFactor('fgD', 0.4, 0.7);
		setProperty('fgD.antialiasing', true);
		addLuaSprite('fgD', true)
		
		setProperty('skyD.alpha',0)
		setProperty('floorD.alpha',0)
		setProperty('fgD.alpha',0)
	end
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	
	makeLuaSprite('blueshit', '', 0, 0);
	makeGraphic('blueshit',1920,1080,'0094FF')
	addLuaSprite('blueshit', true);
	setLuaSpriteScrollFactor('blueshit',0,0)
	setProperty('blueshit.scale.x',2)
	setProperty('blueshit.scale.y',2)
	setProperty('blueshit.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end
function onBeatHit()
	if beat == 1 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
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
	if beat == 3 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 4 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
		else
			triggerEvent('Add Camera Zoom')
		end
	end
end

function onUpdate()
	if beat == -1 then
		if curStep % 2 == 0 then
			if curStep % 2 == 0 then
				triggerEvent('Add Camera Zoom')
			end
		else
			if curStep % 2 == 0 then
				triggerEvent('Add Camera Zoom')
			end
		end
	end
	
	if songName == "hollow" then
		if curStep == 0 then
			setProperty('defaultCamZoom',0.666)
			setProperty('blk.alpha',1)
			setProperty('camHUD.alpha',0)
		end
		if curStep == 5 then
			doTweenAlpha('blackThing','blk',0,5,'quadOut')
		end
		if curStep == 48 then
			doTweenAlpha('camHUDTween','camHUD',1,1.4,'linear')
		end
		if curStep == 64 then
			beat = 3;
		end
		if curStep == 128 then
			beat = 4;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 240 then
			beat = 0;
		end
		if curStep == 256 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 4;
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 383 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 388 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 512 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 3;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 624 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 640 then
			beat = 3;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 880 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
		end
		if curStep == 896 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 4;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',1)
				setProperty('floor.alpha',1)
				setProperty('fg.alpha',1)
				setProperty('skyD.alpha',0)
				setProperty('floorD.alpha',0)
				setProperty('fgD.alpha',0)
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1023 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1028 then
			beat = 4;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1152 then
			beat = 0;
		end
		if curStep == 1152 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1280 then
			beat = 0;
			setProperty('defaultCamZoom',7)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,2.75,'linear')
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 1312 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 2;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',1)
				setProperty('floor.alpha',1)
				setProperty('fg.alpha',1)
				setProperty('skyD.alpha',0)
				setProperty('floorD.alpha',0)
				setProperty('fgD.alpha',0)
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1408 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 3;
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1536 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 0;
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1664 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			doTweenAlpha('blackThing','blk',1,4.2,'linear')
			doTweenAlpha('camHUDTween','camHUD',0,0.9,'linear')
		end
	end
	
    if songName == "hollow-old" then
		if curStep == 0 then
			setProperty('defaultCamZoom',0.666)
			setProperty('blk.alpha',1)
			setProperty('camHUD.alpha',0)
		end
		if curStep == 5 then
			doTweenAlpha('blackThing','blk',0,5,'quadOut')
		end
		if curStep == 48 then
			doTweenAlpha('camHUDTween','camHUD',1,1.4,'linear')
		end
		if curStep == 128 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 4;
		end
		if curStep == 256 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 372 or curStep == 378 then
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 384 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 511 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 516 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 640 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 0;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 704 then
			beat = 3;
		end
		if curStep == 752 then
			beat = 4;
		end
		if curStep == 768 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 2;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',1)
				setProperty('floor.alpha',1)
				setProperty('fg.alpha',1)
				setProperty('skyD.alpha',0)
				setProperty('floorD.alpha',0)
				setProperty('fgD.alpha',0)
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1024 then
			beat = 4;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
		end
		if curStep == 1026 then
			cancelTween('blackThing');
			doTweenAlpha('blackThing','blk',0.3,2.8,'linear')
		end
		if curStep == 1056 then
			cancelTween('blackThing');
			cancelTween('flsh');
			setProperty('blk.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			beat = 2;
		end
		if curStep == 1152 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 0;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 1280 then
			beat = 4;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
		end
		if curStep == 1296 then
			setProperty('blk.alpha',0)
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 2;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',1)
				setProperty('floor.alpha',1)
				setProperty('fg.alpha',1)
				setProperty('skyD.alpha',0)
				setProperty('floorD.alpha',0)
				setProperty('fgD.alpha',0)
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1423 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1428 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1544 then
			beat = 0;
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1552 then
			beat = 2;
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1679 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1684 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1801 then
			beat = 0;
		end
		if curStep == 1808 then
			beat = 4;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('camHUDTween','camHUD',0,1.5,'linear')
		end
		if curStep == 1872 then
			beat = 0;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',1,5.5,'linear')
		end
		if curStep == 1939 then
			doTweenAlpha('camHUDTween','camHUD',1,0.3,'linear')
			doTweenAlpha('blackThing','blk',0,0.4,'linear')
		end
		if curStep == 1944 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',1,3,'linear')
			doTweenAlpha('camHUDTween','camHUD',0,2.5,'linear')
		end
	end
	
    if songName == "hollow-encore" then
		if curStep == 0 then
			beat = 3;
			setProperty('blk.alpha',1)
			setProperty('camHUD.alpha',0)
		end
		if curStep == 10 then
			doTweenAlpha('blackThing','blk',0,10,'quadOut')
		end
		if curStep == 52 then
			doTweenAlpha('bluefuckingshit','blueshit',0.7,0.88,'linear')
		end
		if curStep == 56 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,0.5,'linear')
		end
		if curStep == 64 then
			cancelTween('bluefuckingshit');
			cancelTween('blackThing');
			setProperty('blk.alpha',0)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			setProperty('blueshit.alpha',0)
		end
		if curStep == 96 then
			doTweenAlpha('camHUDTween','camHUD',1,2.5,'linear')
		end
		if curStep == 179 then
			doTweenAlpha('Blue','blueshit',0.7,0.9,'linear')
		end
		if curStep == 192 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 4;
			setProperty('blueshit.alpha',0)
		end
		if curStep == 320 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 1;
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 352 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 384 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 416 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 448 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 480 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 512 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 544 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 572 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 576 then
			beat = 0;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 697 then
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
		end
		if curStep == 704 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',1)
				setProperty('floor.alpha',1)
				setProperty('fg.alpha',1)
				setProperty('skyD.alpha',0)
				setProperty('floorD.alpha',0)
				setProperty('fgD.alpha',0)
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 736 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 768 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 800 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 804 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 816 then
			beat = 0;
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 824 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 832 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 960 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1024 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1088 then
			beat = 0;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 1088 or curStep == 1120 or curStep == 1152 or curStep == 1184 then
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 1216 then
			beat = 1;
		end
		if curStep == 1280 then
			beat = 2;
		end
		if curStep == 1312 then
			beat = -1;
		end
		if curStep == 1328 then
			beat = 0;
			doTweenAlpha('blackThing','blk',1,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',0,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',0,0.08,'linear')
		end
		if curStep == 1344 then
			beat = 1;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blackThing','blk',0,0.1,'linear')
			doTweenAlpha('DevoidUI','DevoidUIControl',1,0.08,'linear')
			doTweenAlpha('DevoidUIIco','DevoidUIControlIcons',1,0.08,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',1)
				setProperty('floor.alpha',1)
				setProperty('fg.alpha',1)
				setProperty('skyD.alpha',0)
				setProperty('floorD.alpha',0)
				setProperty('fgD.alpha',0)
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1472 then
			beat = 0;
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1504 then
			beat = 1;
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1536 then
			beat = 2;
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1600 then
			beat = 4;
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1664 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1696 then
			beat = 0;
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1700 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1712 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1720 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1728 then
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1856 then
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
		end
		if curStep == 1920 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
		end
		if curStep == 1952 then
			beat = 0;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.666)
			xx = 600;
			yy = 450;
			xx2 = 700;
			yy2 = 450;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('floor.alpha',0)
				setProperty('fg.alpha',0)
				setProperty('skyD.alpha',1)
				setProperty('floorD.alpha',1)
				setProperty('fgD.alpha',1)
			end
			setProperty('dad.color', getColorFromHex('525252'))
			setProperty('boyfriend.color', getColorFromHex('525252'))
		end
		if curStep == 1984 then
			setProperty('defaultCamZoom',0.8)
			xx = 600;
			yy = 530;
			xx2 = 700;
			yy2 = 550;
			doTweenAlpha('camHUDTween','camHUD',0,2.2,'linear')
		end
		if curStep == 2000 then
			doTweenAlpha('blackThing','blk',1,21.6,'linear')
		end
	end
	if songName == "empty" then
		if curStep == 0 then
			beat = 1;
			setProperty('defaultCamZoom',0.666)
			setProperty('blk.alpha',1)
			setProperty('camHUD.alpha',0)
		end
		if curStep == 5 then
			doTweenAlpha('blackThing','blk',0,2.5,'quadOut')
		end
		if curStep == 10 then
			doTweenAlpha('camHUDTween','camHUD',1,1.4,'linear')
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