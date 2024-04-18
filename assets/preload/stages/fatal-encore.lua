local xx = 250;
local yy = 300;
local ofs = 15;
local ofs2 = 15;
local xx2 = 250;
local yy2 = 300;
local followchars = true;
local mechanicPhase = 0;
local mechanicSpeed = 1;
local mechanicRandomSpeed = false;

function onCreate()
	addHaxeLibrary('FlxColor', 'flixel.util');
	addHaxeLibrary('WinPaths');
	addCharacterToList('bf-fatal-1','bf');
	addCharacterToList('bf-fatal-2','bf');
	addCharacterToList('bf-fatal-final','bf');
	addCharacterToList('fatal sonic','dad');
	addCharacterToList('fatal-error-p2','dad');
	addCharacterToList('fatal-p3','dad');
	addCharacterToList('fatal-final','dad');
	setProperty('FatalEncoreFiles.alpha',1)
	
	makeLuaSprite('darkThing', '', 0, 0);
	makeGraphic('darkThing',1920,1080,'000000')
	addLuaSprite('darkThing', false);
	setScrollFactor('darkThing',0,0)
	setProperty('darkThing.scale.x',4)
	setProperty('darkThing.scale.y',4)
	setProperty('darkThing.alpha',0.8)
	
	makeAnimatedLuaSprite('phaseZerobg', 'bgs/fatal-encore/bg', -350, -67);
	setScrollFactor('phaseZerobg', 1, 1);
	addAnimationByPrefix('phaseZerobg', 'bg dance', 'bg dance', 12, true);
	setProperty('phaseZerobg.antialiasing', false);
	addLuaSprite('phaseZerobg', false);
	scaleObject('phaseZerobg', 3, 3)
	
	makeAnimatedLuaSprite('files', 'bgs/fatal-encore/characters-bg', -1800, -500);
	setScrollFactor('files', 1, 1);
	addAnimationByPrefix('files', 'dance', 'dance', 12, true);
	setProperty('files.antialiasing', false);
	addLuaSprite('files', false);
	scaleObject('files', 6, 6)
	setScrollFactor('files', 0.8, 0.8);
	setProperty('files.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)
	setObjectCamera('flashingshit', 'camHUD')
	
	makeLuaSprite('bg', '', 0, 0);
	makeGraphic('bg',1920,1080,'000000')
	addLuaSprite('bg', true);
	setScrollFactor('bg',0,0)
	setProperty('bg.scale.x',4)
	setProperty('bg.scale.y',4)
	setProperty('bg.alpha',0)

	makeLuaSprite('RSOD', 'bgs/fatal-encore/Error_Screen', 0, 0);
	setProperty('RSOD.scale.x',0.7)
	setProperty('RSOD.scale.y',0.7)
	setScrollFactor('RSOD', 0, 0);
	screenCenter('RSOD');
	setProperty('RSOD.antialiasing', true);
	setProperty('RSOD.alpha', 0);
	addLuaSprite('RSOD', true);
	setObjectCamera('RSOD', 'camOther')

	setProperty('boyfriendGroup.visible',false)
	setProperty('gfGroup.visible',false)
	
	runHaxeCode([[
		var files:Array<String>;
		if (game.UseWindowsDesktopFiles)
			files = WinPaths.getDesktopFileNames(false, false, false, false, false);
		else
			files = game.NonRealDesktopIcons;
		for (i in 0...files.length-1) {
			game.FatalityEncoreMechanic(false, true);
		}
		trace(game.FatalEncoreFileGotCorrupted);
	]])
end

function notePos(pos)
	if pos == 'left' then
		noteTweenX("note0", 0, 752.6, 0.3, quadInOut)
		noteTweenX("note1", 1, 858.8, 0.3, quadInOut)
		noteTweenX("note2", 2, 965, 0.3, quadInOut)
		noteTweenX("note3", 3, 1071.2, 0.3, quadInOut)
			
		noteTweenAlpha('opponentStrumss0',0 ,1 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss1',1 ,1 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss2',2 ,1 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss3',3 ,1 ,0.3, 'linear')
		
		noteTweenX("note4", 4, 102.6, 0.3, cubeInOut)
		noteTweenX("note5", 5, 208.8, 0.3, cubeInOut)
		noteTweenX("note6", 6, 315, 0.3, cubeInOut)
		noteTweenX("note7", 7, 421.2, 0.3, cubeInOut)
		
		noteTweenAlpha('playerStrumss0',4 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss1',5 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss2',6 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss3',7 ,1 ,0.3, 'linear')
	end
	if pos == 'center' then
		noteTweenX("note0", 0, 93, 0.3, quadInOut)
		noteTweenX("note1", 1, 205, 0.3, quadInOut)
		noteTweenX("note2", 2, 957, 0.3, quadInOut)
		noteTweenX("note3", 3, 1069, 0.3, quadInOut)
			
		noteTweenAlpha('opponentStrumss0',0 ,0.5 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss1',1 ,0.5 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss2',2 ,0.5 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss3',3 ,0.5 ,0.3, 'linear')
		
		noteTweenX("note4", 4, 412, 0.3, cubeInOut)
		noteTweenX("note5", 5, 524, 0.3, cubeInOut)
		noteTweenX("note6", 6, 638, 0.3, cubeInOut)
		noteTweenX("note7", 7, 750, 0.3, cubeInOut)
		
		noteTweenAlpha('playerStrumss0',4 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss1',5 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss2',6 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss3',7 ,1 ,0.3, 'linear')
	end
	if pos == 'right' then
		noteTweenX("note0", 0, 102.6, 0.3, quadInOut)
		noteTweenX("note1", 1, 208.8, 0.3, quadInOut)
		noteTweenX("note2", 2, 315, 0.3, quadInOut)
		noteTweenX("note3", 3, 421.2, 0.3, quadInOut)
			
		noteTweenAlpha('opponentStrumss0',0 ,1 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss1',1 ,1 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss2',2 ,1 ,0.3, 'linear')
		noteTweenAlpha('opponentStrumss3',3 ,1 ,0.3, 'linear')
		
		noteTweenX("note4", 4, 752.6, 0.3, cubeInOut)
		noteTweenX("note5", 5, 858.8, 0.3, cubeInOut)
		noteTweenX("note6", 6, 965, 0.3, cubeInOut)
		noteTweenX("note7", 7, 1071.2, 0.3, cubeInOut)
		
		noteTweenAlpha('playerStrumss0',4 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss1',5 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss2',6 ,1 ,0.3, 'linear')
		noteTweenAlpha('playerStrumss3',7 ,1 ,0.3, 'linear')
	end
end

function onBeatHit()
	if mechanicRandomSpeed == true then
		mechanicSpeed = getRandomInt(1, 5);
	end
	if curBeat % 4 and mechanicSpeed == 1 or curBeat % 6 and mechanicSpeed == 2 or curBeat % 4 and mechanicSpeed == 3 or curBeat % 2 and mechanicSpeed == 4 or mechanicSpeed == 5 then
		runHaxeCode([[
			switch (]]..mechanicSpeed..[[) {
				case 1:
					switch(FlxG.random.int(0, 14)) {
						case 9:
							if (]]..mechanicPhase..[[ == 1)
								game.FatalityEncoreMechanic();
							if (]]..mechanicPhase..[[ == 2)
								game.FatalityEncoreMechanic(true);
					}
				case 2:
					switch(FlxG.random.int(0, 3)) {
						case 3:
							if (]]..mechanicPhase..[[ == 1)
								game.FatalityEncoreMechanic();
							if (]]..mechanicPhase..[[ == 2)
								game.FatalityEncoreMechanic(true);
					}
				case 3,4:
					switch(FlxG.random.int(0, 1)) {
						case 0:
							if (]]..mechanicPhase..[[ == 1)
								game.FatalityEncoreMechanic();
							if (]]..mechanicPhase..[[ == 2)
								game.FatalityEncoreMechanic(true);
					}
				case 5:
					if (]]..mechanicPhase..[[ == 1)
						game.FatalityEncoreMechanic();
					if (]]..mechanicPhase..[[ == 2)
						game.FatalityEncoreMechanic(true);
			}
		]])
	end
end

function phaseChange(phase, bgcorr, traycorr)
	if bgcorr == 0 then
		runHaxeCode([[
			game.FatalEncoreFileGotCorrupted = [];
			game.BackgroundPC.setColorTransform(1, 1, 1, 1);
		]])
	end
	if bgcorr == 1 then
		runHaxeCode([[
			game.BackgroundPC.setColorTransform(1, 0, 0, 1);
			game.FatalityEncoreAddCorruptFiles();
		]])
	end
	if bgcorr == 2 then
		runHaxeCode([[
			game.BackgroundPC.setColorTransform(0.50, 0, 0, 1);
			game.FatalEncoreCorruptedFilesALL.forEach(function(spr:FlxSprite) {
				spr.alpha = 1;
			});
			game.FatalEncoreFiles.alpha = 0;
			game.FatalEncoreFilesGlitch.alpha = 0;
		]])
	end
	
	if traycorr == 0 then
		runHaxeCode([[
			game.FatalEncoreTray.setColorTransform(1, 1, 1, 1);
			game.FatalEncoreTrayIcons.setColorTransform(1, 1, 1, 1);
			game.FatalEncoreUsername.color = 0xFFFFFFFF;
			game.FatalEncorePCTime.color = 0xFFFFFFFF;
			game.FatalEncorePCDay.color = 0xFFFFFFFF;
		]])
	end
	if traycorr == 1 then
		runHaxeCode([[
			game.FatalEncoreTray.setColorTransform(1, 0.5, 0.5, 1);
			game.FatalEncoreTrayIcons.setColorTransform(0.85, 0.3, 0.3, 1);
			game.FatalEncoreUsername.color = 0xFFFF424B;
			game.FatalEncorePCTime.color = 0xFFFF424B;
			game.FatalEncorePCDay.color = 0xFFFF424B;
		]])
	end
	if traycorr == 2 then
		runHaxeCode([[
			game.FatalEncoreTray.setColorTransform(1, 0, 0, 1);
			game.FatalEncoreTrayIcons.setColorTransform(1, 0, 0, 1);
			game.FatalEncoreUsername.color = 0xFFFF000C;
			game.FatalEncorePCTime.color = 0xFFFF000C;
			game.FatalEncorePCDay.color = 0xFFFF000C;
		]])
	end

	if phase == -1 then
		runHaxeCode([[
			game.bfIsLeft = true;
			game.iconP1.changeIcon(game.dad.healthIcon);
			game.iconP2.changeIcon(game.boyfriend.healthIcon);
			game.reloadHealthBarColors();
		]])
		setProperty('files.alpha',0)
		setProperty('phaseZerobg.alpha',1)
		setProperty('darkThing.alpha',0.8)
		triggerEvent('Change Character', '0', 'bf-fatal-2');
		triggerEvent('Change Character', '1', 'fatal sonic');
		setProperty('boyfriendGroup.x',0)
		setProperty('boyfriendGroup.y',0)
		setProperty('gfGroup.x',0)
		setProperty('gfGroup.y',0)
		setProperty('boyfriendGroup.visible',false)
		setProperty('gfGroup.visible',false)
		setProperty('dadGroup.x',-340)
		setProperty('dadGroup.y',0)
		setProperty('defaultCamZoom',0.6)	
		notePos('center');
	end
	if phase == 0 then
		runHaxeCode([[
			game.bfIsLeft = true;
			game.iconP1.changeIcon(game.dad.healthIcon);
			game.iconP2.changeIcon(game.boyfriend.healthIcon);
			game.reloadHealthBarColors();
		]])
		setProperty('files.alpha',0)
		setProperty('phaseZerobg.alpha',0)
		setProperty('darkThing.alpha',0)
		triggerEvent('Change Character', '0', 'bf-fatal-1');
		triggerEvent('Change Character', '1', 'fatal-error-p2');
		setProperty('boyfriendGroup.x',0)
		setProperty('boyfriendGroup.y',0)
		setProperty('gfGroup.x',0)
		setProperty('gfGroup.y',0)
		setProperty('boyfriendGroup.visible',true)
		setProperty('gfGroup.visible',true)
		setProperty('dadGroup.x',0)
		setProperty('dadGroup.y',0)
		setProperty('defaultCamZoom',0.4)	
		notePos('left');
	end
	if phase == 1 then
		runHaxeCode([[
			game.bfIsLeft = true;
			game.iconP1.changeIcon(game.dad.healthIcon);
			game.iconP2.changeIcon(game.boyfriend.healthIcon);
			game.reloadHealthBarColors();
		]])
		setProperty('files.alpha',0)
		setProperty('phaseZerobg.alpha',0)
		setProperty('darkThing.alpha',0)
		triggerEvent('Change Character', '0', 'bf-fatal-2');
		triggerEvent('Change Character', '1', 'fatal-p3');
		setProperty('boyfriendGroup.x',400)
		setProperty('boyfriendGroup.y',200)
		setProperty('gfGroup.x',-400)
		setProperty('gfGroup.y',100)
		setProperty('boyfriendGroup.visible',true)
		setProperty('gfGroup.visible',true)
		setProperty('dadGroup.x',-230)
		setProperty('dadGroup.y',100)
		setProperty('defaultCamZoom',0.45)
		notePos('center');
	end
	if phase == 2 then
		runHaxeCode([[
			game.bfIsLeft = false;
			game.iconP1.changeIcon(game.boyfriend.healthIcon);
			game.iconP2.changeIcon(game.dad.healthIcon);
			game.reloadHealthBarColors();
		]])
		setProperty('files.alpha',1)
		setProperty('phaseZerobg.alpha',0)
		setProperty('darkThing.alpha',0)
		triggerEvent('Change Character', '0', 'bf-fatal-final');
		triggerEvent('Change Character', '1', 'fatal-final');
		setProperty('boyfriendGroup.x',400)
		setProperty('boyfriendGroup.y',0)
		setProperty('gfGroup.x',600)
		setProperty('gfGroup.y',100)
		setProperty('boyfriendGroup.visible',true)
		setProperty('gfGroup.visible',true)
		setProperty('dadGroup.x',-200)
		setProperty('dadGroup.y',100)
		setProperty('defaultCamZoom',0.5)
		notePos('right');
	end
end
function flash(color, alpha, time)
	cancelTween('flash');
	if color == 'red' then
		setProperty('flashingshit.color', getColorFromHex('FF0000'))
	else
		setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
	end
	setProperty('flashingshit.alpha',alpha)
	doTweenAlpha('flash','flashingshit',0,time,'linear')
end

function onUpdate()
	if songName == "fatality-encore" then
		if curStep == 12 then
			notePos('center');
		end
		if curStep == 256 then
			phaseChange(0, 0, 0);
			flash('red', 1, 1);
			mechanicPhase = 1;
		end
		if curStep == 1152 then
			flash('red', 1, 1);
			phaseChange(1, 1, 1);
			mechanicSpeed = 3;
		end
		if curStep == 1600 then
			mechanicSpeed = 4;
		end
		if curStep == 1728 then
			flash('red', 1, 1);
			phaseChange(0, -1, 1);
		end
		if curStep == 2224 then
			mechanicPhase = 0;
			doTweenAlpha('camHUD','camHUD',0,0.25,'linear')
			doTweenAlpha('bg','bg',1,0.25,'linear')
		end
		if curStep == 2230 then
			phaseChange(2, 2, 2);
			mechanicPhase = 2;
			mechanicRandomSpeed = true;
		end
		if curStep == 2240 then
			setProperty('bg.alpha',0)
			doTweenAlpha('camHUD','camHUD',1,0.25,'linear')
			flash('red', 1, 1);
		end
		if curStep == 2528 then
			mechanicPhase = 0;
			doTweenAlpha('camHUDtw','camHUD',0,1.5,'linear')
			doTweenAlpha('bg','bg',1,1.5,'linear')
		end
		if curStep == 2592 then
			setProperty('RSOD.alpha',1)
			playSound('error', 0.8);
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