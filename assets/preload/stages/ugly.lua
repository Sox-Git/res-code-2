local xx = 1450;
local yy = 1550;
local xx2 = 1550;
local yy2 = 1550;
local ofs = 25;
local ofs2 = 25;
local followchars = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('floor', 'bgs/ugly/floor', 0, 200);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false)
		setProperty('floor.alpha',1)
		
		makeLuaSprite('pillarsOne', 'bgs/ugly/pillars-1', 0, 200);
		setScrollFactor('pillarsOne', 1, 1);
		setProperty('pillarsOne.antialiasing', true);
		addLuaSprite('pillarsOne', false)
		setProperty('pillarsOne.alpha', 1)
		
		makeLuaSprite('pillarsTwo', 'bgs/ugly/pillars-2', 0, 0);
		setScrollFactor('pillarsTwo', 1, 1);
		setProperty('pillarsTwo.antialiasing', true);
		addLuaSprite('pillarsTwo', false)
		setProperty('pillarsTwo.alpha',1)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('poster', 'bgs/ugly/poster', 0, 0);
			setScrollFactor('poster', 1, 1);
			setProperty('poster.antialiasing', true);
			addLuaSprite('poster', false)
			setProperty('poster.alpha',1)
		end
		
		makeLuaSprite('thing', 'bgs/ugly/thing', 0, 50);
		setScrollFactor('thing', 1, 1);
		setProperty('thing.antialiasing', true);
		addLuaSprite('thing', false)
		setProperty('thing.alpha',1)
		
		makeLuaSprite('light', 'bgs/ugly/light', 0, 50);
		setScrollFactor('light', 1, 1);
		setProperty('light.antialiasing', true);
		addLuaSprite('light', false)
		setProperty('light.alpha',1)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('table', 'bgs/ugly/table', 0, 0);
			setScrollFactor('table', 1, 1);
			setProperty('table.antialiasing', true);
			addLuaSprite('table', false)
			setProperty('table.alpha',1)

			makeLuaSprite('fnaf', 'bgs/ugly/fnaf', 180, 150);
			setScrollFactor('fnaf', 1, 1);
			setProperty('fnaf.antialiasing', true);
			addLuaSprite('fnaf', false)
			setProperty('fnaf.alpha',1)
			
			makeLuaSprite('portalMine', 'bgs/ugly/portal-minecraft', 0, 50);
			setScrollFactor('portalMine', 1, 1);
			setProperty('portalMine.antialiasing', true);
			addLuaSprite('portalMine', false)
			setProperty('portalMine.alpha',1)
		end
		
		makeLuaSprite('pillarsThree', 'bgs/ugly/pillars-3', -80, -100);
		setScrollFactor('pillarsThree', 0.9, 1);
		setProperty('pillarsThree.antialiasing', true);
		setProperty('pillarsThree.scale.x', 1.45);
		setProperty('pillarsThree.scale.y', 1.45);
		addLuaSprite('pillarsThree', true)
		setProperty('pillarsThree.alpha',1)
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('ceiling', 'bgs/ugly/ceiling', 0, 0);
			setScrollFactor('ceiling', 1, 1);
			setProperty('ceiling.antialiasing', true);
			addLuaSprite('ceiling', true)
			setProperty('ceiling.alpha',1)
		end
		
		makeLuaSprite('lights', 'bgs/ugly/lights', 0, 50);
		setScrollFactor('lights', 1, 1);
		setProperty('lights.antialiasing', true);
		addLuaSprite('lights', true)
		setProperty('lights.alpha',0.5)
	end
end

function onUpdate()
	
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
			
            if getProperty('dad.animation.curAnim.name') == 'transformation' then
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