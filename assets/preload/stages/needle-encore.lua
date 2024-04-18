local xx = 1250;
local yy = 750;
local ofs = 25;
local ofs2 = 25;
local xx2 = 1550;
local yy2 = 750;
local followchars = true;
function onCreate()
	makeLuaSprite('bg', 'bgs/shadowmouse/bg', -800, -400);
	scaleObject('bg', 1, 1);
	setScrollFactor('bg', 0.15, 0.15);
	setProperty('bg.antialiasing', true);
	setProperty('bg.alpha', 0);
	addLuaSprite('bg', false);
	
	makeLuaSprite('planet', 'bgs/shadowmouse/planet', -500, -400);
	scaleObject('planet', 1, 1);
	setScrollFactor('planet', 0.25, 0.25);
	setProperty('planet.antialiasing', true);
	setProperty('planet.alpha', 0);
	addLuaSprite('planet', false);
	
	makeLuaSprite('bgOne', 'bgs/shadowmouse/bg-1', -500, -300);
	scaleObject('bgOne', 1, 1);
	setScrollFactor('bgOne', 0.35, 0.35);
	setProperty('bgOne.antialiasing', true);
	setProperty('bgOne.alpha', 0);
	addLuaSprite('bgOne', false);
	
	makeLuaSprite('bgTwo', 'bgs/shadowmouse/bg-2', -300, -200);
	scaleObject('bgTwo', 1, 1);
	setScrollFactor('bgTwo', 0.45, 0.45);
	setProperty('bgTwo.antialiasing', true);
	setProperty('bgTwo.alpha', 0);
	addLuaSprite('bgTwo', false);
	
	makeLuaSprite('bgThree', 'bgs/shadowmouse/bg-3', -200, -100);
	scaleObject('bgThree', 1, 1);
	setScrollFactor('bgThree', 0.55, 0.55);
	setProperty('bgThree.antialiasing', true);
	setProperty('bgThree.alpha', 0);
	addLuaSprite('bgThree', false);
	
	makeLuaSprite('bgFourOne', 'bgs/shadowmouse/bg-4-1', -200, 0);
	scaleObject('bgFourOne', 1, 1);
	setScrollFactor('bgFourOne', 0.66, 0.66);
	setProperty('bgFourOne.antialiasing', true);
	setProperty('bgFourOne.alpha', 0);
	addLuaSprite('bgFourOne', false);
	
	makeLuaSprite('bgFourTwo', 'bgs/shadowmouse/bg-4-2', -200, 0);
	scaleObject('bgFourTwo', 1, 1);
	setScrollFactor('bgFourTwo', 0.66, 0.66);
	setProperty('bgFourTwo.antialiasing', true);
	setProperty('bgFourTwo.alpha', 0);
	addLuaSprite('bgFourTwo', false);
	
	makeLuaSprite('bgFourThree', 'bgs/shadowmouse/bg-4-3', -200, 0);
	scaleObject('bgFourThree', 1, 1);
	setScrollFactor('bgFourThree', 0.66, 0.66);
	setProperty('bgFourThree.antialiasing', true);
	setProperty('bgFourThree.alpha', 0);
	addLuaSprite('bgFourThree', false);
	
	makeLuaSprite('bgFourFour', 'bgs/shadowmouse/bg-4-4', -200, 0);
	scaleObject('bgFourFour', 1, 1);
	setScrollFactor('bgFourFour', 0.66, 0.66);
	setProperty('bgFourFour.antialiasing', true);
	setProperty('bgFourFour.alpha', 0);
	addLuaSprite('bgFourFour', false);
	
	makeLuaSprite('bgFiveOne', 'bgs/shadowmouse/bg-5-1', -200, 0);
	scaleObject('bgFiveOne', 1, 1);
	setScrollFactor('bgFiveOne', 0.78, 0.78);
	setProperty('bgFiveOne.antialiasing', true);
	setProperty('bgFiveOne.alpha', 0);
	addLuaSprite('bgFiveOne', false);
	
	makeLuaSprite('bgFiveTwo', 'bgs/shadowmouse/bg-5-2', -150, 0);
	scaleObject('bgFiveTwo', 1, 1);
	setScrollFactor('bgFiveTwo', 0.78, 0.78);
	setProperty('bgFiveTwo.antialiasing', true);
	setProperty('bgFiveTwo.alpha', 0);
	addLuaSprite('bgFiveTwo', false);
	
	makeLuaSprite('bgFiveThree', 'bgs/shadowmouse/bg-5-3', -150, 0);
	scaleObject('bgFiveThree', 1, 1);
	setScrollFactor('bgFiveThree', 0.78, 0.78);
	setProperty('bgFiveThree.antialiasing', true);
	setProperty('bgFiveThree.alpha', 0);
	addLuaSprite('bgFiveThree', false);
	
	makeLuaSprite('bridge', 'bgs/shadowmouse/bridge', 0, 0);
	scaleObject('bridge', 1, 1);
	setScrollFactor('bridge', 1, 1);
	setProperty('bridge.antialiasing', true);
	setProperty('bridge.alpha', 1);
	addLuaSprite('bridge', false);
	
	setProperty('camHUD.alpha', 0);
	
	makeLuaSprite('lol', '', -500, -300);
	makeGraphic('lol',1920,1080,'000000')
	addLuaSprite('lol', false);
	setLuaSpriteScrollFactor('lol',0,0)
	setProperty('lol.scale.x',2)
	setProperty('lol.scale.y',2)
	setProperty('lol.alpha',0)
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',0)
	setObjectCamera('blk', 'camHUD')

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	setObjectCamera('flashingshit', 'camHUD')
	
	makeAnimatedLuaSprite('eyes', 'bgs/shadowmouse/eyes', 330, 150);
	scaleObject('eyes', 1.7, 1.7);
	addAnimationByPrefix('eyes', 'idle', 'eyes idle', 8, true);
	setProperty('eyes.antialiasing', true);
	addLuaSprite('eyes', false);
	setProperty('eyes.alpha', 0);
	
	makeAnimatedLuaSprite('eyetoeye', 'bgs/shadowmouse/eyetoeye', 0, 0);
	scaleObject('eyetoeye', 1.1, 1.1);
	addAnimationByPrefix('eyetoeye', 'idle', 'eyetoeye idle', 4, true);
	setProperty('eyetoeye.antialiasing', true);
	addLuaSprite('eyetoeye', true);
	setProperty('eyetoeye.alpha', 0);
	screenCenter('eyetoeye')
	setObjectCamera('eyetoeye', 'camHUD')
	
	makeLuaSprite('blkQWE', '', 0, 0);
	makeGraphic('blkQWE',1920,1080,'000000')
	addLuaSprite('blkQWE', true);
	setLuaSpriteScrollFactor('blkQWE',0,0)
	setProperty('blkQWE.scale.x',2)
	setProperty('blkQWE.scale.y',2)
	setProperty('blkQWE.alpha',1)
	setObjectCamera('blkQWE', 'camOther')
	
	setProperty('gfGroup.alpha', 0);
	runTimer('bgFourOne-Down', 0.2, 1)
	runTimer('bgFourTwo-Down', 0.4, 1)
	runTimer('bgFourThree-Down', 0.1, 1)
	runTimer('bgFourFour-Down', 0.1, 1)
	runTimer('bgFiveOne-Down', 0.3, 1)
	runTimer('bgFiveTwo-Down', 0.3, 1)
	runTimer('bgFiveThree-Down', 0.7, 1)
end
function onTimerCompleted(tag)
	if tag == 'bgFourOne-Down' then
		doTweenY('FourOneTweenDown', 'bgFourOne', 60, 2.8, 'quadInOut')
		runTimer('bgFourOne-Up', 2.8, 1)
	end
	if tag == 'bgFourOne-Up' then
		doTweenY('FourOneTweenUp', 'bgFourOne', 0, 2.0, 'quadInOut')
		runTimer('bgFourOne-Down', 2.0, 1)
	end
	
	if tag == 'bgFourTwo-Down' then
		doTweenY('FourTwoTweenDown', 'bgFourTwo', 80, 2.5, 'quadInOut')
		runTimer('bgFourTwo-Up', 2.5, 1)
	end
	if tag == 'bgFourTwo-Up' then
		doTweenY('FourTwoTweenUp', 'bgFourTwo', 0, 2.4, 'quadInOut')
		runTimer('bgFourTwo-Down', 2.4, 1)
	end
	
	if tag == 'bgFourThree-Down' then
		doTweenY('FourThreeTweenDown', 'bgFourThree', 70, 2.6, 'quadInOut')
		runTimer('bgFourThree-Up', 2.6, 1)
	end
	if tag == 'bgFourThree-Up' then
		doTweenY('FourThreeTweenUp', 'bgFourThree', 0, 2.1, 'quadInOut')
		runTimer('bgFourThree-Down', 2.1, 1)
	end
	
	if tag == 'bgFourFour-Down' then
		doTweenY('FourFourTweenDown', 'bgFourFour', 90, 2.5, 'quadInOut')
		runTimer('bgFourFour-Up', 2.5, 1)
	end
	if tag == 'bgFourFour-Up' then
		doTweenY('FourFourTweenUp', 'bgFourFour', 0, 2.0, 'quadInOut')
		runTimer('bgFourFour-Down', 2.0, 1)
	end
	
	if tag == 'bgFiveOne-Down' then
		doTweenY('FiveOneTweenDown', 'bgFiveOne', 20, 2.8, 'quadInOut')
		runTimer('bgFiveOne-Up', 2.8, 1)
	end
	if tag == 'bgFiveOne-Up' then
		doTweenY('FiveOneTweenUp', 'bgFiveOne', 0, 2.6, 'quadInOut')
		runTimer('bgFiveOne-Down', 2.6, 1)
	end
	
	if tag == 'bgFiveTwo-Down' then
		doTweenY('FiveTwoTweenDown', 'bgFiveTwo', 40, 2.5, 'quadInOut')
		runTimer('bgFiveTwo-Up', 2.5, 1)
	end
	if tag == 'bgFiveTwo-Up' then
		doTweenY('FiveTwoTweenUp', 'bgFiveTwo', 0, 2.0, 'quadInOut')
		runTimer('bgFiveTwo-Down', 2.0, 1)
	end
	
	if tag == 'bgFiveThree-Down' then
		doTweenY('FiveThreeTweenDown', 'bgFiveThree', 60, 2.5, 'quadInOut')
		runTimer('bgFiveThree-Up', 2.5, 1)
	end
	if tag == 'bgFiveThree-Up' then
		doTweenY('FiveThreeTweenUp', 'bgFiveThree', 0, 2.0, 'quadInOut')
		runTimer('bgFiveThree-Down', 2.0, 1)
	end
end
function onUpdate(elapsed)
	if songName == "round-a-bout-encore" then
		if curStep == 1 then
			setProperty('boyfriend.color', getColorFromHex('494949'))
			setProperty('dad.color', getColorFromHex('494949'))
			setProperty('bridge.color', getColorFromHex('494949'))
			doTweenAlpha('blkQWE','blkQWE',0,2.7,'linear')
		end
		if curStep == 12 then
			doTweenAlpha('camHUD','camHUD',1,0.7,'linear')
		end
		if curStep == 16 then
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('bg.alpha', 1);
			setProperty('planet.alpha', 1);
			setProperty('bgOne.alpha', 1);
			setProperty('bgTwo.alpha', 1);
			setProperty('bgThree.alpha', 1);
			setProperty('bgFourOne.alpha', 1);
			setProperty('bgFourTwo.alpha', 1);
			setProperty('bgFourThree.alpha', 1);
			setProperty('bgFourFour.alpha', 1);
			setProperty('bgFiveOne.alpha', 1);
			setProperty('bgFiveTwo.alpha', 1);
			setProperty('bgFiveThree.alpha', 1);
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('bridge.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 144 or curStep == 240 or curStep == 304 or curStep == 464 or curStep == 720 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 208 or curStep == 272 or curStep == 336 or curStep == 528 or curStep == 656 then
			setProperty('defaultCamZoom',0.7)
		end
		if curStep == 464 then
			doTweenAlpha('lol','lol',0.4,0.25,'linear')
		end
		if curStep == 592 then
			doTweenAlpha('lolout','lol',0,0.25,'linear')
			setProperty('defaultCamZoom',0.6)
			cancelTween('flsh');
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 742 then
			setProperty('defaultCamZoom',0.6)
			doTweenAlpha('blk1','blk',1,1.2,'linear')
		end
		
		if curStep == 752 then
			doTweenAlpha('eyetoeye','eyetoeye',1,2,'linear')
		end
		
		if curStep == 770 then
			setProperty('eyetoeye.alpha', 0);
			setProperty('blk.alpha', 0);
			setProperty('lol.alpha', 1);
			setProperty('eyes.alpha', 1);
			setProperty('defaultCamZoom',0.7)
			setProperty('blkQWE.alpha', 0);
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 866 then
			setProperty('defaultCamZoom',0.6)
		end
		if curStep == 938 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 962 then
			setProperty('defaultCamZoom',0.7)
			doTweenAlpha('blkQWE1','blkQWE',1,1.5,'linear')
		end
		if curStep == 978 then
			setProperty('defaultCamZoom',0.6)
			setProperty('blkQWE.alpha', 0);
			setProperty('lol.alpha', 0);
			setProperty('eyes.alpha', 0);
		end
		if curStep == 1090 then
			setProperty('defaultCamZoom',0.7)
		end
		if curStep == 1106 then
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 1122 then
			setProperty('defaultCamZoom',0.7)
		end
		if curStep == 1138 then
			setProperty('defaultCamZoom',0.6)
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('blkQaa','blkQWE',1,2,'linear')
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