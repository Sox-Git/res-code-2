function onUpdate(elapsed)
	if curStep >= 136 then --136
	  songPos = getSongPosition()
	  local currentBeat = (songPos/1000)*(bpm/120)
	  doTweenY(dadTweenY, 'dad', 50-70*math.sin((currentBeat*0.3)*math.pi),0.001)
	end
  end