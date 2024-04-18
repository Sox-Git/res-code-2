function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)

	if curStep == 528 then
		setProperty('gf.alpha', 0);
	end

	if curStep == 677 then
		setProperty('gf.alpha', 1);
	end
	
    if curStep == 692 then
		setProperty('gf.alpha', 0);
	end   
	
	if curStep == 741 then
		setProperty('gf.alpha', 1);
	end

	if curStep == 758 then
		setProperty('gf.alpha', 0);
	end
	
    if curStep == 767 then
		setProperty('gf.alpha', 1);
	end  
end