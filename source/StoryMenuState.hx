package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.FlxCamera;

using StringTools;

#if windows
import Discord.DiscordClient;
#end

class StoryMenuState extends MusicBeatState
{
	var ezbg:FlxSprite;
	var bg:FlxSprite;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var leftArrow1:FlxSprite;
	var rightArrow1:FlxSprite;
	var leftArrow2:FlxSprite;
	var rightArrow2:FlxSprite;
	var SelectedSongExe:Int = 0;
	var SelectedSongAlt:Int = 0;
	var oneclickpls:Bool = true;
	var bfIDLELAWL:StoryModeMenuBFidle;
	var bfALTIDLELAWL:StoryModeMenuBFidle;
	var redBOX:FlxSprite;
	var selection:Int = 1;
	var songArrayExe = ['too-slow', 'you-cant-run', 'triple-trouble', 'final-escape', 'face-off'];
	var songArrayAlt = ['coulrophobia', 'broken-heart', 'tribal', 'goddess'];
	var AltSelected:Bool = false;
	var WeekSelected:String = 'exe';
	var staticscreen:FlxSprite;
	var staticscreenAlt:FlxSprite;
	var portrait:FlxSprite;
	var portraitAlt:FlxSprite;
	var greyBOX:FlxSprite;
	var greyALTBOX:FlxSprite;
	var yellowBOX:FlxSprite;
	var yellowALTBOX:FlxSprite;
	var lock:FlxSprite;
	private var camGame:FlxCamera;
	var blackScreen:FlxSprite;
	var MouseSelection:Int = 0;
	
	var hitboxOne:FlxSprite;
	var hitboxTwo:FlxSprite;
	var hitboxThree:FlxSprite;
	var hitboxOneALT:FlxSprite;
	var hitboxTwoALT:FlxSprite;
	var hitboxThreeALT:FlxSprite;
	
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var scoreText:FlxText;
	
	var GoreContent:Bool = false;
	var GoreWarningMenu:Bool = false;
	public static var GoreAccept:Bool = false;
	public static var GoreBack:Bool = false;
	override function create()
	{
		Paths.clearUnusedMemory();
		GoreAccept = false;
		GoreBack = false;
		persistentUpdate = persistentDraw = true;
		if (!ClientPrefs.vineboom) {
			if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
				FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.7);
			}
		} else {
			FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.7);
			ClientPrefs.vineboom = false;
			ClientPrefs.saveSettings();
		}
		switch (ClientPrefs.storyProgressExe)
		{
			case 0:
				songArrayExe = ['too-slow'];
			case 1:
				songArrayExe = ['too-slow', 'you-cant-run'];
			case 2:
				songArrayExe = ['too-slow', 'you-cant-run', 'triple-trouble'];
			case 3:
				songArrayExe = ['too-slow', 'you-cant-run', 'triple-trouble', 'final-escape'];
			case 4:
				songArrayExe = ['too-slow', 'you-cant-run', 'triple-trouble', 'final-escape', 'face-off'];
		}
		switch (ClientPrefs.storyProgressAlt)
		{
			case 0:
				songArrayAlt = ['coulrophobia'];
			case 1:
				songArrayAlt = ['coulrophobia', 'broken-heart'];
			case 2:
				songArrayAlt = ['coulrophobia', 'broken-heart', 'tribal'];
			case 3:
				songArrayAlt = ['coulrophobia', 'broken-heart', 'tribal', 'goddess'];
		}
		PlayState.isStory = true;
		PlayState.isEncore = false;
		PlayState.isExtras = false;
		PlayState.isSound = false;
		PlayState.isFreeplay = false;
		
		PlayState.BFEncoreSkins = false;
		PlayState.BFSkins = false;
		PlayState.GFEncoreSkins = false;
		PlayState.GFSkins = false;
		
		#if desktop
		var rpcName:String = 'In Story Mode Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.smallImageRpc = '';
		DiscordClient.imageRpc = songArrayExe[SelectedSongExe];
		DiscordClient.changePresence(rpcName, null);
		#end

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];

		FlxG.sound.playMusic(Paths.music('storymode'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);

		bg = new FlxSprite(0, 0);
		bg.frames = Paths.getSparrowAtlas('story-mode/bg');
		bg.animation.addByPrefix('idlexd', "static", 24);
		bg.animation.play('idlexd');
		bg.alpha = 1;
		bg.antialiasing = true;
		bg.setGraphicSize(Std.int(bg.width));
		bg.updateHitbox();
		add(bg);

		greyBOX = new FlxSprite(147, 76).loadGraphic(Paths.image('story-mode/greybox'));
		greyBOX.antialiasing = true;
		greyBOX.updateHitbox();
		add(greyBOX);
		
		greyALTBOX = new FlxSprite(747, 76).loadGraphic(Paths.image('story-mode/greybox'));
		greyALTBOX.antialiasing = true;
		greyALTBOX.updateHitbox();
		add(greyALTBOX);

		bfIDLELAWL = new StoryModeMenuBFidle(120, 150);
		bfIDLELAWL.scale.x = .4;
		bfIDLELAWL.scale.y = .4;
		bfIDLELAWL.y += 50;
		bfIDLELAWL.antialiasing = true;
		bfIDLELAWL.animation.play('idleLAWLAW', true);
		add(bfIDLELAWL);

		bfALTIDLELAWL = new StoryModeMenuBFidle(715, 150, true);
		bfALTIDLELAWL.scale.x = .4;
		bfALTIDLELAWL.scale.y = .4;
		bfALTIDLELAWL.y += 50;
		bfALTIDLELAWL.antialiasing = true;
		bfALTIDLELAWL.animation.play('idleLAWLAW', true);
		if (ClientPrefs.storyProgressExe == 5) add(bfALTIDLELAWL);

		portrait = new FlxSprite(150, 79).loadGraphic(Paths.image('story-mode/exe/too-slow'));
		portrait.setGraphicSize(Std.int(portrait.width * 0.275));
		portrait.antialiasing = true;
		portrait.updateHitbox();
		add(portrait);
		
		portraitAlt = new FlxSprite(750, 79).loadGraphic(Paths.image('story-mode/alt/coulrophobia'));
		portraitAlt.setGraphicSize(Std.int(portraitAlt.width * 0.275));
		portraitAlt.antialiasing = true;
		portraitAlt.updateHitbox();
		if (ClientPrefs.storyProgressExe == 5) add(portraitAlt);

		staticscreen = new FlxSprite(150, 0);
		staticscreen.frames = Paths.getSparrowAtlas('story-mode/static');
		staticscreen.animation.addByPrefix('screenstaticANIM', "screenSTATIC", 24);
		staticscreen.animation.play('screenstaticANIM');
		staticscreen.y += 79;
		staticscreen.alpha = 0.3;
		staticscreen.antialiasing = true;
		staticscreen.setGraphicSize(Std.int(staticscreen.width * 0.275));
		staticscreen.updateHitbox();
		add(staticscreen);
		
		staticscreenAlt = new FlxSprite(750, 0);
		staticscreenAlt.frames = Paths.getSparrowAtlas('story-mode/static');
		staticscreenAlt.animation.addByPrefix('screenstaticANIM', "screenSTATIC", 24);
		staticscreenAlt.animation.play('screenstaticANIM');
		staticscreenAlt.y += 79;
		if (ClientPrefs.storyProgressExe == 5) staticscreenAlt.alpha = 0.3;
		if (ClientPrefs.storyProgressExe != 5) staticscreenAlt.alpha = 1;
		staticscreenAlt.antialiasing = true;
		staticscreenAlt.setGraphicSize(Std.int(staticscreenAlt.width * 0.275));
		staticscreenAlt.updateHitbox();
		add(staticscreenAlt);

		yellowBOX = new FlxSprite(145, 77).loadGraphic(Paths.image('story-mode/yellowbox'));
		yellowBOX.alpha = 1;
		yellowBOX.antialiasing = true;
		yellowBOX.updateHitbox();
		add(yellowBOX);
		
		yellowALTBOX = new FlxSprite(745, 77).loadGraphic(Paths.image('story-mode/yellowbox'));
		yellowALTBOX.alpha = 1;
		yellowALTBOX.antialiasing = true;
		yellowALTBOX.updateHitbox();
		add(yellowALTBOX);

		redBOX = new FlxSprite(120, 56).loadGraphic(Paths.image('story-mode/redbox'));
		redBOX.alpha = 1;
		redBOX.antialiasing = true;
		redBOX.updateHitbox();
		add(redBOX);

		sprDifficulty = new FlxSprite(297, 600);
		sprDifficulty.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('hard');
		sprDifficulty.antialiasing = true;
		add(sprDifficulty);

		leftArrow = new FlxSprite(147, sprDifficulty.y);
		leftArrow.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.8));
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = true;
		add(leftArrow);

		rightArrow = new FlxSprite(443, sprDifficulty.y);
		rightArrow.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.8));
		rightArrow.animation.addByPrefix('idle', "arrow right");
		rightArrow.animation.addByPrefix('press', "arrow push right");
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = true;
		add(rightArrow);
		
		leftArrow1 = new FlxSprite(550, 400);
		leftArrow1.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		leftArrow1.setGraphicSize(Std.int(leftArrow1.width * 0.8));
		leftArrow1.animation.addByPrefix('idle', "arrow left");
		leftArrow1.animation.addByPrefix('press', "arrow push left");
		leftArrow1.animation.play('idle');
		leftArrow1.antialiasing = true;
		if (ClientPrefs.storyProgressExe == 5) add(leftArrow1);

		rightArrow1 = new FlxSprite(535, 400);
		rightArrow1.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		rightArrow1.setGraphicSize(Std.int(rightArrow1.width * 0.8));
		rightArrow1.animation.addByPrefix('idle', "arrow right");
		rightArrow1.animation.addByPrefix('press', "arrow push right");
		rightArrow1.animation.play('idle');
		rightArrow1.antialiasing = true;
		if (ClientPrefs.storyProgressExe == 5) add(rightArrow1);
		
		leftArrow2 = new FlxSprite(50, 141);
		leftArrow2.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		leftArrow2.setGraphicSize(Std.int(leftArrow2.width * 0.8));
		leftArrow2.animation.addByPrefix('idle', "arrow left");
		leftArrow2.animation.addByPrefix('press', "arrow push left");
		leftArrow2.animation.play('idle');
		leftArrow2.antialiasing = true;
		add(leftArrow2);

		rightArrow2 = new FlxSprite(535, 141);
		rightArrow2.frames = Paths.getSparrowAtlas('story-mode/difficulties');
		rightArrow2.setGraphicSize(Std.int(rightArrow2.width * 0.8));
		rightArrow2.animation.addByPrefix('idle', "arrow right");
		rightArrow2.animation.addByPrefix('press', "arrow push right");
		rightArrow2.animation.play('idle');
		rightArrow2.antialiasing = true;
		add(rightArrow2);

		lock = new FlxSprite(892, 350).loadGraphic(Paths.image('story-mode/locked'));
		lock.antialiasing = true;
		lock.updateHitbox();
		if (ClientPrefs.storyProgressExe != 5) add(lock);

		hitboxOne = new FlxSprite(73,57).makeGraphic(521, 221, 0x00000000);
		add(hitboxOne);
		hitboxTwo = new FlxSprite(73,309).makeGraphic(521, 261, 0x00000000);
		add(hitboxTwo);
		hitboxThree = new FlxSprite(73,599).makeGraphic(521, 87, 0x00000000);
		add(hitboxThree);
		hitboxOneALT = new FlxSprite(686,57).makeGraphic(521, 221, 0x00000000);
		add(hitboxOneALT);
		hitboxTwoALT = new FlxSprite(686,309).makeGraphic(521, 261, 0x00000000);
		add(hitboxTwoALT);
		hitboxThreeALT = new FlxSprite(686,599).makeGraphic(521, 87, 0x00000000);
		add(hitboxThreeALT);

		scoreText = new FlxText(205, -5, 0, "SCORE: ", 55);
		scoreText.setFormat(Paths.font("advanced.ttf"), scoreText.size, 0xFFF0303A, CENTER);
		scoreText.setBorderStyle(SHADOW, 0xFF591F26, 4, 1);
		add(scoreText);
		if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
			scoreText.text = TranslationLanguages.Text[scoreText.text];

		sprDifficulty.offset.x = 70;
		sprDifficulty.y = leftArrow.y + 10;
		sprDifficulty.alpha = 0;
		sprDifficulty.y = leftArrow.y - 15;
		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 10, alpha: 1}, 0.07);

		leftArrow.alpha = 0.3;
		rightArrow.alpha = 0.3;
		leftArrow1.alpha = 0.3;
		leftArrow1.visible = false;
		rightArrow1.alpha = 0.3;
		leftArrow2.alpha = 1.0;
		rightArrow2.alpha = 1.0;

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.cameras = [camGame];
		blackScreen.alpha = 0;
		add(blackScreen);
		
		ScoreUPD();
		
		#if mobile
		addVirtualPad(LEFT_FULL, A_B);
		virtualPad.y = -26;
		#end
		super.create();
	}

	function changediff()
	{
		sprDifficulty.alpha = 0;
		sprDifficulty.y = leftArrow.y - 15;
		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 10, alpha: 1}, 0.07);
	}

	function ScoreUPD()
	{
		if (!AltSelected) {
			#if !switch
			intendedScore = Highscore.getScore(songArrayExe[SelectedSongExe], 2);
			intendedRating = Highscore.getRating(songArrayExe[SelectedSongExe], 2);
			#end
			scoreText.text = 'Story-SCORE: ';
			if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
				scoreText.text = TranslationLanguages.Text[scoreText.text] + lerpScore;
			else
				scoreText.text = 'SCORE: ' + lerpScore;
			scoreText.screenCenter(X);
			scoreText.x -= 315;
			if (selection == 1)
				scoreText.alpha = 1;
			else
				scoreText.alpha = 0;
		} else {
			if (ClientPrefs.storyProgressAlt != 0)
			{
				#if !switch
				intendedScore = Highscore.getScore(songArrayAlt[SelectedSongAlt], 2);
				intendedRating = Highscore.getRating(songArrayAlt[SelectedSongAlt], 2);
				#end
				scoreText.text = 'Story-SCORE: ';
				if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
					scoreText.text = TranslationLanguages.Text[scoreText.text] + lerpScore;
				else
					scoreText.text = 'SCORE: ' + lerpScore;
				scoreText.screenCenter(X);
				scoreText.x += 290;
				if (selection == 1)
					scoreText.alpha = 1;
				else
					scoreText.alpha = 0;
			} else {
				scoreText.alpha = 0;
			}
		}
	}

	function changeAct(Act:Int = 1)
	{	
		if (ClientPrefs.storyProgressExe != 0)
		{		
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

			SelectedSongExe += Act;
			if (SelectedSongExe < 0)
				SelectedSongExe = songArrayExe.length - 1;
			else if (SelectedSongExe > songArrayExe.length - 1)
				SelectedSongExe = 0;
				
			portrait.loadGraphic(Paths.image('story-mode/exe/' + songArrayExe[SelectedSongExe]));

			FlxTween.cancelTweensOf(staticscreen);
			staticscreen.alpha = 1;
			FlxTween.tween(staticscreen, {alpha: 0.3}, 1);
			
			#if desktop
			DiscordClient.imageRpc = songArrayExe[SelectedSongExe];
			DiscordClient.changePresence();
			#end

			#if !switch
			intendedScore = Highscore.getScore(songArrayExe[SelectedSongExe], 2);
			intendedRating = Highscore.getRating(songArrayExe[SelectedSongExe], 2);
			#end
		}
	}

	function changeActAlt(ActAlt:Int = 1)
	{	
		if (ClientPrefs.storyProgressAlt != 0)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

			SelectedSongAlt += ActAlt;
			if (SelectedSongAlt < 0)
				SelectedSongAlt = songArrayAlt.length - 1;
			else if (SelectedSongAlt > songArrayAlt.length - 1)
				SelectedSongAlt = 0;
				
			portraitAlt.loadGraphic(Paths.image('story-mode/alt/' + songArrayAlt[SelectedSongAlt]));

			FlxTween.cancelTweensOf(staticscreenAlt);
			staticscreenAlt.alpha = 1;
			FlxTween.tween(staticscreenAlt, {alpha: 0.3}, 1);
			
			#if desktop
			DiscordClient.imageRpc = songArrayAlt[SelectedSongAlt];
			DiscordClient.changePresence();
			#end
			
			#if !switch
			intendedScore = Highscore.getScore(songArrayAlt[SelectedSongAlt], 2);
			intendedRating = Highscore.getRating(songArrayAlt[SelectedSongAlt], 2);
			#end
		}
	}

	function changeWeek(alt:Bool = false, ?shit:Bool = false, ?disabledafuk:Bool = false)
	{
		if (ClientPrefs.storyProgressExe == 5 && !shit) {
			if (!alt)
			{
				sprDifficulty.x = 297;
				redBOX.x = 120;

				leftArrow.x = 147;
				rightArrow.x = 443;
				leftArrow1.x = 650;
				rightArrow1.x = 535;
				leftArrow2.x = 50;
				rightArrow2.x = 535;
				
				#if desktop
				DiscordClient.imageRpc = songArrayExe[SelectedSongExe];
				DiscordClient.changePresence();
				#end
				AltSelected = false;
			}
			if (alt)
			{
				sprDifficulty.x = 897;
				redBOX.x = 720;
				
				leftArrow.x = 747;
				rightArrow.x = 1043;
				leftArrow1.x = 650;
				rightArrow1.x = 535;
				leftArrow2.x = 650;
				rightArrow2.x = 1135;
				
				#if desktop
				DiscordClient.imageRpc = songArrayAlt[SelectedSongAlt];
				DiscordClient.changePresence();
				#end
				AltSelected = true;
			}
		}
		if (!disabledafuk) {
			if (!AltSelected) {
				leftArrow1.visible = false;
				rightArrow1.visible = true;
			}
			if (AltSelected) {
				leftArrow1.visible = true;
				rightArrow1.visible = false;
			}
		}
	}

	function Select(sel:Int)
	{
		selection = sel;
		
		switch (sel)
		{
			case 1:
				leftArrow.alpha = 0.3;
				rightArrow.alpha = 0.3;
				if (MouseSelection == 0) {
					leftArrow1.alpha = 0.3;
					rightArrow1.alpha = 0.3;
				}
				leftArrow2.alpha = 1.0;
				rightArrow2.alpha = 1.0;
			case 2:
				leftArrow.alpha = 0.3;
				rightArrow.alpha = 0.3;
				if (MouseSelection == 0) {
					leftArrow1.alpha = 1.0;
					rightArrow1.alpha = 1.0;
				}
				leftArrow2.alpha = 0.3;
				rightArrow2.alpha = 0.3;
			case 3:
				leftArrow.alpha = 1.0;
				rightArrow.alpha = 1.0;
				if (MouseSelection == 0) {
					leftArrow1.alpha = 0.3;
					rightArrow1.alpha = 0.3;
				}
				leftArrow2.alpha = 0.3;
				rightArrow2.alpha = 0.3;
		}

	}

	override public function update(elapsed:Float)
	{
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;
		ScoreUPD();
		
		if (!ClientPrefs.gore) {
			if (!AltSelected) {
				switch(songArrayExe[SelectedSongExe]) {
					case 'too-slow', 'triple-trouble':
						GoreContent = true;
					default:
						GoreContent = false;
				}
			} else {
				switch(songArrayAlt[SelectedSongAlt]) {
					case 'coulrophobia', 'goddess':
						GoreContent = true;
					default:
						GoreContent = false;
				}
			}
		}
		
		if (ClientPrefs.flashing && GoreAccept) {
			FlxFlicker.flicker(redBOX, 1, 0.06, false, false, function(flick:FlxFlicker) {});
			GoreAccept = false;
		}
		if (GoreBack) {
			GoreWarningMenu = false;
			oneclickpls = true;
			GoreBack = false;
		}

		if (!GoreWarningMenu) {
			#if desktop
			if (!FlxG.mouse.overlaps(yellowBOX) && !FlxG.mouse.overlaps(yellowALTBOX)) MouseSelection = 0;
			if (FlxG.mouse.overlaps(yellowBOX) && !FlxG.mouse.overlaps(yellowALTBOX) || FlxG.mouse.overlaps(hitboxOne) || FlxG.mouse.overlaps(hitboxTwo) || FlxG.mouse.overlaps(hitboxThree)) MouseSelection = 1;
			if (!FlxG.mouse.overlaps(yellowBOX) && FlxG.mouse.overlaps(yellowALTBOX) && ClientPrefs.storyProgressExe == 5 || FlxG.mouse.overlaps(hitboxOneALT) || FlxG.mouse.overlaps(hitboxTwoALT) || FlxG.mouse.overlaps(hitboxThreeALT)) MouseSelection = 2;
			#end
			if (MouseSelection == 0) {
				if (leftArrow1.visible == false && rightArrow1.visible == false) changeWeek(false, true);
				if (controls.UI_LEFT_P && oneclickpls)
				{
					switch (selection)
					{
						case 1:
							if (!AltSelected) changeAct(-1);
							if (AltSelected) changeActAlt(-1);
						case 2:
							changeWeek(false);
						case 3:
							changediff();
					}
				}

				if (controls.UI_RIGHT_P && oneclickpls)
				{
					switch (selection)
					{
						case 1:
							if (!AltSelected) changeAct(1);
							if (AltSelected) changeActAlt(1);
						case 2:
							changeWeek(true);
						case 3:
							changediff();
					}
				}

				if (controls.UI_UP_P && oneclickpls) {
					if (ClientPrefs.storyProgressExe != 5) Select(1);
					if (ClientPrefs.storyProgressExe == 5) {
						switch (selection)
						{
						case 2:
							Select(1);
						case 3:
							Select(2);
						}
					}
				}
				
				if (controls.UI_DOWN_P && oneclickpls) {
					if (ClientPrefs.storyProgressExe != 5) Select(3);
					if (ClientPrefs.storyProgressExe == 5) {
						switch (selection)
						{
							case 1:
								Select(2);
							case 2:
								Select(3);
						}
					}
				}

				if (oneclickpls) {
					if (controls.UI_LEFT) {
						switch (selection)
						{
							case 1:
								leftArrow2.animation.play('press');
							case 2:
								leftArrow1.animation.play('press');
							case 3:
								leftArrow.animation.play('press');
						}
					} else {
						switch (selection)
						{
							case 1:
								leftArrow2.animation.play('idle');
							case 2:
								leftArrow1.animation.play('idle');
							case 3:
								leftArrow.animation.play('idle');
						}
					}
					if (controls.UI_RIGHT) {
						switch (selection)
						{
							case 1:
								rightArrow2.animation.play('press');
							case 2:
								rightArrow1.animation.play('press');
							case 3:
								rightArrow.animation.play('press');
						}
					} else {
						switch (selection)
						{
							case 1:
								rightArrow2.animation.play('idle');
							case 2:
								rightArrow1.animation.play('idle');
							case 3:
								rightArrow.animation.play('idle');
						}
					}
				}
			} else {
				leftArrow1.visible = false;
				rightArrow1.visible = false;
				#if desktop
				if (MouseSelection == 1 && oneclickpls) {
					changeWeek(false, false, true);
					if (FlxG.mouse.overlaps(hitboxOne) && selection != 1) Select(1);
					if (FlxG.mouse.overlaps(hitboxTwo) && selection != 2 && ClientPrefs.storyProgressExe == 5) Select(2);
					if (FlxG.mouse.overlaps(hitboxThree) && selection != 3) Select(3);
					if (FlxG.mouse.justPressed) {
						if (FlxG.mouse.overlaps(leftArrow2)) {
							leftArrow2.animation.play('press');
							changeAct(-1);
						}
						if (FlxG.mouse.overlaps(rightArrow2)) {
							rightArrow2.animation.play('press');
							changeAct(1);
						}
						if (FlxG.mouse.overlaps(leftArrow)) {
							leftArrow.animation.play('press');
							changediff();
						}
						if (FlxG.mouse.overlaps(rightArrow)) {
							rightArrow.animation.play('press');
							changediff();
						}
					} else {
						leftArrow2.animation.play('idle');
						rightArrow2.animation.play('idle');
						leftArrow.animation.play('idle');
						rightArrow.animation.play('idle');
					}
				}
				if (MouseSelection == 2 && oneclickpls) {
					changeWeek(true, false, true);
					if (FlxG.mouse.overlaps(hitboxOneALT) && selection != 1) Select(1);
					if (FlxG.mouse.overlaps(hitboxTwoALT) && selection != 2) Select(2);
					if (FlxG.mouse.overlaps(hitboxThreeALT) && selection != 3) Select(3);
					if (FlxG.mouse.justPressed) {
						if (FlxG.mouse.overlaps(leftArrow2)) {
							leftArrow2.animation.play('press');
							changeActAlt(-1);
						}
						if (FlxG.mouse.overlaps(rightArrow2)) {
							rightArrow2.animation.play('press');
							changeActAlt(1);
						}
						if (FlxG.mouse.overlaps(leftArrow)) {
							leftArrow.animation.play('press');
							changediff();
						}
						if (FlxG.mouse.overlaps(rightArrow)) {
							rightArrow.animation.play('press');
							changediff();
						}
					} else {
						leftArrow2.animation.play('idle');
						rightArrow2.animation.play('idle');
						leftArrow.animation.play('idle');
						rightArrow.animation.play('idle');
					}
				}
				#end
			}

			if ((controls.BACK #if desktop || FlxG.mouse.justPressedRight #end) && oneclickpls)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxG.switchState(new MainMenuState());
				oneclickpls = false;
			}

			if (controls.ACCEPT #if desktop || (FlxG.mouse.overlaps(redBOX) && (FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed)) #end)
			{
				if (oneclickpls)
				{
					oneclickpls = false;
					if (!GoreContent) FlxG.sound.play(Paths.sound('confirmMenu'));
					
					if (!AltSelected) {
						if (ClientPrefs.storyProgressExe != 5) {
							switch (ClientPrefs.storyProgressExe) {
								case 0:
									if (songArrayExe[SelectedSongExe] == 'too-slow') PlayState.storyPlaylist = ['too-slow', 'you-cant-run', 'triple-trouble'];
								case 1:
									if (songArrayExe[SelectedSongExe] == 'you-cant-run') PlayState.storyPlaylist = ['you-cant-run', 'triple-trouble'];
								case 2:
									if (songArrayExe[SelectedSongExe] == 'triple-trouble') PlayState.storyPlaylist = ['triple-trouble'];
								case 3:
									if (songArrayExe[SelectedSongExe] == 'final-escape') PlayState.storyPlaylist = ['final-escape', 'face-off'];
								case 4:
									if (songArrayExe[SelectedSongExe] == 'face-off') PlayState.storyPlaylist = ['face-off'];
							}
							PlayState.isStoryMode = true;
							PlayState.storyDifficulty = 2;
							PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
							PlayState.storyWeek = 1;
							if (!GoreContent) {
								new FlxTimer().start(1, function(tmr:FlxTimer) { Main.InPlaystate = true; LoadingState.loadAndSwitchState(new PlayState()); });
							} else {
								openSubState(new GoreWarningSubstate(false, false, false, 1, true, 'story', 'playstate'));
								GoreWarningMenu = true;
							}
						} else {
							if (songArrayExe[SelectedSongExe] == 'too-slow') PlayState.SONG = Song.loadFromJson('too-slow' + '-hard', 'too-slow');
							if (songArrayExe[SelectedSongExe] == 'you-cant-run') PlayState.SONG = Song.loadFromJson('you-cant-run' + '-hard', 'you-cant-run');
							if (songArrayExe[SelectedSongExe] == 'triple-trouble') PlayState.SONG = Song.loadFromJson('triple-trouble' + '-hard', 'triple-trouble');
							if (songArrayExe[SelectedSongExe] == 'final-escape') PlayState.SONG = Song.loadFromJson('final-escape' + '-hard', 'final-escape');
							if (songArrayExe[SelectedSongExe] == 'face-off') PlayState.SONG = Song.loadFromJson('face-off' + '-hard', 'face-off');
							PlayState.isStoryMode = true;
							PlayState.storyDifficulty = 2;
							PlayState.storyWeek = 1;
							if (!GoreContent) {
								new FlxTimer().start(1, function(tmr:FlxTimer) { Main.InPlaystate = true; LoadingState.loadAndSwitchState(new PlayState()); });
							} else {
								openSubState(new GoreWarningSubstate(false, false, false, 1, true, 'story', 'playstate'));
								GoreWarningMenu = true;
							}
						}
					} else {
						if (ClientPrefs.storyProgressAlt != 4) {
							switch (ClientPrefs.storyProgressAlt) {
								case 0:
									if (songArrayAlt[SelectedSongAlt] == 'coulrophobia') PlayState.storyPlaylist = ['coulrophobia', 'broken-heart', 'tribal', 'goddess'];
								case 1:
									if (songArrayAlt[SelectedSongAlt] == 'broken-heart') PlayState.storyPlaylist = ['broken-heart', 'tribal', 'goddess'];
								case 2:
									if (songArrayAlt[SelectedSongAlt] == 'tribal') PlayState.storyPlaylist = ['tribal', 'goddess'];
								case 3:
									if (songArrayAlt[SelectedSongAlt] == 'goddess') PlayState.storyPlaylist = ['goddess'];
							}
							PlayState.isStoryMode = true;
							PlayState.storyDifficulty = 2;
							PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
							PlayState.storyWeek = 15;
							
							if (!GoreContent) {
								if (songArrayAlt[SelectedSongAlt] == 'coulrophobia') { 
									FlxTween.tween(blackScreen, {alpha: 1}, 0.9);
									FlxG.sound.music.fadeOut(0.9, 0);
									new FlxTimer().start(1, function(tmr:FlxTimer) { openSubState(new RosyMechanicSubstate()); });
								} else {
									new FlxTimer().start(1, function(tmr:FlxTimer) { Main.InPlaystate = true; LoadingState.loadAndSwitchState(new PlayState()); });
								}
							} else {
								if (songArrayAlt[SelectedSongAlt] == 'coulrophobia') { 
									openSubState(new GoreWarningSubstate(true, false, true, 1, true, 'story', 'rosy-mechanic'));
									GoreWarningMenu = true;
								} else {
									openSubState(new GoreWarningSubstate(false, false, false, 1, true, 'story', 'playstate'));
									GoreWarningMenu = true;
								}
							}					
						} else {
							if (songArrayAlt[SelectedSongAlt] == 'coulrophobia') PlayState.SONG = Song.loadFromJson('coulrophobia' + '-hard', 'coulrophobia');
							if (songArrayAlt[SelectedSongAlt] == 'broken-heart') PlayState.SONG = Song.loadFromJson('broken-heart' + '-hard', 'broken-heart');
							if (songArrayAlt[SelectedSongAlt] == 'tribal') PlayState.SONG = Song.loadFromJson('tribal' + '-hard', 'tribal');
							if (songArrayAlt[SelectedSongAlt] == 'goddess') PlayState.SONG = Song.loadFromJson('goddess' + '-hard', 'goddess');
							PlayState.isStoryMode = true;
							PlayState.storyDifficulty = 2;
							PlayState.storyWeek = 15;
							
							if (!GoreContent) {
								if (songArrayAlt[SelectedSongAlt] == 'coulrophobia') { 
									FlxTween.tween(blackScreen, {alpha: 1}, 0.9);
									FlxG.sound.music.fadeOut(0.9, 0);
									new FlxTimer().start(1, function(tmr:FlxTimer) { openSubState(new RosyMechanicSubstate()); });
								} else {
									new FlxTimer().start(1, function(tmr:FlxTimer) { Main.InPlaystate = true; LoadingState.loadAndSwitchState(new PlayState()); });
								}
							} else {
								if (songArrayAlt[SelectedSongAlt] == 'coulrophobia') { 
									openSubState(new GoreWarningSubstate(true, false, true, 1, true, 'story', 'rosy-mechanic'));
									GoreWarningMenu = true;
								} else {
									openSubState(new GoreWarningSubstate(false, false, false, 1, true, 'story', 'playstate'));
									GoreWarningMenu = true;
								}
							}		
						}
					}
				}	
				if (ClientPrefs.flashing && !GoreWarningMenu)
					FlxFlicker.flicker(redBOX, 1, 0.06, false, false, function(flick:FlxFlicker) {});
			}
		}

		super.update(elapsed);
	}
}
