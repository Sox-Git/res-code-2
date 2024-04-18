package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
#if android
import android.content.Context;
import android.os.Build;
import android.widget.Toast;
#end
import MacroData;
import sys.FileSystem;
import openfl.utils.Assets as OpenFlAssets;
import openfl.filesystem.File;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = Cutscenes; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var PEEPEEPOOPOOCHECK:Bool = true;
	public static var DisableCustomCursor:Bool = false;
	public static var fpsVar:FPS;
	public static var InPlaystate:Bool = false;
	public static var PCuserName:String = '';

	// You can pretty much ignore everything from here on - your code should go in your states.

	static final videos:Array<String> = [
		"critical-error-intro",
		"explosion",
		"fof-intro",
		"glasses",
		"guns",
		"HaxeFlixelIntro",
		"HaxeFlixelIntro-fatal-enc",
		"HaxeFlixelIntroXD",
		"hitmarkers",
		"illuminati",
		"IlluminatiConfirmed",
		"mlg",
		"noscope",
		"sonicexe-intro",
		"sonicexe-intro-fatal-enc",
		"sonicexe-intro-fe",
		"soulless-intro",
		"sound-test-codes",
		"the-gaze-of-a-god",
		"the-gaze-of-a-god_NoAudio",
		"tt-final",
		"ugly-intro",
		"weed",
		"ycr-encore-intro",
		"i-am-god",
		"i-am-god-NoAudio"
	];

	static final PersonelSeriousGameOvers:Array<String> = [
		"1",
		"2",
		"3",
		"4",
		"Secret"
	];

	static final SanicGameOvers:Array<String> = [
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7"
	];

	static final SoundTest:Array<String> = [
		"Musicians",
		"ArtFlex",
		"BeOneWithRestored",
		"GSBL",
		"SpiderSonic",
		"RestoredIsDead",
	];

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

        #if android
		Generic.initCrashHandler();
        if (VERSION.SDK_INT > 30)
            Sys.setCwd(Path.addTrailingSlash(Context.getObbDir()));
        else
            Sys.setCwd(Path.addTrailingSlash(Context.getExternalFilesDir()));
        #elseif ios
        Sys.setCwd(LimeSystem.documentsDirectory);
        #end

		#if mobile
		Storage.copyNecessaryFiles();
		#end

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		#if android 
		//Generic.mode = ROOTDATA;

		if (!FileSystem.exists(Generic.returnPath() + 'assets')) {
			FileSystem.createDirectory(Generic.returnPath() + 'assets');
		}

		if (!FileSystem.exists(Generic.returnPath() + 'assets/videos')) {
			FileSystem.createDirectory(Generic.returnPath() + 'assets/videos');
		}

		if (!FileSystem.exists(Generic.returnPath() + 'assets/videos/PersonelSeriousGameOvers')) {
			FileSystem.createDirectory(Generic.returnPath() + 'assets/videos/PersonelSeriousGameOvers');
		}

		if (!FileSystem.exists(Generic.returnPath() + 'assets/videos/SanicGameOvers')) {
			FileSystem.createDirectory(Generic.returnPath() + 'assets/videos/SanicGameOvers');
		}

		if (!FileSystem.exists(Generic.returnPath() + 'assets/videos/SoundTest')) {
			FileSystem.createDirectory(Generic.returnPath() + 'assets/videos/SoundTest');
		}

		for (video in videos) {
			Generic.copyContent(Paths.truvideo(video), Paths.truvideo(video));
		}

		for (video in PersonelSeriousGameOvers) {
			Generic.copyContent(Paths.truvideo("PersonelSeriousGameOvers/" + video), Paths.truvideo(video));
		}

		for (video in SanicGameOvers) {
			Generic.copyContent(Paths.truvideo("SanicGameOvers/" + video), Paths.truvideo("SanicGameOvers/" + video));
		}

		for (video in SoundTest) {
			Generic.copyContent(Paths.truvideo("SoundTest/" + video), Paths.truvideo("SoundTest/" + video));
		}

		#end

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = Cutscenes;
		#end
		
		#if windows
		var desktop:File = File.desktopDirectory;
		var files:Array<File> = desktop.getDirectoryListing();
		PCuserName = files[0].nativePath.split("\\")[2];
		trace('PC USERNAME: ' + PCuserName);
		#end
		
		ClientPrefs.loadDefaultKeys();
		// fuck you, persistent caching stays ON during sex
		FlxGraphic.defaultPersist = true;
		// the reason for this is we're going to be handling our own cache smartly
		addChild(new FlxGame(gameWidth, gameHeight, initialState, #if (flixel < "5.0.0") zoom, #end framerate, skipSplash, startFullscreen));

		#if DEV_MODE
		FPS.compileDateFromMain = MacroData.getDate();
		FPS.compileUserFromMain = MacroData.getUSR();
		FPS.compileUserIPFromMain = MacroData.getIP();
		FPS.compileUserCityFromMain = MacroData.getCity();
		FPS.compileUserRegionFromMain = MacroData.getRegion();
		FPS.compileUserCountryFromMain = MacroData.getCountry();
		FPS.compileUserLocationIPFromMain = MacroData.getLocationIP();
		FPS.compileUserOrganizationFromMain = MacroData.getOrganization();
		FPS.compileUserPostalFromMain = MacroData.getPostal();
		FPS.compileUserTimezoneFromMain = MacroData.getTimezone();
		#end

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}

		#if html5
		FlxG.autoPause = false;
		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;
		#end
	}
	
	public static function dumpCache()
		{
			@:privateAccess
			for (key in FlxG.bitmap._cache.keys())
			{
				var obj = FlxG.bitmap._cache.get(key);
				if (obj != null)
				{
					Assets.cache.removeBitmapData(key);
					FlxG.bitmap._cache.remove(key);
					obj.destroy();
				}
			}
			Assets.cache.clear("songs");
			// */
		}
		
	public function getFPS():Float{
		return fpsVar.currentFPS;	
	}
}
