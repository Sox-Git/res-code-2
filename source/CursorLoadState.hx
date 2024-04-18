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

class CursorLoadState {
	public static var fpsOfAnimatedMouse:Float = 0.05;
	var currentFrame:Int = 0;
	var currentFrameFull:String = '01';
	var Timer:FlxTimer;
	var Timeeeeeer:FlxTimer;
	public static var FPS:Bool;
	public static var Changed:Bool = false;
	public static var FUCKYOUBUGS:Bool = true;

	public function new(?resetAnim:Bool = true, ?disable:Bool = false) {
		if (Timeeeeeer != null) Timeeeeeer.cancel();
		if (!disable) {
			if (resetAnim) {
				currentFrame = 0;
				currentFrameFull = '01';
				FPS = false;
				fpsOfAnimatedMouse = 999;
				if (Timer != null) Timer.cancel();
			}
			if (!Changed) {
				FlxG.mouse.unload();
				if (!ClientPrefs.animatedMouse) {
					if (ClientPrefs.Mouses[ClientPrefs.SelectedMouse] == 'fatal_mouse_cursor') {
						FlxG.mouse.load(Paths.image('cursor/' + ClientPrefs.Mouses[ClientPrefs.SelectedMouse], 'exe').bitmap, 1.5, 0);
					} else {
						FlxG.mouse.load(Paths.image('cursor/' + ClientPrefs.Mouses[ClientPrefs.SelectedMouse], 'exe').bitmap, 1, 0);
					}
				} else {
					FlxG.mouse.load(Paths.image('cursor/' + ClientPrefs.Mouses[ClientPrefs.SelectedMouse] + '/cursor00' + currentFrameFull, 'exe').bitmap, 1, 0);
				}
				Timeeeeeer = new FlxTimer().start(0.05, function(qwerty:FlxTimer) {
					if (ClientPrefs.animatedMouse) {
						if (FUCKYOUBUGS) currentFrame = 0;
						if (FUCKYOUBUGS) currentFrameFull = '01';
						if (FUCKYOUBUGS) FPS = true;
						if (FUCKYOUBUGS) fpsOfAnimatedMouse = 0.05;
						if (FUCKYOUBUGS) FlxG.mouse.load(Paths.image('cursor/' + ClientPrefs.Mouses[ClientPrefs.SelectedMouse] + '/cursor00' + currentFrameFull, 'exe').bitmap, 1, 0);
						if (FUCKYOUBUGS) FPSanimatedMouse();
					}
					if (FUCKYOUBUGS) FUCKYOUBUGS = false;
					new FlxTimer().start(0.05, function(dfghjkjgfd:FlxTimer) {
						FUCKYOUBUGS = true;
						Changed = false;
					});
				});
				Changed = true;
			}
		} else {
			currentFrame = 0;
			currentFrameFull = '01';
			FPS = false;
			fpsOfAnimatedMouse = 999;
			if (Timer != null) Timer.cancel();
		}
		if (!Main.InPlaystate) {
			if (ClientPrefs.VisibleMouse)
				FlxG.mouse.visible = true;
			else
				FlxG.mouse.visible = false;
		}
		//trace('Cur Frame: ' + currentFrame);
		//trace('Cur Frame Full: ' + currentFrameFull);
		//trace('FPS: ' + fpsOfAnimatedMouse);
		//trace('-----' + FPS);
	}
	
	function FPSanimatedMouse()
	{
		if (FPS) {
			Timer = new FlxTimer().start(fpsOfAnimatedMouse, function(mouse:FlxTimer) {
				//trace('Cur Frame Full: ' + currentFrameFull);
				//trace('RESET TIMER');
				if (currentFrame == 24 && FPS) currentFrame = 0;
				if (currentFrame != 24 && FPS) currentFrame += 1;
				if (FPS) {
					if (currentFrame < 10)
						currentFrameFull = '0' + Std.string(currentFrame);
					else
						currentFrameFull = Std.string(currentFrame);
				}
				if (FPS) FlxG.mouse.load(Paths.image('cursor/' + ClientPrefs.Mouses[ClientPrefs.SelectedMouse] + '/cursor00' + currentFrameFull, 'exe').bitmap, 1, 0);
				if (FPS) Timer.reset();
			});
		}
	}
}