local xx = 600;
local yy = 370;
local ofs = 25;
local ofs2 = 25;
local xx2 = 800;
local yy2 = 350;
local vineboom = true;
local random;
local a = false;
local BeatFlash = false;
local BeatHP = false;
local BeatFlashSlow = false;
local BeatHPSlow = false;
local zoom = -1;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/serious/bg', -550, -600);
		scaleObject('bg', 1, 1);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		setProperty('bg.alpha', 0.6);
		addLuaSprite('bg', false);
		
		makeLuaSprite('table', 'bgs/serious/table', -550, -600);
		scaleObject('table', 1, 1);
		setScrollFactor('table', 1, 1);
		setProperty('table.antialiasing', true);
		addLuaSprite('table', false);
	end
	
	makeLuaSprite('fgdf', '', 0, 0);
	makeGraphic('fgdf',1920,1080,'FFFFFF')
	addLuaSprite('fgdf', true);
	setLuaSpriteScrollFactor('fgdf',0,0)
	setProperty('fgdf.scale.x',2)
	setProperty('fgdf.scale.y',2)
	setProperty('fgdf.alpha',0)
	
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',2)
	setProperty('black.scale.y',2)
	setProperty('black.alpha',0)
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('light', 'bgs/serious/light', -550, -600);
		scaleObject('light', 1, 1);
		setScrollFactor('light', 1, 1);
		setProperty('light.antialiasing', true);
		addLuaSprite('light', true);
	end
	
	makeLuaSprite('bl', '', 0, 0);
	makeGraphic('bl',1920,1080,'000000')
	addLuaSprite('bl', true);
	setLuaSpriteScrollFactor('bl',0,0)
	setProperty('bl.scale.x',2)
	setProperty('bl.scale.y',2)
	setProperty('bl.alpha',0)
	
	makeLuaSprite('flash', '', 0, 0);
	makeGraphic('flash',1920,1080,'777777')
	addLuaSprite('flash', true);
	setLuaSpriteScrollFactor('flash',0,0)
	setProperty('flash.scale.x',2)
	setProperty('flash.scale.y',2)
	setProperty('flash.alpha',0)
end

function onBeatHit()
	if BeatFlash == true then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
			setProperty('fgdf.alpha', 0.03);
			doTweenAlpha('fgdf','fgdf',0,0.3,'linear')
		end
	end
	if BeatHP == true then
		if curBeat % 1 == 0 then
			if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
				setProperty('healthBar.y', 650);
				setProperty('healthBarBG.y', 650);
				doTweenY('HPtweenDown', 'healthBar', 645, 0.2,'cubicOut');
				doTweenY('HPBGtweenDown', 'healthBarBG', 645, 0.2,'cubicOut');
			else
				setProperty('healthBar.y', 88);
				setProperty('healthBarBG.y', 88);
				doTweenY('HPtweenDown', 'healthBar', 83, 0.2,'cubicOut');
				doTweenY('HPBGtweenDown', 'healthBarBG', 83, 0.2,'cubicOut');
			end

			setProperty('iconP2.angle', 10);
			doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

			setProperty('iconP1.angle', 10);
			doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
		end
		if curBeat % 2 == 0 then
			if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
				setProperty('healthBar.y', 640);
				setProperty('healthBarBG.y', 640);
				doTweenY('HPtweenUp', 'healthBar', 645, 0.2,'cubicOut');
				doTweenY('HPBGtweenUp', 'healthBarBG', 645, 0.2,'cubicOut');
			else
				setProperty('healthBar.y', 78);
				setProperty('healthBarBG.y', 78);
				doTweenY('HPtweenUp', 'healthBar', 83, 0.2,'cubicOut');
				doTweenY('HPBGtweenUp', 'healthBarBG', 83, 0.2,'cubicOut');
			end
		
			setProperty('iconP2.angle', -10);
			doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

			setProperty('iconP1.angle', -10);
			doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
		end
	end
	if BeatFlashSlow == true then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom')
			setProperty('fgdf.alpha', 0.03);
			doTweenAlpha('fgdf','fgdf',0,0.3,'linear')
		end
	end
	if BeatHPSlow == true then
		if curBeat % 2 == 0 then
			if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
				setProperty('healthBar.y', 650);
				setProperty('healthBarBG.y', 650);
				doTweenY('HPtweenDown', 'healthBar', 645, 0.2,'cubicOut');
				doTweenY('HPBGtweenDown', 'healthBarBG', 645, 0.2,'cubicOut');
			else
				setProperty('healthBar.y', 88);
				setProperty('healthBarBG.y', 88);
				doTweenY('HPtweenDown', 'healthBar', 83, 0.2,'cubicOut');
				doTweenY('HPBGtweenDown', 'healthBarBG', 83, 0.2,'cubicOut');
			end
		
			setProperty('iconP2.angle', 10);
			doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

			setProperty('iconP1.angle', 10);
			doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
		end
		if curBeat % 4 == 0 then
			if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
				setProperty('healthBar.y', 640);
				setProperty('healthBarBG.y', 640);
				doTweenY('HPtweenUp', 'healthBar', 645, 0.2,'cubicOut');
				doTweenY('HPBGtweenUp', 'healthBarBG', 645, 0.2,'cubicOut');
			else
				setProperty('healthBar.y', 78);
				setProperty('healthBarBG.y', 78);
				doTweenY('HPtweenUp', 'healthBar', 83, 0.2,'cubicOut');
				doTweenY('HPBGtweenUp', 'healthBarBG', 83, 0.2,'cubicOut');
			end
		
			setProperty('iconP2.angle', -10);
			doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

			setProperty('iconP1.angle', -10);
			doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
		end
	end

	if a == false then
		if curBeat % 2 == 0 then
			if getRandomInt(1,2) == 1 then
				random = 1;
			else
				if getRandomInt(3,4) == 3 then
					random = 3;
				else
					if getRandomInt(2,4) == 2 then
						random = 2;
					else
						random = 4;
					end
				end
			end
		else
			if getRandomInt(1,2) == 1 then
				random = 1;
			else
				if getRandomInt(3,4) == 3 then
					random = 3;
				else
					if getRandomInt(2,4) == 2 then
						random = 2;
					else
						random = 4;
					end
				end
			end
		end
	end
end

function onTimerCompleted(tag)
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		if tag == 'light1' then
			setProperty('boyfriendGroup.color', getColorFromHex('606060'))
			setProperty('dadGroup.color', getColorFromHex('606060'))
			setProperty('black.alpha',0)
			setProperty('light.alpha',1)
			if random == 1 then
				runTimer('light2', 5, 1)
			end
			if random == 2 then
				runTimer('light2', 4, 1)
			end
			if random == 3 then
				runTimer('light2', 2, 1)
			end
			if random == 4 then
				runTimer('light2', 1, 1)
			end
			a = false;
		end
		if tag == 'light2' then
			setProperty('black.alpha',0.15)
			setProperty('light.alpha',0.9)
			runTimer('light3', 0.02, 1)
		end
		if tag == 'light3' then
			setProperty('black.alpha',0)
			setProperty('light.alpha',1)
			runTimer('light4', 0.02, 1)
		end
		if random == 1 then
			if tag == 'light4' then
				a = true;
				setProperty('black.alpha',0.2)
				setProperty('light.alpha',0.7)
				runTimer('light5', 0.02, 1)
			end
			if tag == 'light5' then
				setProperty('black.alpha',0)
				setProperty('light.alpha',1)
				runTimer('light6', 0.02, 1)
			end
			if tag == 'light6' then
				setProperty('black.alpha',0.2)
				setProperty('light.alpha',0.8)
				runTimer('light7', 0.02, 1)
			end
			if tag == 'light7' then
				setProperty('black.alpha',0.15)
				setProperty('light.alpha',0.9)
				runTimer('light8', 0.02, 1)
			end
			if tag == 'light8' then
				setProperty('black.alpha',0.2)
				setProperty('light.alpha',0.7)
				runTimer('light9', 0.02, 1)
			end
			if tag == 'light9' then
				setProperty('black.alpha',0)
				setProperty('light.alpha',1)
				runTimer('light10', 0.02, 1)
			end
			if tag == 'light10' then
				setProperty('black.alpha',0.15)
				setProperty('light.alpha',0.9)
				runTimer('light1', 0.02, 1)
			end
		else
			if random == 2 then 
				if tag == 'light4' then
					a = true;
					setProperty('black.alpha',0.2)
					setProperty('light.alpha',0.7)
					runTimer('light5', 0.02, 1)
				end
				if tag == 'light5' then
					setProperty('black.alpha',0)
					setProperty('light.alpha',1)
					runTimer('light6', 0.02, 1)
				end
				if tag == 'light6' then
					runTimer('light7', 0.3, 1)
				end
				if tag == 'light7' then
					setProperty('black.alpha',0.2)
					setProperty('light.alpha',0.7)
					runTimer('light8', 0.02, 1)
				end
				if tag == 'light8' then
					setProperty('black.alpha',0.15)
					setProperty('light.alpha',0.9)
					runTimer('light1', 0.02, 1)
				end
			else
				if random == 3 then 
					if tag == 'light4' then
						a = true;
						setProperty('black.alpha',0.2)
						setProperty('light.alpha',0.7)
						runTimer('light5', 0.02, 1)
					end
					if tag == 'light5' then
						setProperty('black.alpha',0)
						setProperty('light.alpha',1)
						runTimer('light6', 0.3, 1)
					end
					if tag == 'light6' then
						setProperty('black.alpha',0.2)
						setProperty('light.alpha',0.8)
						runTimer('light1', 0.02, 1)
					end
				else
					if random == 4 then 
						if tag == 'light4' then
							a = true;
							setProperty('black.alpha',0.2)
							setProperty('light.alpha',0.8)
							runTimer('light1', 0.02, 1)
						end
					end
				end
			end
		end
	end
end

function onUpdate(elapsed)
	if zoom == -1 then
		doTweenZoom('zoom1', 'camGame',0.45, 0.1, 'quadInOut')
	end
	if zoom == 0 then
		doTweenZoom('zoom2', 'camGame',0.55, 0.1, 'quadInOut')
	end
	if zoom == 1 then
		doTweenZoom('zoom3', 'camGame',0.65, 0.1, 'quadInOut')
	end

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
	currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "personel-serious" then
		if curStep == 0 then
			setProperty('camHUD.alpha', 0);
			setProperty('scoreTxt.alpha', 0.2);
		end
		if curStep == 5 then
			runTimer('light1', 0.1, 1);
		end
		if curStep == 50 then
			noteTweenAlpha('opponentStrums0',0 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('opponentStrums1',1 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('opponentStrums2',2 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('opponentStrums3',3 ,0.5 ,0.005, 'linear')
			
			noteTweenAlpha('playerStrums0',4 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('playerStrums1',5 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('playerStrums2',6 ,0.5 ,0.005, 'linear')
			noteTweenAlpha('playerStrums3',7 ,0.5 ,0.005, 'linear')
		end
		if curStep == 150 then
			doTweenAlpha('cam0','camHUD',1,2,'linear')
		end
		if curStep == 160 then
			BeatFlash = true;
		end
		if curStep == 288 then
			BeatHP = true;
			setProperty('flash.alpha', 1);
			doTweenAlpha('flash1','flash',0,1,'linear')
		end
		if curStep == 544 then
			zoom = 1;
		end
		if curStep == 672 then
			zoom = 0;
		end
		if curStep == 782 then
			BeatHP = false;
			BeatFlash = false;
			doTweenAlpha('bl1','bl',1,0.25,'linear')
			doTweenAlpha('IconP21','iconP2',0,0.25,'linear')
			doTweenAlpha('IconP11','iconP1',0,0.25,'linear')
			doTweenAlpha('healthBar1','healthBar',0,0.25,'linear')
			doTweenAlpha('healthBarBG1','healthBarBG',0,0.25,'linear')
			doTweenAlpha('scoreTxt1','scoreTxt',0,0.25,'linear')
			doTweenAlpha('timeBarBG1','timeBarBG',0,0.25,'linear')
			doTweenAlpha('timeBarBGBG1','timeBarBGBG',0,0.25,'linear')
			doTweenAlpha('timeBar1','timeBar',0,0.25,'linear')
			doTweenAlpha('timeTxt1','timeTxt',0,0.25,'linear')
		end
		if curStep == 800 then
			zoom = -1;
			setProperty('flash.alpha', 1);
			doTweenAlpha('flash2','flash',0,1,'linear')
			BeatHP = true;
			BeatFlash = true;
			setProperty('bl.alpha', 0);
			doTweenAlpha('IconP22','iconP2',1,0.25,'linear')
			doTweenAlpha('IconP12','iconP1',1,0.25,'linear')
			doTweenAlpha('healthBar2','healthBar',1,0.25,'linear')
			doTweenAlpha('healthBarBG2','healthBarBG',1,0.25,'linear')
			doTweenAlpha('scoreTxt2','scoreTxt',0.2,0.25,'linear')
			doTweenAlpha('timeBarBG2','timeBarBG',1,0.25,'linear')
			doTweenAlpha('timeBarBGBG2','timeBarBGBG',1,0.25,'linear')
			doTweenAlpha('timeBar2','timeBar',1,0.25,'linear')
			doTweenAlpha('timeTxt2','timeTxt',1,0.25,'linear')
		end
		if curStep == 1040 then
			zoom = 1;
			BeatHP = false;
			BeatFlash = false;
			doTweenAlpha('IconP23','iconP2',0,0.25,'linear')
			doTweenAlpha('IconP13','iconP1',0,0.25,'linear')
			doTweenAlpha('healthBar3','healthBar',0,0.25,'linear')
			doTweenAlpha('healthBarBG3','healthBarBG',0,0.25,'linear')
			doTweenAlpha('scoreTxt3','scoreTxt',0,0.25,'linear')
			doTweenAlpha('timeBarBG3','timeBarBG',0,0.25,'linear')
			doTweenAlpha('timeBarBGBG3','timeBarBGBG',0,0.25,'linear')
			doTweenAlpha('timeBar3','timeBar',0,0.25,'linear')
			doTweenAlpha('timeTxt3','timeTxt',0,0.25,'linear')
		end
		if curStep == 1056 then
			zoom = 0;
			setProperty('flash.alpha', 1);
			doTweenAlpha('flash3','flash',0,1,'linear')
			BeatHPSlow = true;
			BeatFlashSlow = true;
			doTweenAlpha('IconP24','iconP2',1,0.25,'linear')
			doTweenAlpha('IconP14','iconP1',1,0.25,'linear')
			doTweenAlpha('healthBar4','healthBar',1,0.25,'linear')
			doTweenAlpha('healthBarBG4','healthBarBG',1,0.25,'linear')
			doTweenAlpha('scoreTxt4','scoreTxt',0.2,0.25,'linear')
			doTweenAlpha('timeBarBG4','timeBarBG',1,0.25,'linear')
			doTweenAlpha('timeBarBGBG4','timeBarBGBG',1,0.25,'linear')
			doTweenAlpha('timeBar4','timeBar',1,0.25,'linear')
			doTweenAlpha('timeTxt4','timeTxt',1,0.25,'linear')
		end
		if curStep == 1312 then
			zoom = -1;
			BeatHP = true;
			BeatFlash = true;
			BeatHPSlow = false;
			BeatFlashSlow = false;
		end
		if curStep == 1568 then
			doTweenAlpha('cam1','camHUD',0,0.7,'linear')
			doTweenAlpha('bl2','bl',1,0.7,'linear')
			BeatHP = false;
			BeatFlash = false;
		end
	end
	
	if vineboom == true then
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