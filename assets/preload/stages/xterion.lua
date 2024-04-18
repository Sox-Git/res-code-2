function onCreate()
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	screenCenter('black')
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',4)
	setProperty('black.scale.y',4)
	setProperty('black.alpha',0)
end
function onStepHit()
	if curStep == 1960 and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		doTweenAlpha('darkness','black',1,0.001,'linear')
	end
	if curStep == 1964 and getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg2D', 'xterion/bg2D', -300, -70, 'exe');
		addLuaSprite('bg2D', false);
		setLuaSpriteScrollFactor('bg2D',1,1)
		setProperty('bg2D.scale.x',1.7)
		setProperty('bg2D.scale.y',1.7)
		setProperty('defaultCamZoom',0.5)
		setProperty('boyfriend.x',1500)
		setProperty('dad.x',-200)
		setProperty('dad.y',180)
	end
	if curStep == 1968 then
		doTweenAlpha('darkness','black',0,0.01,'linear')
	end
end