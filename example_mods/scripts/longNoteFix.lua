--Script by Wolfie_1985
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'dad-idle' then							
		setProperty('dad.idleSuffix','')
	end
	if tag == 'gf-idle' then							
		setProperty('gf.idleSuffix','')
	end
	if tag == 'bf-idle' then							
		setProperty('boyfriend.idleSuffix','')
	end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if noteType == 'No Animation' then
		--do nothing lol
	elseif noteType == 'GF Sing' or gfSection == true and mustHitSection == false then
		setProperty('gf.idleSuffix','-nothing')
		runTimer('gf-idle', 0.3)
	else
		setProperty('dad.idleSuffix','-nothing')
		runTimer('dad-idle', 0.3)	
	end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if noteType == 'No Animation' then
		--do nothing lol
	elseif noteType == 'GF Sing' or gfSection == true and mustHitSection == true then
		setProperty('gf.idleSuffix','-nothing')
		runTimer('gf-idle', 0.3)
	else
		setProperty('boyfriend.idleSuffix','-nothing')
		runTimer('bf-idle', 0.3)	
	end
	if songName == "face-off" then
		if noteType == 'No Animation' then
			--do nothing lol
		else
			setProperty('boyfriend.idleSuffix','-nothing')
			runTimer('bf-idle', 0.3)
			if curStep > 1 and curStep < 448 then
				setProperty('dad.idleSuffix','-nothing')
				runTimer('dad-idle', 0.3)
			end
		end
	end
end
function onEvent(name, value1, value2)
	if name == 'Play Animation' then
		if value2 == 'gf' or value2 == 'Gf' or value2 == 'GF' or value2 == 'gF' then 
			runTimer('gf-idle', 0.3)
			setProperty('gf.idleSuffix','-nothing')
		end
		if value2 == 'bf' or value2 == 'Bf' or value2 == 'BF' or value2 == 'bF' then
			runTimer('bf-idle', 0.3)
			setProperty('boyfriend.idleSuffix','-nothing')		
		end
		if value2 == 'dad' or value2 == 'Dad' or value2 == 'DAd' or value2 == 'DAD' or value2 == 'dAD' or value2 == 'dAd' or value2 == 'DaD' or value2 == 'daD' then
			runTimer('dad-idle', 0.3)
			setProperty('dad.idleSuffix','-nothing')	
		end
	end
end
function noteMiss(membersIndex, noteData, noteType, isSustainNote)
	if getProperty('tag.animation.curAnim.name') == 'singLEFTmiss' and getProperty('tag.animation.curAnim.finished') == true then
		runTimer('bf-idle', 0.3)	
	end
	if getProperty('tag.animation.curAnim.name') == 'singRIGHTmiss' and getProperty('tag.animation.curAnim.finished') == true then
		runTimer('bf-idle', 0.3)
	end
	if getProperty('tag.animation.curAnim.name') == 'singDOWNmiss' and getProperty('tag.animation.curAnim.finished') == true then
		runTimer('bf-idle', 0.3)
	end
	if getProperty('tag.animation.curAnim.name') == 'singUPmiss' and getProperty('tag.animation.curAnim.finished') == true then
		runTimer('bf-idle', 0.3)
	end
end