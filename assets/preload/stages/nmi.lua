function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/nmi/bg', -1550, -800);
		scaleObject('bg', 1, 1);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		setProperty('bg.alpha', 1);
		addLuaSprite('bg', false);
	end

	makeAnimatedLuaSprite('NMITV', 'bgs/nmi/nmi-tv', -850, -130);
	addAnimationByPrefix('NMITV', 'idle', 'tv-nmi0', 24, true);
	addAnimationByPrefix('NMITV', 'flash', 'tv-nmi-flash0', 24, false);
	setProperty('NMITV.antialiasing', true);
	addLuaSprite('NMITV', false);
	objectPlayAnimation('NMITV', 'idle', true)

	makeLuaSprite('overlay', '', 0, 0);
	makeGraphic('overlay',1920,1080,'000000')
	setScrollFactor('overlay', 0, 0);
	setProperty('overlay.scale.x',2)
	setProperty('overlay.scale.y',2)
	setProperty('overlay.alpha',0.70)
	addLuaSprite('overlay', true);

	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('MoonLight', 'bgs/nmi/moon-light', -1550, -800);
		setScrollFactor('MoonLight', 1, 1);
		setProperty('MoonLight.antialiasing', true);
		setProperty('MoonLight.alpha', 0.6);
		addLuaSprite('MoonLight', true);
		
		makeLuaSprite('TVLight', 'bgs/nmi/tv-light', -1550, -800);
		setScrollFactor('TVLight', 1, 1);
		setProperty('TVLight.antialiasing', true);
		setProperty('TVLight.alpha', 0);
		addLuaSprite('TVLight', true);
	end
	
	makeLuaSprite('VG', 'bgs/nmi/vg', -1550, -800);
	setScrollFactor('VG', 1, 1);
	setProperty('VG.antialiasing', true);
	setProperty('VG.alpha', 1);
	addLuaSprite('VG', true);
	
	makeAnimatedLuaSprite('static', 'bgs/omw/staticOMW', -500, -500);
	scaleObject('static', 6, 6);
	addAnimationByPrefix('static', 'sshh', 'stat', 24, true);
	setScrollFactor('static', 0, 0);
	setProperty('static.antialiasing', false);
	setProperty('static.alpha',0)
	addLuaSprite('static', true);
	
	makeLuaSprite('no', 'bgs/nmi/no', -250, -175);
	scaleObject('no', 1.50, 1.50);
	setScrollFactor('no', 0, 0);
	setProperty('no.antialiasing', true);
	setProperty('no.alpha',0)
	addLuaSprite('no', true);
	
	makeLuaSprite('more', 'bgs/nmi/more', -250, -175);
	scaleObject('more', 1.50, 1.50);
	setScrollFactor('more', 0, 0);
	setProperty('more.antialiasing', true);
	setProperty('more.alpha',0)
	addLuaSprite('more', true);
	
	makeLuaSprite('innocence', 'bgs/nmi/innocence', -250, -175);
	scaleObject('innocence', 1.50, 1.50);
	setScrollFactor('innocence', 0, 0);
	setProperty('innocence.antialiasing', true);
	setProperty('innocence.alpha',0)
	addLuaSprite('innocence', true);
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onTimerCompleted(tag)
	if tag == 'NMI-TV-Idle' then
		objectPlayAnimation('NMITV', 'idle', true)
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "fake-baby" then
		if curStep == 0 then
			setProperty('dad.alpha',0)
			setProperty('camHUD.alpha', 0)
		end
		
		if curStep == 10 then
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
		
			noteTweenAlpha('opponentStrumss0',0 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrumss1',1 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrumss2',2 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrumss3',3 ,0 ,0.05, 'linear')
		
			noteTweenAlpha('playerStrumss0',4 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrumss1',5 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrumss2',6 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrumss3',7 ,0 ,0.05, 'linear')
		end
		
		if curStep == 15 then
			setProperty('camHUD.alpha', 1)
		end
		
		if curStep == 19 or curStep == 54 or curStep == 92 or curStep == 130 or curStep == 168 or curStep == 206 or curStep == 244 or curStep == 282 or curStep == 320 then
			objectPlayAnimation('NMITV', 'flash', false)
			runTimer('NMI-TV-Idle', 0.6, 1)
			triggerEvent('Screen Shake','0.2,0.005','0.2,0.005')
		end
		
		if curStep == 257 then
			triggerEvent('Screen Shake','0.8,0.005','0.8,0.005')
		end
		
		if curStep == 272 then
			doTweenAlpha('StaticTween','static',1,3.5,'quadInOut')
		end
		
		if curStep == 284 then
			triggerEvent('Screen Shake','1.4,0.005','1.4,0.005')
		end
		
		if curStep == 314 then
			triggerEvent('Screen Shake','1,0.005','1,0.005')
		end
		
		if curStep == 330 then
			setProperty('flashingshit.alpha','0.25')
			doTweenAlpha('flashingshit1','flashingshit',0,0.30,'linear')
			setProperty('no.alpha',1)
			triggerEvent('Screen Shake','0.2,0.010','0.2,0.010')
		end
		
		if curStep == 334 then
			setProperty('flashingshit.alpha','0.25')
			doTweenAlpha('flashingshit2','flashingshit',0,0.30,'linear')
			setProperty('more.alpha',1)
			triggerEvent('Screen Shake','0.4,0.010','0.4,0.010')
		end
		
		if curStep == 338 then
			setProperty('flashingshit.alpha','0.25')
			doTweenAlpha('flashingshit3','flashingshit', 0, 0.30,'linear')
			setProperty('innocence.alpha',1)
			triggerEvent('Screen Shake','0.8,0.010','0.8,0.010')
		end
		
		if curStep == 352 then
			doTweenAlpha('flashingshit4','flashingshit',1,2.9,'linear')
		end
		
		if curStep == 384 then
			doTweenAlpha('flashingshit5','flashingshit',0,0.50,'linear')
			
			setProperty('dad.alpha',1)
			setProperty('NMITV.alpha',1)
			setProperty('TVLight.alpha',0.5)
			
			setProperty('static.alpha',0.04)
			setProperty('iconP2.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
			
			doTweenAlpha('timeBarBGT','timeBarBG',1,1,'linear')
			doTweenAlpha('timeBarT','timeBar',1,1,'linear')
			doTweenAlpha('timeTxtT','timeTxt',1,1,'linear')
			doTweenAlpha('timeBarBGBGT','timeBarBGBG',1,1,'linear')
			
			setProperty('no.alpha', 0)
			setProperty('more.alpha', 0)
			setProperty('innocence.alpha', 0)
			
			setPropertyFromGroup('opponentStrums',0,'alpha',1)
			setPropertyFromGroup('opponentStrums',1,'alpha',1)
			setPropertyFromGroup('opponentStrums',2,'alpha',1)
			setPropertyFromGroup('opponentStrums',3,'alpha',1)
			
			setPropertyFromGroup('playerStrums',0,'alpha',1)
			setPropertyFromGroup('playerStrums',1,'alpha',1)
			setPropertyFromGroup('playerStrums',2,'alpha',1)
			setPropertyFromGroup('playerStrums',3,'alpha',1)
		end
		
		if curStep == 894 then
			noteTweenAlpha('opponentStrums0',0 ,0 ,1.5, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,0 ,1.5, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,0 ,1.5, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,0 ,1.5, 'linear')
			
			noteTweenAlpha('playerStrums0',4 ,0 ,1.5, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,1.5, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,1.5, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,1.5, 'linear')
			
			doTweenAlpha('score1','scoreTxt',0,1.5,'linear')
			doTweenAlpha('hpbg','healthBarBG',0,1.5,'linear')
			doTweenAlpha('hp','healthBar',0,1.5,'linear')
			doTweenAlpha('ip1','iconP1',0,1.5,'linear')
			doTweenAlpha('ip2','iconP2',0,1.5,'linear')
		end
		
		if curStep == 1144 then
			noteTweenAlpha('opponentStrumsAgain0',0 ,1 ,0.75, 'linear')
			noteTweenAlpha('opponentStrumsAgain1',1 ,1 ,0.75, 'linear')
			noteTweenAlpha('opponentStrumsAgain2',2 ,1 ,0.75, 'linear')
			noteTweenAlpha('opponentStrumsAgain3',3 ,1 ,0.75, 'linear')
			
			noteTweenAlpha('playerStrumsAgain0',4 ,1 ,0.75, 'linear')
			noteTweenAlpha('playerStrumsAgain1',5 ,1 ,0.75, 'linear')
			noteTweenAlpha('playerStrumsAgain2',6 ,1 ,0.75, 'linear')
			noteTweenAlpha('playerStrumsAgain3',7 ,1 ,0.75, 'linear')
		end
		
		if curStep == 1152 then
			setProperty('flashingshit.alpha','1')
			doTweenAlpha('flashingshit6','flashingshit',0,0.50,'linear')
			
			setProperty('iconP2.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
		end
		
		if curStep == 1400 then
			noteTweenAlpha('opponentStrums0',0 ,0 ,1.5, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,0 ,1.5, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,0 ,1.5, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,0 ,1.5, 'linear')
			
			noteTweenAlpha('playerStrums0',4 ,0 ,1.5, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0 ,1.5, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0 ,1.5, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0 ,1.5, 'linear')
			
			doTweenAlpha('score1','scoreTxt',0,1.5,'linear')
			doTweenAlpha('hpbg','healthBarBG',0,1.5,'linear')
			doTweenAlpha('hp','healthBar',0,1.5,'linear')
			doTweenAlpha('ip1','iconP1',0,1.5,'linear')
			doTweenAlpha('ip2','iconP2',0,1.5,'linear')
		end
	end
end