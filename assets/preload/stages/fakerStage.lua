function onCreate()
makeLuaSprite('fondo', 'faker/fondo', -597, -257, 'exe');
addLuaSprite('fondo', false);
scaleObject('fondo', 1.1, 1) 

makeLuaSprite('arboles', 'faker/arboles', 259, 41, 'exe');
addLuaSprite('arboles', false);
scaleObject('arboles', 1, 1) 

makeLuaSprite('pilar', 'faker/pilar', 1130, -139, 'exe');
addLuaSprite('pilar', false);
scaleObject('pilar', 1, 1) 

makeLuaSprite('flor', 'faker/flor', 1515, 541, 'exe');
addLuaSprite('flor', false);
scaleObject('flor', 1.2, 1.2) 

makeAnimatedLuaSprite('screenstatic', 'screenstatic', 0, 0, 'exe');
addAnimationByPrefix('screenstatic', 'idle', 'screenSTATIC', 24, true);  
objectPlayAnimation('screenstatic', 'screenstatic', true)
addLuaSprite('screenstatic', true);
scaleLuaSprite('screenstatic', 1, 1);
setObjectCamera('screenstatic','other')
setPropertyLuaSprite('screenstatic', 'alpha', 0)

setProperty('cameraSpeed', 1)
end 

function onUpdate()
	if songName == "faker" then
		if curStep == 883 then
			makeLuaSprite('blackscreen', 'Black', 0, 0)
			addLuaSprite('blackscreen',false)
			setGraphicSize('blackscreen',10000,10000)	
			precacheImage('Black')
			setObjectCamera('blackscreen', 'camOther')
		end
	end
end	