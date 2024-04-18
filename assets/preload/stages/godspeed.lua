local xx = 275;
local yy = 500;
local ofs = 50;
local ofs2 = 50;
local xx2 = 900;
local yy2 = 500;
local followchars = true;
local flashSpeed = 0;

function onCreate()
	makeAnimatedLuaSprite('BFlegs', 'characters/BF/HD/Running/bf-godspeed-legs', 820, 600);
	scaleObject('BFlegs', 1, 1);
	addAnimationByPrefix('BFlegs', 'run', 'run', 35, true);
	setScrollFactor('BFlegs', 1, 1);
	setProperty('BFlegs.antialiasing', false);
	setProperty('BFlegs.alpha',1)
	addLuaSprite('BFlegs', true);
	
	makeLuaSprite('black', 'Black', -1000, -1000);
	addLuaSprite('black', true);
	setLuaSpriteScrollFactor('black',0,0)
	scaleObject('black', 2,2)
	setProperty('black.alpha',0.4)
	
	makeLuaSprite('Blacky', '', 0, 0);
	addLuaSprite('Blacky', true);
	setLuaSpriteScrollFactor('Blacky',0,0)
	setProperty('Blacky.scale.x',2)
	setProperty('Blacky.scale.y',2)
	setProperty('Blacky.alpha',0)
	
	makeLuaSprite('RedVG', 'RedVG', 0, 0, 'exe');
	setLuaSpriteScrollFactor('RedVG',0,0)
	scaleObject('RedVG',2,2)
	screenCenter('RedVG');
	setProperty('RedVG.alpha',0)
	addLuaSprite('RedVG', true);
end

function onTimerCompleted(tag)
	if flashSpeed == 1 then
		if tag == 'redVG1' then
			doTweenAlpha('VG3','RedVG',0.25,0.7,'linear')
			runTimer('redVG2', 0.7)
		end
		if tag == 'redVG2' then
			doTweenAlpha('VG3','RedVG',0,0.7,'linear')
			runTimer('redVG1', 0.7)
		end
	end

	if flashSpeed == 2 then
		if tag == 'redVG1' then
			doTweenAlpha('VG3','RedVG',0.5,0.55,'linear')
			runTimer('redVG2', 0.55)
		end
		if tag == 'redVG2' then
			doTweenAlpha('VG3','RedVG',0,0.55,'linear')
			runTimer('redVG1', 0.55)
		end
	end

	if flashSpeed == 3 then
		if tag == 'redVG1' then
			doTweenAlpha('VG3','RedVG',0.6,0.4,'linear')
			runTimer('redVG2', 0.4)
		end
		if tag == 'redVG2' then
			doTweenAlpha('VG3','RedVG',0.2,0.4,'linear')
			runTimer('redVG1', 0.4)
		end
	end

	if flashSpeed == 4 then
		if tag == 'redVG1' then
			doTweenAlpha('VG4','RedVG',0.8,0.25,'linear')
			runTimer('redVG2', 0.25)
		end
		if tag == 'redVG2' then
			doTweenAlpha('VG4','RedVG',0.4,0.25,'linear')
			runTimer('redVG1', 0.25)
		end
	end

	if flashSpeed == 5 then
		if tag == 'redVG1' then
			doTweenAlpha('VG5','RedVG',1,0.10,'linear')
			runTimer('redVG2', 0.10)
		end
		if tag == 'redVG2' then
			doTweenAlpha('VG5','RedVG',0.65,0.10,'linear')
			runTimer('redVG1', 0.10)
		end
	end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "godspeed" then
		if curStep == 0 then
			flashSpeed = 1;
			runTimer('redVG1', 0.1)
			
			if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
				setProperty('timeBarBG.x', 750)
				setProperty('timeBar.x', 750)
				setProperty('timeTxt.x', 750)
			end
		end
	
		if curStep == 2 then
			doTweenX('dad', 'dad', -500, 220);
		end
		
		if curStep == 672 then
			flashSpeed = 2;
		end
		
		if curStep == 1312 then
			flashSpeed = 3;
		end
		
		if curStep == 2276 then
			flashSpeed = 4;
		end
		
		if curStep == 2780 then
			doTweenAlpha('BlackyT1','Blacky',1,0.5,'linear')
		end
		
		if curStep == 3080 then
			flashSpeed = 0;
			setProperty('RedVG.alpha',1)
			doTweenAlpha('RVGEnd','RedVG',0,2,'linear')
			doTweenAlpha('BlackyT2','Blacky',1,2.5,'linear')
			doTweenAlpha('camHUDT','camHUD',0,1.7,'linear')
			doTweenAlpha('camGAMET','camGame',0,1.7,'linear')
			doTweenX('dadAaa', 'dad', -2300, 4);
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

            if getProperty('boyfriend.animaion.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
        triggerEvent('Camera Follow Pos','','')
	end
end
	