function onCreate()
	makeLuaSprite('backwall', 'bgs/secreth/wall', -200, -200);
	setScrollFactor('backwall', 0.9, 0.9);
	scaleObject('backwall', 0.8, 0.8);
	
	makeLuaSprite('desk', 'bgs/secreth/desk', -170, -100);
	setScrollFactor('desk', 0.9, 0.9);
	scaleObject('desk', 0.7, 0.7);

	makeLuaSprite('robot', 'bgs/secreth/robo', -170, -100);
	setScrollFactor('robot', 0.9, 0.9);
	scaleObject('robot', 0.7, 0.7);

	makeLuaSprite('box', 'bgs/secreth/box', -170, -100);
	setScrollFactor('box', 0.9, 0.9);
	scaleObject('box', 0.7, 0.7);

	makeLuaSprite('crate', 'bgs/secreth/crate', -170, -100);
	setScrollFactor('crate', 0.9, 0.9);
	scaleObject('crate', 0.7, 0.7);

	addLuaSprite('backwall', false);
	addLuaSprite('box', false);
	addLuaSprite('robot', false);
	addLuaSprite('desk', false);
	addLuaSprite('crate', false);
end