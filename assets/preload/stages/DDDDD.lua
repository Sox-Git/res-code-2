local zoom = 0;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/tails-doll/bg', -700, -100);
		scaleObject('bg', 1.1, 1.1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
	end
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if zoom == 1 then
		doTweenZoom('ZOOMDAD', 'camGame',1.3, 1, 'quadOut')
	end
	if zoom == 2 then
		doTweenZoom('ZOOMDAD', 'camGame',0.7, 1, 'quadOut')
	end
	if zoom == 3 then
		doTweenZoom('ZOOMDAD', 'camGame',1.6, 1, 'quadOut')
	end
	
	if songName == "sunshine" then
		if curStep == 592 then
			triggerEvent('Play Animation', 'out', 'Dad')
			triggerEvent('Camera Follow Pos', '250', '400')
			zoom = 1;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bg','bg',0.5,1.2,'linear')
			end
			
			doTweenAlpha('iconP1T','iconP1',0,1.2,'linear')
			doTweenAlpha('iconP2T','iconP2',0,1.2,'linear')
			doTweenAlpha('healthBarT','healthBar',0,1.2,'linear')
			doTweenAlpha('healthBarBGT','healthBarBG',0,1.2,'linear')
			
			noteTweenAlpha('OpponentStrums0',0 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrums1',1 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrums2',2 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrums3',3 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums0',4 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,1.2, 'linear')
		end
		
		if curStep == 604 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',0)
			end
			triggerEvent('Camera Follow Pos')
			zoom = 3;
			
			setPropertyFromGroup('opponentStrums',0,'alpha',1)
			setPropertyFromGroup('opponentStrums',1,'alpha',1)
			setPropertyFromGroup('opponentStrums',2,'alpha',1)
			setPropertyFromGroup('opponentStrums',3,'alpha',1)
			
			setPropertyFromGroup('playerStrums',0,'alpha',1)
			setPropertyFromGroup('playerStrums',1,'alpha',1)
			setPropertyFromGroup('playerStrums',2,'alpha',1)
			setPropertyFromGroup('playerStrums',3,'alpha',1)
		end
		
		if curStep == 864 then
			doTweenAlpha('blk1','blk',1,1.2,'linear')
		
			noteTweenAlpha('OpponentStrumss0',0 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrumss1',1 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrumss2',2 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrumss3',3 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrumss0',4 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrumss1',5 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrumss2',6 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrumss3',7 ,0 ,1.2, 'linear')
		end
		
		if curStep == 882 then
			setProperty('boyfriendGroup.visible',true)
			setProperty('boyfriend.visible',true)
			setProperty('blk.alpha',0)
		
			doTweenAlpha('iconP1TT','iconP1',1,0.25,'linear')
			doTweenAlpha('iconP2TT','iconP2',1,0.25,'linear')
			doTweenAlpha('healthBarTT','healthBar',1,0.25,'linear')
			doTweenAlpha('healthBarBGTT','healthBarBG',1,0.25,'linear')
		
			noteTweenAlpha('OpponentStrumsss0',0 ,1 ,0.25, 'linear')
			noteTweenAlpha('OpponentStrumsss1',1 ,1 ,0.25, 'linear')
			noteTweenAlpha('OpponentStrumsss2',2 ,1 ,0.25, 'linear')
			noteTweenAlpha('OpponentStrumsss3',3 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss0',4 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss1',5 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss2',6 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss3',7 ,1 ,0.25, 'linear')
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',1)
			end
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
			zoom = 2;
		end
		if curStep == 1264 then
			doTweenAlpha('END1','scoreTxt',0,2,'linear')
			doTweenAlpha('END2','iconP1',0,2,'linear')
			doTweenAlpha('END3','iconP2',0,2,'linear')
			doTweenAlpha('END4','healthBar',0,2,'linear')
			doTweenAlpha('END5','healthBarBG',0,2,'linear')
			doTweenAlpha('END6','timeBar',0,2,'linear')
			doTweenAlpha('END7','timeBarBG',0,2,'linear')
			doTweenAlpha('END8','timeTxt',0,2,'linear')
			
			noteTweenAlpha('END9',0 ,0 ,2, 'linear')
			noteTweenAlpha('END10',1 ,0 ,2, 'linear')
			noteTweenAlpha('END11',2 ,0 ,2, 'linear')
			noteTweenAlpha('END12',3 ,0 ,2, 'linear')
			noteTweenAlpha('END13',4 ,0 ,2, 'linear')
			noteTweenAlpha('END14',5 ,0 ,2, 'linear')
			noteTweenAlpha('END15',6 ,0 ,2, 'linear')
			noteTweenAlpha('END16',7 ,0 ,2, 'linear')
		end
	end
	if songName == "drippyshine" then
		if curStep == 576 then
			triggerEvent('Play Animation', 'out', 'Dad')
			triggerEvent('Camera Follow Pos', '250', '400')
			zoom = 1;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bg','bg',0.5,1.2,'linear')
			end
			
			doTweenAlpha('iconP1T','iconP1',0,1.2,'linear')
			doTweenAlpha('iconP2T','iconP2',0,1.2,'linear')
			doTweenAlpha('healthBarT','healthBar',0,1.2,'linear')
			doTweenAlpha('healthBarBGT','healthBarBG',0,1.2,'linear')
			
			noteTweenAlpha('OpponentStrums0',0 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrums1',1 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrums2',2 ,0 ,1.2, 'linear')
			noteTweenAlpha('OpponentStrums3',3 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums0',4 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,1.2, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,1.2, 'linear')
		end
		
		if curStep == 588 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',0)
			end
			triggerEvent('Camera Follow Pos')
			zoom = 3;
			
			setPropertyFromGroup('opponentStrums',0,'alpha',1)
			setPropertyFromGroup('opponentStrums',1,'alpha',1)
			setPropertyFromGroup('opponentStrums',2,'alpha',1)
			setPropertyFromGroup('opponentStrums',3,'alpha',1)
			
			setPropertyFromGroup('playerStrums',0,'alpha',1)
			setPropertyFromGroup('playerStrums',1,'alpha',1)
			setPropertyFromGroup('playerStrums',2,'alpha',1)
			setPropertyFromGroup('playerStrums',3,'alpha',1)
		end
		
		if curStep == 848 then
			noteTweenAlpha('OpponentStrumss0',0 ,0 ,1, 'linear')
			noteTweenAlpha('OpponentStrumss1',1 ,0 ,1, 'linear')
			noteTweenAlpha('OpponentStrumss2',2 ,0 ,1, 'linear')
			noteTweenAlpha('OpponentStrumss3',3 ,0 ,1, 'linear')
			noteTweenAlpha('playerStrumss0',4 ,0 ,1, 'linear')
			noteTweenAlpha('playerStrumss1',5 ,0 ,1, 'linear')
			noteTweenAlpha('playerStrumss2',6 ,0 ,1, 'linear')
			noteTweenAlpha('playerStrumss3',7 ,0 ,1, 'linear')
		end
		
		if curStep == 860 then
			doTweenAlpha('iconP1TT','iconP1',1,0.25,'linear')
			doTweenAlpha('iconP2TT','iconP2',1,0.25,'linear')
			doTweenAlpha('healthBarTT','healthBar',1,0.25,'linear')
			doTweenAlpha('healthBarBGTT','healthBarBG',1,0.25,'linear')
		
			noteTweenAlpha('OpponentStrumsss0',0 ,1 ,0.25, 'linear')
			noteTweenAlpha('OpponentStrumsss1',1 ,1 ,0.25, 'linear')
			noteTweenAlpha('OpponentStrumsss2',2 ,1 ,0.25, 'linear')
			noteTweenAlpha('OpponentStrumsss3',3 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss0',4 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss1',5 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss2',6 ,1 ,0.25, 'linear')
			noteTweenAlpha('playerStrumsss3',7 ,1 ,0.25, 'linear')
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha',1)
			end
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
			zoom = 2;
		end
		if curStep == 1248 then
			doTweenAlpha('END1','scoreTxt',0,2,'linear')
			doTweenAlpha('END2','iconP1',0,2,'linear')
			doTweenAlpha('END3','iconP2',0,2,'linear')
			doTweenAlpha('END4','healthBar',0,2,'linear')
			doTweenAlpha('END5','healthBarBG',0,2,'linear')
			doTweenAlpha('END6','timeBar',0,2,'linear')
			doTweenAlpha('END7','timeBarBG',0,2,'linear')
			doTweenAlpha('END8','timeTxt',0,2,'linear')
			
			noteTweenAlpha('END9',0 ,0 ,2, 'linear')
			noteTweenAlpha('END10',1 ,0 ,2, 'linear')
			noteTweenAlpha('END11',2 ,0 ,2, 'linear')
			noteTweenAlpha('END12',3 ,0 ,2, 'linear')
			noteTweenAlpha('END13',4 ,0 ,2, 'linear')
			noteTweenAlpha('END14',5 ,0 ,2, 'linear')
			noteTweenAlpha('END15',6 ,0 ,2, 'linear')
			noteTweenAlpha('END16',7 ,0 ,2, 'linear')
		end
	end
end