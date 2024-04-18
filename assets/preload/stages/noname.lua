local xx = 1200;
local yy = 900;
local ofs = 40;
local ofs2 = 40;
local xx2 = 1500;
local yy2 = 900;
local followchars = true;
local dark = false;
local event = false;
local gooogoogaaagaa = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		--P1
		makeLuaSprite('bg', 'bgs/no-name/p1/bg', 0, 0);
		scaleObject('bg', 1.5, 1.5);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);

		makeLuaSprite('border', 'bgs/no-name/p1/border', 0, 0);
		scaleObject('border', 1.5, 1.5);
		setScrollFactor('border', 1, 1);
		setProperty('border.antialiasing', true);
		addLuaSprite('border', false);

		makeAnimatedLuaSprite('ground', 'bgs/no-name/p1/ground', -200, 0);
		scaleObject('ground', 1.5, 1.5);
		addAnimationByPrefix('ground', 'static', 'static', 8, true);
		addAnimationByPrefix('ground', 'anim', 'anim', 8, false);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		objectPlayAnimation('ground', 'static', false)
		addLuaSprite('ground', false);
		
		makeLuaSprite('moon', 'bgs/no-name/p1/moon', 765, 200);
		scaleObject('moon', 1, 1);
		setScrollFactor('moon', 1, 1);
		setProperty('moon.antialiasing', true);
		addLuaSprite('moon', false);
		
		--P2
		makeLuaSprite('bgPT', 'bgs/no-name/p2/bg', -100, 0);
		scaleObject('bgPT', 1.35, 1.35);
		setScrollFactor('bgPT', 1, 1);
		setProperty('bgPT.antialiasing', true);
		addLuaSprite('bgPT', false);
		setProperty('bgPT.alpha',0)

		makeLuaSprite('groundPT', 'bgs/no-name/p2/ground', -100, 0);
		scaleObject('groundPT', 1.35, 1.35);
		setScrollFactor('groundPT', 1, 1);
		setProperty('groundPT.antialiasing', true);
		addLuaSprite('groundPT', false);
		setProperty('groundPT.alpha',0)
	end

	--Shit
	makeAnimatedLuaSprite('static', 'bgs/omw/staticOMW', -500, -500);
	scaleObject('static', 6, 6);
	addAnimationByPrefix('static', 'sshh', 'stat', 24, true);
	setScrollFactor('static', 0, 0);
	setProperty('static.antialiasing', false);
	setProperty('static.alpha',0.0)
	addLuaSprite('static', true);
	
	makeLuaSprite('darkness', '', 0, 0);
	makeGraphic('darkness',1920,1080,'000000')
	addLuaSprite('darkness', true);
	setLuaSpriteScrollFactor('darkness',0,0)
	setProperty('darkness.scale.x',2)
	setProperty('darkness.scale.y',2)
	setProperty('darkness.alpha',0)

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('blackscreen', '', 0, 0);
	makeGraphic('blackscreen',1920,1080,'000000')
	addLuaSprite('blackscreen', true);
	setLuaSpriteScrollFactor('blackscreen',0,0)
	setProperty('blackscreen.scale.x',2)
	setProperty('blackscreen.scale.y',2)
	setProperty('blackscreen.alpha',0)
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "forever-unnamed" then
		if event == true then
			if dark == true then
				yy = 800;
				setProperty('darkness.alpha',0.1)
				setProperty('dad.alpha',1)
				setProperty('boyfriend.alpha',0)
				setProperty('dadGroup.color', getColorFromHex('565656'));
				doTweenZoom('ZOOMDAD', 'camGame',0.6, 0.5, 'quadOut')
				
				if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
					setProperty('bg.alpha',0)
					setProperty('border.alpha',0)
					setProperty('ground.alpha',0)
					setProperty('moon.alpha',0)
					setProperty('groundPT.alpha',1)
					setProperty('bgPT.alpha',1)
				end
				setProperty('static.alpha',0.1)
				
				setProperty('timeBarBG.alpha', 0)
				setProperty('timeBar.alpha', 0)
				setProperty('timeTxt.alpha', 0)
				
				if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
					noteTweenX("DADnote4", 0, 3000, 0.01, cubeInOut)
					noteTweenX("DADnote5", 1, 3000, 0.01, cubeInOut)
					noteTweenX("DADnote6", 2, 3000, 0.01, cubeInOut)
					noteTweenX("DADnote7", 3, 3000, 0.01, cubeInOut)
					
					noteTweenX("BFnote4", 4, 370, 0.01, cubeInOut)
					noteTweenX("BFnote5", 5, 510, 0.01, cubeInOut)
					noteTweenX("BFnote6", 6, 650, 0.01, cubeInOut)
					noteTweenX("BFnote7", 7, 790, 0.01, cubeInOut)
				end
				
				setPropertyFromGroup('playerStrums',0,'alpha',0.6)
				setPropertyFromGroup('playerStrums',1,'alpha',0.6)
				setPropertyFromGroup('playerStrums',2,'alpha',0.6)
				setPropertyFromGroup('playerStrums',3,'alpha',0.6)
			else
				yy = 900;
				setProperty('darkness.alpha',0.5)
				setProperty('dad.alpha',1)
				setProperty('boyfriend.alpha',1)
				setProperty('dadGroup.color', getColorFromHex('FFFFFF'));
				doTweenZoom('ZOOMDAD', 'camGame',0.55, 0.5, 'quadOut')
				
				if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
					objectPlayAnimation('ground', 'static', false)
					setProperty('bg.alpha',1)
					setProperty('border.alpha',1)
					setProperty('ground.alpha',1)
					setProperty('moon.alpha',1)
					setProperty('groundPT.alpha',0)
					setProperty('bgPT.alpha',0)
				end
				setProperty('static.alpha',0.15)
				
				setProperty('timeBarBG.alpha', 1)
				setProperty('timeBar.alpha', 1)
				setProperty('timeTxt.alpha', 1)
				
				if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
					noteTweenX("DADnote0ClassicPos", 0, 93, 0.01, cubeInOut)
					noteTweenX("DADnote1ClassicPos", 1, 205, 0.01, cubeInOut)
					noteTweenX("DADnote2ClassicPos", 2, 317, 0.01, cubeInOut)
					noteTweenX("DADnote3ClassicPos", 3, 429, 0.01, cubeInOut)
				
					noteTweenX("BFnote4ClassicPos", 4, 733, 0.01, cubeInOut)
					noteTweenX("BFnote5ClassicPos", 5, 845, 0.01, cubeInOut)
					noteTweenX("BFnote6ClassicPos", 6, 957, 0.01, cubeInOut)
					noteTweenX("BFnote7ClassicPos", 7, 1069, 0.01, cubeInOut)
				end
				
				setPropertyFromGroup('playerStrums',0,'alpha',1)
				setPropertyFromGroup('playerStrums',1,'alpha',1)
				setPropertyFromGroup('playerStrums',2,'alpha',1)
				setPropertyFromGroup('playerStrums',3,'alpha',1)
			end
		end
		if gooogoogaaagaa == true then
			yy = 900;
			setProperty('darkness.alpha',0.5)
			setProperty('dad.alpha',1)
			setProperty('boyfriend.alpha',1)
			setProperty('dadGroup.color', getColorFromHex('FFFFFF'));
			doTweenZoom('ZOOMDAD', 'camGame',0.55, 0.5, 'quadOut')
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				objectPlayAnimation('ground', 'static', false)
				setProperty('bg.alpha',1)
				setProperty('border.alpha',1)
				setProperty('ground.alpha',1)
				setProperty('moon.alpha',1)
				setProperty('groundPT.alpha',0)
				setProperty('bgPT.alpha',0)
			end
			setProperty('static.alpha',0.15)
			
			setProperty('timeBarBG.alpha', 1)
			setProperty('timeBar.alpha', 1)
			setProperty('timeTxt.alpha', 1)
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				noteTweenX("DADnote0ClassicPos", 0, 93, 0.01, cubeInOut)
				noteTweenX("DADnote1ClassicPos", 1, 205, 0.01, cubeInOut)
				noteTweenX("DADnote2ClassicPos", 2, 317, 0.01, cubeInOut)
				noteTweenX("DADnote3ClassicPos", 3, 429, 0.01, cubeInOut)
				
				noteTweenX("BFnote4ClassicPos", 4, 733, 0.01, cubeInOut)
				noteTweenX("BFnote5ClassicPos", 5, 845, 0.01, cubeInOut)
				noteTweenX("BFnote6ClassicPos", 6, 957, 0.01, cubeInOut)
				noteTweenX("BFnote7ClassicPos", 7, 1069, 0.01, cubeInOut)
			end
			
			setPropertyFromGroup('playerStrums',0,'alpha',1)
			setPropertyFromGroup('playerStrums',1,'alpha',1)
			setPropertyFromGroup('playerStrums',2,'alpha',1)
			setPropertyFromGroup('playerStrums',3,'alpha',1)
		end
	
		if curStep == 0 then
			setProperty('camHUD.alpha',0)
		end
		
		if curStep == 5 then
			gooogoogaaagaa = false;
		end
		
		if curStep == 15 then
			setProperty('scoreTxt.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('healthBarBG.alpha', 0);
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
		end
		
		
		if curStep == 239 then
			doTweenAlpha('camHUD1','camHUD',1,1,'linear')
		end
		
		if curStep == 372 then
			doTweenAlpha('camHUD15','camHUD',0,1,'linear')
		end
		
		if curStep == 492 then
			doTweenAlpha('camHUD16','camHUD',1,1,'linear')
		end
	
		if curStep == 620 or curStep == 1132 then
			event = false;
			objectPlayAnimation('ground', 'anim', false)
			doTweenAlpha('moonT1','moon',0,0.5,'linear')
		end
		
		if curStep == 625 or curStep == 1137 then
			doTweenAlpha('dadT1','dad',0,0.75,'linear')
			doTweenAlpha('bfT1','boyfriend',0,0.75,'linear')
			doTweenAlpha('borderT1','border',0,0.5,'linear')
		end
		
		if curStep == 630 or curStep == 1142 then
			doTweenAlpha('bgT1','bg',0,0.5,'linear')
		end
	
		if curStep == 624 then
			setProperty('scoreTxt.alpha', 0.20);
			setProperty('iconP1.alpha', 0.20);
			setProperty('iconP2.alpha', 0.20);
			setProperty('healthBar.alpha', 0.20);
			setProperty('healthBarBG.alpha', 0.20);
			setProperty('timeBar.alpha', 0.20);
			setProperty('timeBarBG.alpha', 0.20);
			setProperty('timeTxt.alpha', 0.20);
		end
		
		if curStep == 628 then
			setProperty('scoreTxt.alpha', 0.40);
			setProperty('iconP1.alpha', 0.40);
			setProperty('iconP2.alpha', 0.40);
			setProperty('healthBar.alpha', 0.40);
			setProperty('healthBarBG.alpha', 0.40);
			setProperty('timeBar.alpha', 0.40);
			setProperty('timeBarBG.alpha', 0.40);
			setProperty('timeTxt.alpha', 0.40);
		end
		
		if curStep == 632 then
			setProperty('scoreTxt.alpha', 0.50);
			setProperty('iconP1.alpha', 0.60);
			setProperty('iconP2.alpha', 0.60);
			setProperty('healthBar.alpha', 0.60);
			setProperty('healthBarBG.alpha', 0.60);
			setProperty('timeBar.alpha', 0.60);
			setProperty('timeBarBG.alpha', 0.60);
			setProperty('timeTxt.alpha', 0.60);
		end
		
		if curStep == 636 then
			setProperty('scoreTxt.alpha', 0.60);
			setProperty('iconP1.alpha', 0.80);
			setProperty('iconP2.alpha', 0.80);
			setProperty('healthBar.alpha', 0.80);
			setProperty('healthBarBG.alpha', 0.80);
			setProperty('timeBar.alpha', 0.80);
			setProperty('timeBarBG.alpha', 0.80);
			setProperty('timeTxt.alpha', 0.80);
		end
	
		if curStep == 640 then
			event = true;
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1.5,'linear')
			dark = true;
			
			setProperty('scoreTxt.alpha', 0.75);
			setProperty('iconP1.alpha', 1);
			setProperty('iconP2.alpha', 1);
			setProperty('healthBar.alpha', 1);
			setProperty('healthBarBG.alpha', 1);
			setProperty('timeBar.alpha', 1);
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeTxt.alpha', 1);
		end
		
		if curStep == 896 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit2','flashingshit',0,1.5,'linear')
			dark = false;
			
			doTweenAlpha('camHUD2','camHUD',0,1,'linear')
		end
		
		if curStep == 915 then
			setProperty('scoreTxt.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('healthBarBG.alpha', 0);
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
		end
		
		if curStep == 939 then
			doTweenAlpha('camHUD3','camHUD',1,1,'linear')
		end
		
		if curStep == 1024 then
			doTweenAlpha('camHUD13','camHUD',0,1,'linear')
		end
		
		if curStep == 1068 then
			doTweenAlpha('camHUD14','camHUD',1,1,'linear')
		end
		
		if curStep == 1152 then
			doTweenAlpha('camHUD4','camHUD',0,0.25,'linear')
			setProperty('blackscreen.alpha', 1);
		end
	
		if curStep == 1169 then
			event = true;
			setProperty('flashingshit.alpha',1)
			setProperty('blackscreen.alpha', 0);
			doTweenAlpha('flashingshit3','flashingshit',0,1.5,'linear')
			dark = true;
		end
		
		if curStep == 1232 then
			setProperty('scoreTxt.alpha', 0.75);
			setProperty('iconP1.alpha', 1);
			setProperty('iconP2.alpha', 1);
			setProperty('healthBar.alpha', 1);
			setProperty('healthBarBG.alpha', 1);
			setProperty('timeBar.alpha', 1);
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeTxt.alpha', 1);
		end
		
		if curStep == 1259 then
			doTweenAlpha('camHUD5','camHUD',1,1,'linear')
		end
		
		if curStep == 1280 then
			doTweenAlpha('camHUD6','camHUD',0.25,0.8,'linear')
			doTweenAlpha('BS1','blackscreen',1,0.8,'linear')
		end
		
		if curStep == 1296 then
			doTweenAlpha('camHUD7','camHUD',1,0.25,'linear')
			setProperty('blackscreen.alpha', 0);
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit4','flashingshit',0,1.5,'linear')
		end
		
		if curStep == 1408 then
			doTweenAlpha('camHUD8','camHUD',0,1,'linear')
		end
		
		if curStep == 1516 then
			doTweenAlpha('camHUD9','camHUD',1,1,'linear')
		end
		
		if curStep == 1664 then
			doTweenAlpha('camHUD10','camHUD',0,1,'linear')
			doTweenAlpha('BS2','blackscreen',1,1,'linear')
		end
		
		if curStep == 1696 then
			dark = false;
		
			setProperty('scoreTxt.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('healthBarBG.alpha', 0);
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
		end
		
		if curStep == 1712 then
			doTweenAlpha('BS3','blackscreen',0,1,'linear')
		end
		
		if curStep == 1840 then
			doTweenAlpha('camHUD11','camHUD',1,1,'linear')
		end
		
		if curStep == 1920 then
			doTweenAlpha('camHUD12','camHUD',0,1,'linear')
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
            if getProperty('boyfriend.animation.curAnim.name') == 'hey' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
        triggerEvent('Camera Follow Pos','','')
	end
end

function onGameOver()
	gooogoogaaagaa = false;
	event = false;
end

function opponentNoteHit()
	if dark == true then
		health = getProperty('health')
		if getProperty('health') > 0.3 then
			setProperty('health', health- 0.020);
		end
		cameraShake('game', 0.005, 0.05)
	end
	if dark == false then
		health = getProperty('health')
		if getProperty('health') > 0.3 then
			setProperty('health', health- 0.005);
		end
	end
end