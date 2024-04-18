-- Used formulas from FE source code (thx Shubs!!!)
-- FOREVER ENGINE SWEEP!

local separation
local receptorSep = 18 -- how much of pixels do you want each note to distance
local receptorSize = 5.9 -- note size

local strumPosY

function onCreatePost()
	separation = screenWidth / 4

	strumPosY = screenHeight / 6
	if downscroll then strumPosY = screenHeight / 1.25 end

	resizeStrumline('opponent', screenWidth / 2 - separation, strumPosY, receptorSize, receptorSep)
	resizeStrumline('player', screenWidth / 2 + separation, strumPosY, receptorSize, receptorSep)
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
		--setPropertyFromGroup(strum..'Strums', note, 'y', y_position)
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