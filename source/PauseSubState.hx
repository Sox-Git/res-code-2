package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import Song.SwagSong;
import Section.SwagSection;
import Song.SwagSong;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath;
import openfl.display.BlendMode;

class PauseSubState extends MusicBeatSubstate
{
	var menuItems:Array<String>;
	var curSelected:Int = 0;
	var pauseMusic:FlxSound;
	var bg:FlxSprite;
	var top:FlxSprite;
	var panel:FlxSprite;
	var exit3:FlxSprite;
	var exit2:FlxSprite;
	var exit1:FlxSprite;
	var restart3:FlxSprite;
	var restart2:FlxSprite;
	var restart1:FlxSprite;
	var continue3:FlxSprite;
	var continue2:FlxSprite;
	var continue1:FlxSprite;
	var timeBarBG:AttachedSprite;
	var timeBar:FlxBar;
	public var PauseIconP1:HealthIcon;
	var sPercent:Float = PlayState.instance.songPercent;
	var holdTime:Float = 0;

	public function new(x:Float, y:Float)
	{
		super();
		
		if (ClientPrefs.storyProgressExe == 3 && PlayState.SONG.song.toLowerCase() == 'final-escape')
			menuItems = ['Continue', 'Restart'];
		else
			menuItems = ['Continue', 'Restart', 'Exit'];

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
		FlxG.sound.list.add(pauseMusic);
		FlxG.sound.play(Paths.sound('pause', 'shared'), 0.7);

		bg = new FlxSprite(0, 0);
		bg.frames = Paths.getSparrowAtlas('staticBACKGROUND2-g', 'exe');
		bg.animation.addByPrefix('idle', "menuSTATICNEW instance 1", 24);
		bg.animation.play('idle');
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.scrollFactor.set();
		bg.blend = BlendMode.MULTIPLY;
		bg.alpha = 0;
		add(bg);

		top = new FlxSprite(-800, 0).loadGraphic(Paths.image('pauseStuff/pauseTop'));
		top.antialiasing = ClientPrefs.globalAntialiasing;
		top.scrollFactor.set();
		add(top);
		
		panel = new FlxSprite(800, 0).loadGraphic(Paths.image('pauseStuff/bottomPanel'));
		panel.antialiasing = ClientPrefs.globalAntialiasing;
		panel.scrollFactor.set();
		add(panel);

		exit3 = new FlxSprite(1515, 635).loadGraphic(Paths.image('pauseStuff/graybut'));
		exit3.antialiasing = ClientPrefs.globalAntialiasing;
		exit3.scrollFactor.set();
		
		exit2 = new FlxSprite(1515, 635).loadGraphic(Paths.image('pauseStuff/blackbut'));
		exit2.antialiasing = ClientPrefs.globalAntialiasing;
		exit2.scrollFactor.set();
		
		exit1 = new FlxSprite(1540, 640).loadGraphic(Paths.image('pauseStuff/Exittomenu'));
		exit1.antialiasing = ClientPrefs.globalAntialiasing;
		exit1.scrollFactor.set();
		
		if (menuItems.contains('Exit')) {
			add(exit3);
			add(exit2);
			add(exit1);
		}
		
		restart3 = new FlxSprite(1600, 535).loadGraphic(Paths.image('pauseStuff/graybut'));
		restart3.antialiasing = ClientPrefs.globalAntialiasing;
		restart3.scrollFactor.set();
		add(restart3);
		
		restart2 = new FlxSprite(1600, 535).loadGraphic(Paths.image('pauseStuff/blackbut'));
		restart2.antialiasing = ClientPrefs.globalAntialiasing;
		restart2.scrollFactor.set();
		add(restart2);
		
		restart1 = new FlxSprite(1625, 540).loadGraphic(Paths.image('pauseStuff/RestartSong'));
		restart1.antialiasing = ClientPrefs.globalAntialiasing;
		restart1.scrollFactor.set();
		add(restart1);
		
		continue3 = new FlxSprite(1680, 435).loadGraphic(Paths.image('pauseStuff/graybut'));
		continue3.antialiasing = ClientPrefs.globalAntialiasing;
		continue3.scrollFactor.set();
		add(continue3);
		
		continue2 = new FlxSprite(1680, 435).loadGraphic(Paths.image('pauseStuff/blackbut'));
		continue2.antialiasing = ClientPrefs.globalAntialiasing;
		continue2.scrollFactor.set();
		add(continue2);
		
		continue1 = new FlxSprite(1705, 440).loadGraphic(Paths.image('pauseStuff/Resume'));
		continue1.antialiasing = ClientPrefs.globalAntialiasing;
		continue1.scrollFactor.set();
		add(continue1);

		switch (ClientPrefs.Language) {
			case 'Russian', 'Spanish':
				exit3.x = 684+800;
				exit2.x = 684+800;
				exit1.x = 709+800;
				restart3.x = 769+800;
				restart2.x = 769+800;
				restart1.x = 794+800;
				continue3.x = 849+800;
				continue2.x = 849+800;
				continue1.x = 874+800;
		}

		timeBarBG = new AttachedSprite('timeBar');
		timeBarBG.antialiasing = ClientPrefs.globalAntialiasing;
		timeBarBG.x = 200;
		timeBarBG.y = 200;
		timeBarBG.scrollFactor.set();
		timeBarBG.color = FlxColor.BLACK;
		timeBarBG.xAdd = -4;
		timeBarBG.yAdd = -4;
		timeBarBG.alpha = 0;
		add(timeBarBG);

		timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), this,
			'sPercent', 0, 1);
		timeBar.scrollFactor.set();
		timeBar.antialiasing = ClientPrefs.globalAntialiasing;
		timeBar.createFilledBar(0xFF000000, 0xFFfc0303);
		timeBar.numDivisions = 800;
		timeBar.alpha = 0;
		add(timeBar);
		timeBarBG.sprTracker = timeBar;
		
		if (PlayState.SONG.song.toLowerCase() == 'final-escape' || PlayState.SONG.song.toLowerCase() == 'judgement')
			PauseIconP1 = new HealthIcon('bf', false);
		else
			PauseIconP1 = new HealthIcon(PlayState.instance.boyfriend.healthIcon, false);
		PauseIconP1.antialiasing = ClientPrefs.globalAntialiasing;
		PauseIconP1.y = timeBarBG.y + -70;
		PauseIconP1.x = timeBarBG.x + -120;
		PauseIconP1.alpha = 0;
		add(PauseIconP1);

		changeSelection(0);
		
		if (PlayState.isFixedAspectRatio) {
			bg.x -= 200;
			TweenInSmallWindow();
		} else {
			TweenIn();
		}

		FlxG.mouse.visible = false;

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
		
		#if mobile
		addVirtualPad(UP_DOWN, A);
		addVirtualPadCamera();
		#end
	}

	function ButtonsTween(elapsed:Float):Void
	{
		switch(curSelected) {
			case 0:
				continue1.y = FlxMath.lerp(continue1.y, 430, CoolUtil.boundTo(elapsed * 24, 0, 1));
				continue2.y = FlxMath.lerp(continue2.y, 425, CoolUtil.boundTo(elapsed * 24, 0, 1));
				continue3.y = FlxMath.lerp(continue3.y, 440, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				restart1.y = FlxMath.lerp(restart1.y, 540, CoolUtil.boundTo(elapsed * 24, 0, 1));
				restart2.y = FlxMath.lerp(restart2.y, 535, CoolUtil.boundTo(elapsed * 24, 0, 1));
				restart3.y = FlxMath.lerp(restart3.y, 535, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				exit1.y = FlxMath.lerp(exit1.y, 640, CoolUtil.boundTo(elapsed * 24, 0, 1));
				exit2.y = FlxMath.lerp(exit2.y, 635, CoolUtil.boundTo(elapsed * 24, 0, 1));
				exit3.y = FlxMath.lerp(exit3.y, 635, CoolUtil.boundTo(elapsed * 24, 0, 1));
			case 1:
				continue1.y = FlxMath.lerp(continue1.y, 440, CoolUtil.boundTo(elapsed * 24, 0, 1));
				continue2.y = FlxMath.lerp(continue2.y, 435, CoolUtil.boundTo(elapsed * 24, 0, 1));
				continue3.y = FlxMath.lerp(continue3.y, 435, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				restart1.y = FlxMath.lerp(restart1.y, 530, CoolUtil.boundTo(elapsed * 24, 0, 1));
				restart2.y = FlxMath.lerp(restart2.y, 525, CoolUtil.boundTo(elapsed * 24, 0, 1));
				restart3.y = FlxMath.lerp(restart3.y, 540, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				exit1.y = FlxMath.lerp(exit1.y, 640, CoolUtil.boundTo(elapsed * 24, 0, 1));
				exit2.y = FlxMath.lerp(exit2.y, 635, CoolUtil.boundTo(elapsed * 24, 0, 1));
				exit3.y = FlxMath.lerp(exit3.y, 635, CoolUtil.boundTo(elapsed * 24, 0, 1));
			case 2:
				continue1.y = FlxMath.lerp(continue1.y, 440, CoolUtil.boundTo(elapsed * 24, 0, 1));
				continue2.y = FlxMath.lerp(continue2.y, 435, CoolUtil.boundTo(elapsed * 24, 0, 1));
				continue3.y = FlxMath.lerp(continue3.y, 435, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				restart1.y = FlxMath.lerp(restart1.y, 540, CoolUtil.boundTo(elapsed * 24, 0, 1));
				restart2.y = FlxMath.lerp(restart2.y, 535, CoolUtil.boundTo(elapsed * 24, 0, 1));
				restart3.y = FlxMath.lerp(restart3.y, 535, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				exit1.y = FlxMath.lerp(exit1.y, 630, CoolUtil.boundTo(elapsed * 24, 0, 1));
				exit2.y = FlxMath.lerp(exit2.y, 625, CoolUtil.boundTo(elapsed * 24, 0, 1));
				exit3.y = FlxMath.lerp(exit3.y, 640, CoolUtil.boundTo(elapsed * 24, 0, 1));
		}
	}

	function TweenIn():Void
	{
		FlxTween.tween(top, {x: 0}, 0.25, { ease: FlxEase.expoInOut });
		FlxTween.tween(panel, {x: 0}, 0.25, { ease: FlxEase.expoInOut });
		switch (ClientPrefs.Language) {
			case 'Russian', 'Spanish':
				FlxTween.tween(exit3, {x: 684}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit2, {x: 684}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit1, {x: 709}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart3, {x: 769}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart2, {x: 769}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart1, {x: 794}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue3, {x: 849}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue2, {x: 849}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue1, {x: 874}, 0.25, { ease: FlxEase.expoInOut });
			default:
				FlxTween.tween(exit3, {x: 715}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit2, {x: 715}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit1, {x: 740}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart3, {x: 800}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart2, {x: 800}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart1, {x: 825}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue3, {x: 880}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue2, {x: 880}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue1, {x: 905}, 0.25, { ease: FlxEase.expoInOut });
		}
		FlxTween.tween(timeBarBG, {alpha: 1}, 0.30, { ease: FlxEase.expoInOut });
		FlxTween.tween(timeBar, {alpha: 1}, 0.30, { ease: FlxEase.expoInOut });	
		FlxTween.tween(PauseIconP1, {alpha: 1}, 0.30, { ease: FlxEase.expoInOut });
		FlxTween.tween(bg, {alpha: 0.7}, 0.30, { ease: FlxEase.expoInOut });
	}

	function TweenInSmallWindow():Void
	{
		FlxTween.tween(top, {x: 0}, 0.25, { ease: FlxEase.expoInOut });
		FlxTween.tween(panel, {x: -260}, 0.25, { ease: FlxEase.expoInOut });
		switch (ClientPrefs.Language) {
			case 'Russian', 'Spanish':
				FlxTween.tween(exit3, {x: 414}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit2, {x: 414}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit1, {x: 439}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart3, {x: 499}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart2, {x: 499}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart1, {x: 524}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue3, {x: 579}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue2, {x: 579}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue1, {x: 604}, 0.25, { ease: FlxEase.expoInOut });
			default:
				FlxTween.tween(exit3, {x: 445}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit2, {x: 445}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(exit1, {x: 470}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart3, {x: 530}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart2, {x: 530}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(restart1, {x: 555}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue3, {x: 610}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue2, {x: 610}, 0.25, { ease: FlxEase.expoInOut });
				FlxTween.tween(continue1, {x: 635}, 0.25, { ease: FlxEase.expoInOut });
		}
		FlxTween.tween(timeBarBG, {alpha: 1}, 0.30, { ease: FlxEase.expoInOut });
		FlxTween.tween(timeBar, {alpha: 1}, 0.30, { ease: FlxEase.expoInOut });
		FlxTween.tween(PauseIconP1, {alpha: 1}, 0.30, { ease: FlxEase.expoInOut });
		FlxTween.tween(bg, {alpha: 0.7}, 0.30, { ease: FlxEase.expoInOut });
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		ButtonsTween(elapsed);
		
		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
		if (controls.UI_UP_P)
		{
			changeSelection(-shiftMult);
			holdTime = 0;
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(shiftMult);
			holdTime = 0;
		}
		if (controls.UI_DOWN_P || controls.UI_UP_P)
		{
			var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
			holdTime += elapsed;
			var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
			if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
			{
				changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
			}
		}
		#if desktop
		if (FlxG.mouse.wheel != 0)
		{
			changeSelection(-shiftMult * FlxG.mouse.wheel);
			holdTime = 0;
		}
		#end
		if (controls.BACK || #if desktop FlxG.mouse.justPressedRight #else FlxG.android.justReleased.BACK #end) {
			#if windows
			lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe";
			#end
			close();
			FlxG.sound.play(Paths.sound('unpause', 'shared'), 0.4);
			FlxG.mouse.visible = false;
		}
		var daSelected:String = menuItems[curSelected];
		if (controls.ACCEPT #if desktop || FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed #end)
		{
			switch (daSelected)
			{
				case "Continue":
					#if windows
					lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe";
					#end
					close();
					FlxG.sound.play(Paths.sound('unpause', 'shared'), 0.4);
					FlxG.mouse.visible = false;
				case "Restart":
					Main.DisableCustomCursor = false;
					restartSong();
					FlxG.mouse.visible = false;
				case "Exit":
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					if(PlayState.isStory) {
						MusicBeatState.switchState(new StoryMenuState());
					} else {
						if(PlayState.isEncore) {
							MusicBeatState.switchState(new EncoreState());
						} else {
							if(PlayState.isExtras) {
								MusicBeatState.switchState(new extras.ExtraSongsState());
							} else {
								if(PlayState.isSound) {
									MusicBeatState.switchState(new SoundTestState());
								} else {
									if(PlayState.isFreeplay) {
										MusicBeatState.switchState(new FreeplayState());
									} else {
										MusicBeatState.switchState(new MainMenuState());
									}
								}
							}
						}
					}
					if (ClientPrefs.VisibleMouse)
						FlxG.mouse.visible = true;
					else
						FlxG.mouse.visible = false;
					Main.InPlaystate = false;
					Main.DisableCustomCursor = false;
					PlayState.chartingMode = false;
			}
		}
	}

	public static function restartSong(noTrans:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			Main.InPlaystate = true;
			MusicBeatState.resetState();
		}
	}

	override function destroy()
	{
		pauseMusic.stop();
		ClientPrefs.saveSettings();
		pauseMusic.destroy();
		super.destroy();
	}

	function changeSelection(change:Int = 0, ?mouse:Bool = false):Void
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (!mouse) {
			curSelected += change;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
			if (curSelected >= menuItems.length)
				curSelected = 0;
		} else {
			curSelected = change;
		}
	}
}
