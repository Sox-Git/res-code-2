local xx = 900;
local yy = 600;
local ofs = 50;
local ofs2 = 50;
local xx2 = 900;
local yy2 = 1100;
local followchars = true;
local beat = 0;
local zoom = 1;
local BoppingRedVG = false;

function onSongStart()
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		noteTweenX("note4", 4, 370, 0.25, cubeInOut)
		noteTweenX("note5", 5, 510, 0.25, cubeInOut)
		noteTweenX("note6", 6, 650, 0.25, cubeInOut)
		noteTweenX("note7", 7, 790, 0.25, cubeInOut)
	end
end
function onCreate()
	addHaxeLibrary('PauseSubState');
	
	makeLuaSprite('bg', 'bgs/judgement/bg', -2200, -1700);
	scaleObject('bg', 1, 1);
	setScrollFactor('bg', 1, 1);
	scaleObject('bg', 2, 2);
	setProperty('bg.antialiasing', true);
	addLuaSprite('bg', false);
	
	makeLuaSprite('bgFloatingCenter', 'bgs/judgement/floating-1', -2200, -1600);
	scaleObject('bgFloatingCenter', 1, 1);
	setScrollFactor('bgFloatingCenter', 0.5, 0.5);
	scaleObject('bgFloatingCenter', 2, 2);
	setProperty('bgFloatingCenter.antialiasing', true);
	addLuaSprite('bgFloatingCenter', false);
	
	makeLuaSprite('bgFloatingLeft', 'bgs/judgement/floating-2', -2200, -1600);
	scaleObject('bgFloatingLeft', 1, 1);
	setScrollFactor('bgFloatingLeft', 0.5, 0.5);
	scaleObject('bgFloatingLeft', 2, 2);
	setProperty('bgFloatingLeft.antialiasing', true);
	addLuaSprite('bgFloatingLeft', false);
	
	makeLuaSprite('bgFloatingRight', 'bgs/judgement/floating-2', -2200, -1350);
	scaleObject('bgFloatingRight', 1, 1);
	setScrollFactor('bgFloatingRight', 0.5, 0.5);
	scaleObject('bgFloatingRight', 2, 2);
	setProperty('bgFloatingRight.antialiasing', true);
	setProperty('bgFloatingRight.flipX', true);
	addLuaSprite('bgFloatingRight', false);
	
	makeLuaSprite('ground', 'bgs/judgement/ground', -2200, -1700);
	scaleObject('ground', 1, 1);
	setScrollFactor('ground', 1, 1);
	scaleObject('ground', 2, 2);
	setProperty('ground.antialiasing', true);
	addLuaSprite('ground', false);

	makeLuaSprite('fg', 'bgs/judgement/cool-thing', -2200, -1700);
	scaleObject('fg', 1, 1);
	setScrollFactor('fg', 0.7, 0.7);
	scaleObject('fg', 2, 2);
	setProperty('fg.antialiasing', true);
	addLuaSprite('fg', true);
	
	makeLuaSprite('vg', 'bgs/judgement/vg', -2200, -1700);
	scaleObject('vg', 1, 1);
	setScrollFactor('vg', 1, 1);
	scaleObject('vg', 2, 2);
	setProperty('vg.antialiasing', true);
	addLuaSprite('vg', true);
	
	makeLuaSprite('redVG', 'RedVG', 0, 0, 'exe');
	setScrollFactor('redVG', 0, 0);
	setProperty('redVG.antialiasing', true);
	setProperty('redVG.alpha', 0);
	addLuaSprite('redVG', true);
	setObjectCamera('redVG', 'camHUD');
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',1)
	setObjectCamera('blk', 'camHUD')

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	setObjectCamera('flashingshit', 'camHUD')
	
	runTimer('flyLeft-Down', 0.1, 1)
	runTimer('flyCenter-Down', 0.6, 1)
	runTimer('flyRight-Down', 0.1, 1)
end

function onTimerCompleted(tag)
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		if tag == 'flyLeft-Down' then
			doTweenY('LTweenDown', 'bgFloatingLeft', -1450, 2.5, 'quadInOut')
			runTimer('flyLeft-Up', 2.5, 1)
		end
		if tag == 'flyLeft-Up' then
			doTweenY('LTweenUp', 'bgFloatingLeft', -1600, 2.0, 'quadInOut')
			runTimer('flyLeft-Down', 2.0, 1)
		end
		
		if tag == 'flyCenter-Down' then
			doTweenY('CTweenDown', 'bgFloatingCenter', -1450, 2.5, 'quadInOut')
			runTimer('flyCenter-Up', 2.5, 1)
		end
		if tag == 'flyCenter-Up' then
			doTweenY('CTweenUp', 'bgFloatingCenter', -1600, 2.0, 'quadInOut')
			runTimer('flyCenter-Down', 2.0, 1)
		end
		
		if tag == 'flyRight-Down' then
			doTweenY('RTweenDown', 'bgFloatingRight', -1350, 2.5, 'quadInOut')
			runTimer('flyRight-Up', 2.5, 1)
		end
		if tag == 'flyRight-Up' then
			doTweenY('RTweenUp', 'bgFloatingRight', -1200, 2.0, 'quadInOut')
			runTimer('flyRight-Down', 2.0, 1)
		end
	end
end
function opponentNoteHit()
	cameraShake('hud', 0.002, 0.15)
	cameraShake('game', 0.01, 0.30)
end		
function onBeatHit()
	if beat == 1 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 2 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		else
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 3 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 4 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
		else
			triggerEvent('Add Camera Zoom')
		end
	end
	if BoppingRedVG == true then
		cancelTween('redvgtween');
		setProperty('redVG.alpha',0.5)
		doTweenAlpha('redvgtween','redVG',0,0.7,'linear')
	end
end
function onStepHit()
	if beat == 5 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 6 then
		triggerEvent('Add Camera Zoom')
	end
end
function onUpdate(elapsed)
	if zoom == 1 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.225)
		else
			setProperty('defaultCamZoom',0.3)
		end
	end
	if zoom == 2 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.27)
		else
			setProperty('defaultCamZoom',0.34)
		end
	end
	runHaxeCode([[
		game.iconP1.changeIcon('bf');
	]])
	if songName == "judgement" then
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
		if curStep == 20 then
			setProperty('camHUD.alpha',1)
		end
		if curStep == 66 then
			doTweenAlpha('black', 'blk', 0, 1.5, 'linear') 
			noteTweenAlpha('playerrStrums0',4 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums1',5 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums2',6 ,0.4 ,1, 'linear')
			noteTweenAlpha('playerrStrums3',7 ,0.4 ,1, 'linear')
		end
		if curStep == 208 then
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
		end
		if curStep == 144 then
			beat = 3;
		end
		if curStep == 192 then
			beat = 4;
		end
		if curStep == 202 then
			beat = 0;
		end
		if curStep == 208 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 1;
		end
		if curStep == 456 then
			doTweenAlpha('blk','blk',0.9,0.65,'linear')
		end
		if curStep == 464 then
			doTweenAlpha('blk','blk',0,0.5,'linear')
			zoom = 2;
			beat = 4;
		end
		if curStep == 585 then
			zoom = 1;
			beat = 0;
		end
		if curStep == 592 then
			zoom = 2;
			beat = 4;
		end
		if curStep == 688 then
			beat = 5;
		end
		if curStep == 704 then
			beat = 6;
		end
		if curStep == 713 then
			beat = 0;
		end
		if curStep == 716 then
			beat = 0;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('000000'))
			setProperty('flashingshit.alpha',1)
		end
		if curStep == 720 then
			zoom = 1;
			beat = 3;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 848 then
			zoom = 2;
			beat = 1;
		end
		if curStep == 944 then
			beat = 4;
		end
		if curStep == 976 then
			BoppingRedVG = true;
			zoom = 1;
		end
		if curStep == 1224 then
			zoom = 2;
			beat = 2;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.6,'linear')
		end
		if curStep == 1228 then
			zoom = 2;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.6,'linear')
		end
		if curStep == 1232 then
			BoppingRedVG = false;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 4;
			zoom = 1;
		end
		if curStep == 1360 then
			beat = 0;
			zoom = 2;
		end
		if curStep == 1484 then
			cancelTween('flsh');
			triggerEvent('Add Camera Zoom')
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('flsh','flashingshit',0,0.6,'linear')
		end
		if curStep == 1488 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('camHUD','camHUD',0,2,'linear')
			doTweenAlpha('sddf', 'blk', 1, 3, 'linear') 
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