timerone = true
timertwo = true

local dadx = 700;
local dady = 370;
local gfx = 700;
local gfy = 370;
local bfx = 700;
local bfy = 370;
local yes = true;

function onCreate()
	makeLuaSprite('Discord', 'bgs/lukas/Discord', -650, -400);
	setScrollFactor('Discord', 0.9, 0.9);
	scaleObject('Discord', 2.5, 2.5);
	addLuaSprite('Discord', false);
	
	makeLuaSprite('BG', 'bgs/lukas/discord-bg', 208, 120);
	setScrollFactor('BG', 0, 0);
	scaleObject('BG', 0.675, 0.675);
	addLuaSprite('BG', true);
	
	makeLuaSprite('Lost', 'bgs/lukas/discord-left', 208, 120);
	setScrollFactor('Lost', 0, 0);
	setProperty('Lost.alpha',0)
	scaleObject('Lost', 0.675, 0.675);
	addLuaSprite('Lost', true);
	
	makeLuaSprite('Lukas', 'bgs/lukas/discord-right', 208, 120);
	setScrollFactor('Lukas', 0, 0);
	setProperty('Lukas.alpha',0)
	scaleObject('Lukas', 0.675, 0.675);
	addLuaSprite('Lukas', true);
end

function onUpdate()
	if yes == true then
        if mustHitSection == false then
			if gfSection == false then
				if getProperty('dad.animation.curAnim.name') == 'singLEFT'  or getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',dadx,dady)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT'  or getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',gfx,gfy)
				end	
			end
        else
			if gfSection == false then
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT'  or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss'  or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' or getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' or getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',bfx,bfy)
				end
			else
				if getProperty('gf.animation.curAnim.name') == 'singLEFT'  or getProperty('gf.animation.curAnim.name') == 'singRIGHT' or getProperty('gf.animation.curAnim.name') == 'singUP' or getProperty('gf.animation.curAnim.name') == 'singDOWN' or getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',gfx,gfy)
				end	
			end
        end
	end


	if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
		setProperty('Lost.alpha',1)
	end
            
	if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
		setProperty('Lost.alpha',1)
	end
            
	if getProperty('dad.animation.curAnim.name') == 'singUP' then
		setProperty('Lost.alpha',1)
	end
           
	if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
		setProperty('Lost.alpha',1)
	end

	if getProperty('dad.animation.curAnim.name') == 'idle' then
		setProperty('Lost.alpha',0)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
		setProperty('Lukas.alpha',0)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
		setProperty('Lukas.alpha',0)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
		setProperty('Lukas.alpha',0)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
		setProperty('Lukas.alpha',0)
	end

	if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
		setProperty('Lukas.alpha',1)
	end
	
	if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		setProperty('Lukas.alpha',0)
	end
end