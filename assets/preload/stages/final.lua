local xx = 500;
local yy = 350;
local ofs = 5;
local ofs2 = 5;
local xx2 = 700;
local yy2 = 350;
local followchars = false;
local SecondPhase = false;
local PixelPart = false;
local DeezNuts = false;
local DIE = false;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		-- Final Escape Phase 1
		makeLuaSprite('P1bg', 'bgs/final/p1/bg', -400, -250);
		scaleObject('P1bg', 1, 1);
		setScrollFactor('P1bg', 0.4, 1);
		setProperty('P1bg.antialiasing', true);
		addLuaSprite('P1bg', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('P1water', 'bgs/final/p1/water', -450, -250);
			scaleObject('P1water', 1, 1);
			setScrollFactor('P1water', 0.5, 1);
			setProperty('P1water.antialiasing', true);
			addLuaSprite('P1water', false);
			
			makeLuaSprite('P1mountains1', 'bgs/final/p1/mountains-1', -450, -250);
			scaleObject('P1mountains1', 1, 1);
			setScrollFactor('P1mountains1', 0.6, 1);
			setProperty('P1mountains1.antialiasing', true);
			addLuaSprite('P1mountains1', false);
		end
		
		makeLuaSprite('P1mountains2', 'bgs/final/p1/mountains-2', -460, -250);
		scaleObject('P1mountains2', 1, 1);
		setScrollFactor('P1mountains2', 0.8, 1);
		setProperty('P1mountains2.antialiasing', true);
		addLuaSprite('P1mountains2', false);
		
		makeLuaSprite('mountainBF', 'bgs/final/p1/mountain-bf', -470, -250);
		scaleObject('mountainBF', 1, 1);
		setScrollFactor('mountainBF', 1, 1);
		setProperty('mountainBF.antialiasing', true);
		addLuaSprite('mountainBF', false);
	end
	makeLuaSprite('P1XenoRing', 'bgs/final/p1/ring', -110, -165);
	scaleObject('P1XenoRing', 1, 1);
	setScrollFactor('P1XenoRing', 1, 1);
	setProperty('P1XenoRing.antialiasing', true);
	addLuaSprite('P1XenoRing', false);
	
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		-- Final Escape Phase 2
		makeLuaSprite('bg', 'bgs/final/p2/bg', -430, -380);
		scaleObject('bg', 1.2, 1.2);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		--Objects x_x
		makeAnimatedLuaSprite('blackHole', 'bgs/final/p2/Objects/black-hole', -250, 300);
		setScrollFactor('blackHole', 1, 1);
		addAnimationByPrefix('blackHole', 'blackHole', 'black-hole', 30, true);
		setProperty('blackHole.antialiasing', true);
		addLuaSprite('blackHole', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('ring1', 'bgs/final/p2/Objects/ring', -90, -60);
			setScrollFactor('ring1', 1, 1);
			addAnimationByPrefix('ring1', 'ring', 'ring', 24, true);
			setProperty('ring1.antialiasing', true);
			setProperty('ring1.angle', -20);
			addLuaSprite('ring1', false);
			
			makeAnimatedLuaSprite('ring2', 'bgs/final/p2/Objects/ring', 10, -70);
			setScrollFactor('ring2', 1, 1);
			addAnimationByPrefix('ring2', 'ring', 'ring', 30, true);
			setProperty('ring2.antialiasing', true);
			setProperty('ring2.angle', -5);
			addLuaSprite('ring2', false);
			
			makeAnimatedLuaSprite('ring3', 'bgs/final/p2/Objects/ring', 110, -80);
			setScrollFactor('ring3', 1, 1);
			addAnimationByPrefix('ring3', 'ring', 'ring', 30, true);
			setProperty('ring3.antialiasing', true);
			setProperty('ring3.angle', 10);
			addLuaSprite('ring3', false);
			
			makeAnimatedLuaSprite('eggy', 'bgs/final/p2/Objects/eggy', 1000, 50);
			setScrollFactor('eggy', 1, 1);
			addAnimationByPrefix('eggy', 'egg', 'egg', 30, false);
			setProperty('eggy.antialiasing', true);
			addLuaSprite('eggy', false);
			
			makeLuaSprite('Dirt2', 'bgs/final/p2/Objects/dirt-2', 1060, -100);
			scaleObject('Dirt2', 1, 1);
			setScrollFactor('Dirt2', 1, 1);
			setProperty('Dirt2.antialiasing', true);
			addLuaSprite('Dirt2', false);
			
			makeLuaSprite('sega', 'bgs/final/p2/Objects/sega', 1150, 50);
			scaleObject('sega', 1, 1);
			setScrollFactor('sega', 1, 1);
			setProperty('sega.antialiasing', true);
			addLuaSprite('sega', false);
			
			makeLuaSprite('rock', 'bgs/final/p2/Objects/rock', 1350, -50);
			scaleObject('rock', 1, 1);
			setScrollFactor('rock', 1, 1);
			setProperty('rock.antialiasing', true);
			addLuaSprite('rock', false);
			
			makeAnimatedLuaSprite('glitch1', 'bgs/final/p2/Objects/glitch-1', 400, -150);
			setScrollFactor('glitch1', 1, 1);
			addAnimationByPrefix('glitch1', 'gl1', 'glitch-1', 30, true);
			setProperty('glitch1.antialiasing', true);
			addLuaSprite('glitch1', false);
			
			makeAnimatedLuaSprite('glitch2', 'bgs/final/p2/Objects/glitch-2', 700, -140);
			setScrollFactor('glitch2', 1, 1);
			addAnimationByPrefix('glitch2', 'gl2', 'glitch-2', 30, true);
			setProperty('glitch2.antialiasing', true);
			addLuaSprite('glitch2', false);
			
			makeLuaSprite('O', 'bgs/final/p2/Objects-SONIC/O', 160, 630);
			scaleObject('O', 1, 1);
			setScrollFactor('O', 1, 1);
			setProperty('O.antialiasing', true);
			addLuaSprite('O', false);
			
			makeLuaSprite('S', 'bgs/final/p2/Objects-SONIC/S', -140, 660);
			scaleObject('S', 1, 1);
			setScrollFactor('S', 1, 1);
			setProperty('S.antialiasing', true);
			addLuaSprite('S', false);

			makeLuaSprite('C', 'bgs/final/p2/Objects-SONIC/C', 1350, 450);
			scaleObject('C', 1, 1);
			setScrollFactor('C', 1, 1);
			setProperty('C.antialiasing', true);
			addLuaSprite('C', false);
			
			makeLuaSprite('N', 'bgs/final/p2/Objects-SONIC/N', 850, 400);
			scaleObject('N', 1, 1);
			setScrollFactor('N', 1, 1);
			setProperty('N.antialiasing', true);
			addLuaSprite('N', false);
			
			makeLuaSprite('I', 'bgs/final/p2/Objects-SONIC/I', 1200, 400);
			scaleObject('I', 1, 1);
			setScrollFactor('I', 1, 1);
			setProperty('I.antialiasing', true);
			addLuaSprite('I', false);

			makeAnimatedLuaSprite('checkpoint', 'bgs/final/p2/Objects/checkpoint', -200, 400);
			setScrollFactor('checkpoint', 1, 1);
			addAnimationByPrefix('checkpoint', 'checkpoint', 'checkpoint', 30, true);
			setProperty('checkpoint.antialiasing', true);
			addLuaSprite('checkpoint', false);
			
			makeLuaSprite('Dirt1', 'bgs/final/p2/Objects/dirt-1', 200, -150);
			scaleObject('Dirt1', 1, 1);
			setScrollFactor('Dirt1', 1, 1);
			setProperty('Dirt1.antialiasing', true);
			addLuaSprite('Dirt1', false);
		end
		
		makeLuaSprite('mountains', 'bgs/final/p2/mountains', -230, -140);
		scaleObject('mountains', 1, 1);
		setScrollFactor('mountains', 1, 1);
		setProperty('mountains.antialiasing', true);
		addLuaSprite('mountains', false);
		
		makeLuaSprite('mountains3', 'bgs/final/p2/mountains', -1130, -500);
		scaleObject('mountains3', 1.5, 1.5);
		setScrollFactor('mountains3', 1, 1);
		setProperty('mountains3.antialiasing', true);
		addLuaSprite('mountains3', false);
		
		makeLuaSprite('mountains2', 'bgs/final/p2/mountains', -330, -750);
		scaleObject('mountains2', 1.5, 1.5);
		setScrollFactor('mountains2', 1, 1);
		setProperty('mountains2.antialiasing', true);
		addLuaSprite('mountains2', false);
	end
	
	makeLuaSprite('Ring', 'bgs/final/p2/Ring', -190, -85);
	scaleObject('Ring', 1, 1);
	setScrollFactor('Ring', 1, 1);
	setProperty('Ring.antialiasing', true);
	addLuaSprite('Ring', false);
	
	makeAnimatedLuaSprite('emblem', 'bgs/final/p2/emblem', -250, 300);
	setScrollFactor('emblem', 1, 1);
	addAnimationByPrefix('emblem', 'emblem', 'emblem', 24, true);
	setProperty('emblem.antialiasing', true);
	addLuaSprite('emblem', false);
	
	makeAnimatedLuaSprite('BFRunningLegs', 'characters/BF/HD/Running/bf-fe-p2-legs', 690, 635);
	setScrollFactor('BFRunningLegs', 1, 1);
	addAnimationByPrefix('BFRunningLegs', 'legs', 'legs', 24, true);
	setProperty('BFRunningLegs.antialiasing', true);
	setProperty('BFRunningLegs.scale.x',0.7)
	setProperty('BFRunningLegs.scale.y',0.7)
	setProperty('BFRunningLegs.alpha',0)
	addLuaSprite('BFRunningLegs', false);
	
	makeAnimatedLuaSprite('BGpix', 'bgs/final/pixel/BG', -1300, -800);
	addAnimationByPrefix('BGpix', 'idle', 'BG ', 12, true);
	scaleObject('BGpix', 9, 9);
	setScrollFactor('BGpix', 0.7, 1);
	setProperty('BGpix.antialiasing', false);
	setProperty('BGpix.alpha', 0);
	addLuaSprite('BGpix', false);
	
	makeLuaSprite('FloorPix', 'bgs/final/pixel/pix-floor', -2000, 0);
	scaleObject('FloorPix', 9, 9);
	setScrollFactor('FloorPix', 1, 1);
	setProperty('FloorPix.antialiasing', false);
	setProperty('FloorPix.alpha', 0);
	addLuaSprite('FloorPix', false);
	
	makeLuaSprite('epico', 'bgs/final/pixel/epico', -250, -140);
	setScrollFactor('epico', 0, 0);
	scaleObject('epico', 1.4, 1.4);
	setProperty('epico.antialiasing', true);
	setProperty('epico.alpha', 0);
	addLuaSprite('epico', true);
	
	makeLuaSprite('blackscreen', '', 0, 0);
	makeGraphic('blackscreen',1920,1080,'000000')
	addLuaSprite('blackscreen', true);
	setLuaSpriteScrollFactor('blackscreen',0,0)
	setProperty('blackscreen.scale.x',2)
	setProperty('blackscreen.scale.y',2)
	setProperty('blackscreen.alpha',1)
	
	makeLuaSprite('blackbg', '', 0, 0);
	makeGraphic('blackbg',1920,1080,'000000')
	addLuaSprite('blackbg', false);
	setLuaSpriteScrollFactor('blackbg',0,0)
	setProperty('blackbg.scale.x',2)
	setProperty('blackbg.scale.y',2)
	setProperty('blackbg.alpha',0)
	
	makeLuaSprite('DeezNutsRing', 'bgs/final/p1/ring', -110, -165);
	scaleObject('DeezNutsRing', 1, 1);
	setScrollFactor('DeezNutsRing', 1, 1);
	setProperty('DeezNutsRing.antialiasing', true);
	setProperty('DeezNutsRing.alpha',0)
	addLuaSprite('DeezNutsRing', false);
	
	makeLuaSprite('redshit', '', 0, 0);
	makeGraphic('redshit',1920,1080,'A80000')
	addLuaSprite('redshit', true);
	setLuaSpriteScrollFactor('redshit',0,0)
	setProperty('redshit.scale.x',2)
	setProperty('redshit.scale.y',2)
	setProperty('redshit.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		setProperty('bg.alpha', 0);
		setProperty('blackHole.alpha', 0);
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('ring1.alpha', 0);
			setProperty('ring2.alpha', 0);
			setProperty('ring3.alpha', 0);
			setProperty('eggy.alpha', 0);
			setProperty('Dirt2.alpha', 0);
			setProperty('sega.alpha', 0);
			setProperty('rock.alpha', 0);
			setProperty('glitch1.alpha', 0);
			setProperty('glitch2.alpha', 0);
			setProperty('S.alpha', 0);
			setProperty('O.alpha', 0);
			setProperty('N.alpha', 0);
			setProperty('I.alpha', 0);
			setProperty('C.alpha', 0);
			setProperty('checkpoint.alpha', 0);
			setProperty('Dirt1.alpha', 0);
		end
		setProperty('mountains.alpha', 0);
		setProperty('mountains3.alpha', 0);
		setProperty('mountains2.alpha', 0);
	end
	setProperty('Ring.alpha', 0);
	setProperty('emblem.alpha', 0);
	setProperty('camHUD.alpha', 0);
	
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		runTimer('S-Fly Up', 0.1, 1)
		runTimer('O-Fly Up', 0.35, 1)
		runTimer('N-Fly Up', 0.3, 1)
		runTimer('I-Fly Up', 0.65, 1)
		runTimer('C-Fly Up', 0.45, 1)
		runTimer('Checkpoint-Fly Up', 0.45, 1)
		runTimer('Dirt1-Fly Up', 0.50, 1)
		runTimer('Glitch1-Fly Up', 0.8, 1)
		runTimer('Glitch2-Fly Up', 0.65, 1)
		runTimer('Rock-Fly Up', 0.7, 1)
		runTimer('Sega-Fly Up', 0.4, 1)
		runTimer('Dirt2-Fly Up', 1.1, 1)
		runTimer('Egg-Fly Up', 0.60, 1)
		runTimer('Ring1-Fly Up', 0.30, 1)
		runTimer('Ring2-Fly Up', 0.40, 1)
		runTimer('Ring3-Fly Up', 0.50, 1)
	end
end

function onTimerCompleted(tag)
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		if DIE == false then
			--S.O.N.I.C - S
			if tag == 'S-Fly Up' then
				doTweenY('S-TweenUp', 'S', 720, 2.5, 'quadInOut')
				runTimer('S-Fly Down', 2.5, 1)
			end
			if tag == 'S-Fly Down' then
				doTweenY('S-TweenDown', 'S', 660, 2.0, 'quadInOut')
				runTimer('S-Fly Up', 2.0, 1)
			end
			
			--S.O.N.I.C - O
			if tag == 'O-Fly Up' then
				doTweenY('O-TweenUp', 'O', 690, 2.5, 'quadInOut')
				runTimer('O-Fly Down', 2.5, 1)
			end
			if tag == 'O-Fly Down' then
				doTweenY('O-TweenDown', 'O', 630, 2.0, 'quadInOut')
				runTimer('O-Fly Up', 2.0, 1)
			end
			
			--S.O.N.I.C - N
			if tag == 'N-Fly Up' then
				doTweenY('N-TweenUp', 'N', 400, 2.5, 'quadInOut')
				runTimer('N-Fly Down', 2.5, 1)
			end
			if tag == 'N-Fly Down' then
				doTweenY('N-TweenDown', 'N', 460, 2.0, 'quadInOut')
				runTimer('N-Fly Up', 2.0, 1)
			end
			
			--S.O.N.I.C - I
			if tag == 'I-Fly Up' then
				doTweenY('I-TweenUp', 'I', 400, 2.5, 'quadInOut')
				runTimer('I-Fly Down', 2.5, 1)
			end
			if tag == 'I-Fly Down' then
				doTweenY('I-TweenDown', 'I', 460, 2.0, 'quadInOut')
				runTimer('I-Fly Up', 2.0, 1)
			end
			
			--S.O.N.I.C - C
			if tag == 'C-Fly Up' then
				doTweenY('C-TweenUp', 'C', 400, 2.5, 'quadInOut')
				runTimer('C-Fly Down', 2.5, 1)
			end
			if tag == 'C-Fly Down' then
				doTweenY('C-TweenDown', 'C', 460, 2.0, 'quadInOut')
				runTimer('C-Fly Up', 2.0, 1)
			end
			
			--Checkpoint
			if tag == 'Checkpoint-Fly Up' then
				doTweenY('Checkpoint-TweenUp', 'checkpoint', 440, 2.5, 'quadInOut')
				runTimer('Checkpoint-Fly Down', 2.5, 1)
			end
			if tag == 'Checkpoint-Fly Down' then
				doTweenY('Checkpoint-TweenDown', 'checkpoint', 400, 2.0, 'quadInOut')
				runTimer('Checkpoint-Fly Up', 2.0, 1)
			end
			
			--Dirt 1
			if tag == 'Dirt1-Fly Up' then
				doTweenY('Dirt1-TweenUp', 'Dirt1', -150, 2.5, 'quadInOut')
				runTimer('Dirt1-Fly Down', 2.5, 1)
			end
			if tag == 'Dirt1-Fly Down' then
				doTweenY('Dirt1-TweenDown', 'Dirt1', -180, 2.0, 'quadInOut')
				runTimer('Dirt1-Fly Up', 2.0, 1)
			end
			
			--Glitch 1
			if tag == 'Glitch1-Fly Up' then
				doTweenY('Glitch1-TweenUp', 'glitch1', -130, 2.5, 'quadInOut')
				runTimer('Glitch1-Fly Down', 2.5, 1)
			end
			if tag == 'Glitch1-Fly Down' then
				doTweenY('Glitch1-TweenDown', 'glitch1', -150, 2.0, 'quadInOut')
				runTimer('Glitch1-Fly Up', 2.0, 1)
			end
			
			--Glitch 2
			if tag == 'Glitch2-Fly Up' then
				doTweenY('Glitch2-TweenUp', 'glitch2', -120, 2.5, 'quadInOut')
				runTimer('Glitch2-Fly Down', 2.5, 1)
			end
			if tag == 'Glitch2-Fly Down' then
				doTweenY('Glitch2-TweenDown', 'glitch2', -140, 2.0, 'quadInOut')
				runTimer('Glitch2-Fly Up', 2.0, 1)
			end
			
			--Rock
			if tag == 'Rock-Fly Up' then
				doTweenY('Rock-TweenUp', 'rock', -20, 2.5, 'quadInOut')
				runTimer('Rock-Fly Down', 2.5, 1)
			end
			if tag == 'Rock-Fly Down' then
				doTweenY('Rock-TweenDown', 'rock', -50, 2.0, 'quadInOut')
				runTimer('Rock-Fly Up', 2.0, 1)
			end
			
			--Sega
			if tag == 'Sega-Fly Up' then
				doTweenY('Sega-TweenUp', 'sega', 90, 2.5, 'quadInOut')
				runTimer('Sega-Fly Down', 2.5, 1)
			end
			if tag == 'Sega-Fly Down' then
				doTweenY('Sega-TweenDown', 'sega', 50, 2.0, 'quadInOut')
				runTimer('Sega-Fly Up', 2.0, 1)
			end
			
			--Dirt 2
			if tag == 'Dirt2-Fly Up' then
				doTweenY('Dirt2-TweenUp', 'Dirt2', -70, 2.5, 'quadInOut')
				runTimer('Dirt2-Fly Down', 2.5, 1)
			end
			if tag == 'Dirt2-Fly Down' then
				doTweenY('Dirt2-TweenDown', 'Dirt2', -100, 2.0, 'quadInOut')
				runTimer('Dirt2-Fly Up', 2.0, 1)
			end
			
			--Egg
			if tag == 'Egg-Fly Up' then
				doTweenY('Egg-TweenUp', 'eggy', 90, 2.5, 'quadInOut')
				runTimer('Egg-Fly Down', 2.5, 1)
			end
			if tag == 'Egg-Fly Down' then
				doTweenY('Egg-TweenDown', 'eggy', 50, 2.0, 'quadInOut')
				runTimer('Egg-Fly Up', 2.0, 1)
			end
			
			--Ring 1
			if tag == 'Ring1-Fly Up' then
				doTweenY('Ring1-TweenUp', 'ring1', -40, 2.5, 'quadInOut')
				runTimer('Ring1-Fly Down', 2.5, 1)
			end
			if tag == 'Ring1-Fly Down' then
				doTweenY('Ring1-TweenDown', 'ring1', -60, 2.0, 'quadInOut')
				runTimer('Ring1-Fly Up', 2.0, 1)
			end
			
			--Ring 2
			if tag == 'Ring2-Fly Up' then
				doTweenY('Ring2-TweenUp', 'ring2', -50, 2.5, 'quadInOut')
				runTimer('Ring2-Fly Down', 2.5, 1)
			end
			if tag == 'Ring2-Fly Down' then
				doTweenY('Ring2-TweenDown', 'ring2', -70, 2.0, 'quadInOut')
				runTimer('Ring2-Fly Up', 2.0, 1)
			end
			
			--Ring 3
			if tag == 'Ring3-Fly Up' then
				doTweenY('Ring3-TweenUp', 'ring3', -60, 2.5, 'quadInOut')
				runTimer('Ring3-Fly Down', 2.5, 1)
			end
			if tag == 'Ring3-Fly Down' then
				doTweenY('Ring3-TweenDown', 'ring3', -80, 2.0, 'quadInOut')
				runTimer('Ring3-Fly Up', 2.0, 1)
			end
		end
	end
	if PixelPart == false then
		if SecondPhase == true then
			--Xeno Ring
			if tag == 'XenoRing-Fly Up' then
				doTweenY('XenoRing-TweenUp', 'Ring', -115, 2.5, 'quadInOut')
				runTimer('XenoRing-Fly Down', 2.5, 1)
			end
			if tag == 'XenoRing-Fly Down' then
				doTweenY('XenoRing-TweenDown', 'Ring', -85, 2.0, 'quadInOut')
				runTimer('XenoRing-Fly Up', 2.0, 1)
			end
				
			--Xeno
			if tag == 'Xeno-Fly Up' then
				doTweenY('Xeno-TweenUp', 'dad', 0, 2.5, 'quadInOut')
				runTimer('Xeno-Fly Down', 2.5, 1)
			end
			if tag == 'Xeno-Fly Down' then
				doTweenY('Xeno-TweenDown', 'dad', 30, 2.0, 'quadInOut')
				runTimer('Xeno-Fly Up', 2.0, 1)
			end
		end
	end
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('eggy', 'egg', true)
		else
			objectPlayAnimation('eggy', 'egg', true)
		end
	end
end

function onUpdate(elapsed)
	if DIE == true then
		doTweenZoom('ZOOMDAD', 'camGame',0.8, 1.0, 'quadOut')
	else
		if DeezNuts == true then
			doTweenZoom('ZOOMDAD', 'camGame',0.9, 1.0, 'quadOut')
			triggerEvent('Camera Follow Pos',500,200)
		else
			if PixelPart == false then
				if SecondPhase == false then
					if mustHitSection == false then
						doTweenZoom('ZOOMDAD', 'camGame',0.7, 1.0, 'quadOut')
					else
						doTweenZoom('ZOOMDAD', 'camGame',0.9, 1.0, 'quadOut')
					end
				else
					if mustHitSection == false then
						doTweenZoom('ZOOMDAD', 'camGame',0.75, 1.0, 'quadOut')
					else
						doTweenZoom('ZOOMDAD', 'camGame',0.95, 1.0, 'quadOut')
					end
				end
			else
				doTweenZoom('ZOOMDAD', 'camGame', 0.45, 1.0, 'quadOut')
			end
		end
	end

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if SecondPhase == true then
		if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			setProperty('BFRunningLegs.alpha', 0);
		else
			setProperty('BFRunningLegs.alpha', 1);
		end
	end
	
	if songName == "final-escape" then
		if curStep == 7 then
			doTweenAlpha('whitescreen1','flashingshit',1,2,'linear')
			
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeBar.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("DADnote4", 0, 3000, 0.25, quadInOut)
				noteTweenX("DADnote5", 1, 3000, 0.25, quadInOut)
				noteTweenX("DADnote6", 2, 3000, 0.25, quadInOut)
				noteTweenX("DADnote7", 3, 3000, 0.25, quadInOut)
				
				noteTweenX("BFnote4", 4, 370, 0.25, quadInOut)
				noteTweenX("BFnote5", 5, 510, 0.25, quadInOut)
				noteTweenX("BFnote6", 6, 650, 0.25, quadInOut)
				noteTweenX("BFnote7", 7, 790, 0.25, quadInOut)
			end
			
			setPropertyFromGroup('playerStrums',0,'alpha',0.6)
			setPropertyFromGroup('playerStrums',1,'alpha',0.6)
			setPropertyFromGroup('playerStrums',2,'alpha',0.6)
			setPropertyFromGroup('playerStrums',3,'alpha',0.6)
		end

		if curStep == 32 then
			setProperty('blackscreen.alpha', 0);
			doTweenAlpha('whitescreen2','flashingshit',0,1,'linear')
		end
		
		if curStep == 128 then
			doTweenAlpha('camHUDT','camHUD',1,1,'linear')
		end
		
		if curStep == 272 then
			doTweenAlpha('whitescreen3','flashingshit',1,1.2,'linear')
		end
		
		if curStep == 288 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha', 1);
				setProperty('blackHole.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('ring1.alpha', 1);
					setProperty('ring2.alpha', 1);
					setProperty('ring3.alpha', 1);
					setProperty('eggy.alpha', 1);
					setProperty('Dirt2.alpha', 1);
					setProperty('sega.alpha', 1);
					setProperty('rock.alpha', 1);
					setProperty('glitch1.alpha', 1);
					setProperty('glitch2.alpha', 1);
					setProperty('S.alpha', 1);
					setProperty('O.alpha', 1);
					setProperty('N.alpha', 1);
					setProperty('I.alpha', 1);
					setProperty('C.alpha', 1);
					setProperty('checkpoint.alpha', 1);
					setProperty('Dirt1.alpha', 1);
				end
				setProperty('mountains.alpha', 1);
				setProperty('mountains3.alpha', 1);
				setProperty('mountains2.alpha', 1);
			end
			setProperty('Ring.alpha', 1);
			setProperty('emblem.alpha', 1);
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('P1bg.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('P1water.alpha', 0);
					setProperty('P1mountains1.alpha', 0);
				end
				setProperty('P1mountains2.alpha', 0);
				setProperty('mountainBF.alpha', 0);
			end
			setProperty('P1XenoRing.alpha', 0);
		
			SecondPhase = true;
			runTimer('XenoRing-Fly Up', 0.10, 1)
			runTimer('Xeno-Fly Up', 0.10, 1)
			doTweenAlpha('whitescreen3','flashingshit',0,0.7,'linear')
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("BFnote4ClassicPos", 4, 733, 0.6, quadInOut)
				noteTweenX("BFnote5ClassicPos", 5, 845, 0.6, quadInOut)
				noteTweenX("BFnote6ClassicPos", 6, 957, 0.6, quadInOut)
				noteTweenX("BFnote7ClassicPos", 7, 1069, 0.6, quadInOut)
			end
			
			noteTweenAlpha('BFnoteTween1',4 ,1 ,0.6, quadInOut)
			noteTweenAlpha('BFnoteTween2',5 ,1 ,0.6, quadInOut)
			noteTweenAlpha('BFnoteTween3',6 ,1 ,0.6, quadInOut)
			noteTweenAlpha('BFnoteTween4',7 ,1 ,0.6, quadInOut)
		end
		
		if curStep == 1312 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash0','flashingshit',0,1,'linear')
		end
		
		if curStep == 1568 then
			doTweenAlpha('camHUDT2','camHUD',0,1,'linear')
		end
		
		if curStep == 1664 then
			doTweenAlpha('camHUDT4','camHUD',1,1,'linear')
		end
		
		if curStep == 1690 then
			doTweenAlpha('camHUDT5','camHUD',0,1,'linear')
		end
		
		if curStep == 1792 then
			doTweenAlpha('camHUDT6','camHUD',1,1,'linear')
		end
		
		if curStep == 1816 then
			doTweenAlpha('flash1','flashingshit',1,0.7,'linear')
		end
		
		if curStep == 1824 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash2','flashingshit',0,1,'linear')
		end
		
		if curStep == 2336 then
			doTweenAlpha('blackscreen1','blackscreen',1,3,'linear')
			doTweenAlpha('camHUDT2','camHUD',0,2,'linear')
		end
		
		if curStep == 2400 then
			followchars = true;
			PixelPart = true;
			SecondPhase = false;
			setScrollFactor('dadGroup', 1.3, 1);
			setProperty('BGpix.alpha',1)
			setProperty('FloorPix.alpha',1)
			setProperty('epico.alpha',1)
			setProperty('dad.x',0)
			setProperty('dad.y',550)
			setProperty('boyfriend.x',1004)
			setProperty('boyfriend.y',383)
		end
		
		if curStep == 2464 then
			setProperty('blackscreen.alpha', 0);
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash3','flashingshit',0,1,'linear')
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("DADnote0ClassicPos", 0, 93, 0.25, quadInOut)
				noteTweenX("DADnote1ClassicPos", 1, 205, 0.25, quadInOut)
				noteTweenX("DADnote2ClassicPos", 2, 317, 0.25, quadInOut)
				noteTweenX("DADnote3ClassicPos", 3, 429, 0.25, quadInOut)
			end
		end
		
		if curStep == 2704 then
			doTweenAlpha('camHUDT3','camHUD',1,1.5,'linear')
		end
		
		if curStep == 3104 then
			doTweenAlpha('blackscreen2','blackscreen',1,0.7,'linear')
			doTweenAlpha('camHUDT3','camHUD',0,0.8,'linear')
		end
		
		if curStep == 3117 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("DADnote4", 0, 3000, 0.02, quadInOut)
				noteTweenX("DADnote5", 1, 3000, 0.02, quadInOut)
				noteTweenX("DADnote6", 2, 3000, 0.02, quadInOut)
				noteTweenX("DADnote7", 3, 3000, 0.02, quadInOut)
			end
			setProperty('boyfriend.alpha', 0);
			setProperty('blackbg.alpha', 1);
			setProperty('DeezNutsRing.alpha', 1);
			setProperty('BGpix.alpha',0)
			setProperty('FloorPix.alpha',0)
			setProperty('epico.alpha',0)
			setScrollFactor('dadGroup', 1, 1);
			setProperty('boyfriend.x',690)
			setProperty('boyfriend.y',480)
			setProperty('dad.x',160)
			setProperty('dad.y',30)
			followchars = false;
			PixelPart = false;
			DeezNuts = true;
		end
		
		if curStep == 3118 then
			doTweenAlpha('blackscreen3','blackscreen',0,0.25,'linear')
		end
		
		if curStep == 3128 then
			doTweenAlpha('redshit','redshit',1,0.6,'quadOut')
		end
		
		if curStep == 3136 then
			DeezNuts = false;
			triggerEvent('Camera Follow Pos','','')
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash4','flashingshit',0,1,'linear')
			doTweenAlpha('camHUDT4','camHUD',1,1,'linear')
			setProperty('boyfriend.alpha', 1);
			setProperty('redshit.alpha', 0);
			setProperty('DeezNutsRing.alpha', 0);
			setProperty('blackbg.alpha', 0);
			runTimer('XenoRing-Fly Up', 0.10, 1)
			runTimer('Xeno-Fly Up', 0.10, 1)
			SecondPhase = true;
		end
		
		if curStep == 3924 then
			DIE = true;
			doTweenAlpha('blackscreen3','blackscreen',1,3,'linear')
			doTweenAlpha('camHUDT3','camHUD',0,3,'linear')
			
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				cancelTween('S-TweenUp');
				cancelTween('S-TweenDown');
				cancelTween('O-TweenUp');
				cancelTween('O-TweenDown');
				cancelTween('N-TweenUp');
				cancelTween('N-TweenDown');
				cancelTween('I-TweenUp');
				cancelTween('I-TweenDown');
				cancelTween('C-TweenUp');
				cancelTween('C-TweenDown');
				cancelTween('Checkpoint-TweenUp');
				cancelTween('Checkpoint-TweenDown');
				cancelTween('Dirt1-TweenUp');
				cancelTween('Dirt1-TweenDown');
				cancelTween('Glitch1-TweenUp');
				cancelTween('Glitch1-TweenDown');
				cancelTween('Glitch2-TweenUp');
				cancelTween('Glitch2-TweenDown');
				cancelTween('Rock-TweenUp');
				cancelTween('Rock-TweenDown');
				cancelTween('Sega-TweenUp');
				cancelTween('Sega-TweenDown');
				cancelTween('Dirt2-TweenUp');
				cancelTween('Dirt2-TweenDown');
				cancelTween('Egg-TweenUp');
				cancelTween('Egg-TweenDown');
				cancelTween('Ring1-TweenUp');
				cancelTween('Ring1-TweenDown');
				cancelTween('Ring2-TweenUp');
				cancelTween('Ring2-TweenDown');
				cancelTween('Ring3-TweenUp');
				cancelTween('Ring3-TweenDown');
			end
			cancelTween('XenoRing-TweenUp');
			cancelTween('XenoRing-TweenDown');
			cancelTween('Xeno-TweenUp');
			cancelTween('Xeno-TweenDown');
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenX('BlackHoleX-DIE', 'blackHole', -1100, 6, 'quadInOut')
				doTweenY('BlackHoleY-DIE', 'blackHole', 800, 6, 'quadInOut')
				doTweenAlpha('BlackHoleAlpha-DIE','blackHole',0,6,'quadInOut')
				doTweenAlpha('BG-DIE','bg',0,9,'quadInOut')
				
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenY('S-DIE', 'S', 1100, 2.7, 'quadInOut')
					doTweenY('O-DIE', 'O', 1100, 2.7, 'quadInOut')
					doTweenY('N-DIE', 'N', 1100, 2.7, 'quadInOut')
					doTweenY('I-DIE', 'I', 1100, 2.7, 'quadInOut')
					doTweenY('C-DIE', 'C', 1100, 2.7, 'quadInOut')
					doTweenAngle('S-DIE-Rotate', 'S', 100, 4.5, 'quadInOut')
					doTweenAngle('O-DIE-Rotate', 'O', -100, 4.5, 'quadInOut')
					doTweenAngle('N-DIE-Rotate', 'N', 50, 4.5, 'quadInOut')
					doTweenAngle('I-DIE-Rotate', 'I', 100, 4.5, 'quadInOut')
					doTweenAngle('C-DIE-Rotate', 'C', -150, 4.5, 'quadInOut')
					
					doTweenY('RingOne-DIE', 'ring1', 1100, 4.1, 'quadInOut')
					doTweenY('RingTwo-DIE', 'ring2', 1100, 4.5, 'quadInOut')
					doTweenY('RingThree-DIE', 'ring3', 1100, 4.3, 'quadInOut')
					doTweenAngle('RingOne-DIE-Rotate', 'ring1', 50, 4.5, 'quadInOut')
					doTweenAngle('RingTwo-DIE-Rotate', 'ring2', 100, 4.5, 'quadInOut')
					doTweenAngle('RingThree-DIE-Rotate', 'ring3', -150, 4.5, 'quadInOut')
					
					doTweenY('EGG-DIE', 'eggy', 1100, 4.1, 'quadInOut')
					doTweenAngle('EGG-DIE-Rotate', 'eggy', -100, 4.5, 'quadInOut')
					
					doTweenY('Dirt2-DIE', 'Dirt2', 1100, 4.1, 'quadInOut')
					doTweenAngle('Dirt2-DIE-Rotate', 'Dirt2', 50, 4.5, 'quadInOut')
					
					doTweenY('Sega-DIE', 'sega', 1100, 3.9, 'quadInOut')
					doTweenAngle('Sega-DIE-Rotate', 'sega', 100, 4.5, 'quadInOut')
					
					doTweenY('Rock-DIE', 'rock', 1100, 3.9, 'quadInOut')
					doTweenAngle('Rock-DIE-Rotate', 'rock', 85, 4.5, 'quadInOut')
					
					doTweenAlpha('Glitch1-DIE','glitch1',0,4,'quadInOut')
					doTweenAlpha('Glitch2-DIE','glitch2',0,4,'quadInOut')
					
					doTweenY('Checkpoint-DIE', 'checkpoint', 1100, 3.9, 'quadInOut')
					doTweenAngle('Checkpoint-DIE-Rotate', 'checkpoint', 110, 4.5, 'quadInOut')
					
					doTweenY('Dirt1-DIE', 'Dirt1', 1100, 4.1, 'quadInOut')
					doTweenAngle('Dirt1-DIE-Rotate', 'Dirt1', -50, 4.5, 'quadInOut')
				end
				
				doTweenY('Mountains-DIE', 'mountains', 1100, 8, 'quadInOut')
				doTweenY('Mountains3-DIE', 'mountains3', 1100, 8, 'quadInOut')
				doTweenY('Mountains2-DIE', 'mountains2', 1100, 8, 'quadInOut')
			end
			doTweenY('Ring-DIE', 'Ring', 700, 9, 'quadInOut')
			doTweenY('Emblem-DIE', 'emblem', 1700, 9, 'quadInOut')
			
			doTweenY('Xeno-DIE', 'dad', 700, 9, 'quadInOut')
			doTweenY('BF-DIE', 'boyfriend', 1300, 9, 'quadInOut')
			doTweenY('BFLegs-DIE', 'BFRunningLegs', 1300, 9, 'quadInOut')
			
			cameraShake('game', 0.0035, 10)
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
			if getProperty('dad.animation.curAnim.name') == 'boo' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
			if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
			if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
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

function opponentNoteHit()
	if SecondPhase == false and DeezNuts == false and PixelPart == false and DIE == false then
		health = getProperty('health')
		if getProperty('health') > 0.5 then
			setProperty('health', health- 0.010);
		end
		
		cameraShake('game', 0.0025, 0.05)
	end
	if SecondPhase == true and DeezNuts == false and PixelPart == false and DIE == false then
		health = getProperty('health')
		if getProperty('health') > 0.25 then
			setProperty('health', health- 0.020);
		end
		
		cameraShake('game', 0.005, 0.05)
	end
	if SecondPhase == false and DeezNuts == true and PixelPart == false and DIE == false then
		health = getProperty('health')
		if getProperty('health') > 0.4 then
			setProperty('health', health- 0.015);
		end
		
		cameraShake('game', 0.004, 0.05)
	end
end