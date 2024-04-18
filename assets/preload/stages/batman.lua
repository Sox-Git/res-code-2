local xx = 150;
local yy = 450;
local ofs = 15;
local ofs2 = 15;
local xx2 = 500;
local yy2 = 450;
local followchars = true;

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/batman/bg', -950, -150);
		scaleObject('bg', 2, 1.5);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		makeLuaSprite('clouds', 'bgs/batman/clouds', -1100, -150);
		scaleObject('clouds', 2, 1.5);
		setScrollFactor('clouds', 1.3, 1.3);
		setProperty('clouds.antialiasing', true);
		addLuaSprite('clouds', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('city1', 'bgs/batman/city', -800, -350);
			scaleObject('city1', 1.8, 1.8);
			setScrollFactor('city1', 0.9, 1);
			setProperty('city1.antialiasing', true);
			addLuaSprite('city1', false);

			makeLuaSprite('city2', 'bgs/batman/city', -850, -450);
			scaleObject('city2', 1.9, 1.9);
			setScrollFactor('city2', 1.1, 1);
			setProperty('city2.antialiasing', true);
			addLuaSprite('city2', false);
		end
		
		makeLuaSprite('sonic', 'bgs/batman/sonic', -550, -200);
		scaleObject('sonic', 1.3, 1.3);
		setScrollFactor('sonic', 1.2, 1.2);
		setProperty('sonic.antialiasing', true);
		addLuaSprite('sonic', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('city', 'bgs/batman/city', -1000, -700);
			scaleObject('city', 2, 2);
			setScrollFactor('city', 1, 1);
			setProperty('city.antialiasing', true);
			addLuaSprite('city', false);

			--Lights
			makeLuaSprite('light1', 'bgs/batman/lights/light-1', -9500, -350);
			scaleObject('light1', 0.7, 0.7);
			setScrollFactor('light1', 1, 1);
			setProperty('light1.antialiasing', true);
			addLuaSprite('light1', false);
			setProperty('light1.alpha',0)
			
			makeLuaSprite('light2', 'bgs/batman/lights/light-2', -1100, -350);
			scaleObject('light2', 1, 1);
			setScrollFactor('light2', 1, 1);
			setProperty('light2.antialiasing', true);
			addLuaSprite('light2', false);
			setProperty('light2.alpha',0)
			
			makeLuaSprite('light3', 'bgs/batman/lights/light-3', -1100, -350);
			scaleObject('light3', 1, 1);
			setScrollFactor('light3', 1, 1);
			setProperty('light3.antialiasing', true);
			addLuaSprite('light3', false);
			setProperty('light3.alpha',0)
			
			makeLuaSprite('light4', 'bgs/batman/lights/light-4', -1100, -350);
			scaleObject('light4', 1, 1);
			setScrollFactor('light4', 1, 1);
			setProperty('light4.antialiasing', true);
			addLuaSprite('light4', false);
			setProperty('light4.alpha',0)
			
			makeLuaSprite('light5', 'bgs/batman/lights/light-5', -1100, -350);
			scaleObject('light5', 1, 1);
			setScrollFactor('light5', 1, 1);
			setProperty('light5.antialiasing', true);
			addLuaSprite('light5', false);
			setProperty('light5.alpha',0)
			
			makeLuaSprite('light6', 'bgs/batman/lights/light-6', -1100, -350);
			scaleObject('light6', 1, 1);
			setScrollFactor('light6', 1, 1);
			setProperty('light6.antialiasing', true);
			addLuaSprite('light6', false);
			setProperty('light6.alpha',0)
		end
	end
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'B3B2FF')
	addLuaSprite('flashingshit', true);
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',2)
	setProperty('flashingshit.scale.y',2)
	setProperty('flashingshit.alpha',0)
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

	if songName == "gotta-go" then
		if curStep == 768 then
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('light2.alpha',1)
				doTweenAlpha('light2','light2',0,1.0,'linear')
				setProperty('light4.alpha',1)
				doTweenAlpha('light4','light4',0,1.0,'linear')
				setProperty('light5.alpha',1)
				doTweenAlpha('light5','light5',0,1.0,'linear')
			end
			
			setProperty('flashingshit.alpha',0.45)
			doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
		end
		
		if curStep == 1152 then
			if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
				setProperty('light1.alpha',1)
				doTweenAlpha('light1','light1',0,1.0,'linear')
				setProperty('light2.alpha',1)
				doTweenAlpha('light2','light2',0,1.0,'linear')
				setProperty('light3.alpha',1)
				doTweenAlpha('light3','light3',0,1.0,'linear')
				setProperty('light4.alpha',1)
				doTweenAlpha('light4','light4',0,1.0,'linear')
				setProperty('light5.alpha',1)
				doTweenAlpha('light5','light5',0,1.0,'linear')
				setProperty('light6.alpha',1)
				doTweenAlpha('light6','light6',0,1.0,'linear')
			end
			
			setProperty('flashingshit.alpha',0.60)
			doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
		end
	end
	
	if songName == "call-of-justice" then
		if curStep == 0 then
		end
	end
end

function onBeatHit()
	if getPropertyFromClass('ClientPrefs', 'Optimization') == false and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		if curStep < 1135 then
			if curBeat %4 == 0 then
				if getRandomInt(1,6) == 1 then 
					setProperty('light1.alpha',1)
					doTweenAlpha('light1','light1',0,1.0,'linear')
					
					setProperty('flashingshit.alpha',0.10)
					doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
				else
					if getRandomInt(1,6) == 2 then 
						setProperty('light2.alpha',1)
						doTweenAlpha('light2','light2',0,1.0,'linear')
						
						setProperty('flashingshit.alpha',0.15)
						doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
					else
						if getRandomInt(1,6) == 3 then 
							setProperty('light3.alpha',1)
							doTweenAlpha('light3','light3',0,1.0,'linear')
							
							setProperty('flashingshit.alpha',0.25)
							doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
						else
							if getRandomInt(1,6) == 4 then 
								setProperty('light4.alpha',1)
								doTweenAlpha('light4','light4',0,1.0,'linear')
								
								setProperty('flashingshit.alpha',0.22)
								doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
							else
								if getRandomInt(1,6) == 5 then 
									setProperty('light5.alpha',1)
									doTweenAlpha('light5','light5',0,1.0,'linear')
									
									setProperty('flashingshit.alpha',0.20)
									doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
								else
									if getRandomInt(1,6) == 6 then 
										setProperty('light6.alpha',1)
										doTweenAlpha('light6','light6',0,1.0,'linear')
										
										setProperty('flashingshit.alpha',0.15)
										doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
									end
								end
							end
						end
					end
				end
			end
		end
		if curStep > 1135 and curStep < 1152 then
			if curBeat %1 == 0 then
				if getRandomInt(1,6) == 1 then 
					setProperty('light1.alpha',1)
					doTweenAlpha('light1','light1',0,1.0,'linear')
					
					setProperty('flashingshit.alpha',0.10)
					doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
				else
					if getRandomInt(1,6) == 2 then 
						setProperty('light2.alpha',1)
						doTweenAlpha('light2','light2',0,1.0,'linear')
						
						setProperty('flashingshit.alpha',0.15)
						doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
					else
						if getRandomInt(1,6) == 3 then 
							setProperty('light3.alpha',1)
							doTweenAlpha('light3','light3',0,1.0,'linear')
							
							setProperty('flashingshit.alpha',0.25)
							doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
						else
							if getRandomInt(1,6) == 4 then 
								setProperty('light4.alpha',1)
								doTweenAlpha('light4','light4',0,1.0,'linear')
								
								setProperty('flashingshit.alpha',0.22)
								doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
							else
								if getRandomInt(1,6) == 5 then 
									setProperty('light5.alpha',1)
									doTweenAlpha('light5','light5',0,1.0,'linear')
									
									setProperty('flashingshit.alpha',0.20)
									doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
								else
									if getRandomInt(1,6) == 6 then 
										setProperty('light6.alpha',1)
										doTweenAlpha('light6','light6',0,1.0,'linear')
										
										setProperty('flashingshit.alpha',0.15)
										doTweenAlpha('flashingshit','flashingshit',0,1.0,'linear')
									end
								end
							end
						end
					end
				end
			end
		end
	end
end