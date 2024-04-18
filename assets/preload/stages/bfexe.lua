local xx = 200;
local yy = 300;
local ofs = 15;
local ofs2 = 15;
local xx2 = 400;
local yy2 = 300;
local followchars = true;
local SingBoth = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeAnimatedLuaSprite('IconGame', 'bgs/bfexe/IconGame', 0, -500);
		scaleObject('IconGame', 1, 1);
		addAnimationByPrefix('IconGame', 'boom', 'Idle', 24, false);
		setScrollFactor('IconGame', 1, 1);
		setProperty('IconGame.antialiasing', true);
		addLuaSprite('IconGame', false);
		setProperty('IconGame.alpha',0)
		
		makeLuaSprite('marror1', 'bgs/bfexe/marror1', -280, -150);
		scaleObject('marror1', 0.5, 0.5);
		setScrollFactor('marror1', 1, 1);
		setProperty('marror1.antialiasing', true);
		addLuaSprite('marror1', true);
		
		makeLuaSprite('marror2', 'bgs/bfexe/marror2', -280, -150);
		scaleObject('marror2', 0.5, 0.5);
		setScrollFactor('marror2', 1, 1);
		setProperty('marror2.antialiasing', true);
		addLuaSprite('marror2', false);
		
		makeLuaSprite('floor', 'bgs/bfexe/floor', -850, -630);
		scaleObject('floor', 1, 1);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		setProperty('floor.alpha', 0);
		addLuaSprite('floor', false);
		
		makeLuaSprite('FG', 'bgs/bfexe/FG', -1070, -640);
		scaleObject('FG', 1.1, 1);
		setScrollFactor('FG', 1.3, 1);
		setProperty('FG.antialiasing', true);
		setProperty('FG.alpha', 0);
		addLuaSprite('FG', true);
	end
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
	
	
	
	makeLuaSprite('blackscreen', '', 0, 0);
	makeGraphic('blackscreen',1920,1080,'000000')
	addLuaSprite('blackscreen', true);
	setLuaSpriteScrollFactor('blackscreen',0,0)
	setProperty('blackscreen.scale.x',2)
	setProperty('blackscreen.scale.y',2)
	setProperty('blackscreen.alpha',1)
	
	setProperty('gfGroup.alpha', 1);
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		if curBeat % 2 == 0 then
			objectPlayAnimation('IconGame', 'boom', true)
		else
			objectPlayAnimation('IconGame', 'boom', true)
		end
	end
end

function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 110)
	
	if songName == "face-off" then
		if curStep == 0 then
			setProperty('dad.alpha', 1);
			setProperty('iconP2.alpha', 0)
			setProperty('iconP1.alpha', 0)
			setProperty('healthBar.alpha', 0)
			setProperty('healthBarBG.alpha', 0)
			setProperty('scoreTxt.alpha', 0)
			
			setPropertyFromGroup('opponentStrums',0,'alpha',0)
			setPropertyFromGroup('opponentStrums',1,'alpha',0)
			setPropertyFromGroup('opponentStrums',2,'alpha',0)
			setPropertyFromGroup('opponentStrums',3,'alpha',0)
			
			setPropertyFromGroup('playerStrums',0,'alpha',0)
			setPropertyFromGroup('playerStrums',1,'alpha',0)
			setPropertyFromGroup('playerStrums',2,'alpha',0)
			setPropertyFromGroup('playerStrums',3,'alpha',0)
		end

		if curStep == 116 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.1)
			setPropertyFromGroup('playerStrums',1,'alpha',0.1)
			setPropertyFromGroup('playerStrums',2,'alpha',0.1)
			setPropertyFromGroup('playerStrums',3,'alpha',0.1)
		end  

		if curStep == 117 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.2)
			setPropertyFromGroup('playerStrums',1,'alpha',0.2)
			setPropertyFromGroup('playerStrums',2,'alpha',0.2)
			setPropertyFromGroup('playerStrums',3,'alpha',0.2)
		end
		
		if curStep == 118 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.3)
			setPropertyFromGroup('playerStrums',1,'alpha',0.3)
			setPropertyFromGroup('playerStrums',2,'alpha',0.3)
			setPropertyFromGroup('playerStrums',3,'alpha',0.3)
		end

		if curStep == 119 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.4)
			setPropertyFromGroup('playerStrums',1,'alpha',0.4)
			setPropertyFromGroup('playerStrums',2,'alpha',0.4)
			setPropertyFromGroup('playerStrums',3,'alpha',0.4)
		end
		
		if curStep == 120 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.5)
			setPropertyFromGroup('playerStrums',1,'alpha',0.5)
			setPropertyFromGroup('playerStrums',2,'alpha',0.5)
			setPropertyFromGroup('playerStrums',3,'alpha',0.5)
		end
		
		if curStep == 121 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.6)
			setPropertyFromGroup('playerStrums',1,'alpha',0.6)
			setPropertyFromGroup('playerStrums',2,'alpha',0.6)
			setPropertyFromGroup('playerStrums',3,'alpha',0.6)
		end

		if curStep == 122 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.7)
			setPropertyFromGroup('playerStrums',1,'alpha',0.7)
			setPropertyFromGroup('playerStrums',2,'alpha',0.7)
			setPropertyFromGroup('playerStrums',3,'alpha',0.7)
		end
		
		if curStep == 123 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.8)
			setPropertyFromGroup('playerStrums',1,'alpha',0.8)
			setPropertyFromGroup('playerStrums',2,'alpha',0.8)
			setPropertyFromGroup('playerStrums',3,'alpha',0.8)
		end
		
		if curStep == 124 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.9)
			setPropertyFromGroup('playerStrums',1,'alpha',0.9)
			setPropertyFromGroup('playerStrums',2,'alpha',0.9)
			setPropertyFromGroup('playerStrums',3,'alpha',0.9)
		end

		if curStep == 125 then
			setPropertyFromGroup('playerStrums',0,'alpha',1.0)
			setPropertyFromGroup('playerStrums',1,'alpha',1.0)
			setPropertyFromGroup('playerStrums',2,'alpha',1.0)
			setPropertyFromGroup('playerStrums',3,'alpha',1.0)
		end

		if curStep == 126 then
			doTweenAlpha('blackscreen','blackscreen',0.15,0.5,'linear')
		end
		
		if curStep == 382 then
			SingBoth = false
		end  

		if curStep == 384 then
			doTweenAlpha('blackscreen','blackscreen',1,1.0,'linear')
		end  
		
		if curStep == 385 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.9)
			setPropertyFromGroup('playerStrums',1,'alpha',0.9)
			setPropertyFromGroup('playerStrums',2,'alpha',0.9)
			setPropertyFromGroup('playerStrums',3,'alpha',0.9)
		end
		
		if curStep == 386 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.8)
			setPropertyFromGroup('playerStrums',1,'alpha',0.8)
			setPropertyFromGroup('playerStrums',2,'alpha',0.8)
			setPropertyFromGroup('playerStrums',3,'alpha',0.8)
		end
		
		if curStep == 387 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.7)
			setPropertyFromGroup('playerStrums',1,'alpha',0.7)
			setPropertyFromGroup('playerStrums',2,'alpha',0.7)
			setPropertyFromGroup('playerStrums',3,'alpha',0.7)
		end
		
		if curStep == 388 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.7)
			setPropertyFromGroup('playerStrums',1,'alpha',0.7)
			setPropertyFromGroup('playerStrums',2,'alpha',0.7)
			setPropertyFromGroup('playerStrums',3,'alpha',0.7)
		end
		
		if curStep == 389 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.6)
			setPropertyFromGroup('playerStrums',1,'alpha',0.6)
			setPropertyFromGroup('playerStrums',2,'alpha',0.6)
			setPropertyFromGroup('playerStrums',3,'alpha',0.6)
		end

		if curStep == 390 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.5)
			setPropertyFromGroup('playerStrums',1,'alpha',0.5)
			setPropertyFromGroup('playerStrums',2,'alpha',0.5)
			setPropertyFromGroup('playerStrums',3,'alpha',0.5)
		end
		
		if curStep == 391 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.4)
			setPropertyFromGroup('playerStrums',1,'alpha',0.4)
			setPropertyFromGroup('playerStrums',2,'alpha',0.4)
			setPropertyFromGroup('playerStrums',3,'alpha',0.4)
		end
		
		if curStep == 392 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.3)
			setPropertyFromGroup('playerStrums',1,'alpha',0.3)
			setPropertyFromGroup('playerStrums',2,'alpha',0.3)
			setPropertyFromGroup('playerStrums',3,'alpha',0.3)
		end
		
		if curStep == 393 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.2)
			setPropertyFromGroup('playerStrums',1,'alpha',0.2)
			setPropertyFromGroup('playerStrums',2,'alpha',0.2)
			setPropertyFromGroup('playerStrums',3,'alpha',0.2)
		end
		
		if curStep == 394 then
			setPropertyFromGroup('playerStrums',0,'alpha',0.1)
			setPropertyFromGroup('playerStrums',1,'alpha',0.1)
			setPropertyFromGroup('playerStrums',2,'alpha',0.1)
			setPropertyFromGroup('playerStrums',3,'alpha',0.1)
		end  

		if curStep == 394 then
			setPropertyFromGroup('playerStrums',0,'alpha',0)
			setPropertyFromGroup('playerStrums',1,'alpha',0)
			setPropertyFromGroup('playerStrums',2,'alpha',0)
			setPropertyFromGroup('playerStrums',3,'alpha',0)
		end  

		if curStep == 448 then
			setProperty('blackscreen.alpha',0)
			setProperty('flashingshit.alpha',1)
			if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('IconGame.alpha',1)
			end
			
			setProperty('dad.x', -350)
			setProperty('defaultCamZoom',0.6)
			
			setProperty('marror1.alpha', 0)
			setProperty('marror2.alpha', 0)
			setProperty('FG.alpha', 1);
			setProperty('floor.alpha', 1);
			setProperty('dad.alpha', 1);
			setProperty('iconP2.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
			
			setPropertyFromGroup('opponentStrums',0,'alpha',1)
			setPropertyFromGroup('opponentStrums',1,'alpha',1)
			setPropertyFromGroup('opponentStrums',2,'alpha',1)
			setPropertyFromGroup('opponentStrums',3,'alpha',1)
			
			setPropertyFromGroup('playerStrums',0,'alpha',1)
			setPropertyFromGroup('playerStrums',1,'alpha',1)
			setPropertyFromGroup('playerStrums',2,'alpha',1)
			setPropertyFromGroup('playerStrums',3,'alpha',1)
		end  
		
		if curStep == 450 then
			doTweenAlpha('flashingshit','flashingshit',0,0.8,'linear')
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

            if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeR' or getProperty('boyfriend.animation.curAnim.name') == 'dodgeL' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
		
        end
    
        triggerEvent('Camera Follow Pos','','')
    
	end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function goodNoteHit(membersIndex, direction, noteData, noteType, isSustainNote)
	if SingBoth then
		characterPlayAnim('dad', singAnims[direction + 1], true);
	end
end