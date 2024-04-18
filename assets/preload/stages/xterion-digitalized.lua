local zoom = 0;
local fuck = false;
local eenndd = false;
local sus = false;
local JohnNineDoeMoment = false;
local FuckingGreenHills = false;
local camX = 700;
local camY = 600;

local xx = 600;
local yy = 580;
local ofs = 20;
local ofs2 = 20;
local xx2 = 900;
local yy2 = 580;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeAnimatedLuaSprite('bg', 'bgs/digitalized/bg', -400, 100);
		addAnimationByPrefix('bg', 'idle', 'static', 12, true);
		addAnimationByPrefix('bg', 'end', 'end', 12, false);
		addAnimationByPrefix('bg', 'black', 'blacks', 12, true);
		setScrollFactor('bg', 1, 1);
		addLuaSprite('bg', false);
		objectPlayAnimation('bg', 'idle', true)
		
		makeAnimatedLuaSprite('gh', 'bgs/digitalized/green-hill', -400, 0);
		addAnimationByPrefix('gh', 'green', 'green', 6, true);
		addAnimationByPrefix('gh', 'red', 'red', 6, true);
		luaSpritePlayAnimation('gh', 'green');
		setScrollFactor('gh', 1, 1);
		addLuaSprite('gh', false);
		setProperty('gh.alpha',0)
		
		precacheImage('bgs/digitalized/green-hill')
	end
	
	makeLuaSprite('blacky', '', 0, -500);
	makeGraphic('blacky',1920,1080,'000000')
	addLuaSprite('blacky', true);
	setLuaSpriteScrollFactor('blacky',0,0)
	setProperty('blacky.scale.x',2)
	setProperty('blacky.scale.y',2)
	setProperty('blacky.alpha',1)
	
	makeAnimatedLuaSprite('ring', 'bgs/digitalized/ring', 0, 0);
	addAnimationByIndices('ring', 'idle', '0', 24, true);
	addAnimationByPrefix('ring', 'anim', 'anim', 24, false);
	objectPlayAnimation('ring', 'idle', true)
	setScrollFactor('ring', 0, 0);
	setProperty('ring.scale.x',1.5)
	setProperty('ring.scale.y',1.5)
	screenCenter('ring')
	addLuaSprite('ring', true);
	setProperty('ring.alpha',0)
	
	makeLuaSprite('flashingshit', '', -300, -300);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	setProperty('camHUD.alpha',0)
end

function onUpdate(elapsed)
	if FuckingGreenHills == false then
		if JohnNineDoeMoment == false then
			if zoom == 0 then
				doTweenZoom('ZOOMDAD', 'camGame',0.5, 0.5, 'quadOut')
			end
			if zoom == 1 then
				doTweenZoom('ZOOMDAD', 'camGame',0.6, 0.5, 'quadOut')
			end
			if zoom == 2 then
				doTweenZoom('ZOOMDAD', 'camGame',0.7, 0.5, 'quadOut')
			end
			if zoom == 3 then
				doTweenZoom('ZOOMDAD', 'camGame',0.8, 0.5, 'quadOut')
			end
			if zoom == 4 then
				doTweenZoom('ZOOMDAD', 'camGame',0.9, 0.5, 'quadOut')
			end
		else
			triggerEvent('Camera Follow Pos', camX, camY)
		end
	else
		doTweenZoom('ZOOMDAD', 'camGame',1.0, 0.5, 'quadOut')
	end
	
	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if sus == false then
		if FuckingGreenHills == false then
			if eenndd == false then
				if fuck == false then
					if mustHitSection == false then
						if getProperty('dad.animation.curAnim.name.startsWith("sing")') then
							noteTweenAlpha('opponentStrums0T1',0 ,0.6 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums1T1',1 ,0.6 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums2T1',2 ,0.6 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums3T1',3 ,0.6 ,0.2, 'linear')
							
							noteTweenAlpha('playerStrumss0',4 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss1',5 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss2',6 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss3',7 ,0.1 ,0.2, 'linear')
						end
						if getProperty('dad.animation.curAnim.name') == 'idle' then
							noteTweenAlpha('opponentStrums0T1',0 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums1T1',1 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums2T1',2 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums3T1',3 ,0.1 ,0.2, 'linear')
							
							noteTweenAlpha('playerStrumss0',4 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss1',5 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss2',6 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss3',7 ,0.1 ,0.2, 'linear')
						end
					else
						if getProperty('boyfriend.animation.curAnim.name.startsWith("sing")') then
							noteTweenAlpha('opponentStrums0T1',0 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums1T1',1 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums2T1',2 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums3T1',3 ,0.1 ,0.2, 'linear')
							
							noteTweenAlpha('playerStrumss0',4 ,0.6 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss1',5 ,0.6 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss2',6 ,0.6 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss3',7 ,0.6 ,0.2, 'linear')
						end
						if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
							noteTweenAlpha('opponentStrums0T1',0 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums1T1',1 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums2T1',2 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('opponentStrums3T1',3 ,0.1 ,0.2, 'linear')
							
							noteTweenAlpha('playerStrumss0',4 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss1',5 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss2',6 ,0.1 ,0.2, 'linear')
							noteTweenAlpha('playerStrumss3',7 ,0.1 ,0.2, 'linear')
						end
					end
				else
					noteTweenAlpha('opponentStrums0T1',0 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums1T1',1 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums2T1',2 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums3T1',3 ,0.6 ,0.2, 'linear')
					
					noteTweenAlpha('playerStrumss0',4 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss1',5 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss2',6 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss3',7 ,0.6 ,0.2, 'linear')
				end
			end
		else
			if mustHitSection == false then
				if getProperty('dad.animation.curAnim.name.startsWith("sing")') then
					noteTweenAlpha('opponentStrums0T1',0 ,0.8 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums1T1',1 ,0.8 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums2T1',2 ,0.8 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums3T1',3 ,0.8 ,0.2, 'linear')
					
					noteTweenAlpha('playerStrumss0',4 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss1',5 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss2',6 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss3',7 ,0.6 ,0.2, 'linear')
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					noteTweenAlpha('opponentStrums0T1',0 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums1T1',1 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums2T1',2 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums3T1',3 ,0.6 ,0.2, 'linear')
						
					noteTweenAlpha('playerStrumss0',4 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss1',5 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss2',6 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss3',7 ,0.6 ,0.2, 'linear')
				end
			else
				if getProperty('boyfriend.animation.curAnim.name.startsWith("sing")') then
					noteTweenAlpha('opponentStrums0T1',0 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums1T1',1 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums2T1',2 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums3T1',3 ,0.6 ,0.2, 'linear')
						
					noteTweenAlpha('playerStrumss0',4 ,0.8 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss1',5 ,0.8 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss2',6 ,0.8 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss3',7 ,0.8 ,0.2, 'linear')
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					noteTweenAlpha('opponentStrums0T1',0 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums1T1',1 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums2T1',2 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('opponentStrums3T1',3 ,0.6 ,0.2, 'linear')
					
					noteTweenAlpha('playerStrumss0',4 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss1',5 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss2',6 ,0.6 ,0.2, 'linear')
					noteTweenAlpha('playerStrumss3',7 ,0.6 ,0.2, 'linear')
				end
			end
		end
	end
	
	if songName == "digitalized" then
		if curStep == 5 then
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBarBGBG.alpha', 0)
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
		
		if curStep == 6 then
			setProperty('camHUD.alpha',1)
		end
		
		if curStep == 10 then
			doTweenAlpha('BL1','blacky',0,0.5,'linear')	
		end

		if curStep == 128 then
			doTweenAlpha('iconP2T','iconP2',1,0.5,'linear')	
			doTweenAlpha('iconP1T','iconP1',1,0.5,'linear')	
			doTweenAlpha('healthBarT','healthBar',0.7,0.5,'linear')	
			doTweenAlpha('healthBarBGT','healthBarBG',0.7,0.5,'linear')	
			doTweenAlpha('scoreTxtT','scoreTxt',0.5,0.5,'linear')	
			doTweenAlpha('timeBarBGT','timeBarBG',1,0.5,'linear')	
			doTweenAlpha('timeBarBGBGT','timeBarBGBG',1,0.5,'linear')
			doTweenAlpha('timeBarT','timeBar',1,0.5,'linear')	
			doTweenAlpha('timeTxtT','timeTxt',1,0.5,'linear')
		end

		if curStep == 128 or curStep == 512 or curStep == 678 or curStep == 806 or curStep == 1152 or curStep == 1280 or curStep == 1664 or curStep == 1920 then
			zoom = 2;
		end
		
		if curStep == 384 or curStep == 896 or curStep == 1260 or curStep == 1388 or curStep == 1792 then
			zoom = 1;
		end
		
		if curStep == 648 or curStep == 776 or curStep == 1536  then
			zoom = 3;
		end
		
		if curStep == 1408 then
			zoom = 4;
		end
		
		if curStep == 128 or curStep == 1152 or curStep == 1405 or curStep == 1789 then
			fuck = true;
		end
		
		if curStep == 640 or curStep == 1661 or curStep == 1920 then
			fuck = false;
		end
		
		if curStep == 634 then
			doTweenAlpha('iconP2TT','iconP2',0,0.5,'linear')	
			doTweenAlpha('iconP1TT','iconP1',0,0.5,'linear')	
			doTweenAlpha('healthBarTT','healthBar',0,0.5,'linear')	
			doTweenAlpha('healthBarBGTT','healthBarBG',0,0.5,'linear')	
			doTweenAlpha('scoreTxtTT','scoreTxt',0,0.5,'linear')	
			doTweenAlpha('timeBarBGTT','timeBarBG',0,0.5,'linear')	
			doTweenAlpha('timeBarBGBGTT','timeBarBGBG',0,0.5,'linear')
			doTweenAlpha('timeBarTT','timeBar',0,0.5,'linear')	
			doTweenAlpha('timeTxtTT','timeTxt',0,0.5,'linear')
		end
		
		if curStep == 637 then
			doTweenAlpha('BL2','blacky',1,0.20,'linear')	
		end
		
		if curStep == 642 then
			setProperty('blacky.alpha',0)
			setProperty('ring.alpha',1)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('gh.alpha',1)
			end
			triggerEvent('Change Character', '1', 'xterion-first-gh')
			objectPlayAnimation('ring', 'anim', false)
			FuckingGreenHills = true;	
		end
		
		if curStep == 652 then
			setProperty('ring.alpha',0)
		end
		
		if curStep == 891 then
			doTweenAlpha('BL3','blacky',1,0.25,'linear')	
		end
		
		if curStep == 896 then
			setProperty('blacky.alpha',0)
			setProperty('ring.alpha',1)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				luaSpritePlayAnimation('gh', 'red');
			end
			objectPlayAnimation('ring', 'anim', false)
		end
		
		if curStep == 907 then
			setProperty('ring.alpha',0)
		end
		
		if curStep == 1147 then
			doTweenAlpha('BL4','blacky',1,0.25,'linear')	
		end
		
		if curStep == 1152 then
			setProperty('blacky.alpha',0)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('gh.alpha',0)
			end
			triggerEvent('Change Character', '1', 'xterion-first')
			objectPlayAnimation('ring', 'anim', false)
			FuckingGreenHills = false;
			setProperty('ring.alpha',1)
			
			doTweenAlpha('iconP2TTT','iconP2',1,0.5,'linear')	
			doTweenAlpha('iconP1TTT','iconP1',1,0.5,'linear')	
			doTweenAlpha('healthBarTTT','healthBar',0.7,0.5,'linear')	
			doTweenAlpha('healthBarBGTTT','healthBarBG',0.7,0.5,'linear')	
			doTweenAlpha('scoreTxtTTT','scoreTxt',0.5,0.5,'linear')	
			doTweenAlpha('timeBarBGTTT','timeBarBG',1,0.5,'linear')	
			doTweenAlpha('timeBarBGBGTTT','timeBarBGBG',1,0.5,'linear')
			doTweenAlpha('timeBarTTT','timeBar',1,0.5,'linear')	
			doTweenAlpha('timeTxtTTT','timeTxt',1,0.5,'linear')
		end
		
		if curStep == 1167 then
			setProperty('ring.alpha',0)
		end
		
		if curStep == 1920 then
			sus = true;
			doTweenAlpha('iconP2TTTT','iconP2',0,2.5,'linear')	
			doTweenAlpha('iconP1TTTT','iconP1',0,2.5,'linear')	
			doTweenAlpha('healthBarTTTT','healthBar',0,2.5,'linear')	
			doTweenAlpha('healthBarBGTTTT','healthBarBG',0,2.5,'linear')	
			doTweenAlpha('scoreTxtTTTT','scoreTxt',0,2.5,'linear')	
			doTweenAlpha('timeBarBGTTTT','timeBarBG',0,2.5,'linear')	
			doTweenAlpha('timeBarBGBGTTTT','timeBarBGBG',0,2.5,'linear')
			doTweenAlpha('timeBarTTTT','timeBar',0,2.5,'linear')	
			doTweenAlpha('timeTxtTTTT','timeTxt',0,2.5,'linear')
			
			noteTweenAlpha('opponentStrumss0END',0 ,0 ,2.5, 'linear')
			noteTweenAlpha('opponentStrumss1END',1 ,0 ,2.5, 'linear')
			noteTweenAlpha('opponentStrumss2END',2 ,0 ,2.5, 'linear')
			noteTweenAlpha('opponentStrumss3END',3 ,0 ,2.5, 'linear')
		
			noteTweenAlpha('playerStrumss0END',4 ,0 ,2.5, 'linear')
			noteTweenAlpha('playerStrumss1END',5 ,0 ,2.5, 'linear')
			noteTweenAlpha('playerStrumss2END',6 ,0 ,2.5, 'linear')
			noteTweenAlpha('playerStrumss3END',7 ,0 ,2.5, 'linear')
		end
		if curStep == 1976 then
			JohnNineDoeMoment = true;
			doTweenZoom('ZOOMDAD', 'camGame',1.2, 10, 'quadInOut')
		end
		if curStep == 1978 then
			camX = 650;
			camY = 610;
		end
		if curStep == 1980 then
			camX = 600;
			camY = 620;
		end
		if curStep == 1982 then
			camX = 550;
			camY = 630;
		end
		if curStep == 1984 then
			camX = 500;
		end
		if curStep == 1986 then
			camX = 450;
		end
		if curStep == 1988 then
			camX = 400;
		end
		if curStep == 1990 then
			camX = 350;
		end
		if curStep == 1992 then
			camX = 300;
		end
		if curStep == 2001 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				objectPlayAnimation('bg', 'end', false)
			end
			eenndd = true;
		end
		if curStep == 2033 then
			triggerEvent('Play Animation', 'ending', 'Dad');
			triggerEvent('Alt Idle Animation', 'Dad', '-alt');
		end
		if curStep == 2048 then
			setProperty('boyfriend.alpha',0)
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
			setProperty('dad.alpha',0)
		end
	end
	
	if FuckingGreenHills == true then
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
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
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