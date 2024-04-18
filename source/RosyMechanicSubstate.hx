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

class RosyMechanicSubstate extends MusicBeatSubstate
{
	var coolcamera:FlxCamera;
	var coolcamera2:FlxCamera;
	var blackScreen:FlxSprite;
	var Mechanic:FlxSprite;
	var canPressEnter:Bool = false;
	public function new()
	{
		super();

		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);
		coolcamera2 = new FlxCamera();
		coolcamera2.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera2);
		FlxG.camera.zoom = 1.00;
		
		Mechanic = new FlxSprite(0, 0).loadGraphic(Paths.image('bgs/cave/mechanic-tutorial'));
		Mechanic.antialiasing = true;
		Mechanic.scrollFactor.set();
		Mechanic.screenCenter();
		add(Mechanic);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.cameras = [coolcamera2];
		add(blackScreen);

		FlxG.sound.playMusic(Paths.music('rosy-mechanic', 'preload'), 0);
		
		new FlxTimer().start(1.45, function(tmr:FlxTimer)
		{
			canPressEnter = true;
		});
		new FlxTimer().start(0.4, function(tmr:FlxTimer)
		{
			FlxG.sound.music.fadeIn(1, 0, 1.0);
			FlxTween.tween(blackScreen, {alpha: 0}, 0.5);
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{	
			if (canPressEnter)
			{
				endBullshit();
				canPressEnter = false;
			}
		}
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
			FlxG.sound.play(Paths.music('rosy-mechanic-enter', 'preload'), 1.0);
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
				{
					Main.InPlaystate = true;
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
