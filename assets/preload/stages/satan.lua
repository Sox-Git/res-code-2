local xx = 600;
local yy = 670;
local ofs = 15;
local ofs2 = 15;
local xx2 = 850;
local yy2 = 720;
local followchars = true;
local zoom = 1;

function onCreate()
	makeLuaSprite('Sky', 'bgs/satanos-bg/Sky', -600, -200);
	scaleObject('Sky', 1.2, 1.2);
	setScrollFactor('Sky', 1, 1);
	setProperty('Sky.antialiasing', true);
	addLuaSprite('Sky', false);
	
	makeLuaSprite('Trees', 'bgs/satanos-bg/Trees', -950, -820);
	scaleObject('Trees', 1.2, 1.2);
	setScrollFactor('Trees', 1.2, 0.9);
	setProperty('Trees.antialiasing', true);
	addLuaSprite('Trees', false);
	
	makeLuaSprite('Palm', 'bgs/satanos-bg/Palm', -950, -820);
	scaleObject('Palm', 1.2, 1.2);
	setScrollFactor('Palm', 1, 1);
	setProperty('Palm.antialiasing', true);
	addLuaSprite('Palm', false);
	
	makeLuaSprite('Sadpalm', 'bgs/satanos-bg/Sadpalm', -950, -820);
	scaleObject('Sadpalm', 1.2, 1.2);
	setScrollFactor('Sadpalm', 1, 1);
	setProperty('Sadpalm.antialiasing', true);
	addLuaSprite('Sadpalm', false);
	
	makeLuaSprite('Floor', 'bgs/satanos-bg/gamemasters', -950, -820);
	scaleObject('Floor', 1.2, 1.2);
	setScrollFactor('Floor', 1, 1);
	setProperty('Floor.antialiasing', true);
	addLuaSprite('Floor', false);
	
	makeLuaSprite('FRock', 'bgs/satanos-bg/FRock', -850, -820);
	scaleObject('FRock', 1.2, 1.2);
	setScrollFactor('FRock', 0.8, 0.9);
	setProperty('FRock.antialiasing', true);
	addLuaSprite('FRock', true);

end
function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 170)
	
	if zoom == 1 then
		if mustHitSection == false then
			setProperty('defaultCamZoom',0.6)
		else
			setProperty('defaultCamZoom',0.65)
		end
	end
	
	if songName == "perdition" then
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