local xx = 600;
local yy = 1000;
local ofs = 40;
local ofs2 = 40;
local xx2 = 900;
local yy2 = 1100;
local followchars = true;
local beat = 0;
local flash = -1;
local flashAlpha = 0.3;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bga', 'bgs/sally-bg/bg', -1300, -500);
		scaleObject('bga', 3, 3);
		setScrollFactor('bga', 0.15, 0.5);
		setProperty('bga.antialiasing', true);
		addLuaSprite('bga', false)
		
		makeLuaSprite('mount1', 'bgs/sally-bg/mount1', -1000, -200);
		scaleObject('mount1', 2.5, 2.5);
		setScrollFactor('mount1', 0.25, 0.8);
		setProperty('mount1.antialiasing', true);
		addLuaSprite('mount1', false)
		
		makeLuaSprite('mount2', 'bgs/sally-bg/mount2', -1000, -300);
		scaleObject('mount2', 2.5, 2.5);
		setScrollFactor('mount2', 0.4, 0.85);
		setProperty('mount2.antialiasing', true);
		addLuaSprite('mount2', false)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('bridgeB', 'bgs/sally-bg/bridgeB', -1000, -300);
			scaleObject('bridgeB', 2.6, 2.5);
			setScrollFactor('bridgeB', 0.6, 0.90);
			setProperty('bridgeB.antialiasing', true);
			addLuaSprite('bridgeB', false)
			
			makeAnimatedLuaSprite('shadow', 'bgs/sally-bg/shadow-alt', -1000, -450);
			scaleObject('shadow', 2.5, 2.5);
			addAnimationByPrefix('shadow', 'shadow-appears', 'shadow-appears', 18, false);
			addAnimationByPrefix('shadow', 'shadow-idle', 'shadow-idle', 24, true);
			addAnimationByPrefix('shadow', 'idle', 'idle', 24, true);
			objectPlayAnimation('shadow', 'idle', true)
			setProperty('shadow.antialiasing', true);
			addLuaSprite('shadow', false);
		else
			makeLuaSprite('bridgeF', 'bgs/sally-bg/bridgeF', -1000, -200);
			scaleObject('bridgeF', 2.5, 2.5);
			setScrollFactor('bridgeF', 1, 1);
			setProperty('bridgeF.antialiasing', true);
			addLuaSprite('bridgeF', false)
		end
	end

	makeLuaSprite('redBG', '', 0, 0);
	makeGraphic('redBG',1920,1080,'9E0000')
	addLuaSprite('redBG', false);
	setLuaSpriteScrollFactor('redBG',0,0)
	setProperty('redBG.scale.x',4)
	setProperty('redBG.scale.y',4)
	setProperty('redBG.alpha',0)

	makeLuaSprite('blk', '', 0, 0);
	makeGraphic('blk',1920,1080,'000000')
	addLuaSprite('blk', true);
	setLuaSpriteScrollFactor('blk',0,0)
	setProperty('blk.scale.x',4)
	setProperty('blk.scale.y',4)
	setProperty('blk.alpha',0)
	
	makeLuaSprite('blks', '', 0, 0);
	makeGraphic('blks',1920,1080,'000000')
	addLuaSprite('blks', false);
	setLuaSpriteScrollFactor('blks',0,0)
	setProperty('blks.scale.x',4)
	setProperty('blks.scale.y',4)
	setProperty('blks.alpha',0)
	
	makeLuaSprite('reds', '', 0, 0);
	makeGraphic('reds',1920,1080,'FF0000')
	addLuaSprite('reds', false);
	setLuaSpriteScrollFactor('reds',0,0)
	setProperty('reds.scale.x',4)
	setProperty('reds.scale.y',4)
	setProperty('reds.alpha',0)

	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FF0000')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)
	
	makeLuaSprite('flashin', 'RedVG', 0, 0, 'exe');
	addLuaSprite('flashin', true);
	setLuaSpriteScrollFactor('flashin',0,0)
	setProperty('flashin.alpha',0)
	setObjectCamera('flashin', 'camOther')
	setGraphicSize('flashin', FlxG.width, FlxG.height)
end

function onBeatHit()
	if beat == -1 then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom')
		end
	end
	if beat == 1 then
		if curBeat % 2 == 0 then
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
	if flash == -1 then
		if curBeat % 4 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		end
	end
	if flash == 1 then
		if curBeat % 2 == 0 then
			cancelTween('flash');
			setProperty('flashin.alpha', flashAlpha)
			doTweenAlpha('flash','flashin',0,0.7,'linear')
		end
	end
	if flash == 2 then
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

function hideUi(yes)
	if yes == true then
		doTweenAlpha('timeBarBGDis','timeBarBG',0,0.08,'linear')
		doTweenAlpha('timeBarDis','timeBar',0,0.08,'linear')
		doTweenAlpha('timeTxtDis','timeTxt',0,0.08,'linear')
		doTweenAlpha('scoreTxtDis','scoreTxt',0,0.08,'linear')
		doTweenAlpha('healthBarBGDis','healthBarBG',0,0.08,'linear')
		doTweenAlpha('healthBarDis','healthBar',0,0.08,'linear')
		doTweenAlpha('iconP1Dis','iconP1',0,0.08,'linear')
		doTweenAlpha('iconP2Dis','iconP2',0,0.08,'linear')
	end
	if yes == false then
		doTweenAlpha('timeBarBGEnb','timeBarBG',1,0.08,'linear')
		doTweenAlpha('timeBarEnb','timeBar',1,0.08,'linear')
		doTweenAlpha('timeTxtEnb','timeTxt',1,0.08,'linear')
		doTweenAlpha('scoreTxtEnb','scoreTxt',1,0.08,'linear')
		doTweenAlpha('healthBarBGEnb','healthBarBG',1,0.08,'linear')
		doTweenAlpha('healthBarEnb','healthBar',1,0.08,'linear')
		doTweenAlpha('iconP1Enb','iconP1',1,0.08,'linear')
		doTweenAlpha('iconP2Enb','iconP2',1,0.08,'linear')
	end
end

function hideTimebar(no)
	if no == true then
		doTweenAlpha('timeBarBGDis','timeBarBG',0,0.08,'linear')
		doTweenAlpha('timeBarDis','timeBar',0,0.08,'linear')
		doTweenAlpha('timeTxtDis','timeTxt',0,0.08,'linear')
	end
	if no == false then
		doTweenAlpha('timeBarBGEnb','timeBarBG',1,0.08,'linear')
		doTweenAlpha('timeBarEnb','timeBar',1,0.08,'linear')
		doTweenAlpha('timeTxtEnb','timeTxt',1,0.08,'linear')
	end
end


function onUpdate()
	if songName == "goddess" then
		if curStep == 1 then
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
		end
		if curStep == 48 then
			beat = 1;
			flash = 1;
		end
		if curStep == 120 then
			doTweenAlpha('blkScreen','blk',1,0.5,'linear')
		end
		if curStep == 128 then
			setProperty('blk.alpha',0)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
			beat = -1;
			flash = -1;
		end
		if curStep == 176 then
			beat = 1;
			flash = 1;
		end
		if curStep == 256 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 366 then
			hideUi(true);
			doTweenAlpha('redBG','redBG',1,0.1,'linear')
			doTweenAlpha('blkScreen','blk',1,0.1,'linear')
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
		end
		if curStep == 368 then
			setProperty('dad.color', getColorFromHex('000000'))
			setProperty('boyfriend.color', getColorFromHex('000000'))
			doTweenAlpha('blkScreen','blk',0,0.1,'linear')
			beat = 0;
			flash = 0;
		end
		if curStep == 380 then
			hideUi(false);
			doTweenAlpha('redBG','redBG',0,0.4,'linear')
			doTweenAlpha('blkScreen','blk',1,0.1,'linear')
		end
		if curStep == 384 then
			setProperty('dad.color', getColorFromHex('FFFFFF'))
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('blk.alpha',0)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
			beat = 2;
			flash = 2;
		end
		if curStep == 496 or curStep == 624 then
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
			beat = 1;
			flash = 1;
		end
		if curStep == 512 or curStep == 640 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
			beat = 2;
			flash = 2;
		end
		if curStep == 656 or curStep == 688 or curStep == 720 or curStep == 752 then
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
		end
		if curStep == 672 or curStep == 696 or curStep == 736 or curStep == 768 then
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
		end
		if curStep == 696 or curStep == 704 or curStep == 760 then
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
		end
		if curStep == 688 or curStep == 752 or curStep == 1024 then
			beat = 1;
			flash = 1;
		end
		if curStep == 704 or curStep == 768 then
			beat = 2;
			flash = 2;
		end
		if curStep == 768 or curStep == 896 or curStep == 1024 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 1024 then
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
		end
		if curStep == 1120 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bg1','bga',0.5,0.2,'linear')
				doTweenAlpha('bg2','mount1',0.5,0.2,'linear')
				doTweenAlpha('bg3','mount2',0.5,0.2,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bg4','bridgeB',0.5,0.2,'linear')
				end
			end
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
		end
		if curStep == 1152 then
			hideTimebar(true);
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bg1','bga',1,0.2,'linear')
				doTweenAlpha('blks','blks',0.7,0.2,'linear')
				doTweenAlpha('bg2','mount1',1,0.2,'linear')
				doTweenAlpha('bg3','mount2',1,0.2,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bg4','bridgeB',1,0.2,'linear')
				end
			end
			cancelTween('blackflashlol');
			setProperty('blackflashlol.alpha',1)
			doTweenAlpha('blackflashlol','blk',0,1,'linear')
			setProperty('defaultCamZoom',0.55)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
			beat = -1;
			flash = -1;
		end
		if curStep == 1392 then
			beat = 1;
			flash = 1;
		end
		if curStep == 1395 then
			doTweenAlpha('reds','reds',1,1,'linear')
		end
		if curStep == 1408 then
			hideTimebar(false);	
			doTweenAlpha('reds','reds',0,0.2,'linear')
			doTweenAlpha('blks','blks',0,0.2,'linear')
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
			beat = 2;
			flash = 2;
		end
		if curStep == 1582 or curStep == 1646 then
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
			beat = 1;
			flash = 1;
		end
		if curStep == 1600 or curStep == 1664 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
			beat = 2;
			flash = 2;
		end
		if curStep == 1776 or curStep == 1904 then
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
		end
		if curStep == 1792 then
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
		end
		if curStep == 1904 then
			beat = 0;
			flash = 0;
		end
		if curStep == 1920 then
			beat = 1;
			flash = 1;
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bg1','bga',0.5,0.2,'linear')
				doTweenAlpha('bg2','mount1',0.5,0.2,'linear')
				doTweenAlpha('bg3','mount2',0.5,0.2,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bg4','bridgeB',0.75,0.2,'linear')
				end
			end
		end
		if curStep == 2048 then
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				doTweenAlpha('bg1','bga',1,0.2,'linear')
				doTweenAlpha('bg2','mount1',1,0.2,'linear')
				doTweenAlpha('bg3','mount2',1,0.2,'linear')
				if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
					doTweenAlpha('bg4','bridgeB',1,0.2,'linear')
				end
			end
			doTweenAlpha('blkScreen','blk',1,1.1,'linear')
			doTweenAlpha('CH','camHUD',0,1.1,'linear')
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
			beat = 0;
			flash = 0;
		end
		if curStep == 2160 then
			setProperty('blk.alpha',0)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('CH','camHUD',1,0.5,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
			beat = -1;
			flash = -1;
		end
		if curStep == 2400 then
			doTweenAlpha('blkScreen','blk',1,1.1,'linear')
			doTweenAlpha('CH','camHUD',0,1.1,'linear')
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
			beat = 0;
			flash = 0;
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				objectPlayAnimation('shadow', 'shadow-appears', false)
			end
		end
		if curStep == 2425 then
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				objectPlayAnimation('shadow', 'shadow-idle', true)
			end
		end
		if curStep == 2448 then
			setProperty('blk.alpha',0)
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			doTweenAlpha('CH','camHUD',1,0.5,'linear')
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
			beat = 2;
			flash = 2;
		end
		if curStep == 2704 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			setProperty('defaultCamZoom',0.5)
			xx = 600;
			yy = 1100;
			xx2 = 900;
			yy2 = 1200;
		end
		if curStep == 2832 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
		end
		if curStep == 2944 then
			beat = 1;
			flash = 1;
		end
		if curStep == 2960 then
			setProperty('defaultCamZoom',0.6)
			xx = 600;
			yy = 1200;
			xx2 = 900;
			yy2 = 1300;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 1;
			flash = -1;
		end
		if curStep == 3088 then
			setProperty('defaultCamZoom',0.45)
			xx = 600;
			yy = 1000;
			xx2 = 900;
			yy2 = 1100;
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 1;
			flash = 1;
		end
		if curStep == 3232 then
			cancelTween('flsh');
			setProperty('flashingshit.color', getColorFromHex('FF0000'))
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('flsh','flashingshit',0,1,'linear')
			beat = 0;
			flash = 0;
			doTweenAlpha('blkScreen','blk',1,2.3,'linear')
			doTweenAlpha('CH','camHUD',0,1.7,'linear')
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