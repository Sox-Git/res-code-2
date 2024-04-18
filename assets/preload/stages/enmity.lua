function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('sky', 'bgs/enmity/sky', 0, 0);
		scaleObject('sky', 0.75, 0.75);
		setProperty('sky.antialiasing', true);
		addLuaSprite('sky', false);
		
		makeLuaSprite('sun', 'bgs/enmity/sun', 0, 0);
		scaleObject('sun', 0.75, 0.75);
		setScrollFactor('sun', 1, 1);
		setProperty('sun.antialiasing', true);
		addLuaSprite('sun', false);
		
		if getPropertyFromClass('ClientPrefs', 'Optimization') == false then
			makeLuaSprite('nicecar', 'bgs/enmity/nicecar', 0, 0);
			scaleObject('nicecar', 0.75, 0.75);
			setScrollFactor('nicecar', 0.95, 1);
			setProperty('nicecar.antialiasing', true);
			addLuaSprite('nicecar', false);
			
			makeLuaSprite('tree', 'bgs/enmity/tree', 0, 0);
			scaleObject('tree', 0.75, 0.75);
			setScrollFactor('tree', 0.9, 1);
			setProperty('tree.antialiasing', true);
			addLuaSprite('tree', false);

			makeLuaSprite('moon', 'bgs/enmity/moon', 0, 0);
			scaleObject('moon', 0.75, 0.75);
			setScrollFactor('moon', 0.9, 1);
			setProperty('moon.antialiasing', true);
			addLuaSprite('moon', false);
		end
		
		makeLuaSprite('fg', 'bgs/enmity/fg', 0, 0);
		scaleObject('fg', 0.75, 0.75);
		setScrollFactor('fg', 1, 1);
		setProperty('fg.antialiasing', true);
		addLuaSprite('fg', false);
		
		makeAnimatedLuaSprite('shit', 'bgs/enmity/shit', 1150, 0);
		scaleObject('shit', 0.75, 0.75);
		addAnimationByPrefix('shit', 'fff', 'fff', 24, true);
		setScrollFactor('shit', 1, 1);
		setProperty('shit.antialiasing', true);
		addLuaSprite('shit', true);
	end
end