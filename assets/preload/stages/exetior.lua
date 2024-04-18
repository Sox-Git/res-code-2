local xx = 1350;
local yy = 1000;
local ofs = 25;
local ofs2 = 25;
local xx2 = 1500;
local yy2 = 1000;
local followchars = true;
local ZoomBeat = false;
local ZoomBeatAfterCrash = false;
local Error = false;
local SimCrashedFlashes = false;

function onCreate()
	if getProperty('boyfriend.curCharacter') == 'bf' then
		addCharacterToList('bf-scared', 'boyfriend');
	end
	if getProperty('boyfriend.curCharacter') == 'bf_merphi' then
		addCharacterToList('bf_merphi_chaos', 'boyfriend');
	end

	--BRUH
	makeLuaSprite('nvm', '', 0, 0);
	makeGraphic('nvm',1920,1080,'FF0000')
	addLuaSprite('nvm', false);
	setLuaSpriteScrollFactor('nvm',0,0)
	setProperty('nvm.scale.x',2)
	setProperty('nvm.scale.y',2)
	setProperty('nvm.alpha',0)
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		--Phase 1
		makeLuaSprite('bg', 'bgs/exetior/p1/bg', -550, -400);
		scaleObject('bg', 1, 1);
		setScrollFactor('bg', 0.3, 0.5);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('aa', 'bgs/exetior/p1/k-four', -430, 0);
			scaleObject('aa', 1, 1);
			setScrollFactor('aa', 0.4, 0.85);
			setProperty('aa.antialiasing', true);
			addLuaSprite('aa', false);
			
			makeLuaSprite('bb', 'bgs/exetior/p1/k-three', -350, 0);
			scaleObject('bb', 1, 1);
			setScrollFactor('bb', 0.5, 0.9);
			setProperty('bb.antialiasing', true);
			addLuaSprite('bb', false);
		end
	end
	
	makeLuaSprite('screen', 'bgs/exetior/p1/screen', -155, 10);
	scaleObject('screen', 1, 1);
	setScrollFactor('screen', 0.8, 0.9);
	setProperty('screen.antialiasing', true);
	addLuaSprite('screen', false);
	
	makeLuaSprite('screenError', 'bgs/exetior/p1/error', -155, 10);
	scaleObject('screenError', 1, 1);
	setScrollFactor('screenError', 0.8, 0.9);
	setProperty('screenError.antialiasing', true);
	setProperty('screenError.alpha', 0);
	addLuaSprite('screenError', false);
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('dd', 'bgs/exetior/p1/k-one', -155, 10);
		scaleObject('dd', 1, 1);
		setScrollFactor('dd', 0.8, 0.9);
		setProperty('dd.antialiasing', true);
		addLuaSprite('dd', false);
		
		makeLuaSprite('floor', 'bgs/exetior/p1/floor', 0, 0);
		scaleObject('floor', 1, 1);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('KKL', 'bgs/exetior/p1/k-two', -200, 0);
			scaleObject('KKL', 1, 1);
			setScrollFactor('KKL', 0.7, 1);
			setProperty('KKL.antialiasing', true);
			addLuaSprite('KKL', true);
			
			makeLuaSprite('KKR', 'bgs/exetior/p1/k-two', -200, 0);
			scaleObject('KKR', 1, 1);
			setScrollFactor('KKR', 0.7, 1);
			setProperty('KKR.antialiasing', true);
			setProperty('KKR.flipX', true);
			addLuaSprite('KKR', true);
		end
		
		makeLuaSprite('WallL', 'bgs/exetior/p1/crystal-wall', -200, -50);
		scaleObject('WallL', 1, 1);
		setScrollFactor('WallL', 0.7, 1);
		setProperty('WallL.antialiasing', true);
		addLuaSprite('WallL', true);
		
		makeLuaSprite('WallR', 'bgs/exetior/p1/crystal-wall', -200, -50);
		scaleObject('WallR', 1, 1);
		setScrollFactor('WallR', 0.7, 1);
		setProperty('WallR.antialiasing', true);
		setProperty('WallR.flipX', true);
		addLuaSprite('WallR', true);
		
		
		--Phase 2
		makeLuaSprite('bgbg', 'bgs/exetior/p2/bg', -200, -700);
		scaleObject('bgbg', 1, 1);
		setScrollFactor('bgbg', 1, 1);
		setProperty('bgbg.antialiasing', true);
		setProperty('bgbg.alpha', 0);
		addLuaSprite('bgbg', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('second', 'bgs/exetior/p2/second', 600, 650);
			scaleObject('second', 0.7, 0.7);
			addAnimationByPrefix('second', 'bop', '2', 24, false);
			setScrollFactor('second', 0.65, 0.85);
			setProperty('second.antialiasing', true);
			setProperty('second.alpha',0)
			setProperty('second.color', getColorFromHex('3D3D3D'))
			addLuaSprite('second', false);
			
			makeAnimatedLuaSprite('first', 'bgs/exetior/p2/first', 1950, 1100);
			scaleObject('first', 0.7, 0.7);
			addAnimationByPrefix('first', 'bop', '1', 24, false);
			setScrollFactor('first', 0.85, 0.9);
			setProperty('first.antialiasing', true);
			setProperty('first.alpha',0)
			addLuaSprite('first', true);
			
			makeAnimatedLuaSprite('third', 'bgs/exetior/p2/third',  -300, 800);
			scaleObject('third', 0.7, 0.7);
			addAnimationByPrefix('third', 'bop', '3', 24, false);
			setScrollFactor('third', 0.85, 0.9);
			setProperty('third.antialiasing', true);
			setProperty('third.alpha',0)
			addLuaSprite('third', true);
		end
		
		makeLuaSprite('light', 'bgs/exetior/p2/light', -850, -800);
		scaleObject('light', 1, 1);
		setScrollFactor('light', 1, 1);
		setProperty('light.antialiasing', true);
		setProperty('light.alpha', 0);
		addLuaSprite('light', true);
	end
	
	
	--Simulation Crashed
	makeLuaSprite('blkCRSH', '', 0, 0);
	makeGraphic('blkCRSH',1920,1080,'000000')
	addLuaSprite('blkCRSH', true);
	setLuaSpriteScrollFactor('blkCRSH',0,0)
	setProperty('blkCRSH.scale.x',2)
	setProperty('blkCRSH.scale.y',2)
	setProperty('blkCRSH.alpha',0)
	
	makeLuaSprite('crashed', 'bgs/exetior/crashed', 0, 0);
	scaleObject('crashed', 1, 1);
	setScrollFactor('crashed', 0, 0);
	setProperty('crashed.antialiasing', true);
	setProperty('crashed.alpha', 0);
	setObjectCamera('crashed', 'camOther')
	addLuaSprite('crashed', true);
	
	makeAnimatedLuaSprite('Eyes', 'bgs/exetior/exetior-eyes', 370, 50);
	scaleObject('Eyes', 1.0, 1.0);
	setScrollFactor('Eyes', 0, 0);
	addAnimationByPrefix('Eyes', 'eyes', 'exetior-eyes', 24, true);
	objectPlayAnimation('Eyes', 'eyes', true)
	setProperty('Eyes.antialiasing', true);
	setProperty('Eyes.alpha', 0);
	setObjectCamera('Eyes', 'camOther')
	addLuaSprite('Eyes', true);
	
	makeAnimatedLuaSprite('LyricsOne', 'bgs/exetior/exetior-lyrics-1', 190, 450);
	scaleObject('LyricsOne', 1.0, 1.0);
	setScrollFactor('LyricsOne', 0, 0);
	luaSpriteAddAnimationByIndices('LyricsOne', 'a', 'exetior-lyrics-1', '0', 18)
	luaSpriteAddAnimationByIndices('LyricsOne', 'b', 'exetior-lyrics-1', '1', 18)
	luaSpriteAddAnimationByIndices('LyricsOne', 'c', 'exetior-lyrics-1', '2', 18)
	luaSpriteAddAnimationByIndices('LyricsOne', 'd', 'exetior-lyrics-1', '3,4,5,6', 18)
	luaSpriteAddAnimationByIndices('LyricsOne', 'e', 'exetior-lyrics-1', '7,8,9,10', 18)
	luaSpriteAddAnimationByIndices('LyricsOne', 'f', 'exetior-lyrics-1', '11,12,13,14', 18)
	luaSpriteAddAnimationByIndices('LyricsOne', 'g', 'exetior-lyrics-1', '15,16,17,18', 18)
	objectPlayAnimation('LyricsOne', 'a', false)
	setProperty('LyricsOne.antialiasing', true);
	setProperty('LyricsOne.alpha', 0);
	setObjectCamera('LyricsOne', 'camOther')
	addLuaSprite('LyricsOne', true);
	
	makeLuaSprite('LyrThing', '', 0, 1350);
	makeGraphic('LyrThing',1920,1080,'000000')
	addLuaSprite('LyrThing', true);
	setLuaSpriteScrollFactor('LyrThing',0,0)
	setProperty('LyrThing.scale.x',2)
	setProperty('LyrThing.scale.y',2)
	setProperty('LyrThing.alpha',0)
	setObjectCamera('LyrThing', 'camOther')
	
	makeAnimatedLuaSprite('LyricsTwo', 'bgs/exetior/exetior-lyrics-2', 180, 490);
	scaleObject('LyricsTwo', 0.8, 0.8);
	setScrollFactor('LyricsTwo', 0, 0);
	luaSpriteAddAnimationByIndices('LyricsTwo', 'a', 'exetior-lyrics-2', '0', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'b', 'exetior-lyrics-2', '1', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'c', 'exetior-lyrics-2', '2', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'd', 'exetior-lyrics-2', '3', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'e', 'exetior-lyrics-2', '4', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'f', 'exetior-lyrics-2', '5', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'g', 'exetior-lyrics-2', '6,7,8,9', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'h', 'exetior-lyrics-2', '10,11,12,13', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'i', 'exetior-lyrics-2', '14,15,16,17', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'j', 'exetior-lyrics-2', '18', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'k', 'exetior-lyrics-2', '19', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'l', 'exetior-lyrics-2', '20', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'm', 'exetior-lyrics-2', '21', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'n', 'exetior-lyrics-2', '22', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'o', 'exetior-lyrics-2', '23', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'p', 'exetior-lyrics-2', '24', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'q', 'exetior-lyrics-2', '25', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 'r', 'exetior-lyrics-2', '26', 18)
	luaSpriteAddAnimationByIndices('LyricsTwo', 's', 'exetior-lyrics-2', '27', 18)
	objectPlayAnimation('LyricsTwo', 'a', false)
	setProperty('LyricsTwo.antialiasing', true);
	setProperty('LyricsTwo.alpha', 0);
	setObjectCamera('LyricsTwo', 'camOther')
	addLuaSprite('LyricsTwo', true);
	
	
	--Other
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	
	makeLuaSprite('flashin', '', 0, 0);
	makeGraphic('flashin',1920,1080,'FFFFFF')
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.scale.x',2)
	setProperty('flashin.scale.y',2)
	setProperty('flashin.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('first', 'bop', false)
			objectPlayAnimation('second', 'bop', false)
			objectPlayAnimation('third', 'bop', false)
		end
	end
	if ZoomBeat == true then
		triggerEvent('Add Camera Zoom')
		triggerEvent('Add Camera Zoom')
	end
	if ZoomBeatAfterCrash == true then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if SimCrashedFlashes == true then
		if curBeat % 2 == 0 then
			cancelTween('CRSH');
			setProperty('crashed.alpha',1)
			doTweenAlpha('CRSH','crashed',0,0.7,'linear')
		end
	end
	if Error == true then
		if curBeat % 2 == 0 then
			setProperty('screenError.alpha',0)
		else
			setProperty('screenError.alpha',1)
		end
	end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "sharpy-showdown" then
		if curStep == 240 or curStep == 244 or curStep == 248 or curStep == 252 or curStep == 912 or curStep == 916 or curStep == 920 or curStep == 925 or curStep == 2032 or curStep == 2036 or curStep == 2040 or curStep == 2044 then
			setProperty('flashin.color', getColorFromHex('FF0000'))
			setProperty('flashin.alpha',0.6)
			doTweenAlpha('flashinSulonamFucksHisAssOMG','flashin',0,0.5,'linear')
		end
		if curStep == 388 or curStep == 896 or curStep == 928 or curStep == 1056 or curStep == 1184 or curStep == 1344 or curStep == 1920 or curStep == 2048 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshitf','flashingshit',0,1.0,'linear')
		end
		if curStep == 128 or curStep == 640 or curStep == 800 or curStep == 832 or curStep == 864 or curStep == 928 or curStep == 1792 or curStep == 2048 then
			ZoomBeat = true;
		end
		if curStep == 249 or curStep == 784 or curStep == 816 or curStep == 848 or curStep == 896 or curStep == 1184 or curStep == 1920 or curStep == 2192 then
			ZoomBeat = false;
		end
		if curStep == 256 or curStep == 1920 then
			ZoomBeatAfterCrash = true;
		end
		if curStep == 512 or curStep == 2048 then
			ZoomBeatAfterCrash = false;
		end
		if curStep == 512 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('opponentStrums0',0 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums1',1 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums2',2 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums3',3 ,0.25 ,0.6, 'linear')
			else
				noteTweenAlpha('opponentStrums0',0 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums1',1 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums2',2 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums3',3 ,0.5 ,0.6, 'linear')
			end
		
			noteTweenAlpha('playerStrums0',4 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0.5 ,0.6, 'linear')
			
			doTweenAlpha('timeBarBGG','timeBarBG',0,0.6,'linear')
			doTweenAlpha('timeBarr','timeBar',0,0.6,'linear')
			doTweenAlpha('timeTxtt','timeTxt',0,0.6,'linear')
			doTweenAlpha('score1','scoreTxt',0,0.6,'linear')
			doTweenAlpha('hpbg','healthBarBG',0,0.6,'linear')
			doTweenAlpha('hp','healthBar',0,0.6,'linear')
			doTweenAlpha('ip1','iconP1',0,0.6,'linear')
			doTweenAlpha('ip2','iconP2',0,0.6,'linear')
		
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshitaa','flashingshit',0,0.7,'linear')
			setProperty('nvm.alpha',1)
			setProperty('defaultCamZoom',0.70)
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			yy = 1200;
			yy2 = 1200;
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('aa.alpha',0)
					setProperty('bb.alpha',0)
				end
			end
			setProperty('screen.alpha',0)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('dd.alpha',0)
				setProperty('floor.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('KKL.alpha',0)
					setProperty('KKR.alpha',0)
				end
				setProperty('WallL.alpha',0)
				setProperty('WallR.alpha',0)
			end
		end
		if curStep == 640 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('1opponentStrums0',0 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums1',1 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums2',2 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums3',3 ,0.5 ,0.6, 'linear')
			else
				noteTweenAlpha('1opponentStrums0',0 ,1 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums1',1 ,1 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums2',2 ,1 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums3',3 ,1 ,0.6, 'linear')
			end
		
			noteTweenAlpha('1playerStrums0',4 ,1 ,0.6, 'linear')
			noteTweenAlpha('1playerStrums1',5 ,1 ,0.6, 'linear')
			noteTweenAlpha('1playerStrums2',6 ,1 ,0.6, 'linear')
			noteTweenAlpha('1playerStrums3',7 ,1 ,0.6, 'linear')
			
			doTweenAlpha('1timeBarBGG','timeBarBG',1,0.6,'linear')
			doTweenAlpha('1timeBarr','timeBar',1,0.6,'linear')
			doTweenAlpha('1timeTxtt','timeTxt',1,0.6,'linear')
			doTweenAlpha('1score1','scoreTxt',1,0.6,'linear')
			doTweenAlpha('1hpbg','healthBarBG',1,0.6,'linear')
			doTweenAlpha('1hp','healthBar',1,0.6,'linear')
			doTweenAlpha('1ip1','iconP1',1,0.6,'linear')
			doTweenAlpha('1ip2','iconP2',1,0.6,'linear')
		
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshitnah','flashingshit',0,0.7,'linear')
			setProperty('nvm.alpha',0)
			setProperty('defaultCamZoom',0.525)
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			yy = 1000;
			yy2 = 1000;
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('aa.alpha',1)
					setProperty('bb.alpha',1)
				end
			end
			setProperty('screen.alpha',1)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('dd.alpha',1)
				setProperty('floor.alpha',1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('KKL.alpha',1)
					setProperty('KKR.alpha',1)
				end
				setProperty('WallL.alpha',1)
				setProperty('WallR.alpha',1)
			end
		end
		if curStep == 896 then
			doTweenAlpha('camHUDT1','camHUD',0,1.3,'linear')
			doTweenAlpha('BL1','blk',1,1.3,'linear')
		end
		if curStep == 916 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 928 then
			doTweenAlpha('camHUDT2','camHUD',1,1,'linear')
			setProperty('blk.alpha',0)
			setProperty('defaultCamZoom',0.525)
		end
		if curStep == 1184 then
			Error = true;
		end
		if curStep == 1296 then
			doTweenAlpha('camHUDT3','camHUD',0,1.4,'linear')
			yy = 900;
			yy2 = 900;
		end
		if curStep == 1297 then
			xx = 1375;
			xx2 = 1375;
			yy = 800;
			yy2 = 800;
			ofs = 15;
			ofs2 = 15;
		end
		if curStep == 1298 then
			yy = 650;
			yy2 = 650;
			ofs = 10;
			ofs2 = 10;
		end
		if curStep == 1299 then
			yy = 550;
			yy2 = 550;
			ofs = 5;
			ofs2 = 5;
		end
		if curStep == 1300 then
			yy = 460;
			yy2 = 460;
			ofs = 0;
			ofs2 = 0;
		end
		if curStep == 1308 then
			doTweenAlpha('BL2','blkCRSH',1,0.15,'linear')
			doTweenAlpha('Eyes1','Eyes',1,0.15,'linear')
			doTweenAlpha('LyrO1','LyricsOne',1,0.15,'linear')
			objectPlayAnimation('LyricsOne', 'b', false)
		end
		if curStep == 1312 then
			SimCrashedFlashes = true;
			Error = false
			objectPlayAnimation('LyricsOne', 'c', false)
		end
		if curStep == 1323 then
			objectPlayAnimation('LyricsOne', 'd', false)
		end
		if curStep == 1327 then
			objectPlayAnimation('LyricsOne', 'e', false)
			if getProperty('boyfriend.curCharacter') == 'bf' then
				triggerEvent('Change Character','bf','bf-scared')
			end
			if getProperty('boyfriend.curCharacter') == 'bf_merphi' then
				triggerEvent('Change Character','bf','bf_merphi_chaos')
			end
		end
		if curStep == 1333 then
			objectPlayAnimation('LyricsOne', 'f', false)
		end
		if curStep == 1337 then
			objectPlayAnimation('LyricsOne', 'g', false)
		end
		if curStep == 1344 then
			doTweenAlpha('camHUDT4','camHUD',1,0.75,'linear')
			setProperty('defaultCamZoom',0.4)
			ZoomBeatAfterCrash = true;
			SimCrashedFlashes = false;
			setProperty('blkCRSH.alpha',0)
			setProperty('LyricsOne.alpha',0)
			setProperty('Eyes.alpha',0)
			setProperty('crashed.alpha',0)
			xx = 1350;
			yy = 1000;
			ofs = 25;
			ofs2 = 25;
			xx2 = 1500;
			yy2 = 1000;
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('aa.alpha',0)
					setProperty('bb.alpha',0)
				end
			end
			setProperty('screen.alpha',0)
			setProperty('screenError.alpha',0)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('dd.alpha',0)
				setProperty('floor.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('KKL.alpha',0)
					setProperty('KKR.alpha',0)
				end
				setProperty('WallL.alpha',0)
				setProperty('WallR.alpha',0)

				setProperty('bgbg.alpha',1)
				setProperty('light.alpha',1)
			end
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
				setProperty('second.alpha',1)
				setProperty('first.alpha',1)
				setProperty('third.alpha',1)
			end
		end
		if curStep == 1632 then
			ZoomBeatAfterCrash = false;
			doTweenAlpha('camHUDT5','camHUD',0,2,'linear')
			doTweenAlpha('BL2','blk',1,2,'linear')
		end
		if curStep == 1660 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('opponentStrums0',0 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums1',1 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums2',2 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums3',3 ,0.25 ,0.6, 'linear')
			else
				noteTweenAlpha('opponentStrums0',0 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums1',1 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums2',2 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('opponentStrums3',3 ,0.5 ,0.6, 'linear')
			end
		
			noteTweenAlpha('playerStrums0',4 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0.5 ,0.6, 'linear')
			
			doTweenAlpha('timeBarBGG','timeBarBG',0,0.6,'linear')
			doTweenAlpha('timeBarr','timeBar',0,0.6,'linear')
			doTweenAlpha('timeTxtt','timeTxt',0,0.6,'linear')
			doTweenAlpha('score1','scoreTxt',0,0.6,'linear')
			doTweenAlpha('hpbg','healthBarBG',0,0.6,'linear')
			doTweenAlpha('hp','healthBar',0,0.6,'linear')
			doTweenAlpha('ip1','iconP1',0,0.6,'linear')
			doTweenAlpha('ip2','iconP2',0,0.6,'linear')
		
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshitpp','flashingshit',0,0.7,'linear')
			setProperty('blk.alpha',0)
			setProperty('nvm.alpha',1)
			setProperty('defaultCamZoom',0.70)
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			yy = 1200;
			yy2 = 1200;
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bgbg.alpha',0)
				setProperty('light.alpha',0)
				if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('second.alpha',0)
					setProperty('first.alpha',0)
					setProperty('third.alpha',0)
				end
			end
			
			doTweenAlpha('LyricsTwo1','LyricsTwo',1,0.6,'quadInOut')
			setProperty('LyrThing.alpha',1)
			doTweenY('LyrThing1', 'LyrThing', "1030", 0.6, 'quadInOut');
		end
		if curStep == 1664 then
			objectPlayAnimation('LyricsTwo', 'b', false)
		end
		if curStep == 1670 then
			objectPlayAnimation('LyricsTwo', 'c', false)
		end
		if curStep == 1677 then
			objectPlayAnimation('LyricsTwo', 'd', false)
		end
		if curStep == 1680 then
			objectPlayAnimation('LyricsTwo', 'e', false)
		end
		if curStep == 1683 then
			objectPlayAnimation('LyricsTwo', 'f', false)
		end
		if curStep == 1695 then
			objectPlayAnimation('LyricsTwo', 'g', false)
		end
		if curStep == 1701 then
			objectPlayAnimation('LyricsTwo', 'h', false)
		end
		if curStep == 1705 then
			objectPlayAnimation('LyricsTwo', 'i', false)
		end
		if curStep == 1715 then
			objectPlayAnimation('LyricsTwo', 'j', false)
		end
		if curStep == 1717 then
			objectPlayAnimation('LyricsTwo', 'k', false)
		end
		if curStep == 1723 then
			objectPlayAnimation('LyricsTwo', 'l', false)
		end
		if curStep == 1737 then
			objectPlayAnimation('LyricsTwo', 'm', false)
		end
		if curStep == 1740 then
			objectPlayAnimation('LyricsTwo', 'n', false)
		end
		if curStep == 1743 then
			objectPlayAnimation('LyricsTwo', 'o', false)
		end
		if curStep == 1750 then
			objectPlayAnimation('LyricsTwo', 'p', false)
		end
		if curStep == 1756 then
			objectPlayAnimation('LyricsTwo', 'q', false)
		end
		if curStep == 1759 then
			objectPlayAnimation('LyricsTwo', 'r', false)
		end
		if curStep == 1763 then
			objectPlayAnimation('LyricsTwo', 's', false)
		end
		if curStep == 1776 then
			doTweenAlpha('camHUDT6','camHUD',1,0.25,'linear')
		end
		if curStep == 1792 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('1opponentStrums0',0 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums1',1 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums2',2 ,0.5 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums3',3 ,0.5 ,0.6, 'linear')
			else
				noteTweenAlpha('1opponentStrums0',0 ,1 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums1',1 ,1 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums2',2 ,1 ,0.6, 'linear')
				noteTweenAlpha('1opponentStrums3',3 ,1 ,0.6, 'linear')
			end
		
			noteTweenAlpha('1playerStrums0',4 ,1 ,0.6, 'linear')
			noteTweenAlpha('1playerStrums1',5 ,1 ,0.6, 'linear')
			noteTweenAlpha('1playerStrums2',6 ,1 ,0.6, 'linear')
			noteTweenAlpha('1playerStrums3',7 ,1 ,0.6, 'linear')
			
			doTweenAlpha('1timeBarBGG','timeBarBG',1,0.6,'linear')
			doTweenAlpha('1timeBarr','timeBar',1,0.6,'linear')
			doTweenAlpha('1timeTxtt','timeTxt',1,0.6,'linear')
			doTweenAlpha('1score1','scoreTxt',1,0.6,'linear')
			doTweenAlpha('1hpbg','healthBarBG',1,0.6,'linear')
			doTweenAlpha('1hp','healthBar',1,0.6,'linear')
			doTweenAlpha('1ip1','iconP1',1,0.6,'linear')
			doTweenAlpha('1ip2','iconP2',1,0.6,'linear')
		
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshitdff','flashingshit',0,0.7,'linear')
			setProperty('nvm.alpha',0)
			setProperty('defaultCamZoom',0.4)
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			yy = 1000;
			yy2 = 1000;
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bgbg.alpha',1)
				setProperty('light.alpha',1)
				if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('second.alpha',1)
					setProperty('first.alpha',1)
					setProperty('third.alpha',1)
				end
			end
		end
		if curStep == 1772 then
			doTweenAlpha('LyricsTwo2','LyricsTwo',0,0.6,'quadInOut')
			doTweenY('LyrThing2', 'LyrThing', "1350", 0.6, 'quadInOut');
		end
		if curStep == 1805 then
			doTweenAlpha('LyrThingA','LyrThing',0,0.6,'quadInOut')
		end
		if curStep == 2192 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('lashFlash','flashingshit',0,1.0,'linear')
			doTweenAlpha('camHUDT7','camHUD',0,1.35,'linear')
			doTweenAlpha('BL3','blk',1,2.7,'linear')
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