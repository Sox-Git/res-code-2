local xDad = 900;
local yDad = 300;
local xBF = 900;
local yBF = 300;
local ofsDad = 40;
local ofsBF = 40;
local cameraMoves = true;
local yes = false;

function onCreate()
	makeLuaSprite('sky', 'bgs/omw/Day', -550, -800);
	scaleObject('sky', 1, 1);
	setScrollFactor('sky', 0.2, 0.2);
	setProperty('sky.antialiasing', true);
	setProperty('sky.alpha', 1);
	addLuaSprite('sky', false);
	
	makeLuaSprite('nightSky', 'bgs/omw/Night', -550, -700);
	scaleObject('nightSky', 1, 1);
	setScrollFactor('nightSky', 0.2, 0.2);
	setProperty('nightSky.antialiasing', true);
	setProperty('nightSky.alpha', 0);
	addLuaSprite('nightSky', false);

	makeLuaSprite('Mountains', 'bgs/omw/Mountains', -510, -660);
	scaleObject('Mountains', 1, 1);
	setScrollFactor('Mountains', 0.4, 0.4);
	setProperty('Mountains.antialiasing', true);
	setProperty('Mountains.alpha', 1);
	addLuaSprite('Mountains', false);

	makeLuaSprite('MainMountains', 'bgs/omw/Main-Mountains', -440, -620);
	scaleObject('MainMountains', 1, 1);
	setScrollFactor('MainMountains', 0.6, 0.6);
	setProperty('MainMountains.antialiasing', true);
	setProperty('MainMountains.alpha', 1);
	addLuaSprite('MainMountains', false);

	makeAnimatedLuaSprite('waterfall', 'bgs/omw/waterfall', 584, -552);
	scaleObject('waterfall', 1, 1);
	addAnimationByPrefix('waterfall', 'fff', 'fff', 24, true);
	setScrollFactor('waterfall', 0.6, 0.6);
	setProperty('waterfall.antialiasing', false);
	setProperty('waterfall.alpha',1)
	addLuaSprite('waterfall', false);

	makeLuaSprite('Omw', 'bgs/omw/omg-omw', -380, -420);
	scaleObject('Omw', 1, 1);
	setScrollFactor('Omw', 1, 1);
	setProperty('Omw.antialiasing', true);
	setProperty('Omw.alpha', 0);
	addLuaSprite('Omw', false);

	makeLuaSprite('Forest', 'bgs/omw/Forest', -370, -450);
	scaleObject('Forest', 1, 1);
	setScrollFactor('Forest', 0.8, 0.8);
	setProperty('Forest.antialiasing', true);
	setProperty('Forest.alpha', 1);
	addLuaSprite('Forest', false);

	makeAnimatedLuaSprite('BGstatic', 'bgs/omw/staticOMW', -680, -800);
	scaleObject('BGstatic', 6.5, 6.5);
	addAnimationByPrefix('BGstatic', 'sshh', 'stat', 24, true);
	setScrollFactor('BGstatic', 0, 0);
	setProperty('BGstatic.antialiasing', false);
	setProperty('BGstatic.alpha',0)
	addLuaSprite('BGstatic', false);

	makeLuaSprite('Terrain', 'bgs/omw/Terrain', -300, -550);
	scaleObject('Terrain', 1, 1);
	setScrollFactor('Terrain', 1, 1);
	setProperty('Terrain.antialiasing', true);
	setProperty('Terrain.alpha', 1);
	addLuaSprite('Terrain', false);
	
	makeLuaSprite('Front', 'bgs/omw/Front', -300, -600);
	scaleObject('Front', 1, 1);
	setScrollFactor('Front', 1, 0.8);
	setProperty('Front.antialiasing', true);
	setProperty('Front.alpha', 1);
	addLuaSprite('Front', true);

	makeLuaSprite('blacky', '', 0, -500);
	makeGraphic('blacky',1920,1080,'000000')
	addLuaSprite('blacky', true);
	setLuaSpriteScrollFactor('blacky',0,0)
	setProperty('blacky.scale.x',2)
	setProperty('blacky.scale.y',2)
	setProperty('blacky.alpha',0)

	makeAnimatedLuaSprite('static', 'bgs/omw/staticOMW', -680, -800);
	scaleObject('static', 6.5, 6.5);
	addAnimationByPrefix('static', 'sshh', 'stat', 24, true);
	setScrollFactor('static', 0, 0);
	setProperty('static.antialiasing', false);
	setProperty('static.alpha',0)
	addLuaSprite('static', true);

	makeLuaSprite('overlay', '', 0, -500);
	makeGraphic('overlay',1920,1080,'000000')
	setScrollFactor('overlay', 0, 0);
	setProperty('overlay.scale.x',2)
	setProperty('overlay.scale.y',2)
	setProperty('overlay.alpha',0)
	addLuaSprite('overlay', true);
	
	makeLuaSprite('flashingshit', '', -300, -300);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onUpdate(elapsed)
	if yes == false then
		if mustHitSection == false then
			doTweenZoom('ZOOMDAD', 'camGame',0.55, 1.0, 'quadOut')
		else
			doTweenZoom('ZOOMDAD', 'camGame',0.65, 1.0, 'quadOut')
		end
	else
		if mustHitSection == false then
			doTweenZoom('ZOOMDAD', 'camGame',0.55, 1.0, 'quadOut')
		else
			doTweenZoom('ZOOMDAD', 'camGame',0.6, 1.0, 'quadOut')
		end
	end

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "universal-collapse" then
		if curStep == 0 then
			setProperty('dad.alpha', 0);
			setProperty('camHUD.alpha', 0);
		end
		if curStep == 88 or curStep == 96 or curStep == 106 or curStep == 115 then
			setProperty('static.alpha', 1);
		end
		if curStep == 89 then
			setProperty('Omw.alpha', 1);
		end
		if curStep == 90 or curStep == 98 or curStep == 111 or curStep == 116 then
			setProperty('static.alpha', 0);
		end
		if curStep == 98 then
			setProperty('blacky.alpha', 1);
		end
		if curStep == 109 then
			setProperty('blacky.alpha', 0);
		end
		if curStep == 108 then
			setProperty('static.color', getColorFromHex('000DA5'))
		end
		if curStep == 109 then
			setProperty('static.color', getColorFromHex('BC0000'))
		end
		if curStep == 110 then
			setProperty('static.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 112 or curStep == 118 then
			if curStep == 112 then setProperty('static.alpha', 0.3); end
			setProperty('sky.color', getColorFromHex('494949'))
			setProperty('Mountains.color', getColorFromHex('494949'))
			setProperty('MainMountains.color', getColorFromHex('494949'))
			setProperty('waterfall.color', getColorFromHex('494949'))
			setProperty('Omw.color', getColorFromHex('494949'))
			setProperty('Forest.color', getColorFromHex('494949'))
			setProperty('Terrain.color', getColorFromHex('494949'))
			setProperty('Front.color', getColorFromHex('494949'))
			setProperty('boyfriendGroup.color', getColorFromHex('494949'))
			setProperty('dadGroup.color', getColorFromHex('494949'))
		end
		if curStep == 116 then
			setProperty('sky.color', getColorFromHex('FF0000'))
			setProperty('Mountains.color', getColorFromHex('FF0000'))
			setProperty('MainMountains.color', getColorFromHex('FF0000'))
			setProperty('waterfall.color', getColorFromHex('FF0000'))
			setProperty('Omw.color', getColorFromHex('FF0000'))
			setProperty('Forest.color', getColorFromHex('FF0000'))
			setProperty('Terrain.color', getColorFromHex('FF0000'))
			setProperty('Front.color', getColorFromHex('FF0000'))
			setProperty('boyfriendGroup.color', getColorFromHex('FF0000'))
			setProperty('dadGroup.color', getColorFromHex('FF0000'))
		end
		if curStep == 124 then
			setProperty('static.alpha', 0.5);
			setProperty('sky.color', getColorFromHex('0000FF'))
			setProperty('Mountains.color', getColorFromHex('0000FF'))
			setProperty('MainMountains.color', getColorFromHex('0000FF'))
			setProperty('waterfall.color', getColorFromHex('0000FF'))
			setProperty('Omw.color', getColorFromHex('0000FF'))
			setProperty('Forest.color', getColorFromHex('0000FF'))
			setProperty('Terrain.color', getColorFromHex('0000FF'))
			setProperty('Front.color', getColorFromHex('0000FF'))
			setProperty('boyfriendGroup.color', getColorFromHex('0000FF'))
			setProperty('dadGroup.color', getColorFromHex('0000FF'))
		end
		if curStep == 128 then
			setProperty('flashingshit.color', getColorFromHex('565656'))
			setProperty('flashingshit.alpha', 1);
			setProperty('blacky.alpha', 1);
			doTweenAlpha('Flash1','flashingshit',0,1.0,'linear')
		end
		if curStep == 144 then
			setProperty('flashingshit.color', getColorFromHex('828282'))
			doTweenAlpha('Flash2','flashingshit',1,5,'linear')
			doTweenAlpha('Static1','static',0,5,'linear')
			
			yes = true;
			xDad = 900;
			yDad = 150;
			xBF = 900;
			yBF = 400;
		end
		if curStep == 192 then
			doTweenZoom('ZOOMDAD', 'camGame',0.55, 1.0, 'quadOut')
		
			setProperty('sky.color', getColorFromHex('505050'))
			setProperty('Mountains.color', getColorFromHex('505050'))
			setProperty('MainMountains.color', getColorFromHex('505050'))
			setProperty('waterfall.color', getColorFromHex('505050'))
			setProperty('Forest.color', getColorFromHex('505050'))
			setProperty('Terrain.color', getColorFromHex('606060'))
			setProperty('Front.color', getColorFromHex('606060'))
			setProperty('boyfriendGroup.color', getColorFromHex('606060'))
			setProperty('dadGroup.color', getColorFromHex('606060'))
			
			setProperty('BGstatic.alpha', 0.4);
			setProperty('Omw.alpha', 0);
			setProperty('dad.alpha', 1);
			setProperty('blacky.alpha', 0);
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			doTweenAlpha('Flash3','flashingshit',0,1.0,'linear')
		end
		if curStep == 216 then
			doTweenAlpha('camHUD1','camHUD',1,1.7,'linear')
		end
		if curStep == 256 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash4','flashingshit',0,1.0,'linear')
			setProperty('BGstatic.alpha', 0.3);
			
			setProperty('sky.color', getColorFromHex('606060'))
			setProperty('Mountains.color', getColorFromHex('606060'))
			setProperty('MainMountains.color', getColorFromHex('606060'))
			setProperty('waterfall.color', getColorFromHex('606060'))
			setProperty('Forest.color', getColorFromHex('606060'))
			setProperty('Terrain.color', getColorFromHex('707070'))
			setProperty('Front.color', getColorFromHex('707070'))
			setProperty('boyfriendGroup.color', getColorFromHex('707070'))
			setProperty('dadGroup.color', getColorFromHex('707070'))
		end
		if curStep == 311 then
			doTweenAlpha('Yessss1','flashingshit',0.4,0.9,'linear')
		end
		if curStep == 320 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash5','flashingshit',0,1.0,'linear')
			setProperty('BGstatic.alpha', 0.2);
			
			setProperty('sky.color', getColorFromHex('606060'))
			setProperty('Mountains.color', getColorFromHex('606060'))
			setProperty('MainMountains.color', getColorFromHex('606060'))
			setProperty('waterfall.color', getColorFromHex('606060'))
			setProperty('Forest.color', getColorFromHex('606060'))
			setProperty('Terrain.color', getColorFromHex('707070'))
			setProperty('Front.color', getColorFromHex('707070'))
			setProperty('boyfriendGroup.color', getColorFromHex('707070'))
			setProperty('dadGroup.color', getColorFromHex('707070'))
		end
		if curStep == 384 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash6','flashingshit',0,1.0,'linear')
			setProperty('BGstatic.alpha', 0.1);
			
			setProperty('sky.color', getColorFromHex('707070'))
			setProperty('Mountains.color', getColorFromHex('707070'))
			setProperty('MainMountains.color', getColorFromHex('707070'))
			setProperty('waterfall.color', getColorFromHex('707070'))
			setProperty('Forest.color', getColorFromHex('707070'))
			setProperty('Terrain.color', getColorFromHex('808080'))
			setProperty('Front.color', getColorFromHex('808080'))
			setProperty('boyfriendGroup.color', getColorFromHex('808080'))
			setProperty('dadGroup.color', getColorFromHex('808080'))
		end
		if curStep == 416 then
			setProperty('blacky.alpha', 0.16);
		end
		if curStep == 420 then
			setProperty('blacky.alpha', 0.32);
		end
		if curStep == 424 then
			setProperty('blacky.alpha', 0.48);
		end
		if curStep == 426 then
			setProperty('blacky.alpha', 0.64);
		end
		if curStep == 428 then
			setProperty('blacky.alpha', 0.80);
		end
		if curStep == 430 then
			setProperty('blacky.alpha', 1);
		end
		if curStep == 440 then
			doTweenAlpha('Yessss2','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 448 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash7','flashingshit',0,1.0,'linear')
			setProperty('BGstatic.alpha', 0);
			setProperty('blacky.alpha', 0);
			
			setProperty('sky.color', getColorFromHex('FFFFFF'))
			setProperty('Mountains.color', getColorFromHex('FFFFFF'))
			setProperty('MainMountains.color', getColorFromHex('FFFFFF'))
			setProperty('waterfall.color', getColorFromHex('FFFFFF'))
			setProperty('Forest.color', getColorFromHex('FFFFFF'))
			setProperty('Terrain.color', getColorFromHex('FFFFFF'))
			setProperty('Front.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriendGroup.color', getColorFromHex('FFFFFF'))
			setProperty('dadGroup.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 952 then
			doTweenAlpha('Yessss3','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 960 then
			setProperty('flashingshit.alpha', 1);
			doTweenAlpha('Flash8','flashingshit',0,1.0,'linear')
			setProperty('sky.alpha',0)
			setProperty('nightSky.alpha',1)
			
			setProperty('Mountains.color', getColorFromHex('414968'))
			setProperty('MainMountains.color', getColorFromHex('3E4560'))
			setProperty('waterfall.color', getColorFromHex('3E4560'))
			setProperty('Forest.color', getColorFromHex('353C54'))
			setProperty('Terrain.color', getColorFromHex('333333'))
			setProperty('Front.color', getColorFromHex('333333'))
			setProperty('boyfriendGroup.color', getColorFromHex('333333'))
			setProperty('dadGroup.color', getColorFromHex('333333'))
		end
		if curStep == 992 then
			setProperty('flashingshit.alpha', 0.2);
			doTweenAlpha('Flash9','flashingshit',0,1.0,'linear')
		end
		if curStep == 1024 then
			setProperty('flashingshit.alpha', 0.3);
			doTweenAlpha('Flash10','flashingshit',0,1.0,'linear')
		end
		if curStep == 1056 then
			setProperty('flashingshit.alpha', 0.4);
			doTweenAlpha('Flash11','flashingshit',0,1.0,'linear')
		end
		if curStep == 1088 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash12','flashingshit',0,1.0,'linear')
			
			setProperty('Mountains.color', getColorFromHex('50597F'))
			setProperty('MainMountains.color', getColorFromHex('4B5477'))
			setProperty('waterfall.color', getColorFromHex('4B5477'))
			setProperty('Forest.color', getColorFromHex('4C4C4C'))
			setProperty('Terrain.color', getColorFromHex('444444'))
			setProperty('Front.color', getColorFromHex('444444'))
			setProperty('boyfriendGroup.color', getColorFromHex('444444'))
			setProperty('dadGroup.color', getColorFromHex('444444'))
		end
		if curStep == 1208 then
			doTweenAlpha('Yessss4','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 1216 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash13','flashingshit',0,1.0,'linear')
			setProperty('sky.alpha',1)
			setProperty('nightSky.alpha',0)
			
			setProperty('Mountains.color', getColorFromHex('FFFFFF'))
			setProperty('MainMountains.color', getColorFromHex('FFFFFF'))
			setProperty('waterfall.color', getColorFromHex('FFFFFF'))
			setProperty('Forest.color', getColorFromHex('FFFFFF'))
			setProperty('Terrain.color', getColorFromHex('FFFFFF'))
			setProperty('Front.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriendGroup.color', getColorFromHex('FFFFFF'))
			setProperty('dadGroup.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 1336 then
			doTweenAlpha('Yessss5','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 1344 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash14','flashingshit',0,1.0,'linear')
		end
		if curStep == 1464 then
			doTweenAlpha('Yessss6','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 1472 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash15','flashingshit',0,1.0,'linear')
		end
		if curStep == 1591 then
			doTweenAlpha('Yessss7','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 1600 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash16','flashingshit',0,1.0,'linear')
		end
		if curStep == 1720 then
			doTweenAlpha('Yessss8','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 1728 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash17','flashingshit',0,1.0,'linear')
			setProperty('sky.alpha',0)
			setProperty('nightSky.alpha',1)
			
			setProperty('Mountains.color', getColorFromHex('414968'))
			setProperty('MainMountains.color', getColorFromHex('3E4560'))
			setProperty('waterfall.color', getColorFromHex('3E4560'))
			setProperty('Forest.color', getColorFromHex('353C54'))
			setProperty('Terrain.color', getColorFromHex('333333'))
			setProperty('Front.color', getColorFromHex('333333'))
			setProperty('boyfriendGroup.color', getColorFromHex('333333'))
			setProperty('dadGroup.color', getColorFromHex('333333'))
		end
		if curStep == 1974 then
			doTweenAlpha('Yessss9','flashingshit',0.4,1.0,'linear')
		end
		if curStep == 1984 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash18','flashingshit',0,1.0,'linear')

			setProperty('Mountains.color', getColorFromHex('50597F'))
			setProperty('MainMountains.color', getColorFromHex('4B5477'))
			setProperty('waterfall.color', getColorFromHex('4B5477'))
			setProperty('Forest.color', getColorFromHex('4C4C4C'))
			setProperty('Terrain.color', getColorFromHex('444444'))
			setProperty('Front.color', getColorFromHex('444444'))
			setProperty('boyfriendGroup.color', getColorFromHex('444444'))
			setProperty('dadGroup.color', getColorFromHex('444444'))
		end
		if curStep == 2112 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash19','flashingshit',0,1.0,'linear')
		end
		if curStep == 2232 then
			setProperty('blacky.alpha', 0.3);
		end
		if curStep == 2236 then
			setProperty('blacky.alpha', 0.6);
		end
		if curStep == 2238 then
			setProperty('blacky.alpha', 1.0);
		end
		if curStep == 2240 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash20','flashingshit',0,1.0,'linear')
			setProperty('blacky.alpha',0)
			setProperty('sky.alpha',1)
			setProperty('nightSky.alpha',0)
			
			setProperty('Mountains.color', getColorFromHex('FFFFFF'))
			setProperty('MainMountains.color', getColorFromHex('FFFFFF'))
			setProperty('waterfall.color', getColorFromHex('FFFFFF'))
			setProperty('Forest.color', getColorFromHex('FFFFFF'))
			setProperty('Terrain.color', getColorFromHex('FFFFFF'))
			setProperty('Front.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriendGroup.color', getColorFromHex('FFFFFF'))
			setProperty('dadGroup.color', getColorFromHex('FFFFFF'))
		end
		if curStep == 2360 then
			doTweenAlpha('Yessss10','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 2368 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash21','flashingshit',0,1.0,'linear')
		end
		if curStep == 2488 then
			doTweenAlpha('Yessss11','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 2496 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash22','flashingshit',0,1.0,'linear')
		end
		if curStep == 2616 then
			doTweenAlpha('Yessss12','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 2624 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash23','flashingshit',0,1.0,'linear')
		end
		if curStep == 2744 then
			doTweenAlpha('Yessss13','flashingshit',0.4,0.8,'linear')
		end
		if curStep == 2752 then
			setProperty('flashingshit.alpha', 1.0);
			doTweenAlpha('Flash24','flashingshit',0,1.0,'linear')
			doTweenAlpha('camHUD2','camHUD',0,1.6,'linear')
			doTweenAlpha('Static2','static',0.6,5.3,'linear')
			doTweenAlpha('overlay1','overlay',1,5.3,'linear')
		end
	end
	
	if cameraMoves == true then
        if mustHitSection == false then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos',xDad-ofsDad,yDad)
			end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos',xDad+ofsDad,yDad)
			end
			if getProperty('dad.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos',xDad,yDad-ofsDad)
			end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos',xDad,yDad+ofsDad)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' then
				triggerEvent('Camera Follow Pos',xDad,yDad)
			end
        else
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xBF-ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xBF+ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xBF,yBF-ofsBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xBF,yBF+ofsBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
                triggerEvent('Camera Follow Pos',xBF-ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
                triggerEvent('Camera Follow Pos',xBF+ofsBF,yBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
                triggerEvent('Camera Follow Pos',xBF,yBF-ofsBF)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
                triggerEvent('Camera Follow Pos',xBF,yBF+ofsBF)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xBF,yBF)
            end
        end
	end
end