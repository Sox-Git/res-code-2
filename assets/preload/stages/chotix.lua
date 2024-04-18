local flash = 0;
local flashAlpha = 0.5;
local beat = 0;
function onCreate()
	addCharacterToList('xenotix', '1');
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'chotix/hell', -800, 100, 'exe');
		scaleObject('bg', 1.2, 1.2);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', false);
		addLuaSprite('bg', false)
		
		makeLuaSprite('hell1', 'chotix/hell1', -750, 0, 'exe');
		scaleObject('hell1', 1.2, 1.2);
		setScrollFactor('hell1', 1, 1);
		setProperty('hell1.alpha', 0);
		setProperty('hell1.antialiasing', false);
		addLuaSprite('hell1', false)
	
		makeAnimatedLuaSprite('static', 'chotix/EncStatic', -500, -600, 'exe');
		scaleObject('static', 3, 3);
		addAnimationByPrefix('static', 'idle', 'static', 20, true);
		objectPlayAnimation('static', 'idle', true)
		setProperty('static.antialiasing', false);
		addLuaSprite('static', false);
		setBlendMode('static','multiply')
		setProperty('static.alpha',0)
		
		makeLuaSprite('crystals', 'chotix/crystals', -600, -250, 'exe');
		scaleObject('crystals', 1.03, 1.1);
		setScrollFactor('crystals', 0.75, 0.8);
		setProperty('crystals.antialiasing', false);
		addLuaSprite('crystals', true)
		setProperty('crystals.alpha',0)
	end
	
	makeLuaSprite('omg', 'chotix/omg', 0, 0, 'exe');
	setProperty('omg.antialiasing', true);
	setScrollFactor('omg', 0, 0);
	setGraphicSize('omg', 1920, 1080)
	screenCenter('omg')
	setProperty('omg.alpha', 0)
	addLuaSprite('omg', true)

	makeLuaSprite('wh', '', 0, 0);
	makeGraphic('wh',1920,1080,'FFFFFF')
	addLuaSprite('wh', false);
	setLuaSpriteScrollFactor('wh',0,0)
	setProperty('wh.scale.x',4)
	setProperty('wh.scale.y',4)
	setProperty('wh.alpha',0)

	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',4)
	setProperty('blk.scale.y',4)
	setProperty('blk.alpha',0)

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('flashin', 'blueVgV', 0, 0, 'exe');
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.alpha',0)
	setObjectCamera('flashin', 'camOther')
	setGraphicSize('flashin', FlxG.width, FlxG.height)
end

function onBeatHit()
	if beat == -1 then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom')
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
	if flash == -1 then
		if curBeat % 4 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
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

function onUpdate()
	if songName == "long-sky" then
	--816
		if curStep == 744 then
			doTweenAlpha('omg','omg', 1, 0.6, 'linear')
		end
		if curStep == 752 then
			setProperty('omg.alpha', 0)
		end
		if curStep == 880 then
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('wh.alpha', 1)
		end
		if curStep == 1136 then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('wh','wh', 0, 0.6, 'linear')
			setProperty('blk.alpha', 1)
		end
		if curStep == 1168 then
			setProperty('blk.alpha', 0)
		end
		if curStep == 1423 then
			doTweenAlpha('blk','blk',1,0.08,'linear')
			doTweenAlpha('camHUD','camHUD',0,0.08,'linear')
		end
		if curStep == 1464 then
			setProperty('flashingshit.alpha', 1)
			setProperty('blk.alpha',0)
			doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
			doTweenAlpha('camHUD','camHUD',1,0.4,'linear')
			triggerEvent('Change Character', '1','xenotix')
			beat = 2;
			flash = 2;
			setProperty('hell1.alpha',1)
			setProperty('static.alpha',1)
			setProperty('crystals.alpha',1)
		end
		if curStep == 1717 then
			beat = 0;
			flash = 0;
			doTweenAlpha('blk','blk',1,0.08,'linear')
			doTweenAlpha('camHUD','camHUD',0,0.08,'linear')
		end
		if curStep == 1728 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
			triggerEvent('Change Character', '1','chotix')
			setProperty('hell1.alpha',0)
			setProperty('static.alpha',0)
			setProperty('crystals.alpha',0)
			setProperty('blk.alpha',0)
			doTweenAlpha('camHUD','camHUD',1,0.4,'linear')
		end
	end
end