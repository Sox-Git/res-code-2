package;

import flixel.util.FlxTimer;
import flixel.input.gamepad.FlxGamepad;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop; 
import sys.FileSystem; 

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class EncoreState extends MusicBeatState
{
	var whiteshit:FlxSprite;
	var blackshit:FlxSprite;
	var curSelected:Int;
	var songArray:Array<String> = ["too slow encore", "you cant run encore", "triple trouble encore", "endless encore", "cycles encore", "sunshine encore", "chaos encore", "faker encore", "fatality encore", "round a bout encore", "her world encore", "hollow encore", "color blind encore"];
	var boxGRP:FlxTypedSpriteGroup<FlxSprite>;
	var charGRP:FlxTypedSpriteGroup<FlxSprite>;
	var daStaticGRP:FlxTypedSpriteGroup<FlxSprite>;
	var bg:FlxBackdrop;
	var canControl:Bool = true;
	var DeniedSound:Bool = false;
	var sus:Int = 0;
	var songtext:FlxText;
	var scoretext:FlxText;
	private var camGame:FlxCamera;
	var artName:String;
	var arrowLeft:FlxSprite;
	var arrowLeftSel:FlxSprite;
	var arrowRight:FlxSprite;
	var arrowRightSel:FlxSprite;
	var hitboxEnter:FlxSprite;
	
	var TooSlowEncoreSel:FlxTypedSpriteGroup<FlxSprite>;
	var TooSlowEncoreVerOne:FlxSprite;
	var TooSlowEncoreVerTwo:FlxSprite;
	var TooSlowEncoreSelOne:FlxSprite;
	var TooSlowEncoreSelTwo:FlxSprite;
	var TooSlowEncoreWindow:FlxSprite;
	var TooSlowEncoreVerOneEyes:FlxSprite;
	var TooSlowEncoreVerTwoEyes:FlxSprite;
	var TooSlowEncoreExit:FlxSprite;
	var TooSlowEncoreSelAAAAA:Bool = false;
	var TooSlowEncoreSelectedOne:Bool = true;
	var TooSlowEncoreMenuCanControl:Bool = false;
	
	var scoreChoiceText:FlxText;
	var lerpChoiceScore:Int = 0;
	var lerpChoiceRating:Float = 0;
	var intendedChoiceScore:Int = 0;
	var intendedChoiceRating:Float = 0;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var ScoreSongSel:String = '';

	var GoreContent:Bool = false;
	var GoreWarningMenu:Bool = false;
	public static var goreCloseShit:Bool = false;
	
	var Checkbox:FlxSprite;
	var CheckboxCheck:FlxSprite;
	var ShowCutscene:FlxText;
	
	override function create()
	{
		goreCloseShit = false;
		persistentUpdate = persistentDraw = true;
	
		Paths.clearUnusedMemory();
		if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
			FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.7);
		}
		
		curSelected = unlocked.EncoreUnlockedSubstate.EncoreSongSel;
		
		#if desktop
		// Updating Discord Rich Presence
		switch(songArray[curSelected]) {
			case 'too slow encore': DiscordClient.imageRpc = 'too_slow_encore';
			case 'you cant run encore': DiscordClient.imageRpc = 'you_cant_run_encore';
			case 'triple trouble encore': DiscordClient.imageRpc = 'triple_trouble_encore';
			case 'endless encore': DiscordClient.imageRpc = 'endless_encore';
			case 'cycles encore': DiscordClient.imageRpc = 'cycles_encore';
			case 'sunshine encore': DiscordClient.imageRpc = 'sunshine_encore';
			case 'chaos encore': DiscordClient.imageRpc = 'chaos_encore';
			case 'faker encore': DiscordClient.imageRpc = 'faker_encore';
			case 'fatality encore': DiscordClient.imageRpc = 'fatality_encore';
			case 'round a bout encore': DiscordClient.imageRpc = 'round_a_bout_encore';
			case 'her world encore': DiscordClient.imageRpc = 'her_world_encore';
			case 'hollow encore': DiscordClient.imageRpc = 'hollow_encore';
			case 'color blind encore': DiscordClient.imageRpc = 'color_blind_encore';
		}
		var rpcName:String = "In Encore Menu";
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.changePresence(rpcName, null);
		#end
		
		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		FlxG.sound.playMusic(Paths.music('encoremode'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);

		PlayState.isStory = false;
		PlayState.isEncore = true;
		PlayState.isExtras = false;
		PlayState.isSound = false;
		PlayState.isFreeplay = false;
		
		PlayState.BFEncoreSkins = false;
		PlayState.BFSkins = false;
		PlayState.GFEncoreSkins = false;
		PlayState.GFSkins = false;
		
		whiteshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
		whiteshit.alpha = 0;
		blackshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
		blackshit.alpha = 0;

		bg = new FlxBackdrop(Paths.image('freeplay-encore/backgroundlool'), 1, 1, true, false);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);

		boxGRP = new FlxTypedSpriteGroup<FlxSprite>();
		charGRP = new FlxTypedSpriteGroup<FlxSprite>();
		daStaticGRP = new FlxTypedSpriteGroup<FlxSprite>();

		songtext = new FlxText(0, FlxG.height - 90, FlxG.width, '', 25);
		songtext.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(255, 255, 255), CENTER);
		songtext.screenCenter(X);
		add(songtext);
		
		scoretext = new FlxText(0, FlxG.height - 40, FlxG.width, '', 17);
		scoretext.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 17, FlxColor.fromRGB(255, 255, 255), CENTER);
		scoretext.screenCenter(X);
		add(scoretext);
		
		if (songArray[curSelected] == 'too slow encore' || songArray[curSelected] == 'you cant run encore' || songArray[curSelected] == 'triple trouble encore') {
			songtext.text = songArray[curSelected];
		} else {
			shitCode(true);
		}

		for (i in 0...songArray.length)
		{
			if (songArray[sus] == 'too slow encore' || songArray[sus] == 'you cant run encore' || songArray[sus] == 'triple trouble encore') {
				artName = 'encore/' + songArray[sus].toLowerCase();
			} else {
				shitCode(false);
			}
	
			var box:FlxSprite = new FlxSprite(sus * 780, 0).loadGraphic(Paths.image('freeplay-encore/GrayBox'));
			box.ID = i;
			boxGRP.add(box);

			var char:FlxSprite = new FlxSprite(sus * 780, 0).loadGraphic(Paths.image('freeplay-encore/' + artName));
			char.ID = i;
			charGRP.add(char);

			var daStatic:FlxSprite = new FlxSprite();		
			daStatic.frames = Paths.getSparrowAtlas('freeplay-encore/static');	
			daStatic.alpha = 0.2;
			daStatic.ID = i;
			daStatic.setPosition((sus * 780) + 326, 120);			
			daStatic.animation.addByPrefix('static','static', 24, true);			
			daStaticGRP.add(daStatic);
			daStatic.animation.play('static');

			sus += 1;
		}
		add(charGRP);
		add(daStaticGRP);
		add(boxGRP);
		
		hitboxEnter = new FlxSprite(296,93).makeGraphic(689, 534, 0x00000000);
		add(hitboxEnter);
		arrowLeft = new FlxSprite(153, 53).loadGraphic(Paths.image('freeplay-encore/arrow'));
		arrowLeft.antialiasing = ClientPrefs.globalAntialiasing;
		add(arrowLeft);
		arrowLeftSel = new FlxSprite(153, 53).loadGraphic(Paths.image('freeplay-encore/arrow-sel'));
		arrowLeftSel.antialiasing = ClientPrefs.globalAntialiasing;
		arrowLeftSel.alpha = 0;
		add(arrowLeftSel);	
		arrowRight = new FlxSprite(963, 53).loadGraphic(Paths.image('freeplay-encore/arrow'));
		arrowRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowRight.flipX = true;
		add(arrowRight);
		arrowRightSel = new FlxSprite(963, 53).loadGraphic(Paths.image('freeplay-encore/arrow-sel'));
		arrowRightSel.antialiasing = ClientPrefs.globalAntialiasing;
		arrowRightSel.flipX = true;
		arrowRightSel.alpha = 0;
		add(arrowRightSel);
		add(blackshit);
		
		TooSlowEncoreSel = new FlxTypedSpriteGroup<FlxSprite>();
		add(TooSlowEncoreSel);
		TooSlowEncoreVerOne = new FlxSprite(156, 164).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/ver-1'));
		TooSlowEncoreVerOne.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowEncoreSel.add(TooSlowEncoreVerOne);
		if (ClientPrefs.SongsCompleted.contains('too-slow-encore'))
			TooSlowEncoreVerTwo = new FlxSprite(158, 155).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/ver-2'));
		else
			TooSlowEncoreVerTwo = new FlxSprite(158, 155).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/ver-2-locked'));
		TooSlowEncoreVerTwo.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowEncoreSel.add(TooSlowEncoreVerTwo);
		TooSlowEncoreWindow = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/window'));
		TooSlowEncoreWindow.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowEncoreWindow.screenCenter();
		TooSlowEncoreSel.add(TooSlowEncoreWindow);
		TooSlowEncoreVerOneEyes = new FlxSprite(156, 165).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/ver-1-eyes'));
		TooSlowEncoreVerOneEyes.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowEncoreSel.add(TooSlowEncoreVerOneEyes);
		TooSlowEncoreVerTwoEyes = new FlxSprite(159, 155).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/ver-2-eyes'));
		TooSlowEncoreVerTwoEyes.antialiasing = ClientPrefs.globalAntialiasing;
		if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) TooSlowEncoreSel.add(TooSlowEncoreVerTwoEyes);
		TooSlowEncoreSelOne = new FlxSprite(156, 558).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/sel-1'));
		TooSlowEncoreSelOne.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowEncoreSel.add(TooSlowEncoreSelOne);
		TooSlowEncoreSelTwo = new FlxSprite(990, 155).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-slow-encore/sel-2'));
		TooSlowEncoreSelTwo.antialiasing = ClientPrefs.globalAntialiasing;
		if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) TooSlowEncoreSel.add(TooSlowEncoreSelTwo);
		TooSlowEncoreExit = new FlxSprite(124, 45).loadGraphic(Paths.image('exit'));
		TooSlowEncoreExit.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowEncoreSel.add(TooSlowEncoreExit);
		TooSlowEncoreSel.forEach(function(spr:FlxSprite) {
			spr.alpha = 0;
		});
		
		scoreChoiceText = new FlxText(0, FlxG.height - 40, FlxG.width, "", 17);
		scoreChoiceText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), scoreChoiceText.size, FlxColor.WHITE, CENTER);
		scoreChoiceText.screenCenter(X);
		add(scoreChoiceText);
		
		Checkbox = new FlxSprite(5, FlxG.height - 70).loadGraphic(Paths.image('checkbox'));
		Checkbox.antialiasing = ClientPrefs.globalAntialiasing;
		Checkbox.alpha = 0;
		add(Checkbox);	
		
		CheckboxCheck = new FlxSprite(5, FlxG.height - 70).loadGraphic(Paths.image('checkbox-check'));
		CheckboxCheck.antialiasing = ClientPrefs.globalAntialiasing;
		CheckboxCheck.alpha = 0;
		add(CheckboxCheck);	
		
		ShowCutscene = new FlxText(75, FlxG.height - 50, FlxG.width, "Cutscene", 22);
		ShowCutscene.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 22, 0xFFFF0000, LEFT);
		ShowCutscene.alpha = 0;
		add(ShowCutscene);
		if (TranslationLanguages.Text.exists(ShowCutscene.text) && ClientPrefs.Language != 'English')
			ShowCutscene.text = TranslationLanguages.Text[ShowCutscene.text];
		
		add(whiteshit);
		
		switch(curSelected) {
			case 0:
				boxGRP.x = 0;
				charGRP.x = 0;
				daStaticGRP.x = 0;
			case 1:
				boxGRP.x = -780;
				charGRP.x = -780;
				daStaticGRP.x = -780;
			case 2:
				boxGRP.x = -1560;
				charGRP.x = -1560;
				daStaticGRP.x = -1560;
			case 3:
				boxGRP.x = -2340;
				charGRP.x = -2340;
				daStaticGRP.x = -2340;
			case 4:
				boxGRP.x = -3120;
				charGRP.x = -3120;
				daStaticGRP.x = -3120;
			case 5:
				boxGRP.x = -3900;
				charGRP.x = -3900;
				daStaticGRP.x = -3900;
			case 6:
				boxGRP.x = -4680;
				charGRP.x = -4680;
				daStaticGRP.x = -4680;
			case 7:
				boxGRP.x = -5460;
				charGRP.x = -5460;
				daStaticGRP.x = -5460;
			case 8:
				boxGRP.x = -6240;
				charGRP.x = -6240;
				daStaticGRP.x = -6240;
			case 9:
				boxGRP.x = -7020;
				charGRP.x = -7020;
				daStaticGRP.x = -7020;
			case 10:
				boxGRP.x = -7800;
				charGRP.x = -7800;
				daStaticGRP.x = -7800;
			case 11:
				boxGRP.x = -8580;
				charGRP.x = -8580;
				daStaticGRP.x = -8580;
			case 12:
				boxGRP.x = -9360;
				charGRP.x = -9360;
				daStaticGRP.x = -9360;
		}

		boxGRP.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				spr.alpha = 1;
				spr.scale.x = 1;
				spr.scale.y = 1;
			}
			else
			{
				spr.alpha = 0.6;
				spr.scale.x = 0.7;
				spr.scale.y = 0.7;
			}
		});
		
		charGRP.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				spr.alpha = 1;
				spr.scale.x = 1;
				spr.scale.y = 1;
			}
			else
			{
				spr.alpha = 0.6;
				spr.scale.x = 0.7;
				spr.scale.y = 0.7;
			}
		});
		
		daStaticGRP.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				spr.alpha = 0.2;
				spr.scale.x = 1;
				spr.scale.y = 1;
			}
			else
			{
				spr.alpha = 0.1;
				spr.scale.x = 0.7;
				spr.scale.y = 0.7;
			}
		});

		if (curSelected == 0) {
			scoretext.visible = false;
			if (!TooSlowEncoreSelAAAAA)
				scoreChoiceText.visible = false;
			else
				scoreChoiceText.visible = true;
		} else {
			scoretext.visible = true;
			scoreChoiceText.visible = false;
		}

		ScoreUPD();
		super.create();
		
		#if mobile
		addVirtualPad(LEFT_RIGHT, A_B);
		#end
	}
	
	function shitCode(isText:Bool)
	{
		if (isText) {
			if (curSelected == 3) {
				if (ClientPrefs.SongsCompleted.contains('endless'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 4) {
				if (ClientPrefs.SongsCompleted.contains('cycles'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 5) {
				if (ClientPrefs.SongsCompleted.contains('sunshine'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 6) {
				if (ClientPrefs.SongsCompleted.contains('chaos'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 7) {
				if (ClientPrefs.SongsCompleted.contains('faker'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 8) {
				if (ClientPrefs.SongsCompleted.contains('fatality'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 9) {
				if (ClientPrefs.SongsCompleted.contains('round-a-bout'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 10) {
				if (ClientPrefs.SongsCompleted.contains('her-world'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 11) {
				if (ClientPrefs.SongsCompleted.contains('hollow'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
			if (curSelected == 12) {
				if (ClientPrefs.SongsCompleted.contains('color-blind'))
					songtext.text = songArray[curSelected];
				else
					songtext.text = '???';
			}
		} else {
			if (sus == 3) {
				if (ClientPrefs.SongsCompleted.contains('endless'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 4) {
				if (ClientPrefs.SongsCompleted.contains('cycles'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 5) {
				if (ClientPrefs.SongsCompleted.contains('sunshine'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 6) {
				if (ClientPrefs.SongsCompleted.contains('chaos'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 7) {
				if (ClientPrefs.SongsCompleted.contains('faker'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 8) {
				if (ClientPrefs.SongsCompleted.contains('fatality'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 9) {
				if (ClientPrefs.SongsCompleted.contains('round-a-bout'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 10) {
				if (ClientPrefs.SongsCompleted.contains('her-world'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 11) {
				if (ClientPrefs.SongsCompleted.contains('hollow'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
			if (sus == 12) {
				if (ClientPrefs.SongsCompleted.contains('color-blind'))
					artName = 'encore/' + songArray[sus].toLowerCase();
				else
					artName = 'freeplay/locked';
			}
		}

		#if desktop
		switch(songArray[curSelected]) {
			case 'endless encore':
				if (ClientPrefs.SongsCompleted.contains('endless'))
					DiscordClient.imageRpc = 'endless_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'cycles encore':
				if (ClientPrefs.SongsCompleted.contains('cycles'))
					DiscordClient.imageRpc = 'cycles_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'sunshine encore':
				if (ClientPrefs.SongsCompleted.contains('sunshine'))
					DiscordClient.imageRpc = 'sunshine_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'chaos encore':
				if (ClientPrefs.SongsCompleted.contains('chaos'))
					DiscordClient.imageRpc = 'chaos_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'faker encore':
				if (ClientPrefs.SongsCompleted.contains('faker'))
					DiscordClient.imageRpc = 'faker_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'fatality encore':
				if (ClientPrefs.SongsCompleted.contains('fatality'))
					DiscordClient.imageRpc = 'fatality_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'round a bout encore':
				if (ClientPrefs.SongsCompleted.contains('round-a-bout'))
					DiscordClient.imageRpc = 'round_a_bout_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'her world encore':
				if (ClientPrefs.SongsCompleted.contains('her-world'))
					DiscordClient.imageRpc = 'her_world_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'hollow encore':
				if (ClientPrefs.SongsCompleted.contains('hollow'))
					DiscordClient.imageRpc = 'hollow_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
			case 'color blind encore':
				if (ClientPrefs.SongsCompleted.contains('color-blind'))
					DiscordClient.imageRpc = 'color_blind_encore';
				else
					DiscordClient.imageRpc = 'locked_encore';
		}
		DiscordClient.changePresence();
		#end
	}
	
	function TooSlowEncoreSelection(option:String, playSound:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		switch (option) {
			case 'open':
				TooSlowEncoreSelAAAAA = true;
				scoreChoiceText.visible = true;
				canControl = false;
				new FlxTimer().start(0.25, function(lkjh:FlxTimer)
				{
					TooSlowEncoreMenuCanControl = true;
				});
				TooSlowEncoreSel.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 1}, 0.125);
				});
				FlxTween.tween(blackshit, {alpha: 0.75}, 0.125);
				FlxTween.tween(TooSlowEncoreExit, {alpha: 1}, 0.125);
				if (TooSlowEncoreSelectedOne) {
					TooSlowEncoreVerOne.color = 0xFFFFFFFF;
					TooSlowEncoreVerTwo.color = 0xFF232323;
					TooSlowEncoreSelOne.color = 0xFFFFFFFF;
					TooSlowEncoreSelTwo.color = 0xFF7F7F7F;
					TooSlowEncoreVerOneEyes.alpha = 0;
					if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) TooSlowEncoreVerTwoEyes.alpha = 1;
				} else {					
					TooSlowEncoreVerOne.color = 0xFF232323;
					TooSlowEncoreVerTwo.color = 0xFFFFFFFF;
					TooSlowEncoreSelOne.color = 0xFF7F7F7F;
					TooSlowEncoreSelTwo.color = 0xFFFFFFFF;
					TooSlowEncoreVerOneEyes.alpha = 1;
					if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) TooSlowEncoreVerTwoEyes.alpha = 0;
				}
			case 'close':
				FlxG.sound.play(Paths.sound('cancelMenu'));
				TooSlowEncoreSelAAAAA = false;
				scoreChoiceText.visible = false;
				canControl = true;
				TooSlowEncoreMenuCanControl = false;
				TooSlowEncoreSel.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 0}, 0.125);
				});
				FlxTween.tween(blackshit, {alpha: 0}, 0.125);
				FlxTween.tween(TooSlowEncoreExit, {alpha: 0}, 0.125);
			case 'sel-1':
				TooSlowEncoreSelectedOne = true;
				TooSlowEncoreVerOne.color = 0xFFFFFFFF;
				TooSlowEncoreVerTwo.color = 0xFF232323;
				TooSlowEncoreSelOne.color = 0xFFFFFFFF;
				TooSlowEncoreSelTwo.color = 0xFF7F7F7F;
				TooSlowEncoreVerOneEyes.alpha = 0;
				if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) TooSlowEncoreVerTwoEyes.alpha = 1;
			case 'sel-2':
				TooSlowEncoreSelectedOne = false;
				TooSlowEncoreVerOne.color = 0xFF232323;
				TooSlowEncoreVerTwo.color = 0xFFFFFFFF;
				TooSlowEncoreSelOne.color = 0xFF7F7F7F;
				TooSlowEncoreSelTwo.color = 0xFFFFFFFF;
				TooSlowEncoreVerOneEyes.alpha = 1;
				if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) TooSlowEncoreVerTwoEyes.alpha = 0;
		}
	}
	
	function ScoreUPD()
	{
		if (ScoreSongSel != '') {
			#if !switch
			intendedScore = Highscore.getScore(ScoreSongSel, 2);
			intendedRating = Highscore.getRating(ScoreSongSel, 2);
			#end
			scoretext.text = 'Encore-Score: ';
			if (TranslationLanguages.Text.exists(scoretext.text) && ClientPrefs.Language != 'English')
				scoretext.text = TranslationLanguages.Text[scoretext.text] + lerpScore;
			else
				scoretext.text = 'Score: ' + lerpScore;
			if (songArray[curSelected] == 'too slow encore') {
				#if !switch
				intendedChoiceScore = Highscore.getScore(ScoreSongSel, 2);
				intendedChoiceRating = Highscore.getRating(ScoreSongSel, 2);
				#end
				scoreChoiceText.text = 'Encore-Score: ';
				if (TranslationLanguages.Text.exists(scoreChoiceText.text) && ClientPrefs.Language != 'English')
					scoreChoiceText.text = TranslationLanguages.Text[scoreChoiceText.text] + lerpChoiceScore;
				else
					scoreChoiceText.text = 'Score: ' + lerpChoiceScore;
			}
		}
	}
	
	function UPDScoreSongName()
	{
		switch(curSelected) {
			case 0: if (TooSlowEncoreSelectedOne)
						ScoreSongSel = 'too-slow-encore'; 
					else
						ScoreSongSel = 'too-slow-encore-alt';
			case 1: ScoreSongSel = 'you-cant-run-encore'; 
			case 2: ScoreSongSel = 'triple-trouble-encore'; 
			case 3: ScoreSongSel = 'endless-encore';
			case 4: ScoreSongSel = 'cycles-encore';
			case 5: ScoreSongSel = 'sunshine-encore';
			case 6: ScoreSongSel = 'chaos-encore';
			case 7: ScoreSongSel = 'faker-encore';
			case 8: ScoreSongSel = 'fatality-encore';
			case 9: ScoreSongSel = 'round-a-bout-encore';
			case 10: ScoreSongSel = 'her-world-encore';
			case 11: ScoreSongSel = 'hollow-encore';
			case 12: ScoreSongSel = 'color-blind-encore';
			default: ScoreSongSel = '';
		}
	}
	
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		unlocked.EncoreUnlockedSubstate.EncoreSongSel = curSelected;
		UPDScoreSongName();
	
		lerpChoiceScore = Math.floor(FlxMath.lerp(lerpChoiceScore, intendedChoiceScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpChoiceRating = FlxMath.lerp(lerpChoiceRating, intendedChoiceRating, CoolUtil.boundTo(elapsed * 12, 0, 1));
		if (Math.abs(lerpChoiceScore - intendedChoiceScore) <= 10)
			lerpChoiceScore = intendedChoiceScore;
		if (Math.abs(lerpChoiceRating - intendedChoiceRating) <= 0.01)
			lerpChoiceRating = intendedChoiceRating;
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));
		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;
		ScoreUPD();

		arrowLeft.alpha = FlxMath.lerp(arrowLeft.alpha, 0.5, CoolUtil.boundTo(elapsed * 24, 0, 1));
		arrowLeftSel.alpha = FlxMath.lerp(arrowLeftSel.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
		arrowRight.alpha = FlxMath.lerp(arrowRight.alpha, 0.5, CoolUtil.boundTo(elapsed * 24, 0, 1));
		arrowRightSel.alpha = FlxMath.lerp(arrowRightSel.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
		arrowLeft.x = FlxMath.lerp(arrowLeft.x, 113, CoolUtil.boundTo(elapsed * 12, 0, 1));
		arrowLeftSel.x = FlxMath.lerp(arrowLeftSel.x, 113, CoolUtil.boundTo(elapsed * 12, 0, 1));
		arrowRight.x = FlxMath.lerp(arrowRight.x, 1003, CoolUtil.boundTo(elapsed * 12, 0, 1));
		arrowRightSel.x = FlxMath.lerp(arrowRightSel.x, 1003, CoolUtil.boundTo(elapsed * 12, 0, 1));
	
		bg.velocity.set(50, 0);

		boxGRP.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
			else
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.6, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
		});
		
		charGRP.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
			else
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.6, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
		});
		
		daStaticGRP.forEach(function(spr:FlxSprite){
			if(spr.ID == curSelected)
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.2, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
			else
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
		});
		
		if (goreCloseShit) {
			GoreWarningMenu = false;
			if (!TooSlowEncoreMenuCanControl && TooSlowEncoreSelAAAAA)
				TooSlowEncoreMenuCanControl = true;
			if (!TooSlowEncoreMenuCanControl)
				canControl = true;
			else
				canControl = false;
			FlxTransitionableState.skipNextTransIn = false; 
			FlxTransitionableState.skipNextTransOut = false; 
			goreCloseShit = false;
		}
		
		if (!ClientPrefs.gore) {
			switch(ScoreSongSel) {
				case 'too-slow-encore', 'too-slow-encore-alt':
					GoreContent = true;
				default:
					GoreContent = false;
			}
		}
		
		if(canControl) {
			if (!GoreWarningMenu) {
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
				
				if (controls.UI_LEFT_P)
				{
					changeSelection(-shiftMult, 'left');
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					changeSelection(shiftMult, 'right');
					holdTime = 0;
				}
				if(controls.UI_LEFT || controls.UI_RIGHT)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						if (controls.UI_LEFT) changeSelection((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult), 'left');
						if (controls.UI_RIGHT) changeSelection((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult), 'right');
					}
				}
				#if desktop
				if(FlxG.mouse.wheel != 0)
				{
					if (FlxG.mouse.wheel > 0) changeSelection(-shiftMult * FlxG.mouse.wheel,'left');
					if (FlxG.mouse.wheel < 0) changeSelection(-shiftMult * FlxG.mouse.wheel,'right');
					holdTime = 0;
				}
				if (FlxG.mouse.overlaps(arrowLeft) && FlxG.mouse.justPressed) {
					changeSelection(-shiftMult, 'left');
					holdTime = 0;
				}
				if (FlxG.mouse.overlaps(arrowRight) && FlxG.mouse.justPressed) {
					changeSelection(shiftMult, 'right');
					holdTime = 0;
				}
				#end
				
				if (ClientPrefs.cutsceneYouSaw.contains(ScoreSongSel) && ClientPrefs.songsHaveCutsceneCheckbox.contains(ScoreSongSel)) {
					Checkbox.alpha = 1;
					ShowCutscene.alpha = 1;
					if (ClientPrefs.showCutscene.contains(ScoreSongSel))
						CheckboxCheck.alpha = 1;
					else
						CheckboxCheck.alpha = 0;
				} else {
					Checkbox.alpha = 0;
					CheckboxCheck.alpha = 0;
					ShowCutscene.alpha = 0;
				}
				if ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(Checkbox) && ClientPrefs.cutsceneYouSaw.contains(ScoreSongSel) && ClientPrefs.songsHaveCutsceneCheckbox.contains(ScoreSongSel)) {
					if (ClientPrefs.showCutscene.contains(ScoreSongSel))
						ClientPrefs.showCutscene.remove(ScoreSongSel);
					else
						ClientPrefs.showCutscene.push(ScoreSongSel);
					ClientPrefs.saveSettings();
				}
			}
		} else {
			if (TooSlowEncoreSelAAAAA) {
				if ((controls.UI_LEFT_P #if desktop || FlxG.mouse.overlaps(TooSlowEncoreSelOne) #end) && !TooSlowEncoreSelectedOne) TooSlowEncoreSelection('sel-1', true);
				if ((controls.UI_RIGHT_P #if desktop || FlxG.mouse.overlaps(TooSlowEncoreSelTwo) #end) && TooSlowEncoreSelectedOne) TooSlowEncoreSelection('sel-2', true);
			}
		}

		if (!TooSlowEncoreSelAAAAA) {
			if (controls.BACK || #if mobile FlxG.android.justReleased.BACK #else FlxG.mouse.justPressedRight #end) FlxG.switchState(new MainMenuState());
		} else {
			if (controls.BACK || #if mobile FlxG.android.justReleased.BACK #else FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(TooSlowEncoreExit) && (FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed)) #end) TooSlowEncoreSelection('close');
		}
			
		if (!GoreWarningMenu) {
			if (controls.ACCEPT #if desktop || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(hitboxEnter) && !FlxG.mouse.overlaps(arrowLeft) && !FlxG.mouse.overlaps(arrowRight)) #end && !TooSlowEncoreSelAAAAA)
			{
				if (canControl) {
					if (songtext.text != '???') {
						if (songtext.text != 'too slow encore') {
							if (!ClientPrefs.showCutscene.contains(ScoreSongSel)) {
								if (songtext.text == 'fatality encore') 
									Main.DisableCustomCursor = true;
								else
									Main.DisableCustomCursor = false;
								canControl = false;
								
								PlayState.SONG = Song.loadFromJson(songArray[curSelected].toLowerCase() + '', songArray[curSelected].toLowerCase());
								PlayState.isStory = false;
								PlayState.isEncore = true;
								PlayState.isExtras = false;
								PlayState.isSound = false;
								PlayState.isFreeplay = false;
								PlayState.storyDifficulty = 1;
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
								if (!GoreContent) {
									FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
									FlxG.sound.play(Paths.sound('confirmMenu'));
									FlxG.sound.music.fadeOut(0.5, 0);
									new FlxTimer().start(1, function(tmr:FlxTimer)
									{
										if (ScoreSongSel == 'fatality-encore') FlxG.fullscreen = true;
										Main.InPlaystate = true;
										LoadingState.loadAndSwitchState(new PlayState());
									});
								} else {
									openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'encore', 'playstate'));
									GoreWarningMenu = true;
								}
							} else {
								canControl = false;
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
								if (!GoreContent) {
									FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
									FlxG.sound.play(Paths.sound('confirmMenu'));
									FlxG.sound.music.fadeOut(0.5, 0);
									new FlxTimer().start(1, function(tmr:FlxTimer) {
										switch(ScoreSongSel) {
											case 'you-cant-run-encore': MusicBeatState.switchState(new Cutscenes('you-cant-run-encore', 'ycr-encore-intro', 0.3, 'Encore', 'you-cant-run-encore'));
											case 'fatality-encore':
												FlxG.fullscreen = true;
												MusicBeatState.switchState(new Cutscenes('Fatal Encore'));
										}
									});
								} else {
									switch(ScoreSongSel) {
										case 'you-cant-run-encore': openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'encore', 'cutscene', 'you-cant-run-encore', 'ycr-encore-intro', 0.3, 'Encore', 'you-cant-run-encore'));
										case 'fatality-encore': openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'encore', 'cutscene', 'Fatal Encore'));
									}
									GoreWarningMenu = true;
								}
							}
						} else {
							TooSlowEncoreSelection('open');
						}
					} else {
						if (!DeniedSound) {
							new FlxTimer().start(0.5, function(tmr:FlxTimer) { DeniedSound = false; });
							FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
							DeniedSound = true;
						}
					}
				}
			}
			if (controls.ACCEPT #if desktop || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(TooSlowEncoreWindow) && (FlxG.mouse.overlaps(TooSlowEncoreSelOne) || FlxG.mouse.overlaps(TooSlowEncoreSelTwo))) #end && TooSlowEncoreSelAAAAA) {
				if (!canControl && TooSlowEncoreMenuCanControl) {
					Main.DisableCustomCursor = false;
					PlayState.isStory = false;
					PlayState.isEncore = true;
					PlayState.isExtras = false;
					PlayState.isSound = false;
					PlayState.isFreeplay = false;
					PlayState.storyDifficulty = 1;
					switch(TooSlowEncoreSelectedOne) {
						case true:
							TooSlowEncoreMenuCanControl = false;
							PlayState.SONG = Song.loadFromJson('too-slow-encore', 'too-slow-encore');
							FlxTransitionableState.skipNextTransIn = true;
							FlxTransitionableState.skipNextTransOut = true;
							if (!GoreContent) {
								FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
								FlxG.sound.play(Paths.sound('confirmMenu'));
								FlxG.sound.music.fadeOut(0.5, 0);
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									Main.InPlaystate = true;
									LoadingState.loadAndSwitchState(new PlayState());
								});
							} else {
								openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'encore', 'playstate'));
								GoreWarningMenu = true;
							}
						case false:
							if (ClientPrefs.SongsCompleted.contains('too-slow-encore')) {
								TooSlowEncoreMenuCanControl = false;
								PlayState.SONG = Song.loadFromJson('too-slow-encore-alt', 'too-slow-encore-alt');
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
								if (!GoreContent) {
									FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
									FlxG.sound.play(Paths.sound('confirmMenu'));
									FlxG.sound.music.fadeOut(0.5, 0);
									new FlxTimer().start(1, function(tmr:FlxTimer)
									{
										Main.InPlaystate = true;
										LoadingState.loadAndSwitchState(new PlayState());
									});
								} else {
									openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'encore', 'playstate'));
									GoreWarningMenu = true;
								}
							} else {
								if (!DeniedSound) {
									new FlxTimer().start(0.5, function(tmr:FlxTimer) { DeniedSound = false; });
									FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
									DeniedSound = true;
								}
							}
					}
				}
			}
		}
		super.update(elapsed);
	}
	
	function changeSelection(change:Int = 0, ?boom:String = '')
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected += change;
		
		if (curSelected < 0)
			curSelected = songArray.length - 1;
		if (curSelected >= songArray.length)
			curSelected = 0;	
	
		if (boom == 'left') {
			arrowLeft.alpha = 0;
			arrowLeftSel.alpha = 1;
			arrowLeft.x = 103;
			arrowLeftSel.x = 103;
		}
		if (boom == 'right') {
			arrowRight.alpha = 0;
			arrowRightSel.alpha = 1;
			arrowRight.x = 1013;
			arrowRightSel.x = 1013;
		}
	
		switch(curSelected) {
			case 0:
				FlxTween.tween(boxGRP ,{x: 0}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: 0}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: 0}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 1:
				FlxTween.tween(boxGRP ,{x: -780}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -780}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -780}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 2:
				FlxTween.tween(boxGRP ,{x: -1560}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -1560}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -1560}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 3:
				FlxTween.tween(boxGRP ,{x: -2340}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -2340}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -2340}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 4:
				FlxTween.tween(boxGRP ,{x: -3120}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -3120}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -3120}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 5:
				FlxTween.tween(boxGRP ,{x: -3900}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -3900}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -3900}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 6:
				FlxTween.tween(boxGRP ,{x: -4680}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -4680}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -4680}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 7:
				FlxTween.tween(boxGRP ,{x: -5460}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -5460}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -5460}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 8:
				FlxTween.tween(boxGRP ,{x: -6240}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -6240}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -6240}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 9:
				FlxTween.tween(boxGRP ,{x: -7020}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -7020}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -7020}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 10:
				FlxTween.tween(boxGRP ,{x: -7800}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -7800}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -7800}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 11:
				FlxTween.tween(boxGRP ,{x: -8580}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -8580}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -8580}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
			case 12:
				FlxTween.tween(boxGRP ,{x: -9360}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(charGRP ,{x: -9360}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
				FlxTween.tween(daStaticGRP ,{x: -9360}, 0.15, {ease: FlxEase.expoOut, onComplete: function(sus:FlxTween){}});
		}
		if (curSelected == 0) {
			scoretext.visible = false;
			if (TooSlowEncoreSelAAAAA) scoreChoiceText.visible = false;
		} else {
			scoretext.visible = true;
			scoreChoiceText.visible = false;
		}
		if (songArray[curSelected] == 'too slow encore' || songArray[curSelected] == 'you cant run encore' || songArray[curSelected] == 'triple trouble encore') {
			songtext.text = songArray[curSelected];
			#if desktop
			switch(songArray[curSelected]) {
				case 'too slow encore': DiscordClient.imageRpc = 'too_slow_encore';
				case 'you cant run encore': DiscordClient.imageRpc = 'you_cant_run_encore';
				case 'triple trouble encore': DiscordClient.imageRpc = 'triple_trouble_encore';
			}
			DiscordClient.changePresence();
			#end
		} else {
			shitCode(true);
		}
	}
}