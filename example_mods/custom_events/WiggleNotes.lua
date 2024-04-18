wigglefreq = 0
wiggleamp = 0
function onUpdatePost()

if not inGameOver then
	for i=0,getProperty('notes.length') do
		strum = getPropertyFromGroup('notes',i,'strumTime')
		woom = (strum-getSongPosition())
		if wiggleamp > 0 then
		woom = (strum-getSongPosition())/wigglefreq
		end
		setPropertyFromGroup('notes',i,'angle',wiggleamp *math.sin(woom))
	
	end
end

end

function onEvent(n,v,b)
	if n == 'WiggleNotes' then
		wigglefreq = tonumber(v)
		wiggleamp = tonumber(b)
	end
end