local xx = 900;
local yy = 550;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1000;
local yy2 = 600;
local followchars = true;
local flash = 0;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/jp/sky', 0, -200);
		scaleObject('sky', 1, 1);
		setScrollFactor('city', 0.2, 0.5);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false);
		
		makeLuaSprite('city', 'bgs/jp/city', -100, 0);
		scaleObject('city', 1, 1);
		setScrollFactor('city', 0.5, 0.7);
		setProperty('city.antialiasing', true);
		addLuaSprite('city', false);
		
		makeLuaSprite('ground', 'bgs/jp/ground', 0, 0);
		scaleObject('ground', 1, 1);
		setScrollFactor('ground', 1, 1);
		setProperty('ground.antialiasing', true);
		addLuaSprite('ground', false);
		
		makeLuaSprite('secondBg', 'bgs/jp/bg-2', 0, 0);
		scaleObject('secondBg', 1, 1);
		setScrollFactor('secondBg', 1, 1);
		setProperty('secondBg.antialiasing', true);
		addLuaSprite('secondBg', false);
		setProperty('secondBg.alpha', 0);
	end
	
	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',2)
	setProperty('blk.scale.y',2)
	setProperty('blk.alpha',1)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('flashin', 'blueVgV', 0, 0, 'exe');
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.alpha',0)
	setObjectCamera('flashin', 'camOther')
	setGraphicSize('flashin', FlxG.width, FlxG.height)
	
end

function onBeatHit()
	if flash == 1 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha',0.35)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if flash == 2 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha',0.35)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flash');
			setProperty('flashin.alpha',0.35)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "endless-jp" then
		if curStep == 0 then
			setProperty('camHUD.alpha',0)
		end
		if curStep == 1 then
			setProperty('flashingshit.color', getColorFromHex('6600FF'))
			doTweenAlpha('purp','flashingshit',0.3,0.4,'linear')
		end
		if curStep == 6 then
			flash = 2;
			setProperty('blk.alpha',0)
			setProperty('flashin.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh1','flashingshit',0,1,'linear')
		end
		if curStep == 112 then
			doTweenAlpha('camHud1','camHUD',0.65,1,'linear')
		end
		if curStep == 262 then
			setProperty('defaultCamZoom',0.95)
			flash = 1;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0.2)
				setProperty('city.alpha',0.4)
			end
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh2','flashingshit',0,1,'linear')
			xx = 700;
			yy = 600;
			xx2 = 1200;
			yy2 = 650;
		end
		if curStep == 384 then
			setProperty('defaultCamZoom',0.85)
			doTweenAlpha('blk1','blk',1,0.6,'linear')
			flash = 0;
		end
		if curStep == 398 then
			setProperty('defaultCamZoom',0.95)
			flash = 1;
			setProperty('blk.alpha',0)
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh3','flashingshit',0,1,'linear')
		end
		if curStep == 518 then
			setProperty('defaultCamZoom',0.8)
			flash = 2;
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh4','flashingshit',0,1,'linear')
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('sky1','sky',1,0.6,'linear')
				doTweenAlpha('city1','city',1,0.6,'linear')
			end
			xx = 900;
			yy = 550;
			xx2 = 1000;
			yy2 = 600;
		end
		if curStep == 646 or curStep == 662 or curStep == 670 or curStep == 678 or curStep == 694 or curStep == 706 or curStep == 714 or curStep == 722 or curStep == 734 or curStep == 746 or curStep == 754 or curStep == 766 or curStep == 782 or curStep == 794 or curStep == 802 or curStep == 814 then
			cancelTween('fl');
			setProperty('flashingshit.alpha',0.35)
			doTweenAlpha('fl','flashingshit',0,0.5,'linear')
			setProperty('defaultCamZoom',0.95)
		end
		if curStep == 654 or curStep == 666 or curStep == 674 or curStep == 686 or curStep == 702 or curStep == 710 or curStep == 718 or curStep == 726 or curStep == 742 or curStep == 750 or curStep == 758 or curStep == 774 or curStep == 790 or curStep == 798 or curStep == 806 or curStep == 822 then
			cancelTween('fl');
			setProperty('flashingshit.alpha',0.35)
			doTweenAlpha('fl','flashingshit',0,0.5,'linear')
			setProperty('defaultCamZoom',0.8)
		end
		if curStep == 886 then
			setProperty('blk.alpha',1)
			setProperty('defaultCamZoom',0.95)
			flash = 0;
		end
		if curStep == 902 then
			setProperty('defaultCamZoom',0.8)
			setProperty('blk.alpha',0)
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh5','flashingshit',0,1,'linear')
			flash = 2;
		end
		if curStep == 1094 then
			setProperty('defaultCamZoom',0.95)
			xx = 700;
			yy = 600;
			xx2 = 1200;
			yy2 = 650;
		end
		if curStep == 1142 then
			setProperty('blk.alpha',1)
			setProperty('defaultCamZoom',0.95)
			flash = 0;
		end
		if curStep == 1158 then
			setProperty('defaultCamZoom',0.85)
			setProperty('blk.alpha',0)
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh6','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			xx = 900;
			yy = 550;
			xx2 = 1000;
			yy2 = 600;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('sky.alpha',0)
				setProperty('city.alpha',0)
				setProperty('ground.alpha',0)
				setProperty('secondBg.alpha',1)
			end
		end
		if curStep == 1290 then
			setProperty('defaultCamZoom',0.95)
			xx = 700;
			yy = 600;
			xx2 = 1200;
			yy2 = 650;
		end
		if curStep == 1410 then
			setProperty('defaultCamZoom',0.85)
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh7','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.8)
			flash = 2;
			xx = 900;
			yy = 550;
			xx2 = 1000;
			yy2 = 600;
		end
		if curStep == 1478 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh8','flashingshit',0,1,'linear')
		end
		if curStep == 1541 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh9','flashingshit',0,1,'linear')
		end
		if curStep == 1606 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh10','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.95)
			xx = 700;
			yy = 600;
			xx2 = 1200;
			yy2 = 650;
		end
		if curStep == 1654 then
			setProperty('blk.alpha',1)
			setProperty('defaultCamZoom',0.95)
			flash = 0;
		end
		if curStep == 1666 then
			doTweenAlpha('blk2','blk',0,0.8,'linear')
		end
		if curStep == 1674 then
			setProperty('defaultCamZoom',0.85)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh11','flashingshit',0,1,'linear')
			flash = 2;
		end
		if curStep == 1734 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh12','flashingshit',0,1,'linear')
		end
		if curStep == 1798 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh13','flashingshit',0,1,'linear')
		end
		if curStep == 1862 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh14','flashingshit',0,1,'linear')
		end
		if curStep == 1926 then
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh15','flashingshit',0,1,'linear')
			doTweenAlpha('camHud2','camHUD',0,0.65,'linear')
			flash = 0;
		end
		if curStep == 1958 then
			setProperty('flashingshit.alpha',0.7)
			doTweenAlpha('flsh16','flashingshit',0,2,'linear')
			doTweenAlpha('blk3','blk',1,4,'linear')
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