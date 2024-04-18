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

class GameOverWechidnaSubstate extends MusicBeatSubstate
{
	public static var instance:GameOverWechidnaSubstate;
	
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var blackScreen:FlxSprite;
	
	var Cold:FlxSprite;
	
	var canPressEnter:Bool = false;
	var enterPressed:Bool = false;
	var canPress:Bool = true;

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new()
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;
		PlayState.instance.camGame.alpha = 1;
		
		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);
		coolcamera2 = new FlxCamera();
		coolcamera2.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera2);
		FlxG.camera.zoom = 1.325;
		
		var Wech = new FlxSprite(0, FlxG.height - 567);
		Wech.frames = Paths.getSparrowAtlas('gameovers/wechidna');
		Wech.antialiasing = false;
		Wech.animation.addByPrefix('idle', 'idle', 18, true);
		Wech.animation.play('idle', true);
		Wech.screenCenter(X);
		add(Wech);
		
		var daStatic = new FlxSprite(0, 0);
		daStatic.frames = Paths.getSparrowAtlas('daSTAT', 'exe');
		daStatic.animation.addByPrefix('static', 'staticFLASH', 24, true);
		daStatic.animation.play('static', true);
		daStatic.setGraphicSize(FlxG.width, FlxG.height);
		daStatic.screenCenter();
		daStatic.cameras = [coolcamera2];
		daStatic.alpha = 0.075;
		add(daStatic);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.cameras = [coolcamera2];
		add(blackScreen);
		
		if (PlayState.instance.GameOverCameraMove) {
			FlxG.camera.scroll.set();
			FlxG.camera.target = null;
		}
		
		Conductor.changeBPM(140);
		FlxG.sound.playMusic(Paths.music('wechidna-gameover', 'shared'), 0);
		
		new FlxTimer().start(1.55, function(tmr:FlxTimer)
		{
			canPressEnter = true;
		});
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			FlxG.sound.music.fadeIn(1, 0, 0.7);
			FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
		});
		new FlxTimer().start(0.3, function(VL:FlxTimer) {
			FlxG.sound.play(Paths.sound('VoiceLines/WechidnaLines/' + FlxG.random.int(1, 7), 'exe'));
		});
		
		#if mobile
		addVirtualPad(NONE, A_B);
		addHitboxCamera();
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
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

	function endBullshit():Void
	{
		if (!isEnding)
		{
			new FlxTimer().start(1.0, function(DADA:FlxTimer)
			{
				FlxTween.tween(blackScreen, {alpha: 1}, 0.5);
			});
			isEnding = true;
			FlxG.sound.music.fadeOut(0.25, 0);
			FlxG.sound.play(Paths.music('wechidna-gameover-retry'), 0.7);
			new FlxTimer().start(1, function(tmr:FlxTimer)
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
