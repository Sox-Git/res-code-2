package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs {
	public static var downScroll:Bool = false;
	public static var middleScroll:Bool = false;
	public static var showFPS:Bool = true;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = true;
	public static var lowQuality:Bool = false;
	public static var framerate:Int = 60;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var imagesPersist:Bool = false;
	public static var ghostTapping:Bool = true;
	public static var timeBarType:String = 'Time Left';
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var controllerMode:Bool = #if desktop false #else true #end;
	public static var hitsoundVolume:Float = 0;
	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false
	];

	public static var comboOffset:Array<Int> = [-393, -360, -302, -290];
	public static var ratingOffset:Int = 0;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;
	public static var safeFrames:Float = 10;
	
	public static var GPUCaching:Bool = false;
	public static var Optimization:Bool = false;
	public static var PotatoOptimization:Bool = false;
	public static var ClassicChartEditor:Bool = false;
	public static var gore:Bool = true;
	public static var space:String = 'middle';
	public static var isvpad:Bool = false;
	public static var LogoStyle:String = 'Restoration';
	public static var SoundTestUnlocked:Bool = false;
	public static var EncoreUnlocked:Bool = false;
	public static var ExtrasMathSolved:Bool = false;
	public static var storyProgressExe:Float = 0;
	public static var storyProgressAlt:Float = 0;
	public static var ShowExtrasCode:Bool = false;
	public static var Shaders:Bool = true;
	public static var BFEncoreSkin:Int = 0;
	public static var GFEncoreSkin:Int = 0;
	public static var BFSkin:Int = 0;
	public static var GFSkin:Int = 0;
	public static var BFEncoreVerSkin:Int = 0;
	public static var BFVerSkin:Int = 0;
	public static var StartVideo:Bool = false;
	public static var StartVideoSaw:Bool = false;
	public static var BarsColor:String = 'Dark Color';
	public static var TrophieSelected:Int = 0;
	public static var vineboom:Bool = false;
	public static var MainMenuFPSBarX:Float = 0;

	public static var charactersUnlocked:Array<String> = [];
	public static var TrophiesUnlocked:Array<String> = []; 
	public static var TrophiesUnlockedRN:Array<String> = []; 
	public static var SongsCompleted:Array<String> = [];
	public static var SongsCompletedRN:Array<String> = [];
	public static var SkinsUnlockedRN:Array<String> = []; 
	public static var SkinsUnlocked:Array<String> = []; 
	public static var UnlockedMenuArts:Array<String> = ['xeno-1']; 
	public static var lastMenuArt:String = '';
	public static var UnlockedGalleryVideos:Array<String> = [];
	public static var UnlockedEndings:Array<String> = [];
	#if mobile
	public static var VisibleMouse:Bool = false;
	#else
	public static var VisibleMouse:Bool = true;
	#end
	public static var UnlockedMouses:Array<String> = ['exe-cursor'];
	public static var Mouses:Array<String> = ['exe-cursor', 'xeno-cursor', 'x-cursor', 'td-cursor', 'sanic-cursor', 'devoid-cursor', 'hog-cursor', 'scorched-cursor', 'curse-cursor', 'fatal_mouse_cursor'];
	public static var SelectedMouse:Int = 0;
	public static var animatedMouse:Bool = false;
	
	public static var daGameCrashed:Bool = false;
	public static var GalleryCanSkip:Bool = false;
	public static var firstLaunchMenusWas:Array<String> = [''];
	public static var youSawSoundTestCutscene:Bool = false;
	
	public static var cutsceneYouSaw:Array<String> = []; 
	public static var showCutscene:Array<String> = ['you-cant-run-encore', 'fatality-encore', 'ugly', 'soulless', 'fight-or-flight', 'critical-error']; 
	public static var songsHaveCutsceneCheckbox:Array<String> = ['you-cant-run-encore', 'fatality-encore', 'ugly', 'soulless', 'fight-or-flight', 'critical-error']; 
	
	public static var volMuted:Bool = false;
	public static var volVolume:Float = 1;
	
	public static var Language:String = 'English';
	
	public static var arrowsSkinNum:Int = 0;
	public static var arrowsSplashNum:Int = 0;
	public static var arrowsColorNumLeft:Int = 0;
	public static var arrowsColorNumDown:Int = 0;
	public static var arrowsColorNumUp:Int = 0;
	public static var arrowsColorNumRight:Int = 0;
	public static var arrowSkin:String = 'NOTE_assets';
	public static var arrowSplash:String = 'noteSplashes';
	public static var arrowColorsRGB:Bool = false;
	public static var boughtSkin:Array<Int> = [];
	public static var boughtSplash:Array<Int> = [];
	public static var boughtColor:Array<Int> = [];
	public static var earnedRings:Array<String> = [];
	public static var RingsAmount:Int = 0;

	public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],
		'note_ring'		=> [SPACE, NONE],
		
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
	}

	public static function saveSettings() {
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.noteSplashes = noteSplashes;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.framerate = framerate;
		//FlxG.save.data.cursing = cursing;
		//FlxG.save.data.violence = violence;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.imagesPersist = imagesPersist;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.scoreZoom = scoreZoom;
		FlxG.save.data.noReset = noReset;
		FlxG.save.data.healthBarAlpha = healthBarAlpha;
		FlxG.save.data.comboOffset = comboOffset;
		FlxG.save.data.achievementsMap = Achievements.achievementsMap;
		FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;

		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.sickWindow = sickWindow;
		FlxG.save.data.goodWindow = goodWindow;
		FlxG.save.data.badWindow = badWindow;
		FlxG.save.data.safeFrames = safeFrames;
		FlxG.save.data.gameplaySettings = gameplaySettings;
		FlxG.save.data.controllerMode = controllerMode;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		
		FlxG.save.data.GPUCaching = GPUCaching;
		FlxG.save.data.Optimization = Optimization;
		FlxG.save.data.PotatoOptimization = PotatoOptimization;
		FlxG.save.data.ClassicChartEditor = ClassicChartEditor;
		FlxG.save.data.gore = gore;
		FlxG.save.data.space = space;
		FlxG.save.data.isvpad = isvpad;
		FlxG.save.data.LogoStyle = LogoStyle;
		FlxG.save.data.SoundTestUnlocked = SoundTestUnlocked;
		FlxG.save.data.EncoreUnlocked = EncoreUnlocked;
		FlxG.save.data.ExtrasMathSolved = ExtrasMathSolved;
		FlxG.save.data.storyProgressExe = storyProgressExe;
		FlxG.save.data.storyProgressAlt = storyProgressAlt;
		FlxG.save.data.ShowExtrasCode = ShowExtrasCode;
		FlxG.save.data.Shaders = Shaders;
		FlxG.save.data.BFEncoreSkin = BFEncoreSkin;
		FlxG.save.data.GFEncoreSkin = GFEncoreSkin;
		FlxG.save.data.BFSkin = BFSkin;
		FlxG.save.data.GFSkin = GFSkin;
		FlxG.save.data.BFEncoreVerSkin = BFEncoreVerSkin;
		FlxG.save.data.BFVerSkin = BFVerSkin;
		FlxG.save.data.StartVideo = StartVideo;
		FlxG.save.data.StartVideoSaw = StartVideoSaw;
		FlxG.save.data.BarsColor = BarsColor;
		FlxG.save.data.TrophiesUnlocked = TrophiesUnlocked;
		FlxG.save.data.TrophiesUnlockedRN = TrophiesUnlockedRN;
		FlxG.save.data.charactersUnlocked = charactersUnlocked;
		FlxG.save.data.TrophieSelected = TrophieSelected;
		FlxG.save.data.SongsCompleted = SongsCompleted;
		FlxG.save.data.SongsCompletedRN = SongsCompletedRN;
		FlxG.save.data.SkinsUnlockedRN = SkinsUnlockedRN;
		FlxG.save.data.SkinsUnlocked = SkinsUnlocked;
		FlxG.save.data.vineboom = vineboom;
		FlxG.save.data.MainMenuFPSBarX = MainMenuFPSBarX;
		FlxG.save.data.UnlockedMenuArts = UnlockedMenuArts;
		FlxG.save.data.lastMenuArt = lastMenuArt;
		FlxG.save.data.UnlockedGalleryVideos = UnlockedGalleryVideos;
		FlxG.save.data.UnlockedEndings = UnlockedEndings;
		FlxG.save.data.daGameCrashed = daGameCrashed;
		FlxG.save.data.VisibleMouse = VisibleMouse;
		FlxG.save.data.UnlockedMouses = UnlockedMouses;
		FlxG.save.data.Mouses = Mouses;
		FlxG.save.data.SelectedMouse = SelectedMouse;
		FlxG.save.data.animatedMouse = animatedMouse;
		FlxG.save.data.GalleryCanSkip = GalleryCanSkip;
		FlxG.save.data.firstLaunchMenusWas = firstLaunchMenusWas;
		FlxG.save.data.youSawSoundTestCutscene = youSawSoundTestCutscene;
		FlxG.save.data.cutsceneYouSaw = cutsceneYouSaw;
		FlxG.save.data.showCutscene = showCutscene;
		FlxG.save.data.songsHaveCutsceneCheckbox = songsHaveCutsceneCheckbox;
	
		FlxG.save.data.volMuted = volMuted;
		FlxG.save.data.volVolume = volVolume;
		
		FlxG.save.data.Language = Language;
	
		FlxG.save.data.arrowsSkinNum = arrowsSkinNum;
		FlxG.save.data.arrowsSplashNum = arrowsSplashNum;
		FlxG.save.data.arrowsColorNumLeft = arrowsColorNumLeft;
		FlxG.save.data.arrowsColorNumDown = arrowsColorNumDown;
		FlxG.save.data.arrowsColorNumUp = arrowsColorNumUp;
		FlxG.save.data.arrowsColorNumRight = arrowsColorNumRight;
		FlxG.save.data.arrowSkin = arrowSkin;
		FlxG.save.data.arrowSplash = arrowSplash;
		FlxG.save.data.arrowColorsRGB = arrowColorsRGB;
		FlxG.save.data.boughtSkin = boughtSkin;
		FlxG.save.data.boughtSplash = boughtSplash;
		FlxG.save.data.boughtColor = boughtColor;
		FlxG.save.data.earnedRings = earnedRings;
		FlxG.save.data.RingsAmount = RingsAmount;
	
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		if(FlxG.save.data.downScroll != null) {
			downScroll = FlxG.save.data.downScroll;
		}
		if(FlxG.save.data.middleScroll != null) {
			middleScroll = FlxG.save.data.middleScroll;
		}
		if(FlxG.save.data.showFPS != null) {
			showFPS = FlxG.save.data.showFPS;
			if(Main.fpsVar != null) {
				Main.fpsVar.visible = showFPS;
			}
		}
		if(FlxG.save.data.flashing != null) {
			flashing = FlxG.save.data.flashing;
		}
		if(FlxG.save.data.globalAntialiasing != null) {
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if(FlxG.save.data.noteSplashes != null) {
			noteSplashes = FlxG.save.data.noteSplashes;
		}
		if(FlxG.save.data.lowQuality != null) {
			lowQuality = FlxG.save.data.lowQuality;
		}
		if(FlxG.save.data.framerate != null) {
			framerate = FlxG.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		/*if(FlxG.save.data.cursing != null) {
			cursing = FlxG.save.data.cursing;
		}
		if(FlxG.save.data.violence != null) {
			violence = FlxG.save.data.violence;
		}*/
		if(FlxG.save.data.camZooms != null) {
			camZooms = FlxG.save.data.camZooms;
		}
		if(FlxG.save.data.hideHud != null) {
			hideHud = FlxG.save.data.hideHud;
		}
		if(FlxG.save.data.noteOffset != null) {
			noteOffset = FlxG.save.data.noteOffset;
		}
		if(FlxG.save.data.arrowHSV != null) {
			arrowHSV = FlxG.save.data.arrowHSV;
		}
		if(FlxG.save.data.ghostTapping != null) {
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if(FlxG.save.data.timeBarType != null) {
			timeBarType = FlxG.save.data.timeBarType;
		}
		if(FlxG.save.data.scoreZoom != null) {
			scoreZoom = FlxG.save.data.scoreZoom;
		}
		if(FlxG.save.data.noReset != null) {
			noReset = FlxG.save.data.noReset;
		}
		if(FlxG.save.data.healthBarAlpha != null) {
			healthBarAlpha = FlxG.save.data.healthBarAlpha;
		}
		if(FlxG.save.data.comboOffset != null) {
			comboOffset = FlxG.save.data.comboOffset;
		}
		
		if(FlxG.save.data.ratingOffset != null) {
			ratingOffset = FlxG.save.data.ratingOffset;
		}
		if(FlxG.save.data.sickWindow != null) {
			sickWindow = FlxG.save.data.sickWindow;
		}
		if(FlxG.save.data.goodWindow != null) {
			goodWindow = FlxG.save.data.goodWindow;
		}
		if(FlxG.save.data.badWindow != null) {
			badWindow = FlxG.save.data.badWindow;
		}
		if(FlxG.save.data.safeFrames != null) {
			safeFrames = FlxG.save.data.safeFrames;
		}
		if(FlxG.save.data.controllerMode != null) {
			controllerMode = FlxG.save.data.controllerMode;
		}
		if(FlxG.save.data.hitsoundVolume != null) {
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		}
		if(FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}
		
		// flixel automatically saves your volume!
		if(FlxG.save.data.volMuted != null)
		{
			volMuted = FlxG.save.data.volMuted;
		}
		if (FlxG.save.data.volVolume != null)
		{
			volVolume = FlxG.save.data.volVolume;
		}
		
		if (FlxG.save.data.Language != null)
		{
			Language = FlxG.save.data.Language;
		}
		if(FlxG.save.data.GPUCaching != null) {
			GPUCaching = FlxG.save.data.GPUCaching;
		}
		if(FlxG.save.data.Optimization != null) {
			Optimization = FlxG.save.data.Optimization;
		}
		if(FlxG.save.data.PotatoOptimization != null) {
			PotatoOptimization = FlxG.save.data.PotatoOptimization;
		}
		if(FlxG.save.data.ClassicChartEditor != null) {
			ClassicChartEditor = FlxG.save.data.ClassicChartEditor;
		}
		if(FlxG.save.data.gore != null) {
			gore = FlxG.save.data.gore;
		}
		if (FlxG.save.data.space != null)
		{
			space = FlxG.save.data.space;
		}
		if (FlxG.save.data.isvpad != null)
		{
			isvpad = FlxG.save.data.isvpad;
		}
		if(FlxG.save.data.LogoStyle != null) {
			LogoStyle = FlxG.save.data.LogoStyle;
		}
		if(FlxG.save.data.SoundTestUnlocked != null) {
			SoundTestUnlocked = FlxG.save.data.SoundTestUnlocked;
		}
		if(FlxG.save.data.EncoreUnlocked != null) {
			EncoreUnlocked = FlxG.save.data.EncoreUnlocked;
		}
		if(FlxG.save.data.ExtrasMathSolved != null) {
			ExtrasMathSolved = FlxG.save.data.ExtrasMathSolved;
		}
		if(FlxG.save.data.storyProgressExe != null) {
			storyProgressExe = FlxG.save.data.storyProgressExe;
		}
		if(FlxG.save.data.storyProgressAlt != null) {
			storyProgressAlt = FlxG.save.data.storyProgressAlt;
		}
		if(FlxG.save.data.ShowExtrasCode != null) {
			ShowExtrasCode = FlxG.save.data.ShowExtrasCode;
		}
		if(FlxG.save.data.Shaders != null) {
			Shaders = FlxG.save.data.Shaders;
		}
		if(FlxG.save.data.BFEncoreSkin != null) {
			BFEncoreSkin = FlxG.save.data.BFEncoreSkin;
		}
		if(FlxG.save.data.GFEncoreSkin != null) {
			GFEncoreSkin = FlxG.save.data.GFEncoreSkin;
		}
		if(FlxG.save.data.BFSkin != null) {
			BFSkin = FlxG.save.data.BFSkin;
		}
		if(FlxG.save.data.GFSkin != null) {
			GFSkin = FlxG.save.data.GFSkin;
		}
		if(FlxG.save.data.BFEncoreVerSkin != null) {
			BFEncoreVerSkin = FlxG.save.data.BFEncoreVerSkin;
		}
		if(FlxG.save.data.BFVerSkin != null) {
			BFVerSkin = FlxG.save.data.BFVerSkin;
		}
		if(FlxG.save.data.StartVideo != null) {
			StartVideo = FlxG.save.data.StartVideo;
		}
		if(FlxG.save.data.StartVideoSaw != null) {
			StartVideoSaw = FlxG.save.data.StartVideoSaw;
		}
		if(FlxG.save.data.BarsColor != null) {
			BarsColor = FlxG.save.data.BarsColor;
		}
		if(FlxG.save.data.TrophiesUnlocked != null) {
			TrophiesUnlocked = FlxG.save.data.TrophiesUnlocked;
		}
		if(FlxG.save.data.TrophiesUnlockedRN != null) {
			TrophiesUnlockedRN = FlxG.save.data.TrophiesUnlockedRN;
		}
		if(FlxG.save.data.charactersUnlocked != null) {
			charactersUnlocked = FlxG.save.data.charactersUnlocked;
		}
		if(FlxG.save.data.TrophieSelected != null) {
			TrophieSelected = FlxG.save.data.TrophieSelected;
		}
		if(FlxG.save.data.SongsCompleted != null) {
			SongsCompleted = FlxG.save.data.SongsCompleted;
		}
		if(FlxG.save.data.SongsCompletedRN != null) {
			SongsCompletedRN = FlxG.save.data.SongsCompletedRN;
		}
		if(FlxG.save.data.SkinsUnlockedRN != null) {
			SkinsUnlockedRN = FlxG.save.data.SkinsUnlockedRN;
		}
		if(FlxG.save.data.SkinsUnlocked != null) {
			SkinsUnlocked = FlxG.save.data.SkinsUnlocked;
		}
		if(FlxG.save.data.UnlockedMenuArts != null) {
			UnlockedMenuArts = FlxG.save.data.UnlockedMenuArts;
		}
		if(FlxG.save.data.lastMenuArt != null) {
			lastMenuArt = FlxG.save.data.lastMenuArt;
		}
		if(FlxG.save.data.UnlockedGalleryVideos != null) {
			UnlockedGalleryVideos = FlxG.save.data.UnlockedGalleryVideos;
		}
		if(FlxG.save.data.UnlockedEndings != null) {
			UnlockedEndings = FlxG.save.data.UnlockedEndings;
		}
		if(FlxG.save.data.vineboom != null) {
			vineboom = FlxG.save.data.vineboom;
		}
		if(FlxG.save.data.MainMenuFPSBarX != null) {
			MainMenuFPSBarX = FlxG.save.data.MainMenuFPSBarX;
		}
		if(FlxG.save.data.daGameCrashed != null) {
			daGameCrashed = FlxG.save.data.daGameCrashed;
		}
		if(FlxG.save.data.VisibleMouse != null) {
			VisibleMouse = FlxG.save.data.VisibleMouse;
		}
		if(FlxG.save.data.GalleryCanSkip != null) {
			GalleryCanSkip = FlxG.save.data.GalleryCanSkip;
		}
		if(FlxG.save.data.UnlockedMouses != null) {
			UnlockedMouses = FlxG.save.data.UnlockedMouses;
		}
		if(FlxG.save.data.Mouses != null) {
			Mouses = FlxG.save.data.Mouses;
		}
		if(FlxG.save.data.SelectedMouse != null) {
			SelectedMouse = FlxG.save.data.SelectedMouse;
		}
		if(FlxG.save.data.animatedMouse != null) {
			animatedMouse = FlxG.save.data.animatedMouse;
		}
		if(FlxG.save.data.firstLaunchMenusWas != null) {
			firstLaunchMenusWas = FlxG.save.data.firstLaunchMenusWas;
		}
		if(FlxG.save.data.youSawSoundTestCutscene != null) {
			youSawSoundTestCutscene = FlxG.save.data.youSawSoundTestCutscene;
		}
		if(FlxG.save.data.cutsceneYouSaw != null) {
			cutsceneYouSaw = FlxG.save.data.cutsceneYouSaw;
		}
		if(FlxG.save.data.showCutscene != null) {
			showCutscene = FlxG.save.data.showCutscene;
		}
		if(FlxG.save.data.songsHaveCutsceneCheckbox != null) {
			songsHaveCutsceneCheckbox = FlxG.save.data.songsHaveCutsceneCheckbox;
		}

		if(FlxG.save.data.arrowsSkinNum != null)
			arrowsSkinNum = FlxG.save.data.arrowsSkinNum;
		if(FlxG.save.data.arrowsSplashNum != null)
			arrowsSplashNum = FlxG.save.data.arrowsSplashNum;
		if(FlxG.save.data.arrowsColorNumLeft != null)
			arrowsColorNumLeft = FlxG.save.data.arrowsColorNumLeft;
		if(FlxG.save.data.arrowsColorNumDown != null)
			arrowsColorNumDown = FlxG.save.data.arrowsColorNumDown;
		if(FlxG.save.data.arrowsColorNumUp != null)
			arrowsColorNumUp = FlxG.save.data.arrowsColorNumUp;
		if(FlxG.save.data.arrowsColorNumRight != null)
			arrowsColorNumRight = FlxG.save.data.arrowsColorNumRight;
		if(FlxG.save.data.arrowSkin != null)
			arrowSkin = FlxG.save.data.arrowSkin;
		if(FlxG.save.data.arrowSplash != null)
			arrowSplash = FlxG.save.data.arrowSplash;
		if(FlxG.save.data.arrowColorsRGB != null)
			arrowColorsRGB = FlxG.save.data.arrowColorsRGB;
		if(FlxG.save.data.boughtSkin != null)
			boughtSkin = FlxG.save.data.boughtSkin;
		if(FlxG.save.data.boughtSplash != null)
			boughtSplash = FlxG.save.data.boughtSplash;
		if(FlxG.save.data.boughtColor != null)
			boughtColor = FlxG.save.data.boughtColor;
		if(FlxG.save.data.earnedRings != null)
			earnedRings = FlxG.save.data.earnedRings;
		if(FlxG.save.data.RingsAmount != null)
			RingsAmount = FlxG.save.data.RingsAmount;

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99');
		if(save != null && save.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		Cutscenes.muteKeys = copyKey(keyBinds.get('volume_mute'));
		Cutscenes.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		Cutscenes.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = Cutscenes.muteKeys;
		FlxG.sound.volumeDownKeys = Cutscenes.volumeDownKeys;
		FlxG.sound.volumeUpKeys = Cutscenes.volumeUpKeys;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
