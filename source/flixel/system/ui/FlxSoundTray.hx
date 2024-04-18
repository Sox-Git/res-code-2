package flixel.system.ui;

#if FLX_SOUND_SYSTEM
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
#if flash
import flash.text.AntiAliasType;
import flash.text.GridFitType;
#end

class FlxSoundTray extends Sprite
{
	public var active:Bool;
	var _timer:Float;
	var _bars:Array<Bitmap>;
	var _width:Int = 28;
	var _defaultScale:Float = 2.0;
	public static var leakShow:Bool = false;
	@:keep
	public function new()
	{
		super();

		visible = false;
		scaleX = _defaultScale;
		scaleY = _defaultScale;
		var tmp:Bitmap = new Bitmap(new BitmapData(_width, 80, true, 0x7F000000));
		screenCenter();
		addChild(tmp);

		var text:TextField = new TextField();
		text.width = tmp.width;
		text.height = tmp.height;
		text.multiline = true;
		text.wordWrap = true;
		text.selectable = false;

		#if flash
		text.embedFonts = true;
		text.antiAliasType = AntiAliasType.NORMAL;
		text.gridFitType = GridFitType.PIXEL;
		#else
		#end
		var dtf:TextFormat = new TextFormat(FlxAssets.FONT_DEFAULT, 10, 0xffffff);
		dtf.align = TextFormatAlign.CENTER;
		text.defaultTextFormat = dtf;
		addChild(text);
		text.text = "VOL";
		text.y = 0;

		var by:Int = 71;
		_bars = new Array();

		for (i in 0...10)
		{
			tmp = new Bitmap(new BitmapData(16, 4, false, FlxColor.WHITE));
			tmp.x += 5.7;
			tmp.y = by;
			addChild(tmp);
			_bars.push(tmp);
			by -= 6;
		}

		y = -height;
		visible = false;
	}

	public function update(MS:Float):Void
	{
		if (_timer > 0) {
			_timer -= MS / 1000;
		}
		else if (y > -width) {
			x += (MS / 1000) * FlxG.width * 2;

			if (x <= -width) {
				visible = false;
				active = false;
			}
		}
	}

	public function show(Silent:Bool = false):Void
	{
		#if DEV_MODE
		if (FlxG.keys.pressed.I && FlxG.keys.pressed.P)
			leakShow = !leakShow;
		#end
	
		if (!Silent) {
			var sound = Paths.sound('sound', 'preload');
			if (sound != null)
				FlxG.sound.load(sound).play();
		}

		_timer = 1;
		y = 0;
		screenCenter();
		visible = true;
		active = true;
		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

		if (FlxG.sound.muted)
			globalVolume = 0;

		for (i in 0..._bars.length)
		{
			if (i < globalVolume)
				_bars[i].alpha = 1;
			else
				_bars[i].alpha = 0.5;
		}
		
		ClientPrefs.volMuted = FlxG.sound.muted;
		ClientPrefs.volVolume = FlxG.sound.volume;
		ClientPrefs.saveSettings();
	}

	public function screenCenter():Void
	{
		scaleX = _defaultScale;
		scaleY = _defaultScale;

		x = (1 * (Lib.current.stage.stageWidth - _width * _defaultScale) - FlxG.game.x);
	}
}
#end
