function onCreate()
	makeLuaSprite('shadow', 'bgs/void/shadow', -600, 100);
	setLuaSpriteScrollFactor('shadow', 1, 1);
	scaleObject('shadow', 2, 1);
	setProperty('shadow.alpha',1)
	setProperty('shadow.antialiasing', true);
	addLuaSprite('shadow', false);
end