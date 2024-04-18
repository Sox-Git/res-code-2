package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;

using StringTools;

class MainMenuStateOld extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2 (v4.5/5.0)'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'encore',
		'freeplay',
		'sound_test',
		'credits',
		'options',
		'extras'
	];

	var debugKeys:Array<FlxKey>;
	var BG:FlxSprite;
	
	public var SoundTestUnlocked:Bool = false;
	public var EncoreUnlocked:Bool = false;
	
	public var SoundTestBlock:String = 'sound_test';
	public var EncoreBlock:String = 'encore';
	public var lockedControl:Bool = true;
	public var selectedSomethin:Bool = false;
	public static var instance:MainMenuState;
	
	var TooSlowTrophy:FlxSprite;
	var YouCantRunTrophy:FlxSprite;
	var TripleTroubleTrophy:FlxSprite;
	var FinalEscapeTrophy:FlxSprite;
	var FaceOffTrophy:FlxSprite;
	public var blackScreen:FlxSprite;

	override function create()
	{	
		instance = this;
		
		FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.7);
		WeekData.loadTheFirstEnabledMod();
		
		PlayState.isStoryMode = false;
		PlayState.isStory = false;
		PlayState.isEncore = false;
		PlayState.isExtras = false;
		PlayState.isSound = false;
		PlayState.isFreeplay = false;
		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;
		
		PlayState.BFEncoreSkins = false;
		PlayState.BFSkins = false;
		PlayState.GFEncoreSkins = false;
		PlayState.GFSkins = false;
		
		PlayState.ChaosCutscene = false;
		PlayState.showSTCutscene = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Main Menu", null);
		#end
		
		PlayState.storyPlaylist = [];
		
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		FlxTransitionableState.skipNextTransIn = false;
		openSubState(new SonicTransition(1.0, true));
		
		persistentUpdate = persistentDraw = true;

		BG = new FlxSprite(0, 0);
		BG.frames = Paths.getSparrowAtlas('Main_Menu_Spritesheet_Animation');
		BG.antialiasing = ClientPrefs.globalAntialiasing;
		BG.animation.addByPrefix('bgAnim', 'BG instance 1', 24);
		BG.setGraphicSize(Std.int(BG.width * 1.00));
		BG.animation.play('bgAnim');
		BG.updateHitbox();
		BG.screenCenter();
		add(BG);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{			
			var menuItem:FlxSprite = new FlxSprite(0, 0);
			menuItem.ID = i;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/' + optionShit[i]);
			menuItem.animation.addByIndices('idle', optionShit[i], [0], "", 24);
			menuItem.animation.addByIndices('sel', optionShit[i], [1], "", 24);
			if (optionShit[i] == 'encore' || optionShit[i] == 'sound_test') {
				menuItem.animation.addByIndices('locked', optionShit[i], [3], "", 24);
				menuItem.animation.addByIndices('lock-sel', optionShit[i], [4], "", 24);
			}
			menuItem.animation.play('idle');
			menuItem.antialiasing = true;
			menuItem.updateHitbox();
			menuItem.scrollFactor.set();
			switch(i) {
				case 0:
					menuItem.setPosition(480, 50);
					FlxTween.tween(menuItem, {x: 515},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.30,
					});
				case 1:
					menuItem.setPosition(480, 133.25);
					FlxTween.tween(menuItem, {x: 585},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.40,
					});
				case 2:
					menuItem.setPosition(480, 216.5);
					FlxTween.tween(menuItem, {x: 650},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.50,
					});
				case 3:
					menuItem.setPosition(480, 299.75);
					FlxTween.tween(menuItem, {x: 725},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.60,
					});
				case 4:
					menuItem.setPosition(480, 383);
					FlxTween.tween(menuItem, {x: 800},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.70,
					});
				case 5:
					menuItem.setPosition(480, 466.25);
					FlxTween.tween(menuItem, {x: 865},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.80,
					});
				case 6:
					menuItem.setPosition(480, 549.5);
					FlxTween.tween(menuItem, {x: 935},1, {
						ease: FlxEase.expoInOut,
						startDelay: 0.90,
					});
			}
			menuItems.add(menuItem);
		}

		changeItem();

		var dataerase:FlxText = new FlxText(FlxG.width - 300, FlxG.height - 36, 300, "Hold DEL to erase ALL data (this doesn't include ALL options)", 3);
		dataerase.scrollFactor.set();
		dataerase.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(dataerase);
		
		var source:FlxText = new FlxText(FlxG.width - 355, 1, 350, "Recreated source code by: Merphi, ItsFellow, Lifeless, Siivkoi, Shyllis, NicolasMyt and Sirox.", 3);
		source.scrollFactor.set();
		source.setFormat(Paths.font("vcr.ttf"), 15, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(source);
		
		var restored:FlxText = new FlxText(FlxG.width - 355, 56, 350, "Restored Sonic.exe 2.5/3.0 by: Merphi & Futagami Team", 3);
		restored.scrollFactor.set();
		restored.setFormat(Paths.font("vcr.ttf"), 15, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(restored);
		
		var restored:FlxText = new FlxText(FlxG.width - 362, 96, 350, "Version: 4.5/5.0", 3);
		restored.scrollFactor.set();
		restored.setFormat(Paths.font("vcr.ttf"), 15, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(restored);
		
		TooSlowTrophy = new FlxSprite(-400, 80).loadGraphic(Paths.image('trophies/too-slow'));
		TooSlowTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowTrophy.scrollFactor.set();
		TooSlowTrophy.setGraphicSize(Std.int(TooSlowTrophy.width * 0.4));
		
		YouCantRunTrophy = new FlxSprite(-400, 80).loadGraphic(Paths.image('trophies/you-cant-run'));
		YouCantRunTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		YouCantRunTrophy.scrollFactor.set();
		YouCantRunTrophy.setGraphicSize(Std.int(YouCantRunTrophy.width * 0.4));
		
		TripleTroubleTrophy = new FlxSprite(-325, 60).loadGraphic(Paths.image('trophies/triple-trouble'));
		TripleTroubleTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		TripleTroubleTrophy.scrollFactor.set();
		TripleTroubleTrophy.setGraphicSize(Std.int(TripleTroubleTrophy.width * 0.4));
		
		FinalEscapeTrophy = new FlxSprite(-375, 80).loadGraphic(Paths.image('trophies/final-escape'));
		FinalEscapeTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		FinalEscapeTrophy.scrollFactor.set();
		FinalEscapeTrophy.setGraphicSize(Std.int(FinalEscapeTrophy.width * 0.4));
		
		FaceOffTrophy = new FlxSprite(-400, 80).loadGraphic(Paths.image('trophies/face-off'));
		FaceOffTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		FaceOffTrophy.scrollFactor.set();
		FaceOffTrophy.setGraphicSize(Std.int(FaceOffTrophy.width * 0.4));
		
		switch (ClientPrefs.TrophieSelected) {
			case 0:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 1:
				TooSlowTrophy.alpha = 1;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 2:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 1;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 3:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 1;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 4:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 1;
				FaceOffTrophy.alpha = 0;
			case 5:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 1;
		}
		
		add(TooSlowTrophy);
		add(YouCantRunTrophy);
		add(TripleTroubleTrophy);
		add(FinalEscapeTrophy);
		add(FaceOffTrophy);
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.alpha = 0;
		add(blackScreen);
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		changeItem();
		
		if (ClientPrefs.SongsCompletedRN.length <= 0) {
			if (ClientPrefs.SkinsUnlockedRN.length <= 0) {
				if (ClientPrefs.TrophiesUnlockedRN.length > 0 && !lockedControl && !selectedSomethin) {
					openSubState(new unlocked.SkinUnlockedSubstate());
					lockedControl = true;
					selectedSomethin = true;
				}
			} else {
				if (ClientPrefs.SkinsUnlockedRN.length > 0 && !lockedControl && !selectedSomethin) {
					openSubState(new unlocked.SkinUnlockedSubstate());
					lockedControl = true;
					selectedSomethin = true;
				}
			}
		} else {
			if (ClientPrefs.SongsCompletedRN.length > 0 && !lockedControl && !selectedSomethin) {
				openSubState(new unlocked.EncoreUnlockedSubstate());
				lockedControl = true;
				selectedSomethin = true;
			}
		}

		switch (ClientPrefs.TrophieSelected) {
			case 0:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 1:
				TooSlowTrophy.alpha = 1;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 2:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 1;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 3:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 1;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 4:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 1;
				FaceOffTrophy.alpha = 0;
			case 5:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 1;
		}
		
		if (ClientPrefs.SoundTestUnlocked) {
			SoundTestUnlocked = true;
			SoundTestBlock = 'Unlocked';
		} else {
			SoundTestUnlocked = false;
			SoundTestBlock = 'sound_test';
		}
		
		if (ClientPrefs.EncoreUnlocked) {
			EncoreUnlocked = true;
			EncoreBlock = 'Unlocked';
		} else {
			EncoreUnlocked = false;
			EncoreBlock = 'encore';
		}
	
		if (FlxG.keys.justPressed.DELETE)
		{
			var counter = 0;
			new FlxTimer().start(0.1, function(hello:FlxTimer)
			{
				counter += 1;
				if (counter == 30)
				{
					openSubState(new EraseProgressSubstate());
					lockedControl = true;
					selectedSomethin = true;
				}
				if (FlxG.keys.pressed.DELETE)
				{
					hello.reset();
				}
			});
		}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		
		if (FlxG.keys.justPressed.F1 && !lockedControl && !selectedSomethin) {
			new FlxTimer().start(0.05, function(tmr:FlxTimer) {
				openSubState(new DebugSubstate());
				lockedControl = true;
				selectedSomethin = true;
			});
		}
		
		if (FlxG.keys.justPressed.TAB && !lockedControl && !selectedSomethin) {
			new FlxTimer().start(0.05, function(tmr:FlxTimer) {
				openSubState(new TrophiesSubstate());
				lockedControl = true;
				selectedSomethin = true;
			});
		}
		
		new FlxTimer().start(1.05, function(tmr:FlxTimer) {
			lockedControl = false;
			changeItem();
		});
		
		if (!selectedSomethin && !lockedControl)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == SoundTestBlock || optionShit[curSelected] == EncoreBlock) {
					FlxG.sound.play(Paths.sound('deniedMOMENT'));
				} else {
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

									switch (daChoice)
									{
										case 'story_mode':
											MusicBeatState.switchState(new StoryMenuState());
										case 'encore':
											MusicBeatState.switchState(new EncoreState());
										case 'freeplay':
											MusicBeatState.switchState(new FreeplayState());
										case 'sound_test':
											MusicBeatState.switchState(new SoundTestState());
										case 'credits':
											MusicBeatState.switchState(new CreditsState());
										case 'options':
											LoadingState.loadAndSwitchState(new options.OptionsState());
										case 'extras':
											if (ClientPrefs.ShowExtrasCode) {
												MusicBeatState.switchState(new extras.ExtrasState());
											} else {
												if (ClientPrefs.ExtrasMathSolved) {
													MusicBeatState.switchState(new extras.ExtrasState());
												} else {
													MusicBeatState.switchState(new extras.CodeState());
												}
											}
									}
							});
						}
					});
					}
				}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{	
			if (!ClientPrefs.EncoreUnlocked) {
				if (spr.ID == 1) spr.animation.play('locked');
			} else {
				if (spr.ID == 1) spr.animation.play('idle');
			}
			
			if (!ClientPrefs.SoundTestUnlocked) {
				if (spr.ID == 3) spr.animation.play('locked');
			} else {
				if (spr.ID == 3) spr.animation.play('idle');
			}

			if (spr.ID != 1 && spr.ID != 3) spr.animation.play('idle');

			spr.updateHitbox();
			
			if (spr.ID == curSelected) {
				if (!ClientPrefs.EncoreUnlocked) {
					if (spr.ID == 1) spr.animation.play('locked');
				} else {
					if (spr.ID == 1) spr.animation.play('sel');
				}
				
				if (!ClientPrefs.SoundTestUnlocked) {
					if (spr.ID == 3) spr.animation.play('locked');
				} else {
					if (spr.ID == 3) spr.animation.play('sel');
				}
				
				if (!lockedControl) {
					if (spr.ID != 1 && spr.ID != 3) spr.animation.play('sel');
				}
			}
			
			spr.updateHitbox();
			
		});
	}
}