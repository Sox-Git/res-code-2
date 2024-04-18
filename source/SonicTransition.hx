package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
import openfl.display.Shader;
import shaders.Wow;

class SonicTransition extends MusicBeatSubstate {
	var isTransIn:Bool = false;
	var duration:Float = 1.0;
	public static var TransFile:String = 'head';
	
	var fuckingShit:FlxSprite;
	var fuckingShitBRUH:FlxSprite;
	
	var shitcodelol:Float = 40.0;
	var cam:FlxCamera;
	var cum:FlxCamera;
	public static var finishCallback:Void->Void;
	public static var instance:SonicTransition;

	public function new(duration:Float, isTransIn:Bool) {
		super();

		instance = this;
		this.isTransIn = isTransIn;
		this.duration = duration;
		
		cam = new FlxCamera();
		cam.bgColor.alpha = 0;
		if (isTransIn) {
			cam.zoom = 0.05;
		} else {
			cam.zoom = 5;
		}
		FlxG.cameras.add(cam);
		
		var woo:Wow;
		woo = new Wow();
		
		cum = new FlxCamera();
		cum.bgColor.alpha = 0;
		FlxG.cameras.add(cum);
		
		if(FlxTransitionableState.skipNextTransIn) {
			cam = null;
			cum = null;
		}

		fuckingShit = new FlxSprite().loadGraphic(Paths.image('Transition/' + TransFile));
		fuckingShit.antialiasing = ClientPrefs.globalAntialiasing;
		fuckingShit.scrollFactor.set();
		fuckingShit.screenCenter();
		fuckingShit.cameras = [cam];
		fuckingShit.shader = woo;
		add(fuckingShit);
		
		if (isTransIn) {
			shitcodelol = 1.0;
		} else {
			shitcodelol = 45.0;
		}
		
		fuckingShitBRUH = new FlxSprite().loadGraphic(Paths.image('Transition/shit'));
		fuckingShitBRUH.setGraphicSize(Std.int(fuckingShitBRUH.width * shitcodelol));
		fuckingShitBRUH.scrollFactor.set();
		fuckingShitBRUH.screenCenter();
		fuckingShitBRUH.cameras = [cum];
		add(fuckingShitBRUH);
		
		if (isTransIn) {
		    FlxTween.tween(cam, {zoom: 5}, duration, {
				onComplete: function(twn:FlxTween) {
					close();
					camSus();
				},
				ease: FlxEase.expoInOut,
				startDelay: 0.05
			});
			FlxTween.tween(cum, {zoom: 45}, 0.7, {
				ease: FlxEase.expoInOut,
				startDelay: 0.10
			});
		} else {
			FlxTween.tween(cam, {zoom: 0.075}, duration, {
				onComplete: function(twn:FlxTween) {
					if(finishCallback != null) {
						finishCallback();
					}
				},
				ease: FlxEase.expoInOut,
				startDelay: 0.10
			});
			FlxTween.tween(cum, {zoom: 0.05}, 0.7, {
				ease: FlxEase.expoInOut,
				startDelay: 0.35
			});
		}
	}
	
	public function camSus() {
		cam.zoom = 1.0;
		cum.zoom = 1.0;
	}
}