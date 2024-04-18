function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
	if songName == 'malediction' then	
		makeLuaSprite('bg', 'bgs/curse/malediction/background', -300, -200);
		scaleObject('bg', 1, 1);
		setScrollFactor('bg', 0, 0);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		makeLuaSprite('treesback', 'bgs/curse/malediction/treesfarback', -850, -300);
		scaleObject('treesback', 1.5, 1.5);
		setScrollFactor('treesback', 1, 1);
		setProperty('treesback.antialiasing', true);
		addLuaSprite('treesback', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('trees', 'bgs/curse/malediction/treesback', -850, -300);
			scaleObject('trees', 1.5, 1.5);
			setScrollFactor('trees', 1, 1);
			setProperty('trees.antialiasing', true);
			addLuaSprite('trees', false);
		
			makeAnimatedLuaSprite('fountain', 'bgs/curse/malediction/goofyahfountain', 200, -50);
			scaleObject('fountain', 1.5, 1.5);
			setScrollFactor('fountain', 1, 1);
			addAnimationByPrefix('fountain', 'fountain', 'fountainlol', 24, true);
			setProperty('fountain.antialiasing', true);
			addLuaSprite('fountain', false);
		end
		
		makeLuaSprite('floor', 'bgs/curse/malediction/floor', -750, 675);
		scaleObject('floor', 1.5, 1.5);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false);
	end
	
	if songName == 'unblessful-hedgehog' then
		makeLuaSprite('skyBad', 'bgs/curse/bad/sky', -1150, -700);
		scaleObject('skyBad', 1.5, 1.5);
		setScrollFactor('skyBad', 1.3, 1.3);
		setProperty('skyBad.antialiasing', true);
		addLuaSprite('skyBad', false);

		makeLuaSprite('cityBad2', 'bgs/curse/bad/city2', -950, -700);
		scaleObject('cityBad2', 1.5, 1.5);
		setScrollFactor('cityBad2', 0.4, 0.4);
		setProperty('cityBad2.antialiasing', true);
		addLuaSprite('cityBad2', false);

		makeLuaSprite('cityBad1', 'bgs/curse/bad/city1', -1150, -700);
		scaleObject('cityBad1', 1.5, 1.5);
		setScrollFactor('cityBad1', 0.6, 0.6);
		setProperty('cityBad1.antialiasing', true);
		addLuaSprite('cityBad1', false);
	
		makeLuaSprite('treesBad', 'bgs/curse/bad/trees', -1150, -700);
		scaleObject('treesBad', 1.5, 1.5);
		setScrollFactor('treesBad', 0.8, 0.8);
		setProperty('treesBad.antialiasing', true);
		addLuaSprite('treesBad', false);
	
		makeLuaSprite('floorBad', 'bgs/curse/bad/floor', -1150, -700);
		scaleObject('floorBad', 1.5, 1.5);
		setScrollFactor('floorBad', 1, 1);
		setProperty('floorBad.antialiasing', true);
		addLuaSprite('floorBad', false);
		
	end
	
	makeAnimatedLuaSprite('static', 'bgs/curse/malediction/staticCurse', -350, -300);
	scaleObject('static', 1.75, 1.75);
	setScrollFactor('static', 0, 0);
	addAnimationByPrefix('static', 'static', 'menuSTATICNEW instance 1', 24, true);
	setProperty('static.antialiasing', true);
	setProperty('static.alpha', 0);
	addLuaSprite('static', false);
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', false);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	
	end
	if songName == 'extricate-hex' then
		makeLuaSprite('sky', 'bgs/curse/good/sky', -1050, -700);
		scaleObject('sky', 1.2, 1.2);
		setScrollFactor('sky', 0.6, 0.6);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false);		
		
		makeLuaSprite('sun', 'bgs/curse/good/sun_and_clouds', -540, -350);
		scaleObject('sun', 1, 1);
		setScrollFactor('sun', 0.2, 0.2);
		setProperty('sun.antialiasing', true);
		addLuaSprite('sun', false);		
		
		makeAnimatedLuaSprite('water', 'bgs/curse/good/Malediction_good_future_Water', -650, -350);
		scaleObject('water', 1.1, 1.1);
		setScrollFactor('water', 0.4, 0.4);
		addAnimationByPrefix('water', 'idle', 'Water', 7, true);
		setProperty('water.antialiasing', true);
		setProperty('water.alpha', 1);
		addLuaSprite('water', false);		
		
		makeLuaSprite('city', 'bgs/curse/good/city_and_trees', -650, -350);
		scaleObject('city', 1.1, 1.1);
		setScrollFactor('city', 0.4, 0.4);
		setProperty('city.antialiasing', true);
		addLuaSprite('city', false);		
		
		makeLuaSprite('bridge', 'bgs/curse/good/bridge', -740, -340);
		scaleObject('bridge', 1.12, 1.12);
		setScrollFactor('bridge', 1, 1);
		setProperty('bridge.antialiasing', true);
		addLuaSprite('bridge', false);		
		

	end
end

function onUpdate(elapsed)


    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	
	if songName == "malediction" then
		if curStep == 736 then
			doTweenAlpha('static','static',1,2,'linear')
		end
		
		if curStep == 760 then
			doTweenAlpha('static','static',0.5,2,'linear')
		end
		
		if curStep == 784 then
			doTweenAlpha('static','static',1,2,'linear')
		end
		
		if curStep == 808 then
			doTweenAlpha('static','static',0.5,2,'linear')
		end
		
		if curStep == 832 then
			doTweenAlpha('static','static',1,2,'linear')
		end
		
		if curStep == 856 then
			doTweenAlpha('static','static',0.5,2,'linear')
		end

		if curStep == 880 then
			doTweenAlpha('static','static',1,2,'linear')
		end
		
		if curStep == 904 then
			doTweenAlpha('static','static',0.5,2,'linear')
		end
		
		if curStep == 928 then
			doTweenAlpha('static','static',1,2,'linear')
		end
		
		if curStep == 952 then
			doTweenAlpha('static','static',0.5,2,'linear')
		end
		
		if curStep == 976 then
			doTweenAlpha('static','static',1,2,'linear')
		end
		
		if curStep == 992 then
			doTweenAlpha('static','static',0,1,'linear')
		end
	end
	if songName == "unblessful-hedgehog" then
		if curStep == 0 then
			doTweenAlpha('blk','blk',1,20,'linear')
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 256 then
			doTweenAlpha('blk','blk',0,0.1,'linear')
			setProperty('defaultCamZoom',0.65)
			doTweenAlpha('static','static',0.7,1,'linear')
		end
		if curStep == 384 then
			doTweenAlpha('static','static',1,1.5,'linear')
		end
		if curStep == 512 then
			doTweenAlpha('static','static',0.5,1.5,'linear')
		end
		if curStep == 768 then
			doTweenAlpha('static','static',1,1.5,'linear')
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 1023 then
			doTweenAlpha('static','static',0.7,1.5,'linear')
			setProperty('defaultCamZoom',0.65)
		end
		if curStep == 1279 then
			doTweenAlpha('static','static',0.2,1.5,'linear')
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 1407 then
			doTweenAlpha('static','static',1,1.5,'linear')
			setProperty('defaultCamZoom',0.65)
		end
		if curStep == 1535 then
			doTweenAlpha('static','static',0.5,1.5,'linear')
		end		
		if curStep == 1791 then
			doTweenAlpha('static','static',1,1.5,'linear')
		end		
		if curStep == 2048 then 
			doTweenAlpha('blk','blk',1,23,'linear')
		    doTweenAlpha('static','static',0,23,'linear')
			setProperty('defaultCamZoom',0.75)
		end
	end
end