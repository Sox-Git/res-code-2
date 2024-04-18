local particles = false;
local particlesSpeed = 1;
local particlesAmount = 0;
local particlesSize = 1;
local particleBeat = false;
local particleCurBeat = 2;
local beat = 0;
local beatFlash = 0;

function onCreate()
	addHaxeLibrary('FlxText', 'flixel.text');
	addHaxeLibrary('FlxTextAlign', 'flixel.text');
	addHaxeLibrary('FlxColor', 'flixel.util');
	addHaxeLibrary('FlxObject', 'flixel');

	makeLuaSprite('bg', '', 0, 0);
	makeGraphic('bg',1920,1080,'FFFFFF')
	addLuaSprite('bg', false);
	screenCenter('bg')
	setLuaSpriteScrollFactor('bg',0,0)
	setProperty('bg.scale.x',4)
	setProperty('bg.scale.y',4)
	setProperty('bg.alpha', 0);

	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/mono/sky', -900, -400);
		scaleObject('sky', 1, 1);
		setScrollFactor('sky', 0.3, 0.3);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false);
		
		makeLuaSprite('glow', 'bgs/mono/glow', -900, -700);
		scaleObject('glow', 1, 1);
		setScrollFactor('glow', 0.3, 0.3);
		setProperty('glow.antialiasing', true);
		addLuaSprite('glow', false);
		
		makeLuaSprite('etc', 'bgs/mono/cool', -350, -200);
		scaleObject('etc', 1, 1);
		setScrollFactor('etc', 0.7, 0.7);
		setProperty('etc.antialiasing', true);
		addLuaSprite('etc', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('wtf', 'bgs/mono/cube', -150, 0);
			scaleObject('wtf', 1, 1);
			setScrollFactor('wtf', 0.90, 0.90);
			setProperty('wtf.antialiasing', true);
			addLuaSprite('wtf', false);
		
			makeLuaSprite('flow1', 'bgs/mono/flower-1', -150, 0);
			scaleObject('flow1', 1, 1);
			setScrollFactor('flow1', 0.90, 0.90);
			setProperty('flow1.antialiasing', true);
			addLuaSprite('flow1', false);
		end
		
		makeLuaSprite('tree', 'bgs/mono/tree', -150, 0);
		scaleObject('tree', 1, 1);
		setScrollFactor('tree', 0.90, 0.90);
		setProperty('tree.antialiasing', true);
		addLuaSprite('tree', false);
		
		makeLuaSprite('ground', 'bgs/mono/floor', 0, 0);
		scaleObject('ground', 1, 1);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('flow2', 'bgs/mono/flower-2', -300, -50);
			scaleObject('flow2', 1, 1);
			setScrollFactor('flow2', 0.75, 0.75);
			setProperty('flow2.antialiasing', true);
			addLuaSprite('flow2', true);
		end
		
		makeLuaSprite('staticMap', 'staticMap', 0, 0);
		setScrollFactor('staticMap', 1, 1);
		setProperty('staticMap.antialiasing', true);
		addLuaSprite('staticMap', true);
		setScrollFactor('staticMap', 0, 0);
		setObjectCamera('staticMap', 'camOther')
		setGraphicSize('staticMap', 1280, 720)
		setProperty('staticMap.alpha', 0.25)
		
		makeAnimatedLuaSprite('stat1', 'bgs/omw/staticOMW', 0, 0);
		addAnimationByPrefix('stat1', 'idle', 'stat', 30, true);
		setProperty('stat1.antialiasing', true);
		addLuaSprite('stat1', true);
		setScrollFactor('stat1', 0, 0);
		setObjectCamera('stat1', 'camOther')
		setGraphicSize('stat1', 1280, 720)
		screenCenter('stat1')
		setBlendMode('stat1','SUBTRACT')
		setProperty('stat1.alpha', 1)
		
		makeAnimatedLuaSprite('stat2', 'bgs/gameover/toofarstatic', 0, 0);
		addAnimationByPrefix('stat2', 'idle', 'toofarstatic idle', 30, true);
		setProperty('stat2.antialiasing', true);
		addLuaSprite('stat2', true);
		setScrollFactor('stat2', 0, 0);
		setObjectCamera('stat2', 'camOther')
		setGraphicSize('stat2', 1280, 720)
		screenCenter('stat2')
		setBlendMode('stat2','SUBTRACT')
		setProperty('stat2.alpha', 1)
		
		makeLuaSprite('vg', 'bgs/gameover/vg', 0, 0);
		setScrollFactor('vg', 1, 1);
		setProperty('vg.antialiasing', true);
		addLuaSprite('vg', true);
		setScrollFactor('vg', 0, 0);
		setObjectCamera('vg', 'camOther')
		setGraphicSize('vg', 1280, 720)
		setProperty('vg.alpha', 1)
		
		makeLuaSprite('bgCol', '', 0, 0);
		makeGraphic('bgCol',1920,1080,'FFFFFF')
		addLuaSprite('bgCol', false);
		screenCenter('bgCol')
		setLuaSpriteScrollFactor('bgCol',0,0)
		setProperty('bgCol.scale.x',4)
		setProperty('bgCol.scale.y',4)
		setProperty('bgCol.alpha', 0);
		
		makeLuaSprite('blackScreen', '', 0, 0);
		makeGraphic('blackScreen',1920,1080,'000000')
		addLuaSprite('blackScreen', false);
		screenCenter('blackScreen')
		setLuaSpriteScrollFactor('blackScreen',0,0)
		setProperty('blackScreen.scale.x',4)
		setProperty('blackScreen.scale.y',4)
		setProperty('blackScreen.alpha', 0);
		setObjectCamera('blackScreen', 'camHUD')
		
		makeLuaSprite('flashB', '', 0, 0);
		makeGraphic('flashB',1920,1080,'FFFFFF')
		addLuaSprite('flashB', true);
		screenCenter('flashB')
		setLuaSpriteScrollFactor('flashB',0,0)
		setProperty('flashB.scale.x',4)
		setProperty('flashB.scale.y',4)
		setProperty('flashB.alpha',0)
		setObjectCamera('flashB', 'camOther')
		
		makeLuaSprite('flash', '', 0, 0);
		makeGraphic('flash',1920,1080,'FFFFFF')
		addLuaSprite('flash', true);
		screenCenter('flash')
		setLuaSpriteScrollFactor('flash',0,0)
		setProperty('flash.scale.x',4)
		setProperty('flash.scale.y',4)
		setProperty('flash.alpha',0)
		setObjectCamera('flash', 'camOther')
	end
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
	
	if beatFlash == 1 then
		if curBeat % 2 == 0 then else
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.6)
			doTweenAlpha('flshBeat','flash',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beatFlash == 2 then
		if curBeat % 2 == 0 then
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.6)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.6)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beatFlash == 3 then
		if curBeat % 2 == 0 then else
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.3)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beatFlash == 4 then
		if curBeat % 2 == 0 then
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.3)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.3)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beatFlash == 5 then
		if curBeat % 2 == 0 then else
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.15)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beatFlash == 6 then
		if curBeat % 2 == 0 then
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.15)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flshBeat');
			setProperty('flashB.alpha',0.15)
			doTweenAlpha('flshBeat','flashB',0,0.5,'linear')
			triggerEvent('Add Camera Zoom')
		end
	end
end
function onUpdate()
	if particles == true then
		if particleBeat == true then
			if particleCurBeat == 4 then
				if curBeat % 4 == 0 then
					particlesSpeed = 3;
					particlesSize = 2;
					particlesAmount = 0;
				else
					particlesSpeed = 1;
					particlesSize = 1;
					particlesAmount = 0;
				end
			end
			if particleCurBeat == 3 then
				if curBeat % 3 == 0 then
					particlesSpeed = 4;
					particlesSize = 3;
					particlesAmount = 0;
				else
					particlesSpeed = 1;
					particlesSize = 1;
					particlesAmount = 0;
				end
			end
			if particleCurBeat == 2 then
				if curBeat % 2 == 0 then
					particlesSpeed = 6;
					particlesSize = 5;
					particlesAmount = 0;
				else
					particlesSpeed = 1;
					particlesSize = 1;
					particlesAmount = 0;
				end
			end
			if particleCurBeat == 1 then
				if curBeat % 1 == 0 then
					particlesSpeed = 3;
					particlesSize = 2;
					particlesAmount = 1;
				else
					particlesSpeed = 1;
					particlesSize = 1;
					particlesAmount = 0;
				end
			end
		end
		runHaxeCode([[
			if (]]..particlesSpeed..[[ != 0) {
				switch (FlxG.random.int(0, ]]..particlesAmount..[[)) {
					case 0:
						var particle:FlxSprite = new FlxSprite((game.boyfriend.x-game.dad.x)+FlxG.random.int(-1150, 1150)+1050,(game.boyfriend.x-game.dad.x)+850).makeGraphic(25, 25, 0xFF000000); 
						switch(]]..particlesSize..[[) {
							case 1: var size:Int = FlxG.random.int(5, 35);
							case 2: var size:Int = FlxG.random.int(10, 45);
							case 3: var size:Int = FlxG.random.int(15, 55);
							case 4: var size:Int = FlxG.random.int(20, 65);
							case 5: var size:Int = FlxG.random.int(25, 75);
						}
						switch(]]..particlesSpeed..[[) {
							case -1: var time:Int = FlxG.random.float(20, 30);
							case 1: var time:Int = FlxG.random.float(15, 25);
							case 2: var time:Int = FlxG.random.float(10, 20);
							case 3: var time:Int = FlxG.random.float(5, 15);
							case 4: var time:Int = FlxG.random.float(2.5, 10);
							case 5: var time:Int = FlxG.random.float(1, 5);
							case 6: var time:Int = 1;
						}
						particle.setGraphicSize(size, size);
						particle.antialiasing = ClientPrefs.globalAntialiasing;
						particle.scrollFactor.set(FlxG.random.float(0.6, 1), FlxG.random.float(0.75, 1));
						particle.alpha = FlxG.random.float(0.1, 0.7);
						if (game.curBeat % 2 == 0 && ]]..particlesSpeed..[[ == 1) {
							FlxTween.tween(particle, {y: -FlxG.height - 1000}, time-10, {ease: FlxEase.easeInOut, onComplete: function(twn:FlxTween) {particle.destroy();}});
							FlxTween.tween(particle, {angle: 1000}, time-10.5, {ease: FlxEase.easeInOut});
						} else {
							FlxTween.tween(particle, {y: -FlxG.height - 1000}, time, {ease: FlxEase.easeInOut, onComplete: function(twn:FlxTween) {particle.destroy();}});
							if (]]..particlesSpeed..[[ == 6)
								FlxTween.tween(particle, {angle: 1000}, time, {ease: FlxEase.easeInOut});
							else
								FlxTween.tween(particle, {angle: 1000}, time-0.5, {ease: FlxEase.easeInOut});
						}
						game.insert(game.members.indexOf(game.modchartSprites.get('glow'))+1, particle);
				}
			}
		]])
	end
	
	if songName == "color-blind" then
		if curStep == 0 then
			setProperty('boyfriend.alpha', 0);
			setProperty('dad.alpha', 0);
			doTweenAlpha('bg','bg', 0.6, 13,'linear')
			doTweenAlpha('boyfriend','boyfriend', 0.7, 13,'linear')
			doTweenAlpha('dad','dad', 0.7, 13,'linear')

			setProperty('sky.alpha', 0);
			setProperty('glow.alpha', 0);
			setProperty('etc.alpha', 0);
			setProperty('ground.alpha', 0);
			setProperty('wtf.alpha', 0);
			setProperty('flow1.alpha', 0);
			setProperty('tree.alpha', 0);
			setProperty('flow2.alpha', 0);
		
			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.02,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.02,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.02,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.02,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.02,'linear')
			setProperty('timeBar.visible', false);
			setProperty('timeBarBGBG.visible', false);
			setProperty('timeBarBG.visible', false);
			setProperty('timeTxt.visible', false);
		end
		if curStep == 5 then
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBGBG.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			setProperty('timeBar.visible', true);
			setProperty('timeBarBGBG.visible', true);
			setProperty('timeBarBG.visible', true);
			setProperty('timeTxt.visible', true);
		end
		
		if curStep == 128 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			doTweenAlpha('flsh','flash',0,1,'linear')
			
			setProperty('bg.alpha',0)
			setProperty('boyfriend.alpha',1)
			setProperty('dad.alpha',1)
			
			setProperty('sky.alpha', 1);
			setProperty('glow.alpha', 1);
			setProperty('etc.alpha', 1);
			setProperty('ground.alpha', 1);
			setProperty('wtf.alpha', 1);
			setProperty('flow1.alpha', 1);
			setProperty('tree.alpha', 1);
			setProperty('flow2.alpha', 1);
			
			setProperty('staticMap.alpha', 0);
			setProperty('stat1.alpha', 0);
			setProperty('stat2.alpha', 0);
			setProperty('vg.alpha', 0);
		
			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.5,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.5,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.5,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.5,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.5,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.5,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.5,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.5,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.5,'linear')
			
			beat = 4;
		end
		if curStep == 252 then
			cancelTween('flsh');
			setProperty('flash.color', getColorFromHex('444444'))
			doTweenAlpha('flsh','flash',1,0.39,'linear')
		end
		if curStep == 256 then
			cancelTween('flsh');
			doTweenAlpha('flsh','flash',0,0.39,'linear')
			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('bgCol.color', getColorFromHex('FFFFFF'));
			setProperty('bgCol.alpha', 1);
			beat = 0;
			
			setProperty('sky.alpha', 0);
			setProperty('glow.alpha', 0);
			setProperty('etc.alpha', 0);
			setProperty('ground.alpha', 0);
			setProperty('wtf.alpha', 0);
			setProperty('flow1.alpha', 0);
			setProperty('tree.alpha', 0);
			setProperty('flow2.alpha', 0);
			
			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 0, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 0, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 0, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 0, 0.15,'linear')
		end
		if curStep == 272 then
			cancelTween('flsh');
			setProperty('flash.color', getColorFromHex('000000'))
			doTweenAlpha('flsh','flash',1,0.39,'linear')
			beat = 4;
		end
		if curStep == 276 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('bgCol.color', getColorFromHex('FFFFFF'));
			setProperty('bgCol.alpha', 0);
			
			setProperty('sky.alpha', 1);
			setProperty('glow.alpha', 1);
			setProperty('etc.alpha', 1);
			setProperty('ground.alpha', 1);
			setProperty('wtf.alpha', 1);
			setProperty('flow1.alpha', 1);
			setProperty('tree.alpha', 1);
			setProperty('flow2.alpha', 1);
			
			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.3,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.3,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.3,'linear')
			beatFlash = 3;
		end
		if curStep == 527 then
			doTweenAlpha('flsh','flash',1,0.1,'linear')
		end
		if curStep == 528 then
			beat = 4;
			beatFlash = 0;
			setProperty('defaultCamZoom',0.8)
			
			cancelTween('flsh');
			doTweenAlpha('flsh','flash',0,1,'linear')
			
			setProperty('sky.color', getColorFromHex('777777'));
			setProperty('glow.color', getColorFromHex('777777'));
			setProperty('etc.color', getColorFromHex('777777'));
			setProperty('ground.color', getColorFromHex('777777'));
			setProperty('wtf.color', getColorFromHex('777777'));
			setProperty('flow1.color', getColorFromHex('777777'));
			setProperty('tree.color', getColorFromHex('777777'));
			setProperty('flow2.color', getColorFromHex('777777'));
		end
		if curStep == 652 then
			cancelTween('flsh');
			setProperty('flash.color', getColorFromHex('444444'))
			doTweenAlpha('flsh','flash',1,0.39,'linear')
		end
		if curStep == 656 then
			cancelTween('flsh');
			doTweenAlpha('flsh','flash',0,0.39,'linear')
			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('bgCol.color', getColorFromHex('FFFFFF'));
			setProperty('bgCol.alpha', 1);
			beat = 0;

			setProperty('sky.color', getColorFromHex('FFFFFF'));
			setProperty('glow.color', getColorFromHex('FFFFFF'));
			setProperty('etc.color', getColorFromHex('FFFFFF'));
			setProperty('ground.color', getColorFromHex('FFFFFF'));
			setProperty('wtf.color', getColorFromHex('FFFFFF'));
			setProperty('flow1.color', getColorFromHex('FFFFFF'));
			setProperty('tree.color', getColorFromHex('FFFFFF'));
			setProperty('flow2.color', getColorFromHex('FFFFFF'));

			setProperty('sky.alpha', 0);
			setProperty('glow.alpha', 0);
			setProperty('etc.alpha', 0);
			setProperty('ground.alpha', 0);
			setProperty('wtf.alpha', 0);
			setProperty('flow1.alpha', 0);
			setProperty('tree.alpha', 0);
			setProperty('flow2.alpha', 0);

			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 0, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 0, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 0, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 0, 0.15,'linear')
		end
	
		if curStep == 672 then
			setProperty('defaultCamZoom',0.7)
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('bgCol.color', getColorFromHex('FFFFFF'));
			setProperty('bgCol.alpha', 0);
			
			setProperty('sky.alpha', 1);
			setProperty('glow.alpha', 1);
			setProperty('etc.alpha', 1);
			setProperty('ground.alpha', 1);
			setProperty('wtf.alpha', 1);
			setProperty('flow1.alpha', 1);
			setProperty('tree.alpha', 1);
			setProperty('flow2.alpha', 1);
			
			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.3,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.3,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.3,'linear')
			beatFlash = 3;
			beat = 4;
		end
		if curStep == 799 or curStep == 864 or curStep == 924 then
			doTweenAlpha('blackScreen','blackScreen', 1, 0.15,'linear')
			beatFlash = 0;
			beat = 0;
			
			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 0, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 0, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 0, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 0, 0.15,'linear')
		end
		if curStep == 804 or curStep == 868 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('blackScreen.alpha',0)
			beatFlash = 3;
			beat = 4;
			
			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.15,'linear')
		end
		if curStep == 928 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('blackScreen.alpha',0)
			beatFlash = 0;
			beat = 2;
			
			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 0, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 0, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 0, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 0, 0.15,'linear')
			
			setProperty('defaultCamZoom',0.75)
			
			setProperty('sky.color', getColorFromHex('858585'));
			setProperty('glow.color', getColorFromHex('858585'));
			setProperty('etc.color', getColorFromHex('858585'));
			setProperty('ground.color', getColorFromHex('858585'));
			setProperty('wtf.color', getColorFromHex('858585'));
			setProperty('flow1.color', getColorFromHex('858585'));
			setProperty('tree.color', getColorFromHex('858585'));
			setProperty('flow2.color', getColorFromHex('858585'));
		end
		if curStep == 1056 then
			beatFlash = 6;
			beat = 4;
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 1120 then
			beatFlash = 4;
			beat = 4;
			setProperty('defaultCamZoom',0.85)
			
			setProperty('sky.color', getColorFromHex('666666'));
			setProperty('glow.color', getColorFromHex('666666'));
			setProperty('etc.color', getColorFromHex('666666'));
			setProperty('ground.color', getColorFromHex('666666'));
			setProperty('wtf.color', getColorFromHex('666666'));
			setProperty('flow1.color', getColorFromHex('666666'));
			setProperty('tree.color', getColorFromHex('666666'));
			setProperty('flow2.color', getColorFromHex('666666'));
		end
		if curStep == 1180 then
			doTweenAlpha('blackScreen','blackScreen', 1, 0.2,'linear')
			beatFlash = 0;
			beat = 0;
		end
		if curStep == 1184 then
			setProperty('defaultCamZoom',0.7)
			doTweenAlpha('blackScreen','blackScreen', 0, 0.2,'linear')
			beatFlash = 3;
			beat = 4;
		end
		if curStep == 1188 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			
			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.15,'linear')
			
			setProperty('sky.color', getColorFromHex('FFFFFF'));
			setProperty('glow.color', getColorFromHex('FFFFFF'));
			setProperty('etc.color', getColorFromHex('FFFFFF'));
			setProperty('ground.color', getColorFromHex('FFFFFF'));
			setProperty('wtf.color', getColorFromHex('FFFFFF'));
			setProperty('flow1.color', getColorFromHex('FFFFFF'));
			setProperty('tree.color', getColorFromHex('FFFFFF'));
			setProperty('flow2.color', getColorFromHex('FFFFFF'));
		end
		if curStep == 1252 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
		end
		if curStep == 1308 then
			doTweenAlpha('blackScreen','blackScreen', 1, 0.15,'linear')
			beatFlash = 0;
			beat = 0;
			
			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 0, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 0, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 0, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 0, 0.15,'linear')
		end
		if curStep == 1312 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('blackScreen.alpha',0)

			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.5,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.5,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.5,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.5,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.5,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.5,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.5,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.5,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.5,'linear')
			
			beat = 4;
		end
		if curStep == 1376 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			beat = 0;
		end
		if curStep == 1440 or curStep == 1952 then
			if curStep == 1952 then
				setProperty('defaultCamZoom',0.85)
			end
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')

			setProperty('boyfriend.color', getColorFromHex('000000'))
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('bgCol.color', getColorFromHex('FFFFFF'));
			setProperty('bgCol.alpha', 1);

			setProperty('sky.alpha', 0);
			setProperty('glow.alpha', 0);
			setProperty('etc.alpha', 0);
			setProperty('ground.alpha', 0);
			setProperty('wtf.alpha', 0);
			setProperty('flow1.alpha', 0);
			setProperty('tree.alpha', 0);
			setProperty('flow2.alpha', 0);

			doTweenAlpha('scoreTxt','scoreTxt', 0, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 0, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 0, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 0, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 0, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 0, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 0, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 0, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 0, 0.15,'linear')
		end
		if curStep == 1568 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 1632 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 1696 or curStep == 2736 then
			setProperty('defaultCamZoom',0.7)
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')

			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('bgCol.color', getColorFromHex('FFFFFF'));
			setProperty('bgCol.alpha', 0);

			setProperty('sky.alpha', 1);
			setProperty('glow.alpha', 1);
			setProperty('etc.alpha', 1);
			setProperty('ground.alpha', 1);
			setProperty('wtf.alpha', 1);
			setProperty('flow1.alpha', 1);
			setProperty('tree.alpha', 1);
			setProperty('flow2.alpha', 1);

			doTweenAlpha('scoreTxt','scoreTxt', 1, 0.3,'linear')
			doTweenAlpha('iconP1','iconP1', 1, 0.3,'linear')
			doTweenAlpha('iconP2','iconP2', 1, 0.3,'linear')
			doTweenAlpha('healthBar','healthBar', 1, 0.3,'linear')
			doTweenAlpha('healthBarBG','healthBarBG', 1, 0.3,'linear')
			doTweenAlpha('timeBar','timeBar', 1, 0.15,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG', 1, 0.15,'linear')
			doTweenAlpha('timeBarBG','timeBarBG', 1, 0.15,'linear')
			doTweenAlpha('timeTxt','timeTxt', 1, 0.15,'linear')
		end
		if curStep == 1712 or curStep == 1744 or curStep == 1776 or curStep == 1808 or curStep == 2208 or curStep == 2864 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 2464 then
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 1728 or curStep == 1760 or curStep == 1792 or curStep == 1816 then
			setProperty('defaultCamZoom',0.7)
		end
		if curStep == 1820 then
			setProperty('flash.color', getColorFromHex('000000'));
			doTweenAlpha('flsh','flash',1,0.15,'linear')
		end
		if curStep == 1824 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 2464 or curStep == 2480 or curStep == 2496 or curStep == 2512 or curStep == 2520 or curStep == 2528 or curStep == 2544 or curStep == 2560 or curStep == 2576 or curStep == 2584 or curStep == 2592 or curStep == 2608 or curStep == 2624 or curStep == 2640 or curStep == 2648 or curStep == 2656 or curStep == 2672 or curStep == 2688 or curStep == 2704 or curStep == 2712 then
			triggerEvent('Add Camera Zoom')
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1.3,'linear')
		end
		if curStep == 2720 then
			setProperty('flash.color', getColorFromHex('000000'));
			doTweenAlpha('flsh','flash',1,1.5,'linear')
		end
		if curStep == 2736 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			beat = 4;
		end
		if curStep == 2864 then
			cancelTween('flsh');
			setProperty('flash.alpha',1)
			setProperty('flash.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('flsh','flash',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			beat = 0;
		end
		if curStep == 2928 then
			setProperty('defaultCamZoom',0.85)
			beat = 3;
		end
		if curStep == 2992 then
			beat = 0;
			setProperty('defaultCamZoom',0.7)
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 2994 or curStep == 2996 or curStep == 2998 or curStep == 3000 then
			triggerEvent('Add Camera Zoom')
		end
		if curStep == 3000 then
			setProperty('flash.color', getColorFromHex('000000'));
			doTweenAlpha('flsh','flash',1,0.5,'linear')
			doTweenAlpha('ch','camHUD',0,0.5,'linear')
		end
	
		if curStep == 112 or curStep == 804 or curStep == 868 or curStep == 1252 then
			particles = true;
		end
		if curStep == 272 then
			particleBeat = true;
		end
		if curStep == 520 then
			particleBeat = false;
			particlesAmount = 1;
			particlesSpeed = -1;
		end
		if curStep == 656 or curStep == 799 or curStep == 863 or curStep == 919 or curStep == 1178 or curStep == 1246 or curStep == 1306 or curStep == 3008 then
			particles = false;
		end
		if curStep == 672 then
			particles = true;
			particleBeat = true;
		end
		if curStep == 928 then
			particles = true;
			particleBeat = true;
			particleCurBeat = 1;
		end
		if curStep == 1120 then
			particleBeat = false;
			particlesAmount = 0;
			particlesSpeed = 2;
			particlesSize = 3;
		end
		if curStep == 1184 then
			particles = true;
			particleBeat = true;
			particlesSize = 1;
			particleCurBeat = 2;
		end
		if curStep == 1312 then
			particles = true;
			particleBeat = false;
			particlesSize = 1;
			particleCurBeat = 1;
		end
		if curStep == 1440 then
			particlesAmount = 1;
			particlesSpeed = -1;
		end
		if curStep == 1568 then
			particlesSpeed = 1;
		end
		if curStep == 1632 then
			particlesSpeed = 2;
		end
		if curStep == 1696 then
			particlesSpeed = 3;
			particlesAmount = 0;
		end
		if curStep == 1824 then
			particlesSpeed = 1;
			particlesAmount = 0;
		end
		if curStep == 1952 then
			particlesSpeed = -1;
			particlesAmount = 3;
		end
		if curStep == 1208 then
			particlesSpeed = 1;
			particlesAmount = 2;
		end
		if curStep == 2464 then
			particlesSpeed = -1;
			particlesAmount = 3;
		end
		if curStep == 2720 then
			particlesAmount = 5;
		end
		if curStep == 2736 then
			particlesSpeed = 3;
		end
		if curStep == 2864 then
			particlesSpeed = 1;
			particlesAmount = 0;
		end
		if curStep == 2928 then
			particlesSpeed = -1;
			particlesAmount = 1;
		end
		if curStep == 2992 then
			particlesSpeed = -1;
			particlesAmount = 3;
		end
	end
end