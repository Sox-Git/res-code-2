local zoom = 1;
local Ye = false;
local Bu = false;

function onCreate()
	if songName == "chaos-encore" then
		precacheImage('characters/Fleetway/fleetway_com')
		
		addCharacterToList('bf-super','bf');
		addCharacterToList('fleetway','dad');
		addCharacterToList('fleetway-anims2','dad');
		addCharacterToList('fleetway-anims3','dad');
	
		makeLuaSprite('blackbg', '', 0, 0);
		makeGraphic('blackbg',1920,1080,'000000')
		addLuaSprite('blackbg', false);
		setLuaSpriteScrollFactor('blackbg',0,0)
		setProperty('blackbg.scale.x',2)
		setProperty('blackbg.scale.y',2)
		setProperty('blackbg.alpha',0)
		
		makeLuaSprite('fuckyeaY', '', 0, 0);
		makeGraphic('fuckyeaY',1920,1080,'FFFF00')
		addLuaSprite('fuckyeaY', false);
		setLuaSpriteScrollFactor('fuckyeaY',0,0)
		setProperty('fuckyeaY.scale.x',2)
		setProperty('fuckyeaY.scale.y',2)
		setProperty('fuckyeaY.alpha',0)
		
		makeLuaSprite('fuckyeaB', '', 0, 0);
		makeGraphic('fuckyeaB',1920,1080,'00CDFF')
		addLuaSprite('fuckyeaB', false);
		setLuaSpriteScrollFactor('fuckyeaB',0,0)
		setProperty('fuckyeaB.scale.x',2)
		setProperty('fuckyeaB.scale.y',2)
		setProperty('fuckyeaB.alpha',0)
		
		makeLuaSprite('vg', 'RedVG', 0, 0, 'exe');
		setScrollFactor('vg', 0, 0);
		setProperty('vg.antialiasing', true);
		setObjectCamera('vg', 'hud');
		addLuaSprite('vg', true);
		setProperty('vg.alpha', 0);
		setProperty('vg.color', getColorFromHex('FF0000'));
		
		makeLuaSprite('bruh', '', 0, 0);
		makeGraphic('bruh',1920,1080,'000000')
		addLuaSprite('bruh', true);
		setLuaSpriteScrollFactor('bruh',0,0)
		setProperty('bruh.scale.x',2)
		setProperty('bruh.scale.y',2)
		setProperty('bruh.alpha',0)
		setObjectCamera('bruh', 'hud')
	
		makeLuaSprite('flashingshit', '', 0, 0);
		makeGraphic('flashingshit',1920,1080,'FFFFFF')
		addLuaSprite('flashingshit', true);
		setLuaSpriteScrollFactor('flashingshit',0,0)
		setProperty('flashingshit.scale.x',2)
		setProperty('flashingshit.scale.y',2)
		setProperty('flashingshit.alpha',0)
		setObjectCamera('flashingshit', 'hud')
		
		makeLuaSprite('black', '', 0, 0);
		makeGraphic('black',1920,1080,'000000')
		addLuaSprite('black', true);
		setLuaSpriteScrollFactor('black',0,0)
		setProperty('black.scale.x',2)
		setProperty('black.scale.y',2)
		setProperty('black.alpha',1)
		setObjectCamera('black', 'other')
		
		makeLuaSprite('flashin', '', 0, 0);
		makeGraphic('flashin',1920,1080,'FFFFFF')
		addLuaSprite('flashin', true);
		setLuaSpriteScrollFactor('flashin',0,0)
		setProperty('flashin.scale.x',2)
		setProperty('flashin.scale.y',2)
		setProperty('flashin.alpha',0)
		setObjectCamera('flashin', 'other')
	end
end

function onStepHit()
	if songName == 'chaos-encore' then
		if curStep == 500 then
			noteTweenAlpha("dissapear1", 0, 0, 0.5, "linear")
			noteTweenAlpha("dissapear2", 1, 0, 0.5, "linear")
			noteTweenAlpha("dissapear3", 2, 0, 0.5, "linear")
			noteTweenAlpha("dissapear4", 3, 0, 0.5, "linear")
		end
		if curStep == 504 then
			makeAnimatedLuaSprite('eat this!', 'characters/Fleetway/fleetway_com', 70, 0);
			setScrollFactor('eat this!', 1, 1);
			setObjectCamera('eat this!', 'camHUD')
			addAnimationByPrefix('eat this!', 'idle', 'cooking', 31, true);
			setProperty('eat this!.antialiasing', true);
			addLuaSprite('eat this!', true);
			scaleObject('eat this!', 1.3, 1.3)
			setScrollFactor('eat this!', 1, 1);
		end
		if curStep == 512 then
			noteTweenAlpha("dissapear1", 0, 1, 0.5, "linear")
			noteTweenAlpha("dissapear2", 1, 1, 0.5, "linear")
			noteTweenAlpha("dissapear3", 2, 1, 0.5, "linear")
			noteTweenAlpha("dissapear4", 3, 1, 0.5, "linear")	
		end
		if curStep == 519 then
			removeLuaSprite('eat this!')
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'RedVGin' then
		doTweenAlpha('In','vg',1,0.62,'linear')
		runTimer('RedVGout', 0.62, 1)
	end
	if tag == 'RedVGout' then
		doTweenAlpha('Out','vg',0,0.62,'linear')
		runTimer('RedVGin', 0.62, 1)
	end
	if tag == 'RedVGinFast' then
		doTweenAlpha('InF','vg',1,0.31,'linear')
		runTimer('RedVGoutFast', 0.31, 1)
	end
	if tag == 'RedVGoutFast' then
		doTweenAlpha('OutF','vg',0,0.31,'linear')
		runTimer('RedVGinFast', 0.31, 1)
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "chaos-encore" then
		if zoom == 1 then
			doTweenZoom('ZOOMDAD', 'camGame',0.7, 0.25, 'quadOut')
		end
		if curStep == 0 then
			setProperty('camHUD.alpha', 0);
		end
		if curStep == 1 then
			runTimer('RedVGin', 0, 1)
		end
		if curStep == 3 then
			doTweenAlpha('BBG','black',0,7.5,'linear')
		end
		if curStep == 10 then
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeBarBGBG.alpha', 0);
			setProperty('timeBar.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			
			setProperty('healthBarBG.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('scoreTxt.alpha', 0);
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("DADnote4", 0, 3000, 0.05, quadInOut)
				noteTweenX("DADnote5", 1, 3000, 0.05, quadInOut)
				noteTweenX("DADnote6", 2, 3000, 0.05, quadInOut)
				noteTweenX("DADnote7", 3, 3000, 0.05, quadInOut)
				
				noteTweenX("BFnote4", 4, 3000, 0.05, quadInOut)
				noteTweenX("BFnote5", 5, 3000, 0.05, quadInOut)
				noteTweenX("BFnote6", 6, 3000, 0.05, quadInOut)
				noteTweenX("BFnote7", 7, 3000, 0.05, quadInOut)
			end
		end
		if curStep == 15 then
			setProperty('camHUD.alpha', 1);
		end
		if curStep == 192 then
			triggerEvent('Play Animation', 'fastanim', 'Dad');
		end
		if curStep == 224 then
			setProperty('camHUD.alpha', 0);
		end
		if curStep == 230 then
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeBarBGBG.alpha', 1);
			setProperty('timeBar.alpha', 1);
			setProperty('timeTxt.alpha', 1);
			
			setProperty('healthBarBG.alpha', 1);
			setProperty('healthBar.alpha', 1);
			setProperty('iconP1.alpha', 1);
			setProperty('iconP2.alpha', 1);
			setProperty('scoreTxt.alpha', 1);
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("DADnote0ClassicPos", 0, 93, 0.05, quadInOut)
				noteTweenX("DADnote1ClassicPos", 1, 205, 0.05, quadInOut)
				noteTweenX("DADnote2ClassicPos", 2, 317, 0.05, quadInOut)
				noteTweenX("DADnote3ClassicPos", 3, 429, 0.05, quadInOut)
				
				noteTweenX("BFnote4ClassicPos", 4, 733, 0.05, quadInOut)
				noteTweenX("BFnote5ClassicPos", 5, 845, 0.05, quadInOut)
				noteTweenX("BFnote6ClassicPos", 6, 957, 0.05, quadInOut)
				noteTweenX("BFnote7ClassicPos", 7, 1069, 0.05, quadInOut)
			end
		end
		if curStep == 240 then
			doTweenAlpha('CamHudT1','camHUD',1,1,'linear')
			cancelTween('In');
			cancelTween('Out');
			cancelTimer('RedVGin');
			cancelTimer('RedVGout');
			doTweenAlpha('OutVG1','vg',0,0.62,'linear')
		end
		if curStep == 256 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash1','flashingshit',0,1,'linear')
		end
		if curStep == 384 then
			runTimer('RedVGinFast', 0, 1)
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash2','flashingshit',0,1,'linear')
		end
		if curStep == 496 then
			cancelTween('InF');
			cancelTween('OutF');
			cancelTimer('RedVGinFast');
			cancelTimer('RedVGoutFast');
			doTweenAlpha('OutVG2','vg',0,0.31,'linear')
		end
		if curStep == 506 then
			triggerEvent('Change Character', '1', 'fleetway-anims3');
			triggerEvent('Play Animation', 'WHAT', 'Dad');
		end
		if curStep == 512 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash3','flashingshit',0,1,'linear')
			triggerEvent('Change Character', '1', 'fleetway');
		end
		if curStep == 768 then
			doTweenAlpha('BBG1','black',1,1.1,'linear')
		end
		if curStep == 784 then
			doTweenAlpha('flash1','flashin',0.7,1.1,'linear')
			setProperty('blackbg.alpha',1)
			setProperty('thechamber.alpha', 0);
			setProperty('porker.alpha', 0);
		end
		if curStep == 800 then
			setProperty('black.alpha', 0);
			doTweenAlpha('flash2','flashin',0,0.7,'linear')
		end
		if curStep == 928 or curStep == 942 or curStep == 948 or curStep == 954 or curStep == 960 or curStep == 966 or curStep == 972 or curStep == 980 or curStep == 986 or curStep == 992 or curStep == 1006 or curStep == 1012 or curStep == 1018 or curStep == 1024 or curStep == 1030 or curStep == 1036 or curStep == 1044 or curStep == 1050 then
			if Ye == true then
				cancelTween('LightyY')
				Ye = false;
			end
			setProperty('fuckyeaY.alpha', 0.2);
			doTweenAlpha('LightyY','fuckyeaY',0,0.7,'linear')
			Ye = true;
		end
		if curStep == 936 or curStep == 952 or curStep == 968 or curStep == 974 or curStep == 978 or curStep == 984 or curStep == 988 or curStep == 990 or curStep == 991 or curStep == 1000 or curStep == 1016 or curStep == 1032 or curStep == 1038 or curStep == 1042 or curStep == 1048 or curStep == 1052 or curStep == 1054 then
			if Bu == true then
				cancelTween('LightyB');
				Bu = false;
			end
			setProperty('fuckyeaB.alpha', 0.2);
			doTweenAlpha('LightyB','fuckyeaB',0,0.5,'linear')
			Bu = true;
		end
		if curStep == 1216 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash4','flashingshit',0,1,'linear')
		end
		if curStep == 1056 then
			doTweenAlpha('BBG2','black',1,1.1,'linear')
		end
		if curStep == 1072 then
			triggerEvent('Change Character', '0', 'bf-super');
			setProperty('blackbg.alpha',0)
			setProperty('thechamber.alpha', 1);
			setProperty('porker.alpha', 1);
			setProperty('flashin.color', getColorFromHex('FFFF00'))
			setProperty('flashin.alpha', 1);
			doTweenAlpha('LightyYGO','flashin',0,1,'linear')
			
			triggerEvent('Change Character', '1', 'fleetway-anims3');
			triggerEvent('Play Animation', 'Step it up', 'Dad');
		end
		if curStep == 1080 then
			doTweenAlpha('BBG3','black',0,0.5,'linear')
		end
		if curStep == 1090 then
			triggerEvent('Change Character', '1', 'fleetway');
		end
		if curStep == 1456 then
			setProperty('bruh.alpha', 1);
		end
		if curStep == 1472 then
			setProperty('bruh.alpha', 0);
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash5','flashingshit',0,1,'linear')
		end
		if curStep == 1728 then
			doTweenAlpha('BBG4','black',1,1.2,'linear')
		end
		if curStep == 1760 then
			setProperty('black.alpha', 0);
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash6','flashingshit',0,1,'linear')
		end
		if curStep == 1888 then
			runTimer('RedVGinFast', 0, 1)
		end
		if curStep == 1982 then
			triggerEvent('Change Character', '1', 'fleetway-anims2');
			triggerEvent('Play Animation', 'Ill show you', 'Dad');
		end
		if curStep == 2000 then
			cancelTween('InF');
			cancelTween('OutF');
			cancelTimer('RedVGinFast');
			cancelTimer('RedVGoutFast');
			doTweenAlpha('OutVG2','vg',0,0.31,'linear')
		end
		if curStep == 2015 then
			triggerEvent('Change Character', '1', 'fleetway');
		end
		if curStep == 2016 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash7','flashingshit',0,1,'linear')
			runTimer('RedVGinFast', 0, 1)
		end
		if curStep == 2128 then
			setProperty('bruh.alpha', 1);
			cancelTween('InF');
			cancelTween('OutF');
			cancelTimer('RedVGinFast');
			cancelTimer('RedVGoutFast');
			doTweenAlpha('OutVG2','vg',0,0.31,'linear')
		end
		if curStep == 2135 then
			setProperty('blackbg.alpha',1)
			setProperty('thechamber.alpha', 0);
			setProperty('porker.alpha', 0);
		end
		if curStep == 2144 then
			setProperty('bruh.alpha', 0);
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash8','flashingshit',0,1,'linear')
		end
		if curStep == 2144 or curStep == 2150 or curStep == 2156 or curStep == 2208 or curStep == 2214 or curStep == 2220 or curStep == 2272 or curStep == 2278 or curStep == 2284 or curStep == 2336 or curStep == 2342 or curStep == 2348 then
			if Ye == true then
				cancelTween('LightyY')
				Ye = false;
			end
			setProperty('fuckyeaY.alpha', 0.2);
			doTweenAlpha('LightyY','fuckyeaY',0,0.7,'linear')
			Ye = true;
		end
		if curStep == 2176 or curStep == 2182 or curStep == 2188 or curStep == 2240 or curStep == 2246 or curStep == 2252 or curStep == 2304 or curStep == 2310 or curStep == 2316 or curStep == 2368 or curStep == 2374 or curStep == 2380 then
			if Bu == true then
				cancelTween('LightyB');
				Bu = false;
			end
			setProperty('fuckyeaB.alpha', 0.2);
			doTweenAlpha('LightyB','fuckyeaB',0,0.5,'linear')
			Bu = true;
		end
		if curStep == 2380 then
			doTweenAlpha('oaoaoaoaoa','bruh',1,0.25,'linear')
		end
		if curStep == 2392 then
			setProperty('blackbg.alpha',0)
			setProperty('thechamber.alpha', 1);
			setProperty('porker.alpha',1);
		end
		if curStep == 2400 then
			setProperty('bruh.alpha', 0);
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash9','flashingshit',0,1,'linear')
			doTweenAlpha('CamHudT2','camHUD',0,1.5,'linear')
		end
		if curStep == 2428 then
			doTweenAlpha('KillMePls','bruh',1,0.35,'linear')
		end
	end
end