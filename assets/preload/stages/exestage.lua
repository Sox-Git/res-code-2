function onCreate()
makeAnimatedLuaSprite('Exe', 'faker/Exe', -735, -500, 'exe');
addAnimationByPrefix('Exe', 'idle', 'Exe', 24, true)
objectPlayAnimation('Exe', 'Exe', true);
addLuaSprite('Exe', false);
scaleObject('Exe', 1.1, 1.1)  

makeLuaSprite('tailscorpse', 'faker/TailsCorpse', 200, 425, 'exe');
addLuaSprite('tailscorpse', false);
scaleObject('tailscorpse', 1, 1)

setProperty('health', 2);

setProperty('defaultCamZoom', 1.1) 

end 

function onCreatePost()
	doTweenColor('timeBar', 'timeBar', '5C21FF', 0.01, 'linear');
end

function onCountdownStarted()
	noteTweenX('exe0', 0, -1000, 0.01, 'quartInOut')
	noteTweenX('exe1', 1, -1000, 0.01, 'quartInOut')
	noteTweenX('exe2', 2, -1000, 0.01, 'quartInOut')
	noteTweenX('exe3', 3, -1000, 0.01, 'quartInOut')
end

local Cam1 = 1
local Cam2 = 0.7

function onMoveCamera(focus)
	if focus == 'boyfriend' then
	setProperty('defaultCamZoom', Cam1) 
	elseif focus == 'dad' then
	setProperty('defaultCamZoom', Cam2) 
	end
end
