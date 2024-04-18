local xx = 600;
local yy = 300;
local ofs = 25;
local ofs2 = 25;
local xx2 = 1000;
local yy2 = 400;
local followchars = true;
local zoom = 0;
local funny = false;
local funnyyyy = false;
local funnyaoao = 0;
local marauderMoment = false;
local FunnyArrows = false;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeAnimatedLuaSprite('sun', 'bgs/dng/sunset', -650, -450);
		scaleObject('sun', 1, 1);
		addAnimationByPrefix('sun', 'anim', 'anim', 8, false);
		setScrollFactor('sun', 0.35, 0.35);
		setProperty('sun.antialiasing', true);
		addLuaSprite('sun', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('bbg', 'bgs/dng/bbg', -650, -600);
			scaleObject('bbg', 1.5, 1.5);
			setScrollFactor('bbg', 0.6, 0.6);
			setProperty('bbg.antialiasing', true);
			addLuaSprite('bbg', false)
		end
		
		makeLuaSprite('bg', 'bgs/dng/bg', -650, -600);
		scaleObject('bg', 1.5, 1.5);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false)
	end
	
	if songName == "haze" then
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
			makeLuaSprite('lightGround', 'bgs/dng/light-ground', 750, -550);
			scaleObject('lightGround', 1, 1);
			setScrollFactor('lightGround', 1, 1);
			setProperty('lightGround.antialiasing', true);
			addLuaSprite('lightGround', false)
			
			makeLuaSprite('light', 'bgs/dng/light', 750, -925);
			scaleObject('light', 1, 1.3);
			setScrollFactor('light', 1, 1);
			setProperty('light.antialiasing', true);
			addLuaSprite('light', true)
			
			makeLuaSprite('lightBF', 'bgs/dng/light', 750, -925);
			scaleObject('lightBF', 1, 1.3);
			setScrollFactor('lightBF', 1, 1);
			setProperty('lightBF.antialiasing', true);
			addLuaSprite('lightBF', false)
			
			makeLuaSprite('lightGroundDad', 'bgs/dng/light-ground', -1000, -925);
			scaleObject('lightGroundDad', 2, 1.3);
			setScrollFactor('lightGroundDad', 1, 1);
			setProperty('lightGroundDad.antialiasing', true);
			addLuaSprite('lightGroundDad', false)
			
			makeLuaSprite('lightDad', 'bgs/dng/light', -1000, -1800);
			scaleObject('lightDad', 2, 2);
			setScrollFactor('lightDad', 1, 1);
			setProperty('lightDad.antialiasing', true);
			addLuaSprite('lightDad', false)
		
			setProperty('lightBF.alpha', 0);
			setProperty('lightGroundDad.alpha', 0);
			setProperty('lightDad.alpha', 0);
		end
		setProperty('camHUD.alpha', 0);
	end
	
	if songName == "marauder" then
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
			makeLuaSprite('lightGround', 'bgs/dng/light-ground', 750, -600);
			scaleObject('lightGround', 1, 1);
			setScrollFactor('lightGround', 1, 1);
			setProperty('lightGround.antialiasing', true);
			addLuaSprite('lightGround', false)
			
			makeLuaSprite('light', 'bgs/dng/light', 750, -975);
			scaleObject('light', 1, 1.3);
			setScrollFactor('light', 1, 1);
			setProperty('light.antialiasing', true);
			addLuaSprite('light', false)
			
			makeLuaSprite('lightGroundDad', 'bgs/dng/light-ground', 0, -600);
			scaleObject('lightGroundDad', 1, 1);
			setScrollFactor('lightGroundDad', 1, 1);
			setProperty('lightGroundDad.antialiasing', true);
			addLuaSprite('lightGroundDad', false)
			
			makeLuaSprite('lightDad', 'bgs/dng/light', 0, -975);
			scaleObject('lightDad', 1, 1.3);
			setScrollFactor('lightDad', 1, 1);
			setProperty('lightDad.antialiasing', true);
			addLuaSprite('lightDad', false)
			
			setProperty('lightGround.alpha', 0);
			setProperty('light.alpha', 0);
			setProperty('lightGroundDad.alpha', 0);
			setProperty('lightDad.alpha', 0);
		end
	end
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('sun', 'anim', false)
		end
	end
	if funny == true then
		if curBeat % 2 == 0 then
			setProperty('camGame.angle',-0.7)
			doTweenAngle('rotateGame1', 'camGame',0, 0.15, 'quadOut')
			setProperty('camHUD.y',-5)
			doTweenY('xHud1','camHUD',0,0.15,'linear')
		else
			if curBeat % 1 == 0 then
				setProperty('camGame.angle',0.7)
				doTweenAngle('rotate2', 'camGame',0, 0.15, 'quadOut')
				setProperty('camHUD.y',5)
				doTweenY('xHud1','camHUD',0,0.15,'linear')
			end
		end
	end
	if funnyyyy == true then
		if curBeat % 2 == 0 then
			setProperty('iconP2.angle', -8);
			doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

			setProperty('iconP1.angle', -8);
			doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
		else
			if curBeat % 1 == 0 then
				setProperty('iconP2.angle', 8);
				doTweenAngle('bip', 'iconP2', 0,0.2,'cubicOut');

				setProperty('iconP1.angle', 8);
				doTweenAngle('bop', 'iconP1', 0,0.2,'cubicOut');
			end
		end
	end
	if funnyaoao == 2 then
		if curBeat % 2 == 0 then
			if zoom == 1 then
				if mustHitSection == false then
					setProperty('camGame.zoom', 0.56)
					doTweenZoom('Zoom1DadCamOut1','camGame',0.55,0.1,'quadInOut')
				else
					setProperty('camGame.zoom', 0.61)
					doTweenZoom('Zoom1DadCamOut2','camGame',0.60,0.1,'quadInOut')
				end
			end
			if zoom == 2 then
				setProperty('camGame.zoom', 0.56)
				doTweenZoom('Zoom2DadCamOut','camGame',0.55,0.1,'quadInOut')
			end
			if zoom == 3 then
				setProperty('camGame.zoom', 0.61)
				doTweenZoom('Zoom3DadCamOut','camGame',0.60,0.1,'quadInOut')
			end
			if zoom == 4 then
				setProperty('camGame.zoom', 0.66)
				doTweenZoom('Zoom4DadCamOut','camGame',0.65,0.1,'quadInOut')
			end
		end
	end
	if funnyaoao == 3 then
		if curBeat % 1 == 0 then
			if zoom == 1 then
				if mustHitSection == false then
					setProperty('camGame.zoom', 0.56)
					doTweenZoom('Zoom1DadCamOut1','camGame',0.55,0.1,'quadInOut')
				else
					setProperty('camGame.zoom', 0.61)
					doTweenZoom('Zoom1DadCamOut2','camGame',0.60,0.1,'quadInOut')
				end
			end
			if zoom == 2 then
				setProperty('camGame.zoom', 0.56)
				doTweenZoom('Zoom2DadCamOut','camGame',0.55,0.1,'quadInOut')
			end
			if zoom == 3 then
				setProperty('camGame.zoom', 0.61)
				doTweenZoom('Zoom3DadCamOut','camGame',0.60,0.1,'quadInOut')
			end
			if zoom == 4 then
				setProperty('camGame.zoom', 0.66)
				doTweenZoom('Zoom4DadCamOut','camGame',0.65,0.1,'quadInOut')
			end
		end
	end
end

function onStepHit()
	if funnyaoao == 1 and songName == "insidious" then
		setProperty('camGame.zoom', 0.61)
	end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if marauderMoment == true then
		if zoom == 1 then
			if mustHitSection == false then
				doTweenZoom('ZOOMDAD', 'camGame',0.55, 1.0, 'quadOut')
			else
				doTweenZoom('ZOOMDAD', 'camGame',0.60, 1.0, 'quadOut')
			end
		end
		if zoom == 2 then
			doTweenZoom('ZOOMDAD', 'camGame',0.55, 1.0, 'quadOut')
		end
		if zoom == 3 then
			doTweenZoom('ZOOMDAD', 'camGame',0.60, 1.0, 'quadOut')
		end
		if zoom == 4 then
			doTweenZoom('ZOOMDAD', 'camGame',0.65, 1.0, 'quadOut')
		end
		if zoom == 5 then
			doTweenZoom('ZOOMDAD', 'camGame',0.75, 0.5, 'quadOut')
		end
	else
		if zoom == 1 then
			doTweenZoom('ZOOMDAD', 'camGame',0.95, 0.5, 'quadOut')
		end
		if zoom == 2 then
			doTweenZoom('ZOOMDAD', 'camGame',0.55, 0.5, 'quadOut')
		end
		if zoom == 3 then
			doTweenZoom('ZOOMDAD', 'camGame',0.65, 0.5, 'quadOut')
		end
		if zoom == 4 then
			doTweenZoom('ZOOMDAD', 'camGame',0.60, 0.5, 'quadOut')
		end
	end
	
	if FunnyArrows == true then
        if mustHitSection == false then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
				setPropertyFromGroup('opponentStrums',0,'y',35)
				noteTweenY("OppMove0", 0, 50, 0.05, 'quadInOut')
            end  
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
				setPropertyFromGroup('opponentStrums',3,'y',35)
				noteTweenY("OppMove3", 3, 50, 0.05, 'quadInOut')
            end
			if getProperty('dad.animation.curAnim.name') == 'singUP' then
				setPropertyFromGroup('opponentStrums',2,'y',35)
				noteTweenY("OppMove2", 2, 50, 0.05, 'quadInOut')
            end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
				setPropertyFromGroup('opponentStrums',1,'y',35)
				noteTweenY("OppMove1", 1, 50, 0.05, 'quadInOut')
            end
        else
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
				setPropertyFromGroup('playerStrums',0,'y',35)
				noteTweenY("PlMove0", 4, 50, 0.05, 'quadInOut')
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
				setPropertyFromGroup('playerStrums',3,'y',35)
				noteTweenY("PlMove3", 7, 50, 0.05, 'quadInOut')
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
				setPropertyFromGroup('playerStrums',2,'y',35)
				noteTweenY("PlMove2", 6, 50, 0.05, 'quadInOut')
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
				setPropertyFromGroup('playerStrums',1,'y',35)
				noteTweenY("PlMove1", 5, 50, 0.05, 'quadInOut')
            end
        end
	end
	
	if songName == "insidious" then
		setProperty('gf.alpha', 0);
		FunnyArrows = true;
	
		if curStep == 0 then
			xx = 600;
			yy = 300;
			ofs = 40;
			ofs2 = 40;
			xx2 = 900;
			yy2 = 300;
			zoom = 4;
		end
		if curStep == 16 then
			funny = true;
			funnyyyy = true;
		end
		if curStep == 520 then
			doTweenAlpha('Black0','blk',1,0.7,'linear')
		end
		if curStep == 528 then
			setProperty('blk.alpha', 0);
			zoom = 4;
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash1','flashingshit',0,1.0,'linear')
			funnyaoao = 1;
		end
		if curStep == 592 then
			funny = false;
			funnyyyy = false;
			funnyaoao = 0;
		end
		if curStep == 596 then
			funny = true;
			funnyaoao = 1;
		end
		if curStep == 784 then
			zoom = 3;
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('flash2','flashingshit',0,1.0,'linear')
			funnyaoao = 0;
		end
		if curStep == 902 then
			doTweenAlpha('Black1','blk',1,0.2,'linear')
		end
		if curStep == 903 then
			funny = false;
			funnyyyy = false;
			funnyaoao = 0;
		end
		if curStep == 904 or curStep == 906 then
			setProperty('blk.alpha', 0);
		end
		if curStep == 905 or curStep == 907 then
			setProperty('blk.alpha', 1);
		end
		if curStep == 908 then
			setProperty('blk.alpha', 0);
			doTweenAlpha('Black2','blk',1,0.25,'linear')
		end
		if curStep == 910 then
			doTweenAlpha('Black3','blk',0,0.28,'linear')
		end
		if curStep == 912 then
			funnyyyy = true;
		end
		if curStep == 1040 then
			funnyyyy = false;
			doTweenAlpha('Black4','blk',1,0.3,'linear')
			doTweenAlpha('camHudInvisible','camHUD',0,0.3,'linear')
		end
	end
	
	if songName == "haze" then
		setProperty('gf.alpha', 0);
		if curStep == 0 then
			setProperty('blk.alpha',1)
			zoom = 1;
			xx = 1400;
			yy = 400;
			ofs = 25;
			ofs2 = 25;
			xx2 = 1400;
			yy2 = 400;
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sun.alpha', 0);
				setProperty('bg.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bbg.alpha', 0);
					setProperty('lightGround.alpha', 0.8);
					setProperty('light.alpha', 0.10);
				end
			end
			
			setProperty('boyfriendGroup.alpha', 0.3);
			setProperty('dadGroup.alpha', 0);
			
			setProperty('scoreTxt.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('healthBarBG.alpha', 0);
		end
		
		if curStep == 5 then
			doTweenAlpha('camHUDTween','camHUD',1,0.25,'linear')
			doTweenAlpha('blkTween','blk',0,0.4,'linear')
			
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeBarBGBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			
			noteTweenAlpha('ON1','0',0,0.01,'linear');
			noteTweenAlpha('ON2','1',0,0.01,'linear');
			noteTweenAlpha('ON3','2',0,0.01,'linear');
			noteTweenAlpha('ON4','3',0,0.01,'linear');
		end
		
		if curStep == 204 then
			doTweenAlpha('bfTween1','boyfriend',0.35,1,'linear')
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('LGTween1','lightGround',0.85,1,'linear')
				doTweenAlpha('LTween1','light',0.125,1,'linear')
			end
		end
		
		if curStep == 288 then
			doTweenAlpha('bfTween2','boyfriend',0.40,1,'linear')
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('LGTween2','lightGround',0.90,1,'linear')
				doTweenAlpha('LTween2','light',0.15,1,'linear')
			end
		end
		
		if curStep == 372 then
			doTweenAlpha('bfTween2','boyfriend',0,0.5,'linear')
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('LGTween3','lightGround',0,0.5,'linear')
				doTweenAlpha('LTween3','light',0,0.5,'linear')
			end
		
			noteTweenAlpha('PN1','4',0,0.5,'linear');
			noteTweenAlpha('PN2','5',0,0.5,'linear');
			noteTweenAlpha('PN3','6',0,0.5,'linear');
			noteTweenAlpha('PN4','7',0,0.5,'linear');
		end
		
		if curStep == 385 then
			setProperty('blk.alpha', 1);
			setProperty('camHUD.alpha', 0);
			
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sun.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bbg.alpha', 1);
				end
				setProperty('bg.alpha', 1);
			end
			
			setProperty('boyfriend.alpha', 1);
			setProperty('dad.alpha', 1);
			
			setProperty('scoreTxt.alpha', 1);
			setProperty('iconP1.alpha', 1);
			setProperty('iconP2.alpha', 1);
			setProperty('healthBar.alpha', 1);
			setProperty('healthBarBG.alpha', 1);
			setProperty('timeBar.alpha', 1);
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeBarBGBG.alpha', 1);
			setProperty('timeTxt.alpha', 1);
			
			noteTweenAlpha('1ON1','0',1,0.01,'linear');
			noteTweenAlpha('2ON2','1',1,0.01,'linear');
			noteTweenAlpha('3ON3','2',1,0.01,'linear');
			noteTweenAlpha('4ON4','3',1,0.01,'linear');
			
			noteTweenAlpha('1PN1','4',1,0.01,'linear');
			noteTweenAlpha('2PN2','5',1,0.01,'linear');
			noteTweenAlpha('3PN3','6',1,0.01,'linear');
			noteTweenAlpha('4PN4','7',1,0.01,'linear');
		end
		
		if curStep == 400 then
			zoom = 2;
			xx = 600;
			yy = 200;
			ofs = 40;
			ofs2 = 40;
			xx2 = 1000;
			yy2 = 300;
			setProperty('blk.alpha', 0);
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
		end
		
		if curStep == 448 then
			doTweenAlpha('camHUDTween1','camHUD',1,1.0,'linear')
		end
		
		if curStep == 912 then
			doTweenAlpha('camHUDTween2','camHUD',0,1.0,'linear')
			doTweenAlpha('blkTween1','blk',1,1.0,'linear')
		end
		
		if curStep == 929 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sun.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bbg.alpha', 0);
					setProperty('lightGround.alpha', 0.8);
					setProperty('lightBF.alpha', 0.10);
					setProperty('lightGroundDad.alpha', 0.8);
					setProperty('lightDad.alpha', 0.10);
				end
				setProperty('bg.alpha', 0);
			end
			
			setProperty('dadGroup.color', 0xFFFFFFFF);
			setProperty('boyfriendGroup.color', 0xFFFFFFFF);
			
			setProperty('scoreTxt.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('healthBarBG.alpha', 0);
			
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeBarBGBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			
			noteTweenAlpha('O1','0',0.3,0.01,'linear');
			noteTweenAlpha('O2','1',0.3,0.01,'linear');
			noteTweenAlpha('O3','2',0.3,0.01,'linear');
			noteTweenAlpha('O4','3',0.3,0.01,'linear');
			
			noteTweenAlpha('P1','4',0.3,0.01,'linear');
			noteTweenAlpha('P2','5',0.3,0.01,'linear');
			noteTweenAlpha('P3','6',0.3,0.01,'linear');
			noteTweenAlpha('P4','7',0.3,0.01,'linear');
		end
		
		if curStep == 944 then
			doTweenAlpha('camHUDTween3','camHUD',1,0.5,'linear')
			doTweenAlpha('blkTween2','blk',0,0.5,'linear')
		end
		
		if curStep == 1200 then
			doTweenAlpha('camHUDTween4','camHUD',0,1.0,'linear')
			doTweenAlpha('blkTween3','blk',1,1.0,'linear')
		end
		
		if curStep == 1216 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sun.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bbg.alpha', 1);
					setProperty('lightGround.alpha', 0);
					setProperty('lightBF.alpha', 0);
					setProperty('lightGroundDad.alpha', 0);
					setProperty('lightDad.alpha', 0);
				end
				setProperty('bg.alpha', 1);
			end
			
			setProperty('dadGroup.color', 0xFFFFFF);
			setProperty('boyfriendGroup.color', 0xFFFFFF);
			
			setProperty('scoreTxt.alpha', 1);
			setProperty('iconP1.alpha', 1);
			setProperty('iconP2.alpha', 1);
			setProperty('healthBar.alpha', 1);
			setProperty('healthBarBG.alpha', 1);
			
			setProperty('timeBar.alpha', 1);
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeBarBGBG.alpha', 1);
			setProperty('timeTxt.alpha', 1);
			
			noteTweenAlpha('O11','0',1,0.01,'linear');
			noteTweenAlpha('O22','1',1,0.01,'linear');
			noteTweenAlpha('O33','2',1,0.01,'linear');
			noteTweenAlpha('O44','3',1,0.01,'linear');
			
			noteTweenAlpha('P11','4',1,0.01,'linear');
			noteTweenAlpha('P22','5',1,0.01,'linear');
			noteTweenAlpha('P33','6',1,0.01,'linear');
			noteTweenAlpha('P44','7',1,0.01,'linear');
		end
		
		if curStep == 1232 then
			setProperty('blk.alpha', 0);
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
		end
		
		if curStep == 1344 then
			doTweenAlpha('camHUDTween5','camHUD',1,1.5,'linear')
		end
		
		if curStep == 2056 then
			doTweenAlpha('camHUDTween5','camHUD',0,1,'linear')
		end
	end
	
	if songName == "marauder" then
		if curStep == 0 then
			setProperty('gf.x', -150);
			setProperty('gf.y', -600);
			setProperty('dad.x', 400);
			xx = 600;
			yy = 200;
			ofs = 25;
			ofs2 = 25;
			xx2 = 1000;
			yy2 = 300;
			marauderMoment = true;
			zoom = 1;
		end
		if curStep == 64 then
			marauderMoment = false;
			zoom = 2;
		end
		if curStep == 188 then
			doTweenAlpha('blkTween1','blk',1,1.5,'linear')
			doTweenAlpha('camHUDTween1','camHUD',0,1.5,'linear')
		end
		if curStep == 208 then
			zoom = 4;
			funnyaoao = 3;
			setProperty('blk.alpha', 0);
			doTweenAlpha('camHUDTween2','camHUD',1,0.25,'linear')
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang1','flashingshit',0,1.0,'linear')
			funny = true;
			funnyyyy = true;
			FunnyArrows = true;
		end
		if curStep == 336 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang2','flashingshit',0,1.0,'linear')
		end
		if curStep == 464 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang3','flashingshit',0,1.0,'linear')
			funny = false;
			funnyyyy = false;
			zoom = 2;
			funnyaoao = 2;
			FunnyArrows = false;
		end
		if curStep == 584 or curStep == 586 or curStep == 588 or curStep == 589 or curStep == 591 then
			setProperty('camGame.zoom', 0.56)
			doTweenZoom('DadCamOut','camGame',0.55,0.1,'quadInOut')
		end
		if curStep == 592 then
			zoom = 4;
			funnyaoao = 3;
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang4','flashingshit',0,1.0,'linear')
			funny = true;
			funnyyyy = true;
			FunnyArrows = true;
		end
		if curStep == 718 then
			funny = false;
			funnyyyy = false;
			FunnyArrows = false;
			funnyaoao = 0;
		end
		if curStep == 720 then
			doTweenAlpha('blkTween2','blk',1,2,'linear')
			doTweenAlpha('camHUDTween3','camHUD',0,3,'linear')
		end
		if curStep == 752 then
			setProperty('blk.alpha', 0);
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang5','flashingshit',0,1.0,'linear')
			zoom = 1;
			marauderMoment = true;
		end
		if curStep == 807 then
			doTweenAlpha('camHUDTween4','camHUD',1,1,'linear')
		end
		if curStep == 812 or curStep == 844 or curStep == 852 or curStep == 860 or curStep == 866 or curStep == 870 or curStep == 872 or curStep == 875 or curStep == 876 or curStep == 878 or curStep == 879 or curStep == 882 or curStep == 886 or curStep == 890 or curStep == 894 or curStep == 898 or curStep == 902 or curStep == 906 or curStep == 910 or curStep == 914 or curStep == 918 or curStep == 922 or curStep == 926 or curStep == 930 or curStep == 934 or curStep == 938 or curStep == 942 or curStep == 946 or curStep == 950 or curStep == 954 or curStep == 958 or curStep == 962 or curStep == 966 or curStep == 970 or curStep == 974 or curStep == 978 or curStep == 982 or curStep == 986 or curStep == 990 or curStep == 994 or curStep == 998 or curStep == 1002 or curStep == 1006 then
			if mustHitSection == false then
				setProperty('camGame.zoom', 0.56)
				doTweenZoom('DadCamOut1','camGame',0.55,0.1,'quadInOut')
			else
				setProperty('camGame.zoom', 0.61)
				doTweenZoom('DadCamOut2','camGame',0.60,0.1,'quadInOut')
			end
		end
		if curStep == 880 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang5','flashingshit',0,1.0,'linear')
		end
		if curStep == 1004 then
			doTweenAlpha('blkTween3','blk',1,0.16,'linear')
			doTweenAlpha('camHUDTween5','camHUD',0,0.2,'linear')
		end
		if curStep == 1007 then
			setProperty('gf.x', -150);
			setProperty('gf.y', -600);
			setProperty('dad.x', 400);
		end
		if curStep == 1008 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang6','flashingshit',0,1.0,'linear')
			setProperty('blk.alpha', 0);
			doTweenAlpha('camHUDTween6','camHUD',1,0.10,'linear')
		end
		if curStep == 1072 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang7','flashingshit',0,1.0,'linear')
		end
		if curStep == 1136 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang8','flashingshit',0,1.0,'linear')
			funnyaoao = 2;
		end
		if curStep == 1260 then
			doTweenAlpha('blkTween4','blk',1,0.15,'linear')
			doTweenAlpha('camHUDTween7','camHUD',0,0.18,'linear')
		end
		if curStep == 1264 then
			setProperty('blk.alpha', 0);
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang8','flashingshit',0,1.0,'linear')
			doTweenAlpha('camHUDTween8','camHUD',1,0.10,'linear')
			funnyaoao = 3;
		end
		if curStep == 1382 then
			funnyaoao = 0;
		end
		if curStep == 1388 then
			doTweenAlpha('blkTween5','blk',1,0.8,'linear')
			doTweenAlpha('camHUDTween9','camHUD',0,0.8,'linear')
		end
		if curStep == 1402 then
			xx = 920;
			yy = 300;
			xx2 = 920;
			yy2 = 300;
		
			zoom = 5;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sun.alpha', 0);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('lightGround.alpha', 0.8);
					setProperty('light.alpha', 0.10);
					setProperty('lightGroundDad.alpha', 0.8);
					setProperty('lightDad.alpha', 0.10);
					setProperty('bbg.alpha', 0);
				end
				setProperty('bg.alpha', 0);
			end
			
			setProperty('gf.x', -150);
			setProperty('gf.y', -600);
			setProperty('dad.x', 400);
			
			setProperty('gf.alpha', 0);			
			setProperty('dadGroup.color', 0xFFFFFFFF);
			setProperty('boyfriendGroup.color', 0xFFFFFFFF);
			
			setProperty('scoreTxt.alpha', 0);
			setProperty('iconP1.alpha', 0);
			setProperty('iconP2.alpha', 0);
			setProperty('healthBar.alpha', 0);
			setProperty('healthBarBG.alpha', 0);
			
			setProperty('timeBar.alpha', 0);
			setProperty('timeBarBG.alpha', 0);
			setProperty('timeBarBGBG.alpha', 0);
			setProperty('timeTxt.alpha', 0);
			
			noteTweenAlpha('O1','0',0.3,0.01,'linear');
			noteTweenAlpha('O2','1',0.3,0.01,'linear');
			noteTweenAlpha('O3','2',0.3,0.01,'linear');
			noteTweenAlpha('O4','3',0.3,0.01,'linear');
			
			noteTweenAlpha('P1','4',0.3,0.01,'linear');
			noteTweenAlpha('P2','5',0.3,0.01,'linear');
			noteTweenAlpha('P3','6',0.3,0.01,'linear');
			noteTweenAlpha('P4','7',0.3,0.01,'linear');
		end
		if curStep == 1408 then
			doTweenAlpha('blkTween6','blk',0,0.5,'linear')
			doTweenAlpha('camHUDTween10','camHUD',1,0.5,'linear')
		end
		if curStep == 1536 then
			doTweenAlpha('blkTween7','blk',1,1.5,'linear')
			doTweenAlpha('camHUDTween11','camHUD',0,1.5,'linear')
		end
		if curStep == 1549 then
			xx = 600;
			yy = 200;
			xx2 = 1000;
			yy2 = 300;
		
			zoom = 1;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sun.alpha', 1);
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					setProperty('bbg.alpha', 1);
					setProperty('lightGround.alpha', 0);
					setProperty('light.alpha', 0);
					setProperty('lightGroundDad.alpha', 0);
					setProperty('lightDad.alpha', 0);
				end
				setProperty('bg.alpha', 1);
			end
			
			setProperty('gf.alpha', 1);
			setProperty('dadGroup.color', 0xFFFFFF);
			setProperty('boyfriendGroup.color', 0xFFFFFF);
			
			setProperty('scoreTxt.alpha', 1);
			setProperty('iconP1.alpha', 1);
			setProperty('iconP2.alpha', 1);
			setProperty('healthBar.alpha', 1);
			setProperty('healthBarBG.alpha', 1);
			
			setProperty('timeBar.alpha', 1);
			setProperty('timeBarBG.alpha', 1);
			setProperty('timeBarBGBG.alpha', 1);
			setProperty('timeTxt.alpha', 1);
			
			noteTweenAlpha('O11','0',1,0.01,'linear');
			noteTweenAlpha('O22','1',1,0.01,'linear');
			noteTweenAlpha('O33','2',1,0.01,'linear');
			noteTweenAlpha('O44','3',1,0.01,'linear');
			
			noteTweenAlpha('P11','4',1,0.01,'linear');
			noteTweenAlpha('P22','5',1,0.01,'linear');
			noteTweenAlpha('P33','6',1,0.01,'linear');
			noteTweenAlpha('P44','7',1,0.01,'linear');
		end
		if curStep == 1562 then
			doTweenAlpha('camHUDTween12','camHUD',1,0.5,'linear')
		end
		if curStep == 1552 then
			funnyaoao = 3;
			funnyyyy = true;
		end
		if curStep == 1568 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang9','flashingshit',0,1.0,'linear')
			setProperty('blk.alpha', 0);
		end
		if curStep == 1696 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flashbang10','flashingshit',0,1.0,'linear')
		end
		if curStep == 1824 then
			funnyyyy = false;
			funnyaoao = 0;
			doTweenAlpha('camHUDTween13','camHUD',0,1.2,'linear')
			doTweenAlpha('blkTween8','blk',1,1.2,'linear')
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
			if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
			if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
			if getProperty('gf.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
			if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
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