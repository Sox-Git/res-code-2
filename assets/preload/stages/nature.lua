local xx = 250;
local yy = 300;
local xx2 = 620;
local yy2 = 300;
local ofs = 10;
local ofs2 = 10;
local followchars = true;
local PhaseTwo = false;

function onCreate()
	makeLuaSprite('sky', 'bgs/nature/sky', -1400, -800);
	scaleObject('sky', 1.4, 1.4);
	setScrollFactor('sky', 1.05, 1.05);
	setProperty('sky.antialiasing', true);
	addLuaSprite('sky', false);
	
	makeLuaSprite('montains', 'bgs/nature/montains', -1000, 0);
	scaleObject('montains', 1.4, 1.4);
	setScrollFactor('montains', 1, 1);
	setProperty('montains.antialiasing', true);
	addLuaSprite('montains', false);
	
	makeLuaSprite('floor', 'bgs/nature/floor', -1400, 500);
	scaleObject('floor', 1.6, 1.6);
	setScrollFactor('floor', 1, 1);
	setProperty('floor.antialiasing', true);
	addLuaSprite('floor', false);
	
	makeLuaSprite('arbutos', 'bgs/nature/arbutos', -1600, 300);
	scaleObject('arbutos', 1.6, 1.6);
	setScrollFactor('arbutos', 1, 1);
	setProperty('arbutos.antialiasing', true);
	addLuaSprite('arbutos', false);
	
	makeLuaSprite('nyyom', '', 0, 0);
	makeGraphic('nyyom',1920,1080,'FFFFFF')
	addLuaSprite('nyyom', true);
	setLuaSpriteScrollFactor('nyyom',0,0)
	setProperty('nyyom.scale.x',2)
	setProperty('nyyom.scale.y',2)
	setProperty('nyyom.alpha',0)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFF00')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
end

function onTimerCompleted(tag)
	if PhaseTwo == true then
		if tag == 'Chu-Fly Up' then
			doTweenY('Chu-TweenUp', 'dad', -170, 2, 'quadInOut')
			runTimer('Chu-Fly Down', 2, 1)
		end
		if tag == 'Chu-Fly Down' then
			doTweenY('Chu-TweenDown', 'dad', -120, 1.5, 'quadInOut')
			runTimer('Chu-Fly Up', 1.5, 1)
		end
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)

	if songName == "extreme-zap" then
		if curStep == 256 then
			setProperty('nyyom.alpha',1)
			doTweenAlpha('Flash0','nyyom',0,1,'linear')
		end
	
		if curStep == 480 then
			doTweenAlpha('Nyom','nyyom',1,2.5,'linear')
		end

		if curStep == 512 then
			setProperty('nyyom.alpha',0)
			setProperty('flashingshit.alpha',1)
			doTweenAlpha('Flash1','flashingshit',0,1,'linear')
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

            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
    
end