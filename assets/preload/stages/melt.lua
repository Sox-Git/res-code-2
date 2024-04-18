local xx = 550;
local yy = 220;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1250;
local yy2 = 220;
local SingBoth = false;
local followchars = true;

function onCreate()
	addHaxeLibrary('FlxBackdrop', 'flixel.addons.display');
	addHaxeLibrary('FlxTween', 'flixel.tweens');
	addHaxeLibrary('FlxEase', 'flixel.tweens');
	addHaxeLibrary('FlxObject', 'flixel');
	
	makeLuaSprite('sky', '', 0, 0);
	makeGraphic('sky', 1920, 1080,'2400B4')
	addLuaSprite('sky', false);
	setLuaSpriteScrollFactor('sky',0,0)
	setProperty('sky.scale.x',2)
	setProperty('sky.scale.y',2)

	
	makeLuaSprite('skyN', '', 0, 0);
	makeGraphic('skyN', 1920, 1080,'000000')
	addLuaSprite('skyN', false);
	setLuaSpriteScrollFactor('skyN',0,0)
	setProperty('skyN.scale.x',2)
	setProperty('skyN.scale.y',2)
	setProperty('skyN.alpha', 0)
	
	makeAnimatedLuaSprite('mountins', 'bgs/melt/classic/main', -1300, -788);
	scaleObject('mountins', 7, 7);
	addAnimationByPrefix('mountins', 'idle', 'BG ', 12, true);
	setScrollFactor('mountins', 0.7, 1);
	setProperty('mountins.antialiasing', false);
	addLuaSprite('mountins', false);
	
	makeAnimatedLuaSprite('mountinsN', 'bgs/melt/night/main', -1300, -788);
	scaleObject('mountinsN', 7, 7);
	addAnimationByPrefix('mountinsN', 'idle', 'BG ', 12, true);
	setScrollFactor('mountinsN', 0.7, 1);
	setProperty('mountinsN.antialiasing', false);
	setProperty('mountinsN.alpha', 0);
	addLuaSprite('mountinsN', false);
	
	makeAnimatedLuaSprite('water', 'bgs/melt/classic/water', -1300, -788);
	scaleObject('water', 7, 7);
	addAnimationByPrefix('water', 'idle', 'BG', 12, true);
	setScrollFactor('water', 0.9, 1);
	setProperty('water.antialiasing', false);
	addLuaSprite('water', false);
	
	makeAnimatedLuaSprite('waterN', 'bgs/melt/night/water', -1300, -788);
	scaleObject('waterN', 7, 7);
	addAnimationByPrefix('waterN', 'idle', 'BG', 12, true);
	setScrollFactor('waterN', 0.9, 1);
	setProperty('waterN.antialiasing', false);
	setProperty('waterN.alpha', 0);
	addLuaSprite('waterN', false);
	
	makeAnimatedLuaSprite('loop', 'bgs/melt/classic/loop', 800, -850);
	scaleObject('loop', 6, 6);
	addAnimationByPrefix('loop', 'idle', 'loop ', 12, true);
	setScrollFactor('loop', 1.05, 1);
	setProperty('loop.antialiasing', false);
	addLuaSprite('loop', false);
	
	makeAnimatedLuaSprite('loopN', 'bgs/melt/night/loop_night', 800, -850);
	scaleObject('loopN', 6, 6);
	addAnimationByPrefix('loopN', 'idle', 'loop_night ', 12, true);
	setScrollFactor('loopN', 1.05, 1);
	setProperty('loopN.antialiasing', false);
	setProperty('loopN.alpha', 0);
	addLuaSprite('loopN', false);
	
	makeAnimatedLuaSprite('tvIcons', 'bgs/melt/tv-icons', 627, 88);
	scaleObject('tvIcons', 7, 7);
	addAnimationByPrefix('tvIcons', 'melthog1', 'Melthog1 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog2', 'Melthog2 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog3', 'Melthog3-4 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog4', 'Melthog3-4 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog5', 'Melthog5-6-7 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog6', 'Melthog5-6-7 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog7', 'Melthog5-6-7 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthogs3', 'MelthogS3 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthogpico', 'Melthog Pico 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthogbf', 'Melthog BF 0', 24, true);
	setScrollFactor('tvIcons', 1, 1);
	setProperty('tvIcons.antialiasing', false);
	addLuaSprite('tvIcons', false);
	
	if songName == "melthing" then
		objectPlayAnimation('tvIcons', 'melthogbf', true)
	end
	
	makeLuaSprite('plate', 'bgs/melt/classic/plate', -600, -350);
	scaleObject('plate', 6, 6);
	setScrollFactor('plate', 1.1, 1);
	setProperty('plate.antialiasing', false);
	addLuaSprite('plate', false);
	
	makeLuaSprite('plateN', 'bgs/melt/night/plate_night', -600, -350);
	scaleObject('plateN', 6, 6);
	setScrollFactor('plateN', 1.1, 1);
	setProperty('plateN.antialiasing', false);
	setProperty('plateN.alpha', 0);
	addLuaSprite('plateN', false);
	
	makeAnimatedLuaSprite('floor', 'bgs/melt/classic/Melthog_S1_stage', -1550, -850);
	scaleObject('floor', 7, 7);
	addAnimationByPrefix('floor', 'idle', 'S1 Stage', 12, true);
	setScrollFactor('floor', 1, 1);
	setProperty('floor.antialiasing', false);
	addLuaSprite('floor', false);
	
	makeAnimatedLuaSprite('floorN', 'bgs/melt/night/Melthog_S1_stage_night', -1550, -850);
	scaleObject('floorN', 7, 7);
	addAnimationByPrefix('floorN', 'idle', 'S1_night Stage', 12, true);
	setScrollFactor('floorN', 1, 1);
	setProperty('floorN.antialiasing', false);
	setProperty('floorN.alpha', 0);
	addLuaSprite('floorN', false);
	
	makeLuaSprite('blackout', '', 0, 0);
	makeGraphic('blackout',1920,1080,'000000')
	addLuaSprite('blackout', false);
	setLuaSpriteScrollFactor('blackout',0,0)
	setProperty('blackout.scale.x',2)
	setProperty('blackout.scale.y',2)
	setProperty('blackout.alpha',0)
	
	makeLuaSprite('blackscreen', '', 0, 0);
	makeGraphic('blackscreen',1920,1080,'000000')
	addLuaSprite('blackscreen', true);
	setLuaSpriteScrollFactor('blackscreen',0,0)
	setProperty('blackscreen.scale.x',2)
	setProperty('blackscreen.scale.y',2)
	setProperty('blackscreen.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	setProperty('camHUD.alpha', 0);
	setProperty('gfGroup.alpha', 0);
	
	runHaxeCode([[
		CloudClassicOne = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/1'), 1, 1, true, false);
		CloudClassicOne.scale.set(7, 7);
		CloudClassicOne.x = -1500;
		CloudClassicOne.y = -650;
		CloudClassicOne.scrollFactor.set(0.7, 1);
		CloudClassicOne.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+1, CloudClassicOne);
			
		CloudClassicTwo = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/2'), 1, 1, true, false);
		CloudClassicTwo.x = -1500;
		CloudClassicTwo.y = -650;
		CloudClassicTwo.scale.set(7, 7);
		CloudClassicTwo.scrollFactor.set(0.7, 1);
		CloudClassicTwo.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+2, CloudClassicTwo);
			
		CloudClassicThree = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/3'), 1, 1, true, false);
		CloudClassicThree.x = -1500;
		CloudClassicThree.y = -650;
		CloudClassicThree.scale.set(7, 7);
		CloudClassicThree.scrollFactor.set(0.7, 1);
		CloudClassicThree.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+3, CloudClassicThree);
			
		CloudClassicFour = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/4'), 1, 1, true, false);
		CloudClassicFour.x = -1500;
		CloudClassicFour.y = -650;
		CloudClassicFour.scale.set(7, 7);
		CloudClassicFour.scrollFactor.set(0.7, 1);
		CloudClassicFour.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+4, CloudClassicFour);
			
		CloudClassicFive = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/5'), 1, 1, true, false);
		CloudClassicFive.x = -1500;
		CloudClassicFive.y = -650;
		CloudClassicFive.scale.set(7, 7);
		CloudClassicFive.scrollFactor.set(0.7, 1);
		CloudClassicFive.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+5, CloudClassicFive);
			
		CloudClassicSix = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/6'), 1, 1, true, false);
		CloudClassicSix.x = -1500;
		CloudClassicSix.y = -650;
		CloudClassicSix.scale.set(7, 7);
		CloudClassicSix.scrollFactor.set(0.7, 1);
		CloudClassicSix.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+6, CloudClassicSix);
			
			
		CloudNightOne = new FlxBackdrop(Paths.image('bgs/melt/night/clouds/1'), 1, 1, true, false);
		CloudNightOne.x = -1500;
		CloudNightOne.y = -650;
		CloudNightOne.alpha = 0;
		CloudNightOne.scale.set(7, 7);
		CloudNightOne.scrollFactor.set(0.7, 1);
		CloudNightOne.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyN'))+1, CloudNightOne);
			
		CloudNightTwo = new FlxBackdrop(Paths.image('bgs/melt/night/clouds/2'), 1, 1, true, false);
		CloudNightTwo.x = -1500;
		CloudNightTwo.y = -650;
		CloudNightTwo.alpha = 0;
		CloudNightTwo.scale.set(7, 7);
		CloudNightTwo.scrollFactor.set(0.7, 1);
		CloudNightTwo.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyN'))+2, CloudNightTwo);
			
		CloudNightThree = new FlxBackdrop(Paths.image('bgs/melt/night/clouds/3'), 1, 1, true, false);
		CloudNightThree.x = -1500;
		CloudNightThree.y = -650;
		CloudNightThree.alpha = 0;
		CloudNightThree.scale.set(7, 7);
		CloudNightThree.scrollFactor.set(0.7, 1);
		CloudNightThree.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyN'))+3, CloudNightThree);
			
		CloudNightFour = new FlxBackdrop(Paths.image('bgs/melt/night/clouds/4'), 1, 1, true, false);
		CloudNightFour.x = -1500;
		CloudNightFour.y = -650;
		CloudNightFour.alpha = 0;
		CloudNightFour.scale.set(7, 7);
		CloudNightFour.scrollFactor.set(0.7, 1);
		CloudNightFour.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyN'))+4, CloudNightFour);
			
		CloudNightFive = new FlxBackdrop(Paths.image('bgs/melt/night/clouds/5'), 1, 1, true, false);
		CloudNightFive.x = -1500;
		CloudNightFive.y = -650;
		CloudNightFive.alpha = 0;
		CloudNightFive.scale.set(7, 7);
		CloudNightFive.scrollFactor.set(0.7, 1);
		CloudNightFive.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyN'))+5, CloudNightFive);
			
		CloudNightSix = new FlxBackdrop(Paths.image('bgs/bgs/melt/night/clouds/6'), 1, 1, true, false);
		CloudNightSix.x = -1500;
		CloudNightSix.y = -650;
		CloudNightSix.alpha = 0;
		CloudNightSix.scale.set(7, 7);
		CloudNightSix.scrollFactor.set(0.7, 1);
		CloudNightSix.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyN'))+6, CloudNightSix);
	]])
	
end

function onEvent(event, val1, val2)
	if event == 'Change Character' then
		if val1 == "1" or val1 == 'dad' or val1 == 'opponent' then
			if val2 == 'Melthog_1' then
				objectPlayAnimation('tvIcons', 'melthog1', true)
			end
			if val2 == 'Melthog_2' then
				objectPlayAnimation('tvIcons', 'melthog2', true)
			end
			if val2 == 'Melthog_3' then
				objectPlayAnimation('tvIcons', 'melthog3', true)
			end
			if val2 == 'Melthog_4' then
				objectPlayAnimation('tvIcons', 'melthog4', true)
			end
			if val2 == 'Melthog_5' then
				objectPlayAnimation('tvIcons', 'melthog5', true)
			end
			if val2 == 'Melthog_6' then
				objectPlayAnimation('tvIcons', 'melthog6', true)
			end
			if val2 == 'Melthog_7' then
				objectPlayAnimation('tvIcons', 'melthog7', true)
			end
		end
	end
end

function onStepHit()	
	if songName == "melting" or songName == "Melting" then
		if curStep == 201 then
			doTweenAlpha('camHUDTween2','camHUD',1,1,'linear')
		end
		
		if curStep == 1280 then
			doTweenAlpha('BSTween1','blackscreen',0,1.6,'linear')
		end
		
		if curStep == 1310 then
			doTweenAlpha('timeBarT','timeBar',0,0.01,'linear')
			doTweenAlpha('timeBarBGT','timeBarBG',0,0.01,'linear')
			doTweenAlpha('timeTxtT','timeTxt',0,0.01,'linear')
			doTweenAlpha('iconP1T','iconP1',0,0.01,'linear')
			doTweenAlpha('iconP2T','iconP2',0,0.01,'linear')
			doTweenAlpha('healthBarT','healthBar',0,0.01,'linear')
			doTweenAlpha('healthBarBGT','healthBarBG',0,0.01,'linear')
			doTweenAlpha('iconP1T','iconP1',0,0.01,'linear')
			doTweenAlpha('sonicHUDTween12','sonicHUD',0,0.01,'linear')
			
			noteTweenAlpha('1ON1','0',0,0.01,'linear');
			noteTweenAlpha('2ON2','1',0,0.01,'linear');
			noteTweenAlpha('3ON3','2',0,0.01,'linear');
			noteTweenAlpha('4ON4','3',0,0.01,'linear');
			
			noteTweenAlpha('1PN1','4',0,0.01,'linear');
			noteTweenAlpha('2PN2','5',0,0.01,'linear');
			noteTweenAlpha('3PN3','6',0,0.01,'linear');
			noteTweenAlpha('4PN4','7',0,0.01,'linear');
		end
	
		if curStep == 1344 then
			setProperty('blackscreen.alpha',0)
			triggerEvent('Change Character', '1', 'Melthog_7')
			setProperty('sky.alpha',0)
			setProperty('mountins.alpha',0)
			setProperty('water.alpha',0)
			setProperty('floor.alpha',0)
			setProperty('loop.alpha',0)
			setProperty('plate.alpha',0)
			setProperty('skyN.alpha',1)
			setProperty('mountinsN.alpha',1)
			setProperty('waterN.alpha',1)
			setProperty('floorN.alpha',1)
			setProperty('loopN.alpha',1)
			setProperty('plateN.alpha',1)
			doTweenAlpha('timeBarT2','timeBar',1,1,'linear')
			doTweenAlpha('timeBarBGT2','timeBarBG',1,1,'linear')
			doTweenAlpha('timeTxtT2','timeTxt',1,1,'linear')
			doTweenAlpha('iconP1T2','iconP1',1,1,'linear')
			doTweenAlpha('iconP2T2','iconP2',1,1,'linear')
			doTweenAlpha('healthBarT2','healthBar',1,1,'linear')
			doTweenAlpha('healthBarBGT2','healthBarBG',1,1,'linear')
			doTweenAlpha('iconP1T2','iconP1',1,1,'linear')
			doTweenAlpha('sonicHUDTween12','sonicHUD',1,1,'linear')
		
			noteTweenAlpha('1ON','0',1,1,'linear');
			noteTweenAlpha('2ON','1',1,1,'linear');
			noteTweenAlpha('3ON','2',1,1,'linear');
			noteTweenAlpha('4ON','3',1,1,'linear');
			
			noteTweenAlpha('1PN','4',1,1,'linear');
			noteTweenAlpha('2PN','5',1,1,'linear');
			noteTweenAlpha('3PN','6',1,1,'linear');
			noteTweenAlpha('4PN','7',1,1,'linear');
			
			runHaxeCode([[
				CloudClassicOne.alpha = 0;
				CloudClassicTwo.alpha = 0;
				CloudClassicThree.alpha = 0;
				CloudClassicFour.alpha = 0;
				CloudClassicFive.alpha = 0;
				CloudClassicSix.alpha = 0;
				
				CloudNightOne.alpha = 1;
				CloudNightTwo.alpha = 1;
				CloudNightThree.alpha = 1;
				CloudNightFour.alpha = 1;
				CloudNightFive.alpha = 1;
				CloudNightSix.alpha = 1;
			]])
		end
		
		if curStep == 1447 then
			doTweenAlpha('camHUDTween9','camHUD',1,1,'linear')		
		end
		
		if curStep == 1568 then
			doTweenAlpha('BSTween1','blackscreen',1,1.25,'linear')
			doTweenAlpha('camHUDTween4','camHUD',0.2,1.25,'linear')
		end
		
		if curStep == 1608 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1,'linear')
			triggerEvent('Change Character', '1', 'Melthog_3')
			setProperty('blackscreen.alpha',0)
			setProperty('sky.alpha',1)
			setProperty('mountins.alpha',1)
			setProperty('water.alpha',1)
			setProperty('floor.alpha',1)
			setProperty('loop.alpha',1)
			setProperty('plate.alpha',1)
			setProperty('skyN.alpha',0)
			setProperty('mountinsN.alpha',0)
			setProperty('waterN.alpha',0)
			setProperty('floorN.alpha',0)
			setProperty('loopN.alpha',0)
			setProperty('plateN.alpha',0)
			setProperty('camHUD.alpha',1)
			
			runHaxeCode([[
				CloudClassicOne.alpha = 1;
				CloudClassicTwo.alpha = 1;
				CloudClassicThree.alpha = 1;
				CloudClassicFour.alpha = 1;
				CloudClassicFive.alpha = 1;
				CloudClassicSix.alpha = 1;
				
				CloudNightOne.alpha = 0;
				CloudNightTwo.alpha = 0;
				CloudNightThree.alpha = 0;
				CloudNightFour.alpha = 0;
				CloudNightFive.alpha = 0;
				CloudNightSix.alpha = 0;
			]])
		end
		
		if curStep == 1759 then
			runHaxeCode([[
				FlxTween.tween(CloudClassicOne, {alpha: 0.8}, 0.8);
				FlxTween.tween(CloudClassicTwo, {alpha: 0.8}, 0.8);;
				FlxTween.tween(CloudClassicThree, {alpha: 0.8}, 0.8);
				FlxTween.tween(CloudClassicFour, {alpha: 0.8}, 0.8);
				FlxTween.tween(CloudClassicFive, {alpha: 0.8}, 0.8);
				FlxTween.tween(CloudClassicSix, {alpha: 0.8}, 0.8);
			
				FlxTween.tween(CloudNightOne, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudNightTwo, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudNightThree, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudNightFour, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudNightFive, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudNightSix, {alpha: 0.2}, 0.8);
			]])
			doTweenAlpha('skyN','skyN',0.2 ,0.8,'linear')
			doTweenAlpha('plateN','plateN',0.2 ,0.8,'linear')
			doTweenAlpha('mountinsN','mountinsN',0.2 ,0.8,'linear')
			doTweenAlpha('waterN','waterN',0.2 ,0.8,'linear')
			doTweenAlpha('floorN','floorN',0.2 ,0.8,'linear')
			doTweenAlpha('loopN','loopN',0.2 ,0.8,'linear')
		end
		
		if curStep == 1855 then
			runHaxeCode([[
				FlxTween.tween(CloudClassicOne, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudClassicTwo, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudClassicThree, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudClassicFour, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudClassicFive, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudClassicSix, {alpha: 0.5}, 0.8);
			
				FlxTween.tween(CloudNightOne, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudNightTwo, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudNightThree, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudNightFour, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudNightFive, {alpha: 0.5}, 0.8);
				FlxTween.tween(CloudNightSix, {alpha: 0.5}, 0.8);
			]])
			doTweenAlpha('skyN','skyN',0.5 ,0.8,'linear')
			doTweenAlpha('plateN','plateN',0.5 ,0.8,'linear')
			doTweenAlpha('mountinsN','mountinsN',0.5 ,0.8,'linear')
			doTweenAlpha('waterN','waterN',0.5 ,0.8,'linear')
			doTweenAlpha('floorN','floorN',0.5 ,0.8,'linear')
			doTweenAlpha('loopN','loopN',0.5 ,0.8,'linear')
		end
		
		if curStep == 1983 then
			runHaxeCode([[
				FlxTween.tween(CloudClassicOne, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudClassicTwo, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudClassicThree, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudClassicFour, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudClassicFive, {alpha: 0.2}, 0.8);
				FlxTween.tween(CloudClassicSix, {alpha: 0.2}, 0.8);
			
				FlxTween.tween(CloudNightOne, {alpha: 0.7}, 0.8);
				FlxTween.tween(CloudNightTwo, {alpha: 0.7}, 0.8);
				FlxTween.tween(CloudNightThree, {alpha: 0.7}, 0.8);
				FlxTween.tween(CloudNightFour, {alpha: 0.7}, 0.8);
				FlxTween.tween(CloudNightFive, {alpha: 0.7}, 0.8);
				FlxTween.tween(CloudNightSix, {alpha: 0.7}, 0.8);
			]])
			doTweenAlpha('skyN','skyN',0.7 ,0.8,'linear')
			doTweenAlpha('plateN','plateN',0.7 ,0.8,'linear')
			doTweenAlpha('mountinsN','mountinsN',0.7 ,0.8,'linear')
			doTweenAlpha('waterN','waterN',0.7 ,0.8,'linear')
			doTweenAlpha('floorN','floorN',0.7 ,0.8,'linear')
			doTweenAlpha('loopN','loopN',0.7 ,0.8,'linear')
		end
		
		if curStep == 2111 then
			runHaxeCode([[
				FlxTween.tween(CloudClassicOne, {alpha: 0}, 0.8);
				FlxTween.tween(CloudClassicTwo, {alpha: 0}, 0.8);
				FlxTween.tween(CloudClassicThree, {alpha: 0}, 0.8);
				FlxTween.tween(CloudClassicFour, {alpha: 0}, 0.8);
				FlxTween.tween(CloudClassicFive, {alpha: 0}, 0.8);
				FlxTween.tween(CloudClassicSix, {alpha: 0}, 0.8);
			
				FlxTween.tween(CloudNightOne, {alpha: 1}, 0.8);
				FlxTween.tween(CloudNightTwo, {alpha: 1}, 0.8);
				FlxTween.tween(CloudNightThree, {alpha: 1}, 0.8);
				FlxTween.tween(CloudNightFour, {alpha: 1}, 0.8);
				FlxTween.tween(CloudNightFive, {alpha: 1}, 0.8);
				FlxTween.tween(CloudNightSix, {alpha: 1}, 0.8);
			]])
			doTweenAlpha('skyN','skyN',1 ,0.8,'linear')
			doTweenAlpha('plateN','plateN',1 ,0.8,'linear')
			doTweenAlpha('mountinsN','mountinsN',1 ,0.8,'linear')
			doTweenAlpha('waterN','waterN',1 ,0.8,'linear')
			doTweenAlpha('floorN','floorN',1 ,0.8,'linear')
			doTweenAlpha('loopN','loopN',1 ,0.8,'linear')
		end
		
		if curStep == 2240 then
			doTweenAlpha('camHUDTween5','camHUD',0,2.35,'linear')
		end
		
		if curStep == 2320 then
			doTweenAlpha('timeBarT1','timeBar',0,0.1,'linear')
			doTweenAlpha('timeBarBGT1','timeBarBG',0,0.1,'linear')
			doTweenAlpha('timeTxtT1','timeTxt',0,0.1,'linear')
			doTweenAlpha('iconP1T1','iconP1',0,0.1,'linear')
			doTweenAlpha('iconP2T1','iconP2',0,0.1,'linear')
			doTweenAlpha('healthBarT1','healthBar',0,0.1,'linear')
			doTweenAlpha('healthBarBGT1','healthBarBG',0,0.1,'linear')
			doTweenAlpha('iconP1T1','iconP1',0,0.1,'linear')
		end
		
		if curStep == 2336 then
			doTweenAlpha('camHUDTween6','camHUD',1,1.75,'linear')
		end
		
		if curStep == 2368 then
			doTweenAlpha('1sonicHUDTween1','sonicHUD',0,1.9,'linear')
			doTweenAlpha('camHUDTween7','camHUD',0,1.9,'linear')
			
			noteTweenAlpha('11ON1','0',0,1.9,'linear');
			noteTweenAlpha('12ON2','1',0,1.9,'linear');
			noteTweenAlpha('13ON3','2',0,1.9,'linear');
			noteTweenAlpha('14ON4','3',0,1.9,'linear');
			
			noteTweenAlpha('11PN1','4',0,1.9,'linear');
			noteTweenAlpha('12PN2','5',0,1.9,'linear');
			noteTweenAlpha('13PN3','6',0,1.9,'linear');
			noteTweenAlpha('14PN4','7',0,1.9,'linear');
		end

		if curStep == 2400 then
			setProperty('camHUD.alpha',1)
			setProperty('blackscreen.alpha',1)
		end
		
		if curStep == 2415 then
			setProperty('camHUD.alpha',0)
		end
	end
end
function onUpdate()

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	runHaxeCode([[
		CloudClassicOne.velocity.set(85, 0);
		CloudClassicTwo.velocity.set(80, 0);
		CloudClassicThree.velocity.set(75, 0);
		CloudClassicFour.velocity.set(70, 0);
		CloudClassicFive.velocity.set(65, 0);
		CloudClassicSix.velocity.set(60, 0);
			
		CloudNightOne.velocity.set(85, 0);
		CloudNightTwo.velocity.set(80, 0);
		CloudNightThree.velocity.set(75, 0);
		CloudNightFour.velocity.set(70, 0);
		CloudNightFive.velocity.set(65, 0);
		CloudNightSix.velocity.set(60, 0);
	]])
	
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

            if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeR' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeL' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if SingBoth then
		characterPlayAnim('gf', singAnims[direction + 1], true);
	end
end