local dadx = 400;
local dady = 425;
local gfx = 400;
local gfy = 425;
local bfx = 400;
local bfy = 425;
local vineboom = true;

function onCreate()
	makeLuaSprite('white', '', 0, 0);
	makeGraphic('white',1920,1080,'FFFFFF')
	addLuaSprite('white', false);
	setLuaSpriteScrollFactor('white',0,0)
	setProperty('white.scale.x',2)
	setProperty('white.scale.y',2)
	
	makeAnimatedLuaSprite('gf', 'characters/GF/Skins/sunky_gf', 0, -20);
	addAnimationByPrefix('gf', 'sunky', 'sunky', 28, true);
	setScrollFactor('gf', 1, 1);
	setProperty('gf.alpha',0)
	addLuaSprite('gf', false);
	
	makeLuaSprite('slaps', 'bgs/old-ycr-slaps', -430, -350);
	scaleObject('slaps', 1.75, 1.75);
	setScrollFactor('slaps', 0, 0);
	setProperty('slaps.antialiasing', false);
	setProperty('slaps.alpha', 1);
	addLuaSprite('slaps', true);
	
	setProperty('camHUD.alpha',0)
end

function onUpdate(elapsed)

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "old-ycr-slaps" then
		if curStep == 20 then
			doTweenY('bfTween1', 'boyfriend', 200, 1.5, 'quadInOut');
			doTweenY('dadTween1', 'dad', 0, 1.5, 'quadInOut');
			doTweenY('slapsTween1', 'slaps', -495, 1.5, 'quadInOut');

			noteTweenAlpha('opponentStrumss0',0 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrumss1',1 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrumss2',2 ,0 ,0.05, 'linear')
			noteTweenAlpha('opponentStrumss3',3 ,0 ,0.05, 'linear')
		
			noteTweenAlpha('playerStrumss0',4 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrumss1',5 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrumss2',6 ,0 ,0.05, 'linear')
			noteTweenAlpha('playerStrumss3',7 ,0 ,0.05, 'linear')
			
			doTweenAlpha('sscore','scoreTxt',0,0.05,'linear')
			doTweenAlpha('hhbBG','healthBarBG',0,0.05,'linear')
			doTweenAlpha('hhp','healthBar',0,0.05,'linear')
			doTweenAlpha('iiconP1','iconP1',0,0.05,'linear')
			doTweenAlpha('iiconP2','iconP2',0,0.05,'linear')
			doTweenAlpha('ttimeBarBG','timeBarBG',0,0.05,'linear')
			doTweenAlpha('ttimeBar','timeBar',0,0.05,'linear')
			doTweenAlpha('ttimeTxt','timeTxt',0,0.05,'linear')
		end
		
		if curStep == 25 then
			setProperty('camHUD.alpha',1)
		end
		
		if curStep == 80 then
			doTweenY('bfTween2', 'boyfriend', 350, 1.5, 'quadInOut');
			doTweenY('dadTween2', 'dad', 150, 1.5, 'quadInOut');
			doTweenY('slapsTween2', 'slaps', -350, 1.5, 'quadInOut');
			
			doTweenZoom('camZoom', 'camGame', 0.7, 2.5, 'quadInOut');
		end
		
		if curStep == 90 then
			doTweenAlpha('slapsTween3','slaps',0,1,'quadInOut')
		end
		
		if curStep == 224 then
			noteTweenAlpha('opponentStrums0',0 ,1 ,1, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,1 ,1, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,1 ,1, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,1 ,1, 'linear')
		
			noteTweenAlpha('playerStrums0',4 ,1 ,1, 'linear')
			noteTweenAlpha('playerStrums1',5 ,1 ,1, 'linear')
			noteTweenAlpha('playerStrums2',6 ,1 ,1, 'linear')
			noteTweenAlpha('playerStrums3',7 ,1 ,1, 'linear')
			
			doTweenAlpha('score','scoreTxt',1,1,'linear')
			doTweenAlpha('hbBG','healthBarBG',1,1,'linear')
			doTweenAlpha('hp','healthBar',1,1,'linear')
			doTweenAlpha('iconP1','iconP1',1,1,'linear')
			doTweenAlpha('iconP2','iconP2',1,1,'linear')
			doTweenAlpha('timeBarBG','timeBarBG',1,1,'linear')
			doTweenAlpha('timeBar','timeBar',1,1,'linear')
			doTweenAlpha('timeTxt','timeTxt',1,1,'linear')
			
			doTweenAlpha('gf','gf',1,1,'linear')
		end
		
		if curStep == 768 then
			noteTweenAlpha('oopponentStrums0',0 ,0 ,1, 'linear')
			noteTweenAlpha('oopponentStrums1',1 ,0 ,1, 'linear')
			noteTweenAlpha('oopponentStrums2',2 ,0 ,1, 'linear')
			noteTweenAlpha('oopponentStrums3',3 ,0 ,1, 'linear')
		
			noteTweenAlpha('pplayerStrums0',4 ,0 ,1, 'linear')
			noteTweenAlpha('pplayerStrums1',5 ,0 ,1, 'linear')
			noteTweenAlpha('pplayerStrums2',6 ,0 ,1, 'linear')
			noteTweenAlpha('pplayerStrums3',7 ,0 ,1, 'linear')
			
			doTweenAlpha('scoree','scoreTxt',0,1,'linear')
			doTweenAlpha('hbBGG','healthBarBG',0,1,'linear')
			doTweenAlpha('hpp','healthBar',0,1,'linear')
			doTweenAlpha('iconP11','iconP1',0,1,'linear')
			doTweenAlpha('iconP22','iconP2',0,1,'linear')
			doTweenAlpha('timeBarBGG','timeBarBG',0,0.05,'linear')
			doTweenAlpha('timeBarr','timeBar',0,0.05,'linear')
			doTweenAlpha('timeTxtt','timeTxt',0,0.05,'linear')
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