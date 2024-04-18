local camHudBopping = false;
local IconsBopping = false;
local BoppingSpeed = 2;
local camShake = false;

function onCreate()
	setProperty('camHUD.alpha',0)
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/you-cant-run-encore/bg', -2000, -1100);
		scaleObject('bg', 2, 1.6);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('city1', 'bgs/you-cant-run-encore/city1', -2000, -1100);
			scaleObject('city1', 2, 1.6);
			setScrollFactor('city1', 0.9, 1);
			setProperty('city1.antialiasing', true);
			addLuaSprite('city1', false);
			
			makeLuaSprite('city2', 'bgs/you-cant-run-encore/city2', -2000, -1100);
			scaleObject('city2', 2, 1.6);
			setScrollFactor('city2', 1.07, 1);
			setProperty('city2.antialiasing', true);
			addLuaSprite('city2', false);
		end
		
		makeAnimatedLuaSprite('static', 'Phase3/NewTitleMenuBG', -350, -300, 'exe');
		scaleObject('static', 6, 6);
		setScrollFactor('static', 0, 0);
		addAnimationByPrefix('static', 'idle', 'TitleMenuSSBG instance 1', 24, true);
		objectPlayAnimation('static', 'idle', true)
		setProperty('static.antialiasing', true);
		setProperty('static.alpha', 0);
		addLuaSprite('static', false)
		
		makeLuaSprite('floor', 'bgs/you-cant-run-encore/floor', -2250, -2400);
		scaleObject('floor', 2.3, 3);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false);
	end
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		setProperty('bg.alpha',1)
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			setProperty('city1.alpha',1)
			setProperty('city2.alpha',1)
		end
		setProperty('floor.alpha',1)
	end
end

function onBeatHit()
	if camHudBopping == true then
		if BoppingSpeed == 1 then
			if curBeat % 2 == 0 then
				setProperty('camHUD.y',10)
				doTweenY('xHud1','camHUD',0,0.2,'linear')
			end
		end
		if BoppingSpeed == 2 then
			if curBeat % 2 == 0 then
				setProperty('camHUD.y',10)
				doTweenY('xHud1','camHUD',0,0.2,'linear')
			else
				if curBeat % 1 == 0 then
					setProperty('camHUD.y',10)
					doTweenY('xHud2','camHUD',0,0.2,'linear')
				end
			end

		end
	end
	if IconsBopping == true then
		if BoppingSpeed == 1 then
			if curBeat % 4 == 0 then
				setProperty('iconP2.angle', -8);
				doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

				setProperty('iconP1.angle', -8);
				doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
			else
				if curBeat % 2 == 0 then
					setProperty('iconP2.angle', 8);
					doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

					setProperty('iconP1.angle', 8);
					doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
				end
			end
		end
		if BoppingSpeed == 2 then
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
	end
end

function onUpdate(elapsed)

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if curStep == 7 then
		setProperty('iconP2.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('healthBar.alpha', 0)
		setProperty('healthBarBG.alpha', 0)
		setProperty('scoreTxt.alpha', 0);
		setProperty('timeBar.alpha', 0);
		setProperty('timeBarBG.alpha', 0);
		setProperty('timeBarBGBG.alpha', 0);
		setProperty('timeTxt.alpha', 0);

		setProperty('xenoEncHP.alpha', 0);
		setProperty('xenoEncUIthing.alpha', 0);
		setProperty('xenoEncMissesTxt.alpha', 0);
		setProperty('xenoEncIconP1.alpha', 0);
		setProperty('xenoEncIconP2.alpha', 0);
		setProperty('xenoEncHealthBar.alpha', 0);
		
		noteTweenAlpha('OpponentStrums0',0 ,0 ,0.01, 'linear')
		noteTweenAlpha('OpponentStrums1',1 ,0 ,0.01, 'linear')
		noteTweenAlpha('OpponentStrums2',2 ,0 ,0.01, 'linear')
		noteTweenAlpha('OpponentStrums3',3 ,0 ,0.01, 'linear')
		
		noteTweenAlpha('playerStrums0',4 ,0 ,0.01, 'linear')
		noteTweenAlpha('playerStrums1',5 ,0 ,0.01, 'linear')
		noteTweenAlpha('playerStrums2',6 ,0 ,0.01, 'linear')
		noteTweenAlpha('playerStrums3',7 ,0 ,0.01, 'linear')
	end
	if curStep == 8 then
		doTweenAlpha('camHUD1','camHUD',1,0.1,'linear')
	end
	if curStep == 144 then
		camHudBopping = true;
		IconsBopping = true;
		
		doTweenAlpha('iconP2','iconP2',1,0.5,'linear')
		doTweenAlpha('iconP1','iconP1',1,0.5,'linear')
		doTweenAlpha('healthBar','healthBar',1,0.5,'linear')
		doTweenAlpha('healthBarBG','healthBarBG',1,0.5,'linear')
		doTweenAlpha('scoreTxt','scoreTxt',1,0.5,'linear')
		doTweenAlpha('timeBar','timeBar',1,0.5,'linear')
		doTweenAlpha('timeBarBG','timeBarBG',1,0.5,'linear')
		doTweenAlpha('timeBarBGBG','timeBarBGBG',1,0.5,'linear')
		doTweenAlpha('timeTxt','timeTxt',1,0.5,'linear')
		
		doTweenAlpha('xenoEncHP','xenoEncHP',1,0.5,'linear')
		doTweenAlpha('xenoEncUIthing','xenoEncUIthing',1,0.5,'linear')
		doTweenAlpha('xenoEncMissesTxt','xenoEncMissesTxt',1,0.5,'linear')
		doTweenAlpha('xenoEncIconP1','xenoEncIconP1',1,0.5,'linear')
		doTweenAlpha('xenoEncIconP2','xenoEncIconP2',1,0.5,'linear')
		doTweenAlpha('xenoEncHealthBar','xenoEncHealthBar',1,0.5,'linear')
		
		noteTweenAlpha('OpponentStrums00',0 ,0.5 ,0.5, 'linear')
		noteTweenAlpha('OpponentStrums11',1 ,0.5 ,0.5, 'linear')
		noteTweenAlpha('OpponentStrums22',2 ,0.5 ,0.5, 'linear')
		noteTweenAlpha('OpponentStrums33',3 ,0.5 ,0.5, 'linear')
		
		noteTweenAlpha('playerStrums00',4 ,1 ,0.5, 'linear')
		noteTweenAlpha('playerStrums11',5 ,1 ,0.5, 'linear')
		noteTweenAlpha('playerStrums22',6 ,1 ,0.5, 'linear')
		noteTweenAlpha('playerStrums33',7 ,1 ,0.5, 'linear')
	end
	if curStep == 520 then
		camHudBopping = false;
		IconsBopping = false;
	end
	if curStep == 528 then
		if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
			setProperty('bg.alpha',0)
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				setProperty('city1.alpha',0)
				setProperty('city2.alpha',0)
			end
			setProperty('floor.alpha',0)
		end
	end
	if curStep == 784 then
		if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
			setProperty('bg.alpha',1)
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				setProperty('city1.alpha',1)
				setProperty('city2.alpha',1)
			end
			setProperty('floor.alpha',1)
		end
		BoppingSpeed = 1;
		camHudBopping = true;
		IconsBopping = true;
	end
	if curStep == 912 then
		BoppingSpeed = 2;
	end
	if curStep == 1152 then
		BoppingSpeed = 1;
		camHudBopping = false;
		IconsBopping = false;
	end
	if curStep == 1160 then
		doTweenAlpha('camHUD2','camHUD',0,0.8,'linear')
	end
	if curStep == 1254 then
		doTweenAlpha('camHUD3','camHUD',1,1,'linear')
		BoppingSpeed = 2;
		camHudBopping = true;
		IconsBopping = true;
	end
	if curStep == 1276 then
		camHudBopping = false;
		IconsBopping = false;
	end
	if curStep == 1296 then
		doTweenAlpha('camHUD4','camHUD',0,0.5,'linear')
		camShake = true;
	end
	if curStep == 1307 then
		if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
			setProperty('static.alpha', 1);
		end
	end
	if curStep == 1440 then
		if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
			doTweenAlpha('static','static',0,0.5,'linear')
		end
		BoppingSpeed = 1;
		camHudBopping = true;
		IconsBopping = true;
		camShake = false;
	end
	if curStep == 1568 then
		doTweenAlpha('camHUD5','camHUD',1,0.7,'linear')
		BoppingSpeed = 2;
		camHudBopping = false;
		IconsBopping = false;
	end
	if curStep == 1584 then
		doTweenAlpha('camHUD6','camHUD',1,0.5,'linear')
		camHudBopping = true;
		IconsBopping = true;
	end
	if curStep == 1840 then
		doTweenAlpha('camHUD7','camHUD',0,1,'linear')
		camHudBopping = false;
		IconsBopping = false;
	end
	if curStep == 1896 then
		doTweenAlpha('camOther','camOther',0,1,'linear')
		doTweenAlpha('blk','blk',1,1,'linear')
	end
end

function opponentNoteHit()
	if camShake == true then
		cameraShake('game', 0.010, 0.05)
	end
end