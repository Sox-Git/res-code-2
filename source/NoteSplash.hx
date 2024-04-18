package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import shaders.ColorSwap;
import editors.*;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;
	var isRing:Bool = PlayState.SONG.isRing;

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String;
		var prefix:String='';
		if (PlayState.instance.customNoteColors) prefix = '-COLOR';
		if (PlayState.instance.noteChangesFromTheStore)
			skin = 'arrows/'+ClientPrefs.arrowSplash+prefix;
		else
			skin = 'arrows/noteSplashes'+prefix;
		
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;
		if (!PlayState.instance.fatalUI) {
			if (PlayState.SONG.splashSkin == 'slash-splash' || PlayState.isPixelStage)
				skin = 'slash-splash';
		} else {
			skin = 'splashes';
		}

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		if (PlayState.instance.noteChangesFromTheStore) {
			if (!ClientPrefs.arrowColorsRGB)
				shader = colorSwap.shader;
			else
				shader = PlayState.instance.rgbColorSwap.shader;
		} else {
			shader = colorSwap.shader;
		}

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);

		var prefix:String='';
		if (PlayState.instance.customNoteColors) prefix = '-COLOR';
		if (PlayState.instance.noteChangesFromTheStore)
			texture = 'arrows/'+ClientPrefs.arrowSplash+prefix;
		else
			texture = 'arrows/noteSplashes'+prefix;
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		if (!PlayState.instance.fatalUI) {
			if (PlayState.isPixelStage || PlayState.instance.pixelNoteGenesis)
				texture = 'slash-splash';
		} else {
			texture = 'splashes';
		}
		switch (PlayState.instance.noteGenesis) {
			case 1: texture = 'slash-splash';
			case 2:
				if (PlayState.instance.noteChangesFromTheStore) {
					if (ClientPrefs.arrowSplash != 'noteSplashes') {
						texture = 'arrows/'+ClientPrefs.arrowSplash+prefix;
					} else {
						switch(PlayState.SONG.song.toLowerCase()) {
							case 'our-horizon': texture = 'arrows/noteSplashes'+prefix;
							default: texture = 'BloodSplash';
						}
					}
				} else {
					switch(PlayState.SONG.song.toLowerCase()) {
						case 'our-horizon': texture = 'arrows/noteSplashes'+prefix;
						default: texture = 'BloodSplash';
					}
				}
		}

		if(textureLoaded != texture)
			loadAnims(texture);
		
		switch(texture){
			case 'BloodSplash':
				alpha = 1;
				antialiasing=true;
				colorSwap.hue = 0;
				colorSwap.saturation = 0;
				colorSwap.brightness = 0;
				animation.play('splash', true);
				offset.set(-40*(0.7/0.7),-90*(0.7/0.7));
				animation.curAnim.frameRate = 24;
				
			case 'hitmarker':
				alpha = 1;
				antialiasing=true;
				colorSwap.hue = 0;
				colorSwap.saturation = 0;
				colorSwap.brightness = 0;
				animation.play('hit', true);
				updateHitbox();
				offset.set(-90*(0.7/0.7),-90*(0.7/0.7));
				animation.curAnim.frameRate = 24;
				
			case 'milkSplashes':
				alpha = 0.89;
				antialiasing=true;
				var animNum:Int = FlxG.random.int(1, 2);
				animation.play('note' + note + '-' + animNum, true);
				scale.x = 0.6;
				scale.y = 0.6;
				updateHitbox();
				offset.set(70*(0.7/0.7), 90*(0.7/0.7));
				
			default:
				alpha = 0.8;
				antialiasing=true;
				if (PlayState.instance.customNoteColors) {
					if (!ClientPrefs.arrowColorsRGB) {
						colorSwap.hue = hueColor;
						colorSwap.saturation = satColor;
						colorSwap.brightness = brtColor;
					}
				} else {
					if (PlayState.instance.noteChangesFromTheStore) {
						if (!ClientPrefs.arrowColorsRGB) {
							colorSwap.hue = hueColor;
							colorSwap.saturation = satColor;
							colorSwap.brightness = brtColor;
						}
					} else {
						colorSwap.hue = 0;
						colorSwap.saturation = 0;
						colorSwap.brightness = 0;
					}
				}
				var skinDetectShit:Array<String> = texture.split("/");
				if (skinDetectShit.contains('diamond') || skinDetectShit.contains('electric') || skinDetectShit.contains('sparkles')) {
					animation.play('note' + note, true);
				} else {
					animation.play('note' + note + '-' + FlxG.random.int(1, 2), true);
				}
				offset.set(10*(0.7/0.7), 10*(0.7/0.7));
				animation.curAnim.frameRate = 24;
		}
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		var skinDetectShit:Array<String> = skin.split("/");
		switch(skin) {
			case 'BloodSplash':
					animation.addByPrefix("splash", "Pop", 24, false);
			case 'hitmarker':
					animation.addByPrefix("hit", "hit", 24, false);
			case 'milkSplashes':
				for (i in 1...3) {
					animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
					animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
					animation.addByPrefix("note2-" + i, "note splash green " + i, 24, false);
					animation.addByPrefix("note3-" + i, "note splash red " + i, 24, false);
				}
			default:
				if(isRing) {
					for (i in 1...3) {
						animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
						animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
						animation.addByPrefix("note2-" + i, "note splash red " + i, 24, false);
						animation.addByPrefix("note3-" + i, "note splash green " + i, 24, false);
						animation.addByPrefix("note4-" + i, "note splash red " + i, 24, false);
					}
				} else {
					if (skinDetectShit.contains('diamond') || skinDetectShit.contains('electric') || skinDetectShit.contains('sparkles')) {
						animation.addByPrefix("note0", "note splash purple 1", 24, false);
						animation.addByPrefix("note1", "note splash blue 1", 24, false);
						animation.addByPrefix("note2", "note splash green 1", 24, false);
						animation.addByPrefix("note3", "note splash red 1", 24, false);
					} else {
						for (i in 1...3) {
							animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
							animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
							animation.addByPrefix("note2-" + i, "note splash green " + i, 24, false);
							animation.addByPrefix("note3-" + i, "note splash red " + i, 24, false);
						}
					}
				}
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}