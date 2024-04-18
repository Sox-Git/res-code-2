local xx = 1350;
local yy = 1150;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1350;
local yy2 = 1150;
local CenterXFix = 150;
local followchars = true;
local shakin = false;

function onCreate()
	xx = xx+CenterXFix;
	xx2 = xx2+CenterXFix;
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeAnimatedLuaSprite('truefatalstage', 'bgs/critical/truefatalstage', -400, 100);
		addAnimationByPrefix('truefatalstage', 'idle', 'idle', 12, true);
		objectPlayAnimation('truefatalstage', 'idle', true)
		scaleObject('truefatalstage', 4, 4);
		setScrollFactor('truefatalstage', 1, 1);
		setProperty('truefatalstage.antialiasing', false);
		addLuaSprite('truefatalstage', false);

		makeLuaSprite('criticalBG', 'bgs/critical/bg', -1300, -800);
		scaleObject('criticalBG', 4, 4);
		setProperty('criticalBG.antialiasing', false);
		addLuaSprite('criticalBG', false);
		setScrollFactor('criticalBG', 0.2, 0.2);
		setProperty('criticalBG.alpha',0)

		makeAnimatedLuaSprite('criticalWindows', 'bgs/critical/windows', -1100, -360);
		addAnimationByPrefix('criticalWindows', 'idle', 'windows', 24, true);
		objectPlayAnimation('criticalWindows', 'idle', true)
		scaleObject('criticalWindows', 4, 4);
		setScrollFactor('criticalWindows', 0.3, 0.5);
		setProperty('criticalWindows.antialiasing', false);
		addLuaSprite('criticalWindows', false);
		setProperty('criticalWindows.alpha',0)

		makeLuaSprite('bsod', 'bgs/critical/bsod', -150, 200);
		scaleObject('bsod', 2.7, 2.7);
		setScrollFactor('bsod', 0.4, 0.6);
		setProperty('bsod.antialiasing', false);
		addLuaSprite('bsod', false);
		setProperty('bsod.alpha',0)

		makeLuaSprite('bsodead', 'bgs/critical/bsodead', -150, 200);
		scaleObject('bsodead', 2.7, 2.7);
		setScrollFactor('bsodead', 0.4, 0.6);
		setProperty('bsodead.antialiasing', false);
		addLuaSprite('bsodead', false);
		setProperty('bsodead.alpha',0)

		makeLuaSprite('criticalFloor', 'bgs/critical/ground', -418, 1364);
		scaleObject('criticalFloor', 4, 4);
		setProperty('criticalFloor.antialiasing', false);
		addLuaSprite('criticalFloor', false);
		setProperty('criticalFloor.alpha',0)
	end
	makeAnimatedLuaSprite('static', 'bgs/omw/staticOMW', -680, -800);
	scaleObject('static', 6.5, 6.5);
	addAnimationByPrefix('static', 'sshh', 'stat', 24, true);
	setScrollFactor('static', 0, 0);
	setProperty('static.antialiasing', false);
	setProperty('static.alpha',0)
	addLuaSprite('static', true);
	setObjectCamera('static', 'camHUD')
	setProperty('static.color', getColorFromHex('FF0000'))

	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	setProperty('black.alpha',0)
	setObjectCamera('black', 'camHUD')
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	setObjectCamera('flashingshit', 'camHUD')

	makeAnimatedLuaSprite('lyrics', 'bgs/critical/lyrics', 120, 170);
	luaSpriteAddAnimationByIndices('lyrics', 'a', 'y-c-i-m', '0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2', 12)
	luaSpriteAddAnimationByIndices('lyrics', 'b', 'y-c-i-m', '3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5,3,4,5', 12)
	luaSpriteAddAnimationByIndices('lyrics', 'c', 'y-c-i-m', '6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8,6,7,8', 12)
	luaSpriteAddAnimationByIndices('lyrics', 'd', 'y-c-i-m', '9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11,9,10,11', 12)
	setLuaSpriteScrollFactor('lyrics',0,0)
	luaSpritePlayAnimation('lyrics', 'a', true)
	setProperty('lyrics.antialiasing', false);
	addLuaSprite('lyrics', true);
	setProperty('lyrics.alpha',0)
	setObjectCamera('lyrics', 'camOther')
	
	makeLuaSprite('red', '', 0, 0);
	makeGraphic('red',1920,1080,'FF0000')
	addLuaSprite('red', true);
	setLuaSpriteScrollFactor('red',0,0)
	setProperty('red.scale.x',2)
	setProperty('red.scale.y',2)
	setProperty('red.alpha',0)
	setObjectCamera('red', 'camHUD')
end

function hideUi(yes)
	if yes == true then
		doTweenAlpha('sonicHUD','sonicHUD',0,0.08,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',0,0.08,'linear')
		doTweenAlpha('healthBarDis','healthBar',0,0.08,'linear')
		doTweenAlpha('iconP1Dis','iconP1',0,0.08,'linear')
		doTweenAlpha('iconP2Dis','iconP2',0,0.08,'linear')
	end
	if yes == false then
		doTweenAlpha('sonicHUD','sonicHUD',1,0.08,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',1,0.08,'linear')
		doTweenAlpha('healthBarDis','healthBar',1,0.08,'linear')
		doTweenAlpha('iconP1Dis','iconP1',1,0.08,'linear')
		doTweenAlpha('iconP2Dis','iconP2',1,0.08,'linear')
	end
end

function Final(no)
	if no == true then
		doTweenAlpha('sonicHUD','sonicHUD',0,2.38,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',0,2.38,'linear')
		doTweenAlpha('healthBarDis','healthBar',0,2.38,'linear')
		doTweenAlpha('iconP1Dis','iconP1',0,2.38,'linear')
		doTweenAlpha('iconP2Dis','iconP2',0,2.38,'linear')
	end
	if no == false then
		doTweenAlpha('sonicHUD','sonicHUD',1,2.38,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',1,2.38,'linear')
		doTweenAlpha('healthBarDis','healthBar',1,2.38,'linear')
		doTweenAlpha('iconP1Dis','iconP1',1,2.38,'linear')
		doTweenAlpha('iconP2Dis','iconP2',1,2.38,'linear')
	end
end

function onUpdate(elapsed)

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "critical-error" then
		if curStep == 0 then
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("1DadT1", 0, 25, 0.05, quadInOut)
				noteTweenX("1DadT2", 1, 137, 0.05, quadInOut)
				noteTweenX("1DadT3", 2, 726, 0.05, quadInOut)
				noteTweenX("1DadT4", 3, 838, 0.05, quadInOut)
				
				noteTweenX("1BFDT1", 4, 262, 0.05, quadInOut)
				noteTweenX("1BFDT2", 5, 374, 0.05, quadInOut)
				noteTweenX("1BFDT3", 6, 488, 0.05, quadInOut)
				noteTweenX("1BFDT4", 7, 600, 0.05, quadInOut)
			end
		end
		if curStep == 229 then
			doTweenAlpha('bl','black',1,0.15,'linear')
			doTweenAlpha('lyrics','lyrics',1,0.15,'linear')
			luaSpritePlayAnimation('lyrics', 'a', true)
			
			noteTweenAlpha('oopponentSttrrumms0',0 ,0.5 ,0.15, 'linear')
			noteTweenAlpha('oopponentSttrrumms1',1 ,0.5 ,0.15, 'linear')
			noteTweenAlpha('oopponentSttrrumms2',2 ,0.5 ,0.15, 'linear')
			noteTweenAlpha('oopponentSttrrumms3',3 ,0.5 ,0.15, 'linear')
		
			noteTweenAlpha('pplayerSttrumms0',4 ,0.5 ,0.15, 'linear')
			noteTweenAlpha('pplayerSttrumms1',5 ,0.5 ,0.15, 'linear')
			noteTweenAlpha('pplayerSttrumms2',6 ,0.5 ,0.15, 'linear')
			noteTweenAlpha('pplayerSttrumms3',7 ,0.5 ,0.15, 'linear')
			
			doTweenAlpha('ttimeBBarBGGG','timeBarBG',0.5,0.15,'linear')
			doTweenAlpha('ttimeBBarrr','timeBar',0.5,0.15,'linear')
			doTweenAlpha('ttimeTTxttt','timeTxt',0.5,0.15,'linear')
			doTweenAlpha('sscoree1','scoreTxt',0.5,0.15,'linear')
			doTweenAlpha('hhpbgg','healthBarBG',0.5,0.15,'linear')
			doTweenAlpha('hhpp','healthBar',0.5,0.15,'linear')
			doTweenAlpha('iip11','iconP1',0.5,0.15,'linear')
			doTweenAlpha('iip22','iconP2',0.5,0.15,'linear')
		end
		if curStep == 238 then
			luaSpritePlayAnimation('lyrics', 'b', true)
		end
		if curStep == 246 then
			luaSpritePlayAnimation('lyrics', 'c', true)
		end
		if curStep == 255 then
			shakin = true;
			luaSpritePlayAnimation('lyrics', 'd', true)
		end
		if curStep == 264 then
			noteTweenAlpha('oopponentSttrrumms0',0 ,1 ,0.15, 'linear')
			noteTweenAlpha('oopponentSttrrumms1',1 ,1 ,0.15, 'linear')
			noteTweenAlpha('oopponentSttrrumms2',2 ,1 ,0.15, 'linear')
			noteTweenAlpha('oopponentSttrrumms3',3 ,1 ,0.15, 'linear')
		
			noteTweenAlpha('pplayerSttrumms0',4 ,1 ,0.15, 'linear')
			noteTweenAlpha('pplayerSttrumms1',5 ,1 ,0.15, 'linear')
			noteTweenAlpha('pplayerSttrumms2',6 ,1 ,0.15, 'linear')
			noteTweenAlpha('pplayerSttrumms3',7 ,1 ,0.15, 'linear')
			
			doTweenAlpha('ttimeBBarBGGG','timeBarBG',1,0.15,'linear')
			doTweenAlpha('ttimeBBarrr','timeBar',1,0.15,'linear')
			doTweenAlpha('ttimeTTxttt','timeTxt',1,0.15,'linear')
			doTweenAlpha('sscoree1','scoreTxt',1,0.15,'linear')
			doTweenAlpha('hhpbgg','healthBarBG',1,0.15,'linear')
			doTweenAlpha('hhpp','healthBar',1,0.15,'linear')
			doTweenAlpha('iip11','iconP1',1,0.15,'linear')
			doTweenAlpha('iip22','iconP2',1,0.15,'linear')
			
			shakin = false;
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash1','flashingshit',0,1.0,'linear')
			setProperty('lyrics.alpha',0)
			setProperty('black.alpha',0)
			doTweenAlpha('cam','camHUD',1,0.15,'linear')
			xx = 1400+CenterXFix;
			yy = 1350;
			ofs = 25;
			ofs2 = 25;
			xx2 = 1400+CenterXFix;
			yy2 = 1350;
			setProperty('defaultCamZoom',0.5)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('criticalBG.alpha',1)
				setProperty('criticalWindows.alpha',1)
				setProperty('criticalFloor.alpha',1)
				setProperty('truefatalstage.alpha',0)
			end
			setProperty('boyfriend.y',1350)
			setProperty('boyfriend.x',1071)
		end
		if curStep == 527 then
			setProperty('defaultCamZoom',0.4)
			xx = 1500+CenterXFix;
			yy = 1350;
			xx2 = 1500+CenterXFix;
			yy2 = 1350;
		end
		if curStep == 658 then
			setProperty('defaultCamZoom',0.5)
			xx = 1400+CenterXFix;
			yy = 1350;
			xx2 = 1400+CenterXFix;
			yy2 = 1350;
		end
		if curStep == 790 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash2','flashingshit',0,1.0,'linear')
			setProperty('defaultCamZoom',0.6)
			xx = 1300+CenterXFix;
			yy = 1150;
			xx2 = 1300+CenterXFix;
			yy2 = 1150;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('da','criticalBG',0,1.0,'linear')
				doTweenAlpha('daba','criticalWindows',0,1.0,'linear')
				setProperty('criticalFloor.color', getColorFromHex('FF0000'))
			end
			setProperty('dad.color', getColorFromHex('FF0000'))
			setProperty('boyfriend.color', getColorFromHex('FF0000'))
		end
		if curStep == 921 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash3','flashingshit',0,1.0,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 1400+CenterXFix;
			yy = 1350;
			xx2 = 1400+CenterXFix;
			yy2 = 1350;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('criticalBG.alpha',1)
				setProperty('criticalWindows.alpha',1)
				setProperty('criticalFloor.color', getColorFromHex('FFFFFF'))
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1023 then
			doTweenAlpha('red','red', 1, 2.3, 'linear')
		end
		if curStep == 1052 then
			hideUi(true);
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('red','red', 0, 1, 'linear')
			doTweenAlpha('Flash4','flashingshit',0,0.6,'linear')
			ofs = 10;
			ofs2 = 5;
			xx = 1190+CenterXFix;
			yy = 1125;
			xx2 = 1190+CenterXFix;
			yy2 = 1125;
			setProperty('boyfriend.alpha',0)
			setProperty('defaultCamZoom',0.75)
			setProperty('boyfriend.y',1450)
			setProperty('boyfriend.x',1071)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bsod.alpha',1)
				setProperty('criticalFloor.alpha',0)
				setProperty('criticalFloor.color', getColorFromHex('666666'))
			end
			setProperty('boyfriend.color', getColorFromHex('666666'))
			setProperty('dad.color', getColorFromHex('666666'))
		end
		if curStep == 1311 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bsodead','bsodead',1,1.8,'linear')
			end
		end
		if curStep == 1326 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('codered','flashingshit',1,2.5,'linear')
			end
		end
		if curStep == 1344 then
			doTweenAlpha('codeblack','flashingshit',0,0.15,'linear')
			setProperty('black.alpha',1)
		end
		if curStep == 1346 then
			hideUi(false);
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			setProperty('black.alpha',0)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bsod.alpha',0)
				setProperty('bsodead.alpha',0)
			end
			doTweenAlpha('Flash5','flashingshit',0,1.0,'linear')
			ofs = 15;
			ofs2 = 15;
			xx = 1400+CenterXFix;
			yy = 1350;
			xx2 = 1400+CenterXFix;
			yy2 = 1350;
			setProperty('boyfriend.alpha',1)
			setProperty('defaultCamZoom',0.5)
			setProperty('boyfriend.y',1350)
			setProperty('boyfriend.x',1071)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('criticalFloor.alpha',1)
				setProperty('criticalFloor.color', getColorFromHex('FFFFFF'))
			end
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1858 then
			shakin = true;
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash7','flashingshit',0,1.0,'linear')
			xx = 1650+CenterXFix;
			yy = 1200;
			ofs = 25;
			ofs2 = 25;
			xx2 = 1650+CenterXFix;
			yy2 = 1200;
			setProperty('defaultCamZoom',0.35)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('criticalBG.alpha',0)
				setProperty('criticalWindows.alpha',0)
				setProperty('criticalFloor.color', getColorFromHex('494949'))
			end
			setProperty('boyfriend.color', getColorFromHex('494949'))
			setProperty('dad.y',330)
			setProperty('dad.x',550)
		end
		if curStep == 2125 or curStep == 2141 or curStep == 2157 or curStep == 2173 or curStep == 2188 or curStep == 2205 or curStep == 2221 then
			setProperty('black.alpha',1)
		end
		if curStep == 2130 or curStep == 2146 or curStep == 2162 or curStep == 2178 or curStep == 2194 or curStep == 2210 or curStep == 2226 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flash','flashingshit',0,0.5,'linear')
			setProperty('black.alpha',0)
		end
		if curStep == 2242 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash8','flashingshit',0,1.0,'linear')
		end
		if curStep == 2361 then
			doTweenAlpha('Flash9','flashingshit',1,0.75,'linear')
		end
		if curStep == 2370 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash10','flashingshit',0,1.0,'linear')
		end
		if curStep == 2592 then
			doTweenAlpha('Flash11','flashingshit',1,2.8,'linear')
		end
		if curStep == 2626 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash12','flashingshit',0,1.0,'linear')
			
			noteTweenAlpha('oopponentSttrrumms0',0 ,0 ,4, 'linear')
			noteTweenAlpha('oopponentSttrrumms1',1 ,0 ,4, 'linear')
			noteTweenAlpha('oopponentSttrrumms2',2 ,0 ,4, 'linear')
			noteTweenAlpha('oopponentSttrrumms3',3 ,0 ,4, 'linear')
		
			noteTweenAlpha('pplayerSttrumms0',4 ,0 ,4, 'linear')
			noteTweenAlpha('pplayerSttrumms1',5 ,0 ,4, 'linear')
			noteTweenAlpha('pplayerSttrumms2',6 ,0 ,4, 'linear')
			noteTweenAlpha('pplayerSttrumms3',7 ,0 ,4, 'linear')
			
			doTweenAlpha('ttimeBBarBGGG','timeBarBG',0,4,'linear')
			doTweenAlpha('ttimeBBarrr','timeBar',0,4,'linear')
			doTweenAlpha('ttimeTTxttt','timeTxt',0,4,'linear')
			doTweenAlpha('sscoree1','scoreTxt',0,4,'linear')
			doTweenAlpha('hhpbgg','healthBarBG',0,4,'linear')
			doTweenAlpha('hhpp','healthBar',0,4,'linear')
			doTweenAlpha('iip11','iconP1',0,4,'linear')
			doTweenAlpha('iip22','iconP2',0,4,'linear')
		end
		if curStep == 2754 then
			doTweenAlpha('static','static',1,10,'linear')
		end
		if curStep == 2852 then
			Final(true)
			doTweenAlpha('black','black',1,2.38,'linear')
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

function opponentNoteHit()
	if shakin == true then
		cameraShake('game', 0.005, 0.05)
	end
end