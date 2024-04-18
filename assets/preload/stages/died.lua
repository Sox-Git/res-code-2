local dadx = 400;
local dady = 350;
local gfx = 400;
local gfy = 350;
local bfx = 400;
local bfy = 350;
local vineboom = true;
local ugh = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/gameover/bg', -1300, -750);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		setProperty('bg.alpha', 1)
		setProperty('bg.scale.x',0.75)
		setProperty('bg.scale.y',0.75)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('bgLights', 'bgs/gameover/bg-lights', -860, -470);
			addAnimationByPrefix('bgLights', 'idle', 'idle', 3, true);
			scaleObject('bgLights', 0.75, 0.75);
			setScrollFactor('bgLights', 1, 1);
			setProperty('bgLights.antialiasing', true);
			addLuaSprite('bgLights', false);
		end
		
		makeLuaSprite('fg', 'bgs/gameover/fg', -1600, -750);
		setScrollFactor('fg', 1, 1);
		setProperty('fg.antialiasing', true);
		addLuaSprite('fg', true);
		setProperty('fg.alpha', 1)
		setProperty('fg.scale.x',0.75)
		setProperty('fg.scale.y',0.75)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeAnimatedLuaSprite('bgText', 'bgs/gameover/bg-text', -860, -450);
			addAnimationByPrefix('bgText', 'start', 'start', 18, false);
			addAnimationByPrefix('bgText', 'idle', 'idle', 18, true);
			scaleObject('bgText', 0.75, 0.75);
			setScrollFactor('bgText', 1, 1);
			setProperty('bgText.antialiasing', true);
			addLuaSprite('bgText', true);
		end
		
		setProperty('bg.alpha', 0)
		setProperty('bgLights.alpha', 0)
		setProperty('fg.alpha', 0)
		setProperty('bgText.alpha', 0)
	end
	
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	screenCenter('black')
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',4)
	setProperty('black.scale.y',4)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	screenCenter('flashingshit')
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)
	setProperty('camHUD.alpha', 0)
	
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeAnimatedLuaSprite('static', 'bgs/gameover/toofarstatic', 0, 0);
		addAnimationByPrefix('static', 'idle', 'idle', 24, true);
		setProperty('static.antialiasing', true);
		addLuaSprite('static', true);
		setScrollFactor('static', 0, 0);
		setObjectCamera('static', 'camHUD')
		setGraphicSize('static', 1280, 720)
		screenCenter('static')
		setBlendMode('static','ADD')
		setProperty('static.alpha', 0.4)
	end
end

function onUpdate(elapsed)
	if vineboom == true then	
        if mustHitSection == false then
			if gfSection == false then
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',dadx,dady)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',gfx,gfy)
				end	
			end
        else
			if gfSection == false then
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss'  or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' or getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' or getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',bfx,bfy)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT' or getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',gfx,gfy)
				end	
			end
        end
        triggerEvent('Camera Follow Pos','','')
	end
	
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if ugh == true then
		doTweenZoom('damn', 'camGame',0.65, 0.5, 'quadOut')
	end
	
	if songName == "too-far" then
		if curStep == 2 then
			setProperty('gf.alpha',0)
			setProperty('black.alpha',1)
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
		end
		
		if curStep == 10 then
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBarBGBG.alpha', 0)
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
		end
		
		if curStep == 15 then
			noteTweenAlpha('1opponentStrums0',0,0,0.05,'linear')
			noteTweenAlpha('1opponentStrums1',1,0,0.05,'linear')
			noteTweenAlpha('1opponentStrums2',2,0,0.05,'linear')
			noteTweenAlpha('1opponentStrums3',3,0,0.05,'linear')
			
			noteTweenAlpha('1playerStrums0',4,0,0.05,'linear')
			noteTweenAlpha('1playerStrums1',5,0,0.05,'linear')
			noteTweenAlpha('1playerStrums2',6,0,0.05,'linear')
			noteTweenAlpha('1playerStrums3',7,0,0.05,'linear')
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("1DadT1", 0, 93, 0.05, quadInOut)
				noteTweenX("1DadT2", 1, 205, 0.05, quadInOut)
				noteTweenX("1DadT3", 2, 957, 0.05, quadInOut)
				noteTweenX("1DadT4", 3, 1069, 0.05, quadInOut)
				
				noteTweenX("1BFDT1", 4, 412, 0.05, quadInOut)
				noteTweenX("1BFDT2", 5, 524, 0.05, quadInOut)
				noteTweenX("1BFDT3", 6, 638, 0.05, quadInOut)
				noteTweenX("1BFDT4", 7, 750, 0.05, quadInOut)
			end
		end
		
		if curStep == 20 then
			setProperty('camHUD.alpha', 1)
		end
		
		if curStep == 22 or curStep == 24 or curStep == 26 or curStep == 28 or curStep == 30 or curStep == 32 or curStep == 34 or curStep == 36 or curStep == 38 or curStep == 40 or curStep == 42 or curStep == 44 or curStep == 46 or curStep == 48 or curStep == 50 or curStep == 52 or curStep == 54 or curStep == 56 then
			setProperty('black.alpha',0)
			cameraShake('game', 0.007, 0.05)
			dadx = 400;
			dady = 400;
		end
		
		if curStep == 21 or curStep == 23 or curStep == 25 or curStep == 27 or curStep == 29 or curStep == 31 or curStep == 33 or curStep == 35 or curStep == 37 or curStep == 39 or curStep == 41 or curStep == 43 or curStep == 45 or curStep == 47 or curStep == 49 or curStep == 51 or curStep == 53 or curStep == 55 or curStep == 57 then
			setProperty('black.alpha',1)
			cameraShake('game', 0.007, 0.05)
			triggerEvent('Play Animation', 'singUP', 'Dad');
		end
		
		if curStep == 55 then
			dadx = 400;
			dady = 350;
			gfx = 400;
			gfy = 350;
			bfx = 400;
			bfy = 350;
		end
		if curStep == 63 then
			dadx = 400;
			dady = 350;
			gfx = 400;
			gfy = 350;
			bfx = 400;
			bfy = 350;
		end
		if curStep == 64 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f1','flashingshit',0,0.7,'linear')
		
			ugh = false;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha', 1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bgLights.alpha', 1)
					setProperty('bgText.alpha', 1)
				end
				setProperty('fg.alpha', 1)
			end
			doTweenAlpha('blacky','black',0,0.7,'elasticOut')
			
			doTweenAlpha('1iconP2','iconP2',1,0.40,'linear')
			doTweenAlpha('1iconP1','iconP1',1,0.40,'linear')
			doTweenAlpha('1healthBar','healthBar',1,0.40,'linear')
			doTweenAlpha('1healthBarBG','healthBarBG',1,0.40,'linear')
			doTweenAlpha('1scoreTxt','scoreTxt',1,0.40,'linear')
			doTweenAlpha('1timeBarBG','timeBarBG',1,0.40,'linear')
			doTweenAlpha('1timeBarBGBG','timeBarBGBG',1,0.40,'linear')
			doTweenAlpha('1timeBar','timeBar',1,0.40,'linear')
			doTweenAlpha('1timeTxt','timeTxt',1,0.40,'linear')
			
			noteTweenAlpha('2opponentStrums0',0,0.3,0.40,'linear')
			noteTweenAlpha('2opponentStrums1',1,0.3,0.40,'linear')
			noteTweenAlpha('2opponentStrums2',2,0.3,0.40,'linear')
			noteTweenAlpha('2opponentStrums3',3,0.3,0.40,'linear')

			noteTweenAlpha('2playerStrums0',4,1,0.40,'linear')
			noteTweenAlpha('2playerStrums1',5,1,0.40,'linear')
			noteTweenAlpha('2playerStrums2',6,1,0.40,'linear')
			noteTweenAlpha('2playerStrums3',7,1,0.40,'linear')
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				luaSpritePlayAnimation('bgText', 'start', false)
			end
		end
		
		if curStep == 96 then
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				luaSpritePlayAnimation('bgText', 'idle', true)
			end
		end
	
		if curStep == 576 then
			doTweenAlpha('2iconP2','iconP2',0,0.40,'linear')
			doTweenAlpha('2iconP1','iconP1',0,0.40,'linear')
			doTweenAlpha('2healthBar','healthBar',0,0.40,'linear')
			doTweenAlpha('2healthBarBG','healthBarBG',0,0.40,'linear')
			doTweenAlpha('2scoreTxt','scoreTxt',0,0.40,'linear')
			doTweenAlpha('2timeBarBG','timeBarBG',0,0.40,'linear')
			doTweenAlpha('2timeBarBGBG','timeBarBGBG',0,0.40,'linear')
			doTweenAlpha('2timeBar','timeBar',0,0.40,'linear')
			doTweenAlpha('2timeTxt','timeTxt',0,0.40,'linear')
			
			noteTweenAlpha('3opponentStrums0',0,0,0.40,'linear')
			noteTweenAlpha('3opponentStrums1',1,0,0.40,'linear')
			noteTweenAlpha('3opponentStrums2',2,0,0.40,'linear')
			noteTweenAlpha('3opponentStrums3',3,0,0.40,'linear')
			
			noteTweenAlpha('3playerStrums0',4,0,0.40,'linear')
			noteTweenAlpha('3playerStrums1',5,0,0.40,'linear')
			noteTweenAlpha('3playerStrums2',6,0,0.40,'linear')
			noteTweenAlpha('3playerStrums3',7,0,0.40,'linear')
		end
		if curStep == 592 then
			doTweenAlpha('gf','gf',1,5.0,'elasticOut')
			doTweenX('1gfTween', 'gf', "450", 5,'elasticOut');
			doTweenX('1dadTween', 'dad', "-400", 5,'elasticOut');
			setProperty('bfIsLeft', true);
		end
		if curStep == 624 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f2','flashingshit',0,1,'linear')
		
			doTweenAlpha('3iconP2','iconP2',1,0.40,'linear')
			doTweenAlpha('3iconP1','iconP1',1,0.40,'linear')
			doTweenAlpha('3healthBar','healthBar',1,0.40,'linear')
			doTweenAlpha('3healthBarBG','healthBarBG',1,0.40,'linear')
			doTweenAlpha('3scoreTxt','scoreTxt',1,0.40,'linear')
			doTweenAlpha('3timeBarBG','timeBarBG',1,0.40,'linear')
			doTweenAlpha('3timeBarBGBG','timeBarBGBG',1,0.40,'linear')
			doTweenAlpha('3timeBar','timeBar',1,0.40,'linear')
			doTweenAlpha('3timeTxt','timeTxt',1,0.40,'linear')

			noteTweenAlpha('4opponentStrums0',0,0.3,0.40,'linear')
			noteTweenAlpha('4opponentStrums1',1,0.3,0.40,'linear')
			noteTweenAlpha('4opponentStrums2',2,0.3,0.40,'linear')
			noteTweenAlpha('4opponentStrums3',3,0.3,0.40,'linear')
			
			noteTweenAlpha('4playerStrums0',4,1,0.40,'linear')
			noteTweenAlpha('4playerStrums1',5,1,0.40,'linear')
			noteTweenAlpha('4playerStrums2',6,1,0.40,'linear')
			noteTweenAlpha('4playerStrums3',7,1,0.40,'linear')
		end
		
		if curStep == 1904 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f','flashingshit',0,1,'linear')
			
			doTweenAlpha('blacky2','black',1,4,'elasticOut')
			doTweenAlpha('camHUUH','camHUD',0,1.0,'elasticOut')
			
			doTweenAlpha('gf','gf',0,5.0,'elasticOut')
			doTweenX('2gfTween', 'gf', "1000", 5,'elasticOut');
			doTweenX('2dadTween', 'dad', "50", 5,'elasticOut');
			setProperty('bfIsLeft', false);
		end
	end
	if songName == "last-hope" then
		if curStep == 2 then
			setProperty('gf.alpha',0)
			setProperty('black.alpha',1)
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
		end
		
		if curStep == 10 then
			setProperty('timeBarBG.alpha', 0)
			setProperty('timeBarBGBG.alpha', 0)
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
		end
		
		if curStep == 15 then
			noteTweenAlpha('1opponentStrums0',0,0,0.05,'linear')
			noteTweenAlpha('1opponentStrums1',1,0,0.05,'linear')
			noteTweenAlpha('1opponentStrums2',2,0,0.05,'linear')
			noteTweenAlpha('1opponentStrums3',3,0,0.05,'linear')
			
			noteTweenAlpha('1playerStrums0',4,0,0.05,'linear')
			noteTweenAlpha('1playerStrums1',5,0,0.05,'linear')
			noteTweenAlpha('1playerStrums2',6,0,0.05,'linear')
			noteTweenAlpha('1playerStrums3',7,0,0.05,'linear')
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("1DadT1", 0, 93, 0.05, quadInOut)
				noteTweenX("1DadT2", 1, 205, 0.05, quadInOut)
				noteTweenX("1DadT3", 2, 957, 0.05, quadInOut)
				noteTweenX("1DadT4", 3, 1069, 0.05, quadInOut)
				
				noteTweenX("1BFDT1", 4, 412, 0.05, quadInOut)
				noteTweenX("1BFDT2", 5, 524, 0.05, quadInOut)
				noteTweenX("1BFDT3", 6, 638, 0.05, quadInOut)
				noteTweenX("1BFDT4", 7, 750, 0.05, quadInOut)
			end
		end
		
		if curStep == 128 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f1','flashingshit',0,0.7,'linear')
		
			ugh = false;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bg.alpha', 1)
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bgLights.alpha', 1)
					setProperty('bgText.alpha', 1)
				end
				setProperty('fg.alpha', 1)
			end
			doTweenAlpha('blacky','black',0,0.7,'elasticOut')
			
			doTweenAlpha('1iconP2','iconP2',1,0.40,'linear')
			doTweenAlpha('1iconP1','iconP1',1,0.40,'linear')
			doTweenAlpha('1healthBar','healthBar',1,0.40,'linear')
			doTweenAlpha('1healthBarBG','healthBarBG',1,0.40,'linear')
			doTweenAlpha('1scoreTxt','scoreTxt',1,0.40,'linear')
			doTweenAlpha('1timeBarBG','timeBarBG',1,0.40,'linear')
			doTweenAlpha('1timeBarBGBG','timeBarBGBG',1,0.40,'linear')
			doTweenAlpha('1timeBar','timeBar',1,0.40,'linear')
			doTweenAlpha('1timeTxt','timeTxt',1,0.40,'linear')
			
			noteTweenAlpha('2opponentStrums0',0,0.3,0.40,'linear')
			noteTweenAlpha('2opponentStrums1',1,0.3,0.40,'linear')
			noteTweenAlpha('2opponentStrums2',2,0.3,0.40,'linear')
			noteTweenAlpha('2opponentStrums3',3,0.3,0.40,'linear')

			noteTweenAlpha('2playerStrums0',4,1,0.40,'linear')
			noteTweenAlpha('2playerStrums1',5,1,0.40,'linear')
			noteTweenAlpha('2playerStrums2',6,1,0.40,'linear')
			noteTweenAlpha('2playerStrums3',7,1,0.40,'linear')
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				luaSpritePlayAnimation('bgText', 'start', false)
			end
		end
		
		if curStep == 129 then
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				luaSpritePlayAnimation('bgText', 'idle', true)
			end
		end
		
		if curStep == 256 then
			setProperty('camHUD.alpha', 1)
		end
	end
end