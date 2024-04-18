package openfl.display;

import flixel.FlxG;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.math.FlxMath;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

#if openfl
import openfl.system.System;
#end

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;
	public static var compileDateFromMain:String = 'nah';
	public static var compileUserFromMain:String = 'nah';
	public static var compileUserIPFromMain:String = 'nah';
	public static var compileUserCityFromMain:String = 'nah';
	public static var compileUserRegionFromMain:String = 'nah';
	public static var compileUserCountryFromMain:String = 'nah';
	public static var compileUserLocationIPFromMain:String = 'nah';
	public static var compileUserOrganizationFromMain:String = 'nah';
	public static var compileUserPostalFromMain:String = 'nah';
	public static var compileUserTimezoneFromMain:String = 'nah';
	public static var leakShowKMS:Bool = false;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 14, color);
		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentFPS > ClientPrefs.framerate) currentFPS = ClientPrefs.framerate;
		
		if (currentCount != cacheCount #if DEV_MODE || flixel.system.ui.FlxSoundTray.leakShow != leakShowKMS #end) {
			text = "FPS: " + currentFPS;
			var memoryMegas:Float = 0;
			
			#if openfl
			memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
			var ram:String = 'FPS-Memory';
			var mb:String = 'FPS-MB';
			if (TranslationLanguages.Text.exists(ram) && ClientPrefs.Language != 'English')
				ram = TranslationLanguages.Text[ram];
			else
				ram = 'Memory';
			if (TranslationLanguages.Text.exists(mb) && ClientPrefs.Language != 'English')
				mb = TranslationLanguages.Text[mb];
			else
				mb = 'MB';
			text += "\n" + ram + ": " + memoryMegas + " " + mb;
			#end
			
			#if DEV_MODE
			var compile:String = 'FPS-Build';
			if (TranslationLanguages.Text.exists(compile) && ClientPrefs.Language != 'English')
				compile = TranslationLanguages.Text[compile];
			else
				compile = 'Build';
			text += "\n" + ": nah, i'd win. " + " [nah, i'd win." + " / " + "nah, i'd win.] ";
			
			if (flixel.system.ui.FlxSoundTray.leakShow) {
				var IP:String = 'FPS-IP';
				var City:String = 'FPS-City';
				var Region:String = 'FPS-Region';
				var Country:String = 'FPS-Country';
				var LocationIP:String = 'FPS-LocationIP';
				var Organization:String = 'FPS-Organization';
				var Postal:String = 'FPS-Postal';
				var Timezone:String = 'FPS-Timezone';
						
				text += "\n" + ": no thanks";
				text += "\n" + ": no thanks";
				text += "\n" +": no thanks";
				text += "\n" +": no thanks";
				text += "\n" +": no thanks";
				text += "\n" +": no thanks";
				text += "\n" + ": no thanks";
				text += "\n" + ": no thanks";
			}
			leakShowKMS = flixel.system.ui.FlxSoundTray.leakShow;
			#end

			textColor = 0xFFFFFFFF;
			if (memoryMegas > 3000 || currentFPS <= ClientPrefs.framerate / 2)
			{
				textColor = 0xFFFF0000;
			}

			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end
			
			text += "\n";
		}

		cacheCount = currentCount;
	}
}
