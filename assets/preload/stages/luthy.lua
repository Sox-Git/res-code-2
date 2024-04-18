local Visible = true;
local GFVisible = false;
local zoom = 0;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/luther/LutherBG', -1350, -290);
		scaleObject('bg', 1.3, 1.3);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false)
		
		makeLuaSprite('Hills', 'bgs/luther/hills', -1350, -290);
		scaleObject('Hills', 1.3, 1.3);
		setScrollFactor('Hills', 1, 1);
		setProperty('Hills.antialiasing', true);
		addLuaSprite('Hills', false)
		
		makeLuaSprite('FloorLight', 'bgs/luther/floor-light', -1350, -290);
		scaleObject('FloorLight', 1.3, 1.3);
		setScrollFactor('FloorLight', 1, 1);
		setProperty('FloorLight.antialiasing', true);
		addLuaSprite('FloorLight', false)
		
		makeLuaSprite('FloorLightNEEDLE', 'bgs/luther/floor-light', -1200, -400);
		scaleObject('FloorLightNEEDLE', 1.3, 1.3);
		setScrollFactor('FloorLightNEEDLE', 1, 1);
		setProperty('FloorLightNEEDLE.antialiasing', true);
		addLuaSprite('FloorLightNEEDLE', false)
		setProperty('FloorLightNEEDLE.alpha',0)
		
		makeLuaSprite('Light', 'bgs/luther/light', -1350, -290);
		scaleObject('Light', 1.3, 1.3);
		setScrollFactor('Light', 1, 1);
		setProperty('Light.antialiasing', true);
		addLuaSprite('Light', true);
		
		makeLuaSprite('LightNEEDLE', 'bgs/luther/light', -750, -290);
		scaleObject('LightNEEDLE', 1, 1.3);
		setScrollFactor('LightNEEDLE', 1, 1);
		setProperty('LightNEEDLE.antialiasing', true);
		addLuaSprite('LightNEEDLE', true);
		setProperty('LightNEEDLE.alpha', 0);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('Egg', 'bgs/luther/egg', -770, 720);
			scaleObject('Egg', 1, 1);
			addAnimationByPrefix('Egg', 'bop', 'idle', 24, false);
			setScrollFactor('Egg', 1.2, 1);
			setProperty('Egg.antialiasing', true);
			addLuaSprite('Egg', true);
			
			makeAnimatedLuaSprite('Knuckles', 'bgs/luther/knuckles', 1400, 720);
			scaleObject('Knuckles', 1, 1);
			addAnimationByPrefix('Knuckles', 'bip', 'idle', 24, false);
			setScrollFactor('Knuckles', 0.8, 1);
			setProperty('Knuckles.antialiasing', true);
			addLuaSprite('Knuckles', true);
		end
	end
	
	
	makeLuaSprite('bg1', '', 0, 0);
	makeGraphic('bg1',1920,1080,'000000')
	addLuaSprite('bg1', false);
	setLuaSpriteScrollFactor('bg1',0,0)
	setProperty('bg1.scale.x',2)
	setProperty('bg1.scale.y',2)
	setProperty('bg1.alpha',1)
	
	makeLuaSprite('bg2', '', 0, 0);
	makeGraphic('bg2',1920,1080,'000000')
	addLuaSprite('bg2', true);
	setLuaSpriteScrollFactor('bg2',0,0)
	setProperty('bg2.scale.x',2)
	setProperty('bg2.scale.y',2)
	setProperty('bg2.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	if Visible == true then
		setProperty('bg2.alpha',1)
	end

end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('Egg', 'bop', false)
			objectPlayAnimation('Knuckles', 'bip', false)
		else
			objectPlayAnimation('Egg', 'bop', false)
			objectPlayAnimation('Knuckles', 'bip', false)
		end
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)

	if zoom == 0 then
		doTweenZoom('ZOOMDAD', 'camGame',0.6, 0.5, 'quadOut')
	end
	if zoom == 1 then
		doTweenZoom('ZOOMDAD', 'camGame',0.7, 0.5, 'quadOut')
	end
	if zoom == 2 then
		doTweenZoom('ZOOMDAD', 'camGame',0.8, 0.5, 'quadOut')
	end
	if zoom == 3 then
		doTweenZoom('ZOOMDAD', 'camGame',0.9, 0.5, 'quadOut')
	end
	if zoom == 4 then
		doTweenZoom('ZOOMDAD', 'camGame',1.0, 0.5, 'quadOut')
	end
	
	if songName == "her-world-old" then
		if curStep == 0 then
			setProperty('Egg.alpha', 0);
			setProperty('Knuckles.alpha', 0);
			setProperty('Light.alpha', 0);
			setProperty('gf.alpha', 0);
			setProperty('dad.alpha', 0);
			setProperty('bf.alpha', 0);
			setProperty('camHUD.alpha', 0);
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
		
			noteTweenAlpha('opponentStrums0',0 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,0 ,0.05, 'linear')
		
			noteTweenAlpha('playerStrums0',4 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,0.05, 'linear')
		end
		if curStep == 124 then
			doTweenAlpha('camHUD','camHUD',1,0.05,'linear')
			noteTweenAlpha('playerStrums0',4 ,1 ,0.05, 'linear')
			noteTweenAlpha('playerStrums1',5 ,1 ,0.05, 'linear')
			noteTweenAlpha('playerStrums2',6 ,1 ,0.05, 'linear')
			noteTweenAlpha('playerStrums3',7 ,1 ,0.05, 'linear')
		end
		if curStep == 128 then
			doTweenAlpha('bg2','bg2',0,0.5,'linear')
		end 
		
		if curStep == 252 then
			doTweenAlpha('bg2','bg2',1,1.0,'linear')
			doTweenAlpha('camHUD','camHUD',0,1,'linear')
		end  
		
		if curStep == 288 then
			setProperty('bg1.alpha',0)
			doTweenAlpha('camHUD','camHUD',1,1,'linear')
			setProperty('bg2.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
			setProperty('dad.alpha', 1);
			setProperty('Light.alpha', 1);
			setProperty('Egg.alpha', 1);
			setProperty('Knuckles.alpha', 1);
			setProperty('timeBar.alpha', 1)
			setProperty('timeTxt.alpha', 1)
			setProperty('scoreTxt.alpha', 1)		
		
			setProperty('iconP2.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)		
		
			noteTweenAlpha('opponentStrums0',0 ,1 ,1.0, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,1 ,1.0, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,1 ,1.0, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,1 ,1.0, 'linear')
		
			noteTweenAlpha('playerStrums0',4 ,1 ,1.0, 'linear')
			noteTweenAlpha('playerStrums1',5 ,1 ,1.0, 'linear')
			noteTweenAlpha('playerStrums2',6 ,1 ,1.0, 'linear')
			noteTweenAlpha('playerStrums3',7 ,1 ,1.0, 'linear')
		end  
	end
	
	if songName == "her-world" then
		--flashes
		if curStep == 128 or curStep == 192 or curStep == 256 or curStep == 320 or curStep == 384 or curStep == 480 or curStep == 544 or curStep == 608 or curStep == 672 or curStep == 736 or curStep == 800 or curStep == 864 or curStep == 928 or curStep == 992 or curStep == 1120 or curStep == 1184 or curStep == 1246 or curStep == 1310 or curStep == 1376 or curStep == 1440 or curStep == 1504 or curStep == 1568 or curStep == 1856 or curStep == 1920 or curStep == 2048 or curStep == 2112 or curStep == 2240 or curStep == 2304 or curStep == 2624 or curStep == 2816 or curStep == 3072 then
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashinshit','flashingshit',0,0.5,'linear')
		end
		
		if curStep == 1759 then
			setProperty('flashingshit.color', getColorFromHex('5D00FF'))
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh1','flashingshit',0,0.25,'linear')
		end
		
		if curStep == 1763 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh2','flashingshit',0,0.25,'linear')
		end
		
		if curStep == 1767 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh3','flashingshit',0,0.25,'linear')
		end
		
		if curStep == 1770 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh4','flashingshit',0,0.25,'linear')
		end
		
		if curStep == 1773 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh5','flashingshit',0,0.25,'linear')
		end
		
		if curStep == 1776 then
			doTweenAlpha('needleLaugh6','flashingshit',0.35,0.20,'linear')
		end
		
		if curStep == 1778 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh7','flashingshit',0,0.20,'linear')
		end
		
		if curStep == 1780 then
			doTweenAlpha('needleLaugh8','flashingshit',0.35,0.20,'linear')
		end
		
		if curStep == 1782 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh9','flashingshit',0,0.20,'linear')
		end
		
		if curStep == 1784 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh9','flashingshit',0,0.20,'linear')
		end
		
		if curStep == 1786 then
			setProperty('flashingshit.alpha',0.25)
			doTweenAlpha('needleLaugh9','flashingshit',0,0.20,'linear')
		end
		
		if curStep == 1792 then
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('bg2.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit5','flashingshit',0,0.75,'linear')
			zoom = 2;
		end

		if curStep == 64 or curStep == 1712 then
			setProperty('bg1.alpha',0)
			setProperty('bg2.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1.0,'linear')
			setProperty('dad.alpha', 1);
		end  

		--end of flashes
		if curStep == 3328 then
			doTweenAlpha('camHUD','camHUD',0,1.0,'linear')		
		end
		if curStep == 0 or curStep == 1712 then
			setProperty('gf.alpha', 0);
			setProperty('dad.alpha', 0);
			setProperty('bf.alpha', 0);
			setProperty('camHUD.alpha', 0);
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
		
			noteTweenAlpha('opponentStrums0',0 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,0 ,0.05, 'linear')
		
			noteTweenAlpha('playerStrums0',4 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,0.05, 'linear')
		end
		
		if curStep == 128 then
			zoom = 3;
		end
		
		if curStep == 180 or curStep == 1792 then
			setProperty('iconP2.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
			setProperty('timeBarBG.alpha', 1)
			setProperty('timeBar.alpha', 1)
			setProperty('timeTxt.alpha', 1)
		
			noteTweenAlpha('opponentStrums0',0 ,1 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,1 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,1 ,0.05, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,1 ,0.05, 'linear')
		
			noteTweenAlpha('playerStrums0',4 ,1 ,0.05, 'linear')
			noteTweenAlpha('playerStrums1',5 ,1 ,0.05, 'linear')
			noteTweenAlpha('playerStrums2',6 ,1 ,0.05, 'linear')
			noteTweenAlpha('playerStrums3',7 ,1 ,0.05, 'linear')
		end
		
		if curStep == 180 then
			doTweenAlpha('camHUDT1','camHUD',1,1.0,'linear')
		end
		
		if curStep == 390 then
			zoom = 0;
			doTweenAlpha('camHUDT2','camHUD',0,2.2,'linear')
			doTweenAlpha('BlackT1','bg2',1,2.2,'linear')
		end
		
		if curStep == 480 or curStep == 2176 then
			doTweenAlpha('BlackT2','bg2',0,0.1,'linear')
		end
		
		if curStep == 523 then
			doTweenAlpha('camHUDT3','camHUD',1,2.0,'linear')
		end
		
		if curStep == 736 then
			zoom = 3;
		end
		
		if curStep == 992 then
			zoom = 0;
		end
	
		
		if curStep == 2176 then
			setProperty('gf.alpha', 1);
			setProperty('gf.color', getColorFromHex('494949'))
			zoom = 4;
		end
		
		if curStep == 1840 then
			doTweenAlpha('camHUDT8','camHUD',1,2,'linear')
		end
		
		if curStep == 1704 then
			doTweenAlpha('BlackT1','bg2',1,2,'linear')
			doTweenAlpha('camHUDT8','camHUD',0,2,'linear')
		end
		if curStep == 1712 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('FloorLightT1','FloorLight',1,0.5,'linear')
				doTweenAlpha('LightT1','Light',1,0.5,'linear')
			end
			doTweenColor('DADColorT2','dad', 0xFFFFFFFF, 0.5,'linear')
		end
		
		if curStep == 2176 or curStep == 2336 or curStep == 2496 or curStep == 2624 then --needlemouse
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('FloorLightT2','FloorLight',0,0.5,'linear')
				doTweenAlpha('LightT2','Light',0,0.5,'linear')
				doTweenAlpha('FloorLightNEEDLET2','FloorLightNEEDLE',1,0.5,'linear')
				doTweenAlpha('LightNEEDLET2','LightNEEDLE',1,0.5,'linear')
			end
			doTweenColor('GFColorT3','gf', 0xFFFFFFFF, 0.5,'linear')
			doTweenColor('DADColorT3','dad', 494949, 0.5,'linear')
		end
		
		if curStep == 2320 or curStep == 2352 or curStep == 2432 or curStep == 2560 or curStep == 2688 then --luther
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('FloorLightT2','FloorLight',1,0.5,'linear')
				doTweenAlpha('LightT2','Light',1,0.5,'linear')
				doTweenAlpha('FloorLightNEEDLET2','FloorLightNEEDLE',0,0.5,'linear')
				doTweenAlpha('LightNEEDLET2','LightNEEDLE',0,0.5,'linear')
			end
			doTweenColor('GFColorT3','gf', 494949, 0.5,'linear')
			doTweenColor('DADColorT3','dad', 0xFFFFFFFF, 0.5,'linear')
		end		
		
		if curStep == 2358 or curStep == 2592 then --both
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('FloorLightT2','FloorLight',1,0.5,'linear')
				doTweenAlpha('LightT2','Light',1,0.5,'linear')
				doTweenAlpha('FloorLightNEEDLET2','FloorLightNEEDLE',1,0.5,'linear')
				doTweenAlpha('LightNEEDLET2','LightNEEDLE',1,0.5,'linear')
			end
			doTweenColor('GFColorT3','gf', 0xFFFFFFFF, 0.5,'linear')
			doTweenColor('DADColorT3','dad', 0xFFFFFFFF, 0.5,'linear')
		end		
		
		if curStep == 2172 then
			doTweenAlpha('BlackT2','bg2',1,0.1,'linear')
		end
		
		if curStep == 2806 then
			doTweenAlpha('camHUDTSOMETHING','camHUD',0.5,0.5,'linear')
			doTweenAlpha('BlackT2','bg2',1,0.8,'linear')
			
		end
		if curStep == 2816 then
			doTweenAlpha('camHUDTSOMETHING','camHUD',1,0.01,'linear')
			doTweenAlpha('BlackT2','bg2',0,0.01,'linear')
			setProperty('gf.alpha',0)
		end
	end
end