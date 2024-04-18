local separation
local receptorSep = 160
local receptorSize = 0.7
local strumPosY
local changeNotes = 0

function onUpdate()
    if changeNotes == 3 then
        for notesLength = 0,getProperty('notes.length') do
            if getPropertyFromGroup('notes',notesLength,'noteType') == '' and getPropertyFromGroup('notes',notesLength,'texture') == 'NOTE_SUNKEH' then
                setPropertyFromGroup('notes',notesLength,'texture','NOTE_SUNKEH')
            end
        end
	end
end

function onUpdate(elapsed)

    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	if songName == "milk" then
		if curStep == 0 then
            changeNotes = 3
            for strumLineNotes = 0,7 do
               setPropertyFromGroup('strumLineNotes',strumLineNotes,'texture','NOTE_SUNKEH')
            end
		end
	end
end


function onCreatePost()
	separation = screenWidth / 4

	strumPosY = screenHeight / 6
	if downscroll then strumPosY = screenHeight / 1.25 end

	resizeStrumline('opponent', screenWidth / 2 - separation, strumPosY, receptorSize, receptorSep)
	resizeStrumline('player', screenWidth / 2 + separation, strumPosY, receptorSize, receptorSep)
	
	if getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
		noteTweenX("note1", 1, 140, 0.25, cubeInOut)
		noteTweenX("note2", 2, 230, 0.25, cubeInOut)
		noteTweenX("note5", 5, 620, 0.25, cubeInOut)
		noteTweenX("note6", 6, 710, 0.25, cubeInOut)
	end
end

function resizeStrumline(strum, x_position, y_position, scale, noteSep)
	
	local swagWidth = scale * noteSep
	local isPlayer = false
	if strum == 'player' then isPlayer = true end

	for note=0, getProperty(strum..'Strums.length')-1 do
		setPropertyFromGroup(strum..'Strums', note, 'scale.x', scale)
		setPropertyFromGroup(strum..'Strums', note, 'scale.y', scale)

		updateHitboxFromGroup(strum..'Strums', note)

		local noteX = x_position - swagWidth / 2
		noteX = noteX + (note - (3 / 2)) * swagWidth

		setPropertyFromGroup(strum..'Strums', note, 'x', noteX)
	end

	for note=0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', note, 'mustPress') == isPlayer then
			setPropertyFromGroup('unspawnNotes', note, 'scale.x', scale)

			if not getPropertyFromGroup('unspawnNotes', note, 'isSustainNote') then
				setPropertyFromGroup('unspawnNotes', note, 'scale.y', scale)
			end
			updateHitboxFromGroup('unspawnNotes', note)
		end
	end
end