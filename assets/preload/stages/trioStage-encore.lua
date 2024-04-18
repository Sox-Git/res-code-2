local xx = 700;
local yy = 200;
local ofs = 15;
local ofs2 = 15;
local xx2 = 700;
local yy2 = 200;
local followchars = true
local beatOne = false
local coolCamIguess = false

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		--Tails
		makeLuaSprite('ts_sky', 'bgs/triple-trouble-encore/tails/ts_sky', -450, -1000);
		scaleObject('ts_sky', 1.2, 1.2);
		setScrollFactor('ts_sky', 1, 1);
		setProperty('ts_sky.antialiasing', true);
		addLuaSprite('ts_sky', false)
		
		makeLuaSprite('ts_fg', 'bgs/triple-trouble-encore/tails/ts_fg', -600, -1000);
		scaleObject('ts_fg', 0.95, 0.95);
		setScrollFactor('ts_fg', 0.7, 0.9);
		setProperty('ts_fg.antialiasing', true);
		addLuaSprite('ts_fg', true)
		
		makeLuaSprite('ts_trees1', 'bgs/triple-trouble-encore/tails/ts_trees1', -500, -800);
		scaleObject('ts_trees1', 0.95, 0.95);
		setScrollFactor('ts_trees1', 0.8, 0.9);
		setProperty('ts_trees1.antialiasing', true);
		addLuaSprite('ts_trees1', false)
		
		makeLuaSprite('ts_grass2', 'bgs/triple-trouble-encore/tails/ts_grass2', -500, -900);
		scaleObject('ts_grass2', 0.95, 0.95);
		setScrollFactor('ts_grass2', 0.85, 0.9);
		setProperty('ts_grass2.antialiasing', true);
		addLuaSprite('ts_grass2', false)
		
		makeLuaSprite('ts_trees2', 'bgs/triple-trouble-encore/tails/ts_trees2', -500, -800);
		scaleObject('ts_trees2', 0.95, 0.95);
		setScrollFactor('ts_trees2', 0.9, 1);
		setProperty('ts_trees2.antialiasing', true);
		addLuaSprite('ts_trees2', false)
		
		makeLuaSprite('ts_floor', 'bgs/triple-trouble-encore/tails/ts_floor', -550, -900);
		scaleObject('ts_floor', 0.95, 0.95);
		setScrollFactor('ts_floor', 1, 1);
		setProperty('ts_floor.antialiasing', true);
		addLuaSprite('ts_floor', false)
		
		--Xeno
		makeLuaSprite('xeno_sky', 'bgs/triple-trouble-encore/xeno/xeno_sky', -750, -1100);
		scaleObject('xeno_sky', 1.7, 1.55);
		setScrollFactor('xeno_sky', 1, 1);
		setProperty('xeno_sky.antialiasing', true);
		addLuaSprite('xeno_sky', false)
		
		makeLuaSprite('xeno_fg', 'bgs/triple-trouble-encore/xeno/xeno_fg', -800, -1100);
		scaleObject('xeno_fg', 1.1, 1.1);
		setScrollFactor('xeno_fg', 1.4, 0.9);
		setProperty('xeno_fg.antialiasing', true);
		addLuaSprite('xeno_fg', true)
		
		makeLuaSprite('xeno_trees2', 'bgs/triple-trouble-encore/xeno/xeno_trees2', -800, -1100);
		scaleObject('xeno_trees2', 1, 1);
		setScrollFactor('xeno_trees2', 1.2, 1.2);
		setProperty('xeno_trees2.antialiasing', true);
		addLuaSprite('xeno_trees2', false)
		
		makeLuaSprite('xeno_trees1', 'bgs/triple-trouble-encore/xeno/xeno_trees1', -800, -1100);
		scaleObject('xeno_trees1', 1, 1);
		setScrollFactor('xeno_trees1', 1.1, 1.1);
		setProperty('xeno_trees1.antialiasing', true);
		addLuaSprite('xeno_trees1', false)
		
		makeLuaSprite('xeno_floor', 'bgs/triple-trouble-encore/xeno/xeno_floor', -800, -1100);
		scaleObject('xeno_floor', 1, 1);
		setScrollFactor('xeno_floor', 1, 1);
		setProperty('xeno_floor.antialiasing', true);
		addLuaSprite('xeno_floor', false)
		
		--knuckles
		makeLuaSprite('kn_bg', 'bgs/triple-trouble-encore/knuckles/kn_bg', -930, -600);
		scaleObject('kn_bg', 2, 1.6);
		setScrollFactor('kn_bg', 1, 1);
		setProperty('kn_bg.antialiasing', true);
		addLuaSprite('kn_bg', false)
		
		makeLuaSprite('kn_city1', 'bgs/triple-trouble-encore/knuckles/kn_city1', -930, -800);
		scaleObject('kn_city1', 2, 1.6);
		setScrollFactor('kn_city1', 0.9, 0.9);
		setProperty('kn_city1.antialiasing', true);
		addLuaSprite('kn_city1', false)
		
		makeLuaSprite('kn_city2', 'bgs/triple-trouble-encore/knuckles/kn_city2', -930, -800);
		scaleObject('kn_city2', 2, 1.6);
		setScrollFactor('kn_city2', 1.07, 1.07);
		setProperty('kn_city2.antialiasing', true);
		addLuaSprite('kn_city2', false)
		
		makeLuaSprite('kn_floor', 'bgs/triple-trouble-encore/knuckles/kn_floor', -1100, -1300);
		scaleObject('kn_floor', 2.3, 2.3);
		setScrollFactor('kn_floor', 1, 1);
		setProperty('kn_floor.antialiasing', true);
		addLuaSprite('kn_floor', false)
		
		--Eggman
		makeLuaSprite('egg_bg', 'bgs/triple-trouble-encore/eggman/egg_bg', -1000, -1000);
		scaleObject('egg_bg', 1.5, 1.5);
		setScrollFactor('egg_bg', 1, 1);
		setProperty('egg_bg.antialiasing', true);
		addLuaSprite('egg_bg', false)
		
		makeLuaSprite('egg_eys', 'bgs/triple-trouble-encore/eggman/egg_eys', -1000, -1000);
		scaleObject('egg_eys', 1.5, 1.5);
		setScrollFactor('egg_eys', 1, 1);
		setProperty('egg_eys.antialiasing', true);
		addLuaSprite('egg_eys', false)
		
		
		setProperty('ts_sky.alpha', 1)
		setProperty('ts_fg.alpha', 1)
		setProperty('ts_floor.alpha', 1)
		setProperty('ts_grass2.alpha', 1)
		setProperty('ts_trees1.alpha', 1)
		setProperty('ts_trees2.alpha', 1)
		setProperty('xeno_fg.alpha', 0)
		setProperty('xeno_floor.alpha', 0)
		setProperty('xeno_sky.alpha', 0)
		setProperty('xeno_trees1.alpha', 0)
		setProperty('xeno_trees2.alpha', 0)
		setProperty('kn_bg.alpha', 0)
		setProperty('kn_city1.alpha', 0)
		setProperty('kn_city2.alpha', 0)
		setProperty('kn_floor.alpha', 0)
		setProperty('egg_bg.alpha', 0)
		setProperty('egg_eys.alpha', 0)
	end
	--Other Shit
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	screenCenter('black')
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',4)
	setProperty('black.scale.y',4)
	setProperty('black.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	screenCenter('flashingshit')
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('flashB', '', 0, 0);
	makeGraphic('flashB',1920,1080,'FF0000')
	addLuaSprite('flashB', true);
	screenCenter('flashB')
	setLuaSpriteScrollFactor('flashB',0,0)
	setProperty('flashB.scale.x',4)
	setProperty('flashB.scale.y',4)
	setProperty('flashB.alpha',0)
end

function onBeatHit()
	if beatOne == true then
		triggerEvent('Add Camera Zoom')
		setProperty('flashB.alpha', 0.1)
		doTweenAlpha('flB','flashB',0,0.35,'linear')
	end
	if beatOne == false then
		setProperty('flashB.alpha', 0)
		doTweenAlpha('flB','flashB',0,0,'linear')
	end
end

function onTimerCompleted(tag)
	if tag == 'eyes up' then
		doTweenY('egg_eys-TweenUp', 'egg_eys', -1000, 2.5, 'sineInOut')
		runTimer('eyes down', 2.5, 1)
	end
	if tag == 'eyes down' then
		doTweenY('egg_eys-TweenDown', 'egg_eys', -1100, 2.5, 'sineInOut')
		runTimer('eyes up', 2.5, 1)
	end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if coolCamIguess == true then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.48)
		else
			setProperty('defaultCamZoom',0.55)
		end
	end
	
	if songName == "triple-trouble-encore" then
		if curStep == 1 then
			noteTweenX("note0", 0, 106.2, 0.3, quadInOut) --106,2
			noteTweenX("note1", 1, 208.8, 0.3, quadInOut)
			noteTweenX("note3", 3, 315, 0.3, quadInOut)
			noteTweenX("note4", 4, 421.2, 0.3, cubeInOut)

					
			noteTweenX("note5", 5, 646.4, 0.3, cubeInOut)
			noteTweenX("note6", 6, 752.6, 0.3, cubeInOut)
			noteTweenX("note7", 7, 858.8, 0.3, cubeInOut)
			noteTweenX("note8", 8, 965, 0.3, cubeInOut)
			noteTweenX("note9", 9, 1071.2, 0.3, cubeInOut)
		end
		if curStep == 16 then
			xx = 450;
			yy = 300;
			xx2 = 950;
			yy2 = 300;
		end
		if curStep == 400 then
			setProperty('defaultCamZoom',0.6)
			yy = 300;
			yy2 = 300;
		end
		if curStep == 416 then
			setProperty('defaultCamZoom',0.625)
			yy = 310;
			yy2 = 310;
		end
		if curStep == 432 then
			setProperty('defaultCamZoom',0.65)
			yy = 330;
			yy2 = 330;
		end
		if curStep == 448 then
			setProperty('defaultCamZoom',0.675)
			yy = 360;
			yy2 = 360;
		end
		if curStep == 464 then
			setProperty('defaultCamZoom',0.7)
		end
		if curStep == 480 then
			setProperty('defaultCamZoom',0.725)
			yy = 370;
			yy2 = 370;
		end
		if curStep == 496 then
			setProperty('defaultCamZoom',0.75)
		end
		if curStep == 512 then
			setProperty('defaultCamZoom',0.8)
			yy = 380;
			yy2 = 380;
		end
		if curStep == 528 then
			setProperty('defaultCamZoom',0.6)
			yy = 300;
			yy2 = 300;
		end
		if curStep == 528 or curStep == 784 or curStep == 1040 or curStep == 1350 or curStep == 2246 or curStep == 2765 or curStep == 3278 or curStep == 5719 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('flashCuzOfYes','flashingshit',0,1,'linear')
		end
		if curStep == 1040 then --Xeno P1
			beatOne = true;
			xx = 600;
			yy = -50;
			xx2 = 800;
			yy2 = 250;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('ts_fg.alpha',0)
				setProperty('ts_floor.alpha',0)
				setProperty('ts_grass2.alpha',0)
				setProperty('ts_sky.alpha',0)
				setProperty('ts_trees1.alpha',0)
				setProperty('ts_trees2.alpha',0)
				setProperty('xeno_fg.alpha', 1)
				setProperty('xeno_floor.alpha', 1)
				setProperty('xeno_sky.alpha', 1)
				setProperty('xeno_trees1.alpha', 1)
				setProperty('xeno_trees2.alpha', 1)
				setProperty('xeno_fg.flipX',true)
				setProperty('xeno_floor.flipX',true)
				setProperty('xeno_sky.flipX',true)
				setProperty('xeno_trees1.flipX',true)
				setProperty('xeno_trees2.flipX',true)
			end
			coolCamIguess = true;
		end
		if curStep == 1164 then
			beatOne = false;
			doTweenAlpha('bl1','black',1,0.3,'linear')
			doTweenAlpha('CH1','camHUD',0,0.3,'linear')
		end
		if curStep == 1186 then
			doTweenAlpha('bl2','black',0,1.6,'linear')
			doTweenAlpha('CH2','camHUD',1,1.6,'linear')
		end
		if curStep == 1200 then
			beatOne = true;
		end
		if curStep == 1324 then
			beatOne = false;
			doTweenAlpha('bl3','black',1,0.3,'linear')
			doTweenAlpha('CH3','camHUD',0,0.3,'linear')
		end
		if curStep == 1328 then --Knux
			xx = 750;
			yy = 250;
			xx2 = 450;
			yy2 = 250;
			setProperty('boyfriend.y',160)
			setProperty('boyfriend.x',-200)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('kn_bg.alpha', 1)
				setProperty('kn_city1.alpha', 1)
				setProperty('kn_city2.alpha', 1)
				setProperty('kn_floor.alpha', 1)
				setProperty('xeno_fg.alpha', 0)
				setProperty('xeno_floor.alpha', 0)
				setProperty('xeno_sky.alpha', 0)
				setProperty('xeno_trees1.alpha', 0)
				setProperty('xeno_trees2.alpha', 0)
			end
			coolCamIguess = false;
			
			noteTweenX("note0", 0, 752.6, 0.3, quadInOut) --106,2
			noteTweenX("note1", 1, 858.8, 0.3, quadInOut)
			noteTweenX("note3", 3, 965, 0.3, quadInOut)
			noteTweenX("note4", 4, 1071.2, 0.3, cubeInOut)

			
			noteTweenX("note5", 5, 106.2, 0.3, cubeInOut)
			noteTweenX("note6", 6, 208.8, 0.3, cubeInOut)
			noteTweenX("note7", 7, 315, 0.3, cubeInOut)
			noteTweenX("note8", 8, 421.2, 0.3, cubeInOut)
			noteTweenX("note9", 9, 527.4, 0.3, cubeInOut)
			

			runHaxeCode([[
				game.bfIsLeft = true;
				game.xenoEncIconP1.changeIcon(game.dad.healthIcon);
				game.xenoEncIconP2.changeIcon(game.boyfriend.healthIcon);
				game.reloadHealthBarColors();
			]])
		end
		if curStep == 1350 then
			doTweenAlpha('bl4','black',0,0.3,'linear')
			doTweenAlpha('CH4','camHUD',1,0.3,'linear')
		end
		if curStep == 1990 then
			setProperty('defaultCamZoom',0.7)
			yy = 400;
			yy2 = 400;
		end
		if curStep == 2246 or curStep == 2566 or curStep == 2694 then
			setProperty('defaultCamZoom',0.5)
			xx = 750;
			yy = 250;
			xx2 = 450;
			yy2 = 250;
		end
		if curStep == 2502 or curStep == 2630 then
			setProperty('defaultCamZoom',0.65)
			yy = 360;
			yy2 = 360;
		end
		if curStep == 2752 then
			doTweenAlpha('bl5','black',1,1.2,'linear')
		end
		if curStep == 2764 then --Xeno P2
			xx = 800;
			yy = -50;
			xx2 = 600;
			yy2 = 250;
			setProperty('dad.x',1000);
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('kn_bg.alpha', 0)
				setProperty('kn_city1.alpha', 0)
				setProperty('kn_city2.alpha', 0)
				setProperty('kn_floor.alpha', 0)
				setProperty('xeno_fg.alpha', 1)
				setProperty('xeno_floor.alpha', 1)
				setProperty('xeno_sky.alpha', 1)
				setProperty('xeno_trees1.alpha', 1)
				setProperty('xeno_trees2.alpha', 1)
				setProperty('xeno_fg.x', -700)
				setProperty('xeno_floor.x', -600)
				setProperty('xeno_sky.x', -550)
				setProperty('xeno_trees1.x', -600)
				setProperty('xeno_trees2.x', -600)
				setProperty('xeno_fg.flipX',false)
				setProperty('xeno_floor.flipX',false)
				setProperty('xeno_sky.flipX',false)
				setProperty('xeno_trees1.flipX',false)
				setProperty('xeno_trees2.flipX',false)
			end
			coolCamIguess = true;
		end
		if curStep == 2768 then
			setProperty('black.alpha', 0)
			beatOne = true;
		end
		if curStep == 3339 then
			beatOne = false;
		end
		if curStep == 3339 then --Eggman
			xx = 450;
			yy = 200;
			xx2 = 1650;
			yy2 = 200;
			runTimer('eyes up', 0.01, 1)
			setProperty('boyfriend.x', 1500);
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('xeno_fg.alpha', 0)
				setProperty('ts_fg.alpha', 0)
				setProperty('xeno_floor.alpha', 0)
				setProperty('xeno_sky.alpha', 0)
				setProperty('xeno_trees1.alpha', 0)
				setProperty('xeno_trees2.alpha', 0)
				setProperty('egg_bg.alpha', 1)
				setProperty('egg_eys.alpha', 1)
			end
			coolCamIguess = false;
			setProperty('defaultCamZoom',0.4)
		end
		if curStep == 3340 then
			noteTweenX("note0", 0, 106.2, 0.3, quadInOut) --106,2
			noteTweenX("note1", 1, 208.8, 0.3, quadInOut)
			noteTweenX("note3", 3, 315, 0.3, quadInOut)
			noteTweenX("note4", 4, 421.2, 0.3, cubeInOut)

			
			noteTweenX("note5", 5, 646.4, 0.3, cubeInOut)
			noteTweenX("note6", 6, 752.6, 0.3, cubeInOut)
			noteTweenX("note7", 7, 858.8, 0.3, cubeInOut)
			noteTweenX("note8", 8, 965, 0.3, cubeInOut)
			noteTweenX("note9", 9, 1071.2, 0.3, cubeInOut)
			

			runHaxeCode([[
				game.bfIsLeft = false;
				game.xenoEncIconP2.changeIcon(game.dad.healthIcon);
				game.xenoEncIconP1.changeIcon(game.boyfriend.healthIcon);
				game.reloadHealthBarColors();
			]])
		end
		if curStep == 3466 then
			setProperty('defaultCamZoom',0.45)
		end
		if curStep == 3594 then
			setProperty('defaultCamZoom',0.35)
		end
		if curStep == 3724 then
			setProperty('defaultCamZoom',0.4)
			xx = 1000;
			yy = 170;
			xx2 = 1000;
			yy2 = 170;
		end
		if curStep == 3851 then
			setProperty('defaultCamZoom',0.3)
			xx = 1000;
			yy = 170;
			xx2 = 1000;
			yy2 = 170;
		end
		if curStep == 3979 then
			setProperty('defaultCamZoom',0.4)
			xx = 1000;
			yy = 170;
			xx2 = 1000;
			yy2 = 170;
		end
		if curStep == 4235 then
			setProperty('defaultCamZoom',0.25)
			xx = 1000;
			yy = 140;
			xx2 = 1000;
			yy2 = 140;
		end
		if curStep == 4495 then
			setProperty('defaultCamZoom',0.4)
		end
		if curStep == 4499 then
			xx = 450;
			yy = 200;
			xx2 = 1650;
			yy2 = 200;
		end
		if curStep == 4626 then
			beatOne = true;
			xx = 600;
			yy = -50;
			xx2 = 800;
			yy2 = 250;
			setProperty('boyfriend.x', 1200);
			setProperty('boyfriend.y', 400);
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('egg_bg.alpha',0)
				setProperty('egg_eys.alpha',0)
				setProperty('xeno_fg.alpha', 1)
				setProperty('xeno_floor.alpha', 1)
				setProperty('xeno_sky.alpha', 1)
				setProperty('xeno_trees1.alpha', 1)
				setProperty('xeno_trees2.alpha', 1)
				setProperty('xeno_fg.x', -800)
				setProperty('xeno_floor.x', -800)
				setProperty('xeno_sky.x', -750)
				setProperty('xeno_trees1.x', -800)
				setProperty('xeno_trees2.x', -800)
				setProperty('xeno_fg.flipX',true)
				setProperty('xeno_floor.flipX',true)
				setProperty('xeno_sky.flipX',true)
				setProperty('xeno_trees1.flipX',true)
				setProperty('xeno_trees2.flipX',true)
			end
			coolCamIguess = true;
		end
		if curStep == 5763 then
			triggerEvent('startstatic')
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
			if getProperty('dad.animation.curAnim.name') == 'laugh' then
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