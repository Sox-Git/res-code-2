function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/apollyon-p1(Outdated)/bg', -1250, -1050);
		scaleObject('bg', 2, 2);
		setScrollFactor('bg', 0.7, 0.7);
		setProperty('bg.antialiasing', false);
		setProperty('bg.alpha', 0.8);
		addLuaSprite('bg', false);
		
		makeLuaSprite('floor', 'bgs/apollyon-p1(Outdated)/floor', -4900, -5800);
		scaleObject('floor', 8, 8);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', false);
		setProperty('floor.alpha', 1);
		addLuaSprite('floor', false);
	end
end