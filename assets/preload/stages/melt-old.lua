local xx = 550;
local yy = 220;
local ofs = 15;
local ofs2 = 15;
local xx2 = 1050;
local yy2 = 220;
local SingBoth = false;
local followchars = true;

function onCreate()
	makeAnimatedLuaSprite('bg', 'bgs/melt-old/BG', -900, -900);
	scaleObject('bg', 7.00, 7.00);
	addAnimationByPrefix('bg', 'idle', 'BG', 12, true);
	setScrollFactor('bg', 1, 1);
	setProperty('bg.antialiasing', false);
	addLuaSprite('bg', false);
	
	makeLuaSprite('floor', 'bgs/melt-old/Terrain ', -900, -1080);
	scaleObject('floor', 7.00, 7.00);
	setProperty('floor.antialiasing', false);
	addLuaSprite('floor', false);
	
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
	
	setProperty('bgS.alpha',0)
	setProperty('floorS.alpha',0)
	setProperty('camHUD.alpha', 0);
	setProperty('gfGroup.alpha', 0);
end

function onStepHit()
	if songName == "melting-old" or songName == "Melting-Old" then
		if curStep == 201 then
			doTweenAlpha('camHUDTween1','camHUD',1,1,'linear')
		end
	end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
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