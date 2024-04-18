local zoom = 0;
local balls = false
local ogY
local currentB
local songP
function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
		makeLuaSprite('bg', 'bgs/sunter/bg', 0, 0);
		setScrollFactor('bg', 1, 1);
		setProperty('bg.antialiasing', true);
		addLuaSprite('bg', false);
		
		makeLuaSprite('stars', 'bgs/sunter/stars', -150, -120);
		setScrollFactor('stars', 0.5, 0.5);
		setProperty('stars.antialiasing', true);
		addLuaSprite('stars', false);
		
		makeLuaSprite('floor', 'bgs/sunter/floor', 0, 0);
		setScrollFactor('floor', 1, 1);
		setProperty('floor.antialiasing', true);
		addLuaSprite('floor', false);
		
		makeLuaSprite('idk', 'bgs/sunter/idk', -100, -15);
		setScrollFactor('idk', 0.7, 0.9);
		setProperty('idk.antialiasing', true);
		addLuaSprite('idk', false);
	end
	
	makeLuaSprite('black', '', 0, 0);
	makeGraphic('black',1920,1080,'000000')
	addLuaSprite('black', true);
	screenCenter('black')
	setLuaSpriteScrollFactor('black',0,0)
	setProperty('black.scale.x',4)
	setProperty('black.scale.y',4)
	
	makeLuaSprite('flashingshit', '', 0, 0);
	makeGraphic('flashingshit',1920,1080,'FFFFFF')
	addLuaSprite('flashingshit', true);
	screenCenter('flashingshit')
	setLuaSpriteScrollFactor('flashingshit',0,0)
	setProperty('flashingshit.scale.x',4)
	setProperty('flashingshit.scale.y',4)
	setProperty('flashingshit.alpha',0)

	setProperty('camHUD.alpha', 0)
end

function onUpdate(elapsed)
	songP = getSongPosition()
	currentB = (songP/2000)*(curBpm/60)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 300) * (bpm / 180)

	noteTweenY('defaultPlayerStrumY0', 4, defaultPlayerStrumY0 - 10*math.sin((currentB+4*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY1', 5, defaultPlayerStrumY1 - 10*math.sin((currentB+5*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY2', 6, defaultPlayerStrumY2 - 10*math.sin((currentB+6*0.25)*math.pi), 0.5)
	noteTweenY('defaultPlayerStrumY3', 7, defaultPlayerStrumY3 - 10*math.sin((currentB+7*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY0', 0, defaultOpponentStrumY0 + 10*math.sin((currentB+0*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY1', 1, defaultOpponentStrumY1 + 10*math.sin((currentB+1*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY2', 2, defaultOpponentStrumY2 + 10*math.sin((currentB+2*0.25)*math.pi), 0.5)
	noteTweenY('defaultOpponentStrumY3', 3, defaultOpponentStrumY3 + 10*math.sin((currentB+3*0.25)*math.pi), 0.5)
	
	if zoom == 0 then
		doTweenZoom('bom', 'camGame',4, 0.01, 'quadOut')
	end
	if zoom == 1 then
		doTweenZoom('bom', 'camGame',1, 0.5, 'quadOut')
	end
	if zoom == 2 then
		doTweenZoom('bom', 'camGame',1.2, 0.5, 'quadOut')
	end
	if zoom == 3 then
		doTweenZoom('bom', 'camGame',0.7, 0.5, 'quadOut')
	end
	
	if songName == "her-world-encore" then
		if curStep == 1 then
			doTweenZoom('damn', 'camGame',1, 10, 'quadOut')
			doTweenAlpha('b1','black',0,9,'quadInOut')
			zoom = -1;
		end
		if curStep == 128 then
			doTweenZoom('boom', 'camGame',1.2, 0.01, 'quadOut')
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f1','flashingshit',0,1,'linear')
		end
		if curStep == 129 then
			doTweenZoom('boom', 'camGame',1, 0.8, 'quadInOut')
		end
		if curStep == 139 then
			zoom = 1;
		end
		if curStep == 181 then
			doTweenAlpha('CH1','camHUD',1,1,'linear')
		end
		if curStep == 384 then
			doTweenAlpha('CH2','camHUD',0,2.5,'linear')
			doTweenAlpha('b2','black',1,2,'quadInOut')
		end
		if curStep == 448 then
			setProperty('black.alpha', 0)
			doTweenAlpha('CH3','camHUD',1,0.5,'linear')
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f2','flashingshit',0,1,'linear')
			zoom = -1;
		end
		if curStep == 704 then
			doTweenAlpha('IconP2','iconP2',0,0.50,'linear')
			doTweenAlpha('IconP1','iconP1',0,0.50,'linear')
			doTweenAlpha('healthBar','healthBar',0,0.50,'linear')
			doTweenAlpha('healthBarBG','healthBarBG',0,0.50,'linear')
			doTweenAlpha('scoreTxt','scoreTxt',0,0.50,'linear')
			doTweenAlpha('timeBarBG','timeBarBG',0,0.50,'linear')
			doTweenAlpha('timeBarBGBG','timeBarBGBG',0,0.50,'linear')
			doTweenAlpha('timeBar','timeBar',0,0.50,'linear')
			doTweenAlpha('timeTxt','timeTxt',0,0.50,'linear')
		
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f3','flashingshit',0,1,'linear')
			zoom = 2;
		end
		if curStep == 832 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f4','flashingshit',0,1,'linear')
			zoom = 1;
		end
		if curStep == 960 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f5','flashingshit',0,1,'linear')
			zoom = 3;
		end
		if curStep == 1214 then
			doTweenAlpha('b3','black',1,0.25,'quadInOut')
		end
		if curStep == 1232 then
			doTweenAlpha('1iconP2','iconP2',1,0.50,'linear')
			doTweenAlpha('1iconP1','iconP1',1,0.50,'linear')
			doTweenAlpha('1healthBar','healthBar',1,0.50,'linear')
			doTweenAlpha('1healthBarBG','healthBarBG',1,0.50,'linear')
			doTweenAlpha('1scoreTxt','scoreTxt',1,0.50,'linear')
			doTweenAlpha('1timeBarBG','timeBarBG',1,0.50,'linear')
			doTweenAlpha('1timeBarBGBG','timeBarBGBG',1,0.50,'linear')
			doTweenAlpha('1timeBar','timeBar',1,0.50,'linear')
			doTweenAlpha('1timeTxt','timeTxt',1,0.50,'linear')
		
			setProperty('black.alpha', 0)
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f6','flashingshit',0,1,'linear')
			zoom = -1;
		end
		if curStep == 1488 then
			zoom = 1;
		end
		if curStep == 1616 then
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f7','flashingshit',0,1,'linear')
			zoom = -1;
		end
		if curStep == 1744 then
			doTweenAlpha('iconP21','iconP2',0,0.50,'linear')
			doTweenAlpha('iconP11','iconP1',0,0.50,'linear')
			doTweenAlpha('healthBar1','healthBar',0,0.50,'linear')
			doTweenAlpha('healthBarBG1','healthBarBG',0,0.50,'linear')
			doTweenAlpha('scoreTxt1','scoreTxt',0,0.50,'linear')
			doTweenAlpha('timeBarBG1','timeBarBG',0,0.50,'linear')
			doTweenAlpha('timeBarBGBG1','timeBarBGBG',0,0.50,'linear')
			doTweenAlpha('timeBar1','timeBar',0,0.50,'linear')
			doTweenAlpha('timeTxt1','timeTxt',0,0.50,'linear')
		
			setProperty('flashingshit.alpha', 1)
			doTweenAlpha('f8','flashingshit',0,1,'linear')
			zoom = 2;
		end
		if curStep == 2000 then
			zoom = 1;
		end
		if curStep == 2064 then
			noteTweenAlpha('opponentStrums0',0,0,1.5,'linear')
			noteTweenAlpha('opponentStrums1',1,0,1.5,'linear')
			noteTweenAlpha('opponentStrums2',2,0,1.5,'linear')
			noteTweenAlpha('opponentStrums3',3,0,1.5,'linear')
			
			noteTweenAlpha('playerStrums0',4,0,1.5,'linear')
			noteTweenAlpha('playerStrums1',5,0,1.5,'linear')
			noteTweenAlpha('playerStrums2',6,0,1.5,'linear')
			noteTweenAlpha('playerStrums3',7,0,1.5,'linear')
			
			doTweenAlpha('b4','black',1,1.5,'quadInOut')
		end
	end
end

--Bouncing Icons (By: Tushka)
options = {
    ["Bounce Modifier"] = 10,
    ["Ease"] = "cubeInOut",
}
function onStartCountdown()
    ogY = getProperty('iconP2.y')
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setProperty('iconP1.y', ogY - options["Bounce Modifier"])
    doTweenY('iconP1', 'iconP1', ogY, crochet/1000,options["Ease"])
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    setProperty('iconP2.y', ogY - options["Bounce Modifier"])
    doTweenY('iconP2', 'iconP2', ogY, crochet/1000,options["Ease"])
end