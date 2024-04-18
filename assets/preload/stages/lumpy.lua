local xx = 1200;
local yy = 750;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1300;
local yy2 = 800;
local followchars = true;
local flash = 0;
local flashAlpha = 0.5;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bgO', 'bgs/lumpy/bg-1', 0, 0);
		scaleObject('bgO', 1.3, 1.3);
		setScrollFactor('bgO', 1, 1);
		setProperty('bgO.antialiasing', true);
		addLuaSprite('bgO', false);
		setProperty('bgO.alpha',0)
		
		makeLuaSprite('bgT', 'bgs/lumpy/bg-2', 0, 0);
		scaleObject('bgT', 1.3, 1.3);
		setScrollFactor('bgT', 1, 1);
		setProperty('bgT.antialiasing', true);
		addLuaSprite('bgT', false);
		setProperty('bgT.alpha',0)
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
	
	makeLuaSprite('flashin', 'GreyVG', 0, 0, 'exe');
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
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if flash == 2 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		else
			cancelTween('flash');
			setProperty('flashin.alpha',flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
			triggerEvent('Add Camera Zoom')
			triggerEvent('Add Camera Zoom')
		end
	end
	if flash == 3 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		end
	end
	if flash == 4 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		else
			cancelTween('flash');
			setProperty('flashin.alpha',flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		end
	end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "frenzy" then
		if curStep == 0 then
			setProperty('camHUD.alpha',0)
			setProperty('boyfriend.alpha',0)
			xx = 950;
			yy = 750;
			ofs = 0;
			ofs2 = 0;
			xx2 = 950;
			yy2 = 750;
		end
		if curStep == 20 then
			doTweenAlpha('blkT1','blk',0,24.3,'linear')
		end
		if curStep == 236 then
			xx = 850;
			yy = 750;
			xx2 = 850;
			yy2 = 750;
		end
		if curStep == 237 or curStep == 244 or curStep == 251 then
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			cancelTween('hahaflash');
			setProperty('flashingshit.alpha',0.5)
			doTweenAlpha('hahaflash','flashingshit',0,0.7,'linear')
		end
		if curStep == 256 then
			cancelTween('blkT1');
			setProperty('blk.alpha',0)
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			xx = 1200;
			yy = 750;
			ofs = 15;
			ofs2 = 15;
			xx2 = 1300;
			yy2 = 800;
			setProperty('defaultCamZoom',0.6)
			setProperty('boyfriend.alpha',1)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bgO.alpha',1)
			end
			flash = 3;
		end
		if curStep == 256 then
			xx = 1200;
			yy = 800;
			xx2 = 1300;
			yy2 = 850;
			setProperty('defaultCamZoom',0.85)
		end
		if curStep == 304 then
			doTweenAlpha('hud1','camHUD',1,1.4,'linear')
		end
		if curStep == 512 then
			xx = 1200;
			yy = 750;
			xx2 = 1300;
			yy2 = 800;
			setProperty('defaultCamZoom',0.6)
		end
		if curStep == 768 then
			xx = 1100;
			yy = 800;
			xx2 = 1400;
			yy2 = 850;
			setProperty('defaultCamZoom',1.1)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bgOT1','bgO',0.5,0.3,'linear')
			end
			flash = 0;
			doTweenAlpha('hud2','camHUD',0.5,0.3,'linear')
		end
		if curStep == 784 then
			doTweenAlpha('hud3','camHUD',1,0.5,'linear')
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			xx = 1200;
			yy = 800;
			xx2 = 1300;
			yy2 = 850;
			setProperty('defaultCamZoom',0.85)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bgT.alpha',1)
				setProperty('bgO.alpha',0)
			end
			flash = 4;
		end
		if curStep == 898 or curStep == 926 or curStep == 962 or curStep == 990 or curStep == 1026 then
			xx = 1200;
			yy = 750;
			xx2 = 1300;
			yy2 = 800;
			setProperty('defaultCamZoom',0.6)
		end
		if curStep == 914 or curStep == 942 or curStep == 978 or curStep == 1006 then
			xx = 1200;
			yy = 800;
			xx2 = 1300;
			yy2 = 850;
			setProperty('defaultCamZoom',0.85)
		end
		if curStep == 1040 then
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			xx = 1200;
			yy = 800;
			xx2 = 1300;
			yy2 = 850;
			setProperty('defaultCamZoom',0.85)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bgT.alpha',0)
				setProperty('bgO.alpha',1)
			end
			flash = 3;
		end
		if curStep == 1168 then
			xx = 1200;
			yy = 750;
			xx2 = 1300;
			yy2 = 800;
			setProperty('defaultCamZoom',0.6)
		end
		if curStep == 1296 or curStep == 1680 then
			setProperty('flashingshit.color', getColorFromHex('FFFFFF'))
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			xx = 1200;
			yy = 800;
			xx2 = 1300;
			yy2 = 850;
			setProperty('defaultCamZoom',0.85)
		end
		if curStep == 1424 then
			xx = 1200;
			yy = 750;
			xx2 = 1300;
			yy2 = 800;
			setProperty('defaultCamZoom',0.6)
		end
		if curStep == 1792 then
			doTweenAlpha('blkT2','blk',1,1.4,'linear')
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bgOT2','bgO',0,1.4,'linear')
			end
		end
		if curStep == 1808 then
			setProperty('flashingshit.color', getColorFromHex('000000'))
			cancelTween('flsh');
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			xx = 1200;
			yy = 800;
			xx2 = 1300;
			yy2 = 850;
			setProperty('defaultCamZoom',0.85)
			setProperty('blk.alpha',0)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('bgT.alpha',1)
			end
			flash = 0;
		end
		if curStep == 2000 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bgTT1','bgT',0,4,'linear')
			end
			doTweenAlpha('blkT3','blk',1,8,'linear')
			doTweenAlpha('hud4','camHUD',0,7.5,'linear')
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