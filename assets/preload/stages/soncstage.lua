function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg','bgs/red-glove/soncback', -1200, -600)
		addLuaSprite('bg',false)
		scaleObject('bg', 2.5, 2.5);

		makeLuaSprite('text','bgs/red-glove/sonctxt', -1250, -600)
		addLuaSprite('text',true)
		scaleObject('text', 1.2, 1.2);
	end
end