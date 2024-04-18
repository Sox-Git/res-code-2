function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sanicbg1','bgs/nostalgic-duo/sanicbg-1',0,-200)
		addLuaSprite('sanicbg1',false)
		scaleObject('sanicbg1',2,2)
		setProperty('sanicbg1.antialiasing',true)
	end
end
function onStepHit()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then	
		if curStep == 384 then
			makeLuaSprite('sanicbg2','bgs/nostalgic-duo/sanicbg-2',10,-230)
			addLuaSprite('sanicbg2',false)
			scaleObject('sanicbg2',2,2)
			setProperty('sanicbg2.antialiasing',true)
			
			removeLuaSprite('sanicbg1')
		end
		if curStep == 640 then
			makeLuaSprite('sanicbg3','bgs/nostalgic-duo/sanicbg-3',150,050)
			addLuaSprite('sanicbg3',false)
			scaleObject('sanicbg3',2.1,2.1)
			
			setProperty('dad.x', 810)
			setProperty('dad.y', 1005)
			setProperty('boyfriend.x', 2050)
			setProperty('boyfriend.y', 820)
			removeLuaSprite('sanicbg2')
		end
	end			
end
function onUpdate(elapsed)
	setProperty('gf.visible',false)
end