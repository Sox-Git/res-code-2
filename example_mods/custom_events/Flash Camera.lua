function onEvent(event,value1,value2)
	if event == 'Flash Camera' then
		makeLuaSprite('flash', '', 0, 0);
		makeGraphic('flash',1920,1080,'FFFFFF')
		addLuaSprite('flash', true);
		setLuaSpriteScrollFactor('flash',0,0)
		setProperty('flash.scale.x',2)
		setProperty('flash.scale.y',2)
		setObjectCamera('flash', 'HUD')
		doTweenAlpha('flTw','flash',0,value1,'linear')
	end
end