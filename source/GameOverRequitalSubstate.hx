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

class GameOverRequitalSubstate extends MusicBeatSubstate
{
	public static var instance:GameOverRequitalSubstate;
	
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var blackScreen:FlxSprite;
	
	var BFPico:FlxSprite;
	var Stars:FlxSprite;
	var numbers:FlxSprite;
	
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
		FlxG.camera.zoom = 1.05;
		
		BFPico = new FlxSprite(0, 0).loadGraphic(Paths.image('gameovers/requital/bf-pico'));
		BFPico.antialiasing = ClientPrefs.globalAntialiasing;
		BFPico.scrollFactor.set();
		BFPico.screenCenter();
		if (ClientPrefs.gore) add(BFPico);
		
		Stars = new FlxSprite(0, 0).loadGraphic(Paths.image('gameovers/requital/continue-stars'));
		Stars.antialiasing = ClientPrefs.globalAntialiasing;
		Stars.scrollFactor.set();
		Stars.screenCenter();
		add(Stars);
		
		numbers = new FlxSprite(0, 0);
		numbers.frames = Paths.getSparrowAtlas('gameovers/requital/numbers');
		numbers.animation.addByIndices('zero', 'num', [10], "", 1, false);
		numbers.animation.addByIndices('one', 'num', [9], "", 1, false);
		numbers.animation.addByIndices('two', 'num', [8], "", 1, false);
		numbers.animation.addByIndices('three', 'num', [7], "", 1, false);
		numbers.animation.addByIndices('four', 'num', [6], "", 1, false);
		numbers.animation.addByIndices('five', 'num', [5], "", 1, false);
		numbers.animation.addByIndices('six', 'num', [4], "", 1, false);
		numbers.animation.addByIndices('seven', 'num', [3], "", 1, false);
		numbers.animation.addByIndices('eight', 'num', [2], "", 1, false);
		numbers.animation.addByIndices('nine', 'num', [1], "", 1, false);
		numbers.animation.addByIndices('ten', 'num', [0], "", 1, false);
		numbers.animation.play('ten', false);
		numbers.screenCenter();
		numbers.antialiasing = false;
		numbers.x -= 7;
		numbers.y += 30;
		add(numbers);

		var daStatic = new FlxSprite(0, 0);
		daStatic.frames = Paths.getSparrowAtlas('daSTAT', 'exe');
		daStatic.animation.addByPrefix('static', 'staticFLASH', 24, true);
		daStatic.animation.play('static', true);
		daStatic.setGraphicSize(FlxG.width, FlxG.height);
		daStatic.screenCenter();
		daStatic.cameras = [coolcamera2];
		daStatic.alpha = 0.1;
		add(daStatic);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.cameras = [coolcamera2];
		add(blackScreen);
		
		FlxG.sound.play(Paths.sound('requital-death'), 0.7);
		
		if (PlayState.instance.GameOverCameraMove) {
			FlxG.camera.scroll.set();
			FlxG.camera.target = null;
		}
		
		Conductor.changeBPM(110);
		
		new FlxTimer().start(2.1, function(tmr:FlxTimer)
		{
			canPressEnter = true;
		});
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
			startCountdown();
		});
		new FlxTimer().start(0.3, function(VL:FlxTimer) {
			FlxG.sound.play(Paths.sound('VoiceLines/RequitalLines/' + FlxG.random.int(1, 6), 'exe'));
		});
		
		#if mobile
		addVirtualPad(NONE, A_B);
		addHitboxCamera();
		#end
	}

	function startCountdown():Void
	{
		FlxG.sound.playMusic(Paths.music('requital-gameover', 'shared'), 1.0);
		FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (!enterPressed) {
				numbers.animation.play('nine', false);
				FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					if (!enterPressed) {
						numbers.animation.play('eight', false);
						FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							if (!enterPressed) {
								numbers.animation.play('seven', false);
								FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									if (!enterPressed) {
										numbers.animation.play('six', false);
										FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
										new FlxTimer().start(1, function(tmr:FlxTimer)
										{
											if (!enterPressed) {
												numbers.animation.play('five', false);
												FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
												new FlxTimer().start(1, function(tmr:FlxTimer)
												{
													if (!enterPressed) {
														numbers.animation.play('four', false);
														FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
														new FlxTimer().start(1, function(tmr:FlxTimer)
														{
															if (!enterPressed) {
																numbers.animation.play('three', false);
																FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
																new FlxTimer().start(1, function(tmr:FlxTimer)
																{
																	if (!enterPressed) {
																		numbers.animation.play('two', false);
																		FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
																		new FlxTimer().start(1, function(tmr:FlxTimer)
																		{
																			if (!enterPressed) {
																				numbers.animation.play('one', false);
																				FlxG.sound.play(Paths.sound('rq-bf-count'), 0.5);
																				new FlxTimer().start(1, function(tmr:FlxTimer)
																				{
																					if (!enterPressed) {
																						numbers.animation.play('zero', false);
																						FlxG.sound.play(Paths.sound('rq-bf-count-end'), 0.5);
																						FlxTween.tween(blackScreen, {alpha: 1}, 0.8);
																						FlxG.sound.music.fadeOut(0.8, 0);
																						new FlxTimer().start(1, function(tmr:FlxTimer)
																						{
																							if (!enterPressed) {
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
																						});
																					}
																				});
																			}
																		});
																	}
																});
															}
														});
													}
												});
											}
										});
									}
								});
							}
						});
					}
				});
			}
		});
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
			if (canPressEnter && canPress) {
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
			FlxG.sound.music.fadeOut(1.5, 0);
			FlxG.sound.play(Paths.music('requital-retry'), 0.8);
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				#if android
				FlxTween.tween(virtualPad, {alpha: 0}, 2); //mariomaestro estuvo aqui
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
