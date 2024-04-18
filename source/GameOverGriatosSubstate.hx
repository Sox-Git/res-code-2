package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxCamera;
import Controls;

class GameOverGriatosSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	var camFollow:FlxPoint;

	public static var instance:GameOverGriatosSubstate;
	
	var volume:Float = 0.8;
	var islol:Bool = true;
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var blackScreen:FlxSprite;
	
	var griatos:FlxSprite;
	var numbers:FlxSprite;
	var breathe:FlxSprite;
	
	var canPressEnter:Bool = false;
	var enterPressed:Bool = false;
	var shit:Bool = true;
	var canPress:Bool = true;

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;
		
		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);
		coolcamera2 = new FlxCamera();
		coolcamera2.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera2);
		FlxG.camera.zoom = 0.5;
		
		boyfriend = new Boyfriend(x, y, 'bf-griatos-death');
		boyfriend.screenCenter();
		
		griatos = new FlxSprite(0, 0);
		griatos.frames = Paths.getSparrowAtlas('gameovers/griatos/griatos');
		griatos.animation.addByPrefix('g', 'griatos', 24, true);
		griatos.animation.play('g', true);
		griatos.scale.x = 1.1;
		griatos.scale.y = 1.1;
		griatos.alpha = 0;
		griatos.screenCenter();
		griatos.x -= 20;
		griatos.y -= 300;
		griatos.antialiasing = true;
		add(griatos);
		
		numbers = new FlxSprite(0, 0);
		numbers.frames = Paths.getSparrowAtlas('gameovers/griatos/numbers');
		numbers.animation.addByPrefix('three', 'num300', 24, false);
		numbers.animation.addByPrefix('two', 'num200', 24, false);
		numbers.animation.addByPrefix('one', 'num100', 24, false);
		numbers.animation.addByPrefix('zero', 'num000', 24, false);
		numbers.animation.play('three', false);
		numbers.alpha = 0;
		numbers.screenCenter();
		numbers.antialiasing = true;
		add(numbers);
		
		breathe = new FlxSprite(0, 0);
		breathe.frames = Paths.getSparrowAtlas('gameovers/griatos/its-hard-to-breathe');
		breathe.animation.addByPrefix('b', 'breathe...', 24, true);
		breathe.animation.play('b', true);
		breathe.scale.x = 1.5;
		breathe.scale.y = 1.5;
		breathe.alpha = 0;
		breathe.screenCenter();
		breathe.y += 400;
		breathe.antialiasing = true;
		add(breathe);
		
		add(boyfriend);

		FlxG.sound.play(Paths.sound('griatos-death'));
		
		if (PlayState.instance.GameOverCameraMove) {
			FlxG.camera.scroll.set();
			FlxG.camera.target = null;
		}
		
		Conductor.changeBPM(110);

		boyfriend.playAnim('firstDeath');

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.cameras = [coolcamera2];
		
		new FlxTimer().start(2.1, function(tmr:FlxTimer)
		{
			canPressEnter = true;
		});
		new FlxTimer().start(0.3, function(VL:FlxTimer) {
			FlxG.sound.play(Paths.sound('VoiceLines/GriatosLines/' + FlxG.random.int(1, 5), 'exe'));
		});
		
		#if mobile
		addVirtualPad(NONE, A_B);
		addHitboxCamera();
		#end
	}

	function GriatosAppears():Void
	{
		FlxTween.tween(griatos, {alpha: 1}, 1);
		new FlxTimer().start(1.5, function(tmr:FlxTimer) { FlxTween.tween(numbers, {alpha: 1}, 1); });
		FlxTween.tween(breathe, {alpha: 1}, 1);
	}
	
	function GriatosDisappears():Void
	{
		FlxTween.tween(griatos, {alpha: 0}, 1);
		FlxTween.tween(griatos.scale, {x:0.2, y:0.2}, 3);
		FlxTween.tween(numbers, {alpha: 0}, 1);
		FlxTween.tween(breathe, {alpha: 0}, 1);
	}

	function startCountdown():Void
	{
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (!enterPressed) numbers.animation.play('two', false);
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				if (!enterPressed) numbers.animation.play('one', false);
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if (!enterPressed) numbers.animation.play('zero', false);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						if (!enterPressed) CountEnded();
					});
				});
			});
		});
	}

	function CountEnded():Void
	{
		canPress = false;
		FlxTween.tween(boyfriend, {alpha: 0}, 1);
		FlxTween.tween(numbers, {alpha: 0}, 1);
		FlxTween.tween(griatos, {y: -1050}, 1);
		FlxTween.tween(breathe, {alpha: 0}, 1);
		FlxG.sound.music.fadeOut(1, 0.4);
		
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			FlxTween.tween(griatos.scale, {x:0.9, y:0.9}, 1);
			FlxTween.tween(griatos, {alpha: 0.8}, 1);
		});
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.tween(griatos.scale, {x:1, y:1}, 0.2);
			FlxTween.tween(griatos, {alpha: 1}, 0.14);
			new FlxTimer().start(0.15, function(tmr:FlxTimer)
			{
				FlxG.sound.music.fadeOut(0.01, 0);
				FlxG.sound.play(Paths.sound('ouch'));
				FlxG.camera.flash(0xFFFF0000, 0.6);
				griatos.alpha = 0;
				new FlxTimer().start(0.6, function(tmr:FlxTimer)
				{
					Sys.exit(0);
				});
			});
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		add(blackScreen);

		new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{
			FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
		});

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);

		if (controls.ACCEPT)
		{	
			if (canPressEnter && canPress)
			{
				endBullshit();
				canPressEnter = false;
				enterPressed = true;
			}
		}

		if (controls.BACK)
		{
			if (canPress) {
				FlxG.sound.music.stop();
				PlayState.deathCounter = 0;
				PlayState.seenCutscene = false;
				if(PlayState.isStory) {
					MusicBeatState.switchState(new StoryMenuState());
					FlxG.sound.playMusic(Paths.music('storymode'));
				} else {
					if(PlayState.isEncore) {
						MusicBeatState.switchState(new EncoreState());
						FlxG.sound.playMusic(Paths.music('encoremode'));
					} else {
						if(PlayState.isExtras) {
							MusicBeatState.switchState(new extras.ExtraSongsState());
						} else {
							if(PlayState.isSound) {
								MusicBeatState.switchState(new SoundTestState());
							} else {
								if(PlayState.isFreeplay) {
									MusicBeatState.switchState(new FreeplayState());
									FlxG.sound.playMusic(Paths.music('freeplaymode'));
								} else {
									MusicBeatState.switchState(new MainMenuState());
								}
							}
						}
					}
				}
				PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
			}
		}

		if (boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if (boyfriend.animation.curAnim.finished)
			{
				coolStartDeath();
				boyfriend.startedDeath = true;
			}
			
			if(boyfriend.animation.curAnim.curFrame == 36)
			{
				GriatosAppears();
			}
		}

		if (boyfriend.animation.curAnim.name == 'deathLoop' && boyfriend.animation.curAnim.curFrame == 1 && shit)
		{
			shit = false;
			startCountdown();
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music('griatos-gameover', 'shared'), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			GriatosDisappears();
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.fadeOut(1.5, 0);
			FlxG.sound.play(Paths.music('griatos-retry'));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				#if android
				FlxTween.tween(virtualPad, {alpha: 0}, 2);
				#end
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					Main.InPlaystate = true;
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
