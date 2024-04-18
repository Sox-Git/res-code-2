local xx = 550;
local yy = 220;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1250;
local yy2 = 220;
local SingBoth = false;
local followchars = true;

function onCreate()
	addHaxeLibrary('FlxBackdrop', 'flixel.addons.display');
	addHaxeLibrary('FlxTween', 'flixel.tweens');
	addHaxeLibrary('FlxEase', 'flixel.tweens');
	addHaxeLibrary('FlxObject', 'flixel');
	
	makeLuaSprite('sky', '', 0, 0);
	makeGraphic('sky', 1920, 1080,'2400B4')
	addLuaSprite('sky', false);
	setLuaSpriteScrollFactor('sky',0,0)
	setProperty('sky.scale.x',2)
	setProperty('sky.scale.y',2)

	
	makeLuaSprite('skyR', '', 0, 0);
	makeGraphic('skyR', 1920, 1080,'4C0707')
	addLuaSprite('skyR', false);
	setLuaSpriteScrollFactor('skyR',0,0)
	setProperty('skyR.scale.x',2)
	setProperty('skyR.scale.y',2)
	setProperty('skyR.alpha', 0)
	
	makeAnimatedLuaSprite('mountins', 'bgs/melt/classic/main', -1300, -788);
	scaleObject('mountins', 7, 7);
	addAnimationByPrefix('mountins', 'idle', 'BG ', 12, true);
	setScrollFactor('mountins', 0.7, 1);
	setProperty('mountins.antialiasing', false);
	addLuaSprite('mountins', false);
	
	makeAnimatedLuaSprite('mountinsR', 'bgs/melt/alt/main', -1300, -788);
	scaleObject('mountinsR', 7, 7);
	addAnimationByPrefix('mountinsR', 'idle', 'BG ', 12, true);
	setScrollFactor('mountinsR', 0.7, 1);
	setProperty('mountinsR.antialiasing', false);
	setProperty('mountinsR.alpha', 0);
	addLuaSprite('mountinsR', false);
	
	makeAnimatedLuaSprite('water', 'bgs/melt/classic/water', -1300, -788);
	scaleObject('water', 7, 7);
	addAnimationByPrefix('water', 'idle', 'BG', 12, true);
	setScrollFactor('water', 0.9, 1);
	setProperty('water.antialiasing', false);
	addLuaSprite('water', false);
	
	makeAnimatedLuaSprite('waterR', 'bgs/melt/alt/water', -1300, -788);
	scaleObject('waterR', 7, 7);
	addAnimationByPrefix('waterR', 'idle', 'BG', 12, true);
	setScrollFactor('waterR', 0.9, 1);
	setProperty('waterR.antialiasing', false);
	setProperty('waterR.alpha', 0);
	addLuaSprite('waterR', false);
	
	makeAnimatedLuaSprite('loop', 'bgs/melt/classic/loop', 800, -850);
	scaleObject('loop', 6, 6);
	addAnimationByPrefix('loop', 'idle', 'loop ', 12, true);
	setScrollFactor('loop', 1.05, 1);
	setProperty('loop.antialiasing', false);
	addLuaSprite('loop', false);
	
	makeAnimatedLuaSprite('loopR', 'bgs/melt/alt/loop_red', 800, -850);
	scaleObject('loopR', 6, 6);
	addAnimationByPrefix('loopR', 'idle', 'loop_red ', 12, true);
	setScrollFactor('loopR', 1.05, 1);
	setProperty('loopR.antialiasing', false);
	setProperty('loopR.alpha', 0);
	addLuaSprite('loopR', false);
	
	makeAnimatedLuaSprite('tvIcons', 'bgs/melt/tv-icons', 627, 88);
	scaleObject('tvIcons', 7, 7);
	addAnimationByPrefix('tvIcons', 'melthog1', 'Melthog1 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog2', 'Melthog2 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog3', 'Melthog3-4 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog4', 'Melthog3-4 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog5', 'Melthog5-6-7 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog6', 'Melthog5-6-7 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthog7', 'Melthog5-6-7 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthogs3', 'MelthogS3 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthogpico', 'Melthog Pico 0', 24, true);
	addAnimationByPrefix('tvIcons', 'melthogbf', 'Melthog BF 0', 24, true);
	setScrollFactor('tvIcons', 1, 1);
	setProperty('tvIcons.antialiasing', false);
	addLuaSprite('tvIcons', false);
	
	if songName == "confronting" then
		objectPlayAnimation('tvIcons', 'melthogbf', true)
	end
	
	makeLuaSprite('plate', 'bgs/melt/classic/plate', -600, -350);
	scaleObject('plate', 6, 6);
	setScrollFactor('plate', 1.1, 1);
	setProperty('plate.antialiasing', false);
	addLuaSprite('plate', false);
	
	makeLuaSprite('plateR', 'bgs/melt/alt/plate_red', -600, -350);
	scaleObject('plateR', 6, 6);
	setScrollFactor('plateR', 1.1, 1);
	setProperty('plateR.antialiasing', false);
	setProperty('plateR.alpha', 0);
	addLuaSprite('plateR', false);
	
	makeAnimatedLuaSprite('floor', 'bgs/melt/classic/Melthog_S1_stage', -1550, -850);
	scaleObject('floor', 7, 7);
	addAnimationByPrefix('floor', 'idle', 'S1 Stage', 12, true);
	setScrollFactor('floor', 1, 1);
	setProperty('floor.antialiasing', false);
	addLuaSprite('floor', false);
	
	makeAnimatedLuaSprite('floorR', 'bgs/melt/alt/Melthog_S1_stage_red', -1550, -850);
	scaleObject('floorR', 7, 7);
	addAnimationByPrefix('floorR', 'idle', 'S1_red Stage', 12, true);
	setScrollFactor('floorR', 1, 1);
	setProperty('floorR.antialiasing', false);
	setProperty('floorR.alpha', 0);
	addLuaSprite('floorR', false);
	
	makeLuaSprite('blackout', '', 0, 0);
	makeGraphic('blackout',1920,1080,'000000')
	addLuaSprite('blackout', false);
	setLuaSpriteScrollFactor('blackout',0,0)
	setProperty('blackout.scale.x',2)
	setProperty('blackout.scale.y',2)
	setProperty('blackout.alpha',0)
	
	makeLuaSprite('blackscreen', '', 0, 0);
	makeGraphic('blackscreen',1920,1080,'000000')
	addLuaSprite('blackscreen', true);
	setLuaSpriteScrollFactor('blackscreen',0,0)
	setProperty('blackscreen.scale.x',2)
	setProperty('blackscreen.scale.y',2)
	setProperty('blackscreen.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	setProperty('camHUD.alpha', 0);
	setProperty('gfGroup.alpha', 0);
	
	runHaxeCode([[
		CloudClassicOne = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/1'), 1, 1, true, false);
		CloudClassicOne.scale.set(7, 7);
		CloudClassicOne.x = -1500;
		CloudClassicOne.y = -650;
		CloudClassicOne.scrollFactor.set(0.7, 1);
		CloudClassicOne.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+1, CloudClassicOne);
			
		CloudClassicTwo = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/2'), 1, 1, true, false);
		CloudClassicTwo.x = -1500;
		CloudClassicTwo.y = -650;
		CloudClassicTwo.scale.set(7, 7);
		CloudClassicTwo.scrollFactor.set(0.7, 1);
		CloudClassicTwo.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+2, CloudClassicTwo);
			
		CloudClassicThree = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/3'), 1, 1, true, false);
		CloudClassicThree.x = -1500;
		CloudClassicThree.y = -650;
		CloudClassicThree.scale.set(7, 7);
		CloudClassicThree.scrollFactor.set(0.7, 1);
		CloudClassicThree.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+3, CloudClassicThree);
			
		CloudClassicFour = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/4'), 1, 1, true, false);
		CloudClassicFour.x = -1500;
		CloudClassicFour.y = -650;
		CloudClassicFour.scale.set(7, 7);
		CloudClassicFour.scrollFactor.set(0.7, 1);
		CloudClassicFour.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+4, CloudClassicFour);
			
		CloudClassicFive = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/5'), 1, 1, true, false);
		CloudClassicFive.x = -1500;
		CloudClassicFive.y = -650;
		CloudClassicFive.scale.set(7, 7);
		CloudClassicFive.scrollFactor.set(0.7, 1);
		CloudClassicFive.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+5, CloudClassicFive);
			
		CloudClassicSix = new FlxBackdrop(Paths.image('bgs/melt/classic/clouds/6'), 1, 1, true, false);
		CloudClassicSix.x = -1500;
		CloudClassicSix.y = -650;
		CloudClassicSix.scale.set(7, 7);
		CloudClassicSix.scrollFactor.set(0.7, 1);
		CloudClassicSix.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('sky'))+6, CloudClassicSix);
			
			
		CloudAltOne = new FlxBackdrop(Paths.image('bgs/melt/alt/clouds/1'), 1, 1, true, false);
		CloudAltOne.x = -1500;
		CloudAltOne.y = -650;
		CloudAltOne.alpha = 0;
		CloudAltOne.scale.set(7, 7);
		CloudAltOne.scrollFactor.set(0.7, 1);
		CloudAltOne.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyR'))+1, CloudAltOne);
			
		CloudAltTwo = new FlxBackdrop(Paths.image('bgs/melt/alt/clouds/2'), 1, 1, true, false);
		CloudAltTwo.x = -1500;
		CloudAltTwo.y = -650;
		CloudAltTwo.alpha = 0;
		CloudAltTwo.scale.set(7, 7);
		CloudAltTwo.scrollFactor.set(0.7, 1);
		CloudAltTwo.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyR'))+2, CloudAltTwo);
			
		CloudAltThree = new FlxBackdrop(Paths.image('bgs/melt/alt/clouds/3'), 1, 1, true, false);
		CloudAltThree.x = -1500;
		CloudAltThree.y = -650;
		CloudAltThree.alpha = 0;
		CloudAltThree.scale.set(7, 7);
		CloudAltThree.scrollFactor.set(0.7, 1);
		CloudAltThree.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyR'))+3, CloudAltThree);
			
		CloudAltFour = new FlxBackdrop(Paths.image('bgs/melt/alt/clouds/4'), 1, 1, true, false);
		CloudAltFour.x = -1500;
		CloudAltFour.y = -650;
		CloudAltFour.alpha = 0;
		CloudAltFour.scale.set(7, 7);
		CloudAltFour.scrollFactor.set(0.7, 1);
		CloudAltFour.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyR'))+4, CloudAltFour);
			
		CloudAltFive = new FlxBackdrop(Paths.image('bgs/melt/alt/clouds/5'), 1, 1, true, false);
		CloudAltFive.x = -1500;
		CloudAltFive.y = -650;
		CloudAltFive.alpha = 0;
		CloudAltFive.scale.set(7, 7);
		CloudAltFive.scrollFactor.set(0.7, 1);
		CloudAltFive.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyR'))+5, CloudAltFive);
			
		CloudAltSix = new FlxBackdrop(Paths.image('bgs/bgs/melt/alt/clouds/6'), 1, 1, true, false);
		CloudAltSix.x = -1500;
		CloudAltSix.y = -650;
		CloudAltSix.alpha = 0;
		CloudAltSix.scale.set(7, 7);
		CloudAltsix.scrollFactor.set(0.7, 1);
		CloudAltSix.antialiasing = false;
		game.insert(game.members.indexOf(game.modchartSprites.get('skyR'))+6, CloudAltSix);
		
		trace('dsfsdfsdf');
	]])
	
end

function onEvent(event, val1, val2)
	if event == 'Change Character' then
		if val1 == "1" or val1 == 'dad' or val1 == 'opponent' then
			if val2 == 'Melthog_c6' then
				objectPlayAnimation('tvIcons', 'melthogs3', true)
			end
			if val2 == 'melt-pico' then
				objectPlayAnimation('tvIcons', 'melthogpico', true)
			end
			if val2 == 'bf-confronting' then
				objectPlayAnimation('tvIcons', 'melthogbf', true)
			end
		end
	end
end

function onStepHit()	
	if songName == "confronting" then
		if curStep == 48 then
			doTweenAlpha('camHUDTween8','camHUD',1,1,'linear')
		end
		
		if curStep == 192 then
			doTweenAlpha('blackout','blackout',1 ,0.6,'linear')
		end
		
		if curStep == 208 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit1','flashingshit',0,1,'linear')
			setProperty('blackout.alpha', 0)
		end
		
		if curStep == 336 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit2','flashingshit',0,1,'linear')
		end
		
		if curStep == 400 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit3','flashingshit',0,1,'linear')
		end
		
		if curStep == 464 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit4','flashingshit',0,1,'linear')
		end
		
		if curStep == 656 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit5','flashingshit',0,1,'linear')
		end
		
		if curStep == 688 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit6','flashingshit',0,1,'linear')
		end
		
		if curStep == 732 then
			doTweenAlpha('gfTween1','gf',0.4,0.3,'linear')
		end
		
		if curStep == 768 then
			doTweenAlpha('gfTween2','gf',0,0.3,'linear')
		end
		
		if curStep == 796 then
			doTweenAlpha('gfTween3','gf',0.4,0.3,'linear')
		end
		
		if curStep == 896 then
			doTweenAlpha('gfTween4','gf',0,0.3,'linear')
		end
		
		if curStep == 992 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit7','flashingshit',0,1,'linear')
			
			setProperty('sky.alpha',0)
			setProperty('mountins.alpha',0)
			setProperty('water.alpha',0)
			setProperty('floor.alpha',0)
			setProperty('loop.alpha',0)
			setProperty('plate.alpha',0)
			setProperty('skyR.alpha',1)
			setProperty('mountinsR.alpha',1)
			setProperty('waterR.alpha',1)
			setProperty('floorR.alpha',1)
			setProperty('loopR.alpha',1)
			setProperty('plateR.alpha',1)
			
			runHaxeCode([[
				CloudClassicOne.alpha = 0;
				CloudClassicTwo.alpha = 0;
				CloudClassicThree.alpha = 0;
				CloudClassicFour.alpha = 0;
				CloudClassicFive.alpha = 0;
				CloudClassicSix.alpha = 0;
				
				CloudAltOne.alpha = 1;
				CloudAltTwo.alpha = 1;
				CloudAltThree.alpha = 1;
				CloudAltFour.alpha = 1;
				CloudAltFive.alpha = 1;
				CloudAltSix.alpha = 1;
			]])
		end
		
		if curStep == 1120 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flashingshit8','flashingshit',0,1,'linear')
			
			setProperty('sky.alpha',1)
			setProperty('mountins.alpha',1)
			setProperty('water.alpha',1)
			setProperty('floor.alpha',1)
			setProperty('loop.alpha',1)
			setProperty('plate.alpha',1)
			setProperty('skyR.alpha',0)
			setProperty('mountinsR.alpha',0)
			setProperty('waterR.alpha',0)
			setProperty('floorR.alpha',0)
			setProperty('loopR.alpha',0)
			setProperty('plateR.alpha',0)
			
			runHaxeCode([[
				CloudClassicOne.alpha = 1;
				CloudClassicTwo.alpha = 1;
				CloudClassicThree.alpha = 1;
				CloudClassicFour.alpha = 1;
				CloudClassicFive.alpha = 1;
				CloudClassicSix.alpha = 1;
				
				CloudAltOne.alpha = 0;
				CloudAltTwo.alpha = 0;
				CloudAltThree.alpha = 0;
				CloudAltFour.alpha = 0;
				CloudAltFive.alpha = 0;
				CloudAltSix.alpha = 0;
			]])
		end
		
		if curStep == 1187 then
			doTweenAlpha('gfTween5','gf',0.4,0.3,'linear')
		end
		
		if curStep == 1214 then
			doTweenAlpha('gfTween6','gf',0,0.3,'linear')
		end
		
		if curStep == 1220 then
			doTweenAlpha('gfTween7','gf',0.4,0.3,'linear')
		end
		
		if curStep == 1232 then
			doTweenAlpha('gfTween8','gf',0,0.3,'linear')
		end
		
		if curStep == 1248 then
			doTweenAlpha('gfTween9','gf',0.4,0.3,'linear')
			SingBoth = true;
		end
		
		if curStep == 1447 then
			doTweenAlpha('gfTween10','gf',0,0.3,'linear')
		end
		
		if curStep == 1460 then
			SingBoth = false;
		end
		
		if curStep == 1624 then
			doTweenAlpha('timeBarT1','timeBar',0,0.3,'linear')
			doTweenAlpha('timeBarBGT1','timeBarBG',0,0.3,'linear')
			doTweenAlpha('timeTxtT1','timeTxt',0,0.3,'linear')
		end
		
		if curStep == 1626 then
			doTweenAlpha('iconP1T1','iconP1',0,0.3,'linear')
			doTweenAlpha('iconP2T1','iconP2',0,0.3,'linear')
			doTweenAlpha('healthBarT1','healthBar',0,0.3,'linear')
			doTweenAlpha('healthBarBGT1','healthBarBG',0,0.3,'linear')
			doTweenAlpha('iconP1T1','iconP1',0,0.3,'linear')
		end
		
		if curStep == 1627 then
			doTweenAlpha('scoreTxtT1','scoreTxt',0,0.3,'linear')
		end
		
		if curStep == 1628 then
			doTweenAlpha('sky','sky',0 ,0.3,'linear')
			doTweenAlpha('mountins','mountins',0 ,0.3,'linear')
			doTweenAlpha('water','water',0 ,0.3,'linear')
			
			runHaxeCode([[
				FlxTween.tween(CloudClassicOne, {alpha: 0}, 0.3);
				FlxTween.tween(CloudClassicTwo, {alpha: 0}, 0.3);
				FlxTween.tween(CloudClassicThree, {alpha: 0}, 0.3);
				FlxTween.tween(CloudClassicFour, {alpha: 0}, 0.3);
				FlxTween.tween(CloudClassicFive, {alpha: 0}, 0.3);
				FlxTween.tween(CloudClassicSix, {alpha: 0}, 0.3);
			]])
		end
		
		if curStep == 1630 then
			doTweenAlpha('plate','plate',0 ,0.3,'linear')
			doTweenAlpha('tvIcons','tvIcons',0 ,0.3,'linear')
			doTweenAlpha('floor','floor',0 ,0.3,'linear')
			doTweenAlpha('loop','loop',0 ,0.3,'linear')
		end
		
		if curStep == 1760 then
			doTweenAlpha('camHUDTween10','camHUD',0,3.5,'linear')
		end
		
		if curStep == 1776 then
			doTweenAlpha('dadT1','dad',0,2,'linear')
			doTweenAlpha('bf1','boyfriend',0,2,'linear')
		end
	end
end

function onUpdate()

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	runHaxeCode([[
		CloudClassicOne.velocity.set(85, 0);
		CloudClassicTwo.velocity.set(80, 0);
		CloudClassicThree.velocity.set(75, 0);
		CloudClassicFour.velocity.set(70, 0);
		CloudClassicFive.velocity.set(65, 0);
		CloudClassicSix.velocity.set(60, 0);
			
		CloudAltOne.velocity.set(85, 0);
		CloudAltTwo.velocity.set(80, 0);
		CloudAltThree.velocity.set(75, 0);
		CloudAltFour.velocity.set(70, 0);
		CloudAltFive.velocity.set(65, 0);
		CloudAltSix.velocity.set(60, 0);
	]])
	
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

            if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeR' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeL' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if SingBoth then
		characterPlayAnim('gf', singAnims[direction + 1], true);
	end
end