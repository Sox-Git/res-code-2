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

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public static var instance:GameOverSubstate;
	
	var volume:Float = 0.8;
	var countdown:FlxText;
	var islol:Bool = true;
	var toolateurfucked:Bool = false;
	var bluevg:FlxSprite;
	var topMajins:FlxSprite;
	var bottomMajins:FlxSprite;
	var actuallynotfuckd:Bool = false;
	var timer:Int = 10;
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var holdup:Bool = true;
	var sonicDEATH:SonicDeathAnimation;
	var blackScreen:FlxSprite;
	var bfdeathshit:FlxSprite;
	var tddeath:FlxSprite;
	
	var canPressEnter:Bool = false;
	var yes:Bool = false;
	var fofShit:Bool = false;
	
	public static function resetVariables() {
		characterName = 'bf';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();
		
		FlxG.mouse.visible = false;
		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		bluevg = new FlxSprite();
		if (PlayState.SONG.song == 'endless-us') {
			bluevg.loadGraphic(Paths.image('blueVgG', 'exe'));
		} else {
			if (PlayState.SONG.song == 'endless-jp') {
				bluevg.loadGraphic(Paths.image('blueVgV', 'exe'));
			} else {
				if (PlayState.SONG.song == 'black-sun' || PlayState.SONG.song == 'godspeed' || PlayState.SONG.song == 'faker-encore') {
					bluevg.loadGraphic(Paths.image('RedVG', 'exe'));
				} else {
					bluevg.loadGraphic(Paths.image('blueVg', 'exe'));
				}
			}
		}
		bluevg.alpha = 0;
		add(bluevg);
		
		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);
		coolcamera2 = new FlxCamera();
		coolcamera2.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera2);

		bluevg.cameras = [coolcamera2];
		
		if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
			boyfriend = new Boyfriend(x, y, characterName);
			boyfriend.x += boyfriend.positionArray[0];
			boyfriend.y += boyfriend.positionArray[1];
		} else {
			new FlxTimer().start(0.49, function(tmr:FlxTimer) {
				boyfriend = new Boyfriend(x, y, characterName);
				boyfriend.x += boyfriend.positionArray[0];
				boyfriend.y += boyfriend.positionArray[1];
			});
		}
		
		if (PlayState.SONG.song == 'milk' || PlayState.SONG.song == 'cool-party') {
			bfdeathshit = new FlxSprite(boyfriend.x, boyfriend.y);
			bfdeathshit.frames = Paths.getSparrowAtlas('Bf_dancin');
			bfdeathshit.animation.addByPrefix('dance', 'Dance', 24, true);
			bfdeathshit.animation.play('dance', true);
			bfdeathshit.alpha = 0;
			bfdeathshit.antialiasing = true;
		}
		
		if (PlayState.SONG.song == 'black-sun' || PlayState.SONG.song == 'godspeed' || PlayState.SONG.song == 'faker-encore') {
			boyfriend.alpha = 0;
			bfdeathshit = new FlxSprite(boyfriend.x, boyfriend.y);
			bfdeathshit.frames = Paths.getSparrowAtlas('exedeath', 'exe');
			bfdeathshit.setGraphicSize(Std.int(bfdeathshit.width * 1.9));
			bfdeathshit.animation.addByPrefix('die', 'DieLmao', 24, false);
			bfdeathshit.cameras = [coolcamera];
			bfdeathshit.screenCenter();
			bfdeathshit.animation.play('die');
			bfdeathshit.animation.paused = true;
			bfdeathshit.animation.curAnim.curFrame = 0;
			bfdeathshit.antialiasing = true;
			add(bfdeathshit);
		}
		
		if (PlayState.SONG.song.toLowerCase() == 'soulless' || PlayState.SONG.song.toLowerCase() == 'sunshine-encore') {
			boyfriend.alpha = 0;
			tddeath = new FlxSprite(0, 0).loadGraphic(Paths.image('gameovers/tails-doll'));
			tddeath.cameras = [coolcamera];
			tddeath.antialiasing = true;
			tddeath.screenCenter();
			if (ClientPrefs.gore) add(tddeath);
			deathSoundName = 'td-death';
			endSoundName = 'td-retry';
		}
		
		if (PlayState.SONG.song == 'endless' || PlayState.SONG.song == 'endless-og' || PlayState.SONG.song == 'endless-jp' || PlayState.SONG.song == 'endless-us' || PlayState.SONG.song == 'endeavors' || PlayState.SONG.song == 'endeavors-og') {
			add(boyfriend);
		}
		
		if (PlayState.SONG.song == 'too-slow' || PlayState.SONG.song == 'you-cant-run' || PlayState.SONG.song == 'triple-trouble' || PlayState.SONG.song == 'final-escape' || PlayState.SONG.song == 'too-slow-encore' || PlayState.SONG.song == 'too-slow-encore-alt' || PlayState.SONG.song == 'you-cant-run-encore' || PlayState.SONG.song == 'triple-trouble-encore' || PlayState.SONG.song == 'hill-of-the-void') {
			sonicDEATH = new SonicDeathAnimation(boyfriend.x - 125, boyfriend.y - 350);
			sonicDEATH.scale.x = 2;
			sonicDEATH.scale.y = 2;
			sonicDEATH.antialiasing = true;
			sonicDEATH.playAnim('firstDeath');
			add(sonicDEATH);
			FlxG.sound.play(Paths.sound('woooshFIRSTDEATH', 'shared'));
			loopSoundName = 'xeno-gameover';
			endSoundName = 'xeno-retry';
		}
		
		if (PlayState.SONG.song.toLowerCase() == 'execution' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'hellbent' || PlayState.SONG.song.toLowerCase() == 'fate' || PlayState.SONG.song.toLowerCase() == 'judgement' ||  PlayState.SONG.song.toLowerCase() == 'cycles-encore' ||  PlayState.SONG.song.toLowerCase() == 'gotta-go-red-glove' ||  PlayState.SONG.song.toLowerCase() == 'execution-inski') {
			boyfriend.cameras = [coolcamera];
			boyfriend.screenCenter();
			volume = 0.7;
		}
		if (PlayState.SONG.song == 'chaos' || PlayState.SONG.song == 'running-wild') {
			volume = 0.5;
		}
		
		if (PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song == 'endless-og' || PlayState.SONG.song == 'endless-jp' || PlayState.SONG.song == 'endless-us' || PlayState.SONG.song == 'endeavors' || PlayState.SONG.song == 'endeavors-og')
		{
			countdown = new FlxText(614, 118 - 30, 100, '10', 40);
			countdown.setFormat(Paths.font('sonic-cd-menu-font.ttf'), 40, FlxColor.WHITE);
			countdown.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			countdown.cameras = [coolcamera];
			add(countdown);
			countdown.alpha = 0;
			countdown.visible = true;
			boyfriend.visible = false;
		}
		
		if (PlayState.SONG.song == 'endless' || PlayState.SONG.song == 'endless-og' || PlayState.SONG.song == 'endless-jp' || PlayState.SONG.song == 'endless-us' || PlayState.SONG.song == 'endeavors' || PlayState.SONG.song == 'endeavors-og')
		{
			if (PlayState.SONG.song == 'endless-us') {
				bottomMajins = new FlxSprite(boyfriend.x - 450, boyfriend.y - 300).loadGraphic(Paths.image('bottomMajinsG'));
			} else {
				if (PlayState.SONG.song == 'endless-jp') {
					bottomMajins = new FlxSprite(boyfriend.x - 450, boyfriend.y - 300).loadGraphic(Paths.image('bottomMajinsV'));
				} else {
					bottomMajins = new FlxSprite(boyfriend.x - 450, boyfriend.y - 300).loadGraphic(Paths.image('bottomMajins'));
				}
			}
			bottomMajins.scale.x = 1.1;
			bottomMajins.scale.y = 1.1;

			bottomMajins.alpha = 0;
			add(bottomMajins);
		}
		if (PlayState.SONG.song != 'endless' && PlayState.SONG.song != 'endless-og' && PlayState.SONG.song != 'endless-jp' && PlayState.SONG.song != 'endless-us' && PlayState.SONG.song != 'endeavors' && PlayState.SONG.song != 'endeavors-og' && PlayState.SONG.song != 'black-sun' && PlayState.SONG.song != 'godspeed' && PlayState.SONG.song != 'faker-encore' && PlayState.SONG.song.toLowerCase() != 'soulless' && PlayState.SONG.song.toLowerCase() != 'sunshine-encore') {
			if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
				add(boyfriend);
			} else {
				new FlxTimer().start(0.5, function(tmr:FlxTimer) {
					add(boyfriend);
				});
			}
		}

		if (PlayState.SONG.song.toLowerCase() == 'milk' || PlayState.SONG.song.toLowerCase() == 'cool-party')
		{
			boyfriend.alpha = 0;
			add(bfdeathshit);
		}
		
		if (PlayState.SONG.song == 'endless' || PlayState.SONG.song == 'endless-og' || PlayState.SONG.song == 'endless-jp' || PlayState.SONG.song == 'endless-us' || PlayState.SONG.song == 'endeavors' || PlayState.SONG.song == 'endeavors-og')
		{
			if (PlayState.SONG.song == 'endless-us') {
				topMajins = new FlxSprite(boyfriend.x - 450, boyfriend.y - 300).loadGraphic(Paths.image('topMajinsG'));
			} else {
				if (PlayState.SONG.song == 'endless-jp') {
					topMajins = new FlxSprite(boyfriend.x - 450, boyfriend.y - 300).loadGraphic(Paths.image('topMajinsV'));
				} else {
					topMajins = new FlxSprite(boyfriend.x - 450, boyfriend.y - 300).loadGraphic(Paths.image('topMajins'));
				}
			}
			topMajins.scale.x = 1.1;
			topMajins.scale.y = 1.1;
			topMajins.alpha = 0;
			add(topMajins);
		}
		
		if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
			camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
		} else {
			new FlxTimer().start(0.5, function(tmr:FlxTimer) {
				camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
			});
		}
		
		if (PlayState.SONG.song != 'black-sun' && PlayState.SONG.song != 'godspeed' && PlayState.SONG.song != 'faker-encore' && PlayState.SONG.song.toLowerCase() != 'soulless' && PlayState.SONG.song.toLowerCase() != 'sunshine-encore' && PlayState.SONG.song.toLowerCase() != 'execution' && PlayState.SONG.song.toLowerCase() != 'cycles' && PlayState.SONG.song.toLowerCase() != 'hellbent' && PlayState.SONG.song.toLowerCase() != 'fate' && PlayState.SONG.song.toLowerCase() != 'judgement' && PlayState.SONG.song.toLowerCase() != 'cycles-encore' && PlayState.SONG.song.toLowerCase() != 'gotta-go-red-glove') {
			if (PlayState.SONG.song.toLowerCase() != 'expulsion' || PlayState.SONG.song.toLowerCase() != 'playful') {
				if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
					FlxG.sound.play(Paths.sound(deathSoundName));
				} else {
					new FlxTimer().start(0.7, function(tmr:FlxTimer) {
						FlxG.sound.play(Paths.sound(deathSoundName));
					});
				}
			}
		}
		
		Conductor.changeBPM(100);
		if (PlayState.instance.GameOverCameraMove) {
			FlxG.camera.scroll.set();
			FlxG.camera.target = null;
		}
		
		if (PlayState.SONG.song.toLowerCase() == 'expulsion' || PlayState.SONG.song.toLowerCase() == 'playful') {
			boyfriend.playAnim('Death');
		} else {
			if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
				boyfriend.playAnim('firstDeath');
			} else {
				new FlxTimer().start(0.7, function(tmr:FlxTimer) {
					boyfriend.playAnim('firstDeath');
					fofShit = true;
				});
			}
		}
		
		var exclude:Array<Int> = [];

		camFollowPos = new FlxObject(0, 0, 1, 1);
		if (PlayState.instance.GameOverCameraMove) {
			camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
		} else {
			camFollowPos.setPosition(FlxG.camera.width / 2, FlxG.camera.height / 2);
		}
		add(camFollowPos);
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.cameras = [coolcamera2];
		blackScreen.visible = false;
		
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			if (PlayState.SONG.song.toLowerCase() == 'milk' || PlayState.SONG.song.toLowerCase() == 'cool-party') {
				FlxG.sound.music.volume = 0;
				FlxTween.tween(bfdeathshit, {alpha: 1}, 1);
				FlxG.sound.playMusic(Paths.music('sunky-gameover', 'shared'));
				FlxG.sound.music.fadeIn(1, 0, 1);
			}
				
			if (PlayState.SONG.song.toLowerCase() == 'black-sun' || PlayState.SONG.song.toLowerCase() == 'godspeed' || PlayState.SONG.song.toLowerCase() == 'faker-encore') {
				FlxG.sound.music.volume = 0;
				FlxG.sound.playMusic(Paths.music('exe-gameover', 'shared'));
				FlxG.sound.play(Paths.sound('VoiceLines/ExeLines/' + FlxG.random.int(1, 8), 'exe'));
				FlxG.sound.music.fadeIn(1, 0, 1);
			}
				
			if (PlayState.SONG.song.toLowerCase() == 'soulless' || PlayState.SONG.song.toLowerCase() == 'sunshine-encore') {
				FlxG.sound.music.volume = 0;
				FlxG.sound.playMusic(Paths.music('td-gameover', 'shared'));
				FlxG.sound.play(Paths.sound('VoiceLines/TailsDollLines/' + FlxG.random.int(1, 6), 'exe'));
				FlxG.sound.music.fadeIn(1, 0, 1);
			}
		});
		
		new FlxTimer().start(2.1, function(tmr:FlxTimer)
		{
			canPressEnter = true;
		});
		
		#if mobile
		addVirtualPad(NONE, A_B);
		addVirtualPadCamera();
		#end
	}

	function startCountdown():Void
	{
		if (islol)
		{
			holdup = false;
			switch (PlayState.SONG.song)
			{
				case 'endless' | 'endless-og' | 'endless-jp' | 'endless-us' | 'endeavors' | 'endeavors-og':
					add(bluevg);
					boyfriend.visible = true;
					FlxTween.tween(topMajins, {alpha: 1}, 5);
					FlxTween.tween(bottomMajins, {alpha: 1}, 10);
					FlxTween.tween(countdown, {alpha: 1}, 1);
					FlxG.sound.play(Paths.sound('majin-gameover'), 1);
			}
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				timer--;
				if (PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'endless-og' || PlayState.SONG.song.toLowerCase() == 'endless-jp' || PlayState.SONG.song.toLowerCase() == 'endless-us' || PlayState.SONG.song.toLowerCase() == 'endeavors' || PlayState.SONG.song.toLowerCase() == 'endeavors-og')
				{
					countdown.text = Std.string(timer);
					if (timer == 9)
					{
						countdown.x += 15;
					}
				}
				if (timer == 0)
				{
					if (!actuallynotfuckd)
						youFuckedUp();
				}
				else
					tmr.reset();
			});
		}
	}

	function youFuckedUp():Void
	{
		toolateurfucked = true;

		switch (PlayState.SONG.song)
		{
			case 'endless' | 'endless-og' | 'endless-jp' | 'endless-us' | 'endeavors' | 'endeavors-og':
				FlxG.sound.music.stop();
				FlxTween.tween(countdown, {alpha: 0}, 0.5);
				remove(topMajins);
				remove(bottomMajins);
				boyfriend.playAnim('premajin');
				FlxG.sound.play(Paths.sound('firstLOOK'), 1);

				FlxTween.tween(bluevg, {alpha: 1}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						FlxTween.tween(bluevg, {alpha: 0}, 0.9);
					}
				});
				FlxTween.tween(coolcamera, {zoom: 1.7}, 1.5, {ease: FlxEase.quartOut});
				new FlxTimer().start(2.6, function(tmr:FlxTimer)
				{
					FlxTween.tween(coolcamera, {zoom: 1}, 0.3, {ease: FlxEase.quartOut});
					boyfriend.playAnim('majin');
					coolcamera.shake(0.01, 0.2);
					coolcamera.flash(FlxColor.fromRGB(75, 60, 240), .5);
					FlxG.sound.play(Paths.sound('secondLOOK'), 1);

					new FlxTimer().start(.4, function(tmr:FlxTimer)
					{
						FlxTween.tween(coolcamera, {zoom: 1.5}, 6, {ease: FlxEase.circIn});
					});

					new FlxTimer().start(5.5, function(tmr:FlxTimer)
					{
						Sys.exit(0);
					});
				});
				
			case 'black-sun' | 'godspeed' | 'faker-encore':
				FlxG.sound.play(Paths.music('exe-die', 'shared'));
				var statica:FlxSprite = new FlxSprite();
				statica.frames = Paths.getSparrowAtlas('screenstatic', 'exe');
				statica.animation.addByPrefix('fard', 'screenSTATIC', 24, true);
				statica.alpha = 0;
				statica.animation.play('fard');
				statica.cameras = [coolcamera2];
				add(statica);
				add(bluevg);
				bfdeathshit.animation.play('die');
				bfdeathshit.animation.paused = false;
				FlxTween.tween(bluevg, {alpha: 1}, 0.5);
				FlxTween.tween(statica, {alpha: 0.2}, 0.2);
				coolcamera.shake(0.05, 1);

				bfdeathshit.animation.finishCallback = function(amogus:String)
				{
					Sys.exit(0);
				}
		}
	}

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') add(blackScreen);

		if(PlayState.instance.vcrShader!=null && ClientPrefs.Shaders)
			PlayState.instance.vcrShader.iTime.value[0] = Conductor.songPosition / 1000;

		if ((PlayState.SONG.song.toLowerCase() == 'expulsion' || PlayState.SONG.song.toLowerCase() == 'playful') && !yes) {
			FlxG.camera.follow(camFollowPos, LOCKON, 1);
			updateCamera = true;
			isFollowingAlready = true;
			new FlxTimer().start(1.6, function(tmr:FlxTimer)
			{
				FlxG.sound.play(Paths.sound(deathSoundName));
				boyfriend.playAnim('firstDeath');
				yes = true;
			});
		}

		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			if (PlayState.instance.GameOverCameraMove) {
				camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
			} else {
				if(PlayState.SONG.song.toLowerCase() == 'b4cksl4sh') {
					camFollowPos.setPosition(boyfriend.getGraphicMidpoint().x + 300, boyfriend.getGraphicMidpoint().y + 250);
				} else {
					if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
						camFollowPos.setPosition(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
					} else {
						if (fofShit) {
							camFollowPos.setPosition(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
						}
					}
				}
			}
		}
		if(PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'endless-og' || PlayState.SONG.song.toLowerCase() == 'endless-jp' || PlayState.SONG.song.toLowerCase() == 'endless-us' || PlayState.SONG.song.toLowerCase() == 'endeavors' || PlayState.SONG.song.toLowerCase() == 'endeavors-og')
		{
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
			{
				FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
			});
		} else {
			if (PlayState.SONG.song.toLowerCase() == 'execution' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'hellbent' || PlayState.SONG.song.toLowerCase() == 'fate' || PlayState.SONG.song.toLowerCase() == 'judgement' ||  PlayState.SONG.song.toLowerCase() == 'cycles-encore' ||  PlayState.SONG.song.toLowerCase() == 'gotta-go-red-glove')
			{
				FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
			} else {
				if (PlayState.SONG.song.toLowerCase() == 'expulsion' || PlayState.SONG.song.toLowerCase() == 'playful') {
					new FlxTimer().start(0.85, function(tmr:FlxTimer)
					{
						FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
					});
				} else {
					if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
						new FlxTimer().start(1.0, function(tmr:FlxTimer)
						{
							FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
						});
					}
				}
			}
		}

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);

		if (controls.ACCEPT)
		{	
			if (!toolateurfucked && canPressEnter)
			{
				if (PlayState.SONG.song == 'black-sun' || PlayState.SONG.song == 'godspeed' || PlayState.SONG.song == 'faker-encore' || PlayState.SONG.song.toLowerCase() == 'soulless' || PlayState.SONG.song.toLowerCase() == 'sunshine-encore')
				{
					actuallynotfuckd = true;
					FlxG.sound.music.fadeOut(0.5, 0);
					FlxTween.tween(blackScreen, {alpha: 1}, 0.5);
					new FlxTimer().start(0.5, function(tmr:FlxTimer)
					{
						FlxG.sound.music.stop();
						Main.InPlaystate = true;
						MusicBeatState.resetState();
						PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
					});
				} else {
					if (PlayState.SONG.song.toLowerCase() == 'execution' || PlayState.SONG.song.toLowerCase() == 'cycles' || PlayState.SONG.song.toLowerCase() == 'hellbent' || PlayState.SONG.song.toLowerCase() == 'fate' || PlayState.SONG.song.toLowerCase() == 'judgement' ||  PlayState.SONG.song.toLowerCase() == 'cycles-encore' ||  PlayState.SONG.song.toLowerCase() == 'gotta-go-red-glove' ||  PlayState.SONG.song.toLowerCase() == 'execution-inski')
					{
						actuallynotfuckd = true;
						boyfriend.playAnim('deathConfirm', true);
						FlxG.sound.play(Paths.music(endSoundName));
						FlxTween.tween(blackScreen, {alpha: 1}, 1.5);
						FlxG.sound.music.fadeOut(1.5, 0);
						new FlxTimer().start(1.5, function(tmr:FlxTimer)
						{
							FlxG.sound.music.stop();
							Main.InPlaystate = true;
							MusicBeatState.resetState();
							PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
						});
					} else {
						if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
							actuallynotfuckd = true;
							endBullshit();
						} else {
							if (fofShit) {
								actuallynotfuckd = true;
								endBullshit();
							}
						}
					}
				}
				if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
					canPressEnter = false;
				} else {
					if (fofShit) {
						canPressEnter = false;
					}
				}
			}
		}

		if (controls.BACK)
		{	
			if (ClientPrefs.storyProgressExe == 3 && PlayState.SONG.song.toLowerCase() == 'final-escape') {
				Sys.exit(0);
			} else {
				if (!toolateurfucked)
				{
					Main.DisableCustomCursor = false;
					Main.InPlaystate = false;
					actuallynotfuckd = true;
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
		}

		if (PlayState.SONG.song.toLowerCase() != 'fight-or-flight') {
			if (boyfriend.animation.curAnim.name == 'firstDeath') {
				if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready && (PlayState.SONG.song.toLowerCase() != 'endless' || PlayState.SONG.song.toLowerCase() != 'endless-og'  || PlayState.SONG.song.toLowerCase() != 'endless-jp' || PlayState.SONG.song.toLowerCase() != 'endless-us' || PlayState.SONG.song.toLowerCase() != 'endeavors' || PlayState.SONG.song.toLowerCase() != 'endeavors-og'))
				{
					FlxG.camera.follow(camFollowPos, LOCKON, 1);
					updateCamera = true;
					isFollowingAlready = true;
				}
				
				if(PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'endless-og' || PlayState.SONG.song.toLowerCase() == 'endless-jp' || PlayState.SONG.song.toLowerCase() == 'endless-us' || PlayState.SONG.song.toLowerCase() == 'endeavors' || PlayState.SONG.song.toLowerCase() == 'endeavors-og')
				{
					new FlxTimer().start(1.0, function(tmr:FlxTimer)
					{
						FlxG.camera.follow(camFollowPos, LOCKON, 1);
						updateCamera = true;
						isFollowingAlready = true;
					});
				}

				if (boyfriend.animation.curAnim.finished)
				{
					coolStartDeath();
					boyfriend.startedDeath = true;
				}
				
				if (holdup && (PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'endless-og' || PlayState.SONG.song.toLowerCase() == 'endless-jp' || PlayState.SONG.song.toLowerCase() == 'endless-us' || PlayState.SONG.song.toLowerCase() == 'endeavors' || PlayState.SONG.song.toLowerCase() == 'endeavors-og' || PlayState.SONG.song.toLowerCase() == 'black-sun' || PlayState.SONG.song.toLowerCase() == 'godspeed' || PlayState.SONG.song.toLowerCase() == 'faker-encore')) startCountdown();
			}
		} else {
			if (fofShit) {
				if (boyfriend.animation.curAnim.name == 'firstDeath') {
					if (boyfriend.animation.curAnim.curFrame >= 1 && !isFollowingAlready)
					{
						FlxG.camera.follow(camFollowPos, LOCKON, 1);
						updateCamera = true;
						isFollowingAlready = true;
					}
					if (boyfriend.animation.curAnim.finished)
					{
						coolStartDeath();
						boyfriend.startedDeath = true;
					}
				}
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

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		var song:String = PlayState.SONG.song.toLowerCase();
		switch(song) {
			case 'too-slow', 'too-slow-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/XenoTSLines/' + FlxG.random.int(1, 10), 'exe'));
			case 'too-slow-encore-alt':
				FlxG.sound.play(Paths.sound('VoiceLines/GrimboLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'you-cant-run', 'you-cant-run-encore', 'hill-of-the-void':
				FlxG.sound.play(Paths.sound('VoiceLines/XenoYCRLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'triple-trouble', 'triple-trouble-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/XenoTTLines/' + FlxG.random.int(1, 12), 'exe'));
			case 'final-escape':
				FlxG.sound.play(Paths.sound('VoiceLines/XenoFELines/' + FlxG.random.int(1, 7), 'exe'));
			case 'face-off', 'ice-cap':
				FlxG.sound.play(Paths.sound('VoiceLines/LookALikeLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'broken-heart':
				FlxG.sound.play(Paths.sound('VoiceLines/AmyALTLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'tribal':
				FlxG.sound.play(Paths.sound('VoiceLines/KnucklesALTLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'goddess':
				FlxG.sound.play(Paths.sound('VoiceLines/SallyALTLines/' + FlxG.random.int(1, 10), 'exe'));
			case 'endless-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/MajinEncoreLines/' + FlxG.random.int(1, 11), 'exe'));
			case 'execution', 'cycles', 'hellbent', 'fate', 'judgement', 'cycles-encore', 'gotta-go-red-glove', 'execution-inski':
				FlxG.sound.play(Paths.sound('VoiceLines/LordXLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'sunshine', 'drippyshine':
				FlxG.sound.play(Paths.sound('VoiceLines/TailsDollLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'chaos', 'running-wild', 'terror', 'chaos-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/FleetLines/' + FlxG.random.int(1, 11), 'exe'));
			case 'faker':
				FlxG.sound.play(Paths.sound('VoiceLines/FakerLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'faker-encore', 'black-sun', 'godspeed':
				FlxG.sound.play(Paths.sound('VoiceLines/ExeLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'missiletoe':
				FlxG.sound.play(Paths.sound('VoiceLines/MissiletoeLines/' + FlxG.random.int(1, 5), 'exe'));
			case 'slaybells':
				FlxG.sound.play(Paths.sound('VoiceLines/SlaybellsLines/' + FlxG.random.int(1, 5), 'exe'));
			case 'jingle-hells':
				FlxG.sound.play(Paths.sound('VoiceLines/JingleHellsLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'fatality', 'fatality-encore', 'critical-error', 'unresponsive':
				FlxG.sound.play(Paths.sound('VoiceLines/FatalLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'prey':
				FlxG.sound.play(Paths.sound('VoiceLines/FurnaceLines/' + FlxG.random.int(1, 4), 'exe'));
			case 'fight-or-flight':
				FlxG.sound.play(Paths.sound('VoiceLines/StarvedLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'relax', 'round-a-bout', 'spike-trap':
				FlxG.sound.play(Paths.sound('VoiceLines/NeedlemouseLines/' + FlxG.random.int(1, 10), 'exe'));
			case 'round-a-bout-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/ShadowmouseLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'her-world-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/SunterLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'mania':
				FlxG.sound.play(Paths.sound('VoiceLines/SHTailsLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'insidious':
				FlxG.sound.play(Paths.sound('VoiceLines/DemogriLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'digitalized', 'substantial':
				FlxG.sound.play(Paths.sound('VoiceLines/XTerionLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'burning':
				FlxG.sound.play(Paths.sound('VoiceLines/GenesysLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'my-horizon', 'our-horizon':
				FlxG.sound.play(Paths.sound('VoiceLines/ChaotixLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'long-sky':
				FlxG.sound.play(Paths.sound('VoiceLines/ChotixLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'hedge':
				FlxG.sound.play(Paths.sound('VoiceLines/HogLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'manual-blast':
				FlxG.sound.play(Paths.sound('VoiceLines/ScorchedLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'malediction', 'extricate-hex', 'unblessful-hedgehog':
				FlxG.sound.play(Paths.sound('VoiceLines/CurseLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'found-you':
				FlxG.sound.play(Paths.sound('VoiceLines/NormalLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'genesis', 'corinthians', 'perdition-apollyon':
				FlxG.sound.play(Paths.sound('VoiceLines/ApollyonLines/' + FlxG.random.int(1, 11), 'exe'));
			case 'trickery':
				FlxG.sound.play(Paths.sound('VoiceLines/PsychoLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'perdition', 'underworld':
				FlxG.sound.play(Paths.sound('VoiceLines/SatanosLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'forever-unnamed':
				FlxG.sound.play(Paths.sound('VoiceLines/NoNameLines/' + FlxG.random.int(1, 5), 'exe'));
			case 'b4cksl4sh':
				FlxG.sound.play(Paths.sound('VoiceLines/Sl4shLines/' + FlxG.random.int(1, 8), 'exe'));
			case 'color-blind', 'color-blind-old', 'color-blind-encore':
				FlxG.sound.play(Paths.sound('VoiceLines/MonoLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'miasma':
				FlxG.sound.play(Paths.sound('VoiceLines/DSKLines/' + FlxG.random.int(1, 7), 'exe'));
			case 'universal-collapse', 'planestrider':
				FlxG.sound.play(Paths.sound('VoiceLines/OMWLines/' + FlxG.random.int(1, 4), 'exe'));
			case 'fake-baby':
				FlxG.sound.play(Paths.sound('VoiceLines/NMILines/' + FlxG.random.int(1, 10), 'exe'));
			case 'envy':
				FlxG.sound.play(Paths.sound('VoiceLines/GrimewareLines/' + FlxG.random.int(1, 11), 'exe'));
			case 'hellstorm', 'sharpy-showdown':
				FlxG.sound.play(Paths.sound('VoiceLines/ExetiorLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'call-of-justice', 'gotta-go', 'call-of-justice-old':
				FlxG.sound.play(Paths.sound('VoiceLines/BatmanLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'shocker', 'extreme-zap', 'thunderbolt':
				FlxG.sound.play(Paths.sound('VoiceLines/SonichuLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'ugly':
				FlxG.sound.play(Paths.sound('VoiceLines/UglyLines/' + FlxG.random.int(1, 6), 'exe'));
			case 'frenzy':
				FlxG.sound.play(Paths.sound('VoiceLines/LumpyLines/' + FlxG.random.int(1, 4), 'exe'));
			case 'soured':
				FlxG.sound.play(Paths.sound('VoiceLines/LemonLines/' + FlxG.random.int(1, 9), 'exe'));
			case 'last-flag':
				FlxG.sound.play(Paths.sound('VoiceLines/MXLines/' + FlxG.random.int(1, 10), 'exe'));
			case 'old-ycr-slaps':
				FlxG.sound.play(Paths.sound('VoiceLines/XenoSlapsLines/' + FlxG.random.int(1, 11), 'exe'));
			case 'oxxynless':
				FlxG.sound.play(Paths.sound('VoiceLines/OxxyLines/' + FlxG.random.int(1, 4), 'exe'));
		}
		if (PlayState.SONG.song != 'black-sun' && PlayState.SONG.song != 'godspeed' && PlayState.SONG.song != 'faker-encore'  && PlayState.SONG.song.toLowerCase() != 'soulless' && PlayState.SONG.song.toLowerCase() != 'sunshine-encore' && PlayState.SONG.song.toLowerCase() != 'milk' && PlayState.SONG.song.toLowerCase() != 'cool-party') {
				FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
		}
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			if (PlayState.SONG.song == 'too-slow' || PlayState.SONG.song == 'you-cant-run' || PlayState.SONG.song == 'triple-trouble' || PlayState.SONG.song == 'final-escape' || PlayState.SONG.song == 'too-slow-encore' || PlayState.SONG.song == 'too-slow-encore-alt' || PlayState.SONG.song == 'you-cant-run-encore' || PlayState.SONG.song == 'triple-trouble-encore' || PlayState.SONG.song == 'hill-of-the-void')
			{
				boyfriend.visible = false;
				FlxG.camera.flash(FlxColor.RED, 4);
				sonicDEATH.playAnim('deathConfirm', true);
			}
			if (PlayState.SONG.song == 'black-sun' || PlayState.SONG.song == 'godspeed' || PlayState.SONG.song == 'faker-encore')
			{
				bfdeathshit.visible = false;
				FlxG.camera.flash(FlxColor.RED, 4);
				FlxG.sound.play(Paths.music('exe-die','shared'));
			}
			if (PlayState.SONG.song.toLowerCase() == 'endless' || PlayState.SONG.song.toLowerCase() == 'endless-og'  || PlayState.SONG.song.toLowerCase() == 'endless-jp' || PlayState.SONG.song.toLowerCase() == 'endless-us' || PlayState.SONG.song.toLowerCase() == 'endeavors' || PlayState.SONG.song.toLowerCase() == 'endeavors-og') {
				if (PlayState.SONG.song == 'endless-us') {
					FlxG.camera.flash(FlxColor.fromRGB(62, 239, 127), 0.5);
				} else {
					if (PlayState.SONG.song == 'endless-jp') {
						FlxG.camera.flash(FlxColor.fromRGB(143, 61, 237), 0.5);
					} else {
						FlxG.camera.flash(FlxColor.fromRGB(75, 60, 240), 0.5);
					}
				}
				remove(countdown);
				remove(topMajins);
				remove(bottomMajins);
				remove(bfdeathshit);
				remove(boyfriend);
				islol = false;
			}

			FlxG.sound.music.stop();
			if (PlayState.SONG.song != 'black-sun' && PlayState.SONG.song != 'godspeed' && PlayState.SONG.song != 'faker-encore') {
				FlxG.sound.play(Paths.music(endSoundName));
			}
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
