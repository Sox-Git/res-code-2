local u = false;
local r = 0;
local shot = false;
local agent = 1;
local health = 0;
local xx = -280;
local yy = 1000;
local xx2 = 580;
local yy2 = 1000;
local xx3 = 80;
local yy3 = 1000;
local ofs = 20;
local ofs2 = 20;
local followchars = true;
local del = 0;
local del2 = 0;
local disco = false;
local discoPink = true;
local discoBlue = false;
local discoGreen = false;
local discoRed = false;
local discoOpOne = false;
local discoOpTwo = false;
local boxAnim = true


function onCreate()
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
	if songName == 'missiletoe' then
		makeLuaSprite('sky-morning', 'bgs/christmas/sky-missiletoe', -1100,50)
		addLuaSprite('sky-morning', false)	
		scaleObject('sky-morning', 0.9, 0.9);	
		setScrollFactor('sky-morning', 0.4, 1);
	end
	if songName == 'slaybells' then
		xx = -280;
		yy = 800;
		xx2 = 580;
		yy2 = 1000;
		xx3 = 80;
		yy3 = 1000;
		makeLuaSprite('sky-evening', 'bgs/christmas/sky-slaybells', -1100,50)
		addLuaSprite('sky-evening',false)	
		scaleObject('sky-evening', 0.9, 0.9);		
		setScrollFactor('sky-evening', 0.4, 1);
	end
	if songName == 'jingle-hells' then
		xx = -280;
		yy = 1000;
		xx2 = 580;
		yy2 = 1000;
		xx3 = 80;
		yy3 = 950;
		ofs = 30
		ofs2 = 30
		makeLuaSprite('sky-night', 'bgs/christmas/sky-jingle-hells', -1000,320)
		addLuaSprite('sky-night',false)	
		scaleObject('sky-night', 0.9, 0.9);	
		setScrollFactor('sky-night', 0.4, 1);
	end	
	makeLuaSprite('treesBack', 'bgs/christmas/trees_back', -1600,50)
	addLuaSprite('treesBack',false)			
	scaleObject('treesBack', 0.9, 0.9);		
	setScrollFactor('treesBack', 0.6, 1);
	
	makeLuaSprite('floorBack', 'bgs/christmas/floor_back', -1400,50)
	addLuaSprite('floorBack',false)				
	scaleObject('floorBack', 0.9, 0.9);		
	setScrollFactor('floorBack', 0.7, 1);

	makeLuaSprite('treesMiddle', 'bgs/christmas/trees_middle', -1500,50)
	addLuaSprite('treesMiddle',false)	
	scaleObject('treesMiddle', 0.9, 0.9);		
	setScrollFactor('treesMiddle', 0.8, 1);

	if songName == 'jingle-hells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeAnimatedLuaSprite('wechidna', 'bgs/christmas/Wechima', -1150, -35);
		setScrollFactor('wechidna', 1, 1);
		addAnimationByPrefix('wechidna', 'idle', 'KrimaWech', 17, false);
		setProperty('wechidna.antialiasing', true);
		addLuaSprite('wechidna', false);
		scaleObject('wechidna', 0.9, 0.9)
		setScrollFactor('wechidna', 0.9, 1);
		
		makeAnimatedLuaSprite('chaotix', 'bgs/christmas/Chaotixmas', 950, 55);
		setScrollFactor('chaotix', 1, 1);
		addAnimationByPrefix('chaotix', 'idle', 'Chaotimas', 17, false);
		setProperty('chaotix.antialiasing', true);
		addLuaSprite('chaotix', false);
		scaleObject('chaotix', 0.8, 0.8)
		setScrollFactor('chaotix', 0.9, 1);
		
		makeAnimatedLuaSprite('omw', 'bgs/christmas/Krimyway', -250, 55);
		setScrollFactor('omw', 1, 1);
		addAnimationByPrefix('omw', 'idle', 'OMW', 5, true);
		setProperty('omw.antialiasing', true);
		addLuaSprite('omw', false);
		scaleObject('omw', 0.9, 0.9)
		setScrollFactor('omw', 0.9, 1);
	end
	
	makeLuaSprite('floorMiddle', 'bgs/christmas/floor_middle', -1400,50)
	addLuaSprite('floorMiddle',false)
	scaleObject('floorMiddle', 0.9, 0.9);
	setScrollFactor('floorMiddle', 0.9, 1);

	if songName == 'slaybells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeAnimatedLuaSprite('requital', 'bgs/christmas/christma-requital', 1000, 960);
		setScrollFactor('requital', 1, 1);
		addAnimationByPrefix('requital', 'idle', 'Requital', 24, false);
		setProperty('requital.antialiasing', true);
		addLuaSprite('requital', false);
		
		makeAnimatedLuaSprite('sanic', 'bgs/christmas/christma-sanic', -850, 985);
		setScrollFactor('sanic', 1, 1);
		addAnimationByPrefix('sanic', 'idle', 'Sanic', 24, false);
		setProperty('sanic.antialiasing', true);
		addLuaSprite('sanic', false);
	end

	if songName == 'jingle-hells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeAnimatedLuaSprite('requital', 'bgs/christmas/christma-requital', 1000, 960);
		setScrollFactor('requital', 1, 1);
		addAnimationByPrefix('requital', 'idle', 'Requital', 24, false);
		setProperty('requital.antialiasing', true);
		addLuaSprite('requital', false);
		
		makeAnimatedLuaSprite('melthog', 'bgs/christmas/KriMelthog', 1300, 990);
		setScrollFactor('melthog', 1, 1);
		addAnimationByPrefix('melthog', 'idle', 'Melthog', 24, false);
		setProperty('melthog.antialiasing', true);
		addLuaSprite('melthog', false);
		
		makeAnimatedLuaSprite('grimbo', 'bgs/christmas/Grimbo_the_Luis', -1150, 985);
		setScrollFactor('grimbo', 1, 1);
		addAnimationByPrefix('grimbo', 'idle', 'Grimbo/Luis', 24, false);
		setProperty('grimbo.antialiasing', true);
		addLuaSprite('grimbo', false);
		
		makeAnimatedLuaSprite('sanic', 'bgs/christmas/christma-sanic', -850, 985);
		setScrollFactor('sanic', 1, 1);
		addAnimationByPrefix('sanic', 'idle', 'Sanic', 24, false);
		setProperty('sanic.antialiasing', true);
		addLuaSprite('sanic', false);
	end

	makeLuaSprite('floorFront', 'bgs/christmas/floor_front', -1400,50)
	addLuaSprite('floorFront',false)
	scaleObject('floorFront', 0.9, 0.9);	
	
	makeLuaSprite('treesFront', 'bgs/christmas/trees_front', -1400,50)
	addLuaSprite('treesFront',false)		
	scaleObject('treesFront', 0.9, 0.9);		
	
	if songName == 'slaybells' or songName == 'jingle-hells' then
		makeLuaSprite('snowFallTrees', 'bgs/christmas/snowfall', -1400,50)
		addLuaSprite('snowFallTrees',false)		
		scaleObject('snowFallTrees', 0.9, 0.9);				
	end
	
	makeAnimatedLuaSprite('speakers', 'bgs/christmas/speakers', 0, 800);
	setScrollFactor('speakers', 1, 1);
	addAnimationByPrefix('speakers', 'idle', 'Idle', 24, false);
	setProperty('speakers.antialiasing', true);
	addLuaSprite('speakers', false);		
	scaleObject('speakers', 1.2, 1.2);
	
	if songName == 'missiletoe' or songName == 'jingle-hells' then
		makeAnimatedLuaSprite('faker', 'bgs/christmas/christma-faker', 110, 540);
		scaleObject('faker', 0.5, 0.5);
		addAnimationByPrefix('faker', 'idle', 'Idle', 26, false);
		setProperty('faker.antialiasing', true);
		addLuaSprite('faker', false);
	end
	
	if songName == 'missiletoe' then
		makeLuaSprite('box', 'bgs/christmas/box', -500, 1080)
		addLuaSprite('box',false)
		setProperty('box.alpha',0)
		scaleObject('box',0.45,0.45)
	end

	makeAnimatedLuaSprite('fleetway', 'bgs/christmas/christma-fleetway', -1100, 1055);
	scaleObject('fleetway', 1, 1);
	setScrollFactor('fleetway', 0.9, 0.9);
	addAnimationByPrefix('fleetway', 'idle', 'Fleetway', 24, false);
	setProperty('fleetway.antialiasing', true);
	addLuaSprite('fleetway', true);
	
	makeAnimatedLuaSprite('curse', 'bgs/christmas/christma-curse', 800, 1025);
	scaleObject('curse', 1, 1);
	setScrollFactor('curse', 0.9, 0.9);
	addAnimationByPrefix('curse', 'idle', 'Curse', 24, false);
	setProperty('curse.antialiasing', true);
	addLuaSprite('curse', true);
		
	if songName == 'slaybells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false or songName == 'jingle-hells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then		
		makeAnimatedLuaSprite('sunky', 'bgs/christmas/christma-sunky', 250, 1050);
		scaleObject('sunky', 1, 1);
		setScrollFactor('sunky', 0.8, 0.8);
		addAnimationByPrefix('sunky', 'idle', 'Sunky', 24, false);
		setProperty('sunky.antialiasing', true);
		addLuaSprite('sunky', true);
						
		makeAnimatedLuaSprite('devoid', 'bgs/christmas/christma-devoid', -460, 1090);
		scaleObject('devoid', 1, 1);
		setScrollFactor('devoid', 0.8, 0.8);
		addAnimationByPrefix('devoid', 'idle', 'Devoid', 24, false);
		setProperty('devoid.antialiasing', true);
		addLuaSprite('devoid', true);
		
		makeAnimatedLuaSprite('rerun', 'bgs/christmas/christma-rerun', -1250, 400);
		scaleObject('rerun', 1.4, 1.4);
		setScrollFactor('rerun', 1, 1);
		addAnimationByPrefix('rerun', 'idle', 'ReRun', 24, false);
		setProperty('rerun.antialiasing', true);
		addLuaSprite('rerun', false);
	end
	if songName == 'jingle-hells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeAnimatedLuaSprite('luther', 'bgs/christmas/christma-luther', 1050, 900);
		scaleObject('luther', 1.1, 1.1);
		setScrollFactor('luther', 1, 1);
		addAnimationByPrefix('luther', 'idle', 'Luther', 24, false);
		setProperty('luther.antialiasing', true);
		addLuaSprite('luther', false);

		makeAnimatedLuaSprite('needlemouse', 'bgs/christmas/christma-needle', -1450, 735);
		scaleObject('needlemouse', 0.5, 0.5);
		setScrollFactor('needlemouse', 1, 1);
		addAnimationByPrefix('needlemouse', 'idle', 'Needle', 24, false);
		setProperty('needlemouse.antialiasing', true);
		setProperty('needlemouse.flipX', true);
		addLuaSprite('needlemouse', false);
	end
	if songName == 'slaybells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeAnimatedLuaSprite('snow-slaybells', 'bgs/christmas/Slayballs_snow', -1400, 50);
		scaleObject('snow-slaybells', 1, 1);
		setScrollFactor('snow-slaybells', 1, 1);
		addAnimationByPrefix('snow-slaybells', 'idle', 'Snow Slaybells', 24, true);
		setProperty('snow-slaybells.antialiasing', true);
		addLuaSprite('snow-slaybells', true);
	end
	if songName == 'jingle-hells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeAnimatedLuaSprite('snow-jingle-hells', 'bgs/christmas/Jingle_Hells_Snow', -1400, 50);
		scaleObject('snow-jingle-hells', 1, 1);
		setScrollFactor('snow-jingle-hells', 1, 1);
		addAnimationByPrefix('snow-jingle-hells', 'idle', 'Jingle Snow', 24, true);
		setProperty('snow-jingle-hells.antialiasing', true);
		addLuaSprite('snow-jingle-hells', true);
	end
	if songName == 'jingle-hells' and getPropertyFromClass('ClientPrefs', 'Optimization') == false then
		makeLuaSprite('flashingshit', '', 0, 0);
		makeGraphic('flashingshit',1920,1080,'FFFFFF')
		addLuaSprite('flashingshit', true);
		setLuaSpriteScrollFactor('flashingshit',0,0)
		setProperty('flashingshit.scale.x',2)
		setProperty('flashingshit.scale.y',2)
		setProperty('flashingshit.alpha',0)
		setObjectCamera('flashingshit', 'hud')
	end
	end
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == true then
		if songName == 'slaybells' then
		xx = -280;
		yy = 800;
		xx2 = 580;
		yy2 = 1000;
		xx3 = 80;
		yy3 = 1000;
	end
	if songName == 'jingle-hells' then
		xx = -280;
		yy = 1000;
		xx2 = 580;
		yy2 = 1000;
		xx3 = 80;
		yy3 = 950;
	end	
	end
	if songName == 'missiletoe' then
		boxAnim = false
	end
end

function onSongStart()
	boxAnim = true
	triggerEvent('Play Animation','box','Dad')
end

function onBeatHit()
	if curBeat % 1 == 0 then
		objectPlayAnimation('speakers', 'idle', true)
	end
	if curBeat % 2 == 0 then
		objectPlayAnimation('fleetway', 'idle', true)
		objectPlayAnimation('curse', 'idle', true)
		objectPlayAnimation('devoid', 'idle', true)
		objectPlayAnimation('sunky', 'idle', true)
		objectPlayAnimation('rerun', 'idle', true)
		objectPlayAnimation('requital', 'idle', true)
		objectPlayAnimation('melthog', 'idle', true)
		objectPlayAnimation('grimbo', 'idle', true)
		objectPlayAnimation('sanic', 'idle', true)
		objectPlayAnimation('wechidna', 'idle', true)
		objectPlayAnimation('chaotix', 'idle', true)
		objectPlayAnimation('faker', 'idle', true)
		objectPlayAnimation('needlemouse', 'idle', true)
		objectPlayAnimation('luther', 'idle', true)
	end
	if songName == "jingle-hells" and disco == true and (getPropertyFromClass('ClientPrefs', 'flashing') == true) then
		if curBeat % 2 == 0 then
			if discoPink == true then
				setProperty('flashingshit.color', getColorFromHex('FF63CB'))
				discoGreen = true;
				discoPink = false;
			end
			if discoBlue == true then
				setProperty('flashingshit.color', getColorFromHex('00FFFF'))
				discoRed = true;
				discoBlue = false;
			end
			
			if discoOpOne == true then
				setProperty('flashingshit.alpha',0.2)
			end
			if discoOpTwo == true then
				setProperty('flashingshit.alpha',0.4)
			end
			doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
		else
			if discoGreen == true then
				setProperty('flashingshit.color', getColorFromHex('93FFB0'))
				discoBlue = true;
				discoGreen = false;
			end
			if discoRed == true then
				setProperty('flashingshit.color', getColorFromHex('F9393F'))
				discoPink = true;
				discoRed = false;
			end
			
			if discoOpOne == true then
				setProperty('flashingshit.alpha',0.2)
			end
			if discoOpTwo == true then
				setProperty('flashingshit.alpha',0.4)
			end
			doTweenAlpha('flashingshit','flashingshit',0,1,'linear')
		end
	end
end

function onStepHit()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 180)
	
	
	if getPropertyFromClass('ClientPrefs', 'PotatoOptimization') == false then
	if songName == 'missiletoe'	then
	
		if curStep == 15 then
			setProperty('box.alpha', 1);
		end
		
	end
	if songName == 'jingle-hells' then
		if curStep == 30 then
			discoOpTwo = true;
		end
		
		if curStep == 1344 then
			discoOpTwo = false;
			discoOpOne = true;
		end
	
		if curStep == 30 or curStep == 542 or curStep == 1086 then
			disco = true;
		end
		
		if curStep == 272 or curStep == 736 or curStep == 1472 then
			disco = false;
		end
	end
	if songName == 'missiletoe' then
		setProperty('gfGroup.visible',false)
	end
	if curStep >= 18 and songName == 'missiletoe' then
		songPos = getSongPosition()
		local currentBeat = (songPos / 300) * (bpm / 180)
		doTweenY(dadTweeY, 'dad', 340-50*math.sin((currentBeat*0.25)*math.pi),0.001)
	end
	end
end
function onUpdate(elapsed)
	if boxAnim == false then
		triggerEvent('Play Animation','box-begin','Dad')
	end
	
	if songName == 'jingle-hells' or songName == 'slaybells' then
		if del > 0 then
			del = del - 1
		end
		if del2 > 0 then
			del2 = del2 - 1
		end	
		if followchars == true then
			if mustHitSection == false and not gfSection then
				setProperty('defaultCamZoom',0.6)
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
				end	
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
					triggerEvent('Camera Follow Pos',xx,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy)
				end
			elseif mustHitSection == true then
				setProperty('defaultCamZoom',0.6)
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
			elseif mustHitSection == false and gfSection then
				setProperty('defaultCamZoom',0.6)
				if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx3-ofs,yy3)
				end
				if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx3+ofs,yy3)
				end
				if getProperty('gf.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx3,yy3-ofs)
				end
				if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx3,yy3+ofs)
				end	
				if getProperty('gf.animation.curAnim.name') == 'idle-alt' then
					triggerEvent('Camera Follow Pos',xx3,yy3)
				end
				if getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx3,yy3)
				end
			else 
				triggerEvent('Camera Follow Pos','','')
			end
		end
	end
end