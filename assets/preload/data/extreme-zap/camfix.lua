local cams = {'camGame', 'camHUD'}

function onUpdatePost(elapsed)
	for _, cam in pairs(cams) do
		setProperty(cam..'.flashSprite.scaleX', 2)
		setProperty(cam..'.flashSprite.scaleY', 2)
		runHaxeCode("game."..cam..".setScale(game."..cam..".zoom / 2, game."..cam..".zoom / 2);")
	end
end