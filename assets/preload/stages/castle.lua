local dadx = 370;
local dady = 425;
local gfx = 370;
local gfy = 425;
local bfx = 370;
local bfy = 425;
local vineboom = true;
local visibleBF = false;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/castle/bg', -600, -100);
		scaleObject('bg', 0.8, 0.8);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);

		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('pillar1', 'bgs/castle/pillar1', -350, -290);
			scaleObject('pillar1', 0.8, 0.8);
			addAnimationByPrefix('pillar1', 'idle', 'pillar1 idle', 10, true);
			setScrollFactor('pillar1', 0, 0);
			setProperty('pillar1.antialiasing', false);
			setProperty('pillar1.alpha',1)
			addLuaSprite('pillar1', false);
		
			makeLuaSprite('pillar2', 'bgs/castle/pillar2', -620, -230);
			scaleObject('pillar2', 0.8, 0.8);
			setScrollFactor('pillar2', 1, 1);
			setProperty('pillar2.antialiasing', true);
			addLuaSprite('pillar2', false);
			
			makeLuaSprite('pillar3', 'bgs/castle/pillar3', -620, -230);
			scaleObject('pillar3', 0.8, 0.8);
			setScrollFactor('pillar3', 1, 1);
			setProperty('pillar3.antialiasing', true);
			addLuaSprite('pillar3', false);
			
			makeAnimatedLuaSprite('pillar4', 'bgs/castle/pillar4', -350, -290);
			scaleObject('pillar4', 0.8, 0.8);
			addAnimationByPrefix('pillar4', 'idle', 'pillar4 idle', 9, true);
			setScrollFactor('pillar4', 0, 0);
			setProperty('pillar4.antialiasing', false);
			setProperty('pillar4.alpha',1)
			addLuaSprite('pillar4', false);
			
			makeLuaSprite('blk', '', 0, 0);
			makeGraphic('blk',1920,1080,'000000')
			addLuaSprite('blk', false);
			setLuaSpriteScrollFactor('blk',0,0)
			setProperty('blk.scale.x',2)
			setProperty('blk.scale.y',2)
			setProperty('blk.alpha',1)
			
			makeLuaSprite('epic-bg', 'bgs/castle/epic-bg', -380, -250);
			scaleObject('epic-bg', 1.1, 1.1);
			setScrollFactor('epic-bg', 1, 1);
			setProperty('epic-bg.alpha',0)
			setProperty('epic-bg.antialiasing', true);
			addLuaSprite('epic-bg', false);
			
			makeLuaSprite('ring', 'bgs/castle/ring', -380, -250);
			scaleObject('ring', 1.1, 1.1);
			setScrollFactor('ring', 1, 1);
			setProperty('ring.alpha',0)
			setProperty('ring.antialiasing', true);
			addLuaSprite('ring', false);
			
			makeAnimatedLuaSprite('spilar', 'bgs/castle/spilar', -360, -240);
			scaleObject('spilar', 0.9, 0.9);
			addAnimationByPrefix('spilar', 'idle', 'spilar idle', 24, true);
			setProperty('spilar.antialiasing', true);
			setProperty('spilar.alpha',0)
			addLuaSprite('spilar', false)
			
			makeLuaSprite('place1', 'bgs/castle/place1', -670, -300);
			scaleObject('place1', 1.3, 1.3);
			setScrollFactor('place1', 1, 1);
			setProperty('place1.alpha',0)
			setProperty('place1.antialiasing', true);
			addLuaSprite('place1', false);
			
			makeLuaSprite('place2', 'bgs/castle/place2', -620, -230);
			scaleObject('place2', 1.2, 1.2);
			setScrollFactor('place2', 1, 1);
			setProperty('place2.alpha',0)
			setProperty('place2.antialiasing', true);
			addLuaSprite('place2', false);
		end

		makeAnimatedLuaSprite('staticс', 'bgs/omw/staticOMW', -500, -500);
		scaleObject('staticс', 6, 6);
		addAnimationByPrefix('staticс', 'stat', 'stat', 24, true);
		setScrollFactor('staticс', 0, 0);
		setProperty('staticс.antialiasing', false);
		setProperty('staticс.alpha',0)
		addLuaSprite('staticс', false);
		
		makeLuaSprite('throne', 'bgs/castle/throne', -620, -230);
		scaleObject('throne', 0.8, 0.8);
		setScrollFactor('throne', 1, 1);
		setProperty('throne.antialiasing', true);
		addLuaSprite('throne', false);

		makeAnimatedLuaSprite('static', 'Static', -500, -500);
		scaleObject('static', 6, 6);
		addAnimationByPrefix('static', 'Static', 'Static', 24, true);
		setScrollFactor('static', 0, 0);
		setProperty('static.antialiasing', false);
		setProperty('static.alpha',0)
		addLuaSprite('static', true);
	end

	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	setProperty('black.alpha',1)
	
	makeLuaSprite('eyes', 'bgs/castle/eyes', -40, 0);
	scaleObject('eyes', 0.7, 0.7);
	setScrollFactor('eyes', 1, 1);
	setProperty('eyes.antialiasing', true);
	setObjectCamera('eyes', 'camHUD')
	setProperty('eyes.alpha',0)
	addLuaSprite('eyes', true);
	
	setProperty('camHUD.alpha',0)
end

function onTimerCompleted(tag)
	if tag == 'X UP' then
		doTweenY('place1-TweenUp', 'place1', -330, 2.5, 'sineInOut')
		doTweenY('dadGroup-TweenUp', 'dadGroup', 140, 2.5, 'sineInOut')
		runTimer('X DOWN', 2.5, 1)
	end
	if tag == 'X DOWN' then
		doTweenY('place1-TweenDown', 'place1', -280, 2.5, 'sineInOut')
		doTweenY('dadGroup-TweenDown', 'dadGroup', 190, 2.5, 'sineInOut')
		runTimer('X UP', 2.5, 1)
	end
	if tag == 'BF UP' then
		doTweenY('place2-TweenUp', 'place2', -260, 2, 'sineInOut')
		doTweenY('boyfriendGroup-TweenUp', 'boyfriendGroup', 170, 2, 'sineInOut')
		runTimer('BF DOWN', 2, 1)
	end
	if tag == 'BF DOWN' then
		doTweenY('place2-TweenDown', 'place2', -210, 2, 'sineInOut')
		doTweenY('boyfriendGroup-TweenUp', 'boyfriendGroup', 220, 2, 'sineInOut')
		runTimer('BF UP', 2, 1)
	end
end

function onUpdate(elapsed)
	songPos = getPropertyFromClass('Conductor', 'songPosition');
	currentBeat = (songPos / 300) * (bpm / 180)
	if visibleBF == false then
		setProperty('boyfriend.alpha',0)
	else
		setProperty('boyfriend.alpha',1)
	end
	
	if songName == "hellbent" then
		if curStep == 1 then
			doTweenAlpha('black', 'black', 0.5, 12, 'linear') 
			setProperty('throne.color', getColorFromHex('000000'))
		end
		if curStep == 5 then
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			
			setPropertyFromGroup('opponentStrums',0,'alpha',0)
			setPropertyFromGroup('opponentStrums',1,'alpha',0)
			setPropertyFromGroup('opponentStrums',2,'alpha',0)
			setPropertyFromGroup('opponentStrums',3,'alpha',0)
			
			setPropertyFromGroup('playerStrums',4,'alpha',0)
			setPropertyFromGroup('playerStrums',5,'alpha',0)
			setPropertyFromGroup('playerStrums',6,'alpha',0)
			setPropertyFromGroup('playerStrums',7,'alpha',0)
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("NoteMove4", 4, 2000, 0.005, 'linear')
				noteTweenX("NoteMove5", 5, 2000, 0.005, 'linear')
				noteTweenX("NoteMove6", 6, -2000, 0.005, 'linear')
				noteTweenX("NoteMove7", 7, -2000, 0.005, 'linear')
			else
				noteTweenX("NoteMove0", 0, 2000, 0.005, 'linear')
				noteTweenX("NoteMove1", 1, 2000, 0.005, 'linear')
				noteTweenX("NoteMove2", 2, -2000, 0.005, 'linear')
				noteTweenX("NoteMove3", 3, -2000, 0.005, 'linear')
			
				noteTweenX("NoteMove4", 4, 2000, 0.005, 'linear')
				noteTweenX("NoteMove5", 5, 2000, 0.005, 'linear')
				noteTweenX("NoteMove6", 6, -2000, 0.005, 'linear')
				noteTweenX("NoteMove7", 7, -2000, 0.005, 'linear')
			end
		end
		
		if curStep == 7 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("note4", 4, 370, 0.25, cubeInOut)
				noteTweenX("note5", 5, 510, 0.25, cubeInOut)
				noteTweenX("note6", 6, 650, 0.25, cubeInOut)
				noteTweenX("note7", 7, 790, 0.25, cubeInOut)
				
				noteTweenAlpha('playerStrumss0',4 ,0 ,0.005, 'linear')
				noteTweenAlpha('playerStrumss1',5 ,0 ,0.005, 'linear')
				noteTweenAlpha('playerStrumss2',6 ,0 ,0.005, 'linear')
				noteTweenAlpha('playerStrumss3',7 ,0 ,0.005, 'linear')
			else
				noteTweenX("note0", 0, 93, 0.05, quadInOut)
				noteTweenX("note1", 1, 205, 0.05, quadInOut)
				noteTweenX("note2", 2, 957, 0.05, quadInOut)
				noteTweenX("note3", 3, 1069, 0.05, quadInOut)
				
				noteTweenAlpha('opponentStrumss0',4 ,0 ,0.005, 'linear')
				noteTweenAlpha('opponentStrumss1',5 ,0 ,0.005, 'linear')
				noteTweenAlpha('opponentStrumss2',6 ,0 ,0.005, 'linear')
				noteTweenAlpha('opponentStrumss3',7 ,0 ,0.005, 'linear')
				
				noteTweenX("note4", 4, 412, 0.25, cubeInOut)
				noteTweenX("note5", 5, 524, 0.25, cubeInOut)
				noteTweenX("note6", 6, 638, 0.25, cubeInOut)
				noteTweenX("note7", 7, 750, 0.25, cubeInOut)
				
				noteTweenAlpha('playerStrumss0',4 ,0 ,0.005, 'linear')
				noteTweenAlpha('playerStrumss1',5 ,0 ,0.005, 'linear')
				noteTweenAlpha('playerStrumss2',6 ,0 ,0.005, 'linear')
				noteTweenAlpha('playerStrumss3',7 ,0 ,0.005, 'linear')
			end
		end
		
		if curStep == 9 then
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
		end
		
		if curStep == 40 then
			setProperty('camHUD.alpha',1)
		end
		
		if curStep == 116 then
			noteTweenAlpha('playerrStrums0',4 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums1',5 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums2',6 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums3',7 ,0.4 ,1, 'linear')
		end
		
		if curStep == 256 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('oppooonentStrums0',0 ,0.2 ,1, 'linear')
				noteTweenAlpha('oppooonentStrums1',1 ,0.2 ,1, 'linear')
				noteTweenAlpha('oppooonentStrums2',2 ,0.2 ,1, 'linear')
				noteTweenAlpha('oppooonentStrums3',3 ,0.2 ,1, 'linear')
			end
		
			noteTweenAlpha('playerrStrums0',4 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums1',5 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums2',6 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums3',7 ,0.4 ,1, 'linear')
		end
		
		if curStep == 514 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('opponentSStrums0',0 ,0 ,0.5, 'linear')
				noteTweenAlpha('opponentSStrums1',1 ,0 ,0.5, 'linear')
				noteTweenAlpha('opponentSStrums2',2 ,0 ,0.5, 'linear')
				noteTweenAlpha('opponentSStrums3',3 ,0 ,0.5, 'linear')
			end
		
			noteTweenAlpha('playerSStrums0',4 ,0 ,0.5, 'linear')
			noteTweenAlpha('playerSStrums1',5 ,0 ,0.5, 'linear')
			noteTweenAlpha('playerSStrums2',6 ,0 ,0.5, 'linear')
			noteTweenAlpha('playerSStrums3',7 ,0 ,0.5, 'linear')
		end
		
		if curStep == 518 then
			doTweenAlpha('black', 'black', 1, 0.2, 'linear')
			doTweenAlpha('eyes', 'eyes', 1, 0.5, 'linear')
		end
		
		if curStep == 543 then
			setProperty('black.alpha',0)
			setProperty('blk.alpha',0)
			doTweenAlpha('eyes', 'eyes', 0, 0.7, 'linear')
			setProperty('throne.color', getColorFromHex('FFFFFF'))
		end
		
		if curStep == 544 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('oopponentStrums0',0 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('oopponentStrums1',1 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('oopponentStrums2',2 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('oopponentStrums3',3 ,0.25 ,0.6, 'linear')
			end
		
			noteTweenAlpha('pplayerStrums0',4 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayerStrums1',5 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayerStrums2',6 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayerStrums3',7 ,0.5 ,0.6, 'linear')
			
			doTweenAlpha('timeBarBGG','timeBarBG',1,0.6,'linear')
			doTweenAlpha('timeBarr','timeBar',1,0.6,'linear')
			doTweenAlpha('timeTxtt','timeTxt',1,0.6,'linear')
			doTweenAlpha('score1','scoreTxt',0.5,0.6,'linear')
			doTweenAlpha('hpbg','healthBarBG',1,0.6,'linear')
			doTweenAlpha('hp','healthBar',1,0.6,'linear')
			doTweenAlpha('ip1','iconP1',1,0.6,'linear')
			doTweenAlpha('ip2','iconP2',1,0.6,'linear')
		end
		
		if curStep == 927 then
			setProperty('black.alpha',1)
		end
		
		if curStep == 928 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('staticс.alpha',1)
			end
			setProperty('black.alpha',0.3)
		end
		
		if curStep == 1056 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('oopponentSttrums0',0 ,0 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrums1',1 ,0 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrums2',2 ,0 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrums3',3 ,0 ,0.6, 'linear')
			end
		
			noteTweenAlpha('pplayerSttrums0',4 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayerSttrums1',5 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayerSttrums2',6 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayerSttrums3',7 ,0 ,0.6, 'linear')
				
			doTweenAlpha('timeBarBGGG','timeBarBG',0,0.6,'linear')
			doTweenAlpha('timeBarrr','timeBar',0,0.6,'linear')
			doTweenAlpha('timeTxttt','timeTxt',0,0.6,'linear')
			doTweenAlpha('sscore1','scoreTxt',0,0.6,'linear')
			doTweenAlpha('hhpbg','healthBarBG',0,0.6,'linear')
			doTweenAlpha('hhp','healthBar',0,0.6,'linear')
			doTweenAlpha('iip1','iconP1',0,0.6,'linear')
			doTweenAlpha('iip2','iconP2',0,0.6,'linear')
		end
		
		if curStep == 1056 or curStep == 1072 or curStep == 1088 or curStep == 1103 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('statttic','static',1,0.3,'linear')
			end
		end
		
		if curStep == 1064 or curStep == 1080 or curStep == 1096 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('stattic','static',0,0.3,'linear')
				runTimer('X UP', 0.01, 1)
				runTimer('BF UP', 0.01, 1)
			end
		end
		
		if curStep == 1111 then
			visibleBF = true;
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('place1.alpha',1)
				setProperty('place2.alpha',1)
				setProperty('epic-bg.alpha',1)
				setProperty('ring.alpha',1)
				setProperty('spilar.alpha',0.7)
				setProperty('pillar1.alpha',0)
				setProperty('pillar2.alpha',0)
				setProperty('pillar3.alpha',0)
				setProperty('pillar4.alpha',0)
				setProperty('throne.alpha',0)
				setProperty('bg.alpha',0)
			end
			
			dadx = 730;
			dady = 550;
			bfx = 730;
			bfy = 550;
			doTweenAlpha('black', 'black', 0, 0.5, 'linear')
			setProperty('defaultCamZoom',0.6)
			setProperty('dad.angle',10)
			setProperty('dad.x',200)
			setProperty('boyfriend.angle',-20)
			setProperty('boyfriend.x',700)
		end
		
		if curStep == 1114 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('oopponentSttrrums0',0 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrrums1',1 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrrums2',2 ,0.25 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrrums3',3 ,0.25 ,0.6, 'linear')
			end
		
			noteTweenAlpha('pplayerStrrums0',4 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayerStrrums1',5 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayerStrrums2',6 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayerStrrums3',7 ,0.5 ,0.6, 'linear')
			
			doTweenAlpha('ttimeBarBGGG','timeBarBG',1,0.6,'linear')
			doTweenAlpha('ttimeBarrr','timeBar',1,0.6,'linear')
			doTweenAlpha('ttimeTxttt','timeTxt',1,0.6,'linear')
			doTweenAlpha('scoore1','scoreTxt',0.5,0.6,'linear')
			doTweenAlpha('hppbg','healthBarBG',1,0.6,'linear')
			doTweenAlpha('hpp','healthBar',1,0.6,'linear')
			doTweenAlpha('ipp1','iconP1',1,0.6,'linear')
			doTweenAlpha('ipp2','iconP2',1,0.6,'linear')
		end
		
		if curStep == 1119 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('staticT','static',0,1,'linear')
				doTweenAlpha('staticcT','staticс',0,1,'linear')
			end
		end
		
		if curStep == 1632 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
				noteTweenAlpha('oopponentSttrrumms0',0 ,0 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrrumms1',1 ,0 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrrumms2',2 ,0 ,0.6, 'linear')
				noteTweenAlpha('oopponentSttrrumms3',3 ,0 ,0.6, 'linear')
			end
		
			noteTweenAlpha('pplayerSttrumms0',4 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayerSttrumms1',5 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayerSttrumms2',6 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayerSttrumms3',7 ,0 ,0.6, 'linear')
			
			doTweenAlpha('ttimeBBarBGGG','timeBarBG',0,0.6,'linear')
			doTweenAlpha('ttimeBBarrr','timeBar',0,0.6,'linear')
			doTweenAlpha('ttimeTTxttt','timeTxt',0,0.6,'linear')
			doTweenAlpha('sscoree1','scoreTxt',0,0.6,'linear')
			doTweenAlpha('hhpbgg','healthBarBG',0,0.6,'linear')
			doTweenAlpha('hhpp','healthBar',0,0.6,'linear')
			doTweenAlpha('iip11','iconP1',0,0.6,'linear')
			doTweenAlpha('iip22','iconP2',0,0.6,'linear')
		end
		
		if curStep == 1721 then
			noteTweenAlpha('pplayyerStrrums0',4 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayyerStrrums1',5 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayyerStrrums2',6 ,0.5 ,0.6, 'linear')
			noteTweenAlpha('pplayyerStrrums3',7 ,0.5 ,0.6, 'linear')
		end
		
		if curStep == 1886 then
			noteTweenAlpha('pplayeerSttrumms0',4 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayeerSttrumms1',5 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayeerSttrumms2',6 ,0 ,0.6, 'linear')
			noteTweenAlpha('pplayeerSttrumms3',7 ,0 ,0.6, 'linear')
		end
	end

	if vineboom == true then
        if mustHitSection == false then
			if gfSection == false then
				if getProperty('dad.animation.curAnim.name') == 'singLEFT'  or getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',dadx,dady)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT'  or getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',gfx,gfy)
				end	
			end
        else
			if gfSection == false then
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT'  or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss'  or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' or getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' or getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',bfx,bfy)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT'  or getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',gfx,gfy)
				end	
			end
        end
	end
end

function onSongStart()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		noteTweenX("NoteMove5", 0, -1000, 0.005, cubeInOut)
		noteTweenX("NoteMove6", 1, -1000, 0.005, cubeInOut)
		noteTweenX("NoteMove7", 2, -1000, 0.005, cubeInOut)
		noteTweenX("NoteMove8", 3, -1000, 0.005, cubeInOut)
	end
end

function opponentNoteHit()
    health = getProperty('health')
    if getProperty('health') > 0.5 then
        setProperty('health', health- 0.020);
    end
	
	cameraShake('game', 0.005, 0.05)
end