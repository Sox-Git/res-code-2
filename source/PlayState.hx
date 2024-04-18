package;

#if !flash 
import flixel.addons.display.FlxRuntimeShader;
#end
import flixel.graphics.FlxGraphic;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.display.FlxTiledSprite;
import flixel.effects.FlxFlicker;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.chainable.FlxGlitchEffect;
import flixel.addons.plugin.screengrab.FlxScreenGrab;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;
import editors.ChartingState;
import editors.BuggyChartingState;
import editors.CharacterEditorState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import Note.EventNote;
import openfl.events.KeyboardEvent;
import flixel.util.FlxSave;
import Achievements;
import StageData;
import FunkinLua;
import DialogueBoxPsych;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
import openfl.filters.ShaderFilter;
import openfl.display.Shader;
import flixel.system.scaleModes.StageSizeScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.math.FlxRandom;
import openfl.system.Capabilities;
import openfl.display.BitmapData;
import openfl.display.Stage;
import flixel.addons.display.FlxBackdrop;
import lime.app.Application;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tweens.FlxTween.FlxTweenManager;

import lime.app.Application;
import lime.graphics.RenderContext;
import lime.ui.MouseButton;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.ui.Window;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.display.Sprite;
import openfl.utils.Assets;
import lime.graphics.Image;
import openfl.filters.DisplacementMapFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Point;
import openfl.filters.DisplacementMapFilterMode;
#if mobile
import mobile.MobileControls;
#end
#if windows
import WinPaths;
#end

#if VIDEOS_ALLOWED
import vlc.MP4Handler;
import vlc.MP4Sprite;
#end

#if desktop
import Discord.DiscordClient;
#end
#if sys
import sys.FileSystem;
#end

import shaders.ChromaticAbberation;
import shaders.ColorSwap;
import shaders.DistortGlitchShader;
import shaders.GlitchShader.Fuck;
import shaders.GlitchShader.GlitchShaderA;
import shaders.GlitchShader.GlitchShaderB;
import shaders.BunchOfShittyShaders;
import shaders.StaticShader;
import shaders.VVCCRR;
import shaders.VCRDistortionShader;
import shaders.WiggleEffect;
import shaders.WiggleEffect.WiggleEffectType;
import shaders.Greyscale;
import shaders.VCRWNB;

using StringTools;

typedef BasicSpeedChange = {
	var time:Float;
	var mult:Float;
}

class PlayState extends MusicBeatState
{
	public static var STRUM_X = 42;
	public static var STRUM_X_MIDDLESCROLL = -278;
	
	public var center:FlxPoint;

	public static var ratingStuff:Array<Dynamic> = [
		['JUST DIE!', 0.2], //From 0% to 19%
		['Shit', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Bruh', 0.6], //From 50% to 59%
		['Meh', 0.69], //From 60% to 68%
		['Nice', 0.7], //69%
		['Good', 0.8], //From 70% to 79%
		['Great', 0.9], //From 80% to 89%
		['Sick!', 1], //From 90% to 99%
		['Perfect!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];
	public var piss:Array<FlxTween> = [];
	//event variables
	private var isCameraOnForcedPos:Bool = false;
	#if (haxe >= "4.0.0")
	public var boyfriendMap:Map<String, Boyfriend> = new Map();
	public var dadMap:Map<String, Character> = new Map();
	public var gfMap:Map<String, Character> = new Map();
	public var variables:Map<String, Dynamic> = new Map();
	public var modchartTweens:Map<String, FlxTween> = new Map<String, FlxTween>();
	public var modchartSprites:Map<String, ModchartSprite> = new Map<String, ModchartSprite>();
	public var modchartTimers:Map<String, FlxTimer> = new Map<String, FlxTimer>();
	public var modchartSounds:Map<String, FlxSound> = new Map<String, FlxSound>();
	public var modchartTexts:Map<String, ModchartText> = new Map<String, ModchartText>();
	public var modchartSaves:Map<String, FlxSave> = new Map<String, FlxSave>();
	#else
	public var boyfriendMap:Map<String, Boyfriend> = new Map<String, Boyfriend>();
	public var dadMap:Map<String, Character> = new Map<String, Character>();
	public var gfMap:Map<String, Character> = new Map<String, Character>();
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();
	public var modchartTweens:Map<String, FlxTween> = new Map();
	public var modchartSprites:Map<String, ModchartSprite> = new Map();
	public var modchartTimers:Map<String, FlxTimer> = new Map();
	public var modchartSounds:Map<String, FlxSound> = new Map();
	public var modchartTexts:Map<String, ModchartText> = new Map();
	public var modchartSaves:Map<String, FlxSave> = new Map();
	#end

	public var BF_X:Float = 770;
	public var BF_Y:Float = 100;
	public var DAD_X:Float = 100;
	public var DAD_Y:Float = 100;
	public var GF_X:Float = 400;
	public var GF_Y:Float = 130;

	public var songSpeedTween:FlxTween;
	public var songSpeed(default, set):Float = 1;
	public var songSpeedType:String = "multiplicative";
	public var noteKillOffset:Float = 350;
	
	public var boyfriendGroup:FlxSpriteGroup;
	public var dadGroup:FlxSpriteGroup;
	public var gfGroup:FlxSpriteGroup;
	public static var curStage:String = '';
	public static var isPixelStage:Bool = false;
	public static var SONG:SwagSong = null;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;

	public var vocals:FlxSound;

	public var dad:Character = null;
	public var gf:Character = null;
	public var boyfriend:Boyfriend = null;

	public var notes:FlxTypedGroup<Note>;
	public var unspawnNotes:Array<Note> = [];
	public var eventNotes:Array<EventNote> = [];

	private var strumLine:FlxSprite;

	//Handles the new epic mega sexy cam code that i've done
	private var camFollow:FlxPoint;
	public var camFollowPos:FlxObject;
	private static var prevCamFollow:FlxPoint;
	private static var prevCamFollowPos:FlxObject;

	public var strumLineNotes:FlxTypedGroup<StrumNote>;
	public var opponentStrums:FlxTypedGroup<StrumNote>;
	public var playerStrums:FlxTypedGroup<StrumNote>;
	public var grpNoteSplashes:FlxTypedGroup<NoteSplash>;

	public var camZooming:Bool = false;
	private var curSong:String = "";

	public var gfSpeed:Int = 1;
	public var health:Float = 1;
	public var combo:Int = 0;

	private var healthBarBG:AttachedSprite;
	public var healthBar:FlxBar;
	public var songPercent:Float = 0;

	private var timeBarBG:AttachedSprite;
	public var timeBar:FlxBar;
	
	public var sicks:Int = 0;
	public var goods:Int = 0;
	public var bads:Int = 0;
	public var shits:Int = 0;
	
	private var generatedMusic:Bool = false;
	public var endingSong:Bool = false;
	public var startingSong:Bool = false;
	private var updateTime:Bool = true;
	public static var changedDifficulty:Bool = false;
	public static var chartingMode:Bool = false;

	//Gameplay settings
	public var healthGain:Float = 1;
	public var healthLoss:Float = 1;
	public var instakillOnMiss:Bool = false;
	public var cpuControlled:Bool = false;
	public var practiceMode:Bool = false;

	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;
	public var camHUD:FlxCamera;
	public var camOverlay:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;
	public var cameraSpeed:Float = 1;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];
	var dialogueJson:DialogueFile = null;

	var halloweenBG:BGSprite;
	var halloweenWhite:BGSprite;

	var phillyCityLights:FlxTypedGroup<BGSprite>;
	var phillyTrain:BGSprite;
	var blammedLightsBlack:ModchartSprite;
	var blammedLightsBlackTween:FlxTween;
	var phillyCityLightsEvent:FlxTypedGroup<BGSprite>;
	var phillyCityLightsEventTween:FlxTween;
	var trainSound:FlxSound;

	var limoKillingState:Int = 0;
	var limo:BGSprite;
	var limoMetalPole:BGSprite;
	var limoLight:BGSprite;
	var limoCorpse:BGSprite;
	var limoCorpseTwo:BGSprite;
	var bgLimo:BGSprite;
	var grpLimoParticles:FlxTypedGroup<BGSprite>;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:BGSprite;

	var upperBoppers:BGSprite;
	var bottomBoppers:BGSprite;
	var santa:BGSprite;
	var heyTimer:Float;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();
	var bgGhouls:BGSprite;

	public var songScore:Int = 0;
	public var songHits:Int = 0;
	public var songMisses:Int = 0;
	public var scoreTxt:FlxText;
	var timeTxt:FlxText;
	var scoreTxtTween:FlxTween;

	public static var campaignScore:Int = 0;
	public static var campaignMisses:Int = 0;
	public static var seenCutscene:Bool = false;
	public static var deathCounter:Int = 0;

	public var defaultCamZoom:Float = 1.05;

	// how big to stretch the pixel art assets
	public static var daPixelZoom:Float = 6;
	private var singAnimations:Array<String> = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

	public var inCutscene:Bool = false;
	public var skipCountdown:Bool = false;
	var songLength:Float = 0;

	public var boyfriendCameraOffset:Array<Float> = null;
	public var opponentCameraOffset:Array<Float> = null;
	public var girlfriendCameraOffset:Array<Float> = null;

	#if desktop
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	//Achievement shit
	var keysPressed:Array<Bool> = [];
	var boyfriendIdleTime:Float = 0.0;
	var boyfriendIdled:Bool = false;

	// Lua shit
	public static var instance:PlayState;
	public var luaArray:Array<FunkinLua> = [];
	private var luaDebugGroup:FlxTypedGroup<DebugLuaText>;
	public var introSoundsSuffix:String = '';

	// Debug buttons
	private var debugKeysChart:Array<FlxKey>;
	private var debugKeysCharacter:Array<FlxKey>;
	
	// Less laggy controls
	private var keysArray:Array<Dynamic>;
	
	// Sonic.exe 3.0 Code
	public var shaderUpdates:Array<Float->Void> = [];
	public var camGameShaders:Array<ShaderEffect> = [];
	public var camHUDShaders:Array<ShaderEffect> = [];
	public var camOtherShaders:Array<ShaderEffect> = [];

	public static var isEncore:Bool = false;
	public static var isStory:Bool = false;
	public static var isExtras:Bool = false;
	public static var isSound:Bool = false;
	public static var isFreeplay:Bool = false;
	public var showCountdown:Bool = false;
	var creditsText:FlxTypedGroup<FlxText>;
	var creditoText:FlxText;
	var box:FlxSprite; 
	
	var canDodge:Bool = false;
	var dodging:Bool = false;
	var ezTrail:FlxTrail;
	
	// Other Things
	public static var isFixedAspectRatio:Bool = false;
	public var superZoomShit:Bool = false;
	public var supersuperZoomShit:Bool = false;
	public var weedSpinningTime:Bool = false;
	var WeedShit:Bool = false;
	public var pixelNoteGenesis:Bool = false;
	public var GameOverCameraMove:Bool = true;
	var scoreRandom:Bool = false;
	public var wowZoomin:Bool = false;
	public var holyFuckStopZoomin:Bool = false;
	var curShader:ShaderFilter;
	var weedVis:ColorSwap;
	var GFIconChange:Bool = false;
	var GFandDad:Bool = true;
	var HPBarAlreadyChanged:Bool = false;
	var HPBarColor:String = 'dad';
	var bgSkin:String = 'hpR';
	var bgTBSkin:String = 'tbR';
	var TimeBarColorOne:FlxColor = 0xFF000000;
	var TimeBarColorTwo:FlxColor = FlxColor.RED;
	public var AnimatedDadIcon:Bool = false;
	var timeBarBGBG:AttachedSprite;
	var dodgething:FlxSprite;
	var anticheat:Bool = true;
	var discordSongPic:Bool = true;
	var LockedChartEditor:Bool = false;
	var FEHPThing:Int = 0;
	var ShitO:Float = 4;
	var ShitT:Float = 8;
	var iconOffset:Int;
	var caShader:ChromaticAbberation;
	var RedVGEvent:FlxSprite;
	
	// Chaos
	var wall:FlxSprite;
	var floor:FlxSprite;
	var fleetwaybgshit:FlxSprite;
	var emeraldbeam:FlxSprite;
	var emeraldbeamyellow:FlxSprite;
	var emeralds:FlxSprite;
	var thechamber:FlxSprite;
	var pebles:FlxSprite;
	var porker:FlxSprite;
	var chamberFront:FlxSprite;
	public static var ChaosCutscene:Bool = true;
	
	// Majin
	var fgmajin:BGSprite;
	var fgmajin2:BGSprite;
	public var majinScrollin:FlxTiledSprite;
	public var EndeavorsOGBG:FlxSpriteGroup;
	public var EndeavorsOGFG:FlxSpriteGroup;
	
	// Too Slow / You Cant Run / Triple Trouble
	var fgTrees:BGSprite;
	var fgTree1:BGSprite;
	var fgTree2:BGSprite;
	var p3staticbg:FlxSprite;
	var backtreesXeno:BGSprite;
	var grassXeno:BGSprite;
	var daNoteStatic:FlxSprite;
	var vg:FlxSprite;
	var fgTree1Xeno:BGSprite;
	var fgTree2Xeno:BGSprite;
	var daJumpscare:FlxSprite;
	var treesfront:BGSprite;
	var topoverlay:BGSprite;
	
	// Sunky
	var cereal:FlxSprite;
	var munch:FlxSprite;
	var pose:FlxSprite;
	var sunker:FlxSprite;
	var aspectRatio:Bool = false;
	var spoOoOoOky:FlxSprite;
	public var sunkerTimebarFuckery:Bool = false;
	public var sunkerTimebarNumber:Int;

	// Needlemouse
	var needleSky:BGSprite;
	var needleMoutains:BGSprite;
	var needleRuins:BGSprite;
	var needleBuildings:BGSprite;
	var conkCreet:BGSprite;
	var needleFg:FlxSprite;
	public var dad2:Character;
	public var dad2Group:FlxSpriteGroup;
	public static var VHSui:Bool = false;
	public var vcrShader:VVCCRR;
	var darkthing:FlxSprite;
	var irlTxt:FlxText;
	
	// PixShader
	var pixShader:VCRWNB;
	
	// Needlemouse P2
	var needleSkyZERO:BGSprite;
	var needleSkyONE:BGSprite;
	var needleSkyTWO:BGSprite;
	var needleSkyTHREE:BGSprite;
	var needleMoutainsZERO:BGSprite;
	var needleMoutainsONE:BGSprite;
	var needleMoutainsTWO:BGSprite;
	var needleMoutainsTHREE:BGSprite;
	var needleRuinsZERO:BGSprite;
	var needleRuinsONE:BGSprite;
	var needleRuinsTWO:BGSprite;
	var needleBuildingsZERO:BGSprite;
	var needleBuildingsONE:BGSprite;
	var needleBuildingsTWO:BGSprite;
	var needleFgZERO:FlxSprite;
	var needleFgONE:FlxSprite;
	var needleFgTWO:FlxSprite;
	var needleFgTHREE:FlxSprite;
	
	// Fatality
	var base:FlxSprite;
	var domain2:FlxSprite;
	var domain:FlxSprite;
	var trueFatal:FlxSprite;
	var daStatix:BGSprite;
	public var fatalUI = false;
	public var FatalEncoreFiles:FlxTypedSpriteGroup<FlxSprite>;
	public var FatalEncoreFilesGlitch:FlxTypedSpriteGroup<FlxSprite>;
	public var FatalEncoreCorruptedFilesALL:FlxTypedSpriteGroup<FlxSprite>;
	public var FatalEncoreFileGotCorrupted:Array<Int> = [];
	public var BackgroundPC:FlxSprite;
	public var FatalEncoreTray:FlxSprite;
	public var FatalEncoreTrayIcons:FlxSprite;
	public var FatalEncorePCDay:FlxText;
	public var FatalEncorePCTime:FlxText;
	public var FatalEncoreUsername:FlxText;
	public var UseWindowsDesktopFiles:Bool = #if windows true; #else false; #end
	public var NonRealDesktopIcons:Array<String> = ["Geometry Dash", "Dare Devil", "Illegal Instruction", "Parallax", "File Extention", "Steam", "Discord", "Bugs in code", "My Passwords", "Plans", "DO NOT OPEN", "My Projects", "Restoration", "FNF'", "Sonic.exe"];
	
	// Fatality Mechanic
	var windowX:Float = Lib.application.window.x;
	var windowY:Float = Lib.application.window.y;
	var Xamount:Float = 0;
	var Yamount:Float = 0;
	var IsWindowMoving:Bool = false;
	var IsWindowMoving2:Bool = false;
	var errorRandom:FlxRandom = new FlxRandom(666);
	var FatalStatic:FlxSprite;
	
	// Prey
	var stardustBgPixel:FlxTiledSprite;
	var stardustFloorPixel:FlxTiledSprite;
	var stardustFurnace:FlxSprite;
	
	// Starved
	var hungryManJackTime:Int = 0;
	
	// Intro
	var blackFuck:FlxSprite;
	var blackFuck2:FlxSprite;
	var whiteFuck:FlxSprite;
	var startBG:FlxSprite;
	var startCircle:FlxSprite;
	var startText:FlxSprite;
	
	// Cutscene Shit
	var topBar:FlxSprite;
	var bottomBar:FlxSprite;
	
	// Fear Mechanic
	var fearUi:FlxSprite;
	var fearUiBg:FlxSprite;
	var fearTween:FlxTween;
	var fearTimer:FlxTimer;
	public var fearNo:Float = 0;
	public var fearBar:FlxBar;
	public static var isFear:Bool = false;
	var doFearCheck = false;
	var fearNum:FlxText;
	
	// Coldsteel bruh
	var SpinAmount:Float = 0;
	var IsNoteSpinning:Bool = false;
	var isPlayersSpinning:Bool = false;
	
	// Healthbar Flip
	public var healthbarval:Float = 1;
	var bfIsLeft:Bool = false;
	
	// Curse
	var hexTimer:Float = 0;
	var hexes:Float = 0;
	var barbedWires:FlxTypedGroup<WireSprite>;
	var wireVignette:FlxSprite;
	
	// XTerion
	var xterionFloor:Floor;
	var xterionSky:BGSprite;
	
	// Hog & Scorched
	var staticlol:StaticShader;
	var staticlmao:StaticShader;
	var staticOverlay:ShaderFilter;
	var glitchThingy:DistortGlitchShader;
	var glitchOverlay:ShaderFilter;
	private var staticAlpha:Float = 1;
	
	var curShaderone:ShaderFilter;
	var curShadertwo:ShaderFilter;
	
	// Hog
	var hogBg:BGSprite;
	var hogMotain:BGSprite;
	var hogWaterFalls:FlxSprite;
	var hogFloor:FlxSprite;
	var hogLoops:FlxSprite;
	var hogTrees:BGSprite;
	var hogRocks:BGSprite;
	var hogOverlay:BGSprite;
	
	// Scorched
	var scorchedBg:BGSprite;
	var scorchedMotain:BGSprite;
	var scorchedWaterFalls:FlxSprite;
	var scorchedFloor:FlxSprite;
	var scorchedMonitor:FlxSprite;
	var scorchedHills:FlxSprite;
	var scorchedTrees:BGSprite;
	var scorchedRocks:BGSprite;
	
	var monitorCounter:Int = 0;
	var monitorAnims:Array<String> = ["fatal", "nmi", "needle", "starved", "idle"];
	
	var camGlitchShader:GlitchShaderB;
	var camFuckShader:Fuck;
	var camFuckFilter:ShaderFilter;
	var camGlitchFilter:ShaderFilter;
	
	// My Horizon - Our horizon Mechanic
	var healthMultiplier:Float = 1;
	var healthDrop:Float = 0;
	var dropTime:Float = 0;
	public var fucklesDrain:Float = 0;
	public var fucklesMode:Bool = false;
	public var drainMisses:Float = 0;

	// My Horizon
	var fucklesBGPixel:BGSprite;
	var fucklesFGPixel:BGSprite;
	var fucklesAmyBg:FlxSprite;
	var fucklesVectorBg:FlxSprite;
	var fucklesKnuxBg:FlxSprite;
	var fucklesEspioBg:FlxSprite;
	var fucklesCharmyBg:FlxSprite;
	var fucklesMightyBg:FlxSprite;
	var fucklesFuckedUpBg:FlxSprite;
	var fucklesFuckedUpFg:BGSprite;
	var fucklesBeats:Bool = true;
	
	//Our Horizon
	var horizonBg:FlxSprite;
	var horizonFloor:FlxSprite;
	var horizonTrees:FlxSprite;
	var horizonTrees2:FlxSprite;

	var horizonPurpur:FlxSprite;
	var horizonYellow:FlxSprite;
	var horizonRed:FlxSprite;
	
	var horizonAmy:FlxSprite;
	var horizonKnuckles:FlxSprite;
	var horizonEspio:FlxSprite;
	var horizonMighty:FlxSprite;
	var horizonCharmy:FlxSprite;
	var horizonVector:FlxSprite;
	
	// Sl4sh
	var slashBg:BGSprite;
	var slashFloor:BGSprite;
	var slashAssCracks:FlxSprite;
	var slashLava:FlxSprite;
	var slashBgPov:BGSprite;
	var slashFloorPov:BGSprite;
	var slashLavaPov:FlxSprite;
	var warning:FlxSprite;
	var MarStarBroBF:Bool = false;
	var MarPressed:Float = 0;
	var SlashSecondPart:Bool = false;
	
	// Fly Vars
	var flyTarg:Character;
	var flyState:String = '';
	var floaty:Float = 0;
	var floaty2:Float = 0;
	var tailscircle:String = '';
	
	// Ring
	var ringCounter:FlxSprite;
	var counterNum:FlxText;
	var cNum:Int = 0;
	var ballsinyojaws:Int = 0;
	var deezNuts:Array<Int> = [4, 5];
	var isRing:Bool = SONG.isRing;
	
	// SonicHUD
	public var sonicHUD:FlxSpriteGroup;
	public var scoreNumbers:Array<SonicNumber>=[];
	public var missNumbers:Array<SonicNumber>=[];
	public var minNumber:SonicNumber;
	public var secondNumberA:SonicNumber;
	public var secondNumberB:SonicNumber;
	public var millisecondNumberA:SonicNumber;
	public var millisecondNumberB:SonicNumber;
	
	// Faker
	var tentas:FlxSprite;
	var fakertransform:FlxSprite;
	var vgblack:FlxSprite;
	
	// Skin System
	public static var BFSkins:Bool = false;
	public static var GFSkins:Bool = false;
	public static var BFEncoreSkins:Bool = false;
	public static var GFEncoreSkins:Bool = false;
	
	// Chotix
	var hellBg:FlxSprite;
	
	// Godspeed
	var GSsky:FlxTiledSprite;
	var GSbbbg:FlxTiledSprite;
	var GSbbg:FlxTiledSprite;
	var GSbg:FlxTiledSprite;
	var GSplants:FlxTiledSprite;
	var Misses:FlxText;
	var RUN:FlxText;
	var Rating:FlxText;
	var MissesTween:FlxTween;
	var RUNTween:FlxTween;
	var RatingTween:FlxTween;
	var RunTextFlashSpeed:Int = 0;
	
	// Sunshine Encore
	var saturn:FlxSprite;
	var w = 550;
	var h = 550;
	
	// NormalCD
	private var metalTrail:FlxTrail;
	private var amyTrail:FlxTrail;
	private var normalTrail:FlxTrail;
	var soulGlassTime:Bool = false;
	var normalBg:FlxSprite;
	var normalFg:FlxSprite;
	var normalTv:FlxSprite;
	var normalVg:FlxSprite;
	var normalShadow:FlxSprite;
	var normalDoor:FlxSprite;
	var normalScreen:FlxSprite;
	var normalChars:FlxSprite;
	public var normalCharShit:Int;
	public var normalBool:Bool = false;

	public var noCamMove:Bool = false;
	public var offDownScroll:Bool = false;
	public var MechanicBFDie:Bool = false;
	public var SlashPressedSpace:Bool = false;
	
	// DevoidUI
	public var DevoidUIControl:FlxTypedSpriteGroup<FlxSprite>;
	public var DevoidUIControlIcons:FlxTypedSpriteGroup<FlxSprite>;
	var devoidTimeBarBG:FlxSprite;
	var devoidUIthing:FlxSprite;
	var devoidHPBar:FlxSprite;
	var devoidUIhpTxt:FlxText;
	var devoidUImissesTxt:FlxText;
	public static var devoidUI:Bool = false;
	var devoidHPvalue:Float = 0.5;
	
	// Xeno Encore UI
	public static var xenoEncUI:Bool = false;
	public static var xenoEncFix:Bool = false;
	public var xenoEncHP:FlxSprite;
	public var xenoEncUIthing:FlxSprite;
	public var xenoEncMissesTxt:FlxText;
	var xenoEncPercentOfRating:Float = 0;
	public var xenoEncIconP1:HealthIcon;
	public var xenoEncIconP2:HealthIcon;
	public var xenoEncHealthBar:FlxBar;
	
	//Majin count
	var MajinCountThree:FlxSprite;
	var MajinCountTwo:FlxSprite;
	var MajinCountOne:FlxSprite;
	var MajinCountGo:FlxSprite;
	
	//Ghost Double Note
	var noteRows:Array<Array<Array<Note>>> = [[],[]];
	public var doubleNoteGhost:Bool = false;
	var curBF:String;
	var curDAD:String;
	var curGF:String;
	
	// Sonic Hud
	public var sonicHUDSongs:Array<String> = [
		"prey",
		"you-cant-run",
		"final-escape",
		"you-cant-run-encore",
		"our-horizon",
		"my-horizon",
		"tetrabrachial",
		"b4cksl4sh",
		"long-sky",
		"genesis",
		"melting",
		"melting-old",
		"confronting"
	];

	var hudStyle:String = 'sonic2';
	
	public var sonicHUDStyles:Map<String, String> = [
		"prey" => "soniccd",
		"you-cant-run" => "sonic1",
		"final-escape" => "sonic1",
		"you-cant-run-encore" => "sonic1",
		"our-horizon" => "chaotix",
		"my-horizon" => "chaotix",
		"long-sky" => "chotix",
		"genesis" => "sonic1",
		"melting" => "sonic1",
		"melting-old" => "sonic1",
		"confronting" => "sonic1"
	];
	
	//Translation Languages
	var SongLang:String = 'Song: ';
	var ScoreLang:String = 'Score: ';
	var MissesLang:String = 'Misses: ';
	var RatingLang:String = 'Rating: ';
	var SacrificesLang:String = 'Sacrifices: ';
	var GameOverLang:String = 'Game Over';
	var PausedLang:String = 'Paused';
	var AccuracyLang:String = 'Accuracy: ';
	
	var customIconAndName:Bool = false;
	public var rgbColorSwap:ColorSwap;
	public var noteChangesFromTheStore:Bool = false;
	public var customArrowColors:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public var customNoteColors:Bool = false;
	public var noteGenesis:Int = 0;

	public function preload(graphic:String, ?lib:String) {
        var newthing:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image(graphic, lib));
        newthing.visible = false;
        add(newthing);
        remove(newthing);
    }
	public function getLuaObject(tag:String, text:Bool=true):FlxSprite {
		if(modchartSprites.exists(tag)) return modchartSprites.get(tag);
		if(text && modchartTexts.exists(tag)) return modchartTexts.get(tag);
		if(variables.exists(tag)) return variables.get(tag);
		return null;
	}
	#if (!flash && sys)
	public var runtimeShaders:Map<String, Array<String>> = new Map<String, Array<String>>();
	public function createRuntimeShader(name:String):FlxRuntimeShader
	{
		if(!ClientPrefs.Shaders) return new FlxRuntimeShader();

		#if (!flash && MODS_ALLOWED && sys)
		if(!runtimeShaders.exists(name) && !initLuaShader(name))
		{
			FlxG.log.warn('Shader $name is missing!');
			return new FlxRuntimeShader();
		}

		var arr:Array<String> = runtimeShaders.get(name);
		return new FlxRuntimeShader(arr[0], arr[1]);
		#else
		FlxG.log.warn("Platform unsupported for Runtime Shaders!");
		return null;
		#end
	}

	public function initLuaShader(name:String, ?glslVersion:Int = 120)
	{
		if(!ClientPrefs.Shaders) return false;

		if(runtimeShaders.exists(name))
		{
			FlxG.log.warn('Shader $name was already initialized!');
			return true;
		}

        #if desktop
		var foldersToCheck:Array<String> = [Paths.mods('shaders/')];
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/shaders/'));
		#else
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('shaders/')];
		#end

		for (folder in foldersToCheck)
		{
			#if desktop
			if(FileSystem.exists(folder))
			#else
			if(OpenFlAssets.exists(folder))
			#end
			{
				var frag:String = folder + name + '.frag';
				var vert:String = folder + name + '.vert';
				var found:Bool = false;
				#if desktop
				if(FileSystem.exists(frag))
				{
					frag = File.getContent(frag);
					found = true;
				}
				else frag = null;

				if (FileSystem.exists(vert))
				{
					vert = File.getContent(vert);
					found = true;
				}
				else vert = null;
				#else
				if(OpenFlAssets.exists(frag))
				{
					frag = Assets.getText(frag);
					found = true;
				}
				else frag = null;
	
				if (OpenFlAssets.exists(vert))
				{
					vert = Assets.getText(vert);
					found = true;
				}
				else vert = null;
				#end

				if(found)
				{
					runtimeShaders.set(name, [frag, vert]);
					//trace('Found shader $name!');
					return true;
				}
			}
		}
		FlxG.log.warn('Missing shader $name .frag AND .vert files!');
		return false;
	}
	#end
	
	override public function create()
	{
		Paths.clearStoredMemory();
		instance = this;
		var songName:String = Paths.formatToSongPath(SONG.song);
		curStage = PlayState.SONG.stage;
		
		if (PlayState.SONG.song.toLowerCase() == 'final-escape' && ClientPrefs.storyProgressExe == 3) LockedChartEditor = true;
		if (PlayState.SONG.song.toLowerCase() == 'final-escape') FEHPThing = 1;
		FlxG.mouse.visible = false;
		if (!LockedChartEditor) {
			debugKeysChart = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
			debugKeysCharacter = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_2'));
		}
		Achievements.loadAchievements();

		keysArray = [
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_left')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_down')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_up')),
			ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_right'))
		];
		
		if (SONG.isRing)
		{
			keysArray = [
				ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_left')),
				ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_down')),
				ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_ring')),
				ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_up')),
				ClientPrefs.copyKey(ClientPrefs.keyBinds.get('note_right'))
			];
		}

		if (TranslationLanguages.Text.exists(SongLang) && ClientPrefs.Language != 'English')
			SongLang = TranslationLanguages.Text[SongLang];
		if (TranslationLanguages.Text.exists(ScoreLang) && ClientPrefs.Language != 'English')
			ScoreLang = TranslationLanguages.Text[ScoreLang];
		if (TranslationLanguages.Text.exists(MissesLang) && ClientPrefs.Language != 'English')
			MissesLang = TranslationLanguages.Text[MissesLang];
		if (TranslationLanguages.Text.exists(RatingLang) && ClientPrefs.Language != 'English')
			RatingLang = TranslationLanguages.Text[RatingLang];
		if (TranslationLanguages.Text.exists(SacrificesLang) && ClientPrefs.Language != 'English')
			SacrificesLang = TranslationLanguages.Text[SacrificesLang];
		if (TranslationLanguages.Text.exists(GameOverLang) && ClientPrefs.Language != 'English')
			GameOverLang = TranslationLanguages.Text[GameOverLang];
		if (TranslationLanguages.Text.exists(PausedLang) && ClientPrefs.Language != 'English')
			PausedLang = TranslationLanguages.Text[PausedLang];
		if (TranslationLanguages.Text.exists(AccuracyLang) && ClientPrefs.Language != 'English')
			AccuracyLang = TranslationLanguages.Text[AccuracyLang];
		switch(ClientPrefs.Language) {
			case 'Russian':
				ratingStuff = [
					['ПРОСТО СДОХНИ!', 0.2],
					['Дерьмо', 0.4],
					['Плохо', 0.5],
					['Брух', 0.6],
					['Так себе', 0.69],
					['Норм', 0.7],
					['Хорошо', 0.8],
					['Круто', 0.9],
					['Отлично!', 1],
					['Идеально!!', 1]
				];
			case 'Spanish':
				ratingStuff = [
					['¡SIMPLEMENTE MUERTE!', 0.2],
					['Mierda', 0.4],
					['Mal', 0.5],
					['Bruh', 0.6],
					['Meh', 0.69],
					['Bonito', 0.7],
					['Bien', 0.8],
					['Genial', 0.9],
					['¡Enfermo!', 1],
					['¡¡Perfecto!!', 1]
				];
		}

		// For the "Just the Two of Us" achievement
		for (i in 0...keysArray.length)
		{
			keysPressed.push(false);
		}

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		// Gameplay settings
		healthGain = ClientPrefs.getGameplaySetting('healthgain', 1);
		healthLoss = ClientPrefs.getGameplaySetting('healthloss', 1);
		instakillOnMiss = ClientPrefs.getGameplaySetting('instakill', false);
		practiceMode = ClientPrefs.getGameplaySetting('practice', false);
		cpuControlled = ClientPrefs.getGameplaySetting('botplay', false);

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camOther = new FlxCamera();
		camOther.bgColor.alpha = 0;
		camOverlay = new FlxCamera();
		camOverlay.bgColor.alpha = 0;
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		if(PlayState.SONG.stage == null || PlayState.SONG.stage.length < 1) {
			switch (songName) {
				default:
					curStage = 'stage';
			}
		}
		switch(curStage) {
			case 'fatality' | 'fatal-encore' | 'critical-error' | 'unresponsive': fatalUI = true;
		}
		if (fatalUI)
			Main.DisableCustomCursor = true;
		else
			Main.DisableCustomCursor = false;

		switch (PlayState.SONG.song.toLowerCase()) {
			case 'b4cksl4sh' | 'milk' | 'cool-party':
				#if desktop
				isFixedAspectRatio = true;
				#else
				isFixedAspectRatio = false;
				#end
			default:
				if (fatalUI && curStage != 'fatal-encore') {
					#if desktop
					isFixedAspectRatio = true;
					#else
					isFixedAspectRatio = false;
					#end
				} else {
					isFixedAspectRatio = false;
				}
		}

		if (isFixedAspectRatio) {
			Lib.application.window.resizable = false;
			FlxG.scaleMode = new StageSizeScaleMode();
			FlxG.resizeGame(960, 720);
			FlxG.resizeWindow(960, 720);
		}

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camOverlay);
		FlxG.cameras.add(camOther);
		grpNoteSplashes = new FlxTypedGroup<NoteSplash>();

		FlxCamera.defaultCameras = [camGame];
		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		sonicHUD = new FlxSpriteGroup();
		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		topBar = new FlxSprite(0, -170).makeGraphic(1280, 170, FlxColor.BLACK);
		bottomBar = new FlxSprite(0, 720).makeGraphic(1280, 170, FlxColor.BLACK);
		blackFuck = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
		blackFuck.setGraphicSize(Std.int(blackFuck.width * 1.6));
		blackFuck.screenCenter();
		blackFuck2 = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
		blackFuck2.setGraphicSize(Std.int(blackFuck2.width * 1.6));
		blackFuck2.screenCenter();

		startBG = new FlxSprite();
		startCircle = new FlxSprite();
		startText = new FlxSprite();

		GameOverSubstate.resetVariables();
		//trace('stage is: ' + curStage);

		var stageData:StageFile = StageData.getStageFile(curStage);
		if(stageData == null) { //Stage couldn't be found, create a dummy stage for preventing a crash
			stageData = {
				directory: "",
				defaultZoom: 0.9,
				isPixelStage: false,
			
				boyfriend: [770, 100],
				girlfriend: [400, 130],
				opponent: [100, 100],
				hide_girlfriend: false,
			
				camera_boyfriend: [0, 0],
				camera_opponent: [0, 0],
				camera_girlfriend: [0, 0],
				camera_speed: 1
			};
		}

		defaultCamZoom = stageData.defaultZoom;
		isPixelStage = stageData.isPixelStage;
		BF_X = stageData.boyfriend[0];
		BF_Y = stageData.boyfriend[1];
		GF_X = stageData.girlfriend[0];
		GF_Y = stageData.girlfriend[1];
		DAD_X = stageData.opponent[0];
		DAD_Y = stageData.opponent[1];

		if(stageData.camera_speed != null)
			cameraSpeed = stageData.camera_speed;

		boyfriendCameraOffset = stageData.camera_boyfriend;
		if(boyfriendCameraOffset == null) //Fucks sake should have done it since the start :rolling_eyes:
			boyfriendCameraOffset = [0, 0];

		opponentCameraOffset = stageData.camera_opponent;
		if(opponentCameraOffset == null)
			opponentCameraOffset = [0, 0];
		
		girlfriendCameraOffset = stageData.camera_girlfriend;
		if(girlfriendCameraOffset == null)
			girlfriendCameraOffset = [0, 0];

		boyfriendGroup = new FlxSpriteGroup(BF_X, BF_Y);
		dadGroup = new FlxSpriteGroup(DAD_X, DAD_Y);
		dad2Group = new FlxSpriteGroup(DAD_X, DAD_Y);
		gfGroup = new FlxSpriteGroup(GF_X, GF_Y);

		switch (curStage)
		{
			case 'too-slow':
				if (!ClientPrefs.PotatoOptimization) {
					var sky:BGSprite = new BGSprite('PolishedP1/BGSky', 'exe', -600, -200, 1, 1);
					sky.setGraphicSize(Std.int(sky.width * 1.4));
					add(sky);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var midTrees1:BGSprite = new BGSprite('PolishedP1/TreesMidBack', 'exe', -600, -200, 0.7, 0.7);
					midTrees1.setGraphicSize(Std.int(midTrees1.width * 1.4));
					add(midTrees1);
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					var treesmid:BGSprite = new BGSprite('PolishedP1/TreesMid', 'exe', -600, -200,  0.7, 0.7);
					add(treesmid);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var treesoutermid:BGSprite = new BGSprite('PolishedP1/TreesOuterMid1', 'exe', -600, -200, 0.7, 0.7);
					treesoutermid.setGraphicSize(Std.int(treesoutermid.width * 1.4));
					add(treesoutermid);
				}

				if (!ClientPrefs.PotatoOptimization) {
					var treesoutermid2:BGSprite = new BGSprite('PolishedP1/TreesOuterMid2', 'exe', -600, -200,  0.7, 0.7);
					treesoutermid2.setGraphicSize(Std.int(treesoutermid2.width * 1.4));
					add(treesoutermid2);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var lefttrees:BGSprite = new BGSprite('PolishedP1/TreesLeft', 'exe', -600, -200,  0.7, 0.7);
					lefttrees.setGraphicSize(Std.int(lefttrees.width * 1.4));
					add(lefttrees);

					var righttrees:BGSprite = new BGSprite('PolishedP1/TreesRight', 'exe', -600, -200, 0.7, 0.7);
					righttrees.setGraphicSize(Std.int(righttrees.width * 1.4));
					add(righttrees);

					var outerbush:BGSprite = new BGSprite('PolishedP1/OuterBush', 'exe', -600, -150, 1, 1);
					outerbush.setGraphicSize(Std.int(outerbush.width * 1.4));
					add(outerbush);

					var outerbush2:BGSprite = new BGSprite('PolishedP1/OuterBushUp', 'exe', -600, -200, 1, 1);
					outerbush2.setGraphicSize(Std.int(outerbush2.width * 1.4));
					add(outerbush2);
				}

				if (!ClientPrefs.PotatoOptimization) {
					var grass:BGSprite = new BGSprite('PolishedP1/Grass', 'exe', -600, -150, 1, 1);
					grass.setGraphicSize(Std.int(grass.width * 1.4));
					add(grass);
					
					if (ClientPrefs.gore) {
						var deadegg:BGSprite = new BGSprite('PolishedP1/DeadEgg', 'exe', -600, -200, 1, 1);
						deadegg.setGraphicSize(Std.int(deadegg.width * 1.4));
						add(deadegg);

						var deadknux:BGSprite = new BGSprite('PolishedP1/DeadKnux', 'exe', -600, -200, 1, 1);
						deadknux.setGraphicSize(Std.int(deadknux.width * 1.4));
						add(deadknux);

						var deadtailz:BGSprite = new BGSprite('PolishedP1/DeadTailz', 'exe', -700, -200, 1, 1);
						deadtailz.setGraphicSize(Std.int(deadtailz.width * 1.4));
						add(deadtailz);

						var deadtailz1:BGSprite = new BGSprite('PolishedP1/DeadTailz1', 'exe', -600, -200, 1, 1);
						deadtailz1.setGraphicSize(Std.int(deadtailz1.width * 1.4));
						add(deadtailz1);

						var deadtailz2:BGSprite = new BGSprite('PolishedP1/DeadTailz2', 'exe', -600, -400, 1, 1);
						deadtailz2.setGraphicSize(Std.int(deadtailz2.width * 1.4));
						add(deadtailz2);
					}

					fgTrees = new BGSprite('PolishedP1/TreesFG', 'exe', -610, -200, 1.1, 1.1);
					fgTrees.setGraphicSize(Std.int(fgTrees.width * 1.45));
				}
		
			case 'endless-forest':
				if (SONG.song.toLowerCase() != 'oxxynless') {
					GameOverCameraMove = false;
					GameOverSubstate.characterName = 'endless_bf';
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					var SKY:BGSprite = new BGSprite('FunInfiniteStage/sonicFUNsky', 'exe', -600, -200, 1.0, 1.0);
					add(SKY);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var bush:BGSprite = new BGSprite('FunInfiniteStage/Bush 1', 'exe', -42, 171, 1.0, 1.0);
					add(bush);

					var pillars2:BGSprite = new BGSprite('FunInfiniteStage/Majin Boppers Back', 'exe', 182, -100, 1.0, 1.0, ['MajinBop2 instance 1'], true);
					add(pillars2);

					var bush2:BGSprite = new BGSprite('FunInfiniteStage/Bush2', 'exe', 132, 354, 1.0, 1.0);
					add(bush2);

					var pillars1:BGSprite = new BGSprite('FunInfiniteStage/Majin Boppers Front', 'exe', -169, -167, 1.0, 1.0, ['MajinBop1 instance 1'], true);
					add(pillars1);
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					var floor:BGSprite = new BGSprite('FunInfiniteStage/floor BG', 'exe', -340, 660, 1.0, 1.0);
					add(floor);

					fgmajin = new BGSprite('FunInfiniteStage/majin FG1', 'exe', 1426, 903, 1.0, 1.0, ['majin front bopper1'], true);
					fgmajin2 = new BGSprite('FunInfiniteStage/majin FG2', 'exe', -93, 871, 1.0, 1.0, ['majin front bopper2'], true);
				}
				
			case 'fun-cd':
				GameOverCameraMove = false;
				GameOverSubstate.characterName = 'BFgreen';

			case 'void':
				whiteFuck = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
				add(whiteFuck);

			case 'TDP2':

			case 'cycles-hills': // lmao
				if (!ClientPrefs.PotatoOptimization) {
					var SKY:BGSprite = new BGSprite('LordXStage/sky', 'exe', -1900, -1006, 1.0, 1.0);
					SKY.setGraphicSize(Std.int(SKY.width * 0.5));
					add(SKY);

					var hills:BGSprite = new BGSprite('LordXStage/hills1', 'exe', -1440, -806 + 200, 1.0, 1.0);
					hills.setGraphicSize(Std.int(hills.width * 0.5));
					add(hills);

					var floor:BGSprite = new BGSprite('LordXStage/floor', 'exe', -1400, -496, 1.0, 1.0);
					floor.setGraphicSize(Std.int(floor.width * 0.55));
					add(floor);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var eyeflower:BGSprite = new BGSprite('LordXStage/WeirdAssFlower_Assets', 'exe', 100 - 500, 100, 1.0, 1.0, ['flower'], true);
					eyeflower.setGraphicSize(Std.int(eyeflower.width * 0.8));
					add(eyeflower);

					var notknuckles:BGSprite = new BGSprite('LordXStage/NotKnuckles_Assets', 'exe', 100 - 300, -400 + 25, 1.0, 1.0, ['Notknuckles'], true);
					notknuckles.setGraphicSize(Std.int(notknuckles.width * 0.5));
					add(notknuckles);
				}

				if (!ClientPrefs.PotatoOptimization) {
					var smallflower:BGSprite = new BGSprite('LordXStage/smallflower', 'exe', -1500, -506, 1.0, 1.0);
					smallflower.setGraphicSize(Std.int(smallflower.width * 0.6));
					add(smallflower);

					var bfsmallflower:BGSprite = new BGSprite('LordXStage/smallflower', 'exe', -1500 + 300, -506 - 50, 1.0, 1.0);
					bfsmallflower.setGraphicSize(Std.int(smallflower.width * 0.6));
					add(bfsmallflower);

					var smallflower2:BGSprite = new BGSprite('LordXStage/smallflowe2', 'exe', -1500, -506 - 50, 1.0, 1.0);
					smallflower2.setGraphicSize(Std.int(smallflower.width * 0.6));
					add(smallflower2);

					var tree:BGSprite = new BGSprite('LordXStage/tree', 'exe', -1900 + 650 - 100, -1006 + 350, 1.0, 1.0);
					tree.setGraphicSize(Std.int(tree.width * .7));
					add(tree);
				}

			case 'cant-run-encore':

			case 'trioStage':
				if (!ClientPrefs.PotatoOptimization) {
					var sky:BGSprite = new BGSprite('Phase3/normal/glitch', 'exe', -621.1, -395.65, 1.0, 1.0);
					sky.active = false;
					add(sky);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var backbush:BGSprite = new BGSprite('Phase3/normal/BackBush', 'exe', -621.1, -395.65, 1.0, 1.0);
					backbush.active = false;
					add(backbush);

					var treeback:BGSprite = new BGSprite('Phase3/normal/TTTrees', 'exe', -621.1, -395.65, 1.0, 1.0);
					treeback.active = false;
					add(treeback);
				}

				if (!ClientPrefs.PotatoOptimization) {
					var topbushes:BGSprite = new BGSprite('Phase3/normal/TopBushes', 'exe', -621.1, -395.65, 1.0, 1.0);
					topbushes.active = false;
					add(topbushes);
					
					fgTree1 = new BGSprite('Phase3/normal/FGTree1', 'exe', -621.1, -395.65, 0.7, 0.7);
					fgTree1.active = false;

					fgTree2 = new BGSprite('Phase3/normal/FGTree2', 'exe', -621.1, -395.65, 0.7, 0.7);
					fgTree2.active = false;

					p3staticbg = new FlxSprite(0, 0);
					p3staticbg.frames = Paths.getSparrowAtlas('Phase3/NewTitleMenuBG', 'exe');
					p3staticbg.animation.addByPrefix('idle', "TitleMenuSSBG instance 1", 24);
					p3staticbg.animation.play('idle');
					p3staticbg.screenCenter();
					p3staticbg.scale.x = 4.5;
					p3staticbg.scale.y = 4.5;
					p3staticbg.visible = false;
					add(p3staticbg);

					backtreesXeno = new BGSprite('Phase3/xeno/BackTrees', 'exe', -621.1, -395.65, 1.0, 1.0);
					backtreesXeno.active = false;
					backtreesXeno.visible = false;
					add(backtreesXeno);

					grassXeno = new BGSprite('Phase3/xeno/Grass', 'exe', -621.1, -395.65, 1.0, 1.0);
					grassXeno.active = false;
					grassXeno.visible = false;
					add(grassXeno);
				}

			case 'sunkStage':
				GameOverCameraMove = false;
				if (!ClientPrefs.PotatoOptimization) {
					var bg:BGSprite = new BGSprite('sunky/sunky BG', 'exe', -300, -500, 0.9, 0.9);
					add(bg);

					var balls:BGSprite = new BGSprite('sunky/ball', 'exe', 20, -500, 0.9, 0.9);
					balls.screenCenter(X);
					add(balls);

					var stage:BGSprite = new BGSprite('sunky/stage', 'exe', 125, -500, 1.0, 1.0);
					stage.setGraphicSize(Std.int(stage.width * 1.1));
					add(stage);

					cereal = new FlxSprite(-1000, 0).loadGraphic(Paths.image("sunky/cereal", 'exe'));
					cereal.cameras = [camOther];
					cereal.screenCenter(Y);
					add(cereal);

					munch = new FlxSprite(-1000, 0).loadGraphic(Paths.image("sunky/sunkyMunch", 'exe'));
					munch.cameras = [camOther];
					munch.screenCenter(Y);
					add(munch);

					pose = new FlxSprite(-1000, 0).loadGraphic(Paths.image("sunky/sunkyPose", 'exe'));
					pose.cameras = [camOther];
					pose.screenCenter(Y);
					add(pose);

					sunker = new FlxSprite(200, 0).loadGraphic(Paths.image("sunky/sunker", 'exe'));
					sunker.cameras = [camOther];
					sunker.frames = Paths.getSparrowAtlas('sunky/sunker', 'exe');
					sunker.animation.addByPrefix('idle', 'sunker', 24, true);
					sunker.animation.play('idle');
					sunker.setGraphicSize(Std.int(sunker.width * 5));
					sunker.updateHitbox();
					sunker.alpha = 0;
					add(sunker);
				}

				if (aspectRatio)
				{
					var funnyAspect:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("sunky/4_3 shit", 'exe'));
					funnyAspect.screenCenter();
					funnyAspect.cameras = [camOther];
					add(funnyAspect);
				}

				spoOoOoOky = new FlxSprite(0, 0).loadGraphic(Paths.image("sunky/sunkage", 'exe'));
				spoOoOoOky.screenCenter();
				spoOoOoOky.visible = false;
				spoOoOoOky.cameras = [camOther];
				add(spoOoOoOky);

			case 'DDDDD':
				GameOverSubstate.characterName = 'bf-3d-death';
				GameOverSubstate.loopSoundName = 'sunshine-gameover';
				GameOverCameraMove = false;
				
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [false];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			case 'omni':
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [false];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
				
			case 'sanicStage':
				GameOverSubstate.loopSoundName = '';
				GameOverSubstate.endSoundName = '';
				GameOverSubstate.characterName = '';
				GameOverCameraMove = false;
				
				if (!ClientPrefs.PotatoOptimization) {
					var bg:BGSprite = new BGSprite('sanicbg', 'exe', -370, -130, 1.0, 1.0);
					bg.setGraphicSize(Std.int(bg.width * 1.2));
					add(bg);
				}
				
				if(ClientPrefs.Shaders){
					weedVis = new ColorSwap();
				}

			case 'chamber':
				GameOverSubstate.deathSoundName = 'fleetway-death';
				GameOverSubstate.loopSoundName = 'fleetway-gameover';
				GameOverSubstate.endSoundName = 'fleetway-retry';
				GameOverCameraMove = true;
				if (!ClientPrefs.PotatoOptimization) {
					wall = new FlxSprite(-2379.05, -1211.1);
					wall.frames = Paths.getSparrowAtlas('Chamber/Wall', 'exe');
					wall.animation.addByPrefix('a', 'Wall instance 1');
					wall.animation.play('a');
					wall.antialiasing = true;
					wall.scrollFactor.set(1.1, 1.1);
					add(wall);

					floor = new FlxSprite(-2349, 1000);
					floor.antialiasing = true;
					floor.frames = Paths.getSparrowAtlas('Chamber/Floor', 'exe');
					floor.animation.addByPrefix('a', 'floor blue');
					floor.animation.addByPrefix('b', 'floor yellow');
					floor.setGraphicSize(Std.int(floor.width * 1.15));
					floor.animation.play('b', true);
					floor.animation.play('a', true);
					floor.scrollFactor.set(1.1, 1);
					floor.antialiasing = true;
					add(floor);

					fleetwaybgshit = new FlxSprite(-2629.05, -1344.05);
					fleetwaybgshit.frames = Paths.getSparrowAtlas('Chamber/FleetwayBGshit', 'exe');
					fleetwaybgshit.animation.addByPrefix('a', 'BGblue');
					fleetwaybgshit.animation.addByPrefix('b', 'BGyellow');
					fleetwaybgshit.animation.play('b', true);
					fleetwaybgshit.animation.play('a', true);
					fleetwaybgshit.antialiasing = true;
					fleetwaybgshit.scrollFactor.set(1.1, 1);
					add(fleetwaybgshit);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					emeraldbeam = new FlxSprite(0, -1376.95 - 200);
					emeraldbeam.antialiasing = true;
					emeraldbeam.frames = Paths.getSparrowAtlas('Chamber/Emerald Beam', 'exe');
					emeraldbeam.animation.addByPrefix('a', 'Emerald Beam instance 1', 24, true);
					emeraldbeam.animation.play('a');
					emeraldbeam.scrollFactor.set(1.1, 1);
					emeraldbeam.visible = true;
					add(emeraldbeam);

					emeraldbeamyellow = new FlxSprite(-300, -1376.95 - 200);
					emeraldbeamyellow.antialiasing = true;
					emeraldbeamyellow.frames = Paths.getSparrowAtlas('Chamber/Emerald Beam Charged', 'exe');
					emeraldbeamyellow.animation.addByPrefix('a', 'Emerald Beam Charged instance 1', 24, true);
					emeraldbeamyellow.animation.play('a');
					emeraldbeamyellow.scrollFactor.set(1.1, 1);
					emeraldbeamyellow.visible = false;
					add(emeraldbeamyellow);

					var emeralds:FlxSprite = new FlxSprite(326.6, -191.75);
					emeralds.antialiasing = true;
					emeralds.frames = Paths.getSparrowAtlas('Chamber/Emeralds', 'exe');
					emeralds.animation.addByPrefix('a', 'TheEmeralds instance 1', 24, true);
					emeralds.animation.play('a');
					emeralds.scrollFactor.set(1.1, 1);
					emeralds.antialiasing = true;
					add(emeralds);
				}
				if (!ClientPrefs.PotatoOptimization) {
					thechamber = new FlxSprite(-225.05, 463.9);
					thechamber.frames = Paths.getSparrowAtlas('Chamber/The Chamber', 'exe');
					thechamber.animation.addByPrefix('a', 'Chamber Sonic Fall', 24, false);
					thechamber.animation.addByIndices('b', 'Chamber Sonic Fall', [25], "", 24, false);
					thechamber.scrollFactor.set(1.1, 1);
					thechamber.antialiasing = true;
					if (SONG.song.toLowerCase() != 'chaos') {
						thechamber.animation.play('b');
					}

					pebles = new FlxSprite(-562.15 + 100, 1043.3);
					add(pebles);
					pebles.frames = Paths.getSparrowAtlas('Chamber/pebles', 'exe');
					pebles.animation.addByPrefix('a', 'pebles instance 1', 24, false);
					pebles.animation.addByPrefix('b', 'pebles instance 2', 24, false);
					pebles.animation.play('b', true);
					pebles.animation.play('a', true);
					pebles.scrollFactor.set(1.1, 1);
					pebles.antialiasing = true;

					porker = new FlxSprite(2880.15, -762.8);
					porker.frames = Paths.getSparrowAtlas('Chamber/Porker Lewis', 'exe');
					porker.animation.addByPrefix('porkerbop', 'Porker FG');
					porker.animation.play('porkerbop', true);
					porker.scrollFactor.set(1.4, 1);
					porker.antialiasing = true;
				}
			case 'chamber-encore':
				GameOverSubstate.deathSoundName = 'fleetway-death';
				GameOverSubstate.loopSoundName = 'fleetway-gameover';
				GameOverSubstate.endSoundName = 'fleetway-retry';
				GameOverCameraMove = true;
				if (!ClientPrefs.PotatoOptimization) {
					wall = new FlxSprite(-2379.05, -1211.1);
					wall.frames = Paths.getSparrowAtlas('Chamber/Wall', 'exe');
					wall.animation.addByPrefix('a', 'Wall instance 1');
					wall.animation.play('a');
					wall.antialiasing = true;
					wall.scrollFactor.set(1.1, 1.1);
					add(wall);
					
					floor = new FlxSprite(-2349, 1000);
					floor.antialiasing = true;
					floor.frames = Paths.getSparrowAtlas('Chamber/Floor', 'exe');
					floor.animation.addByPrefix('b', 'floor yellow');
					floor.setGraphicSize(Std.int(floor.width * 1.15));
					floor.animation.play('b', true);
					floor.scrollFactor.set(1.1, 1);
					floor.antialiasing = true;
					add(floor);

					fleetwaybgshit = new FlxSprite(-2629.05, -1344.05);
					fleetwaybgshit.frames = Paths.getSparrowAtlas('Chamber/FleetwayBGshit', 'exe');
					fleetwaybgshit.animation.addByPrefix('b', 'BGyellow');
					fleetwaybgshit.animation.play('b', true);
					fleetwaybgshit.antialiasing = true;
					fleetwaybgshit.scrollFactor.set(1.1, 1);
					add(fleetwaybgshit);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					emeraldbeamyellow = new FlxSprite(-300, -1376.95 - 200);
					emeraldbeamyellow.antialiasing = true;
					emeraldbeamyellow.frames = Paths.getSparrowAtlas('Chamber/Emerald Beam Charged', 'exe');
					emeraldbeamyellow.animation.addByPrefix('a', 'Emerald Beam Charged instance 1', 24, true);
					emeraldbeamyellow.animation.play('a');
					emeraldbeamyellow.scrollFactor.set(1.1, 1);
					emeraldbeamyellow.visible = true;
					add(emeraldbeamyellow);

					var emeralds:FlxSprite = new FlxSprite(326.6, -191.75);
					emeralds.antialiasing = true;
					emeralds.frames = Paths.getSparrowAtlas('Chamber/Emeralds', 'exe');
					emeralds.animation.addByPrefix('a', 'TheEmeralds instance 1', 24, true);
					emeralds.animation.play('a');
					emeralds.scrollFactor.set(1.1, 1);
					emeralds.antialiasing = true;
					add(emeralds);
				}
				if (!ClientPrefs.PotatoOptimization) {
					thechamber = new FlxSprite(-225.05, 463.9);
					thechamber.frames = Paths.getSparrowAtlas('Chamber/The Chamber', 'exe');
					thechamber.animation.addByIndices('b', 'Chamber Sonic Fall', [25], "", 24, false);
					thechamber.scrollFactor.set(1.1, 1);
					thechamber.antialiasing = true;
					thechamber.animation.play('b');

					pebles = new FlxSprite(-562.15 + 100, 1043.3);
					add(pebles);
					pebles.frames = Paths.getSparrowAtlas('Chamber/pebles', 'exe');
					pebles.animation.addByPrefix('a', 'pebles instance 1', 24, false);
					pebles.animation.play('a', true);
					pebles.scrollFactor.set(1.1, 1);
					pebles.antialiasing = true;

					porker = new FlxSprite(2880.15, -762.8);
					porker.frames = Paths.getSparrowAtlas('Chamber/Porker Lewis', 'exe');
					porker.animation.addByPrefix('porkerbop', 'Porker FG');
					porker.animation.play('porkerbop', true);
					porker.scrollFactor.set(1.4, 1);
					porker.antialiasing = true;
				}
			case 'needle':
				defaultCamZoom = 0.6;
				GameOverCameraMove = false;

				GameOverSubstate.characterName = 'bf-needle-die';
				GameOverSubstate.deathSoundName = 'needlemouse-death';
				GameOverSubstate.loopSoundName = 'needlemouse-gameover';
				GameOverSubstate.endSoundName = 'needlemouse-retry';

				if (!ClientPrefs.PotatoOptimization) {
					needleSky = new BGSprite('needlemouse/sky', 'exe', -725, -200, 0.7, 0.9);
					add(needleSky);

					needleMoutains = new BGSprite('needlemouse/mountains', 'exe', -700, -175, 0.8, 0.9);
					needleMoutains.setGraphicSize(Std.int(needleMoutains.width * 1.1));
					add(needleMoutains);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					needleRuins = new BGSprite('needlemouse/ruins', 'exe', -775, -310, 1, 0.9);
					needleRuins.setGraphicSize(Std.int(needleRuins.width * 1.4));
					add(needleRuins);
				}

				if (!ClientPrefs.PotatoOptimization) {
					needleBuildings = new BGSprite('needlemouse/buildings', 'exe', -1000, -100, 1, 0.9);
					add(needleBuildings);

					conkCreet = new BGSprite('needlemouse/CONK_CREET', 'exe', -775, -310, 1, 0.9);
					conkCreet.setGraphicSize(Std.int(conkCreet.width * 1.4));
					add(conkCreet);
					
					darkthing = new BGSprite('needlemouse/Black', 'exe', 0, 0, 1, 0.9);
					darkthing.setGraphicSize(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3));
					darkthing.alpha = 0;
					add(darkthing);
					darkthing.cameras = [camGame];
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					needleFg = new FlxSprite(-690, -80).loadGraphic(Paths.image('needlemouse/fg', 'exe'));
					needleFg.setGraphicSize(Std.int(needleFg.width * 1.1));
					needleFg.scrollFactor.set(1, 0.9);
				}
				
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				VHSui = true;
				
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'needle-p2':
				defaultCamZoom = 0.75;
				GameOverCameraMove = false;

				GameOverSubstate.characterName = 'bf-needle-die';
				GameOverSubstate.deathSoundName = 'needlemouserage-death';
				GameOverSubstate.loopSoundName = 'needlemouserage-gameover';
				GameOverSubstate.endSoundName = 'needlemouserage-retry';

				if (!ClientPrefs.PotatoOptimization) {
					needleSkyZERO = new BGSprite('needlemouse-p2/sky-0', 'exe', -725, -200, 0.7, 0.9);
					add(needleSkyZERO);	
					needleSkyONE = new BGSprite('needlemouse-p2/sky-1', 'exe', -725, -200, 0.7, 0.9);
					add(needleSkyONE);
					needleSkyTWO = new BGSprite('needlemouse-p2/sky-2', 'exe', -725, -200, 0.7, 0.9);
					add(needleSkyTWO);
					needleSkyTHREE = new BGSprite('needlemouse-p2/sky-3', 'exe', -725, -200, 0.7, 0.9);
					add(needleSkyTHREE);

					needleMoutainsZERO = new BGSprite('needlemouse-p2/mountains-0', 'exe', -700, -175, 0.8, 0.9);
					needleMoutainsZERO.setGraphicSize(Std.int(needleMoutainsZERO.width * 1.1));
					add(needleMoutainsZERO);
					needleMoutainsONE = new BGSprite('needlemouse-p2/mountains-1', 'exe', -700, -175, 0.8, 0.9);
					needleMoutainsONE.setGraphicSize(Std.int(needleMoutainsONE.width * 1.1));
					add(needleMoutainsONE);
					needleMoutainsTWO = new BGSprite('needlemouse-p2/mountains-2', 'exe', -700, -175, 0.8, 0.9);
					needleMoutainsTWO.setGraphicSize(Std.int(needleMoutainsTWO.width * 1.1));
					add(needleMoutainsTWO);
					needleMoutainsTHREE = new BGSprite('needlemouse-p2/mountains-3', 'exe', -700, -175, 0.8, 0.9);
					needleMoutainsTHREE.setGraphicSize(Std.int(needleMoutainsTHREE.width * 1.1));
					add(needleMoutainsTHREE);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					needleRuinsZERO = new BGSprite('needlemouse-p2/ruins-0', 'exe', -775, -310, 1, 0.9);
					needleRuinsZERO.setGraphicSize(Std.int(needleRuinsZERO.width * 1.4));
					add(needleRuinsZERO);
					needleRuinsONE = new BGSprite('needlemouse-p2/ruins-1', 'exe', -775, -310, 1, 0.9);
					needleRuinsONE.setGraphicSize(Std.int(needleRuinsONE.width * 1.4));
					add(needleRuinsONE);
					needleRuinsTWO = new BGSprite('needlemouse-p2/ruins-2', 'exe', -775, -310, 1, 0.9);
					needleRuinsTWO.setGraphicSize(Std.int(needleRuinsTWO.width * 1.4));
					add(needleRuinsTWO);
				}

				if (!ClientPrefs.PotatoOptimization) {
					needleBuildingsZERO = new BGSprite('needlemouse-p2/buildings-0', 'exe', -1000, -100, 1, 0.9);
					add(needleBuildingsZERO);
					needleBuildingsONE = new BGSprite('needlemouse-p2/buildings-1', 'exe', -1000, -100, 1, 0.9);
					add(needleBuildingsONE);
					needleBuildingsTWO = new BGSprite('needlemouse-p2/buildings-2', 'exe', -1000, -100, 1, 0.9);
					add(needleBuildingsTWO);

					conkCreet = new BGSprite('needlemouse-p2/CONK_CREET', 'exe', -775, -310, 1, 0.9);
					conkCreet.setGraphicSize(Std.int(conkCreet.width * 1.4));
					add(conkCreet);

					darkthing = new BGSprite('needlemouse-p2/Black', 'exe', 0, 0, 1, 0.9);
					darkthing.setGraphicSize(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3));
					darkthing.alpha = 0;
					add(darkthing);
					darkthing.cameras = [camGame];
				}

				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					needleFgZERO = new FlxSprite(-690, -80).loadGraphic(Paths.image('needlemouse-p2/fg-0', 'exe'));
					needleFgZERO.setGraphicSize(Std.int(needleFgZERO.width * 1.1));
					needleFgZERO.scrollFactor.set(1, 0.9);
					needleFgONE = new FlxSprite(-690, -80).loadGraphic(Paths.image('needlemouse-p2/fg-1', 'exe'));
					needleFgONE.setGraphicSize(Std.int(needleFgONE.width * 1.1));
					needleFgONE.scrollFactor.set(1, 0.9);
					needleFgTWO = new FlxSprite(-690, -80).loadGraphic(Paths.image('needlemouse-p2/fg-2', 'exe'));
					needleFgTWO.setGraphicSize(Std.int(needleFgTWO.width * 1.1));
					needleFgTWO.scrollFactor.set(1, 0.9);
					needleFgTHREE = new FlxSprite(-690, -80).loadGraphic(Paths.image('needlemouse-p2/fg-3', 'exe'));
					needleFgTHREE.setGraphicSize(Std.int(needleFgTHREE.width * 1.1));
					needleFgTHREE.scrollFactor.set(1, 0.9);
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					needleSkyONE.alpha = 0;
					needleSkyTWO.alpha = 0;
					needleSkyTHREE.alpha = 0;
					needleMoutainsONE.alpha = 0;
					needleMoutainsTWO.alpha = 0;
					needleMoutainsTHREE.alpha = 0;
				}
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					needleRuinsONE.alpha = 0;
					needleRuinsTWO.alpha = 0;
				}
				if (!ClientPrefs.PotatoOptimization) needleBuildingsONE.alpha = 0;
				if (!ClientPrefs.PotatoOptimization) needleBuildingsTWO.alpha = 0;
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					needleFgONE.alpha = 0;
					needleFgTWO.alpha = 0;
					needleFgTHREE.alpha = 0;
				}
				
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				VHSui = true;
				
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse-p2/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'needle-encore':
				defaultCamZoom = 0.6;
				GameOverCameraMove = false;
				
				GameOverSubstate.characterName = 'bf-needle-die';
				GameOverSubstate.deathSoundName = 'shadowmouse-death';
				GameOverSubstate.loopSoundName = 'shadowmouse-gameover';
				GameOverSubstate.endSoundName = 'shadowmouse-retry';

				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				VHSui = true;
				
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'fatality':
				FlxG.mouse.visible = true;
				GameOverCameraMove = false;
				FlxG.mouse.unload();
				FlxG.log.add("Sexy mouse cursor " + Paths.image('cursor/fatal_mouse_cursor', 'exe'));
				FlxG.mouse.load(Paths.image('cursor/fatal_mouse_cursor', 'exe').bitmap, 1.5, 0);
			
				GameOverSubstate.characterName = 'bf-fatal-death';
				GameOverSubstate.deathSoundName = 'fatal-death';
				GameOverSubstate.loopSoundName = 'starved-gameover';
				GameOverSubstate.endSoundName = 'fatal-retry';

				defaultCamZoom = 0.75;
				isPixelStage = true;
				if (!ClientPrefs.PotatoOptimization) {
					base = new FlxSprite(-200, 100);
					base.frames = Paths.getSparrowAtlas('fatal/launchbase', 'exe');
					base.animation.addByIndices('base', 'idle', [0, 1, 2, 3, 4, 5, 6, 8, 9], "", 12, true);
					base.animation.play('base');
					base.scale.x = 5;
					base.scale.y = 5;
					base.antialiasing = false;
					base.scrollFactor.set(1, 1);
					add(base);

					domain2 = new FlxSprite(100, 200);
					domain2.frames = Paths.getSparrowAtlas('fatal/domain2', 'exe');
					domain2.animation.addByIndices('theand', 'idle', [0, 1, 2, 3, 4, 5, 6, 8, 9], "", 12, true);
					domain2.animation.play('theand');
					domain2.scale.x = 4;
					domain2.scale.y = 4;
					domain2.antialiasing = false;
					domain2.scrollFactor.set(1, 1);
					domain2.visible = false;
					add(domain2);

					domain = new FlxSprite(100, 200);
					domain.frames = Paths.getSparrowAtlas('fatal/domain', 'exe');
					domain.animation.addByIndices('begin', 'idle', [0, 1, 2, 3, 4], "", 12, true);
					domain.animation.play('begin');
					domain.scale.x = 4;
					domain.scale.y = 4;
					domain.antialiasing = false;
					domain.scrollFactor.set(1, 1);
					domain.visible = false;
					add(domain);

					trueFatal = new FlxSprite(250, 200);
					trueFatal.frames = Paths.getSparrowAtlas('fatal/truefatalstage', 'exe');
					trueFatal.animation.addByIndices('piss', 'idle', [0, 1, 2, 3], "", 12, true);
					trueFatal.animation.play('piss');
					trueFatal.scale.x = 4;
					trueFatal.scale.y = 4;
					trueFatal.antialiasing = false;
					trueFatal.scrollFactor.set(1, 1);
					trueFatal.visible = false;
					add(trueFatal);
				}
				
				daStatix = new BGSprite('statix', 'exe', 0, 0, 1.0, 1.0, ['statixx'], true);
				daStatix.screenCenter();
				daStatix.setGraphicSize(FlxG.width, FlxG.height);
				daStatix.visible = false;
				
			case 'critical-error' | 'fatal-encore':
				FlxG.mouse.visible = true;
				GameOverCameraMove = false;
				FlxG.mouse.unload();
				FlxG.log.add("Sexy mouse cursor " + Paths.image('cursor/fatal_mouse_cursor', 'exe'));
				FlxG.mouse.load(Paths.image('cursor/fatal_mouse_cursor', 'exe').bitmap, 1.5, 0);
			
				GameOverSubstate.characterName = 'bf-fatal-death';
				GameOverSubstate.deathSoundName = 'fatal-death';
				GameOverSubstate.loopSoundName = 'starved-gameover';
				GameOverSubstate.endSoundName = 'fatal-retry';

				isPixelStage = true;
				
				if (curStage == 'fatal-encore') {
					FatalEncoreFiles = new FlxTypedSpriteGroup<FlxSprite>();
					FatalEncoreFilesGlitch = new FlxTypedSpriteGroup<FlxSprite>();
					FatalEncoreCorruptedFilesALL = new FlxTypedSpriteGroup<FlxSprite>();
					
					if (UseWindowsDesktopFiles)
						BackgroundPC = new FlxSprite(-1250, -680).loadGraphic(Paths.image('pcbg'));
					else
						BackgroundPC = new FlxSprite(-1250, -680).loadGraphic(Paths.image('defaultpcbg'));
					BackgroundPC.setGraphicSize(3733, 2100);
					BackgroundPC.scrollFactor.set(0, 0);
					BackgroundPC.screenCenter();
					BackgroundPC.antialiasing = true;
					add(BackgroundPC);
					
					var FileNa:Array<String>;
					var FileName:Array<String>;
					if (UseWindowsDesktopFiles) {
						FileNa = WinPaths.getDesktopFileNames(false, false, false, false, false);
						FileName = WinPaths.getDesktopFileNames(false, false, false, false, false);
					} else {
						FileNa = NonRealDesktopIcons;
						FileName = ["Geometry Dash", "Dare Devil", "Illegal Instruction", "Parallax", "File Extention", "Steam", "Discord", "Bugs in code", "My Passwords", "Plans", "DO NOT OPEN", "My Projects", "Restoration", "FNF'", "Sonic.exe"];
					}
					for (i in 0...160 - FileName.length) {
						FileName.push('CORRUPTED FILE');
					}
					
					var XIcon:Int = -940;
					var YIcon:Int = -510;
					var XFileName:Int = -1505;
					var YFileName:Int = -362;
					var yayItWorks:Int = 15;
					for (i in 0...FileName.length) {
						var FilesFolder:String = 'fatal-encore-classic-icons/';
						if (UseWindowsDesktopFiles)
							FilesFolder = 'fatal-encore-icons/';
						
						if (i < FileNa.length) {
							var icon:FlxSprite = new FlxSprite(0, 0);
							#if desktop
							if (FileSystem.exists('mods/images/' + FilesFolder + FileName[0] + '.png'))
								icon.loadGraphic(Paths.image(FilesFolder + FileName[0]));
							else
								icon.loadGraphic(Paths.image('unknown'));
							#else
							icon.loadGraphic(Paths.image(FilesFolder + FileName[0]));
							#end
							icon.ID = i;
							icon.setGraphicSize(150, 150);
							icon.scrollFactor.set(0, 0);
							icon.updateHitbox();
							icon.screenCenter();
							icon.x = XIcon;
							icon.y = YIcon;
							icon.antialiasing = true;
							FatalEncoreFiles.add(icon);
							
							var fileGlitch:FlxSprite = new FlxSprite(0, 0);
							fileGlitch.frames = Paths.getSparrowAtlas('file-glitch');
							fileGlitch.animation.addByPrefix('idle', 'idle', 10, true);
							fileGlitch.animation.play('idle');
							fileGlitch.ID = i;
							fileGlitch.setGraphicSize(170, 170);
							fileGlitch.scrollFactor.set(0, 0);
							fileGlitch.updateHitbox();
							fileGlitch.screenCenter();
							fileGlitch.x = XIcon;
							fileGlitch.y = YIcon;
							fileGlitch.antialiasing = true;
							fileGlitch.alpha = 0;
							FatalEncoreFilesGlitch.add(fileGlitch);
							
							var fixlol:String = FileName[0];
							for (i in 0...FileName[0].length) {
								if (fixlol.length > 10)
									fixlol = fixlol.substring(0, fixlol.length - 1);
							}
							if (FileName[0].split('.')[0].length >= 10)
								fixlol = fixlol + '...';
							var fileName:FlxText = new FlxText(0, 0, FlxG.width, fixlol);
							fileName.setFormat(Paths.font('segoeui.ttf'), 33, 0xFFFFFFFF);
							fileName.alignment = 'center';
							fileName.scrollFactor.set(0, 0);
							fileName.ID = i;
							fileName.updateHitbox();
							fileName.screenCenter();
							fileName.x = XFileName;
							fileName.y = YFileName;
							fileName.antialiasing = true;
							FatalEncoreFiles.add(fileName);
						}
						var corruptedFileALL:FlxSprite = new FlxSprite(XIcon, YIcon);
						corruptedFileALL.loadGraphic(Paths.image('CORRUPTED FILE'));
						corruptedFileALL.ID = i;
						corruptedFileALL.setGraphicSize(150, 150);
						corruptedFileALL.scrollFactor.set(0, 0);
						corruptedFileALL.updateHitbox();
						corruptedFileALL.screenCenter();
						corruptedFileALL.x = XIcon;
						corruptedFileALL.y = YIcon;
						corruptedFileALL.antialiasing = true;
						corruptedFileALL.alpha = 0;
						FatalEncoreCorruptedFilesALL.add(corruptedFileALL);
						
						var CorrNameAll:String = 'CORRUPTED FILE';
						for (i in 0...CorrNameAll.length) {
							if (CorrNameAll.length > 9)
								CorrNameAll = CorrNameAll.substring(0, CorrNameAll.length - 1);
						}
						if (CorrNameAll.length >= 9)
							CorrNameAll = CorrNameAll + '...';
						var CorrTextALL:FlxText = new FlxText(XFileName, YFileName, FlxG.width, CorrNameAll);
						CorrTextALL.setFormat(Paths.font('segoeui.ttf'), 33, 0xFFFFFFFF);
						CorrTextALL.alignment = 'center';
						CorrTextALL.scrollFactor.set(0, 0);
						CorrTextALL.ID = i;
						CorrTextALL.updateHitbox();
						CorrTextALL.screenCenter();
						CorrTextALL.x = XFileName;
						CorrTextALL.y = YFileName;
						CorrTextALL.antialiasing = true;
						CorrTextALL.alpha = 0;
						FatalEncoreCorruptedFilesALL.add(CorrTextALL);
						FileName.remove(FileName[0]);
						
						if (i % 16 == 0 && i > 15)
							yayItWorks += 16;
						if (i == yayItWorks) {
							XIcon = -940;
							YIcon += 235;
							XFileName = -1505;
							YFileName += 235;
						} else {
							XIcon += 200;
							XFileName += 200;
						}
					}
					add(FatalEncoreFiles);
					FatalEncoreFiles.scrollFactor.set(0, 0);
					add(FatalEncoreFilesGlitch);
					FatalEncoreFilesGlitch.scrollFactor.set(0, 0);
					add(FatalEncoreCorruptedFilesALL);
					FatalEncoreCorruptedFilesALL.scrollFactor.set(0, 0);
					
					FatalEncoreTray = new FlxSprite(-1250, 1150).makeGraphic(3733, 117, 0xFF1B1D20);
					FatalEncoreTray.scrollFactor.set(0, 0);
					add(FatalEncoreTray);
				
					FatalEncoreTrayIcons = new FlxSprite(0, 1180).loadGraphic(Paths.image('win10Tray'));
					FatalEncoreTrayIcons.setGraphicSize(3200, 100);
					FatalEncoreTrayIcons.scrollFactor.set(0, 0);
					FatalEncoreTrayIcons.antialiasing = true;
					add(FatalEncoreTrayIcons);
				
					FatalEncoreUsername = new FlxText(450, 1170, FlxG.width, #if windows Main.PCuserName #else 'Player' #end);
					FatalEncoreUsername.setFormat(Paths.font('segoeui.ttf'), 40, 0xFFFFFFFF);
					FatalEncoreUsername.alignment = 'right';
					FatalEncoreUsername.scrollFactor.set(0, 0);
					FatalEncoreUsername.updateHitbox();
					FatalEncoreUsername.antialiasing = true;
					add(FatalEncoreUsername);
					
					FatalEncorePCTime = new FlxText(1385, 1153, FlxG.width, Std.string(DateTools.format(Date.now(), "%T")));
					FatalEncorePCTime.setFormat(Paths.font('segoeui.ttf'), 33, 0xFFFFFFFF);
					FatalEncorePCTime.alignment = 'center';
					FatalEncorePCTime.scrollFactor.set(0, 0);
					FatalEncorePCTime.updateHitbox();
					FatalEncorePCTime.antialiasing = true;
					add(FatalEncorePCTime);
					
					FatalEncorePCDay = new FlxText(1385, 1196, FlxG.width, Std.string(DateTools.format(Date.now(), "%F")).split("-")[2] + '.' + Std.string(DateTools.format(Date.now(), "%F")).split("-")[1] + '.' + Std.string(DateTools.format(Date.now(), "%F")).split("-")[0]);
					FatalEncorePCDay.setFormat(Paths.font('segoeui.ttf'), 33, 0xFFFFFFFF);
					FatalEncorePCDay.alignment = 'center';
					FatalEncorePCDay.scrollFactor.set(0, 0);
					FatalEncorePCDay.updateHitbox();
					FatalEncorePCDay.antialiasing = true;
					add(FatalEncorePCDay);
					
					var darkbg:FlxSprite = new FlxSprite(-1250, -680).makeGraphic(1280, 720, 0xFF000000); 
					darkbg.setGraphicSize(3733, 2100);
					darkbg.scrollFactor.set(0, 0);
					darkbg.screenCenter();
					darkbg.alpha = 0.45;
					add(darkbg);
				}
				
			case 'horizon', 'our-horizon':
				GameOverSubstate.deathSoundName = 'chaotix-death';
				GameOverSubstate.loopSoundName = 'chaotix-gameover';
				GameOverSubstate.endSoundName = 'chaotix-retry';
				GameOverSubstate.characterName = 'bf-chaotix-death';

				defaultCamZoom = 0.87;
				if (!ClientPrefs.PotatoOptimization) {
					fucklesBGPixel = new BGSprite('chaotix/horizonsky', 'exe', -1450, -725, 1.2, 0.9);
					add(fucklesBGPixel);

					fucklesFuckedUpBg = new FlxSprite(-1300, -500);
					fucklesFuckedUpBg.frames = Paths.getSparrowAtlas('chaotix/corrupt_background', 'exe');
					fucklesFuckedUpBg.animation.addByPrefix('idle', 'corrupt background', 24, true);
					fucklesFuckedUpBg.animation.play('idle');
					fucklesFuckedUpBg.scale.x = 1;
					fucklesFuckedUpBg.scale.y = 1;
					fucklesFuckedUpBg.visible = false;
					fucklesFuckedUpBg.antialiasing = false;
					add(fucklesFuckedUpBg);

					fucklesFGPixel = new BGSprite('chaotix/horizonFg', 'exe', -550, -735, 1, 0.9);
					add(fucklesFGPixel);

					fucklesFuckedUpFg = new BGSprite('chaotix/horizonFuckedUp', 'exe', -550, -735, 1, 0.9);
					fucklesFuckedUpFg.visible = false;
					add(fucklesFuckedUpFg);

					fucklesAmyBg = new FlxSprite(1195, 630);
					fucklesAmyBg.frames = Paths.getSparrowAtlas('chaotix/BG_amy', 'exe');
					fucklesAmyBg.animation.addByPrefix('idle', 'amy bobbing', 24);
					fucklesAmyBg.animation.addByPrefix('fear', 'amy fear', 24, true);
					fucklesAmyBg.scale.x = 6;
					fucklesAmyBg.scale.y = 6;
					fucklesAmyBg.antialiasing = false;

					fucklesCharmyBg = new FlxSprite(1000, 500);
					fucklesCharmyBg.frames = Paths.getSparrowAtlas('chaotix/BG_charmy', 'exe');
					fucklesCharmyBg.animation.addByPrefix('idle', 'charmy bobbing', 24);
					fucklesCharmyBg.animation.addByPrefix('fear', 'charmy fear', 24, true);
					fucklesCharmyBg.scale.x = 6;
					fucklesCharmyBg.scale.y = 6;
					fucklesCharmyBg.antialiasing = false;

					fucklesMightyBg = new FlxSprite(590, 650);
					fucklesMightyBg.frames = Paths.getSparrowAtlas('chaotix/BG_mighty', 'exe');
					fucklesMightyBg.animation.addByPrefix('idle', 'mighty bobbing', 24);
					fucklesMightyBg.animation.addByPrefix('fear', 'mighty fear', 24, true);
					fucklesMightyBg.scale.x = 6;
					fucklesMightyBg.scale.y = 6;
					fucklesMightyBg.antialiasing = false;

					fucklesEspioBg = new FlxSprite(1400, 660);
					fucklesEspioBg.frames = Paths.getSparrowAtlas('chaotix/BG_espio', 'exe');
					fucklesEspioBg.animation.addByPrefix('idle', 'espio bobbing', 24);
					fucklesEspioBg.animation.addByPrefix('fear', 'espio fear', 24, true);
					fucklesEspioBg.scale.x = 6;
					fucklesEspioBg.scale.y = 6;
					fucklesEspioBg.antialiasing = false;

					fucklesKnuxBg = new FlxSprite(-60, 645);
					fucklesKnuxBg.frames = Paths.getSparrowAtlas('chaotix/BG_knuckles', 'exe');
					fucklesKnuxBg.animation.addByPrefix('idle', 'knuckles bobbing', 24);
					fucklesKnuxBg.animation.addByPrefix('fear', 'knuckles fear', 24, true);
					fucklesKnuxBg.scale.x = 6;
					fucklesKnuxBg.scale.y = 6;
					fucklesKnuxBg.antialiasing = false;

					fucklesVectorBg = new FlxSprite(-250, 615);
					fucklesVectorBg.frames = Paths.getSparrowAtlas('chaotix/BG_vector', 'exe');
					fucklesVectorBg.animation.addByPrefix('idle', 'vector bobbing', 24);
					fucklesVectorBg.animation.addByPrefix('fear', 'vector fear', 24, true);
					fucklesVectorBg.scale.x = 6;
					fucklesVectorBg.scale.y = 6;
					fucklesVectorBg.antialiasing = false;

					add(fucklesAmyBg);
					add(fucklesCharmyBg);
					add(fucklesMightyBg);
					add(fucklesEspioBg);
					add(fucklesKnuxBg);
					add(fucklesVectorBg);
				}

				whiteFuck = new FlxSprite(-600, 0).makeGraphic(FlxG.width * 6, FlxG.height * 6, FlxColor.BLACK);
				whiteFuck.alpha = 0;
				add(whiteFuck);
				
				if (!ClientPrefs.PotatoOptimization) {
					if (SONG.song.toLowerCase() == 'our-horizon') {
						horizonBg = new FlxSprite(-500, 285);
						horizonBg.loadGraphic(Paths.image('chaotix/new_horizon/starline', 'exe'));
						horizonBg.scrollFactor.set(1, 1);
						horizonBg.scale.set(1.1, 1.1);
						horizonBg.antialiasing = true;
						add(horizonBg);

						horizonPurpur = new FlxSprite(-150, 425);
						horizonPurpur.frames = Paths.getSparrowAtlas('chaotix/firework/pink_firework', 'exe');
						horizonPurpur.animation.addByPrefix('idle', 'red firework', 8);
						horizonPurpur.scrollFactor.set(1, 1);
						horizonPurpur.antialiasing = true;
						add(horizonPurpur);

						horizonRed = new FlxSprite(400, 425);
						horizonRed.frames = Paths.getSparrowAtlas('chaotix/firework/red_firework', 'exe');
						horizonRed.animation.addByPrefix('idle', 'red firework', 8);
						horizonRed.scrollFactor.set(1, 1);
						horizonRed.antialiasing = true;
						add(horizonRed);

						horizonYellow = new FlxSprite(800, 425);
						horizonYellow.frames = Paths.getSparrowAtlas('chaotix/firework/yellow_firework', 'exe');
						horizonYellow.animation.addByPrefix('idle', 'red firework', 8);
						horizonYellow.scrollFactor.set(1, 1);
						horizonYellow.antialiasing = true;
						add(horizonYellow);

						horizonFloor = new FlxSprite(-500, 285);
						horizonFloor.loadGraphic(Paths.image('chaotix/new_horizon/floor', 'exe'));
						horizonFloor.scrollFactor.set(1, 1);
						horizonFloor.scale.set(1.1, 1.1);
						horizonFloor.antialiasing = true;
						add(horizonFloor);
						
						if (!ClientPrefs.Optimization) {
							horizonEspio = new FlxSprite(-300, 400);
							horizonEspio.frames = Paths.getSparrowAtlas('chaotix/new_horizon/espio_bopper', 'exe');
							horizonEspio.animation.addByPrefix('idle', 'espio bopper instance 1', 24);
							horizonEspio.scrollFactor.set(1, 1);
							horizonEspio.setGraphicSize(Std.int(horizonEspio.width * 0.5));
							horizonEspio.antialiasing = true;
							add(horizonEspio);
						}

						horizonTrees = new FlxSprite(-400, 285);
						horizonTrees.loadGraphic(Paths.image('chaotix/new_horizon/trees', 'exe'));
						horizonTrees.scrollFactor.set(1, 1);
						horizonTrees.scale.set(1.1, 1.1);
						horizonTrees.antialiasing = true;
						add(horizonTrees);
						
						if (!ClientPrefs.Optimization) {
							horizonAmy = new FlxSprite(800, 400);
							horizonAmy.frames = Paths.getSparrowAtlas('chaotix/new_horizon/amy_bopper', 'exe');
							horizonAmy.animation.addByPrefix('idle', 'amy bopper instance 1', 24);
							horizonAmy.scrollFactor.set(1, 1);
							horizonAmy.setGraphicSize(Std.int(horizonAmy.width * 0.5));
							horizonAmy.antialiasing = true;
							add(horizonAmy);

							horizonMighty = new FlxSprite(500, 400);
							horizonMighty.frames = Paths.getSparrowAtlas('chaotix/new_horizon/mighty_bopper', 'exe');
							horizonMighty.animation.addByPrefix('idle', 'mighty bopper', 24);
							horizonMighty.scrollFactor.set(1, 1);
							horizonMighty.setGraphicSize(Std.int(horizonMighty.width * 0.5));
							horizonMighty.antialiasing = true;
							add(horizonMighty);

							horizonCharmy = new FlxSprite(675, 200);
							horizonCharmy.frames = Paths.getSparrowAtlas('chaotix/new_horizon/charmy_bopper', 'exe');
							horizonCharmy.animation.addByPrefix('idle', 'charmy bopper', 24);
							horizonCharmy.scrollFactor.set(1, 1);
							horizonCharmy.setGraphicSize(Std.int(horizonCharmy.width * 0.5));
							horizonCharmy.antialiasing = true;
							add(horizonCharmy);
						}
						
						horizonTrees2 = new FlxSprite(-500, 285);
						horizonTrees2.loadGraphic(Paths.image('chaotix/new_horizon/trees2', 'exe'));
						horizonTrees2.scrollFactor.set(1, 1);
						horizonTrees2.scale.set(1.1, 1.1);
						horizonTrees2.antialiasing = true;
						add(horizonTrees2);
						
						if (!ClientPrefs.Optimization) {
							horizonKnuckles = new FlxSprite(-750, 780);
							horizonKnuckles.frames = Paths.getSparrowAtlas('chaotix/new_horizon/knuckles_bopper', 'exe');
							horizonKnuckles.animation.addByPrefix('idle', 'knuckles bopper instance 1', 24);
							horizonKnuckles.scrollFactor.set(0.9, 0.75);
							horizonKnuckles.setGraphicSize(Std.int(horizonKnuckles.width * 0.85));
							horizonKnuckles.antialiasing = true;

							horizonVector = new FlxSprite(750, 700);
							horizonVector.frames = Paths.getSparrowAtlas('chaotix/new_horizon/vector_bopper', 'exe');
							horizonVector.animation.addByPrefix('idle', 'vector bopper', 24);
							horizonVector.scrollFactor.set(0.9, 0.75);
							horizonVector.setGraphicSize(Std.int(horizonVector.width * 0.85));
							horizonVector.antialiasing = true;
						}

						horizonBg.visible = false;
						horizonFloor.visible = false;
						horizonTrees.visible = false;
						horizonTrees2.visible = false;

						horizonPurpur.visible = false;
						horizonYellow.visible = false;
						horizonRed.visible = false;
						
						if (!ClientPrefs.Optimization) {
							horizonAmy.visible = false;
							horizonCharmy.visible = false;
							horizonEspio.visible = false;
							horizonMighty.visible = false;
							horizonKnuckles.visible = false;
							horizonVector.visible = false;
						}
					}
				}
				
			case 'starved-pixel':
				defaultCamZoom = 0.6;
				isPixelStage = true;
				GameOverSubstate.characterName = 'bf-sonic-gameover';
				GameOverSubstate.deathSoundName = 'prey-death';
				GameOverSubstate.loopSoundName = 'prey-gameover';
				GameOverSubstate.endSoundName = 'prey-retry';
				GameOverCameraMove = false;

				stardustBgPixel = new FlxTiledSprite(Paths.image('starved/stardustBg', 'exe'), 4608, 2832, true, true);
				stardustBgPixel.scrollFactor.set(0.4, 0.4);

				stardustFloorPixel = new FlxTiledSprite(Paths.image('starved/stardustFloor', 'exe'), 4608, 2832, true, true);

				stardustBgPixel.visible = false;
				stardustFloorPixel.visible = false;

				stardustFurnace = new FlxSprite(-500, 1450);
				stardustFurnace.frames = Paths.getSparrowAtlas('starved/Furnace_sheet', 'exe');
				stardustFurnace.animation.addByPrefix('idle', 'Furnace idle', 24, true);
				stardustFurnace.animation.play('idle');
				stardustFurnace.scale.x = 6;
				stardustFurnace.scale.y = 6;
				stardustFurnace.antialiasing = false;

				stardustBgPixel.screenCenter();
				stardustFloorPixel.screenCenter();

				add(stardustBgPixel);
				add(stardustFurnace);

			case 'starved':
				GameOverSubstate.deathSoundName = 'starved-death';
				GameOverSubstate.loopSoundName = 'starved-gameover';
				GameOverSubstate.endSoundName = 'starved-retry';
				GameOverSubstate.characterName = 'bf-starved-die';
				GameOverCameraMove = false;

				defaultCamZoom = 0.85;
				
			case 'sl4sh':
				GameOverSubstate.deathSoundName = 'slash-death';
				GameOverSubstate.loopSoundName = 'slash-gameover';
				GameOverSubstate.endSoundName = 'slash-retry';
				GameOverSubstate.characterName = 'bf-slash-death';
				GameOverCameraMove = false;
				
				isPixelStage = true;
				defaultCamZoom = 0.6;
				
				if (!ClientPrefs.PotatoOptimization) {
					slashBg = new BGSprite('slash/slashBackground', 'exe', 560, 500, 1, 0.9);
					slashBg.scale.x = 8.5;
					slashBg.scale.y = 8.5;
					slashBg.antialiasing = false;
					add(slashBg);

					slashAssCracks = new FlxSprite(260, 500);
					slashAssCracks.frames = Paths.getSparrowAtlas('slash/slashCracks', 'exe');
					slashAssCracks.animation.addByPrefix('ass', 'sl4sh background crack eyes', 12);
					slashAssCracks.animation.play('ass');
					slashAssCracks.scale.x = 6.7;
					slashAssCracks.scale.y = 6.7;
					slashAssCracks.antialiasing = false;
					slashAssCracks.scrollFactor.set(1, 0.9);
					add(slashAssCracks);

					slashFloor = new BGSprite('slash/slashFloor', 'exe', 560, 500, 1, 0.9);
					slashFloor.scale.x = 8.5;
					slashFloor.scale.y = 8.5;
					slashFloor.antialiasing = false;
					add(slashFloor);

					slashLava = new FlxSprite(500, slashFloor.y - 50);
					slashLava.frames = Paths.getSparrowAtlas('slash/slashLava', 'exe');
					slashLava.animation.addByPrefix('piss', 'sl4sh background lava', 12);
					slashLava.animation.play('piss');
					slashLava.scale.x = 8.6;
					slashLava.scale.y = 8.6;
					slashLava.antialiasing = false;
					slashLava.scrollFactor.set(1, 0.9);
					add(slashLava);

					slashBgPov = new BGSprite('slash/pov_background', 'exe', 560, 500, 1, 0.9);
					slashBgPov.scale.x = 8.5;
					slashBgPov.scale.y = 8.5;
					slashBgPov.antialiasing = false;
					slashBgPov.visible = false;
					add(slashBgPov);

					slashFloorPov = new BGSprite('slash/povslashisgonnagetcha', 'exe', 560, 500, 1, 0.9);
					slashFloorPov.scale.x = 8.5;
					slashFloorPov.scale.y = 8.5;
					slashFloorPov.antialiasing = false;
					slashFloorPov.visible = false;

					slashLavaPov = new FlxSprite(500, slashFloorPov.y - 50);
					slashLavaPov.frames = Paths.getSparrowAtlas('slash/pov_lava', 'exe');
					slashLavaPov.animation.addByPrefix('dontsuck', 'POV lava', 12);
					slashLavaPov.animation.play('dontsuck');
					slashLavaPov.scale.x = 8.6;
					slashLavaPov.scale.y = 8.6;
					slashLavaPov.antialiasing = false;
					slashLavaPov.visible = false;
					slashLavaPov.scrollFactor.set(1, 0.9);

					add(slashLavaPov);
					add(slashFloorPov);
				}

			case 'xterion':
				if (!ClientPrefs.PotatoOptimization) {
					xterionSky = new BGSprite('xterion/sky', 'exe', -500, 400, 1, 0.9);
					xterionSky.setGraphicSize(Std.int(xterionSky.width * 2.0));
					add(xterionSky);

					xterionFloor = new Floor(-300, 830);
					xterionFloor.setGraphicSize(Std.int(xterionFloor.width * 2));
					add(xterionFloor);
				}
				
			case 'hog':
				defaultCamZoom = 0.68;
				
				if (!ClientPrefs.PotatoOptimization) {
					hogBg = new BGSprite('hog/bg', 'exe', 0, -300, 1.1, 0.9);
					hogBg.scale.x = 1.5;
					hogBg.scale.y = 1.5;
					add(hogBg);

					hogMotain = new BGSprite('hog/motains', 'exe', 0, 0, 1.1, 0.9);
					hogMotain.scale.x = 1.5;
					hogMotain.scale.y = 1.5;
					add(hogMotain);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					hogWaterFalls = new FlxSprite(-1100, 200);
					hogWaterFalls.frames = Paths.getSparrowAtlas('hog/Waterfalls', 'exe');
					hogWaterFalls.animation.addByPrefix('water', 'British', 12);
					hogWaterFalls.animation.play('water');
					hogWaterFalls.scrollFactor.set(1, 1);
					add(hogWaterFalls);

					hogLoops = new FlxSprite(-200, 170);
					hogLoops.frames = Paths.getSparrowAtlas('hog/HillsandHills', 'exe');
					hogLoops.animation.addByPrefix('loops', 'DumbassMF', 12);
					hogLoops.animation.play('loops');
					hogLoops.scrollFactor.set(1, 0.9);
					add(hogLoops);
				}

				if (!ClientPrefs.PotatoOptimization) {
					hogTrees = new BGSprite('hog/trees', 'exe', -600, -120, 1, 0.9);
					add(hogTrees);

					hogFloor = new BGSprite('hog/floor', 'exe', -600, 750, 1, 1);
					hogFloor.scale.x = 1.25;
					hogFloor.scale.y = 1.25;
					add(hogFloor);

					hogRocks = new BGSprite('hog/rocks', 'exe', -500, 600, 1.1, 0.9);
					hogRocks.scale.x = 1.25;
					hogRocks.scale.y = 1.25;

					hogOverlay = new BGSprite('hog/overlay', 'exe', -1000, -300, 1.1, 0.9);
					hogOverlay.scale.x = 1.25;
					hogOverlay.scale.y = 1.25;
				}
				
				if (SONG.song.toLowerCase() == 'manual-blast') {
						if (ClientPrefs.Shaders) {
							camGlitchShader = new GlitchShaderB();
							camGlitchShader.iResolution.value = [FlxG.width, FlxG.height];
							camGlitchFilter = new ShaderFilter(camGlitchShader);

							camFuckShader = new Fuck();
							camFuckFilter = new ShaderFilter(camFuckShader);

							staticlol = new StaticShader();
							staticOverlay = new ShaderFilter(staticlol);
							staticlol.iTime.value = [0];
							staticlol.iResolution.value = [FlxG.width, FlxG.height];
							staticlol.alpha.value = [staticAlpha];
							staticlol.enabled.value = [false];

							glitchThingy = new DistortGlitchShader();
							glitchOverlay = new ShaderFilter(glitchThingy);
							glitchThingy.iTime.value = [0];
							glitchThingy.iResolution.value = [FlxG.width, FlxG.height];
							glitchThingy.enabled.value = [false];
						}
						
						if (!ClientPrefs.PotatoOptimization) {
							scorchedBg = new BGSprite('hog/blast/Sunset', 'exe', -200, 0, 1.1, 0.9);
							scorchedBg.scale.x = 1.75;
							scorchedBg.scale.y = 1.75;
							add(scorchedBg);
			
							scorchedMotain = new BGSprite('hog/blast/Mountains', 'exe', 0, 0, 1.1, 0.9);
							scorchedMotain.scale.x = 1.5;
							scorchedMotain.scale.y = 1.5;
							add(scorchedMotain);
						}
						
						if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
							scorchedWaterFalls = new FlxSprite(-1000, 200);
							scorchedWaterFalls.frames = Paths.getSparrowAtlas('hog/blast/Waterfalls', 'exe');
							scorchedWaterFalls.animation.addByPrefix('water', 'British instance 1', 12);
							scorchedWaterFalls.animation.play('water');
							scorchedWaterFalls.scale.x = 1.1;
							scorchedWaterFalls.scale.y = 1.1;
							scorchedWaterFalls.scrollFactor.set(1, 1);
							add(scorchedWaterFalls);
						
							scorchedHills = new BGSprite('hog/blast/Hills', 'exe', -100, 230, 1, 0.9);
							add(scorchedHills);
			
							scorchedMonitor = new FlxSprite(1100, 265);
							scorchedMonitor.frames = Paths.getSparrowAtlas('hog/blast/Monitor', 'exe');
							scorchedMonitor.animation.addByPrefix('idle', 'Monitor', 12, false);
							scorchedMonitor.animation.addByPrefix('fatal', 'Fatalerror', 12, false);
							scorchedMonitor.animation.addByPrefix('nmi', 'NMI', 12, false);
							scorchedMonitor.animation.addByPrefix('needle', 'Needlemouse', 12, false);
							scorchedMonitor.animation.addByPrefix('starved', 'Storved', 12, false);
							scorchedMonitor.animation.play('idle');
							scorchedMonitor.scrollFactor.set(1, 0.9);
							add(scorchedMonitor);
						}
		
						if (!ClientPrefs.PotatoOptimization) {
							scorchedTrees = new BGSprite('hog/blast/Plants', 'exe', -400, -50, 1, 0.9);
							add(scorchedTrees);
			
							scorchedFloor = new BGSprite('hog/blast/Floor', 'exe', -400, 780, 1, 0.9);
							scorchedFloor.scale.x = 1.25;
							scorchedFloor.scale.y = 1.25;
							add(scorchedFloor);
			
							scorchedRocks = new BGSprite('hog/blast/Rocks', 'exe', -500, 600, 1.1, 0.9);
							scorchedRocks.scale.x = 1.25;
							scorchedRocks.scale.y = 1.25;

							scorchedBg.visible = false;
							scorchedMotain.visible = false;
						}
						if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
							scorchedWaterFalls.visible = false;
							scorchedHills.visible = false;
							scorchedMonitor.visible = false;
						}
						if (!ClientPrefs.PotatoOptimization) {
							scorchedTrees.visible = false;
							scorchedFloor.visible = false;
							scorchedRocks.visible = false;
						}

					}else if(SONG.song.toLowerCase() == 'hedge' && ClientPrefs.Shaders){
						camGlitchShader = new GlitchShaderB();
						camGlitchShader.iResolution.value = [FlxG.width, FlxG.height];
						camGlitchFilter = new ShaderFilter(camGlitchShader);

						staticlol = new StaticShader();
						staticOverlay = new ShaderFilter(staticlol);
						staticlol.iTime.value = [0];
						staticlol.iResolution.value = [FlxG.width, FlxG.height];
						staticlol.alpha.value = [staticAlpha];
						staticlol.enabled.value = [false];

						camFuckShader = new Fuck();
						camFuckFilter = new ShaderFilter(camFuckShader);
						
						curShader = staticOverlay;
						curShaderone = camFuckFilter;
						
						camGame.setFilters([curShader, curShaderone]);
					}
				
			case 'requital':
			
			case 'fakerStage':
				if (!ClientPrefs.PotatoOptimization) {
					var sky:FlxSprite = new FlxSprite(-631.8, -493.15).loadGraphic(Paths.image('fakerBG/sky', 'exe'));
					sky.antialiasing = true;
					sky.scrollFactor.set(1, 1);
					sky.active = false;
					sky.scale.x = 0.9;
					sky.scale.y = 0.9;
					add(sky);

					var mountains:FlxSprite = new FlxSprite(-631.8, -475.5).loadGraphic(Paths.image('fakerBG/mountains', 'exe'));
					mountains.antialiasing = true;
					mountains.scrollFactor.set(1.1, 1);
					mountains.active = false;
					mountains.scale.x = 0.9;
					mountains.scale.y = 0.9;
					add(mountains);
					
					var grass:FlxSprite = new FlxSprite(-631.8, -475.5).loadGraphic(Paths.image('fakerBG/grass', 'exe'));
					grass.antialiasing = true;
					grass.scrollFactor.set(1, 1);
					grass.active = false;
					grass.scale.x = 0.9;
					grass.scale.y = 0.9;
					add(grass);
				}

				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var tree2:FlxSprite = new FlxSprite(-631.8, -475.5).loadGraphic(Paths.image('fakerBG/tree2', 'exe'));
					tree2.antialiasing = true;
					tree2.scrollFactor.set(1.225, 1);
					tree2.active = false;
					tree2.scale.x = 0.9;
					tree2.scale.y = 0.9;
					add(tree2);

					var pillar2:FlxSprite = new FlxSprite(-631.8, -459.55).loadGraphic(Paths.image('fakerBG/pillar2', 'exe'));
					pillar2.antialiasing = true;
					pillar2.scrollFactor.set(1.25, 1);
					pillar2.active = false;
					pillar2.scale.x = 0.9;
					pillar2.scale.y = 0.9;
					add(pillar2);

					var plant:FlxSprite = new FlxSprite(-631.8, -493.15).loadGraphic(Paths.image('fakerBG/plant', 'exe'));
					plant.antialiasing = true;
					plant.scrollFactor.set(1.25, 1);
					plant.active = false;
					plant.scale.x = 0.9;
					plant.scale.y = 0.9;
					add(plant);

					var tree1:FlxSprite = new FlxSprite(-631.8, -493.15).loadGraphic(Paths.image('fakerBG/tree1', 'exe'));
					tree1.antialiasing = true;
					tree1.scrollFactor.set(1.25, 1);
					tree1.active = false;
					tree1.scale.x = 0.9;
					tree1.scale.y = 0.9;
					add(tree1);

					var pillar1:FlxSprite = new FlxSprite(-631.8, -493.15).loadGraphic(Paths.image('fakerBG/pillar1', 'exe'));
					pillar1.antialiasing = true;
					pillar1.scrollFactor.set(1.25, 1);
					pillar1.active = false;
					pillar1.scale.x = 0.9;
					pillar1.scale.y = 0.9;
					add(pillar1);
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					var flower1:FlxSprite = new FlxSprite(-631.8, -493.15).loadGraphic(Paths.image('fakerBG/flower1', 'exe'));
					flower1.antialiasing = true;
					flower1.scrollFactor.set(1.25, 1);
					flower1.active = false;
					flower1.scale.x = 0.9;
					flower1.scale.y = 0.9;
					add(flower1);

					var flower2:FlxSprite = new FlxSprite(-631.8, -493.15).loadGraphic(Paths.image('fakerBG/flower2', 'exe'));
					flower2.antialiasing = true;
					flower2.scrollFactor.set(1.25, 1);
					flower2.active = false;
					flower2.scale.x = 0.9;
					flower2.scale.y = 0.9;
					add(flower2);
				}
				
				fakertransform = new FlxSprite(0, 0);
				fakertransform.frames = Paths.getSparrowAtlas('characters/FakerAndExe/Faker_Transformation');
				fakertransform.animation.addByPrefix('1', 'TransformationRIGHT instance 1');
				fakertransform.animation.addByPrefix('2', 'TransformationLEFT instance 1');
				fakertransform.animation.addByPrefix('3', 'TransformationUP instance 1');
				fakertransform.animation.addByPrefix('4', 'TransformationDOWN instance 1');
				fakertransform.animation.play('1', true);
				fakertransform.animation.play('2', true);
				fakertransform.animation.play('3', true);
				fakertransform.animation.play('4', true);
				fakertransform.alpha = 0;
				
			case 'exestage':
				if (!ClientPrefs.PotatoOptimization) {
					var sSKY:FlxSprite = new FlxSprite(-414, -240.8).loadGraphic(Paths.image('exe/sky', 'exe'));
					sSKY.setGraphicSize(Std.int(sSKY.width * 1.2));
					sSKY.scrollFactor.set(1, 1);
					sSKY.antialiasing = true;
					add(sSKY);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var trees:FlxSprite = new FlxSprite(-290.55, -298.3).loadGraphic(Paths.image('exe/backtrees', 'exe'));
					trees.setGraphicSize(Std.int(trees.width * 1.2));
					trees.scrollFactor.set(1.1, 1);
					trees.antialiasing = true;
					add(trees);

					var bg2:FlxSprite = new FlxSprite(-306, -334.65).loadGraphic(Paths.image('exe/trees', 'exe'));
					bg2.setGraphicSize(Std.int(bg2.width * 1.2));
					bg2.scrollFactor.set(1.2, 1);
					bg2.antialiasing = true;
					add(bg2);
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					var bg:FlxSprite = new FlxSprite(-309.95, -240.2).loadGraphic(Paths.image('exe/ground', 'exe'));
					bg.setGraphicSize(Std.int(bg.width * 1.2));
					bg.scrollFactor.set(1.3, 1);
					bg.antialiasing = true;
					add(bg);
					
					var treelol:FlxSprite = new FlxSprite(-409.95, -340.2);
					treelol.frames = Paths.getSparrowAtlas('exe/BGAnim', 'exe');
					treelol.animation.addByPrefix('fire', 'anim', 24);
					treelol.animation.play('fire');
					treelol.scrollFactor.set(1, 1);
					treelol.antialiasing = true;
					add(treelol);

					var tails:FlxSprite = new FlxSprite(700, 500).loadGraphic(Paths.image('exe/TailsCorpse', 'exe'));
					tails.scrollFactor.set(1, 1);
					tails.antialiasing = true;
					if (ClientPrefs.gore) add(tails);
				}
				
			case 'chotix':

			case 'godspeed':
				if (!ClientPrefs.PotatoOptimization) {
					GSsky = new FlxTiledSprite(Paths.image('bgs/godspeed/sky', 'preload'), 3160, 1825, true, true);
					GSsky.screenCenter();
					GSsky.scrollFactor.set(0.2, 0.2);
					add(GSsky);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					GSbbbg = new FlxTiledSprite(Paths.image('bgs/godspeed/b_b_bg', 'preload'), 3160, 1825, true, true);
					GSbbbg.screenCenter();
					GSbbbg.scrollFactor.set(0.4, 0.4);
					add(GSbbbg);
				}
				
				if (!ClientPrefs.PotatoOptimization) {
					GSbbg = new FlxTiledSprite(Paths.image('bgs/godspeed/b_bg', 'preload'), 3160, 1825, true, true);
					GSbbg.screenCenter();
					GSbbg.scrollFactor.set(0.6, 0.6);
					add(GSbbg);
				
					GSbg = new FlxTiledSprite(Paths.image('bgs/godspeed/bg', 'preload'), 3160, 1825, true, true);
					GSbg.screenCenter();
					GSbg.scrollFactor.set(0.8, 0.8);
					add(GSbg);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					GSplants = new FlxTiledSprite(Paths.image('bgs/godspeed/plants', 'preload'), 3160, 1825, true, true);
					GSplants.screenCenter();
					GSplants.scrollFactor.set(0.8, 0.8);
				}
				
			case 'shine':
				
			case 'founded':
				defaultCamZoom = 0.95;

				if (!ClientPrefs.PotatoOptimization) {
					normalBg = new FlxSprite(-150, -200);
					normalBg.loadGraphic(Paths.image('normal-cd/bg', 'exe'));
					normalBg.scrollFactor.set(1, 1);
					normalBg.antialiasing = true;
					normalBg.scale.set(1.2, 1.2);
					add(normalBg);

					normalDoor = new FlxSprite(-245, -760);
					normalDoor.frames = Paths.getSparrowAtlas('normal-cd/doorbangin', 'exe');
					normalDoor.animation.addByPrefix('idle', 'doorbangin', 24, false);
					normalDoor.scrollFactor.set(1, 1);
					normalDoor.antialiasing = true;
					normalDoor.scale.set(1.2, 1.2);
				}
				
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					normalScreen = new FlxSprite(1600, 150);
					normalScreen.frames = Paths.getSparrowAtlas('normal-cd/bigscreen', 'exe');
					normalScreen.animation.addByPrefix('idle', 'bigscreenstaticfinal', 24, true);
					normalScreen.animation.play('idle');
					normalScreen.scrollFactor.set(1, 1);
					normalScreen.antialiasing = true;
					normalScreen.alpha = 0.5;
					normalScreen.scale.set(1.2, 1.2);
					
					normalChars = new FlxSprite(1650, 235);
					normalChars.frames = Paths.getSparrowAtlas('normal-cd/charactersappear', 'exe');
					normalChars.animation.addByPrefix('chaotix', 'Chaotix Appears', 24, false);
					normalChars.animation.addByPrefix('curse', 'Curse Appears', 24, false);
					normalChars.animation.addByPrefix('rex', 'Revived Appears', 24, false);
					normalChars.animation.addByPrefix('rodent', 'Rodent Appears', 24, false);
					normalChars.animation.addByPrefix('spoiled', 'Spoiled Appears', 24, false);
					normalChars.scrollFactor.set(1, 1);
					normalChars.antialiasing = true;
					normalChars.scale.set(1.2, 1.2);
					add(normalChars);
					add(normalScreen);

					normalTv = new FlxSprite(-150, -200);
					normalTv.loadGraphic(Paths.image('normal-cd/tv', 'exe'));
					normalTv.scrollFactor.set(1, 1);
					normalTv.antialiasing = true;
					normalTv.scale.set(1.2, 1.2);
					add(normalTv);

					normalShadow = new FlxSprite(-150, -220);
					normalShadow.loadGraphic(Paths.image('normal-cd/shadow', 'exe'));
					normalShadow.scrollFactor.set(1, 1);
					normalShadow.antialiasing = true;
					normalShadow.scale.set(1.2, 1.2);
					normalShadow.alpha = 0.8;
					add(normalShadow);
				}

				if (!ClientPrefs.PotatoOptimization) {
					normalVg = new FlxSprite(-150, -200);
					normalVg.loadGraphic(Paths.image('normal-cd/vignette', 'exe'));
					normalVg.scrollFactor.set(1, 1);
					normalVg.antialiasing = true;
					normalVg.scale.set(1.2, 1.2);

					normalFg = new FlxSprite(-150, -200);
					normalFg.loadGraphic(Paths.image('normal-cd/front', 'exe'));
					normalFg.scrollFactor.set(1.1, 1);
					normalFg.antialiasing = true;
					normalFg.scale.set(1.2, 1.2);
				}
				
			case 'my-horizon-wechidna':
				if (ClientPrefs.Shaders) {
					caShader = new ChromaticAbberation(0);
					add(caShader);
					caShader.amount = 0;
					var ca:ShaderFilter = new ShaderFilter(caShader.shader);
					curShader = ca;
					camGame.setFilters([curShader]);
				}
				
			case 'luthy':
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				VHSui = true;
				
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'endeavors', 'endeavors-og':
				if (!ClientPrefs.PotatoOptimization) {
					majinScrollin = new FlxTiledSprite(Paths.image('bgs/endeavors/majin-bg', 'preload'), 2560, 1792, true, true);
					majinScrollin.screenCenter();
					majinScrollin.scrollFactor.set(0.2, 0.2);
					majinScrollin.antialiasing = false;
					add(majinScrollin);
				}
				EndeavorsOGBG = new FlxSpriteGroup();
				EndeavorsOGFG = new FlxSpriteGroup();
				if (!ClientPrefs.PotatoOptimization) {
					var SKY:BGSprite = new BGSprite('FunInfiniteStage/sonicFUNsky', 'exe', -600, -200, 1.0, 1.0);
					EndeavorsOGBG.add(SKY);
				}
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					var bush:BGSprite = new BGSprite('FunInfiniteStage/Bush 1', 'exe', -42, 171, 1.0, 1.0);
					EndeavorsOGBG.add(bush);
					var pillars2:BGSprite = new BGSprite('FunInfiniteStage/Majin Boppers Back', 'exe', 182, -100, 1.0, 1.0, ['MajinBop2 instance 1'], true);
					EndeavorsOGBG.add(pillars2);
					var bush2:BGSprite = new BGSprite('FunInfiniteStage/Bush2', 'exe', 132, 354, 1.0, 1.0);
					EndeavorsOGBG.add(bush2);
					var pillars1:BGSprite = new BGSprite('FunInfiniteStage/Majin Boppers Front', 'exe', -169, -167, 1.0, 1.0, ['MajinBop1 instance 1'], true);
					EndeavorsOGBG.add(pillars1);
				}
				if (!ClientPrefs.PotatoOptimization) {
					var floor:BGSprite = new BGSprite('FunInfiniteStage/floor BG', 'exe', -340, 660, 1.0, 1.0);
					EndeavorsOGBG.add(floor);
					fgmajin = new BGSprite('FunInfiniteStage/majin FG1', 'exe', 1126, 903, 1.0, 1.0, ['majin front bopper1'], true);
					fgmajin2 = new BGSprite('FunInfiniteStage/majin FG2', 'exe', -393, 871, 1.0, 1.0, ['majin front bopper2'], true);
				}
				add(EndeavorsOGBG);

			case 'lumpy':
				GameOverCameraMove = false;
				//GameOverSubstate.loopSoundName = 'gameOver_LordX';
				//GameOverSubstate.endSoundName = 'gameOverEnd_LordX';
				GameOverSubstate.characterName = 'lumpy-bf-gameover';
			
			default:
		}
		
		#if windows
		switch (SONG.song.toLowerCase()) {
			case 'fatality' | 'critical-error' | 'unresponsive' | 'fatality-encore':
				lime.app.Application.current.window.title = "1'll d3lete y0u";
				var Icon:Image = Image.fromFile('assets/exe/images/windowIcons/iconFatal.png');
				lime.app.Application.current.window.setIcon(Icon);
				customIconAndName = true;
			default:
				if (!customIconAndName)
					lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase();
		}
		#end
		
		if ((isFreeplay || isEncore || isExtras || isSound || (isSound && isStoryMode)) && SONG.song.toLowerCase() != 'our-horizon' && SONG.arrowSkin != 'NOTE_SUNKEH' && !isRing && !chartingMode && !isPixelStage && !pixelNoteGenesis && ((SONG.splashSkin == null || SONG.splashSkin == 'BloodSplash' || SONG.splashSkin == 'arrows/noteSplashes' || SONG.splashSkin == 'slash-splash' || SONG.splashSkin == 'arrows/noteSplashes-COLOR') || (SONG.arrowSkin == null || SONG.arrowSkin == 'arrows/NOTE_assets' || SONG.arrowSkin == 'PIXELNOTE_assets' || SONG.arrowSkin == 'arrows/NOTE_assets-COLOR')))
			noteChangesFromTheStore = true;
		else
			noteChangesFromTheStore = false;
		
		var defaultSplash:Bool = false;
		switch(SONG.song.toLowerCase()) {
			case 'jingle-hells', 'missiletoe', 'slaybells': //Christmas
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[-45, 10, -10], [75, 40, -15], [-45, 10, -10], [75, 40, -15]];
			case 'endeavors', 'endeavors-og', 'call-of-justice', 'call-of-justice-old', 'endless-encore', 'gotta-go', 'oxxynless', 'endless', 'endless-og': //Majin
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[-150, 0, 30], [-150, 0, 30], [-150, 0, 30], [-150, 0, 30]];
			case 'endless-us': //Blue
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[-165, -5, 30], [-165, -5, 30], [-165, -5, 30], [-165, -5, 30]];
			case 'endless-jp': //Purple
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[-155, -5, 30], [-155, -5, 30], [-155, -5, 30], [-155, -5, 30]];
			case 'chaos', 'chaos-encore', 'running-wild', 'terror': //Super
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
			case 'hollow', 'hollow-old', 'hollow-encore', 'empty': //Void
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[180, 0, 0], [180, 0, 0], [180, 0, 0], [180, 0, 0]];
			case 'fake-baby': //Dark Gray
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[0, -100, -80], [0, -100, -80], [0, -100, -80], [0, -100, -80]];
			case 'color-blind', 'color-blind-old', 'color-blind-encore': //Gray
				defaultSplash = true;
				if (!ClientPrefs.arrowColorsRGB) customNoteColors = true;
				customArrowColors = [[0, -100, -10], [0, -100, -10], [0, -100, -10], [0, -100, -10]];
			case 'animosity', 'reunion', 'ugly', 'hedge', 'her-world', 'her-world-encore', 'her-world-old', 'insidious', 'lukas-world', 'malediction', 'extricate-hex', 'miasma', 'personel', 'personel-serious', 'relax', 'soured', 'substantial', 'thunderbolt', 'shocker', 'extreme-zap': //Default Splashes
				defaultSplash = true;
		}
		var colNotesPrefix:String = '';
		if (customNoteColors)
			colNotesPrefix = '-COLOR';
		if (!isPixelStage && !pixelNoteGenesis && !fatalUI && !isRing) {
			if (SONG.splashSkin != 'milkSplashes' && SONG.splashSkin != 'hitmarker') {
				if (noteChangesFromTheStore)
					SONG.splashSkin = 'arrows/'+ClientPrefs.arrowSplash+colNotesPrefix;
				else
					SONG.splashSkin = 'arrows/noteSplashes'+colNotesPrefix;
				if (!defaultSplash && ClientPrefs.arrowSplash == 'noteSplashes')
					SONG.splashSkin = 'BloodSplash';
			}
		}
		
		preload('arrows/'+ClientPrefs.arrowSkin+colNotesPrefix, 'shared');
		preload('arrows/'+ClientPrefs.arrowSplash+colNotesPrefix, 'shared');
		
		if (anticheat) {
			switch (SONG.song.toLowerCase()) {
				//Story Mode
				case 'you-cant-run':
					if ((!ClientPrefs.SongsCompleted.contains('too-slow') || !ClientPrefs.SongsCompleted.contains('you-cant-run')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'triple-trouble':
					if ((!ClientPrefs.SongsCompleted.contains('you-cant-run') || !ClientPrefs.SongsCompleted.contains('triple-trouble')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'final-escape':
					if ((!ClientPrefs.SongsCompleted.contains('triple-trouble') || !ClientPrefs.SongsCompleted.contains('final-escape')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'face-off':
					if ((!ClientPrefs.SongsCompleted.contains('final-escape') || !ClientPrefs.SongsCompleted.contains('face-off')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'coulrophobia':
					if ((!ClientPrefs.SongsCompleted.contains('face-off') || !ClientPrefs.SongsCompleted.contains('coulrophobia')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'broken-heart':
					if ((!ClientPrefs.SongsCompleted.contains('coulrophobia') || !ClientPrefs.SongsCompleted.contains('broken-heart')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'tribal':
					if ((!ClientPrefs.SongsCompleted.contains('broken-heart') || !ClientPrefs.SongsCompleted.contains('tribal')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'goddess':
					if ((!ClientPrefs.SongsCompleted.contains('tribal') || !ClientPrefs.SongsCompleted.contains('goddess')) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
			
				// Sound Test
				case 'oxxynless':
					if (!ClientPrefs.SongsCompleted.contains('oxxynless') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'old-ycr-slaps':
					if (!ClientPrefs.SongsCompleted.contains('old-ycr-slaps') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
					
				// Freeplay Songs
				case 'endless' | 'endless-og' | 'endless-jp' | 'endless-us' | 'endeavors':
					if (!ClientPrefs.charactersUnlocked.contains('majin') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'hollow' | 'empty':
					if (!ClientPrefs.charactersUnlocked.contains('devoid') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'execution' | 'cycles' | 'hellbent' | 'fate' | 'judgement' | 'gatekeepers':
					if (!ClientPrefs.charactersUnlocked.contains('lord x') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'sunshine' | 'soulless':
					if (!ClientPrefs.charactersUnlocked.contains('tails doll') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'forever-unnamed':
					if (!ClientPrefs.charactersUnlocked.contains('no name') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'agony':
					if (!ClientPrefs.charactersUnlocked.contains('sally alt') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'hellstorm' | 'sharpy-showdown':
					if (!ClientPrefs.charactersUnlocked.contains('exetior') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'chaos' | 'running-wild' | 'heroes-and-villains':
					if (!ClientPrefs.charactersUnlocked.contains('fleetway') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'fatality' | 'critical-error':
					if (!ClientPrefs.charactersUnlocked.contains('fatal error') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'prey' | 'fight-or-flight':
					if (!ClientPrefs.charactersUnlocked.contains('furnace') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'digitalized' | 'substantial':
					if (!ClientPrefs.charactersUnlocked.contains('xterion') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'expulsion':
					if (!ClientPrefs.charactersUnlocked.contains('educator') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'found-you':
					if (!ClientPrefs.charactersUnlocked.contains('normal cd') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'relax' | 'round-a-bout' | 'spike-trap':
					if (!ClientPrefs.charactersUnlocked.contains('needlemouse') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'her-world':
					if (!ClientPrefs.charactersUnlocked.contains('luther') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'milk':
					if (!ClientPrefs.charactersUnlocked.contains('sunky') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'too-fest':
					if (!ClientPrefs.charactersUnlocked.contains('sanic') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'personel' | 'personel-serious':
					if (!ClientPrefs.charactersUnlocked.contains('coldsteel') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'shocker' | 'extreme-zap':
					if (!ClientPrefs.charactersUnlocked.contains('sonichu') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'animosity' | 'reunion':
					if (!ClientPrefs.charactersUnlocked.contains('futagami') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'soured':
					if (!ClientPrefs.charactersUnlocked.contains('sonic.lmn') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'ugly':
					if (!ClientPrefs.charactersUnlocked.contains('ugly sonic') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'frenzy':
					if (!ClientPrefs.charactersUnlocked.contains('lumpy sonic') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'melting' | 'confronting':
					if (!ClientPrefs.charactersUnlocked.contains('melthog') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'faker' | 'black-sun' | 'godspeed':
					if (!ClientPrefs.charactersUnlocked.contains('faker') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'my-horizon' | 'our-horizon':
					if (!ClientPrefs.charactersUnlocked.contains('chaotix') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'forestall-desire':
					if (!ClientPrefs.charactersUnlocked.contains('requital') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'hedge' | 'manual-blast':
					if (!ClientPrefs.charactersUnlocked.contains('hog') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'envy' | 'gorefest' | 'lurk' | 'skincrawler':
					if (!ClientPrefs.charactersUnlocked.contains('grimeware') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'malediction':
					if (!ClientPrefs.charactersUnlocked.contains('curse') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'extricate-hex':
					if (!ClientPrefs.charactersUnlocked.contains('curse') && chartingMode || !ClientPrefs.SongsCompleted.contains('malediction') || !ClientPrefs.UnlockedEndings.contains('curse-good'))
						MusicBeatState.switchState(new NoCheating());
				case 'unblessful-hedgehog':
					if (!ClientPrefs.charactersUnlocked.contains('curse') && chartingMode || !ClientPrefs.SongsCompleted.contains('malediction') || !ClientPrefs.UnlockedEndings.contains('curse-bad'))
						MusicBeatState.switchState(new NoCheating());
				case 'color-blind':
					if (!ClientPrefs.charactersUnlocked.contains('mono.bw') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'fake-baby':
					if (!ClientPrefs.charactersUnlocked.contains('nmi') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'miasma':
					if (!ClientPrefs.charactersUnlocked.contains('dsk') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'insidious' | 'haze' | 'marauder':
					if (!ClientPrefs.charactersUnlocked.contains('demogri') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'burning':
					if (!ClientPrefs.charactersUnlocked.contains('shp and genesys') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'perdition' | 'underworld' | 'purgatory':
					if (!ClientPrefs.charactersUnlocked.contains('satanos') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'genesis' | 'proverbs' | 'corinthians' | 'revelations':
					if (!ClientPrefs.charactersUnlocked.contains('apollyon') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'life-and-death' | 'gods-will':
					if (!ClientPrefs.charactersUnlocked.contains('bratwurst') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'b4cksl4sh':
					if (!ClientPrefs.charactersUnlocked.contains('sl4sh') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'missiletoe' | 'slaybells' | 'jingle-hells':
					if (!ClientPrefs.charactersUnlocked.contains('christmas') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'gotta-go' | 'call-of-justice':
					if (!ClientPrefs.charactersUnlocked.contains('batman') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'mania':
					if (!ClientPrefs.charactersUnlocked.contains('sh-tails') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'universal-collapse' | 'planestrider':
					if (!ClientPrefs.charactersUnlocked.contains('omw') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'too-far' | 'last-hope':
					if (!ClientPrefs.charactersUnlocked.contains('gameover') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'too-far-alt':
					if (!ClientPrefs.charactersUnlocked.contains('gameover') && chartingMode || !ClientPrefs.SongsCompleted.contains('too-far'))
						MusicBeatState.switchState(new NoCheating());
					
				//Encore
				case 'too-slow-encore' | 'you-cant-run-encore' | 'triple-trouble-encore':
					if (!ClientPrefs.EncoreUnlocked && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'too-slow-encore-alt':
					if (!ClientPrefs.EncoreUnlocked && chartingMode || !ClientPrefs.SongsCompleted.contains('too-slow-encore'))
						MusicBeatState.switchState(new NoCheating());
				case 'cycles-encore':
					if (!ClientPrefs.SongsCompleted.contains('cycles') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'endless-encore':
					if (!ClientPrefs.SongsCompleted.contains('endless') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'sunshine-encore':
					if (!ClientPrefs.SongsCompleted.contains('sunshine') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'faker-encore':
					if (!ClientPrefs.SongsCompleted.contains('faker') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'chaos-encore':
					if (!ClientPrefs.SongsCompleted.contains('chaos') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'fatality-encore':
					if (!ClientPrefs.SongsCompleted.contains('fatality') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'round-a-bout-encore':
					if (!ClientPrefs.SongsCompleted.contains('round-a-bout') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'her-world-encore':
					if (!ClientPrefs.SongsCompleted.contains('her-world') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'hollow-encore':
					if (!ClientPrefs.SongsCompleted.contains('hollow') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				case 'color-blind-encore':
					if (!ClientPrefs.SongsCompleted.contains('color-blind') && chartingMode)
						MusicBeatState.switchState(new NoCheating());
				
				//Extras
				case 'her-world-old' | 'long-sky' | 'too-fest-old' | 'tetrabrachial' | 'my-horizon-wechidna' | 'perdition-apollyon' | 'gotta-go-red-glove' | 'hollow-old' | 'ice-cap' | 'haze-og' | 'cool-party' | 'call-of-justice-old' | 'hill-of-the-void' | 'execution-inski' | 'melting-old' | 'color-blind-old' | 'playful' | 'drippyshine' | 'lukas-world' | 'terror' | 'unresponsive' | 'endeavors-og' | 'nostalgic-duo' | 'thunderbolt':
					if ((ClientPrefs.storyProgressExe != 5 || ClientPrefs.storyProgressAlt != 4) && chartingMode)
						MusicBeatState.switchState(new NoCheating());
			}
		}
		
		//Preload Shit
		CoolUtil.precacheMusic('storymodemenumusic');
		CoolUtil.precacheMusic('storymode');
		CoolUtil.precacheMusic('encoremode');
		CoolUtil.precacheMusic('freeplaymode');
		CoolUtil.precacheMusic('extras');
		CoolUtil.precacheMusic('options');
		preload('RedVG', 'exe');
		preload('WhiteVG', 'exe');
		preload('simplejump', 'exe');
		preload('grimbojump', 'exe');
		preload('epicjump', 'exe');
		preload('pauseStuff/pauseTop', 'shared');
		preload('pauseStuff/bottomPanel', 'shared');
		preload('pauseStuff/graybut', 'shared');
		preload('pauseStuff/blackbut', 'shared');
		preload('pauseStuff/Exittomenu', 'shared');
		preload('pauseStuff/RestartSong', 'shared');
		preload('pauseStuff/Resume', 'shared');
		preload('timeBar', 'shared');
		if (!stageData.isPixelStage) {
			preload('num0');
			preload('num1');
			preload('num2');
			preload('num3');
			preload('num4');
			preload('num5');
			preload('num6');
			preload('num7');
			preload('num8');
			preload('num9');
			preload('sick', 'shared');
			preload('good', 'shared');
			preload('bad', 'shared');
			preload('shit', 'shared');
			preload('combo', 'shared');
		}
		if (SONG.song.toLowerCase() == 'color-blind' || SONG.song.toLowerCase() == 'color-blind-old' || SONG.song.toLowerCase() == 'color-blind-encore') {
			preload('monoRating/num0-m', 'shared');
			preload('monoRating/num1-m', 'shared');
			preload('monoRating/num2-m', 'shared');
			preload('monoRating/num3-m', 'shared');
			preload('monoRating/num4-m', 'shared');
			preload('monoRating/num5-m', 'shared');
			preload('monoRating/num6-m', 'shared');
			preload('monoRating/num7-m', 'shared');
			preload('monoRating/num8-m', 'shared');
			preload('monoRating/num9-m', 'shared');
			preload('monoRating/sick-m', 'shared');
			preload('monoRating/good-m', 'shared');
			preload('monoRating/bad-m', 'shared');
			preload('monoRating/shit-m', 'shared');
			preload('monoRating/combo-m', 'shared');
		}
		if (stageData.isPixelStage) {
			preload('pixelUI/num0-pixel');
			preload('pixelUI/num1-pixel');
			preload('pixelUI/num2-pixel');
			preload('pixelUI/num3-pixel');
			preload('pixelUI/num4-pixel');
			preload('pixelUI/num5-pixel');
			preload('pixelUI/num6-pixel');
			preload('pixelUI/num7-pixel');
			preload('pixelUI/num8-pixel');
			preload('pixelUI/num9-pixel');
			preload('pixelUI/sick-pixel');
			preload('pixelUI/good-pixel');
			preload('pixelUI/bad-pixel');
			preload('pixelUI/shit-pixel');
			preload('pixelUI/combo-pixel');
		}
			
		preload('box');
		CoolUtil.precacheSound('spook', 'preload');
		CoolUtil.precacheSound('spooky', 'preload');
		CoolUtil.precacheSound('sppok', 'preload');
		
		#if desktop
		if (discordSongPic && !isSound) {
			if (chartingMode) DiscordClient.smallImageRpc = 'chart-editor';
			switch (SONG.song.toLowerCase())
			{
				//Story Mode
				case 'too-slow': DiscordClient.imageRpc = 'too-slow';
				case 'you-cant-run': DiscordClient.imageRpc = 'you-cant-run';
				case 'triple-trouble': DiscordClient.imageRpc = 'triple-trouble';
				case 'final-escape': DiscordClient.imageRpc = 'final-escape';
				case 'face-off': DiscordClient.imageRpc = 'face-off';
				case 'coulrophobia': DiscordClient.imageRpc = 'coulrophobia';
				case 'broken-heart': DiscordClient.imageRpc = 'broken-heart';
				case 'tribal': DiscordClient.imageRpc = 'tribal';
				case 'goddess': DiscordClient.imageRpc = 'goddess';
			
				// Freeplay Songs
				case 'endless' | 'endless-og' | 'endless-jp' | 'endless-us': DiscordClient.imageRpc = 'majin';
				case 'endeavors': DiscordClient.imageRpc = 'endeavors';
				case 'hollow' | 'empty': DiscordClient.imageRpc = 'devoid';
				case 'execution' | 'cycles': DiscordClient.imageRpc = 'lord-x';
				case 'hellbent': DiscordClient.imageRpc = 'hellbent';
				case 'fate': DiscordClient.imageRpc = 'fate';
				case 'judgement': DiscordClient.imageRpc = 'judgement';
				case 'gatekeepers': DiscordClient.imageRpc = 'guardians';
				case 'sunshine': DiscordClient.imageRpc = 'tails-doll';
				case 'soulless': DiscordClient.imageRpc = 'soulless';
				case 'forever-unnamed': DiscordClient.imageRpc = 'no-name';
				case 'agony': DiscordClient.imageRpc = 'sally-alt';
				case 'hellstorm' | 'sharpy-showdown': DiscordClient.imageRpc = 'exetior';
				case 'chaos' | 'running-wild' | 'heroes-and-villains': DiscordClient.imageRpc = 'fleetway';
				case 'fatality': DiscordClient.imageRpc = 'fatal-error';
				case 'critical-error': DiscordClient.imageRpc = 'critical-error';
				case 'prey': DiscordClient.imageRpc = 'furnace';
				case 'fight-or-flight': DiscordClient.imageRpc = 'starved';
				case 'substantial': DiscordClient.imageRpc = 'xterion';
				case 'digitalized': DiscordClient.imageRpc = 'digitalized';
				case 'expulsion': DiscordClient.imageRpc = 'educator';
				case 'found-you': DiscordClient.imageRpc = 'normal-cd';
				case 'relax': DiscordClient.imageRpc = 'needlemouse';
				case 'round-a-bout': DiscordClient.imageRpc = 'roundabout';
				case 'spike-trap': DiscordClient.imageRpc = 'spike-trap';
				case 'her-world': DiscordClient.imageRpc = 'luther';
				case 'milk': DiscordClient.imageRpc = 'sunky';
				case 'too-fest': DiscordClient.imageRpc = 'sanic';
				case 'personel': DiscordClient.imageRpc = 'coldsteel';
				case 'personel-serious': DiscordClient.imageRpc = 'coldsteel-serious';
				case 'shocker' | 'extreme-zap': DiscordClient.imageRpc = 'sonichu';
				case 'animosity' | 'reunion': DiscordClient.imageRpc = 'futagami';
				case 'soured': DiscordClient.imageRpc = 'sonic_lmn';
				case 'ugly': DiscordClient.imageRpc = 'ugly-sonic';
				case 'frenzy': DiscordClient.imageRpc = 'lumpy-sonic';
				case 'melting': DiscordClient.imageRpc = 'melthog';
				case 'confronting': DiscordClient.imageRpc = 'confronting';
				case 'faker': DiscordClient.imageRpc = 'faker';
				case 'black-sun': DiscordClient.imageRpc = 'exe';
				case 'godspeed': DiscordClient.imageRpc = 'godspeed';
				case 'my-horizon' | 'our-horizon': DiscordClient.imageRpc = 'chaotix';
				case 'forestall-desire': DiscordClient.imageRpc = 'requital';
				case 'manual-blast': DiscordClient.imageRpc = 'scorched';
				case 'hedge': DiscordClient.imageRpc = 'hog';
				case 'envy' | 'gorefest' | 'lurk' | 'skincrawler': DiscordClient.imageRpc = 'grimeware';
				case 'malediction' | 'extricate-hex' | 'unblessful-hedgehog': DiscordClient.imageRpc = 'curse';
				case 'color-blind': DiscordClient.imageRpc = 'mono_bw';
				case 'fake-baby': DiscordClient.imageRpc = 'nmi';
				case 'miasma': DiscordClient.imageRpc = 'dsk';
				case 'insidious': DiscordClient.imageRpc = 'insidious';
				case 'haze': DiscordClient.imageRpc = 'haze';
				case 'marauder': DiscordClient.imageRpc = 'demogri-and-griatos';
				case 'burning': DiscordClient.imageRpc = 'shp-and-genesys';
				case 'perdition' | 'underworld' | 'purgatory': DiscordClient.imageRpc = 'satanos';
				case 'genesis': DiscordClient.imageRpc = 'genesis';
				case 'corinthians': DiscordClient.imageRpc = 'apollyon';
				case 'life-and-death' | 'gods-will': DiscordClient.imageRpc = 'bratwurst';
				case 'b4cksl4sh': DiscordClient.imageRpc = 'sl4sh';
				case 'missiletoe' | 'slaybells' | 'jingle-hells': DiscordClient.imageRpc = 'christmas';
				case 'gotta-go' | 'call-of-justice': DiscordClient.imageRpc = 'batman';
				case 'mania': DiscordClient.imageRpc = 'sh-tails';
				case 'universal-collapse' | 'planestrider': DiscordClient.imageRpc = 'omw';
				case 'too-far' | 'too-far-alt' | 'last-hope': DiscordClient.imageRpc = 'gameover';
					
				//Encore
				case 'too-slow-encore' | 'too-slow-encore-alt': DiscordClient.imageRpc = 'too_slow_encore';
				case 'you-cant-run-encore': DiscordClient.imageRpc = 'you_cant_run_encore';
				case 'triple-trouble-encore': DiscordClient.imageRpc = 'triple_trouble_encore';
				case 'cycles-encore': DiscordClient.imageRpc = 'cycles_encore';
				case 'endless-encore': DiscordClient.imageRpc = 'endless_encore';
				case 'sunshine-encore': DiscordClient.imageRpc = 'sunshine_encore';
				case 'faker-encore': DiscordClient.imageRpc = 'faker_encore';
				case 'chaos-encore': DiscordClient.imageRpc = 'chaos_encore';
				case 'fatality-encore': DiscordClient.imageRpc = 'fatality_encore';
				case 'round-a-bout-encore': DiscordClient.imageRpc = 'round_a_bout_encore';
				case 'her-world-encore': DiscordClient.imageRpc = 'her_world_encore';
				case 'hollow-encore': DiscordClient.imageRpc = 'hollow_encore';
				case 'color-blind-encore': DiscordClient.imageRpc = 'color_blind_encore';
				
				//Extras
				case 'her-world-old' | 'long-sky' | 'too-fest-old' | 'tetrabrachial' | 'my-horizon-wechidna' | 'perdition-apollyon' | 'gotta-go-red-glove' | 'hollow-old' | 'ice-cap' | 'haze-og' | 'cool-party' | 'call-of-justice-old' | 'hill-of-the-void' | 'execution-inski' | 'melting-old' | 'color-blind-old' | 'playful' | 'drippyshine' | 'lukas-world' | 'terror' | 'unresponsive' | 'endeavors-og' | 'nostalgic-duo' | 'thunderbolt': DiscordClient.imageRpc = 'extras-songs';
			}
		}
		if (discordSongPic && isSound) {
			DiscordClient.imageRpc = 'sound-test';
			if (!chartingMode) {
				switch (SONG.song.toLowerCase())
				{
					default: DiscordClient.smallImageRpc = '';
					case 'endless' | 'endless-og' | 'endless-jp' | 'endless-us': DiscordClient.smallImageRpc = 'majin';
					case 'endeavors': DiscordClient.smallImageRpc = 'endeavors';
					case 'hollow' | 'empty': DiscordClient.smallImageRpc = 'devoid';
					case 'execution' | 'cycles': DiscordClient.smallImageRpc = 'lord-x';
					case 'hellbent': DiscordClient.smallImageRpc = 'hellbent';
					case 'fate': DiscordClient.smallImageRpc = 'fate';
					case 'judgement': DiscordClient.smallImageRpc = 'judgement';
					case 'gatekeepers': DiscordClient.smallImageRpc = 'guardians';
					case 'sunshine': DiscordClient.smallImageRpc = 'tails-doll';
					case 'soulless': DiscordClient.smallImageRpc = 'soulless';
					case 'forever-unnamed': DiscordClient.smallImageRpc = 'no-name';
					case 'agony': DiscordClient.smallImageRpc = 'sally-alt';
					case 'hellstorm' | 'sharpy-showdown': DiscordClient.smallImageRpc = 'exetior';
					case 'chaos' | 'running-wild' | 'heroes-and-villains': DiscordClient.smallImageRpc = 'fleetway';
					case 'fatality': DiscordClient.smallImageRpc = 'fatal-error';
					case 'critical-error': DiscordClient.smallImageRpc = 'critical-error';
					case 'prey': DiscordClient.smallImageRpc = 'furnace';
					case 'fight-or-flight': DiscordClient.smallImageRpc = 'starved';
					case 'substantial': DiscordClient.smallImageRpc = 'xterion';
					case 'digitalized': DiscordClient.smallImageRpc = 'digitalized';
					case 'expulsion': DiscordClient.smallImageRpc = 'educator';
					case 'found-you': DiscordClient.smallImageRpc = 'normal-cd';
					case 'relax': DiscordClient.smallImageRpc = 'needlemouse';
					case 'round-a-bout': DiscordClient.smallImageRpc = 'roundabout';
					case 'spike-trap': DiscordClient.smallImageRpc = 'spike-trap';
					case 'her-world': DiscordClient.smallImageRpc = 'luther';
					case 'milk': DiscordClient.smallImageRpc = 'sunky';
					case 'too-fest': DiscordClient.smallImageRpc = 'sanic';
					case 'personel': DiscordClient.smallImageRpc = 'coldsteel';
					case 'personel-serious': DiscordClient.smallImageRpc = 'coldsteel-serious';
					case 'shocker' | 'extreme-zap': DiscordClient.smallImageRpc = 'sonichu';
					case 'animosity' | 'reunion': DiscordClient.smallImageRpc = 'futagami';
					case 'soured': DiscordClient.smallImageRpc = 'sonic_lmn';
					case 'ugly': DiscordClient.smallImageRpc = 'ugly-sonic';
					case 'frenzy': DiscordClient.smallImageRpc = 'lumpy-sonic';
					case 'melting': DiscordClient.smallImageRpc = 'melthog';
					case 'confronting': DiscordClient.smallImageRpc = 'confronting';
					case 'faker': DiscordClient.smallImageRpc = 'faker';
					case 'black-sun': DiscordClient.smallImageRpc = 'exe';
					case 'godspeed': DiscordClient.smallImageRpc = 'godspeed';
					case 'my-horizon' | 'our-horizon': DiscordClient.smallImageRpc = 'chaotix';
					case 'forestall-desire': DiscordClient.smallImageRpc = 'requital';
					case 'manual-blast': DiscordClient.smallImageRpc = 'scorched';
					case 'hedge': DiscordClient.smallImageRpc = 'hog';
					case 'envy' | 'gorefest' | 'lurk' | 'skincrawler': DiscordClient.smallImageRpc = 'grimeware';
					case 'malediction' | 'extricate-hex' | 'unblessful-hedgehog': DiscordClient.smallImageRpc = 'curse';
					case 'color-blind': DiscordClient.smallImageRpc = 'mono_bw';
					case 'fake-baby': DiscordClient.smallImageRpc = 'nmi';
					case 'miasma': DiscordClient.smallImageRpc = 'dsk';
					case 'insidious': DiscordClient.smallImageRpc = 'insidious';
					case 'haze': DiscordClient.smallImageRpc = 'haze';
					case 'marauder': DiscordClient.smallImageRpc = 'demogri-and-griatos';
					case 'burning': DiscordClient.smallImageRpc = 'shp-and-genesys';
					case 'perdition' | 'underworld' | 'purgatory': DiscordClient.smallImageRpc = 'satanos';
					case 'genesis': DiscordClient.smallImageRpc = 'genesis';
					case 'corinthians': DiscordClient.smallImageRpc = 'apollyon';
					case 'life-and-death' | 'gods-will': DiscordClient.smallImageRpc = 'bratwurst';
					case 'b4cksl4sh': DiscordClient.smallImageRpc = 'sl4sh';
					case 'missiletoe' | 'slaybells' | 'jingle-hells': DiscordClient.smallImageRpc = 'christmas';
					case 'gotta-go' | 'call-of-justice': DiscordClient.smallImageRpc = 'batman';
					case 'mania': DiscordClient.smallImageRpc = 'sh-tails';
					case 'universal-collapse' | 'planestrider': DiscordClient.smallImageRpc = 'omw';
					case 'too-far' | 'too-far-alt' | 'last-hope': DiscordClient.smallImageRpc = 'gameover';
				}
			} else {
				DiscordClient.smallImageRpc = 'chart-editor';
			}
		}
		DiscordClient.changePresence();
		#end
		
		preload('hitStatic', 'exe');
		preload('staticBACKGROUND2-g', 'exe');
		CoolUtil.precacheSound('hitStatic1');
		preload('fatal-static', 'shared');
		CoolUtil.precacheSound('fatal-static');
		
		switch (SONG.song.toLowerCase())
		{
			case 'too-slow-encore' | 'too-slow-encore-alt' | 'you-cant-run-encore' | 'triple-trouble-encore':
				devoidUI = false;
				xenoEncUI = true;
				xenoEncFix = true;
			case 'hollow' | 'empty' | 'hollow-encore' | 'hollow-old':
				devoidUI = true;
				xenoEncUI = false;
				xenoEncFix = false;
			default:
				devoidUI = false;
				xenoEncUI = false;
				xenoEncFix = false;
		}
		
		if (SONG.song.toLowerCase() == 'execution' || SONG.song.toLowerCase() == 'cycles' || SONG.song.toLowerCase() == 'hellbent' || SONG.song.toLowerCase() == 'fate' || SONG.song.toLowerCase() == 'judgement' ||  SONG.song.toLowerCase() == 'gotta-go-red-glove' ||  SONG.song.toLowerCase() == 'execution-inski') {
			GameOverCameraMove = false;
			GameOverSubstate.loopSoundName = 'lordx-gameover';
			GameOverSubstate.endSoundName = 'lordx-retry';
			GameOverSubstate.characterName = 'LordXGameOver';
		}
		
		if (SONG.song.toLowerCase() == 'cycles-encore') {
			GameOverCameraMove = false;
			GameOverSubstate.loopSoundName = 'encorelordx-gameover';
			GameOverSubstate.endSoundName = 'lordx-retry';
			GameOverSubstate.characterName = 'cycles-encore-death';
		}
		
		if (isPixelStage) introSoundsSuffix = '-pixel';
		
		if (SONG.song.toLowerCase() == 'sunshine' || SONG.song.toLowerCase() == 'drippyshine' || SONG.song.toLowerCase() == 'soulless' || SONG.song.toLowerCase() == 'sunshine-encore') GameOverCameraMove = false;
		
		if (SONG.song.toLowerCase() == 'too-slow' || SONG.song.toLowerCase() == 'you-cant-run' || SONG.song.toLowerCase() == 'triple-trouble' || SONG.song.toLowerCase() == 'final-escape' || SONG.song.toLowerCase() == 'hill-of-the-void') {
			GameOverCameraMove = false;
			GameOverSubstate.characterName = 'bf-exe-death';
			preload('sonicJUMPSCARE', 'exe');
		}
		
		if (SONG.song.toLowerCase() == 'too-slow-encore' || SONG.song.toLowerCase() == 'too-slow-encore-alt' || SONG.song.toLowerCase() == 'you-cant-run-encore' || SONG.song.toLowerCase() == 'triple-trouble-encore') {
			GameOverCameraMove = false;
			GameOverSubstate.characterName = 'bf-exe-death';
			if (SONG.song.toLowerCase() == 'too-slow-encore' || SONG.song.toLowerCase() == 'too-slow-encore-alt') preload('sonicJUMPSCARE', 'exe');
			CoolUtil.precacheSound('jumpscare', 'exe');
			CoolUtil.precacheSound('datOneSound', 'exe');
		}
		
		if (SONG.song.toLowerCase() == 'you-cant-run') {
			preload('characters/BF/Pixel/BF');
			preload('characters/GF/Pixel/Pixel_gf');
			preload('characters/XenoAndGrimbo/Pixel/Sonic_EXE_Pixel');
			preload('characters/XenoAndGrimbo/HD/Esta-YCR');
			preload('characters/XenoAndGrimbo/HD/Esta-YCR_Angry');
			preload('characters/XenoAndGrimbo/HD/Esta-YCR_JustDie');
			preload('characters/XenoAndGrimbo/HD/Esta-YCR_Scream');
			if (noteChangesFromTheStore)
				preload('arrows/'+ClientPrefs.arrowSkin, 'shared');
			else
				preload('arrows/NOTE_assets', 'shared');
			preload('PIXELNOTE_assets', 'shared');
		}
		
		if (SONG.song.toLowerCase() == 'final-escape') {
			preload('characters/GF/Pixel/Pixel_gf');
			preload('characters/XenoAndGrimbo/Pixel/sonic-encore-ycr');
			if (noteChangesFromTheStore)
				preload('arrows/'+ClientPrefs.arrowSkin, 'shared');
			else
				preload('arrows/NOTE_assets', 'shared');
			preload('PIXELNOTE_assets', 'shared');
		}
		
		if (SONG.song.toLowerCase() == 'you-cant-run-encore') {
			preload('characters/BF/Pixel/encore-bf-pixel');
			preload('characters/XenoAndGrimbo/Pixel/Sonic_EXE_Pixel');
			preload('characters/XenoAndGrimbo/Pixel/sonic-encore-ycr');
			preload('characters/XenoAndGrimbo/HD/YCR-Mad-Cherribun');
			if (noteChangesFromTheStore)
				preload('arrows/'+ClientPrefs.arrowSkin, 'shared');
			else
				preload('arrows/NOTE_assets', 'shared');
			preload('PIXELNOTE_assets', 'shared');
		}
		
		if (SONG.song.toLowerCase() == 'triple-trouble-encore') {
			preload('JUMPSCARES/Tails' + (ClientPrefs.gore==false?"NoGore":""), 'exe');
			preload('JUMPSCARES/Knuckles' + (ClientPrefs.gore==false?"NoGore":""), 'exe');
			preload('JUMPSCARES/Eggman' + (ClientPrefs.gore==false?"NoGore":""), 'exe');
			preload('Phase3Static', 'exe');
			CoolUtil.precacheSound('P3Jumps/TailsScreamLOL', 'exe');
			CoolUtil.precacheSound('P3Jumps/KnucklesScreamLOL', 'exe');
			CoolUtil.precacheSound('P3Jumps/EggmanScreamLOL', 'exe');
		}
		
		if (SONG.song.toLowerCase() == 'hedge') preload('hog/TargetLock', 'exe');
		
		if(SONG.song.toLowerCase() == 'manual-blast') {
			preload('icons/icon-lordx-encore');
			preload('icons/icon-skinwalker');
			preload('icons/icon-terion');
			preload('icons/icon-BEAST');
			preload('icons/icon-rerun');
			preload('icons/icon-mighty');
			preload('icons/icon-griatos');
			preload('icons/icon-eyx');
			preload('icons/icon-cyclops');
			preload('icons/icon-sally');
		}
		
		if(fatalUI) {
			preload('statix', 'exe');
			if(SONG.song.toLowerCase() != 'fatality-encore' || SONG.song.toLowerCase() != 'critical-error') preload('characters/FatalAndCritical/fatal-error-sonic-glitched');
			CoolUtil.precacheSound('staticBUZZ');
		}
		
		if (SONG.song.toLowerCase() == 'b4cksl4sh' || SONG.song.toLowerCase() == 'tetrabrachial' || SONG.song.toLowerCase() == 'my-horizon') {			
			isPixelStage = true;
			if(SONG.song.toLowerCase() == 'b4cksl4sh') {
				preload('slash_warning_sheet', 'exe');
				preload('characters/SL4SH/FrontViewSl4sh');
				preload('characters/MarStarBro/Death/sl4sh_mar_gameover');
				preload('characters/MarStarBro/sl4sh_mar');
				CoolUtil.precacheSound('slashslash', 'exe');
				CoolUtil.precacheSound('slashhit', 'exe');
				CoolUtil.precacheSound('slashwarning', 'exe');
			}
			
			if (SONG.song.toLowerCase() == 'my-horizon' || SONG.song.toLowerCase() == 'our-horizon') {
				GameOverSubstate.deathSoundName = 'chaotix-death';
				GameOverSubstate.loopSoundName = 'chaotix-gameover';
				GameOverSubstate.endSoundName = 'chaotix-retry';
				GameOverSubstate.characterName = 'bf-chaotix-death';
			}
		}
		
		if (curStage == 'chamber' || curStage == 'chamber-encore') {
			preload('spacebar_icon', 'exe');
			preload('characters/BF/HD/Super_BoyFriend_Assets');
			preload('characters/Fleetway/fleetway3');
			CoolUtil.precacheSound('robot', 'exe');
			CoolUtil.precacheSound('sonic', 'exe');
			CoolUtil.precacheSound('laser_moment', 'exe');
			CoolUtil.precacheSound('beam', 'exe');
			CoolUtil.precacheSound('SUPERBF', 'exe');
			CoolUtil.precacheSound('warning', 'exe');
		}
		
		if (SONG.song.toLowerCase() == 'burning' || SONG.song.toLowerCase() == 'slaybells' || SONG.song.toLowerCase() == 'jingle-hells' || SONG.song.toLowerCase() == 'found-you' || SONG.song.toLowerCase() == 'forestall-desire' || SONG.song.toLowerCase() == 'her-world' || SONG.song.toLowerCase() == 'marauder' || SONG.song.toLowerCase() == 'too-far' || SONG.song.toLowerCase() == 'too-far-alt') {
			if (SONG.song.toLowerCase() == 'found-you' || SONG.song.toLowerCase() == 'forestall-desire') {
				GFandDad = false;
			}
			if (SONG.song.toLowerCase() == 'forestall-desire') bfIsLeft = true;
			GFIconChange = true;
		}
		
		if (curStage == 'schoolhouse' || curStage == 'starved') offDownScroll = true;
		else offDownScroll = false;
		
		if (curStage == 'christmas') {
			GameOverCameraMove = false;
			GameOverSubstate.deathSoundName = 'christmas-death';
			GameOverSubstate.loopSoundName = 'christmas-gameover';
			GameOverSubstate.endSoundName = 'christmas-retry';
			GameOverSubstate.characterName = 'sonicexe_christmas';
		}
		
		if (curStage == 'schoolhouse') {
			GameOverCameraMove = false;
			GameOverSubstate.deathSoundName = 'educator-death';
			GameOverSubstate.loopSoundName = 'educator-gameover';
			GameOverSubstate.endSoundName = 'educator-retry';
			GameOverSubstate.characterName = 'educator-death';
		}
		
		if (SONG.song.toLowerCase() == 'endless' || SONG.song.toLowerCase() == 'endless-og' || SONG.song.toLowerCase() == 'endless-us' || SONG.song.toLowerCase() == 'endless-jp' || SONG.song.toLowerCase() == 'endeavors' || SONG.song.toLowerCase() == 'endeavors-og') {
				GameOverSubstate.deathSoundName = 'majin-death';
				GameOverSubstate.loopSoundName = 'majin-gameover';
				GameOverSubstate.endSoundName = 'majin-retry';
				GameOverSubstate.characterName = 'endless_bf';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'endless-encore') {
				GameOverSubstate.deathSoundName = 'encoremajin-death';
				GameOverSubstate.loopSoundName = 'encoremajin-gameover';
				GameOverSubstate.endSoundName = 'majin-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'face-off' || SONG.song.toLowerCase() == 'ice-cap') {
				GameOverSubstate.deathSoundName = 'lookalike-death';
				GameOverSubstate.loopSoundName = 'gameOver';
				GameOverSubstate.endSoundName = 'lookalike-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'milk' || SONG.song.toLowerCase() == 'cool-party') {
				GameOverSubstate.deathSoundName = 'sunky-death';
				GameOverSubstate.loopSoundName = 'sunky-gameover';
				GameOverSubstate.endSoundName = 'sunky-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'sunshine' || SONG.song.toLowerCase() == 'drippyshine') {
				GameOverSubstate.deathSoundName = 'sunshine-death';
				GameOverSubstate.loopSoundName = 'sunshine-gameover';
				GameOverSubstate.endSoundName = 'sunshine-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'sunshine-encore' || SONG.song.toLowerCase() == 'soulless') {
				GameOverSubstate.deathSoundName = 'td-death';
				GameOverSubstate.loopSoundName = 'td-gameover';
				GameOverSubstate.endSoundName = 'td-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'faker') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'faker-gameover';
				GameOverSubstate.endSoundName = 'faker-retry';
				GameOverCameraMove = false;
		
		}
		
		if (SONG.song.toLowerCase() == 'her-world' || SONG.song.toLowerCase() == 'her-world-old') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'luther-gameover';
				GameOverSubstate.endSoundName = 'luther-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'her-world-encore') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'sunter-gameover';
				GameOverSubstate.endSoundName = 'sunter-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'lukas-world') {
				GameOverSubstate.deathSoundName = 'lukas-death';
				GameOverSubstate.loopSoundName = 'lukas-gameover';
				GameOverSubstate.endSoundName = 'lukas-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'mania') {
				GameOverSubstate.deathSoundName = 'shtails-death';
				GameOverSubstate.loopSoundName = 'shtails-gameover';
				GameOverSubstate.endSoundName = 'shtails-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'insidious') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'demogri-gameover';
				GameOverSubstate.endSoundName = 'demogri-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'digitalized' || SONG.song.toLowerCase() == 'substantial') {
				GameOverSubstate.deathSoundName = 'xterion-death';
				GameOverSubstate.loopSoundName = 'xterion-gameover';
				GameOverSubstate.endSoundName = 'xterion-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'burning') {
				GameOverSubstate.deathSoundName = 'burning-death';
				GameOverSubstate.loopSoundName = 'burning-gameover';
				GameOverSubstate.endSoundName = 'burning-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'long-sky') {
				GameOverSubstate.deathSoundName = 'chotix-death';
				GameOverSubstate.loopSoundName = 'chotix-gameover';
				GameOverSubstate.endSoundName = 'chotix-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'hedge') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'hog-gameover';
				GameOverSubstate.endSoundName = 'hog-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'manual-blast') {
				GameOverSubstate.deathSoundName = 'scorched-death';
				GameOverSubstate.loopSoundName = 'scorched-gameover';
				GameOverSubstate.endSoundName = 'scorched-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'malediction' || SONG.song.toLowerCase() == 'extricate-hex' || SONG.song.toLowerCase() == 'unblessful-hedgehog') {
				GameOverSubstate.deathSoundName = 'curse-death';
				GameOverSubstate.loopSoundName = 'curse-gameover';
				GameOverSubstate.endSoundName = 'curse-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'found-you') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'normalcd-gameover';
				GameOverSubstate.endSoundName = 'normalcd-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'genesis' || SONG.song.toLowerCase() == 'corinthians' || SONG.song.toLowerCase() == 'perdition-apollyon') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'gameOver';
				GameOverSubstate.endSoundName = 'apollyon-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'miasma') {
				GameOverSubstate.deathSoundName = 'dsk-death';
				GameOverSubstate.loopSoundName = 'dsk-gameover';
				GameOverSubstate.endSoundName = 'dsk-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'color-blind' || SONG.song.toLowerCase() == 'color-blind-old' || SONG.song.toLowerCase() == 'color-blind-encore') {
				GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
				GameOverSubstate.loopSoundName = 'mono-gameover';
				GameOverSubstate.endSoundName = 'mono-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'universal-collapse' || SONG.song.toLowerCase() == 'planestrider') {
				GameOverSubstate.deathSoundName = 'omw-death';
				GameOverSubstate.loopSoundName = 'omw-gameover';
				GameOverSubstate.endSoundName = 'omw-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'life-and-death' || SONG.song.toLowerCase() == 'gods-will') {
				GameOverSubstate.deathSoundName = 'bratwurst-death';
				GameOverSubstate.loopSoundName = 'gameOver';
				GameOverSubstate.endSoundName = 'bratwurst-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'fake-baby') {
				GameOverSubstate.deathSoundName = 'nmi-death';
				GameOverSubstate.loopSoundName = 'nmi-gameover';
				GameOverSubstate.endSoundName = 'nmi-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'envy') {
				GameOverSubstate.deathSoundName = 'grimeware-death';
				GameOverSubstate.loopSoundName = 'gameOver';
				GameOverSubstate.endSoundName = 'grimeware-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'hellstorm' || SONG.song.toLowerCase() == 'sharpy-showdown') {
				GameOverSubstate.deathSoundName = 'exetior-death';
				GameOverSubstate.loopSoundName = 'exetior-gameover';
				GameOverSubstate.endSoundName = 'exetior-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'call-of-justice' || SONG.song.toLowerCase() == 'gotta-go' || SONG.song.toLowerCase() == 'call-of-justice-old') {
				GameOverSubstate.deathSoundName = 'batman-death';
				GameOverSubstate.loopSoundName = 'batman-gameover';
				GameOverSubstate.endSoundName = 'batman-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'shocker' || SONG.song.toLowerCase() == 'extreme-zap' || SONG.song.toLowerCase() == 'thunderbolt') {
				GameOverSubstate.deathSoundName = 'sonichu-death';
				GameOverSubstate.loopSoundName = 'sonichu-gameover';
				GameOverSubstate.endSoundName = 'sonichu-retry';
				GameOverSubstate.characterName = 'bf-sonichu-death';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'ugly') {
				GameOverSubstate.deathSoundName = 'ugly-death';
				GameOverSubstate.loopSoundName = 'ugly-gameover';
				GameOverSubstate.endSoundName = 'ugly-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'soured') {
				GameOverSubstate.deathSoundName = 'lemon-death';
				GameOverSubstate.loopSoundName = 'lemon-gameover';
				GameOverSubstate.endSoundName = 'lemon-retry';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'old-ycr-slaps') {
				GameOverSubstate.deathSoundName = 'xenoslaps-death';
				GameOverSubstate.loopSoundName = 'xenoslaps-gameover';
				GameOverSubstate.endSoundName = 'xenoslaps-retry';
				GameOverSubstate.characterName = 'bf-exe-death';
				GameOverCameraMove = false;
		}
		
		if (SONG.song.toLowerCase() == 'oxxynless') {
				GameOverSubstate.deathSoundName = 'oxxy-death';
				GameOverSubstate.loopSoundName = 'oxxy-gameover';
				GameOverSubstate.endSoundName = 'oxxy-retry';
				GameOverCameraMove = false;
		}
		
		#if desktop
		if (isStory) {
			detailsText = "Story Mode";
		} else {
			if (isEncore) {
				detailsText = "Encore";
			} else {
				if (isExtras) {
					detailsText = "Extras";
				} else {
					if (isSound) {
						detailsText = "Sound Test";
					} else {
						if (isFreeplay) {
							detailsText = "Freeplay";
						} else {
							detailsText = "???";
						}
					}
				}
			}
		}
		if (TranslationLanguages.Text.exists(detailsText) && ClientPrefs.Language != 'English')
			detailsText = TranslationLanguages.Text[detailsText];
		detailsPausedText = PausedLang + " - " + detailsText;
		#end

		switch (curStage) {
			case 'needle':
				add(gfGroup);
				add(dad2Group);
				add(dadGroup);
				add(boyfriendGroup);
				
			case 'cant-run-xd':
				add(gfGroup);
				add(dadGroup);
				add(boyfriendGroup);
				
			case 'cant-run-encore':
				add(gfGroup);
				add(dadGroup);
				add(boyfriendGroup);
				
			case 'godspeed':	
				add(gfGroup);
				add(dadGroup);
				add(boyfriendGroup);
				add(GSplants);
				
			default:
				add(gfGroup);
				add(dadGroup);
				add(boyfriendGroup);
		}

		switch (SONG.song.toLowerCase())
		{
			case 'perdition' | 'perdition-apollyon' | 'purgatory' | 'underworld' | 'corinthians' | 'mania' | 'coulrophobia':
				gfGroup.visible = false;
		}

		switch (curStage)
		{
			case 'endless-forest':
				var ok:BGSprite= new BGSprite('FunInfiniteStage', 'exe', -600, -200, 1.1, 0.9);
                ok.scale.x = 1.25;
                ok.scale.y = 1.25;
				ok.blend = LIGHTEN;
				add(ok);

				if (!ClientPrefs.PotatoOptimization) add(fgmajin);
				if (!ClientPrefs.PotatoOptimization) add(fgmajin2);
				
			case 'endeavors', 'endeavors-og':
				var ok:BGSprite= new BGSprite('FunInfiniteStage', 'exe', -600, -200, 1.1, 0.9);
                ok.scale.x = 1.25;
                ok.scale.y = 1.25;
				ok.blend = LIGHTEN;
				EndeavorsOGFG.add(ok);
				
				if (!ClientPrefs.PotatoOptimization) EndeavorsOGFG.add(fgmajin);
				if (!ClientPrefs.PotatoOptimization) EndeavorsOGFG.add(fgmajin2);
				add(EndeavorsOGFG);
				
			case 'TDP2':
				gfGroup.visible = false;
				boyfriendGroup.visible = false;
				
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
				
			case 'void' | 'DDDDD' | 'sl4sh':
				gfGroup.visible = false;
				
			case 'trioStage':
				gfGroup.visible = false;
				if (!ClientPrefs.PotatoOptimization) {
					add(fgTree1);
					add(fgTree2);
				}
				
			case 'trioStage-encore':
				gfGroup.visible = false;
				
			case 'xterion' | 'xterion-digitalized':
				gfGroup.visible = false;
				
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.02];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
				
			case 'sunter':
			    var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				VHSui = true;
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
				
			case 'lumpy':
				if (ClientPrefs.Shaders) {
					pixShader = new VCRWNB();
					pixShader.iTime.value = [0];
					var filter = new ShaderFilter(pixShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
				
			case 'died' | 'died-alt':
				if (ClientPrefs.Shaders) {
					pixShader = new VCRWNB();
					pixShader.iTime.value = [0];
					var filter = new ShaderFilter(pixShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
				
			case 'melt' | 'melt-old' | 'confront':
				if (ClientPrefs.Shaders) {
					pixShader = new VCRWNB();
					pixShader.iTime.value = [0];
					var filter = new ShaderFilter(pixShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'schoolhouse':
				if (ClientPrefs.Shaders) {
					pixShader = new VCRWNB();
					pixShader.iTime.value = [0];
					var filter = new ShaderFilter(pixShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'shine':
				gfGroup.visible = false;
				
				var noteStatic = new FlxSprite();
				noteStatic.frames = Paths.getSparrowAtlas("daSTAT", "exe");
				noteStatic.setGraphicSize(camHUD.width, camHUD.height);
				noteStatic.cameras = [camOverlay];
				noteStatic.screenCenter();
				noteStatic.animation.addByPrefix("static", "staticFLASH", 24);
				noteStatic.alpha = 0.1;
				noteStatic.animation.play("static", true);
				add(noteStatic);
				if (ClientPrefs.Shaders) {
					vcrShader = new VVCCRR();
					vcrShader.iTime.value = [0];
					vcrShader.vignetteOn.value = [true];
					vcrShader.perspectiveOn.value = [true];
					if(ClientPrefs.flashing){
						vcrShader.distortionOn.value = [true];
						vcrShader.glitchModifier.value = [0.1];
					}
					vcrShader.vignetteMoving.value = [false];
					vcrShader.iResolution.value = [FlxG.width, FlxG.height];
					vcrShader.noiseTex.input = Paths.image("needlemouse/noise2", "exe").bitmap;
					var filter = new ShaderFilter(vcrShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}

			case 'animosity' | 'reunion':
				gfGroup.visible = false;
				
			case 'starved' | 'chamber' | 'chamber-encore' | 'sanicStage' | 'void' | 'fatality' | 'unresponsive' | 'cycles-hills' | 'bfexe' | 'LukasWorld' | 'critical-error':
				gfGroup.visible = false;
				
			case 'starved-pixel':
				gfGroup.visible = false;
				if (ClientPrefs.Shaders) {
					pixShader = new VCRWNB();
					pixShader.iTime.value = [0];
					var filter = new ShaderFilter(pixShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}
			
			case 'fakerstage':
				gf.scrollFactor.set(1.24, 1);
				dad.scrollFactor.set(1.25, 1);
				boyfriend.scrollFactor.set(1.25, 1);
				
			case 'apollyon-genesis':
				gfGroup.visible = false;
				if (ClientPrefs.Shaders) {
					pixShader = new VCRWNB();
					pixShader.iTime.value = [0];
					var filter = new ShaderFilter(pixShader);
					curShader = filter;
					camHUD.setFilters([curShader]);
					camOverlay.setFilters([curShader]);
					camGame.setFilters([curShader]);
				}		
			default:
				if (fatalUI && curStage != 'fatal-encore')
					gfGroup.visible = false;
				
		}
		
		#if LUA_ALLOWED
		luaDebugGroup = new FlxTypedGroup<DebugLuaText>();
		luaDebugGroup.cameras = [camOther];
		add(luaDebugGroup);
		#end

		// "GLOBAL" SCRIPTS
		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('scripts/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('scripts/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/scripts/'));
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						luaArray.push(new FunkinLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end
		

		// STAGE SCRIPTS
		#if LUA_ALLOWED
		var doPush:Bool = false;

		#if (MODS_ALLOWED && desktop)
		var luaFile:String = 'stages/' + curStage + '.lua';
		if(FileSystem.exists(Paths.modFolders(luaFile))) {
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		} else {
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile)) {
				doPush = true;
			}
		}
		if(doPush) 
			luaArray.push(new FunkinLua(luaFile));
		#else

		var luaFile = Paths.getPreloadPath('stages/' + curStage + '.lua');
		if (OpenFlAssets.exists(luaFile))
		{
			doPush = true;
		}
					
		if(doPush) 
			luaArray.push(new FunkinLua(Asset2File.getPath(luaFile)));

		#end

		#end

		if(!modchartSprites.exists('blammedLightsBlack')) { //Creates blammed light black fade in case you didn't make your own
			blammedLightsBlack = new ModchartSprite(FlxG.width * -0.5, FlxG.height * -0.5);
			blammedLightsBlack.makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
			var position:Int = members.indexOf(gfGroup);
			if(members.indexOf(boyfriendGroup) < position) {
				position = members.indexOf(boyfriendGroup);
			} else if(members.indexOf(dadGroup) < position) {
				position = members.indexOf(dadGroup);
			}
			insert(position, blammedLightsBlack);

			blammedLightsBlack.wasAdded = true;
			modchartSprites.set('blammedLightsBlack', blammedLightsBlack);
		}
		if(curStage == 'philly') insert(members.indexOf(blammedLightsBlack) + 1, phillyCityLightsEvent);
		blammedLightsBlack = modchartSprites.get('blammedLightsBlack');
		blammedLightsBlack.alpha = 0.0;

		var gfVersion:String = SONG.gfVersion;
		if(gfVersion == null || gfVersion.length < 1) {
			switch (curStage)
			{
				default:
					gfVersion = 'gf';
			}
			SONG.gfVersion = gfVersion; //Fix for the Chart Editor
		}
		
		var EncoreGF:String = SONG.gfEncore;
		var EncoreGFNumber:Int = ClientPrefs.GFEncoreSkin;
		switch (EncoreGFNumber)
		{
			case 0:
				EncoreGF = 'GF_hedhehog';
			case 1:
				EncoreGF = 'Encore-HoggedGF';
			case 2:
				EncoreGF = 'Encore-LobsterGF';
			case 3:
				EncoreGF = 'Encore-AmongGF';
			case 4:
				EncoreGF = 'Encore-FakeGF';
			case 5:
				EncoreGF = 'Encore-FatalGF';
			case 6:
				EncoreGF = 'Encore-GFCat';
			case 7:
				EncoreGF = 'Encore-RougeGF';
			case 8:
				EncoreGF = 'Encore-HyperGF';
			case 9:
				EncoreGF = 'Encore-SarahGF';
			case 10:
				EncoreGF = 'Encore-HogGF';
			case 11:
				EncoreGF = 'sunky_gf';
			case 12:
				EncoreGF = 'dj-exe';
		}
		SONG.gfEncore = EncoreGF;
		
		var GFSkin:String = SONG.gfSkin;
		var GFNumber:Int = ClientPrefs.GFSkin;
		switch (GFNumber)
		{
			case 0:
				if (!isEncore) GFSkin = 'gf';
				if (isEncore) GFSkin = 'GF_hedhehog';
			case 1:
				GFSkin = 'GF_hedhehog';
			case 2:
				GFSkin = 'Encore-HoggedGF';
			case 3:
				GFSkin = 'Encore-LobsterGF';
			case 4:
				GFSkin = 'Encore-AmongGF';
			case 5:
				GFSkin = 'Encore-FakeGF';
			case 6:
				GFSkin = 'Encore-FatalGF';
			case 7:
				GFSkin = 'Encore-GFCat';
			case 8:
				GFSkin = 'Encore-RougeGF';
			case 9:
				GFSkin = 'Encore-HyperGF';
			case 10:
				GFSkin = 'Encore-SarahGF';
			case 11:
				GFSkin = 'Encore-HogGF';
			case 12:
				GFSkin = 'sunky_gf';
			case 13:
				GFSkin = 'dj-exe';
			case 14:
				GFSkin = 'Encore-GFHog';
		}
		SONG.gfSkin = GFSkin;

		if (!stageData.hide_girlfriend)
		{
			/*
			if () {
				switch (SONG.song.toLowerCase())
				{						
					default:
						GFEncoreSkins = false;
						GFSkins = false;
						gf = new Character(0, 0, gfVersion);
				}
			} else {
			*/
			if (isFreeplay || isEncore || isExtras || (isSound && isStoryMode)) {
				switch (SONG.song.toLowerCase())
				{
					case 'milk', 'cool-party', 'too-slow-encore', 'too-slow-encore-alt', 'you-cant-run-encore', 'my-horizon-wechidna':
						GFEncoreSkins = false;
						GFSkins = true;
						gf = new Character(0, 0, GFSkin);
						addCharacterToList(EncoreGF, 2);
						addCharacterToList(GFSkin, 2);
						
					default:
						GFEncoreSkins = false;
						GFSkins = false;
						gf = new Character(0, 0, gfVersion);
				}
			} else {
				GFEncoreSkins = false;
				GFSkins = false;
				gf = new Character(0, 0, gfVersion);
			}
			startCharacterPos(gf);
			gf.scrollFactor.set(0.95, 0.95);
			gfGroup.add(gf);
			startCharacterLua(gf.curCharacter);
		}

		if (curStage == 'needle')
		{
			dad2 = new Character(0, 0, 'sarah');
			startCharacterPos(dad2, true);
			dad2Group.add(dad2);
		}

		dad = new Character(0, 0, SONG.player2);
		startCharacterPos(dad, true);
		dadGroup.add(dad);
		startCharacterLua(dad.curCharacter);
		
		flyTarg = dad;
		
		var EncoreBF:String = SONG.bfEncore;
		var EncoreBFNumber:Int = ClientPrefs.BFEncoreSkin;
		switch (EncoreBFNumber)
		{
			case 0:
				EncoreBF = 'bf-encore';
			case 1:
				EncoreBF = 'Encore-HogBF';
			case 2:
				EncoreBF = 'Encore-BFFem';
			case 3:
				if (ClientPrefs.BFEncoreVerSkin == 0) EncoreBF = 'bf_merphi';
				if (ClientPrefs.BFEncoreVerSkin == 1) EncoreBF = 'bf_merphi_chaos';
		}
		SONG.bfEncore = EncoreBF;
		
		var BFSkin:String = SONG.bfSkin;
		var BFNumber:Int = ClientPrefs.BFSkin;
		switch (BFNumber)
		{
			case 0:
				if (!isEncore) BFSkin = 'bf';
				if (isEncore) BFSkin = 'bf-encore';
			case 1:
				BFSkin = 'bf-encore';
			case 2:
				BFSkin = 'Encore-HogBF';
			case 3:
				BFSkin = 'Encore-BFFem';
			case 4:
				if (ClientPrefs.BFVerSkin == 0) BFSkin = 'bf_merphi';
				if (ClientPrefs.BFVerSkin == 1) BFSkin = 'bf_merphi_chaos';
		}
		SONG.bfSkin = BFSkin;
		
		/*
		if (isEncore || isExtras) {
			switch (SONG.song.toLowerCase())
			{
				case 'cycles-encore', 'hollow-encore':
					BFSkins = false;
					BFEncoreSkins = true;
					boyfriend = new Boyfriend(0, 0, EncoreBF);

				case 'gotta-go-red-glove':
					BFSkins = true;
					BFEncoreSkins = false;
					boyfriend = new Boyfriend(0, 0, EncoreBF);
					
				default:
					BFSkins = false;
					BFEncoreSkins = false;
					boyfriend = new Boyfriend(0, 0, SONG.player1);
			}
		} else {
		*/
		if (isFreeplay || isEncore || isExtras || (isSound && isStoryMode)) {
			switch (SONG.song.toLowerCase())
			{
				case 'gotta-go-red-glove', 'hollow-encore', 'hollow', 'hollow-old', 'empty', 'execution', 'cycles', 'fate', 'broken-heart', 'too-fest', 'perdition', 'perdition-apollyon', 'underworld', 'purgatory', 'forever-unnamed', 'sharpy-showdown', 'personel-serious', 'ugly', 'hedge', 'manual-blast', 'miasma', 'my-horizon-wechidna':
					BFEncoreSkins = false;
					BFSkins = true;
					boyfriend = new Boyfriend(0, 0, BFSkin);
					addCharacterToList(EncoreBF, 0);
					addCharacterToList(BFSkin, 0);
				default:
					BFEncoreSkins = false;
					BFSkins = false;
					boyfriend = new Boyfriend(0, 0, SONG.player1);
			}
		} else {
			BFEncoreSkins = false;
			BFSkins = false;
			boyfriend = new Boyfriend(0, 0, SONG.player1);
		}
		startCharacterPos(boyfriend);
		boyfriendGroup.add(boyfriend);
		startCharacterLua(boyfriend.curCharacter);
		
		if (SONG.song.toLowerCase() == 'forestall-desire') {
			addCharacterToList('requitalanim1', 1);
			addCharacterToList('requitalanim2', 1);
			addCharacterToList('requitalanim3', 1);
			addCharacterToList('requitalanim4', 1);
		}
		
		var camPos:FlxPoint = new FlxPoint(girlfriendCameraOffset[0], girlfriendCameraOffset[1]);
		if(gf != null) {
			camPos.x += gf.getGraphicMidpoint().x + gf.cameraPosition[0];
			camPos.y += gf.getGraphicMidpoint().y + gf.cameraPosition[1];
		}

		if(dad.curCharacter.startsWith('gf')) {
			dad.setPosition(GF_X, GF_Y);
			if(gf != null)
				gf.visible = false;
		}

		switch (curStage)
		{
			case 'too-slow':
				if (!ClientPrefs.PotatoOptimization) add(fgTrees);
				
			case 'cant-run-xd':
				dad.x -= 75;
				
			case 'chamber':
				boyfriend.x -= 150;
				boyfriend.y -= 50;
				if (!ClientPrefs.PotatoOptimization) {
					add(thechamber);
					add(porker);
				}
				
			case 'chamber-encore':	
				boyfriend.x -= 150;
				boyfriend.y -= 50;
				if (!ClientPrefs.PotatoOptimization) {
					add(thechamber);
					add(porker);
				}	
	
			case 'cycles-hills':
				dad.x -= 120;
				dad.y -= 50;
				
			case 'needle':
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) add(needleFg);
				dad2.alpha = 0;

				dad.x -= 120;
				dad.y += 265;
				boyfriend.x += 275;
				boyfriend.y += 280;
				gf.x += 1000;
				gf.y += 350;
				dad2.x -= 150;
				dad2.y += 25;

				flyTarg = dad2;
				flyState = 'sHover';

				boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.9));
				
			case 'needle-p2':
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					add(needleFgZERO);
					add(needleFgONE);
					add(needleFgTWO);
					add(needleFgTHREE);
				}
				
				dad.x -= 120;
				dad.y += 265;
				boyfriend.x += 275;
				boyfriend.y += 280;
				gf.x += 1000;
				gf.y += 350;
				boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.9));
				
			case 'needle-encore':
				boyfriend.setGraphicSize(Std.int(boyfriend.width * 0.9));
				
			case 'fatality':
				dad.x -= 550;
				dad.y += 40;
				boyfriend.y += 140;
				
			case 'horizon', 'our-horizon':
				if (SONG.song.toLowerCase() == 'our-horizon' && !ClientPrefs.PotatoOptimization)
				{
					add(horizonKnuckles);
					add(horizonVector);
				}
				
			case 'starved-pixel':
				if (!ClientPrefs.PotatoOptimization) add(stardustFloorPixel);
				boyfriend.x += 250;
				boyfriend.y += 410;
				dad.x -= 1050;
				dad.y += 400;
				
			case 'starved':
				boyfriend.y += 75;
				dad.x += 300;
				dad.y -= 350;
				
			case 'hog':
				gfGroup.visible = false;
				if (!ClientPrefs.PotatoOptimization) {
					add(hogRocks);
					add(hogOverlay);
					if (SONG.song.toLowerCase() == 'manual-blast')
					{
						add(scorchedRocks);
					}
					hogOverlay.blend = LIGHTEN;
				}
				
			case 'sl4sh':
				boyfriend.y -= 35;
				boyfriend.x += 175;
				boyfriend.y += 220;
				
			case 'xterion' | 'xterion-digitalized':
				dad.x -= 75;
				
			case 'chotix':
				gfGroup.visible = false;
				
			case 'monoStage' ,'kn', 'dsk':
				gfGroup.visible = false;
				
			case 'founded':
				dad.visible = false;
				dad.x -= 500;
				if (!ClientPrefs.PotatoOptimization) {
					add(normalDoor);
					add(normalFg);
					add(normalVg);
				}
		}

		var file:String = Paths.json(songName + '/dialogue'); //Checks for json/Psych Engine dialogue
		if (OpenFlAssets.exists(file)) {
			dialogueJson = DialogueBoxPsych.parseDialogue(file);
		}

		var file:String = Paths.txt(songName + '/' + songName + 'Dialogue'); //Checks for vanilla/Senpai dialogue
		if (OpenFlAssets.exists(file)) {
			dialogue = CoolUtil.coolTextFile(file);
		}
		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doof.nextDialogueThing = startNextDialogue;
		doof.skipDialogueThing = skipDialogue;

		Conductor.songPosition = -5000;

		strumLine = new FlxSprite(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, 50).makeGraphic(FlxG.width, 10);
		if(ClientPrefs.downScroll && !offDownScroll) strumLine.y = FlxG.height - 150;
		strumLine.scrollFactor.set();

		var showTime:Bool = !ClientPrefs.hideHud;
		if (!devoidUI) {
			if (!xenoEncUI) {
				timeTxt = new FlxText(STRUM_X + (FlxG.width / 2) - 260, 19, 400, "", 32);
				timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			} else {
				timeTxt = new FlxText(0, 0, 400, "", 25);
				timeTxt.setFormat(Paths.font("tcceb.ttf"), 25, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			}
		} else {
			timeTxt = new FlxText(STRUM_X + (FlxG.width / 2) - 260, 1, 400, "", 40);
			timeTxt.setFormat(Paths.font("dark-bastion.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		}
		timeTxt.scrollFactor.set();
		timeTxt.alpha = 0;
		timeTxt.borderSize = 2;
		timeTxt.visible = showTime;
		if (!xenoEncUI) timeTxt.screenCenter(X);
		if (ClientPrefs.downScroll && !offDownScroll) {
			if (!devoidUI) {
				timeTxt.y = FlxG.height - 44;
			} else {
				timeTxt.y = FlxG.height - 50;
			}
		}

		if(ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.text = SONG.song;
		}
		updateTime = showTime;

		if(VHSui)
		{
			irlTxt = new FlxText(500,625, FlxG.width, "", 40);
			irlTxt.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			irlTxt.scrollFactor.set();
			irlTxt.alpha = 1;
			irlTxt.borderSize = 2;
			add(irlTxt);
		}

		var ShitTO:Float = 4;
		var ShitTT:Float = 8;
		if (bgTBSkin == 'tbR') {
			ShitTO = 15;
			ShitTT = 33;
		}
		
		var bgTBColorPath:String = '';
		if (bgTBSkin == 'tbR') {
			if(ClientPrefs.BarsColor == 'Dark Color') bgTBColorPath = (bgTBSkin + '-dark');
			if(ClientPrefs.BarsColor == 'Light Color' || ClientPrefs.BarsColor == 'No Color Change') bgTBColorPath = (bgTBSkin + '-light');
		}	
	
		timeBarBG = new AttachedSprite(bgTBColorPath);
		timeBarBG.screenCenter(X);
		timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
		timeBarBG.scrollFactor.set();
		timeBarBG.alpha = 0;
		timeBarBG.visible = showTime;
		if (bgTBSkin == 'tbR')
			timeBarBG.xAdd = -17;
		else
			timeBarBG.xAdd = -4;
		timeBarBG.yAdd = -4;
		
		if (bgTBSkin == 'tbR') {
			if(ClientPrefs.BarsColor == 'No Color Change') timeBarBG.color = 0xFF000000;
			timeBarBGBG = new AttachedSprite('tbR-BG');
			timeBarBGBG.screenCenter(X);
			timeBarBGBG.y = timeTxt.y + (timeTxt.height / 4);
			timeBarBGBG.scrollFactor.set();
			timeBarBGBG.alpha = 0;
			timeBarBGBG.visible = showTime;
			if (bgTBSkin == 'tbR')
				timeBarBGBG.xAdd = -17;
			else
				timeBarBGBG.xAdd = -4;
			timeBarBGBG.yAdd = -4;
		}
		
		if (!devoidUI) {
			timeBar = new FlxBar(timeBarBG.x + ShitTO, timeBarBG.y + 4, LEFT_TO_RIGHT, Std.int(timeBarBG.width - ShitTT), Std.int(timeBarBG.height - 8), this, 'songPercent', 0, 1);
		} else {
			if(!ClientPrefs.downScroll) timeBar = new FlxBar(510, 0, LEFT_TO_RIGHT, 263, 45, this, 'songPercent', 0, 1);
			if(ClientPrefs.downScroll) timeBar = new FlxBar(510, 675, LEFT_TO_RIGHT, 263, 45, this, 'songPercent', 0, 1);
		}
		timeBar.scrollFactor.set();
		timeBar.createFilledBar(TimeBarColorOne, TimeBarColorTwo);
		switch (curStage)
		{
			case 'endless-forest' | 'endless-stage':
				timeBar.createFilledBar(0x003D0BBD, 0xFF3D0BBD);
				TimeBarColorOne = 0x003D0BBD;
				TimeBarColorTwo = 0xFF3D0BBD;
			case 'endless-jp':
				timeBar.createFilledBar(0x003D0BBD, 0xFF5C0BBA);
				TimeBarColorOne = 0x003D0BBD;
				TimeBarColorTwo = 0xFF5C0BBA;
			case 'fun-cd':
				timeBar.createFilledBar(0x003D0BBD, 0xFF0C266E);
				TimeBarColorOne = 0x003D0BBD;
				TimeBarColorTwo = 0xFF0C266E;
			case 'cycles-hills':
				timeBar.createFilledBar(0x009FA441, 0xFF9FA441);
				TimeBarColorOne = 0x009FA441;
				TimeBarColorTwo = 0xFF9FA441;
			case 'cycles-encore':
				timeBar.createFilledBar(0x009FA441, 0xFF353535);
				TimeBarColorOne = 0x009FA441;
				TimeBarColorTwo = 0xFF353535;
			case 'sunkStage':
				timeBar.createFilledBar(0x00FF0000, 0xFFFF0000);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFF0000;
				sunkerTimebarFuckery = true;
			case 'xterion':
				timeBar.createFilledBar(0x00FF0000, 0xFF7449FF);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF7449FF;
			case 'xterion-digitalized':
				timeBar.createFilledBar(0x00FF0000, 0xFF850085);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF850085;
			default:
				timeBar.createFilledBar(0x00FF0000, 0xFFFF0000);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFF0000;
		}

		switch (SONG.song.toLowerCase())
		{
			case 'her-world' | 'her-world-old' | 'lukas-world' | 'mania' | 'forestall-desire' | 'soulless' | 'sunshine' | 'sunshine-encore' | 'drippyshine':
				timeBar.createFilledBar(0x00FF0000, 0xFFFF8330);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFF8330;
			case 'hollow' | 'empty' | 'hollow-encore' | 'hollow-old':
				timeBar.createFilledBar(0x00FF0000, 0xFF3850FF);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF3850FF;
			case 'gotta-go' | 'call-of-justice' | 'call-of-justice-old':
			    timeBar.createFilledBar(0x00FF0000, 0xFF4B2FBC);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF4B2FBC;
			case 'endeavors' | 'endeavors-og':
				timeBar.createFilledBar(0x003D0BBD, 0xFF3D0BBD);
				TimeBarColorOne = 0x003D0BBD;
				TimeBarColorTwo = 0xFF3D0BBD;
			case 'malediction' | 'extricate-hex' | 'unblessful-hedgehog':
				timeBar.createFilledBar(0x00FF0000, 0xFF6656B7);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF6656B7;
			case 'fate' | 'judgement':
				timeBar.createFilledBar(0x00FF0000, 0xFF3C3B59);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF3C3B59;
			case 'shocker' | 'extreme-zap' | 'thunderbolt':
				timeBar.createFilledBar(0x00FF0000, 0xFFFFE735);	
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFFE735;
			case 'chaos' | 'heroes-and-villains' | 'running-wild':
				timeBar.createFilledBar(0x00FF0000, 0xFFFFA01C);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFFA01C;
			case 'goddess' | 'agony':
				timeBar.createFilledBar(0x00FF0000, 0xFFFF442B);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFF442B;
			case 'face-off' | 'ice-cap':
				timeBar.createFilledBar(0x00FF0000, 0xFF023331);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF023331;
			case 'broken-heart':
				timeBar.createFilledBar(0x00FF0000, 0xFFB75F74);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFB75F74;
			case 'personel' | 'personel-serious':
				timeBar.createFilledBar(0x00FF0000, 0xFFD82BFF);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFD82BFF;
			case 'hedge' | 'manual-blast':
				timeBar.createFilledBar(0x00FF0000, 0xFF2C27B5);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF2C27B5;
			case 'perdition' | 'underworld' | 'purgatory':
				timeBar.createFilledBar(0x00FF0000, 0xFF5454A8);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF5454A8;
			case 'long-sky':
				timeBar.createFilledBar(0x00FF0000, 0xFFF05C7A);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFF05C7A;
			case 'color-blind' | 'color-blind-old' | 'color-blind-encore':
				timeBar.createFilledBar(0x00FF0000, 0xFFFFFFFF);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFFFFFFF;
			case 'fake-baby':
				timeBar.createFilledBar(0xFF515151, 0xFF000000);
				TimeBarColorOne = 0xFF515151;
				TimeBarColorTwo = 0xFF000000;
			case 'missiletoe':
				timeBar.createFilledBar(0xFF000000, 0xFFFF9900);
				TimeBarColorOne = 0xFF000000;
				TimeBarColorTwo = 0xFFFF9900;
			case 'slaybells':
				timeBar.createFilledBar(0xFF000000, 0xFF1A2AA8);
				TimeBarColorOne = 0xFF000000;
				TimeBarColorTwo = 0xFF1A2AA8;
			case 'jingle-hells':
				timeBar.createFilledBar(0xFF000000, 0xFF3911AC);
				TimeBarColorOne = 0xFF000000;
				TimeBarColorTwo = 0xFF3911AC;
			case 'hellbent':
				timeBar.createFilledBar(0xFF000000, 0xFF26333B);
				TimeBarColorOne = 0xFF000000;
				TimeBarColorTwo = 0xFF26333B;
			case 'too-far' | 'too-far-alt' | 'last-hope':
				timeBar.createFilledBar(0xFF000000, 0xFF26333B);
				TimeBarColorOne = 0xFF000000;
				TimeBarColorTwo = 0xFF26333B;
			case 'faker' | 'faker-encore':
				timeBar.createFilledBar(0x00FF0000, 0xFF1C1C72);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF1C1C72;
			case 'black-sun' | 'godspeed':
				timeBar.createFilledBar(0x00FF0000, 0xFF1F106B);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF1F106B;
			case 'coulrophobia':
				timeBar.createFilledBar(0x00FF0000, 0xFF682447);	
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF682447;
			case 'animosity' | 'reunion':
				timeBar.createFilledBar(0x00FF0000, 0xFF08684D);	
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF08684D;
			case 'playful' | 'expulsion':
				timeBar.createFilledBar(0x00FF0000, 0xFF010F70);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF010F70;
			case 'relax' | 'round-a-bout':
				timeBar.createFilledBar(0x00FF0000, 0xFF813DFF);	
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF813DFF;
			case 'spike-trap':
				timeBar.createFilledBar(0x00FF0000, 0xFF4F259E);	
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF4F259E;
			case 'forever-unnamed':
				timeBar.createFilledBar(0x00FF0000, 0xFF2140A7);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF2140A7;
			case 'her-world-encore':
				timeBar.createFilledBar(0x00FF0000, 0xFF0B42C1);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF0B42C1;
			case 'sharpy-showdown' | 'hellstorm':
				timeBar.createFilledBar(0x00FF0000, 0xFF062D68);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF062D68;
			case 'found-you':
				timeBar.createFilledBar(0x00FF0000, 0xFF5E74A3);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF5E74A3;
			case 'too-fest' | 'hill-of-the-void' | 'too-fest-old':
				timeBar.createFilledBar(0x00FF0000, 0xFF000065);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF000065;
			case 'soured':
				timeBar.createFilledBar(0x00FF0000, 0xFF005DB5);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF005DB5;
			case 'ugly':
				timeBar.createFilledBar(0x00FF0000, 0xFF1C70C3);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF1C70C3;
			case 'frenzy':
				timeBar.createFilledBar(0x00FF0000, 0xFF354BD1);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF354BD1;
			case 'melting' | 'melting-old':
				timeBar.createFilledBar(0x00FF0000, 0xFF4646BC);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF4646BC;
			case 'confronting':
				timeBar.createFilledBar(0x00FF0000, 0xFF056CF7);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF056CF7;
			case 'my-horizon' | 'our-horizon':
				timeBar.createFilledBar(0x00FF0000, 0xFF056CF7);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF056CF7;
			case 'my-horizon-wechidna':
				timeBar.createFilledBar(0x00FF0000, 0xFF8E0E25);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF8E0E25;
			case 'envy' | 'gorefest' | 'lurk' | 'skincrawler':
				timeBar.createFilledBar(0x00FF0000, 0xFF4C349F);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF4C349F;
			case 'miasma':
				timeBar.createFilledBar(0x00FF0000, 0xFF57555A);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF57555A;
			case 'insidious':
				timeBar.createFilledBar(0x00FF0000, 0xFF393D85);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF393D85;
			case 'haze', 'haze-og':
				timeBar.createFilledBar(0x00FF0000, 0xFF392122);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF392122;
			case 'marauder':
				timeBar.createFilledBar(0x00FF0000, 0xFF393D85);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF393D85;
			case 'burning':
				timeBar.createFilledBar(0x00FF0000, 0xFF373744);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF373744;
			case 'genesis':
				timeBar.createFilledBar(0x00FF0000, 0xFF4848FC);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF4848FC;
			case 'corinthians':
				timeBar.createFilledBar(0x00FF0000, 0xFF191A26);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF191A26;
			case 'gods-will' | 'life-and-death':
				timeBar.createFilledBar(0x00FF0000, 0xFF374862);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF374862;
			case 'b4cksl4sh' | 'tetrabrachial':
				timeBar.createFilledBar(0x00FF0000, 0xFF383838);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF383838;
			case 'universal-collapse' | 'planestrider':
				timeBar.createFilledBar(0x00FF0000, 0xFF2C3CA9);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF2C3CA9;
			case 'gotta-go-red-glove':
				timeBar.createFilledBar(0x00FF0000, 0xFF041B5F);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFF041B5F;
			case 'round-a-bout-encore':
				timeBar.createFilledBar(0x00FF0000, 0xFFC1012E);
				TimeBarColorOne = 0x00FF0000;
				TimeBarColorTwo = 0xFFC1012E;
		}
		
		timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
		timeBar.alpha = 0;
		timeBar.visible = showTime;
		
		if (!devoidUI && !xenoEncUI) {
			if (bgTBSkin == 'tbR') {
				if(ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
				add(timeBarBGBG);
				add(timeBar);
				add(timeBarBG);
			} else {
				add(timeBarBG);
				add(timeBar);
			}
			add(timeTxt);
			timeBarBG.sprTracker = timeBar;
			if (bgTBSkin == 'tbR') timeBarBGBG.sprTracker = timeBar;
		}
		
		if(ClientPrefs.timeBarType == 'Song Name')
		{
			timeTxt.size = 24;
			timeTxt.y += 3;
		}

		if(VHSui)
		{
			timeBar.alpha = 1;
			timeTxt.x = 1000;
			timeTxt.y = 10;
			timeTxt.size = 40;
			timeBar.visible = false;
			timeBarBG.visible = false;
			timeBarBGBG.visible = false;
		}
		
		if (devoidUI) {
			DevoidUIControl = new FlxTypedSpriteGroup<FlxSprite>();
			devoidHPBar = new FlxSprite(0, 0);
			devoidHPBar.frames = Paths.getSparrowAtlas('devoidUI/hp-bar', 'preload');
			devoidHPBar.animation.addByPrefix('one', '1', 24, true);
			devoidHPBar.animation.addByPrefix('two', '0.9', 24, true);
			devoidHPBar.animation.addByPrefix('three', '0.8', 24, true);
			devoidHPBar.animation.addByPrefix('four', '0.7', 24, true);
			devoidHPBar.animation.addByPrefix('five', '0.6', 24, true);
			devoidHPBar.animation.addByPrefix('six', '0.5', 24, true);
			devoidHPBar.animation.addByPrefix('seven', '0.4', 24, true);
			devoidHPBar.animation.addByPrefix('eight', '0.3', 24, true);
			devoidHPBar.animation.addByPrefix('nine', '0.2', 24, true);
			devoidHPBar.animation.addByPrefix('ten', '0.1', 24, true);
			devoidHPBar.animation.addByPrefix('eleven', '0.05', 24, true);
			devoidHPBar.animation.play("six", true);
			devoidHPBar.scrollFactor.set();
			devoidHPBar.screenCenter();
			devoidHPBar.x += 380;
			if (!ClientPrefs.downScroll) {
				devoidHPBar.y += 180;
			} else {
				devoidHPBar.flipY = true;
				devoidHPBar.y -= 180;
			}
			devoidHPBar.alpha = ClientPrefs.healthBarAlpha;
			devoidHPBar.antialiasing = true;
			devoidHPBar.visible = !ClientPrefs.hideHud;
			DevoidUIControl.add(devoidHPBar);
			
			devoidUIhpTxt = new FlxText(-40, FlxG.height - 90, FlxG.width, "", 80);
			devoidUIhpTxt.setFormat(Paths.font("dark-bastion.ttf"), 80, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			devoidUIhpTxt.scrollFactor.set();
			devoidUIhpTxt.borderSize = 1.25;
			devoidUIhpTxt.visible = !ClientPrefs.hideHud;
			DevoidUIControl.add(devoidUIhpTxt);
			
			if (ClientPrefs.downScroll) devoidUIhpTxt.y = 10;
		}
		if (xenoEncUI) {
			if (!ClientPrefs.downScroll)
				xenoEncUIthing = new FlxSprite().loadGraphic(Paths.image('xenoUI/encore/thing','preload'));
			else
				xenoEncUIthing = new FlxSprite().loadGraphic(Paths.image('xenoUI/encore/thing-downScroll','preload'));
			xenoEncUIthing.scrollFactor.set();
			xenoEncUIthing.antialiasing=true;
			xenoEncUIthing.setGraphicSize(FlxG.width, FlxG.height);
			xenoEncUIthing.screenCenter();
			if (ClientPrefs.downScroll) xenoEncUIthing.y += 20;
			xenoEncUIthing.visible = !ClientPrefs.hideHud;
			add(xenoEncUIthing);
			add(timeTxt);
			
			if (!ClientPrefs.downScroll)
				scoreTxt = new FlxText(3, 531, FlxG.width, "", 37);
			else
				scoreTxt = new FlxText(3, 245, FlxG.width, "", 37);
			scoreTxt.setFormat(Paths.font("tcceb.ttf"), 37, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			scoreTxt.scrollFactor.set();
			scoreTxt.borderSize = 1.25;
			scoreTxt.visible = !ClientPrefs.hideHud;
			add(scoreTxt);
				
			if (!ClientPrefs.downScroll)
				xenoEncMissesTxt = new FlxText(3, 456, FlxG.width, "", 37);
			else
				xenoEncMissesTxt = new FlxText(3, 171, FlxG.width, "", 37);
			xenoEncMissesTxt.setFormat(Paths.font("tcceb.ttf"), 37, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			xenoEncMissesTxt.scrollFactor.set();
			xenoEncMissesTxt.borderSize = 1.25;
			xenoEncMissesTxt.visible = !ClientPrefs.hideHud;
			add(xenoEncMissesTxt);
		
			if (!ClientPrefs.downScroll)
				xenoEncHealthBar = new FlxBar(105, 656, RIGHT_TO_LEFT, 465, 44, this, 'healthbarval', 0, 2);
			else
				xenoEncHealthBar = new FlxBar(105, 26, RIGHT_TO_LEFT, 465, 44, this, 'healthbarval', 0, 2);
			xenoEncHealthBar.scrollFactor.set();
			xenoEncHealthBar.visible = !ClientPrefs.hideHud;
			xenoEncHealthBar.alpha = ClientPrefs.healthBarAlpha;
			add(xenoEncHealthBar);

			xenoEncIconP1 = new HealthIcon(boyfriend.healthIcon, true);
			xenoEncIconP1.visible = !ClientPrefs.hideHud;
			xenoEncIconP1.alpha = ClientPrefs.healthBarAlpha;
			
			xenoEncIconP2 = new HealthIcon(dad.healthIcon, false);
			xenoEncIconP2.visible = !ClientPrefs.hideHud;
			xenoEncIconP2.alpha = ClientPrefs.healthBarAlpha;

			xenoEncHP = new FlxSprite(0, 0);
			if (!ClientPrefs.downScroll)
				xenoEncHP.frames = Paths.getSparrowAtlas('xenoUI/encore/hpBar', 'preload');
			else
				xenoEncHP.frames = Paths.getSparrowAtlas('xenoUI/encore/hpBar-downScroll', 'preload');
			xenoEncHP.animation.addByPrefix('bad', 'bad', 24, true);
			xenoEncHP.animation.addByPrefix('mid', 'mid', 24, true);
			xenoEncHP.animation.addByPrefix('good', 'good', 24, true);
			xenoEncHP.animation.addByPrefix('sick', 'sick', 24, true);
			xenoEncHP.animation.play("sick", true);
			xenoEncHP.scrollFactor.set();
			xenoEncHP.alpha = ClientPrefs.healthBarAlpha;
			xenoEncHP.visible = !ClientPrefs.hideHud;
			if (!ClientPrefs.downScroll) {
				xenoEncHP.y = FlxG.height - 130;
			} else {
				xenoEncHP.flipY = true;
				xenoEncHP.y = 10;
			}
			xenoEncHP.x = 20;
			xenoEncHP.antialiasing = true;
			add(xenoEncHP);
					
			add(xenoEncIconP1);
			add(xenoEncIconP2);
			xenoEncIconP1.scale.x = 0.5;
			xenoEncIconP1.scale.y = 0.5;
			xenoEncIconP1.x = 530;
			xenoEncIconP2.x = -10;
			timeTxt.x = 3;
			if (!ClientPrefs.downScroll) {
				xenoEncIconP1.y = 600;
				xenoEncIconP2.y = 575;
				timeTxt.y = 498;
			} else {
				xenoEncIconP1.y = -22;
				xenoEncIconP2.y = 10;
				timeTxt.y = 212;
			}
			
			scoreTxt.antialiasing = true;
			xenoEncMissesTxt.antialiasing = true;
			timeTxt.antialiasing = true;
		}
		if (devoidUI) add(DevoidUIControl);

		strumLineNotes = new FlxTypedGroup<StrumNote>();
		add(strumLineNotes);
		add(grpNoteSplashes);
		
		if (ClientPrefs.arrowColorsRGB)
			rgbColorSwap = new ColorSwap();

		var splash:NoteSplash = new NoteSplash(100, 100, 0);
		grpNoteSplashes.add(splash);
		splash.alpha = 0.0;

		opponentStrums = new FlxTypedGroup<StrumNote>();
		playerStrums = new FlxTypedGroup<StrumNote>();

		barbedWires = new FlxTypedGroup<WireSprite>();
		for(shit in 0...6){
			var wow = shit+1;
			var wire:WireSprite = new WireSprite().loadGraphic(Paths.image('curse/barbedWire/' + wow, 'exe'));
			wire.scrollFactor.set();
			wire.antialiasing=true;
			wire.setGraphicSize(FlxG.width, FlxG.height);
			wire.updateHitbox();
			wire.screenCenter(XY);
			wire.alpha=0;
			wire.extraInfo.set("inUse",false);
			wire.cameras = [camOther];
			barbedWires.add(wire);
		}
		
		wireVignette = new FlxSprite().loadGraphic(Paths.image('curse/black_vignette','exe'));
		wireVignette.scrollFactor.set();
		wireVignette.antialiasing=true;
		wireVignette.setGraphicSize(FlxG.width, FlxG.height);
		wireVignette.updateHitbox();
		wireVignette.screenCenter(XY);
		wireVignette.alpha=0;
		wireVignette.cameras = [camOther];

		generateSong(SONG.song);
		#if LUA_ALLOWED

		#if desktop
		for (notetype in noteTypeMap.keys())
		{
			var luaToLoad:String = Paths.modFolders('custom_notetypes/' + notetype + '.lua');
			if(FileSystem.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			else
			{
				luaToLoad = Paths.getPreloadPath('custom_notetypes/' + notetype + '.lua');
				if(FileSystem.exists(luaToLoad))
				{
					luaArray.push(new FunkinLua(luaToLoad));
				}
			}
		}
		for (event in eventPushedMap.keys())
		{
			var luaToLoad:String = Paths.modFolders('custom_events/' + event + '.lua');
			if(FileSystem.exists(luaToLoad))
			{
				luaArray.push(new FunkinLua(luaToLoad));
			}
			else
			{
				luaToLoad = Paths.getPreloadPath('custom_events/' + event + '.lua');
				if(FileSystem.exists(luaToLoad))
				{
					luaArray.push(new FunkinLua(luaToLoad));
				}
			}
		}
		#else
		for (notetype in noteTypeMap.keys())
			{
			var luaToLoad:String = 'custom_notetypes/' + notetype + '.lua';
			luaToLoad = Paths.getPreloadPath(luaToLoad);
			if(OpenFlAssets.exists(luaToLoad)) {
			luaArray.push(new FunkinLua(Asset2File.getPath(luaToLoad)));
			}
		}
		for (event in eventPushedMap.keys())
			{
			var luaToLoad:String = 'custom_events/' + event + '.lua';
			luaToLoad = Paths.getPreloadPath(luaToLoad);    
			if(OpenFlAssets.exists(luaToLoad)) {
			luaArray.push(new FunkinLua(Asset2File.getPath(luaToLoad)));
			}
		}
		#end

		#end
		noteTypeMap.clear();
		noteTypeMap = null;
		eventPushedMap.clear();
		eventPushedMap = null;

		// After all characters being loaded, it makes then invisible 0.01s later so that the player won't freeze when you change characters
		// add(strumLine);

		camFollow = new FlxPoint();
		camFollowPos = new FlxObject(0, 0, 1, 1);

		snapCamFollowToPos(camPos.x, camPos.y);
		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}
		if (prevCamFollowPos != null)
		{
			camFollowPos = prevCamFollowPos;
			prevCamFollowPos = null;
		}
		add(camFollowPos);

		if (curSong.toLowerCase() == 'faker') fakertransform.setPosition(dad.getGraphicMidpoint().x - 400, dad.getGraphicMidpoint().y - 400);

		if (curSong.toLowerCase() == 'black-sun' || curSong.toLowerCase() == 'godspeed')
		{
			vgblack = new FlxSprite().loadGraphic(Paths.image('black_vignette', 'exe'));
			tentas = new FlxSprite().loadGraphic(Paths.image('tentacles_black', 'exe'));
			tentas.alpha = 0;
			vgblack.alpha = 0;
			vgblack.cameras = [camHUD];
			tentas.cameras = [camHUD];
			add(vgblack);
			add(tentas);
			health = 2;
			GameOverCameraMove = false;
		}

		if (devoidUI) {
			devoidTimeBarBG = new FlxSprite().loadGraphic(Paths.image('devoidUI/timeBarBG','preload'));
			devoidTimeBarBG.scrollFactor.set();
			devoidTimeBarBG.antialiasing=true;
			devoidTimeBarBG.setGraphicSize(FlxG.width, FlxG.height);
			devoidTimeBarBG.screenCenter();
			devoidTimeBarBG.visible = !ClientPrefs.hideHud;
			DevoidUIControl.add(devoidTimeBarBG);
			if (ClientPrefs.downScroll) devoidTimeBarBG.flipY = true;
			DevoidUIControl.add(timeBar);
			
			devoidUIthing = new FlxSprite().loadGraphic(Paths.image('devoidUI/ui','preload'));
			devoidUIthing.scrollFactor.set();
			devoidUIthing.antialiasing=true;
			devoidUIthing.setGraphicSize(FlxG.width, FlxG.height);
			devoidUIthing.screenCenter();
			devoidUIthing.visible = !ClientPrefs.hideHud;
			DevoidUIControl.add(devoidUIthing);
			if (ClientPrefs.downScroll) devoidUIthing.flipY = true;

			if (bgTBSkin == 'tbR') {
				if(ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
				DevoidUIControl.add(timeBarBGBG);
				DevoidUIControl.add(timeBarBG);
			} else {
				DevoidUIControl.add(timeBarBG);
			}
			DevoidUIControl.add(timeTxt);
			timeBarBG.sprTracker = timeBar;
			if (bgTBSkin == 'tbR') timeBarBGBG.sprTracker = timeBar;

			timeBarBG.visible = false;
			timeBarBGBG.visible = false;
			timeTxt.antialiasing = true;
		}

		FlxG.camera.follow(camFollowPos, LOCKON, 1);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;
		moveCameraSection(0);
		
		if (!xenoEncUI) {
			var bgSize:Float = 1;
			if (fatalUI)
			{
				bgSkin = "fatalHealth";
				bgSize = 1.5;
			}
			if (bgSkin == 'hpR') {
				if (!VHSui)
					ShitO = 25;
				else
					ShitO = 15;
				ShitT = 50;
			}

			var bgHPBColorPath:String = '';
			if (bgSkin == 'hpR') {
				if(ClientPrefs.BarsColor == 'Dark Color') bgHPBColorPath = (bgSkin + '-dark');
				if(ClientPrefs.BarsColor == 'Light Color' || ClientPrefs.BarsColor == 'No Color Change') bgHPBColorPath = (bgSkin + '-light');
				healthBarBG = new AttachedSprite(bgHPBColorPath);
			} else {
				healthBarBG = new AttachedSprite(bgSkin);
			}
			healthBarBG.y = FlxG.height * 0.89;
			healthBarBG.setGraphicSize(Std.int(healthBarBG.width * bgSize));
			healthBarBG.screenCenter(X);
			healthBarBG.scrollFactor.set();
			healthBarBG.visible = !ClientPrefs.hideHud;
			if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
			if (bgSkin == 'hpR')
				healthBarBG.xAdd = -25;
			else
				healthBarBG.xAdd = -4;
			healthBarBG.yAdd = -4;
			if(ClientPrefs.downScroll && !offDownScroll) healthBarBG.y = 0.11 * FlxG.height;
			
			healthBar = new FlxBar(healthBarBG.x + ShitO, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - ShitT), Std.int(healthBarBG.height - 8), this, 'healthbarval', 0, 2);
			healthBar.scrollFactor.set();
			healthBar.visible = !ClientPrefs.hideHud;
			healthBar.alpha = ClientPrefs.healthBarAlpha;
			if (bgSkin == 'hpR') {
				if(ClientPrefs.BarsColor == 'No Color Change') healthBarBG.color = 0xFF000000;
				add(healthBar);
				add(healthBarBG);
			} else {
				add(healthBarBG);
				add(healthBar);
			}
			healthBarBG.sprTracker = healthBar;
			
			if (devoidUI) {
				healthBar.visible = false;
				healthBarBG.visible = false;
			}
			
			if (devoidUI) DevoidUIControlIcons = new FlxTypedSpriteGroup<FlxSprite>();
			switch (SONG.song.toLowerCase()) {
				case 'godspeed', 'final-escape': iconP1 = new HealthIcon(boyfriend.healthIcon, false);
				case 'judgement', 'judgement-old':
					if (boyfriend.curCharacter == 'bf-fe-p1')
						iconP1 = new HealthIcon('fe', true);
					else
						iconP1 = new HealthIcon(boyfriend.healthIcon, true);
				default:
					if (curStage == 'schoolhouse')
						iconP1 = new HealthIcon(boyfriend.healthIcon, false);
					else
						iconP1 = new HealthIcon(boyfriend.healthIcon, true);
			}
			iconP1.y = healthBar.y - 75;
			iconP1.visible = !ClientPrefs.hideHud;
			iconP1.alpha = ClientPrefs.healthBarAlpha;
			if (FEHPThing == 0 && !devoidUI) add(iconP1);
			if (devoidUI) DevoidUIControlIcons.add(iconP1);
			
			iconP2 = new HealthIcon(dad.healthIcon, false, AnimatedDadIcon);
			iconP2.y = healthBar.y - 75;
			iconP2.visible = !ClientPrefs.hideHud;
			iconP2.alpha = ClientPrefs.healthBarAlpha;
			if (FEHPThing == 0 && !devoidUI) add(iconP2);
			if (devoidUI) DevoidUIControlIcons.add(iconP2);
			if (devoidUI) add(DevoidUIControlIcons);
			
			if (FEHPThing != 0 && !xenoEncUI) {
				add(iconP2);
				add(iconP1);
			}
			
			if (devoidUI) {
				iconP1.x = FlxG.width - 147;
				iconP2.x = -28;
				if (!ClientPrefs.downScroll) {
					iconP1.y = -5;
					iconP2.y = -7.5;
				} else {
					iconP1.y = FlxG.height - 125 + 5;
					iconP2.y = FlxG.height - 125 + 7.5;
				}
			}
			reloadHealthBarColors();
		}
		
		if (xenoEncUI) {
			var bgHPBColorPath:String = '';
			if(ClientPrefs.BarsColor == 'Dark Color') bgHPBColorPath = (bgSkin + '-dark');
			if(ClientPrefs.BarsColor == 'Light Color' || ClientPrefs.BarsColor == 'No Color Change') bgHPBColorPath = (bgSkin + '-light');
			healthBarBG = new AttachedSprite(bgHPBColorPath);
			healthBarBG.y = FlxG.height * 0.89;
			healthBarBG.setGraphicSize(Std.int(healthBarBG.width * 1));
			healthBarBG.screenCenter(X);
			healthBarBG.scrollFactor.set();
			healthBarBG.visible = !ClientPrefs.hideHud;
			if (ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
			healthBarBG.xAdd = -25;
			healthBarBG.yAdd = -4;
			if(ClientPrefs.downScroll && !offDownScroll) healthBarBG.y = 0.11 * FlxG.height;
			
			healthBar = new FlxBar(healthBarBG.x + 15, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 50), Std.int(healthBarBG.height - 8), this, 'healthbarval', 0, 2);
			healthBar.scrollFactor.set();
			healthBar.visible = !ClientPrefs.hideHud;
			healthBar.alpha = ClientPrefs.healthBarAlpha;
			if(ClientPrefs.BarsColor == 'No Color Change') healthBarBG.color = 0xFF000000;
			add(healthBar);
			add(healthBarBG);
			healthBarBG.sprTracker = healthBar;

			iconP1 = new HealthIcon(boyfriend.healthIcon, true);
			iconP1.y = healthBar.y - 75;
			iconP1.visible = !ClientPrefs.hideHud;
			iconP1.alpha = ClientPrefs.healthBarAlpha;
			add(iconP1);
			
			iconP2 = new HealthIcon(dad.healthIcon, false);
			iconP2.y = healthBar.y - 75;
			iconP2.visible = !ClientPrefs.hideHud;
			iconP2.alpha = ClientPrefs.healthBarAlpha;
			add(iconP2);
			
			healthBarBG.visible = false;
			healthBar.visible = false;
			iconP1.visible = false;
			iconP2.visible = false;
			
			reloadHealthBarColors();
		}
		
		if (SONG.song.toLowerCase() == 'godspeed') {
			Misses= new FlxText(-670, healthBarBG.y + 36, FlxG.width, "", 20);
			Misses.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			Misses.scrollFactor.set();
			Misses.borderSize = 1.25;
			Misses.visible = !ClientPrefs.hideHud;
			add(Misses);
			
			RUN = new FlxText(0, healthBarBG.y + 36, FlxG.width, "!RUN!", 20);
			RUN.setFormat(Paths.font("vcr.ttf"), 20, 0xFFFF0000, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			RUN.scrollFactor.set();
			RUN.borderSize = 1.25;
			RUN.visible = !ClientPrefs.hideHud;
			add(RUN);
			if (TranslationLanguages.Text.exists(RUN.text) && ClientPrefs.Language != 'English')
				RUN.text = TranslationLanguages.Text[RUN.text];
			
			Rating = new FlxText(670, healthBarBG.y + 36, FlxG.width, "", 20);
			Rating.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			Rating.scrollFactor.set();
			Rating.borderSize = 1.25;
			Rating.visible = !ClientPrefs.hideHud;
			add(Rating);
			if (ClientPrefs.Language != 'English')
				Rating.x = 683;
		} else {
			if(!VHSui) {
				if (!devoidUI) {
					if (!xenoEncUI) {
						scoreTxt = new FlxText(0, healthBarBG.y + 36, FlxG.width, "", 20);
						scoreTxt.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
					}
				} else {
					scoreTxt = new FlxText(2.5, FlxG.height - 50, FlxG.width, "", 45);
					scoreTxt.setFormat(Paths.font("dark-bastion.ttf"), 45, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				
					devoidUImissesTxt = new FlxText(2.5, FlxG.height - 95, FlxG.width, "", 45);
					devoidUImissesTxt.setFormat(Paths.font("dark-bastion.ttf"), 45, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
					devoidUImissesTxt.scrollFactor.set();
					devoidUImissesTxt.borderSize = 1.25;
					devoidUImissesTxt.visible = !ClientPrefs.hideHud;
					DevoidUIControl.add(devoidUImissesTxt);
					
					if (ClientPrefs.downScroll) {
						scoreTxt.y = 2;
						devoidUImissesTxt.y = 47;
					}
				}
			} else {
				iconP1.scale.x = 0.8;
				iconP1.scale.y = 0.8;
				iconP2.scale.x = 0.8;
				iconP2.scale.y = 0.8;
				healthBar.scale.set(0.8, 0.8);
				healthBarBG.scale.set(0.8, 0.8);
				healthBar.x = 50;
				healthBar.y = 660;
				iconP1.x = 545;
				iconP1.y += 20;
				iconP2.x = 535;
				iconP2.y += 20;
			
				scoreTxt = new FlxText(30, 25, FlxG.width, "", 36);
				scoreTxt.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			}
			if (!xenoEncUI) {
				scoreTxt.scrollFactor.set();
				scoreTxt.borderSize = 1.25;
				scoreTxt.visible = !ClientPrefs.hideHud;
				if (devoidUI)
					DevoidUIControl.add(scoreTxt);
				else
					add(scoreTxt);
			}
		}

		botplayTxt = new FlxText(400, timeBarBG.y + 55, FlxG.width - 800, "BOTPLAY", 32);
		if (!devoidUI)
			botplayTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		else
			botplayTxt.setFormat(Paths.font("dark-bastion.ttf"), 38, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 1.25;
		botplayTxt.visible = cpuControlled;
		add(botplayTxt);
		if (TranslationLanguages.Text.exists(botplayTxt.text) && ClientPrefs.Language != 'English')
			botplayTxt.text = TranslationLanguages.Text[botplayTxt.text];
		if(ClientPrefs.downScroll && !offDownScroll) {
			botplayTxt.y = timeBarBG.y - 78;
		}

		if (devoidUI) {
			scoreTxt.antialiasing = true;
			devoidUIhpTxt.antialiasing = true;
			devoidUImissesTxt.antialiasing = true;
		}

		if (isRing)
		{
			ringCounter = new FlxSprite(1133, 610).loadGraphic(Paths.image('Counter', 'exe'));
			add(ringCounter);
			ringCounter.antialiasing = true;
			ringCounter.cameras = [camHUD];

			var strumArray = [0, 1, 3, 4];

			counterNum = new FlxText(1207, 606, 0, '0', 10, false);
			counterNum.setFormat(Paths.font('EurostileTBla.ttf'), 60, FlxColor.fromRGB(255, 204, 51), FlxTextBorderStyle.OUTLINE, FlxColor.fromRGB(204, 102, 0));
			counterNum.setBorderStyle(OUTLINE, FlxColor.fromRGB(204, 102, 0), 3, 1);
			add(counterNum);
			counterNum.antialiasing = true;
			counterNum.cameras = [camHUD];

			if (ClientPrefs.downScroll && !offDownScroll)
			{
				ringCounter.y = 50;
				counterNum.y = 56;
			}
		}

		if (dad.curCharacter == 'starved')
		{
			fearUi = new FlxSprite().loadGraphic(Paths.image('fearbar'));
			fearUi.scrollFactor.set();
			fearUi.screenCenter();
			fearUi.x += 580;
			fearUi.y -= 50;

			fearUiBg = new FlxSprite(fearUi.x, fearUi.y).loadGraphic(Paths.image('fearbarBG'));
			fearUiBg.scrollFactor.set();
			fearUiBg.screenCenter();
			fearUiBg.x += 580;
			fearUiBg.y -= 50;
			add(fearUiBg);

			fearBar = new FlxBar(fearUi.x + 40, fearUi.y + 10, BOTTOM_TO_TOP, 21, 240, this, 'fearNo', 0, 100);
			fearBar.scrollFactor.set();
			fearBar.visible = true;
			fearBar.numDivisions = 1000;
			fearBar.createFilledBar(0x00000000, 0xFFFF0000);
			//trace('bar added.');

			add(fearBar);
			add(fearUi);
		}

		if (dad.curCharacter == 'Satanos')
		{
			fearUi = new FlxSprite().loadGraphic(Paths.image('fearbarS'));
			fearUi.scrollFactor.set();
			fearUi.screenCenter();
			fearUi.antialiasing = true;
			fearUi.x += 580;
			fearUi.y -= 50;

			fearUiBg = new FlxSprite(fearUi.x, fearUi.y).loadGraphic(Paths.image('fearbarBGS'));
			fearUiBg.scrollFactor.set();
			fearUiBg.screenCenter();
			fearUiBg.antialiasing = true;
			fearUiBg.x += 580;
			fearUiBg.y -= 50;
			add(fearUiBg);

			fearBar = new FlxBar(fearUi.x + 28.5, fearUi.y + 5, BOTTOM_TO_TOP, 25, 275, this, 'fearNo', 0, 100);
			fearBar.scrollFactor.set();
			fearBar.visible = true;
			fearBar.numDivisions = 1000;
			fearBar.createFilledBar(0x00000000, 0xFF3F3F3F);
			//trace('bar added.');

			add(fearBar);
			add(fearUi);
		}
		
		if (curStage == 'chamber' || curStage == 'chamber-encore')
		{
			dodgething = new FlxSprite(0, 600);
			dodgething.frames = Paths.getSparrowAtlas('spacebar_icon', 'exe');
			dodgething.animation.addByPrefix('a', 'spacebar', 24, false, false);
			dodgething.scale.x = 0.5;
			dodgething.scale.y = 0.5;
			dodgething.screenCenter();
			dodgething.x -= 60;
			dodgething.visible = false;
			add(dodgething);
		}
		if (SONG.song.toLowerCase() == 'b4cksl4sh')
		{
			warning = new FlxSprite();
			warning.frames = Paths.getSparrowAtlas('slash_warning_sheet', 'exe');
			warning.animation.addByPrefix('warn', 'slash warning');
			warning.setGraphicSize(Std.int(warning.width * 2.5));
			warning.screenCenter();
			warning.visible = false;
			add(warning);
		}
		
		if(sonicHUDStyles.exists(SONG.song.toLowerCase())) hudStyle = sonicHUDStyles.get(SONG.song.toLowerCase());
		if (fatalUI) hudStyle = 'sonic3';
		var hudFolder = hudStyle;
		if(hudStyle == 'soniccd')hudFolder = 'sonic1';
		var scoreLabel:FlxSprite = new FlxSprite(15, 25).loadGraphic(Paths.image('sonicUI/' + hudFolder + '/score'));
		scoreLabel.setGraphicSize(Std.int(scoreLabel.width * 3));
		scoreLabel.updateHitbox();
		scoreLabel.x = 15;
		scoreLabel.antialiasing = false;
		scoreLabel.scrollFactor.set();
		sonicHUD.add(scoreLabel);

		var timeLabel:FlxSprite = new FlxSprite(15, 70).loadGraphic(Paths.image('sonicUI/' + hudFolder + '/time'));
		timeLabel.setGraphicSize(Std.int(timeLabel.width * 3));
		timeLabel.updateHitbox();
		timeLabel.x = 15;
		timeLabel.antialiasing = false;
		timeLabel.scrollFactor.set();
		sonicHUD.add(timeLabel);

		var missLabel:FlxSprite = new FlxSprite(15, 115).loadGraphic(Paths.image('sonicUI/' + hudFolder + '/misses'));
		missLabel.setGraphicSize(Std.int(missLabel.width * 3));
		missLabel.updateHitbox();
		missLabel.x = 15;
		missLabel.antialiasing = false;
		missLabel.scrollFactor.set();
		sonicHUD.add(missLabel);
		
		// score numbers
		if(hudFolder=='sonic3'){
			for(i in 0...7){
				var number = new SonicNumber(0,0,0,hudFolder);
				number.setGraphicSize(Std.int(number.width*3));
				number.updateHitbox();
				number.x = scoreLabel.x + scoreLabel.width + ((9 * i) * 3);
				number.y = scoreLabel.y;
				scoreNumbers.push(number);
				sonicHUD.add(number);
			}
		}else{
			for(i in 0...7){
				var number = new SonicNumber(0,0,0,hudFolder);
				number.setGraphicSize(Std.int(number.width*3));
				number.updateHitbox();
				number.x = scoreLabel.x + scoreLabel.width + ((9 * i) * 3);
				if (ClientPrefs.Language == 'English' && hudFolder != 'chaotix' && hudFolder != 'chotix') number.x += 12;
				if (ClientPrefs.Language == 'Spanish' && hudFolder == 'sonic1') number.x += 10;
				number.y = scoreLabel.y;
				scoreNumbers.push(number);
				sonicHUD.add(number);
			}
		}

		// miss numbers
		for(i in 0...4){
			var number = new SonicNumber(0,0,0,hudFolder);
			number.setGraphicSize(Std.int(number.width*3));
			number.updateHitbox();
			number.x = missLabel.x + missLabel.width + (6*3) + ((9 * i) * 3);
			if (ClientPrefs.Language == 'English' && (hudFolder == 'sonic3' || hudFolder == 'chaotix' || hudFolder == 'chotix')) number.x += 42;
			if (ClientPrefs.Language == 'Spanish' && (hudFolder == 'chaotix' || hudFolder == 'chotix')) number.x += 14;
			if (ClientPrefs.Language == 'Spanish' && hudFolder == 'sonic1') number.x += 24;
			number.y = missLabel.y;
			missNumbers.push(number);
			sonicHUD.add(number);
		}
		
		minNumber = new SonicNumber(0,0,0,hudFolder);
		minNumber.setGraphicSize(Std.int(minNumber.width*3));
		minNumber.updateHitbox();
		minNumber.x = timeLabel.x + timeLabel.width;
		minNumber.y = timeLabel.y;
		sonicHUD.add(minNumber);
		
		var timeColon:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("sonicUI/" + hudFolder + "/colon"));
		timeColon.setGraphicSize(Std.int(timeColon.width * 3));
		timeColon.updateHitbox();
		timeColon.x = 170;
		timeColon.y = timeLabel.y;
		timeColon.antialiasing = false;
		timeColon.scrollFactor.set();
		sonicHUD.add(timeColon);
		
		secondNumberA = new SonicNumber(0,0,0,hudFolder);
		secondNumberA.setGraphicSize(Std.int(secondNumberA.width*3));
		secondNumberA.updateHitbox();
		secondNumberA.x = 186;
		secondNumberA.y = timeLabel.y;
		sonicHUD.add(secondNumberA);

		secondNumberB = new SonicNumber(0,0,0,hudFolder);
		secondNumberB.setGraphicSize(Std.int(secondNumberB.width*3));
		secondNumberB.updateHitbox();
		secondNumberB.x = 213;
		secondNumberB.y = timeLabel.y;
		sonicHUD.add(secondNumberB);

		var timeQuote:FlxSprite = new FlxSprite(0, 0);
		if(hudFolder=='chaotix' || hudFolder=='chotix'){
			timeQuote.loadGraphic(Paths.image("sonicUI/" + hudFolder + "/quote"));
			timeQuote.setGraphicSize(Std.int(timeQuote.width * 3));
			timeQuote.updateHitbox();
			timeQuote.y = timeLabel.y;
			timeQuote.antialiasing = false;
			timeQuote.scrollFactor.set();
			sonicHUD.add(timeQuote);
			
			millisecondNumberA = new SonicNumber(0,0,0,hudFolder);
			millisecondNumberA.setGraphicSize(Std.int(millisecondNumberA.width*3));
			millisecondNumberA.updateHitbox();
			millisecondNumberA.x = timeQuote.x + timeQuote.width + (2*3);
			millisecondNumberA.y = timeLabel.y;
			sonicHUD.add(millisecondNumberA);

			millisecondNumberB = new SonicNumber(0,0,0,hudFolder);
			millisecondNumberB.setGraphicSize(Std.int(millisecondNumberB.width*3));
			millisecondNumberB.updateHitbox();
			millisecondNumberB.x = millisecondNumberA.x + millisecondNumberA.width + 3;
			millisecondNumberB.y = timeLabel.y;
			sonicHUD.add(millisecondNumberB);
		}

		switch(hudFolder){
			case 'chaotix' | 'chotix':
				minNumber.x = timeLabel.x + timeLabel.width + (4*3);
				timeColon.x = minNumber.x + minNumber.width + (2*3);
				secondNumberA.x = timeColon.x + timeColon.width + (4*3);
				secondNumberB.x = secondNumberA.x + secondNumberA.width + 3;
				timeQuote.x = secondNumberB.x + secondNumberB.width;
				millisecondNumberA.x = timeQuote.x + timeQuote.width + (2*3);
				millisecondNumberB.x = millisecondNumberA.x + millisecondNumberA.width + 3;
			case 'sonic3':
				minNumber.x += 87;
				timeColon.x += 87;
				secondNumberA.x += 87;
				secondNumberB.x += 87;
		}

		switch(ClientPrefs.Language) {
			case 'Russian':
				switch(hudFolder) {
					case 'sonic1':
						minNumber.x += 14;
						timeColon.x += 14;
						secondNumberA.x += 14;
						secondNumberB.x += 14;
				}
			case 'Spanish':
				switch(hudFolder) {
					case 'sonic1':
						minNumber.x += 44;
						timeColon.x += 52;
						secondNumberA.x += 44;
						secondNumberB.x += 44;
					case 'sonic3':
						timeColon.x += 4;
					case 'chaotix' | 'chotix':
						minNumber.x += 12;
						timeColon.x += 12;
						timeQuote.x += 12;
						secondNumberA.x += 12;
						secondNumberB.x += 12;
						millisecondNumberA.x += 12;
						millisecondNumberB.x += 12;
				}
		}

		if(!ClientPrefs.downScroll && !offDownScroll){
			for(member in sonicHUD.members){
				member.y = FlxG.height-member.height-member.y;
			}
		}

		if(sonicHUDSongs.contains(SONG.song.toLowerCase()) || fatalUI){
			scoreTxt.visible=false;
			if (SONG.song.toLowerCase() != 'long-sky') {
				timeBar.visible=false;
				timeTxt.visible=false;
				timeBarBG.visible=false;
				if (bgTBSkin == 'tbR') timeBarBGBG.visible=false;
			}
			add(sonicHUD);
		}

		updateSonicScore();
		updateSonicMisses();

		if(SONG.song.toLowerCase()=='you-cant-run' || SONG.song.toLowerCase()=='you-cant-run-encore' || SONG.song.toLowerCase()=='final-escape'){
			scoreTxt.visible=!ClientPrefs.hideHud;
			if (ClientPrefs.timeBarType != 'Disabled') {
				timeBar.visible=true;
				timeBarBG.visible=true;
				if (bgTBSkin == 'tbR') timeBarBGBG.visible=true;
				timeTxt.visible=true;
			}
			sonicHUD.visible=false;
		}
		strumLineNotes.cameras = [camHUD];
		grpNoteSplashes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		if (SONG.song.toLowerCase() == 'godspeed') {
			Misses.cameras = [camHUD];
			RUN.cameras = [camHUD];
			Rating.cameras = [camHUD];
		} else {
			scoreTxt.cameras = [camHUD];
			if (devoidUI) {
				devoidTimeBarBG.cameras = [camHUD];
				devoidUIthing.cameras = [camHUD];
				devoidHPBar.cameras = [camHUD];
				devoidUIhpTxt.cameras = [camHUD];
				devoidUImissesTxt.cameras = [camHUD];
			}
			if (xenoEncUI) {
				xenoEncHP.cameras = [camHUD];
				xenoEncMissesTxt.cameras = [camHUD];
				xenoEncUIthing.cameras = [camHUD];
				xenoEncIconP1.cameras = [camHUD];
				xenoEncIconP2.cameras = [camHUD];
				xenoEncHealthBar.cameras = [camHUD];
			}
			if (VHSui) irlTxt.cameras = [camHUD];
		}
		botplayTxt.cameras = [camHUD];
		timeBar.cameras = [camHUD];
		timeBarBG.cameras = [camHUD];
		if (bgTBSkin == 'tbR') timeBarBGBG.cameras = [camHUD];
		timeTxt.cameras = [camHUD];
		if (dad.curCharacter == 'starved' || dad.curCharacter == 'Satanos')
		{
			fearUiBg.cameras = [camHUD];
			fearBar.cameras = [camHUD];
			fearUi.cameras = [camHUD];
		}
		if (curStage == 'chamber' || curStage == 'chamber-encore')
		{
			dodgething.cameras = [camHUD];
		}
		if (SONG.song.toLowerCase() == 'b4cksl4sh') {
			warning.cameras = [camHUD];
		}
		sonicHUD.cameras = [camHUD];
		startBG.cameras = [camOther];
		blackFuck.cameras = [camOther];
		startCircle.cameras = [camOther];
		startText.cameras = [camOther];
		if (SONG.song.toLowerCase() == 'you-cant-run-encore') {
			topBar.cameras = [camOther];
			bottomBar.cameras = [camOther];
			topBar.alpha = 0;
			bottomBar.alpha = 0;
			add(topBar);
			add(bottomBar);
		} else {
			if (SONG.song.toLowerCase() == 'too-slow-encore' || SONG.song.toLowerCase() == 'too-slow-encore-alt') {
				topBar.cameras = [camOverlay];
				bottomBar.cameras = [camOverlay];
			} else {
				topBar.cameras = [camHUD];
				bottomBar.cameras = [camHUD];
			}
		}
		
		if(curStage == 'fatality') {
			daStatix.cameras = [camHUD];
			add(daStatix);
		}
		
		switch (curStage) {
			case "batman" | "castle" | "cave" | "died" | "died-alt" | "dng" | "endless-stage" | "fire" | "godspeed" | "hell" | "hollow" | "hotv" | "kn" | "LukasWorld" | "too-fest-old" | "my-horizon-wechidna" | "nature" | "noname" | "omw" | "requite" | "sl4sh" | "ugly" | "xd" | "xterion-digitalized" | "serious" | "critical-error" | "endless-jp" | "endeavors" | "fatal-encore":
				noCamMove = true;
			default:
				noCamMove = false;
		}

		var centerP = new FlxSprite(0, 0);
		centerP.screenCenter(XY);

		center = FlxPoint.get(centerP.x, centerP.y);
		doof.cameras = [camHUD];

		#if mobile
		switch (SONG.song.toLowerCase()) {
			case 'chaos' | 'chaos-encore' | 'running-wild' | 'b4cksl4sh' | 'coulrophobia' | 'hedge':
				addMobileControls(true, true);
				if (ClientPrefs.isvpad && ClientPrefs.space == 'button' && MobileControls.mode != 'Keyboard') {
					addVirtualPad(NONE, DODGE);
					addVirtualPadCamera(false);
					virtualPad.visible = false;
				}
		}

        if (SONG.isRing) {
            addMobileControls(true, true);

            if (ClientPrefs.isvpad && ClientPrefs.space == 'button' && MobileControls.mode != 'Keyboard') {
                addVirtualPad(NONE, DODGE);
                addVirtualPadCamera(false);
                virtualPad.visible = false;
            }
        } else {
            addMobileControls(false, true);
        }
        mobileControls.visible = false;
        #end

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		// SONG SPECIFIC SCRIPTS
		#if LUA_ALLOWED
		var filesPushed:Array<String> = [];
		var foldersToCheck:Array<String> = [Paths.getPreloadPath('data/' + Paths.formatToSongPath(SONG.song) + '/')];

		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('data/' + Paths.formatToSongPath(SONG.song) + '/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/data/' + Paths.formatToSongPath(SONG.song) + '/'));
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if(file.endsWith('.lua') && !filesPushed.contains(file))
					{
						luaArray.push(new FunkinLua(folder + file));
						filesPushed.push(file);
					}
				}
			}
		}
		#end
		
		add(barbedWires);
		add(wireVignette);
		
		var daSong:String = Paths.formatToSongPath(curSong);
			switch (daSong)
			{
				case 'soulless' | 'final-escape' | 'personel' | 'personel-serious':
					if (daSong == 'soulless')
						camHUD.alpha = 0;
					if (daSong == 'soulless' || daSong == 'personel' || daSong == 'personel-serious')
						camGame.alpha = 0;
					
					add(blackFuck);
					blackFuck.alpha = 0;
					startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
					startCircle.x += 900;
					startCircle.alpha = 0;
					add(startCircle);
					startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
					startText.x -= 1200;
					startText.alpha = 0;
					add(startText);
					
					if (ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && isSound)
						startScreenTweenName = 'not-now';
					startCountdown();
					
				case 'endless' | 'endless-jp' | 'endless-og' | 'chaos-encore' | 'drippyshine' | 'endless-encore' | 'envy' | 'gorefest' | 'lurk' | 'skincrawler' | 'faker-encore' | 'forever-unnamed' | 'found-you' | 'frenzy' | 'haze' | 'haze-og' | 'her-world-encore' | 'hollow-encore' | 'insidious' | 'color-blind-old' | 'last-hope' | 'long-sky' | 'lukas-world' | 'marauder' | 'melting-old' | 'miasma' | 'oxxynless' | 'perdition-apollyon' | 'personel-serious' | 'personel' | 'planestrider' | 'reunion' | 'round-a-bout-encore' | 'sharpy-showdown' | 'soured' | 'sunshine-encore' | 'sunshine' | 'terror' | 'too-fest' | 'ugly' | 'unblessful-hedgehog' | 'old-ycr-slaps' | 'endless-us' | 'prey' | 'call-of-justice-old' | 'fight-or-flight'| 'round-a-bout' | 'b4cksl4sh' | 'face-off' | 'ice-cap' | 'malediction' | 'faker' | 'black-sun' | 'godspeed' | 'shocker' | 'perdition' | 'purgatory' | 'underworld' | 'missiletoe' | 'her-world' | 'her-world-old' | 'relax' | 'forestall-desire' | 'broken-heart' | 'tribal' | 'endeavors' | 'slaybells' | 'my-horizon' | 'too-fest-old' | 'tetrabrachial' | 'my-horizon-wechidna' | 'our-horizon' | 'hedge' | 'manual-blast' | 'hollow' | 'hollow-old' |  'empty' | 'substantial' | 'digitalized' | 'gotta-go' | 'mania' | 'universal-collapse' | 'goddess' | 'color-blind' | 'corinthians' | 'genesis' | 'coulrophobia' | 'extreme-zap' | 'fake-baby' | 'extricate-hex' | 'gods-will' | 'gotta-go-red-glove' | 'heroes-and-villains' | 'running-wild' | 'melting' | 'too-far' | 'confronting' | 'too-far-alt' | 'animosity' | 'call-of-justice' | 'spike-trap' | 'jingle-hells' | 'hill-of-the-void' | 'endeavors-og' | 'thunderbolt' | 'color-blind-encore' | 'life-and-death' | 'hellstorm':
					add(blackFuck);
					
					startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
					startCircle.x += 900;
					add(startCircle);

					startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
					startText.x -= 1200;
					add(startText);
					
					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('classic');
					else
						startScreenTweenName = 'classic';
					startCountdown();
					
				case 'milk' | 'cool-party' | 'nostalgic-duo':
					add(blackFuck);
					if (daSong == 'cool-party')
						startCircle.loadGraphic(Paths.image('StartScreens/Sunky-cool', 'exe'));
					else if (daSong == 'nostalgic-duo')
						startCircle.loadGraphic(Paths.image('StartScreens/Sunky-nostalgic', 'exe'));
					else
						startCircle.loadGraphic(Paths.image('StartScreens/Sunky', 'exe'));
					startCircle.scale.x = 0;
					startCircle.x += 50;
					add(startCircle);
					
					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('sunky');
					else
						startScreenTweenName = 'sunky';
					startCountdown();

				case 'chaos-encore':
					if (ChaosCutscene) {
						cinematicBars(true);
						camHUD.visible = false;
						ChaosCutscene = false;
						dad.visible = false;
						boyfriendGroup.visible = false;
						dad.setPosition(600, 400);
						snapCamFollowToPos(900, 700);
						// camFollowPos.setPosition(900, 700);
						FlxG.camera.focusOn(camFollowPos.getPosition());
						new FlxTimer().start(0.5, function(lol:FlxTimer)
						{
							if (true)
							{
								new FlxTimer().start(1, function(lol:FlxTimer)
								{
									FlxTween.tween(FlxG.camera, {zoom: 1.5}, 3, {ease: FlxEase.cubeOut});
									FlxG.sound.play(Paths.sound('robot', 'exe'));
									FlxG.camera.flash(FlxColor.RED, 0.2);
								});
								new FlxTimer().start(2, function(lol:FlxTimer)
								{
									FlxG.sound.play(Paths.sound('sonic', 'exe'));
									if (!ClientPrefs.PotatoOptimization) thechamber.animation.play('a');
								});

								new FlxTimer().start(6, function(lol:FlxTimer)
								{
									startCountdown();
									FlxG.sound.play(Paths.sound('beam', 'exe'));
									FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.2, {ease: FlxEase.cubeOut});
									FlxG.camera.shake(0.02, 0.2);
									FlxG.camera.flash(FlxColor.WHITE, 0.2);
									if (!ClientPrefs.PotatoOptimization) {
										floor.animation.play('b');
										fleetwaybgshit.animation.play('b');
										pebles.animation.play('b');
										emeraldbeamyellow.visible = true;
										emeraldbeam.visible = false;
									}
								});
							}
							else
								lol.reset();
						});
					} else {
						if (!ClientPrefs.PotatoOptimization) {
							thechamber.animation.play('b');
							floor.animation.play('b');
							fleetwaybgshit.animation.play('b');
							pebles.animation.play('b');
							emeraldbeamyellow.visible = true;
							emeraldbeam.visible = false;
						}
					
						cinematicBars(true);
						camHUD.visible = false;
						dad.visible = false;
						boyfriendGroup.visible = false;
						dad.setPosition(600, 400);
						snapCamFollowToPos(900, 700);
						FlxG.camera.focusOn(camFollowPos.getPosition());

						startCountdown();
					}
					
					add(blackFuck);
					blackFuck.alpha = 0;
					startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
					startCircle.x += 900;
					startCircle.alpha = 0;
					add(startCircle);
					startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
					startText.x -= 1200;
					startText.alpha = 0;
					add(startText);
					
				case 'chaos':
					if (ChaosCutscene) {
						cinematicBars(true);
						camHUD.visible = false;
						ChaosCutscene = false;
						dad.visible = false;
						boyfriendGroup.visible = false;
						dad.setPosition(600, 400);
						snapCamFollowToPos(900, 700);
						// camFollowPos.setPosition(900, 700);
						FlxG.camera.focusOn(camFollowPos.getPosition());
						new FlxTimer().start(0.5, function(lol:FlxTimer)
						{
							if (true)
							{
								new FlxTimer().start(1, function(lol:FlxTimer)
								{
									FlxTween.tween(FlxG.camera, {zoom: 1.5}, 3, {ease: FlxEase.cubeOut});
									FlxG.sound.play(Paths.sound('robot', 'exe'));
									FlxG.camera.flash(FlxColor.RED, 0.2);
								});
								new FlxTimer().start(2, function(lol:FlxTimer)
								{
									FlxG.sound.play(Paths.sound('sonic', 'exe'));
									if (!ClientPrefs.PotatoOptimization) thechamber.animation.play('a');
								});

								new FlxTimer().start(6, function(lol:FlxTimer)
								{
									startCountdown();
									FlxG.sound.play(Paths.sound('beam', 'exe'));
									FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.2, {ease: FlxEase.cubeOut});
									FlxG.camera.shake(0.02, 0.2);
									FlxG.camera.flash(FlxColor.WHITE, 0.2);
									if (!ClientPrefs.PotatoOptimization) {
										floor.animation.play('b');
										fleetwaybgshit.animation.play('b');
										pebles.animation.play('b');
										emeraldbeamyellow.visible = true;
										emeraldbeam.visible = false;
									}
								});
							}
							else
								lol.reset();
						});
					} else {
						if (!ClientPrefs.PotatoOptimization) {
							thechamber.animation.play('b');
							floor.animation.play('b');
							fleetwaybgshit.animation.play('b');
							pebles.animation.play('a');
							emeraldbeamyellow.visible = true;
							emeraldbeam.visible = false;
						}
					
						cinematicBars(true);
						camHUD.visible = false;
						dad.visible = false;
						boyfriendGroup.visible = false;
						dad.setPosition(600, 400);
						snapCamFollowToPos(900, 700);
						FlxG.camera.focusOn(camFollowPos.getPosition());

						startCountdown();
					}
					
					add(blackFuck);
					blackFuck.alpha = 0;
					startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
					startCircle.x += 900;
					startCircle.alpha = 0;
					add(startCircle);
					startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
					startText.x -= 1200;
					startText.alpha = 0;
					add(startText);

				case 'old-tails-doll-count':
					readyTailsDoll.loadGraphic(Paths.image('ready', 'exe'));
					setTailsDoll.loadGraphic(Paths.image('set', 'exe'));
					goTailsDoll.loadGraphic(Paths.image('go', 'exe'));

					readyTailsDoll.scale.x = 0.5;
					setTailsDoll.scale.x = 0.5;
					goTailsDoll.scale.x = 0.7;
					readyTailsDoll.scale.y = 0.5;
					setTailsDoll.scale.y = 0.5;
					goTailsDoll.scale.y = 0.7;
					readyTailsDoll.screenCenter();
					setTailsDoll.screenCenter();
					goTailsDoll.screenCenter();
					readyTailsDoll.cameras = [camHUD];
					setTailsDoll.cameras = [camHUD];
					goTailsDoll.cameras = [camHUD];

					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('tails-doll');
					else
						startScreenTweenName = 'tails-doll';

				case 'fatality' | 'fatality-encore' | 'critical-error' | 'unresponsive':
					startScreenSplash = true;
					add(blackFuck);
					
					fatalReady = new FlxSprite().loadGraphic(Paths.image("StartScreens/fatal_2", "exe"));
					fatalReady.setGraphicSize(Std.int(fatalReady.width * daPixelZoom));
					fatalReady.scrollFactor.set();
					fatalReady.updateHitbox();
					fatalReady.screenCenter();
					fatalReady.alpha = 0;
					fatalReady.cameras = [camOther];
					fatalReady.antialiasing = false;
					
					fatalSet = new FlxSprite().loadGraphic(Paths.image("StartScreens/fatal_1", "exe"));
					fatalSet.setGraphicSize(Std.int(fatalSet.width * daPixelZoom));
					fatalSet.scrollFactor.set();
					fatalSet.updateHitbox();
					fatalSet.screenCenter();
					fatalSet.alpha = 0;
					fatalSet.cameras = [camOther];
					fatalSet.antialiasing = false;
					
					fatalGo = new FlxSprite().loadGraphic(Paths.image("StartScreens/fatal_go", "exe"));
					fatalGo.setGraphicSize(Std.int(fatalGo.width * daPixelZoom));
					fatalGo.scrollFactor.set();
					fatalGo.updateHitbox();
					fatalGo.screenCenter();
					fatalGo.alpha = 0;
					fatalGo.cameras = [camOther];
					fatalGo.antialiasing = false;
					
					if (startScreenSplash) {
						startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
						startCircle.x += 900;
						startCircle.alpha = 0;
						startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
						startText.x -= 1200;
						startText.alpha = 0;
					}
					
					add(fatalReady);
					add(fatalSet);
					add(fatalGo);
					if (startScreenSplash) {
						add(startCircle);
						add(startText);
					}
				
					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('fatal');
					else
						startScreenTweenName = 'fatal';
					startCountdown();

				case 'execution' | 'cycles' | 'hellbent' | 'fate' | 'judgement' | 'execution-inski' | 'gatekeepers' | 'cycles-encore':
					startScreenSplash = true;
					add(blackFuck);
					
					LordXThree = new FlxSprite().loadGraphic(Paths.image("x-count/three", "exe"));
					LordXThree.scrollFactor.set();
					LordXThree.updateHitbox();
					LordXThree.screenCenter();
					LordXThree.alpha = 0;
					LordXThree.cameras = [camOther];
					LordXThree.antialiasing = ClientPrefs.globalAntialiasing;
					
					LordXTwo = new FlxSprite().loadGraphic(Paths.image("x-count/two", "exe"));
					LordXTwo.scrollFactor.set();
					LordXTwo.updateHitbox();
					LordXTwo.screenCenter();
					LordXTwo.alpha = 0;
					LordXTwo.cameras = [camOther];
					LordXTwo.antialiasing = ClientPrefs.globalAntialiasing;
					
					LordXOne = new FlxSprite().loadGraphic(Paths.image("x-count/one", "exe"));
					LordXOne.scrollFactor.set();
					LordXOne.updateHitbox();
					LordXOne.screenCenter();
					LordXOne.alpha = 0;
					LordXOne.cameras = [camOther];
					LordXOne.antialiasing = ClientPrefs.globalAntialiasing;
					
					LordXFun = new FlxSprite().loadGraphic(Paths.image("x-count/fun", "exe"));
					LordXFun.scrollFactor.set();
					LordXFun.updateHitbox();
					LordXFun.screenCenter();
					LordXFun.alpha = 0;
					LordXFun.cameras = [camOther];
					LordXFun.antialiasing = ClientPrefs.globalAntialiasing;
					
					if (startScreenSplash) {
						startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
						startCircle.x += 900;
						startCircle.alpha = 0;
						startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
						startText.x -= 1200;
						startText.alpha = 0;
					}
					
					add(LordXThree);
					add(LordXTwo);
					add(LordXOne);
					add(LordXFun);
					if (startScreenSplash) {
						add(startCircle);
						add(startText);
					}

					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('lord-x');
					else
						startScreenTweenName = 'lord-x';
					startCountdown();

				case 'too-slow' | 'you-cant-run' | 'triple-trouble' | 'too-slow-encore' | 'too-slow-encore-alt' | 'you-cant-run-encore' | 'triple-trouble-encore' | 'final-escape-encore':
					startScreenSplash = true;
					if (daSong == 'final-escape-encore') startScreenSplash = false;
					add(blackFuck);
					
					XenoThree = new FlxSprite().loadGraphic(Paths.image("xeno-count/three", "exe"));
					XenoThree.scrollFactor.set();
					XenoThree.updateHitbox();
					XenoThree.screenCenter();
					XenoThree.alpha = 0;
					XenoThree.cameras = [camOther];
					XenoThree.antialiasing = ClientPrefs.globalAntialiasing;
					
					XenoTwo = new FlxSprite().loadGraphic(Paths.image("xeno-count/two", "exe"));
					XenoTwo.scrollFactor.set();
					XenoTwo.updateHitbox();
					XenoTwo.screenCenter();
					XenoTwo.alpha = 0;
					XenoTwo.cameras = [camOther];
					XenoTwo.antialiasing = ClientPrefs.globalAntialiasing;
					
					XenoOne = new FlxSprite().loadGraphic(Paths.image("xeno-count/one", "exe"));
					XenoOne.scrollFactor.set();
					XenoOne.updateHitbox();
					XenoOne.screenCenter();
					XenoOne.alpha = 0;
					XenoOne.cameras = [camOther];
					XenoOne.antialiasing = ClientPrefs.globalAntialiasing;
					
					XenoDie = new FlxSprite().loadGraphic(Paths.image("xeno-count/die", "exe"));
					XenoDie.scrollFactor.set();
					XenoDie.updateHitbox();
					XenoDie.screenCenter();
					XenoDie.alpha = 0;
					XenoDie.cameras = [camOther];
					XenoDie.antialiasing = ClientPrefs.globalAntialiasing;
					
					if (startScreenSplash) {
						startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
						startCircle.x += 900;
						startCircle.alpha = 0;
						startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
						startText.x -= 1200;
						startText.alpha = 0;
					}
					
					add(XenoThree);
					add(XenoTwo);
					add(XenoOne);
					add(XenoDie);
					if (startScreenSplash) {
						add(startCircle);
						add(startText);
					}
					
					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('xeno');
					else
						startScreenTweenName = 'xeno';
					startCountdown();
				
				case 'playful' | 'expulsion' | 'burning':
					add(blackFuck);
					switch (daSong) {
						case 'playful' | 'expulsion': startBG.loadGraphic(Paths.image('StartScreens/BG-educator', 'exe'));
						case 'burning': startBG.loadGraphic(Paths.image('StartScreens/BG-shp', 'exe'));
					}
					startBG.alpha = 0;
					add(startBG);
					startCircle.loadGraphic(Paths.image('StartScreens/Circle-'+ daSong, 'exe'));
					startCircle.x += 900;
					add(startCircle);
					startText.loadGraphic(Paths.image('StartScreens/Text-' + daSong, 'exe'));
					startText.x -= 1200;
					add(startText);

					if (!ClientPrefs.songsHaveCutsceneCheckbox.contains(SONG.song.toLowerCase()) && !isSound)
						startScreenTween('classic-bg');
					else
						startScreenTweenName = 'classic-bg';
					startCountdown();
				
				case 'found-you':
					snapCamFollowToPos(700, 400);
					new FlxTimer().start(0, function(tmr:FlxTimer)
						{
							FlxG.camera.focusOn(camFollowPos.getPosition());
						});
					startCountdown();
					camHUD.visible = false;

				default:
					startCountdown();
			}
		RecalculateRating();
		
		//Majin Count Sprites Preload :D
		MajinCountThree = new FlxSprite().loadGraphic(Paths.image('three', 'exe'));
		MajinCountThree.scrollFactor.set();
		MajinCountThree.updateHitbox();
		MajinCountThree.screenCenter();
		MajinCountThree.y -= 100;
		MajinCountThree.alpha = 0;
		MajinCountThree.cameras = [camOther];
		MajinCountThree.antialiasing = ClientPrefs.globalAntialiasing;

		MajinCountTwo = new FlxSprite().loadGraphic(Paths.image('two', 'exe'));
		MajinCountTwo.scrollFactor.set();
		MajinCountTwo.screenCenter();
		MajinCountTwo.y -= 100;
		MajinCountTwo.alpha = 0;
		MajinCountTwo.cameras = [camOther];
		MajinCountTwo.antialiasing = ClientPrefs.globalAntialiasing;

		MajinCountOne = new FlxSprite().loadGraphic(Paths.image('one', 'exe'));
		MajinCountOne.scrollFactor.set();
		MajinCountOne.screenCenter();
		MajinCountOne.y -= 100;
		MajinCountOne.alpha = 0;
		MajinCountOne.cameras = [camOther];
		MajinCountOne.antialiasing = ClientPrefs.globalAntialiasing;

		MajinCountGo = new FlxSprite().loadGraphic(Paths.image('gofun', 'exe'));
		MajinCountGo.scrollFactor.set();
		MajinCountGo.updateHitbox();
		MajinCountGo.screenCenter();
		MajinCountGo.y -= 100;
		MajinCountGo.alpha = 0;
		MajinCountGo.cameras = [camOther];
		MajinCountGo.antialiasing = ClientPrefs.globalAntialiasing;
		
		
		//PRECACHING MISS SOUNDS BECAUSE I THINK THEY CAN LAG PEOPLE AND FUCK THEM UP IDK HOW HAXE WORKS
		if(ClientPrefs.hitsoundVolume > 0) CoolUtil.precacheSound('hitsound');
		CoolUtil.precacheSound('missnote1');
		CoolUtil.precacheSound('missnote2');
		CoolUtil.precacheSound('missnote3');
		CoolUtil.precacheMusic('breakfast');

		#if desktop
		var rpcF:String = ' (Charting Mode)';
		if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
			rpcF = TranslationLanguages.Text[rpcF];
		if (!chartingMode)
			DiscordClient.changePresence(detailsText, SongLang + SONG.song);
		else
			DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF);
		#end

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		curBF = boyfriend.curCharacter;
		curDAD = dad.curCharacter;
		curGF = gf.curCharacter;
		
		Conductor.safeZoneOffset = (ClientPrefs.safeFrames / 60) * 1000;
		callOnLuas('onCreatePost', []);
		
		super.create();

		Paths.clearUnusedMemory();
	}

	function SunshinePopup() {
	  for(x2 in 0...Math.ceil(FlxG.width / w)+20) {
		  for(y2 in 0...(Math.ceil(FlxG.height / h)+20)) {
			  saturn = new FlxSprite(x2 * w , y2 * h );
			  saturn.loadGraphic(Paths.image("bgs/sunshineEncore/saturn"));
			  saturn.antialiasing = true;
			  saturn.alpha = FlxG.random.float(0.1, 0.4);
			  saturn.scale.set(FlxG.random.float(0.3, 1.5), FlxG.random.float(0.3, 1.7));
			  saturn.scrollFactor.set(FlxG.random.float(0.7, 2.6), FlxG.random.float(1, 3));
			  saturn.x -= 700;
			  saturn.y -= FlxG.random.float(500, 600);
			  saturn.velocity.y = -80;
			  saturn.velocity.x = -80;
			  saturn.blend = BlendMode.ADD;
			  add(saturn);
		  }
	  }
	}

	public function addTextToDebug(text:String, color:FlxColor) {
		#if LUA_ALLOWED
		luaDebugGroup.forEachAlive(function(spr:DebugLuaText) {
			spr.y += 20;
		});

		if(luaDebugGroup.members.length > 34) {
			var blah = luaDebugGroup.members[34];
			blah.destroy();
			luaDebugGroup.remove(blah);
		}
		luaDebugGroup.insert(0, new DebugLuaText(text, luaDebugGroup, color));
		#end
	}

	public function reloadHealthBarColors()
	{
		if (!xenoEncUI) {
			if (GFIconChange) {
				if (!HPBarAlreadyChanged) {
					if (!bfIsLeft)
						healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
							FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
					else
						healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
							FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
					HPBarAlreadyChanged = true;
					healthBar.updateBar();
				}
				
				if (GFandDad) {
					if (HPBarColor == 'dad') {
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						healthBar.updateBar();
					}
					if (HPBarColor == 'gf') {
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
						}
						healthBar.updateBar();
					}
				} else {
					if (HPBarColor == 'bf') {
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						healthBar.updateBar();
					}
					if (HPBarColor == 'gf') {
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						healthBar.updateBar();
					}
				}
			} else {
				if (!bfIsLeft)
					healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
						FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
				else
					healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
						FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						
				healthBar.updateBar();
			}
		} else {
			if (GFIconChange) {
				if (!HPBarAlreadyChanged) {
					if (!bfIsLeft)
						xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
							FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
					else
						xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
							FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
					if (!bfIsLeft)
						healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
							FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
					else
						healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
							FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
					HPBarAlreadyChanged = true;
					xenoEncHealthBar.updateBar();
					healthBar.updateBar();
				}
				
				if (GFandDad) {
					if (HPBarColor == 'dad') {
						if (!bfIsLeft) {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						healthBar.updateBar();
						xenoEncHealthBar.updateBar();
					}
					if (HPBarColor == 'gf') {
						if (!bfIsLeft) {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
						}
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
						}
						healthBar.updateBar();
						xenoEncHealthBar.updateBar();
					}
				} else {
					if (HPBarColor == 'bf') {
						if (!bfIsLeft) {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						healthBar.updateBar();
						xenoEncHealthBar.updateBar();
					}
					if (HPBarColor == 'gf') {
						if (!bfIsLeft) {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
						} else {
							xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						if (!bfIsLeft) {
							healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
								FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]));
						} else {
							healthBar.createFilledBar(FlxColor.fromRGB(gf.healthColorArray[0], gf.healthColorArray[1], gf.healthColorArray[2]),
								FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						}
						healthBar.updateBar();
						xenoEncHealthBar.updateBar();
					}
				}
			} else {
				if (!bfIsLeft)
					xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
						FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
				else
					xenoEncHealthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
						FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
				if (!bfIsLeft)
					healthBar.createFilledBar(FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]),
						FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]));
				else
					healthBar.createFilledBar(FlxColor.fromRGB(boyfriend.healthColorArray[0], boyfriend.healthColorArray[1], boyfriend.healthColorArray[2]),
						FlxColor.fromRGB(dad.healthColorArray[0], dad.healthColorArray[1], dad.healthColorArray[2]));
						
				healthBar.updateBar();	
				xenoEncHealthBar.updateBar();
			}
		}
	}
	public function addCharacterToList(newCharacter:String, type:Int) {
		switch(type) {
			case 0:
				if(!boyfriendMap.exists(newCharacter)) {
					var newBoyfriend:Boyfriend = new Boyfriend(0, 0, newCharacter);
					boyfriendMap.set(newCharacter, newBoyfriend);
					boyfriendGroup.add(newBoyfriend);
					startCharacterPos(newBoyfriend);
					newBoyfriend.alpha = 0.00001;
					startCharacterLua(newBoyfriend.curCharacter);
				}

			case 1:
				if(!dadMap.exists(newCharacter)) {
					var newDad:Character = new Character(0, 0, newCharacter);
					dadMap.set(newCharacter, newDad);
					dadGroup.add(newDad);
					startCharacterPos(newDad, true);
					newDad.alpha = 0.00001;
					startCharacterLua(newDad.curCharacter);
				}

			case 2:
				if(gf != null && !gfMap.exists(newCharacter)) {
					var newGf:Character = new Character(0, 0, newCharacter);
					newGf.scrollFactor.set(0.95, 0.95);
					gfMap.set(newCharacter, newGf);
					gfGroup.add(newGf);
					startCharacterPos(newGf);
					newGf.alpha = 0.00001;
					startCharacterLua(newGf.curCharacter);
				}
		}
	}

	function startCharacterLua(name:String)
	{
		#if LUA_ALLOWED
		var doPush:Bool = false;
		var luaFile:String = 'characters/' + name + '.lua';

		#if desktop
		if(FileSystem.exists(Paths.modFolders(luaFile))) {
			luaFile = Paths.modFolders(luaFile);
			doPush = true;
		} else {
			luaFile = Paths.getPreloadPath(luaFile);
			if(FileSystem.exists(luaFile)) {
				doPush = true;
			}
		}
		#else
		luaFile = Paths.getPreloadPath(luaFile);
		if(Assets.exists(luaFile)) {
			doPush = true;
		}
		#end

		if(doPush)
		{
			for (lua in luaArray)
			{
				if(lua.scriptName == luaFile) return;
			}
			luaArray.push(new FunkinLua(luaFile));
		}
		#end
	}
	
	function startCharacterPos(char:Character, ?gfCheck:Bool = false) {
		if(gfCheck && char.curCharacter.startsWith('gf')) { //IF DAD IS GIRLFRIEND, HE GOES TO HER POSITION
			char.setPosition(GF_X, GF_Y);
			char.scrollFactor.set(0.95, 0.95);
			char.danceEveryNumBeats = 2;
		}
		char.x += char.positionArray[0];
		char.y += char.positionArray[1];
	}

	public function addShaderToCamera(cam:String,effect:ShaderEffect){
		switch(cam.toLowerCase()) {
			case 'camhud' | 'hud':
					camHUDShaders.push(effect);
					var newCamEffects:Array<BitmapFilter>=[];
					for(i in camHUDShaders){
					  newCamEffects.push(new ShaderFilter(i.shader));
					}
					camHUD.setFilters(newCamEffects);
			case 'camother' | 'other':
					camOtherShaders.push(effect);
					var newCamEffects:Array<BitmapFilter>=[];
					for(i in camOtherShaders){
					  newCamEffects.push(new ShaderFilter(i.shader));
					}
					camOther.setFilters(newCamEffects);
			case 'camgame' | 'game':
					camGameShaders.push(effect);
					var newCamEffects:Array<BitmapFilter>=[];
					for(i in camGameShaders){
					  newCamEffects.push(new ShaderFilter(i.shader));
					}
					camGame.setFilters(newCamEffects);
			default:
				if(modchartSprites.exists(cam)) {
					Reflect.setProperty(modchartSprites.get(cam),"shader",effect.shader);
				} else if(modchartTexts.exists(cam)) {
					Reflect.setProperty(modchartTexts.get(cam),"shader",effect.shader);
				} else {
					var OBJ = Reflect.getProperty(PlayState.instance,cam);
					Reflect.setProperty(OBJ,"shader", effect.shader);
				}	
		}
  }

  public function removeShaderFromCamera(cam:String,effect:ShaderEffect){
		switch(cam.toLowerCase()) {
			case 'camhud' | 'hud': 
					camHUDShaders.remove(effect);
					var newCamEffects:Array<BitmapFilter>=[];
					for(i in camHUDShaders){
					  newCamEffects.push(new ShaderFilter(i.shader));
					}
					camHUD.setFilters(newCamEffects);
			case 'camother' | 'other': 
					camOtherShaders.remove(effect);
					var newCamEffects:Array<BitmapFilter>=[];
					for(i in camOtherShaders){
					  newCamEffects.push(new ShaderFilter(i.shader));
					}
					camOther.setFilters(newCamEffects);
			default: 
				camGameShaders.remove(effect);
				var newCamEffects:Array<BitmapFilter>=[];
				for(i in camGameShaders){
				  newCamEffects.push(new ShaderFilter(i.shader));
				}
				camGame.setFilters(newCamEffects);
		}
  }
	
  public function clearShaderFromCamera(cam:String){
		switch(cam.toLowerCase()) {
			case 'camhud' | 'hud': 
				camHUDShaders = [];
				var newCamEffects:Array<BitmapFilter>=[];
				camHUD.setFilters(newCamEffects);
			case 'camother' | 'other': 
				camOtherShaders = [];
				var newCamEffects:Array<BitmapFilter>=[];
				camOther.setFilters(newCamEffects);
			default: 
				camGameShaders = [];
				var newCamEffects:Array<BitmapFilter>=[];
				camGame.setFilters(newCamEffects);
		}
	}
	public function startVideo(name:String):Void {
		#if VIDEOS_ALLOWED
		var foundFile:Bool = false;
		var fileName:String = #if MODS_ALLOWED Paths.modFolders('videos/' + name + '.' + Paths.VIDEO_EXT); #else ''; #end
		if(FileSystem.exists(fileName)) {
			foundFile = true;
		}
		if(!foundFile) {
			fileName = Paths.video(name);
			#if sys
			if(FileSystem.exists(fileName))
			#else
			if(OpenFlAssets.exists(fileName))
			#end
				foundFile = true;
		}

		if(foundFile) {
			inCutscene = true;
			var bg = new FlxSprite(-FlxG.width, -FlxG.height).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
			bg.scrollFactor.set();
			bg.cameras = [camHUD];
			add(bg);
			var video:MP4Handler = new MP4Handler();
			video.playVideo(fileName, false, false, curSong.toLowerCase());
			video.finishCallback = function()
			{
				if (ClientPrefs.showCutscene.contains(curSong.toLowerCase()) && isSound) {
					startCount = true;
					showSTCutscene = false;
					if (!ClientPrefs.cutsceneYouSaw.contains(curSong.toLowerCase())) {
						ClientPrefs.cutsceneYouSaw.push(curSong.toLowerCase());
						ClientPrefs.saveSettings();
					}
				}
				remove(bg);
				startAndEnd();
			}
			return;
		}
		else
		{
			FlxG.log.warn('Couldnt find video file: ' + fileName);
			startAndEnd();
		}
		#end
		startAndEnd();
	}

	function startAndEnd()
	{
		if(endingSong)
			endSong();
		else
			startCountdown();
	}

	var dialogueCount:Int = 0;
	public var psychDialogue:DialogueBoxPsych;
	//You don't have to add a song, just saying. You can just do "startDialogue(dialogueJson);" and it should work
	public function startDialogue(dialogueFile:DialogueFile, ?song:String = null):Void
	{
		// TO DO: Make this more flexible, maybe?
		if(psychDialogue != null) return;

		if(dialogueFile.dialogue.length > 0) {
			inCutscene = true;
			CoolUtil.precacheSound('dialogue');
			CoolUtil.precacheSound('dialogueClose');
			psychDialogue = new DialogueBoxPsych(dialogueFile, song);
			psychDialogue.scrollFactor.set();
			if(endingSong) {
				psychDialogue.finishThing = function() {
					psychDialogue = null;
					endSong();
				}
			} else {
				psychDialogue.finishThing = function() {
					psychDialogue = null;
					startCountdown();
				}
			}
			psychDialogue.nextDialogueThing = startNextDialogue;
			psychDialogue.skipDialogueThing = skipDialogue;
			psychDialogue.cameras = [camHUD];
			add(psychDialogue);
		} else {
			FlxG.log.warn('Your dialogue file is badly formatted!');
			if(endingSong) {
				endSong();
			} else {
				startCountdown();
			}
		}
	}

	function removeStatics()
	{
		playerStrums.forEach(function(todel:StrumNote)
		{
			playerStrums.remove(todel);
			todel.destroy();
		});
		opponentStrums.forEach(function(todel:StrumNote)
		{
			opponentStrums.remove(todel);
			todel.destroy();
		});
		strumLineNotes.forEach(function(todel:StrumNote)
		{
			strumLineNotes.remove(todel);
			todel.destroy();
		});
	}
	
	function strumSwappage(type:Float)
	{
		if (!xenoEncUI) {
			switch (type)
			{
				case 1:
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.x -= 645;
						});
						opponentStrums.forEach(function(spr:FlxSprite)
						{
							spr.x += 645;
						});
						bfIsLeft = true;
						iconP1.changeIcon(dad.healthIcon);
						iconP2.changeIcon(boyfriend.healthIcon);
						reloadHealthBarColors();
				case 2:
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.x += 645;
						});
						opponentStrums.forEach(function(spr:FlxSprite)
						{
							spr.x -= 645;
						});
						bfIsLeft = false;
						iconP2.changeIcon(dad.healthIcon);
						iconP1.changeIcon(boyfriend.healthIcon);
						reloadHealthBarColors();
			}
		} else {
			switch (type)
			{
				case 1:
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.x -= 645;
						});
						opponentStrums.forEach(function(spr:FlxSprite)
						{
							spr.x += 645;
						});
						bfIsLeft = true;
						iconP1.changeIcon(dad.healthIcon);
						iconP2.changeIcon(boyfriend.healthIcon);
						xenoEncIconP1.changeIcon(dad.healthIcon);
						xenoEncIconP2.changeIcon(boyfriend.healthIcon);
						reloadHealthBarColors();
				case 2:
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.x += 645;
						});
						opponentStrums.forEach(function(spr:FlxSprite)
						{
							spr.x -= 645;
						});
						bfIsLeft = false;
						iconP2.changeIcon(dad.healthIcon);
						iconP1.changeIcon(boyfriend.healthIcon);
						xenoEncIconP2.changeIcon(dad.healthIcon);
						xenoEncIconP1.changeIcon(boyfriend.healthIcon);
						reloadHealthBarColors();
			}
		}
	}

	var startScreenTweenName:String = '';
	var startScreenSplash:Bool = true;
	var fatalReady:FlxSprite;
	var fatalSet:FlxSprite;
	var fatalGo:FlxSprite;
	var LordXThree:FlxSprite;
	var LordXTwo:FlxSprite;
	var LordXOne:FlxSprite;
	var LordXFun:FlxSprite;
	var XenoThree:FlxSprite;
	var XenoTwo:FlxSprite;
	var XenoOne:FlxSprite;
	var XenoDie:FlxSprite;
	var readyTailsDoll:FlxSprite;
	var setTailsDoll:FlxSprite;
	var goTailsDoll:FlxSprite;
	function startScreenTween (style:String) {
		switch (style) {
			case 'classic':
				blackFuck.alpha = 1;
				new FlxTimer().start(0.6, function(tmr:FlxTimer) {
					FlxTween.tween(startCircle, {x: 0}, 0.5);
					FlxTween.tween(startText, {x: 0}, 0.5);
				});

				new FlxTimer().start(1.9, function(tmr:FlxTimer) {
					FlxTween.tween(blackFuck, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(blackFuck);
							blackFuck.destroy();
						}
					});
					FlxTween.tween(startCircle, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(startCircle);
							startCircle.destroy();
						}
					});
					FlxTween.tween(startText, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(startText);
							startText.destroy();
						}
					});
				});
			case 'classic-bg':
				blackFuck.alpha = 1;
				new FlxTimer().start(0.6, function(tmr:FlxTimer) {
					FlxTween.tween(startBG, {alpha: 1}, 1);
					FlxTween.tween(startCircle, {x: 0}, 0.5);
					FlxTween.tween(startText, {x: 0}, 0.5);
				});

				new FlxTimer().start(1.9, function(tmr:FlxTimer) {
					FlxTween.tween(blackFuck, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(blackFuck);
							blackFuck.destroy();
						}
					});
					FlxTween.tween(startBG, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(startBG);
							startBG.destroy();
						}
					});
					FlxTween.tween(startCircle, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(startCircle);
							startCircle.destroy();
						}
					});
					FlxTween.tween(startText, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(startText);
							startText.destroy();
						}
					});
				});
			case 'sunky':
				blackFuck.alpha = 1;
				new FlxTimer().start(0.6, function(tmr:FlxTimer) {
					FlxTween.tween(startCircle.scale, {x: 1}, 0.2, {ease: FlxEase.elasticOut});
					FlxG.sound.play(Paths.sound('flatBONK', 'exe'));
				});
				new FlxTimer().start(1.9, function(tmr:FlxTimer) {
					FlxTween.tween(blackFuck, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(blackFuck);
							blackFuck.destroy();
						}
					});
					FlxTween.tween(startCircle, {alpha: 0}, 1, {
						onComplete: function(twn:FlxTween) {
							remove(startCircle);
							startCircle.destroy();
						}
					});
				});
			case 'tails-doll':
				var amongus:Int = 0;
				new FlxTimer().start(1, function(tmr:FlxTimer) {
					switch (amongus) {
						case 0:
							add(readyTailsDoll);
							FlxTween.tween(readyTailsDoll.scale, {x: .9, y: .9}, Conductor.crochet / 500);
							FlxG.sound.play(Paths.sound('ready', 'exe'));
						case 1:
							readyTailsDoll.visible = false;
							add(setTailsDoll);
							FlxTween.tween(setTailsDoll.scale, {x: .9, y: .9}, Conductor.crochet / 500);
							FlxG.sound.play(Paths.sound('set', 'exe'));
						case 2:
							setTailsDoll.visible = false;
							add(goTailsDoll);
							FlxTween.tween(goTailsDoll.scale, {x: 1.1, y: 1.1}, Conductor.crochet / 500);
							FlxG.sound.play(Paths.sound('go', 'exe'));
						case 3:
							goTailsDoll.visible = false;
							canPause = true;
					}
					amongus += 1;
					if (amongus < 5)
						tmr.reset(Conductor.crochet / 700);
				});
			case 'fatal':
				blackFuck.alpha = 1;
				var swagCounter:Int = 0;
				startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer) {
					switch (swagCounter) {
						case 0:
							FlxG.sound.play(Paths.sound('Fatal_3', 'exe'));
						case 1:
							FlxG.sound.play(Paths.sound('Fatal_2', 'exe'));
							fatalReady.alpha = 1;
							FlxTween.tween(fatalReady, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(fatalReady);
									fatalReady.destroy();
								}
							});
						case 2:
							FlxG.sound.play(Paths.sound('Fatal_1', 'exe'));
							fatalSet.alpha = 1;
							FlxTween.tween(fatalSet, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(fatalSet);
									fatalSet.destroy();
								}
							});
						case 3:
							FlxG.sound.play(Paths.sound('Fatal_go', 'exe'));
							fatalGo.alpha = 1;
							FlxTween.tween(fatalGo, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(fatalGo);
									fatalGo.destroy();
								}
							});
						case 4:
							if (startScreenSplash) {
								FlxTween.tween(startCircle, {x: 0}, 0.5);
								FlxTween.tween(startText, {x: 0}, 0.5);
								FlxTween.tween(startCircle, {alpha: 1}, 0.5);
								FlxTween.tween(startText, {alpha: 1}, 0.5);
								
								new FlxTimer().start(1.2, function(tmr:FlxTimer) {
									FlxTween.tween(blackFuck, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(blackFuck);
											blackFuck.destroy();
										}
									});
									FlxTween.tween(startCircle, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(startCircle);
											startCircle.destroy();
										}
									});
									FlxTween.tween(startText, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(startText);
											startText.destroy();
										}
									});
								});
							} else {
								FlxTween.tween(blackFuck, {alpha: 0}, 1, {
									onComplete: function(twn:FlxTween) {
										remove(blackFuck);
										blackFuck.destroy();
									}
								});
							}
						}
					if (swagCounter != 4)
						tmr.reset();
					swagCounter += 1;
				});
			case 'lord-x':
				blackFuck.alpha = 1;
				var swagCounter:Int = 0;
				startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer) {
					switch (swagCounter) {
						case 0:
							FlxG.sound.play(Paths.sound('x-count/three', 'exe'), 0.7);
							LordXThree.alpha = 1;
							FlxTween.tween(LordXThree, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(LordXThree);
									LordXThree.destroy();
								}
							});
						case 1:
							FlxG.sound.play(Paths.sound('x-count/two', 'exe'), 0.7);
							LordXTwo.alpha = 1;
							FlxTween.tween(LordXTwo, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(LordXTwo);
									LordXTwo.destroy();
								}
							});
						case 2:
							FlxG.sound.play(Paths.sound('x-count/one', 'exe'), 0.7);
							LordXOne.alpha = 1;
							FlxTween.tween(LordXOne, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(LordXOne);
									LordXOne.destroy();
								}
							});
						case 3:
							FlxG.sound.play(Paths.sound('x-count/fun', 'exe'), 0.7);
							LordXFun.alpha = 1;
							FlxTween.tween(LordXFun, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(LordXFun);
									LordXFun.destroy();
								}
							});
						case 4:
							if (startScreenSplash) {
								FlxTween.tween(startCircle, {x: 0}, 0.5);
								FlxTween.tween(startText, {x: 0}, 0.5);
								FlxTween.tween(startCircle, {alpha: 1}, 0.5);
								FlxTween.tween(startText, {alpha: 1}, 0.5);
								
								new FlxTimer().start(1.2, function(tmr:FlxTimer) {
									FlxTween.tween(blackFuck, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(blackFuck);
											blackFuck.destroy();
										}
									});
									FlxTween.tween(startCircle, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(startCircle);
											startCircle.destroy();
										}
									});
									FlxTween.tween(startText, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(startText);
											startText.destroy();
										}
									});
								});
							} else {
								FlxTween.tween(blackFuck, {alpha: 0}, 1, {
									onComplete: function(twn:FlxTween) {
										remove(blackFuck);
										blackFuck.destroy();
									}
								});
							}
						}
					if (swagCounter != 4)
						tmr.reset();
					swagCounter += 1;
				});
			case 'xeno':
				blackFuck.alpha = 1;
				var swagCounter:Int = 0;
				startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer) {
					switch (swagCounter) {
						case 0:
							FlxG.sound.play(Paths.sound('xeno-count/three', 'exe'), 0.45);
							XenoThree.alpha = 1;
							FlxTween.tween(XenoThree, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(XenoThree);
									XenoThree.destroy();
								}
							});
						case 1:
							FlxG.sound.play(Paths.sound('xeno-count/two', 'exe'), 0.45);
							XenoTwo.alpha = 1;
							FlxTween.tween(XenoTwo, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(XenoTwo);
									XenoTwo.destroy();
								}
							});
						case 2:
							FlxG.sound.play(Paths.sound('xeno-count/one', 'exe'), 0.45);
							XenoOne.alpha = 1;
							FlxTween.tween(XenoOne, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(XenoOne);
									XenoOne.destroy();
								}
							});
						case 3:
							FlxG.sound.play(Paths.sound('xeno-count/die', 'exe'), 0.45);
							XenoDie.alpha = 1;
							FlxTween.tween(XenoDie, {alpha: 0}, Conductor.crochet / 1000, {
								ease: FlxEase.cubeInOut,
								onComplete: function(twn:FlxTween) {
									remove(XenoDie);
									XenoDie.destroy();
								}
							});
						case 4:
							if (startScreenSplash) {
								FlxTween.tween(startCircle, {x: 0}, 0.5);
								FlxTween.tween(startText, {x: 0}, 0.5);
								FlxTween.tween(startCircle, {alpha: 1}, 0.5);
								FlxTween.tween(startText, {alpha: 1}, 0.5);
								
								new FlxTimer().start(1.2, function(tmr:FlxTimer) {
									FlxTween.tween(blackFuck, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(blackFuck);
											blackFuck.destroy();
										}
									});
									FlxTween.tween(startCircle, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(startCircle);
											startCircle.destroy();
										}
									});
									FlxTween.tween(startText, {alpha: 0}, 1, {
										onComplete: function(twn:FlxTween) {
											remove(startText);
											startText.destroy();
										}
									});
								});
							} else {
								FlxTween.tween(blackFuck, {alpha: 0}, 1, {
									onComplete: function(twn:FlxTween) {
										remove(blackFuck);
										blackFuck.destroy();
									}
								});
							}
						}
					if (swagCounter != 4)
						tmr.reset();
					swagCounter += 1;
				});
		}
	}

	var startTimer:FlxTimer;
	var finishTimer:FlxTimer = null;

	// For being able to mess with the sprites on Lua
	public var countdownReady:FlxSprite;
	public var countdownSet:FlxSprite;
	public var countdownGo:FlxSprite;
	public static var startOnTime:Float = 0;

	public var countDownSprites:Array<FlxSprite> = [];
	var startCount:Bool = false;
	public static var showSTCutscene:Bool = true;
	public function startCountdown():Void
	{
		if (!startCount) {
			if (ClientPrefs.songsHaveCutsceneCheckbox.contains(curSong.toLowerCase()) && isSound && showSTCutscene) {
				switch(curSong.toLowerCase()) {
					case 'ugly': startVideo('ugly-intro');
					case 'soulless': startVideo('soulless-intro');
					case 'critical-error': startVideo('critical-error-intro');
					case 'fight-or-flight': startVideo('fof-intro');
				}
			} else {
				startCount = true;
			}
		}
		
		if (startCount) {
			startScreenTween(startScreenTweenName);
			#if mobile
			mobileControls.visible = true;
			if (ClientPrefs.isvpad && SONG.isRing && ClientPrefs.space == 'button' && MobileControls.mode != 'Keyboard')
			{
				virtualPad.visible = true;
			}
			#end

			ezTrail = new FlxTrail(dad, null, 2, 5, 0.3, 0.04);
			
			if(startedCountdown) {
				callOnLuas('onStartCountdown', []);
				return;
			}

			inCutscene = false;
			var ret:Dynamic = callOnLuas('onStartCountdown', [], false);
			if(ret != FunkinLua.Function_Stop) {
				if (skipCountdown || startOnTime > 0) skipArrowStartTween = true;

				generateStaticArrows(0);
				generateStaticArrows(1);
				for (i in 0...playerStrums.length) {
					setOnLuas('defaultPlayerStrumX' + i, playerStrums.members[i].x);
					setOnLuas('defaultPlayerStrumY' + i, playerStrums.members[i].y);
				}
				for (i in 0...opponentStrums.length) {
					setOnLuas('defaultOpponentStrumX' + i, opponentStrums.members[i].x);
					setOnLuas('defaultOpponentStrumY' + i, opponentStrums.members[i].y);
					//if(ClientPrefs.middleScroll) opponentStrums.members[i].visible = false; 
				}

				if(sonicHUDSongs.contains(SONG.song.toLowerCase()) || fatalUI) {
					if (!(curSong.toLowerCase() == 'you-cant-run' || curSong.toLowerCase() == 'you-cant-run-encore' || curSong.toLowerCase() == 'final-escape' || curSong.toLowerCase() == 'our-horizon')) {
						healthBar.x += 150;
						iconP1.x += 150;
						iconP2.x += 150;
						healthBarBG.x += 150;
					}
				}

				if (curSong == 'black-sun' || curSong == 'godspeed')
				{
					if (!ClientPrefs.middleScroll)
						{
							opponentStrums.forEach(function(spr:StrumNote)
							{
								spr.x += 5000;
							});
						}
				}

				if(curStage == 'requite')
				{
					if (!ClientPrefs.middleScroll)
						{
							playerStrums.forEach(function(spr:FlxSprite)
							{
								spr.x -= 645;
							});
							opponentStrums.forEach(function(spr:FlxSprite)
							{
								spr.x += 645;
							});
						}
						bfIsLeft = true;
						iconP1.changeIcon(dad.healthIcon);
						iconP2.changeIcon(boyfriend.healthIcon);
						reloadHealthBarColors();
				}

				if (VHSui) {
					if (!ClientPrefs.middleScroll) {
						opponentStrums.forEach(function(spr:StrumNote)
						{
							spr.x += 5000;
						});
					}
				}

				if (curStage == 'starved' || curStage == 'schoolhouse')
				{
					if (!ClientPrefs.middleScroll) {
						playerStrums.forEach(function(spr:StrumNote)
						{
							spr.x -= 322;
							spr.y -= 35;
						});
							
						opponentStrums.forEach(function(spr:StrumNote)
						{
							spr.x += 5000;
						});
					}
					healthBar.angle += 90;
					healthBar.screenCenter();
					healthBar.x += 500;
					
					iconP1.x += 1050;
					iconP2.x += 1050;
					
					healthBarBG.angle += 90;
					healthBarBG.x += 500;

					timeBar.y = scoreTxt.y - 40;
					timeBarBG.y = scoreTxt.y - 40;
					if (bgTBSkin == 'tbR') timeBarBGBG.y = scoreTxt.y - 40;
					timeTxt.y = scoreTxt.y - 52;

					healthBar.alpha = 1;
					healthBarBG.alpha = 1;
					scoreTxt.alpha = 0.75;
				}
				
				if (FEHPThing == 1)
				{
					healthBar.angle += 90;
					healthBar.screenCenter();
					healthBar.x += 500;
					
					healthBarBG.angle += 90;
					healthBarBG.screenCenter();
					healthBarBG.x += 500;
					
					iconP1.x += 1055;
					iconP2.x += 1055;

					healthBar.alpha = 1;
					healthBarBG.alpha = 1;
					scoreTxt.alpha = 0.75;
				}

				startedCountdown = true;
				Conductor.songPosition = 0;
				Conductor.songPosition -= Conductor.crochet * 5;
				setOnLuas('startedCountdown', true);
				callOnLuas('onCountdownStarted', []);

				var swagCounter:Int = 0;

				if (skipCountdown || startOnTime > 0) {
					clearNotesBefore(startOnTime);
					setSongTime(startOnTime - 500);
					return;
				}

				startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
				{
					if (gf != null && tmr.loopsLeft % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && !gf.stunned && gf.animation.curAnim.name != null && !gf.animation.curAnim.name.startsWith("sing") && !gf.stunned)
					{
						gf.dance();
					}
					if (tmr.loopsLeft % boyfriend.danceEveryNumBeats == 0 && boyfriend.animation.curAnim != null && !boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.stunned)
					{
						boyfriend.dance();
					}
					if (tmr.loopsLeft % dad.danceEveryNumBeats == 0 && dad.animation.curAnim != null && !dad.animation.curAnim.name.startsWith('sing') && !dad.stunned)
					{
						dad.dance();
					}

					var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
					introAssets.set('default', [
					('ready'),
					('set'),
					('go')
					]);
					introAssets.set('pixel', [
					('pixelUI/ready-pixel'),
					('pixelUI/set-pixel'),
					('pixelUI/date-pixel')
					]);

					var introAlts:Array<String> = introAssets.get('default');
					var antialias:Bool = ClientPrefs.globalAntialiasing;
					if(isPixelStage) {
						introAlts = introAssets.get('pixel');
						antialias = false;
					}
					
					if (showCountdown) {
						switch (swagCounter)
						{
							case 0:
								FlxG.sound.play(Paths.sound('intro3' + introSoundsSuffix), 0.6);
							case 1:
								countdownReady = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
								countdownReady.scrollFactor.set();
								countdownReady.updateHitbox();

								if (PlayState.isPixelStage)
									countdownReady.setGraphicSize(Std.int(countdownReady.width * daPixelZoom));

								countdownReady.screenCenter();
								countdownReady.antialiasing = antialias;
								add(countdownReady);
								FlxTween.tween(countdownReady, {/*y: countdownReady.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
									ease: FlxEase.cubeInOut,
									onComplete: function(twn:FlxTween)
									{
										remove(countdownReady);
										countdownReady.destroy();
									}
								});
								FlxG.sound.play(Paths.sound('intro2' + introSoundsSuffix), 0.6);
							case 2:
								countdownSet = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
								countdownSet.scrollFactor.set();

								if (PlayState.isPixelStage)
									countdownSet.setGraphicSize(Std.int(countdownSet.width * daPixelZoom));

								countdownSet.screenCenter();
								countdownSet.antialiasing = antialias;
								add(countdownSet);
								FlxTween.tween(countdownSet, {/*y: countdownSet.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
									ease: FlxEase.cubeInOut,
									onComplete: function(twn:FlxTween)
									{
										remove(countdownSet);
										countdownSet.destroy();
									}
								});
								FlxG.sound.play(Paths.sound('intro1' + introSoundsSuffix), 0.6);
							case 3:
								countdownGo = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
								countdownGo.scrollFactor.set();

								if (PlayState.isPixelStage)
									countdownGo.setGraphicSize(Std.int(countdownGo.width * daPixelZoom));

								countdownGo.updateHitbox();

								countdownGo.screenCenter();
								countdownGo.antialiasing = antialias;
								add(countdownGo);
								FlxTween.tween(countdownGo, {/*y: countdownGo.y + 100,*/ alpha: 0}, Conductor.crochet / 1000, {
									ease: FlxEase.cubeInOut,
									onComplete: function(twn:FlxTween)
									{
										remove(countdownGo);
										countdownGo.destroy();
									}
								});
								FlxG.sound.play(Paths.sound('introGo' + introSoundsSuffix), 0.6);
							case 4:
						}
					}

					notes.forEachAlive(function(note:Note) {
						note.copyAlpha = false;
						note.alpha = note.multAlpha;
						if(ClientPrefs.middleScroll && !note.mustPress) {
							note.alpha *= 0.5;
						}
					});
					callOnLuas('onCountdownTick', [swagCounter]);

					swagCounter += 1;
					// generateSong('fresh');
				}, 5);
			}
			
			if (SONG.song.toLowerCase() == 'sunshine-encore')
				SunshinePopup();
				{
					switch (curStep)
					{
						case 1:
					}
				}
				
			#if desktop
			var rpcF:String = ' (Charting Mode)';
			if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
				rpcF = TranslationLanguages.Text[rpcF];
			if (SONG.song.toLowerCase() == 'too-slow' || SONG.song.toLowerCase() == 'you-cant-run' || SONG.song.toLowerCase() == 'cycles') {} else {
				if (!chartingMode)
					DiscordClient.changePresence(detailsText, SongLang + SONG.song, null, true, songLength);
				else
					DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF, null, true, songLength);
			}
			#end
		}
	}

	public function addBehindGF(obj:FlxObject)
	{
		insert(members.indexOf(gfGroup), obj);
	}
	public function addBehindBF(obj:FlxObject)
	{
		insert(members.indexOf(boyfriendGroup), obj);
	}
	public function addBehindDad (obj:FlxObject)
	{
		insert(members.indexOf(dadGroup), obj);
	}

	public function clearNotesBefore(time:Float)
	{
		var i:Int = unspawnNotes.length - 1;
		while (i >= 0) {
			var daNote:Note = unspawnNotes[i];
			if(daNote.strumTime - 500 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.ignoreNote = true;

				daNote.kill();
				unspawnNotes.remove(daNote);
				daNote.destroy();
			}
			--i;
		}

		i = notes.length - 1;
		while (i >= 0) {
			var daNote:Note = notes.members[i];
			if(daNote.strumTime - 500 < time)
			{
				daNote.active = false;
				daNote.visible = false;
				daNote.ignoreNote = true;

				daNote.kill();
				notes.remove(daNote, true);
				daNote.destroy();
			}
			--i;
		}
	}

	public function setSongTime(time:Float)
	{
		if(time < 0) time = 0;

		FlxG.sound.music.pause();
		vocals.pause();

		FlxG.sound.music.time = time;
		FlxG.sound.music.play();

		vocals.time = time;
		vocals.play();
		Conductor.songPosition = time;
	}

	function startNextDialogue() {
		dialogueCount++;
		callOnLuas('onNextDialogue', [dialogueCount]);
	}

	function skipDialogue() {
		callOnLuas('onSkipDialogue', [dialogueCount]);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		creditsText = new FlxTypedGroup<FlxText>();
		if(!paused) {
			switch(SONG.song.toLowerCase())
			{	
				default:
					box = new FlxSprite(0, -1000).loadGraphic(Paths.image("box"));
					box.cameras = [camOther];
					box.setGraphicSize(Std.int(box.height * 0.8));
					box.screenCenter(X);
					add(box);

					var texti:String;
					var size:String;

					#if desktop
					if (FileSystem.exists(Paths.json(curSong.toLowerCase() + "/credits"))) {
						texti = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("TIME")[0];
						size = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("SIZE")[1];
					} else {
						texti = File.getContent((Paths.json("unfinished-credits"))).split("TIME")[0];
						size = File.getContent((Paths.json("unfinished-credits"))).split("SIZE")[1];
					}
					#else
					if (OpenFlAssets.exists(Paths.json(curSong.toLowerCase() + "/credits"))) {
						texti = OpenFlAssets.getText((Paths.json(curSong.toLowerCase() + "/credits"))).split("TIME")[0];
						size = OpenFlAssets.getText((Paths.json(curSong.toLowerCase() + "/credits"))).split("SIZE")[1];
					} else {
						texti = OpenFlAssets.getText((Paths.json("unfinished-credits"))).split("TIME")[0];
						size = OpenFlAssets.getText((Paths.json("unfinished-credits"))).split("SIZE")[1];
					}
					#end
					
					switch (ClientPrefs.Language) {
						case 'Russian':
							texti = texti.replace('CREDITS', 'АВТОРЫ');
							texti = texti.replace('CODE', 'КОД');
							texti = texti.replace('ARTWORK', 'ХУД.РАБОТЫ');
							texti = texti.replace('MUSIC', 'МУЗЫКА');
							texti = texti.replace('CHARTING', 'ЧАРТ');
						case 'Spanish':
							texti = texti.replace('CREDITS', 'CREDITOS');
							texti = texti.replace('CODE', 'CODIGO');
							texti = texti.replace('ARTWORK', 'ARTE');
							texti = texti.replace('MUSIC', 'MUSICA');
							texti = texti.replace('CHARTING', 'CHARTING');
					}
					
					creditoText = new FlxText(0, -1000, 0, texti, 28);
					creditoText.cameras = [camOther];
					creditoText.setFormat(Paths.font("PressStart2P.ttf"), Std.parseInt(size), FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
					creditoText.setGraphicSize(Std.int(creditoText.width * 0.8));
					creditoText.updateHitbox();
					creditoText.screenCenter(X);
					creditsText.add(creditoText);
			}
			add(creditsText);

			switch (SONG.song.toLowerCase())
			{
				default:
					var timei:String;

					#if desktop
					if (FileSystem.exists(Paths.json(curSong.toLowerCase() + "/credits"))) {
						timei = File.getContent((Paths.json(curSong.toLowerCase() + "/credits"))).split("TIME")[1];
					} else {
						timei = "2.35";
					}
					#else
					if (OpenFlAssets.exists(Paths.json(curSong.toLowerCase() + "/credits"))) {
						timei = OpenFlAssets.getText((Paths.json(curSong.toLowerCase() + "/credits"))).split("TIME")[1];
					} else {
						timei = "2.35";
					}
					#end

					new FlxTimer().start(Std.parseFloat(timei), function(tmr:FlxTimer) {
						tweencredits();
					});
			}
		}
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		FlxG.sound.music.onComplete = onSongComplete;
		vocals.play();

		if(startOnTime > 0)
		{
			setSongTime(startOnTime - 500);
		}

		if(paused) {
			//trace('Oopsie doopsie! Paused sound');
			FlxG.sound.music.pause();
			vocals.pause();
		}

		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;
		FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		if (!xenoEncUI) {
			FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
			FlxTween.tween(timeBarBG, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
			if (bgTBSkin == 'tbR') FlxTween.tween(timeBarBGBG, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		}
		
		#if desktop
		var rpcF:String = ' (Charting Mode)';
		if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
			rpcF = TranslationLanguages.Text[rpcF];
		if (!chartingMode)
			DiscordClient.changePresence(detailsText, SongLang + SONG.song, null, true, songLength);
		else
			DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF, null, true, songLength);
		#end
		setOnLuas('songLength', songLength);
		callOnLuas('onSongStart', []);
	}

	var debugNum:Int = 0;
	private var noteTypeMap:Map<String, Bool> = new Map<String, Bool>();
	private var eventPushedMap:Map<String, Bool> = new Map<String, Bool>();
	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());
		songSpeedType = ClientPrefs.getGameplaySetting('scrolltype','multiplicative');

		switch(songSpeedType)
		{
			case "multiplicative":
				songSpeed = SONG.speed * ClientPrefs.getGameplaySetting('scrollspeed', 1);
			case "constant":
				songSpeed = ClientPrefs.getGameplaySetting('scrollspeed', 1);
		}
		
		var songData = SONG;
		Conductor.changeBPM(songData.bpm);
		
		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);
		FlxG.sound.list.add(new FlxSound().loadEmbedded(Paths.inst(PlayState.SONG.song)));

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped

		var songName:String = Paths.formatToSongPath(SONG.song);
		var file:String = Paths.json(songName + '/events');
		#if desktop
		if (FileSystem.exists(Paths.modsJson(songName + '/events')) || FileSystem.exists(file)) {
		#else
		if (OpenFlAssets.exists(file)) {
		#end
			var eventsData:Array<Dynamic> = Song.loadFromJson('events', songName).events;
			for (event in eventsData) //Event Notes
			{
				for (i in 0...event[1].length)
				{
					var newEventNote:Array<Dynamic> = [event[0], event[1][i][0], event[1][i][1], event[1][i][2]];
					var subEvent:EventNote = {
						strumTime: newEventNote[0] + ClientPrefs.noteOffset,
						event: newEventNote[1],
						value1: newEventNote[2],
						value2: newEventNote[3]
					};
					subEvent.strumTime -= eventNoteEarlyTrigger(subEvent);
					eventNotes.push(subEvent);
					eventPushed(subEvent);
				}
			}
		}

		for (section in noteData)
		{
			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				
				var lol = 4;
				var lol2 = 3;
				if (SONG.isRing)
					lol = 5;
				if (SONG.isRing)
					lol2 = 4;
					
				var daNoteData:Int = Std.int(songNotes[1] % lol);
				var gottaHitNote:Bool = section.mustHitSection;
			
				if (songNotes[1] > lol2)
					gottaHitNote = !section.mustHitSection;

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note;
				if (gottaHitNote)
					swagNote = new Note(daStrumTime, daNoteData, oldNote,false,false,boyfriend.BFnoteSkin);
				else
					swagNote = new Note(daStrumTime, daNoteData, oldNote,false,false,dad.DADnoteSkin);
				swagNote.row = Conductor.secsToRow(daStrumTime);
				if(noteRows[gottaHitNote?0:1][swagNote.row]==null)
					noteRows[gottaHitNote?0:1][swagNote.row]=[];
				noteRows[gottaHitNote ? 0 : 1][swagNote.row].push(swagNote);
				swagNote.mustPress = gottaHitNote;
				swagNote.sustainLength = songNotes[2];
				swagNote.gfNote = (section.gfSection && (songNotes[1]<4));
				swagNote.noteType = songNotes[3];
				if(!Std.isOfType(songNotes[3], String))
					swagNote.noteType = editors.ChartingState.noteTypeList[songNotes[3]]; //Backward compatibility + compatibility with Week 7 charts
				swagNote.scrollFactor.set();

				var susLength:Float = swagNote.sustainLength;
				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				var floorSus:Int = Math.floor(susLength);
				if(floorSus > 0) {
					for (susNote in 0...floorSus+1)
					{
						oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

						var sustainNote:Note;
						if (gottaHitNote) {
							sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(SONG.speed, 2)), daNoteData, oldNote, true, false, boyfriend.BFnoteSkin);
						} else {
							sustainNote = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + (Conductor.stepCrochet / FlxMath.roundDecimal(SONG.speed, 2)), daNoteData, oldNote, true, false, dad.DADnoteSkin);
						}
						sustainNote.mustPress = gottaHitNote;
						sustainNote.gfNote = (section.gfSection && (songNotes[1]<4));
						sustainNote.noteType = swagNote.noteType;
						sustainNote.scrollFactor.set();
						unspawnNotes.push(sustainNote);

						if (sustainNote.mustPress)
						{
							sustainNote.x += FlxG.width / 2; // general offset
						}
						else if(ClientPrefs.middleScroll)
						{
							sustainNote.x += 310;
							if(daNoteData > 1) //Up and Right
							{
								sustainNote.x += FlxG.width / 2 + 25;
							}
						}
					}
				}

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else if(ClientPrefs.middleScroll)
				{
					swagNote.x += 310;
					if(daNoteData > 1) //Up and Right
					{
						swagNote.x += FlxG.width / 2 + 25;
					}
				}

				if(!noteTypeMap.exists(swagNote.noteType)) {
					noteTypeMap.set(swagNote.noteType, true);
				}
			}
			daBeats += 1;
		}
		for (event in songData.events) //Event Notes
		{
			for (i in 0...event[1].length)
			{
				var newEventNote:Array<Dynamic> = [event[0], event[1][i][0], event[1][i][1], event[1][i][2]];
				var subEvent:EventNote = {
					strumTime: newEventNote[0] + ClientPrefs.noteOffset,
					event: newEventNote[1],
					value1: newEventNote[2],
					value2: newEventNote[3]
				};
				subEvent.strumTime -= eventNoteEarlyTrigger(subEvent);
				eventNotes.push(subEvent);
				eventPushed(subEvent);
			}
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);
		if(eventNotes.length > 1) { //No need to sort if there's a single one or none at all
			eventNotes.sort(sortByTime);
		}
		checkEventNote();
		generatedMusic = true;
	}

	function eventPushed(event:EventNote) {
		switch(event.event) {
			case 'Change Character':
				var charType:Int = 0;
				switch(event.value1.toLowerCase()) {
					case 'gf' | 'girlfriend' | '1':
						charType = 2;
					case 'dad' | 'opponent' | '0':
						charType = 1;
					default:
						charType = Std.parseInt(event.value1);
						if(Math.isNaN(charType)) charType = 0;
				}

				var newCharacter:String = event.value2;
				addCharacterToList(newCharacter, charType);
		}

		if(!eventPushedMap.exists(event.event)) {
			eventPushedMap.set(event.event, true);
		}
	}

	function eventNoteEarlyTrigger(event:EventNote):Float {
		var returnedValue:Float = callOnLuas('eventEarlyTrigger', [event.event]);
		if(returnedValue != 0) {
			return returnedValue;
		}

		switch(event.event) {
			case 'Kill Henchmen': //Better timing so that the kill sound matches the beat intended
				return 280; //Plays 280ms before the actual position
		}
		return 0;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	function sortByTime(Obj1:EventNote, Obj2:EventNote):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	public var skipArrowStartTween:Bool = false; //for lua
	private function generateStaticArrows(player:Int):Void
	{
		var keyCount:Int = 4;
		if (SONG.isRing)
			keyCount = 5;
			
		for (i in 0...keyCount)
		{
			var targetAlpha:Float = 1;
			var babyArrow:StrumNote;
			
			if (player < 1 && ClientPrefs.middleScroll) targetAlpha = 0.35;

			if (fatalUI && player == 1) {
				babyArrow = new StrumNote(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, strumLine.y, i, player,'week6');
			} else {
				if (SONG.player2 == "sunky" && player == 0) {
					babyArrow = new StrumNote(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, strumLine.y, i, player,'sunky');
				} else {
					if (fatalUI && player == 0) {
						babyArrow = new StrumNote(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, strumLine.y, i, player,'fatal');
					} else {
						babyArrow = new StrumNote(ClientPrefs.middleScroll ? STRUM_X_MIDDLESCROLL : STRUM_X, strumLine.y, i, player,'normal');
					}
				}
			}

			if (!offDownScroll)
				babyArrow.downScroll = ClientPrefs.downScroll;
			else
				babyArrow.downScroll = false;
				
			if (!isStoryMode && !skipArrowStartTween) {
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {alpha: targetAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			} else {
				babyArrow.alpha = targetAlpha;
			}

			if (player == 1) {
				if (keyCount == 5) {
					if (i == 0) { babyArrow.x -= 50; }
					if (i == 1) { babyArrow.x -= 50; }
					if (i == 2) { babyArrow.x -= 50; }
					if (i == 3) { babyArrow.x -= 50; }
					if (i == 4) { babyArrow.x -= 50; }
				}
				playerStrums.add(babyArrow);
			} else {
				if(ClientPrefs.middleScroll) {
					babyArrow.x += 310;
					if(i > 1) //Up and Right
						babyArrow.x += FlxG.width / 2 + 25;
				}
				if (keyCount == 5) {
					if (i == 0) { babyArrow.x += 0; }
					if (i == 1) { babyArrow.x += 0; }
					if (i == 2) { babyArrow.visible = false; }
					if (i == 3) { babyArrow.x -= 110; }
					if (i == 4) { babyArrow.x -= 110; }
				}
				opponentStrums.add(babyArrow);
			}

			strumLineNotes.add(babyArrow);
			babyArrow.postAddedToGroup();
		}
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{ 		
			var grey:Greyscale;
			grey = new Greyscale();

			if (ClientPrefs.Shaders && curShader != null && health > 0)
			{
				camGame.setFilters([curShader, new ShaderFilter(grey)]);
				if(curStage != 'my-horizon-wechidna')
					camHUD.setFilters([curShader, new ShaderFilter(grey)]);
				else
					camHUD.setFilters([new ShaderFilter(grey)]);
			}
			else if (ClientPrefs.Shaders && curShader == null && health > 0)
			{
				camGame.setFilters([new ShaderFilter(grey)]);
				camHUD.setFilters([new ShaderFilter(grey)]);
			}
			
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = false;
			if (finishTimer != null && !finishTimer.finished)
				finishTimer.active = false;
			if (songSpeedTween != null)
				songSpeedTween.active = false;

			if(blammedLightsBlackTween != null)
				blammedLightsBlackTween.active = false;
			if(phillyCityLightsEventTween != null)
				phillyCityLightsEventTween.active = false;

			if(carTimer != null) carTimer.active = false;

			var chars:Array<Character> = [boyfriend, gf, dad];
			for (char in chars) {
				if(char != null && char.colorTween != null) {
					char.colorTween.active = false;
				}
			}

			for (tween in modchartTweens) {
				tween.active = false;
			}
			for (tween in piss)
			{
				tween.active = false;
			}
			for (timer in modchartTimers) {
				timer.active = false;
			}
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{	
			if (ClientPrefs.Shaders) {
				if (curShader != null)
				{
					camGame.setFilters([curShader]);
					if(curStage != 'my-horizon-wechidna')
						camHUD.setFilters([curShader]);
					else
						camHUD.setFilters([]);
				} else {
					if (curShaderone != null) {
						camGame.setFilters([curShaderone]);
						camHUD.setFilters([curShaderone]);
					}
					
					if (curShadertwo != null) {
						camGame.setFilters([curShadertwo]);
						camHUD.setFilters([curShadertwo]);
					}
					
					if (curShader == null && curShaderone == null && curShadertwo == null) {
						camGame.setFilters([]);
						camHUD.setFilters([]);
					}
				}
			}
			
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (startTimer != null && !startTimer.finished)
				startTimer.active = true;
			if (finishTimer != null && !finishTimer.finished)
				finishTimer.active = true;
			if (songSpeedTween != null)
				songSpeedTween.active = true;

			if(blammedLightsBlackTween != null)
				blammedLightsBlackTween.active = true;
			if(phillyCityLightsEventTween != null)
				phillyCityLightsEventTween.active = true;
			
			if(carTimer != null) carTimer.active = true;

			var chars:Array<Character> = [boyfriend, gf, dad];
			for (char in chars) {
				if(char != null && char.colorTween != null) {
					char.colorTween.active = true;
				}
			}
			
			for (tween in modchartTweens) {
				tween.active = true;
			}
			for (tween in piss) {
				tween.active = false;
			}
			for (timer in modchartTimers) {
				timer.active = true;
			}
			paused = false;
			
			FlxTween.globalManager.forEach(function(tween:FlxTween)
			{
				tween.active = true;
			});
			FlxTimer.globalManager.forEach(function(timer:FlxTimer)
			{
				timer.active = true;
			});
			
			callOnLuas('onResume', []);

			#if desktop
			var rpcF:String = ' (Charting Mode)';
			if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
				rpcF = TranslationLanguages.Text[rpcF];
			if (startTimer != null && startTimer.finished)
			{
				if (!chartingMode)
					DiscordClient.changePresence(detailsText, SongLang + SONG.song, null, true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
				else
					DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF, null, true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
			}
			else
			{
				if (!chartingMode)
					DiscordClient.changePresence(detailsText, SongLang + SONG.song, null);
				else
					DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF, null);
			}
			#end
		}

		super.closeSubState();
	}

	override public function onFocus():Void
	{
		#if desktop
		var rpcF:String = ' (Charting Mode)';
		if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
			rpcF = TranslationLanguages.Text[rpcF];
		if (health > 0 && !paused)
		{
			if (Conductor.songPosition > 0.0)
			{
				if (!chartingMode)
					DiscordClient.changePresence(detailsText, SongLang + SONG.song, null, true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
				else
					DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF, null, true, songLength - Conductor.songPosition - ClientPrefs.noteOffset);
			}
			else
			{
				if (!chartingMode)
					DiscordClient.changePresence(detailsText, SongLang + SONG.song, null);
				else
					DiscordClient.changePresence(detailsText, SongLang + SONG.song + rpcF, null);
			}
		}
		#end

		super.onFocus();
	}
	
	override public function onFocusLost():Void
	{
		#if desktop
		if (health > 0 && !paused) {
			var rpcF:String = ' (Charting Mode)';
			if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
				rpcF = TranslationLanguages.Text[rpcF];
			if (!chartingMode)
				DiscordClient.changePresence(detailsPausedText, SongLang + SONG.song, null);
			else
				DiscordClient.changePresence(detailsPausedText, SongLang + SONG.song + rpcF, null);
		}
		#end

		super.onFocusLost();
	}

	function windowGoBack()
	{
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			var xLerp:Float = FlxMath.lerp(windowX, Lib.application.window.x, 0.95);
			var yLerp:Float = FlxMath.lerp(windowY, Lib.application.window.y, 0.95);
			Lib.application.window.move(Std.int(xLerp), Std.int(yLerp));
		}, 20);
	}

	function resyncVocals():Void
	{
		if(finishTimer != null) return;

		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();
	}

	function updateCamFollow(?elapsed:Float){
		if(elapsed==null)elapsed=FlxG.elapsed;
		if (!PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
		{
			var char = dad;

			var getCenterX = char.getMidpoint().x + 150;
			var getCenterY = char.getMidpoint().y - 100;

			camFollow.set(getCenterX + camDisplaceX + char.cameraPosition[0], getCenterY + camDisplaceY + char.cameraPosition[1]);

			switch (char.curCharacter)
			{
				case "scorched":
					FlxG.camera.zoom = FlxMath.lerp(0.5, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
					camFollow.x += 20;
					camFollow.y += 70;
				case "starved":
					FlxG.camera.zoom = FlxMath.lerp(1.35, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
					camFollow.x += 20;
					camFollow.y -= 70;
				case "beast_chaotix":
					FlxG.camera.zoom = FlxMath.lerp(1.2, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
					camFollow.x -= 30;
					camFollow.y -= 50;
				case "fatal-sonic", "fatal-glitched":
					camFollow.y -= 50;
					FlxG.camera.zoom = FlxMath.lerp(0.4, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
				default:
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
			}

		}
		else
		{
			var char = boyfriend;

			var getCenterX = char.getMidpoint().x - 100;
			var getCenterY = char.getMidpoint().y - 100;

			camFollow.set(getCenterX + camDisplaceX - char.cameraPosition[0], getCenterY + camDisplaceY + char.cameraPosition[1]);

			switch (char.curCharacter)
			{
				default:
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
			}
		}
	}

	var starvedSpeed:Float = 15;

	public var paused:Bool = false;
	public var camDisplaceX:Float = 0;
	public var camDisplaceY:Float = 0;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;
	var limoSpeed:Float = 0;
	var newIcon:String;
	var targetHP:Float;
	var twn:FlxTween;
	var camElapsed:Float = 0;
	var RGBval:Int = 0;

	override public function update(elapsed:Float)
	{
		if (curStage == 'fatal-encore') {
			FatalEncorePCTime.text = Std.string(DateTools.format(Date.now(), "%T"));
			FatalEncorePCDay.text = Std.string(DateTools.format(Date.now(), "%F")).split("-")[2] + '.' + Std.string(DateTools.format(Date.now(), "%F")).split("-")[1] + '.' + Std.string(DateTools.format(Date.now(), "%F")).split("-")[0];
		}
		if (canDodge && controls.NOTE_RING && curStage == 'chamber' || canDodge && controls.NOTE_RING && curStage == 'chamber-encore')
		{
			dodging = true;
			boyfriend.playAnim('dodge', true);
			boyfriend.specialAnim = true;
			boyfriend.animation.finishCallback = function(a:String)
			{
				if(a == 'dodge'){
					new FlxTimer().start(0.5, function(a:FlxTimer)
					{
						dodging = false;
						boyfriend.specialAnim = false;
					});
				}
			}
		}
		if(vcrShader!=null && ClientPrefs.Shaders)
			vcrShader.iTime.value[0] = Conductor.songPosition / 1000;
		if (canDodge && controls.NOTE_RING && curStage == 'sl4sh')
		{
			dodging = true;
			if (!SlashPressedSpace) {
				new FlxTimer().start(0.5, function(pressedSpace:FlxTimer)
				{
					dodging = false;
					SlashPressedSpace = false;
				});
			}
			SlashPressedSpace = true;
		}
		
		if (MechanicBFDie) {
			health = 0;
			healthbarval = 0;
		}
		if(curStage == 'my-horizon-wechidna'){
			if (dad.curCharacter == 'wechBeast') {
				if (dad.animation.curAnim.name != 'idle' && caShader.amount > -0.492) caShader.amount += -0.0205;
				if (caShader.amount < -0.100) { 
					switch(boyfriend.animation.curAnim.name){
						case 'singUP', 'singDOWN', 'singLEFT', 'singRIGHT': caShader.amount += 0.0150;
					}
				}
			}
			caShader.update(elapsed);
		}
	
		if ((isFreeplay || isEncore || isExtras || isSound || (isSound && isStoryMode)) && SONG.arrowSkin != 'NOTE_SUNKEH' && !isRing && !chartingMode && !isPixelStage && noteGenesis != 1 && !pixelNoteGenesis && ((SONG.splashSkin == null || SONG.splashSkin == 'BloodSplash' || SONG.splashSkin == 'arrows/noteSplashes' || SONG.splashSkin == 'slash-splash' || SONG.splashSkin == 'arrows/noteSplashes-COLOR') || (SONG.arrowSkin == null || SONG.arrowSkin == 'arrows/NOTE_assets' || SONG.arrowSkin == 'PIXELNOTE_assets' || SONG.arrowSkin == 'arrows/NOTE_assets-COLOR')))
			noteChangesFromTheStore = true;
		else
			noteChangesFromTheStore = false;
	
		if(SONG.song.toLowerCase() == 'manual-blast'){
			if (dad.curCharacter == 'scorchedglitch') {
				switch(dad.animation.curAnim.name){
					case 'idle':
						newIcon = "lordx-encore";
						iconP2.changeIcon(newIcon);
					case 'singUP':
						newIcon = "grimeware";
						iconP2.changeIcon(newIcon);
					case 'singDOWN':
						newIcon = "terion";
						iconP2.changeIcon(newIcon);
					case 'singLEFT':
						newIcon = "BEAST";
						iconP2.changeIcon(newIcon);
					case 'singRIGHT':
						newIcon = "rerun";
						iconP2.changeIcon(newIcon);
				}
				iconP2.changeIcon(newIcon);
			}

			if (dad.curCharacter == 'scorchedglitch2') {
				switch(dad.animation.curAnim.name){
					case 'idle':
						newIcon = "mighty";
						iconP2.changeIcon(newIcon);
					case 'singUP':
						newIcon = "griatos";
						iconP2.changeIcon(newIcon);
					case 'singDOWN':
						newIcon = "eyx";
						iconP2.changeIcon(newIcon);
					case 'singLEFT':
						newIcon = "cyclops";
						iconP2.changeIcon(newIcon);
					case 'singRIGHT':
						newIcon = "sallyAlt";
						iconP2.changeIcon(newIcon);
				}
			}
		}
		
		if(SONG.song.toLowerCase() == 'b4cksl4sh' && !MarStarBroBF && !SlashSecondPart){
			switch(MarPressed) {
				case 0:
					if (FlxG.keys.justPressed.M) {
						MarPressed = 1;
						trace("MAR");
					} else {
						if (curBeat % 8 == 0) MarPressed = 0;
					}
				case 1:
					if (FlxG.keys.justPressed.S) {
						MarPressed = 2;
						trace("STAR");
					} else {
						if (curBeat % 8 == 0) MarPressed = 0;
					}
				case 2:
					if (FlxG.keys.justPressed.B) {
						trace("BRO");
						triggerEventNote('Change Character', '0', 'bf-sl4sh-mar');
						GameOverSubstate.deathSoundName = 'slash-death';
						GameOverSubstate.loopSoundName = 'slash-gameover';
						GameOverSubstate.endSoundName = 'slash-retry';
						GameOverSubstate.characterName = 'bf-slash-mar-death';
						boyfriend.y -= 35;
						boyfriend.x += 175;
						boyfriend.y += 220;
						MarStarBroBF = true;
						MarPressed = 0;
					} else {
						if (curBeat % 8 == 0) MarPressed = 0;
					}
			}
		}

		if (SONG.song.toLowerCase() == 'godspeed') {
			switch(RunTextFlashSpeed) {
				case 0:
					if (curBeat % 8 == 0)
					{
						RUN.color = 0xFFFF0000;
						FlxTween.color(RUN, 1, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
					}
					
				case 1:
					if (curBeat % 8 == 0)
					{
						RUN.color = 0xFFFF0000;
						FlxTween.color(RUN, 0.25, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
					} else {
						if (curBeat % 4 == 0)
						{
							RUN.color = 0xFFFF0000;
							FlxTween.color(RUN, 0.25, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
						}
					}
					
				case 2:
					if (curBeat % 4 == 0)
					{
						RUN.color = 0xFFFF0000;
						FlxTween.color(RUN, 0.6, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
					}
					
				case 3:
					if (curBeat % 4 == 0)
					{
						RUN.color = 0xFFFF0000;
						FlxTween.color(RUN, 0.15, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
					} else {
						if (curBeat % 2 == 0)
						{
							RUN.color = 0xFFFF0000;
							FlxTween.color(RUN, 0.15, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
						}
					}
					
				case 4:
					if (curBeat % 2 == 0)
					{
						RUN.color = 0xFFFF0000;
						FlxTween.color(RUN, 0.05, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
					} else {
						if (curBeat % 1 == 0)
						{
							RUN.color = 0xFFFF0000;
							FlxTween.color(RUN, 0.05, 0xFFFF0000, 0xFF3F0000, {ease: FlxEase.circOut});
						}
					}
			}
		}
		
		if (GFIconChange) { //Change Icon
			if (GFandDad) {
				if (!bfIsLeft) {
					if (dad.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(boyfriend.healthIcon);
						iconP2.changeIcon(dad.healthIcon);
						HPBarColor = 'dad';
						reloadHealthBarColors();
					}
					if (gf.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(boyfriend.healthIcon);
						iconP2.changeIcon(gf.healthIcon);
						HPBarColor = 'gf';
						reloadHealthBarColors();
					}
				} else {
					if (dad.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(dad.healthIcon);
						iconP2.changeIcon(boyfriend.healthIcon);
						HPBarColor = 'dad';
						reloadHealthBarColors();
					}
					if (gf.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(gf.healthIcon);
						iconP2.changeIcon(boyfriend.healthIcon);
						HPBarColor = 'gf';
						reloadHealthBarColors();
					}
				}
			} else {
				if (!bfIsLeft) {
					if (boyfriend.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(boyfriend.healthIcon);
						iconP2.changeIcon(dad.healthIcon);
						HPBarColor = 'bf';
						reloadHealthBarColors();
					}
					if (gf.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(gf.healthIcon);
						iconP2.changeIcon(dad.healthIcon);
						HPBarColor = 'gf';
						reloadHealthBarColors();
					}
				} else {
					if (boyfriend.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(dad.healthIcon);
						iconP2.changeIcon(boyfriend.healthIcon);
						HPBarColor = 'bf';
						reloadHealthBarColors();
					}
					if (gf.animation.curAnim.name.startsWith('sing')) {
						iconP1.changeIcon(dad.healthIcon);
						iconP2.changeIcon(gf.healthIcon);
						HPBarColor = 'gf';
						reloadHealthBarColors();
					}
				}
			}
		}
		
		if (ClientPrefs.Shaders) {
			if(staticlol!=null){
				staticlol.iTime.value[0] = Conductor.songPosition / 1000;
				staticlol.alpha.value = [staticAlpha];
			}
			if(pixShader!=null){
				pixShader.iTime.value[0] = Conductor.songPosition / 1000;
			}
			if(staticlmao!=null){
				staticlmao.iTime.value[0] = Conductor.songPosition / 1000;
				staticlmao.alpha.value = [staticAlpha];
			}
			
			if(glitchThingy!=null){
				glitchThingy.iTime.value[0] = Conductor.songPosition / 1000;
			}

			if(camFuckShader!=null)
				camFuckShader.iTime.value[0] = Conductor.songPosition / 1000;
			
			if(camGlitchShader!=null){
				camGlitchShader.iResolution.value = [FlxG.width, FlxG.height];
				camGlitchShader.iTime.value[0] = Conductor.songPosition / 1000;
				if(camGlitchShader.amount>=1)camGlitchShader.amount=1;
				if(dad.curCharacter.startsWith("scorchedglitch"))
					camGlitchShader.amount = FlxMath.lerp(0.1, camGlitchShader.amount, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
				else
					camGlitchShader.amount = FlxMath.lerp(0, camGlitchShader.amount, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
			}
			for(shader in glitchShaders){
				shader.iTime.value[0] += elapsed;
			}
			
			if (WeedShit) {
				if(weedSpinningTime)
					weedVis.hue += elapsed * 2;
				else
					weedVis.hue = FlxMath.lerp(weedVis.hue, 0, CoolUtil.boundTo(elapsed * 2.4, 0, 1));
			}
		}
		
		if (isRing)
			counterNum.text = Std.string(cNum);
				
		#if windows
		if (isFixedAspectRatio)
			FlxG.fullscreen = false;
		else if (curStage == 'fatal-encore')
			FlxG.fullscreen = true;
		#end
			
		managePopups();
		
		callOnLuas('onUpdate', [elapsed]);

		if (dad.curCharacter == 'starved' || dad.curCharacter == 'Satanos')
		{
			isFear = true;
			fearBar.visible = true;
			fearBar.filledCallback = function()
			{
				health = 0;
			}
			// this is such a shitcan method i really should come up with something better tbf
			if (fearNo >= 50 && fearNo < 59)
				health -= 0.1 * elapsed;
			else if (fearNo >= 60 && fearNo < 69)
				health -= 0.13 * elapsed;
			else if (fearNo >= 70 && fearNo < 79)
				health -= 0.17 * elapsed;
			else if (fearNo >= 80 && fearNo < 89)
				health -= 0.20 * elapsed;
			else if (fearNo >= 90 && fearNo < 99)
				health -= 0.35 * elapsed;

			if (health <= 0.01)
			{
				health = 0.01;
			}
		}

		wireVignette.alpha = FlxMath.lerp(wireVignette.alpha, hexes/6, elapsed / (1/60) * 0.2);
		if(hexes > 0){
			var hpCap = 1.6 - ((hexes-1) * 0.3);
			if(hpCap < 0)
				hpCap = 0;
			var loss = 0.005 * (elapsed/(1/120));
			var newHP = health - loss;
			if(newHP < hpCap){
				loss = health - hpCap;
				newHP = health - loss;
			}
			if(loss<0)
				loss = 0;
			if(newHP > hpCap)
				health -= loss;
		}

		if(hexes>0)
		{
			hexTimer += elapsed;
			if (hexTimer >= 5)
			{
				hexTimer=0;
				hexes--;
				updateWires();
			}
		}

		if (fucklesMode)
		{
			fucklesDrain = 0.0005;
			if(drainMisses > 0)
				health -= (fucklesDrain * (elapsed/(1/120))) * drainMisses;
			else
				drainMisses = 0;
		}
		
		targetHP = health;
		if (bfIsLeft)
			targetHP = 2 - health;

		if(fucklesMode){
			var newTarget:Float = FlxMath.lerp(healthbarval, targetHP, 0.1*(elapsed/(1/60)));
				if(Math.abs(newTarget-targetHP)<.002){
				newTarget=targetHP;
			}else{
				targetHP = newTarget;
			}
		}

		healthbarval = targetHP;

		if(dropTime > 0)
		{
			dropTime -= elapsed;
			health -= healthDrop * (elapsed/(1/120));
		}

		if (curSong.toLowerCase() == 'godspeed')
		{
			var ccap;

			ccap = combo;
			if (combo > 40)
				ccap = 40;

			healthDrop = 0.0000001;
			health -= healthDrop * (300 / ((ccap + 1) / 8) * ((songMisses + 1) / 1.9));
			vgblack.alpha = 1 - (health / 2);
			tentas.alpha = 1 - (health / 2);
		}
		
		if (curSong.toLowerCase() == 'black-sun')
		{
			var ccap;

			ccap = combo;
			if (combo > 40)
				ccap = 40;

			healthDrop = 0.0000001;
			health -= healthDrop * (500 / ((ccap + 1) / 8) * ((songMisses + 1) / 1.9));
			vgblack.alpha = 1 - (health / 2);
			tentas.alpha = 1 - (health / 2);
		}

		if(dropTime<=0)
		{
			healthDrop = 0;
			dropTime = 0;
		}
		if (SONG.isRing)
			counterNum.text = Std.string(cNum);
		
		floaty += 0.03;
		floaty2 += 0.01;

		var targetSpeed:Float = 15;
		switch (hungryManJackTime)
		{
			case 1:
				targetSpeed = 35;
			case 2:
				targetSpeed = 50;
			case 3: 
				targetSpeed = 10;
			default:
				targetSpeed = 25;
		}
		starvedSpeed = FlxMath.lerp(starvedSpeed, targetSpeed, 0.3*(elapsed/(1/60)));
		if (targetSpeed - starvedSpeed < 0.2) starvedSpeed = targetSpeed;
			
		if (curStage == 'starved-pixel' && !ClientPrefs.PotatoOptimization)
		{
			stardustBgPixel.scrollX -= (starvedSpeed * stardustBgPixel.scrollFactor.x) * (elapsed/(1/120));
			stardustFloorPixel.scrollX -= starvedSpeed * (elapsed/(1/120));
		}
		
		if (curStage == 'godspeed' && !ClientPrefs.PotatoOptimization)
		{	
			starvedSpeed = 75;
			GSsky.scrollX -= (starvedSpeed * GSsky.scrollFactor.x) * (elapsed/(1/120));
			if (!ClientPrefs.Optimization) GSbbbg.scrollX -= (starvedSpeed * GSbbbg.scrollFactor.x) * (elapsed/(1/120));
			GSbbg.scrollX -= (starvedSpeed * GSbbg.scrollFactor.x) * (elapsed/(1/120));
			GSbg.scrollX -= (starvedSpeed * GSbg.scrollFactor.x) * (elapsed/(1/120));
			if (!ClientPrefs.Optimization) GSplants.scrollX -= (starvedSpeed * GSplants.scrollFactor.x) * (elapsed/(1/120));
		}
		
		if (curStage == 'endeavors' && !ClientPrefs.PotatoOptimization)
		{	
			majinScrollin.scrollX += (2.5 * majinScrollin.scrollFactor.x) * (elapsed/(1/120));
			majinScrollin.scrollY += (2.5 * majinScrollin.scrollFactor.y) * (elapsed/(1/120));
		}
	
		if (curStage == 'endeavors-og' && !ClientPrefs.PotatoOptimization)
		{	
			majinScrollin.scrollX += (2.5 * majinScrollin.scrollFactor.x) * (elapsed/(1/120));
			majinScrollin.scrollY += (2.5 * majinScrollin.scrollFactor.y) * (elapsed/(1/120));
		}
		
		switch (flyState)
		{
			case 'hover' | 'hovering':
				flyTarg.y += Math.sin(floaty) * 1.5;
			// moveCameraSection(Std.int(curStep / 16));
			case 'fly' | 'flying':
				flyTarg.y += Math.sin(floaty) * 1.5;
				flyTarg.x += Math.cos(floaty) * 1.5;
				// moveCameraSection(Std.int(curStep / 16));
			case 'sHover' | 'sHovering':
				flyTarg.y += Math.sin(floaty2) * 0.5;
		}
		
		if(!inCutscene) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 2.4 * cameraSpeed, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
			if(!startingSong && !endingSong && boyfriend.animation.curAnim.name.startsWith('idle')) {
				boyfriendIdleTime += elapsed;
				if(boyfriendIdleTime >= 0.15) { // Kind of a mercy thing for making the achievement easier to get as it's apparently frustrating to some playerss
					boyfriendIdled = true;
				}
			} else {
				boyfriendIdleTime = 0;
			}
		}

		super.update(elapsed);

		if (SONG.song.toLowerCase() == 'personel' && IsNoteSpinning)
		{
			var thisX:Float = Math.sin(SpinAmount * (SpinAmount / 2)) * 100;
			var thisY:Float = Math.sin(SpinAmount * (SpinAmount)) * 100;
			for (str in playerStrums)
			{
				str.angle = str.angle + SpinAmount;
				SpinAmount = SpinAmount + 0.0003;
			}
			for (str in opponentStrums)
			{
				str.angle = str.angle + SpinAmount;
				SpinAmount = SpinAmount + 0.0003;
			}
		}
		if (SONG.song.toLowerCase() == 'personel' && isPlayersSpinning)
		{
			dad.angle = dad.angle + SpinAmount;
			SpinAmount = SpinAmount + 0.00003;
			boyfriend.angle = boyfriend.angle + SpinAmount;
			SpinAmount = SpinAmount + 0.00003;
		}
		#if desktop
		if (SONG.song.toLowerCase() == 'fatality' && IsWindowMoving)
		{
			var thisX:Float = Math.sin(Xamount * (Xamount)) * 100;
			var thisY:Float = Math.sin(Yamount * (Yamount)) * 100;
			var yVal = Std.int(windowY + thisY);
			var xVal = Std.int(windowX + thisX);
			Lib.application.window.move(xVal, yVal);
			Yamount = Yamount + 0.0015;
			Xamount = Xamount + 0.00075;
		}
		#end

		switch (SONG.song.toLowerCase()) {
			case 'fight-or-flight':
				if(ratingName == '?')
					scoreTxt.text = SacrificesLang + songMisses + ' | ' + AccuracyLang + '???';
				else
					scoreTxt.text = SacrificesLang + songMisses + ' | ' + AccuracyLang + '(' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)';
				
			case 'godspeed':
				if(ratingName == '?') {
					Misses.text = MissesLang + songMisses + ' | ';
					Rating.text = '| ' +  RatingLang + ratingName;
				} else {
					Misses.text = MissesLang + songMisses + ' | ';
					Rating.text = '| ' +  RatingLang + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)';
				}
				
			default:
				if(scoreRandom){
					switch(FlxG.random.int(1, 6)) {
						case 1: scoreTxt.text = 'sC0r3: ' + songScore + ' | m11ses: ' + songMisses + ' | R4t3ng: ' + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
						case 2: scoreTxt.text = 'mIsees: ' + songScore + ' | raITNtg: ' + songMisses + ' | socRec: ' + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
						case 3: scoreTxt.text = 'Ra11utNg: ' + songScore + ' | scIrh4: ' + songMisses + ' | Moosiies: ' + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
						case 4: scoreTxt.text = '342hj1: ' + songScore + ' | 5436yu: ' + songMisses + ' | 876rygu: ' + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
						case 5: scoreTxt.text = 'agehjk3: ' + songScore + ' | 4uihja: ' + songMisses + ' | 8ubnmb1: ' + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
						case 6: scoreTxt.text = '4276uihj: ' + songScore + ' | a7d5hf: ' + songMisses + ' | z7dyguhj: ' + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
					}
				} else {
					if(!VHSui) {
						if (!devoidUI) {
							if (!xenoEncUI) {
								if(ratingName == '?')
									scoreTxt.text = ScoreLang + songScore + ' | ' + MissesLang + songMisses + ' | ' + RatingLang + ratingName;
								else
									scoreTxt.text = ScoreLang + songScore + ' | ' + MissesLang + songMisses + ' | ' + RatingLang + ratingName + ' (' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)' + ' - ' + ratingFC;//peeps wanted no integer rating
							} else {
								xenoEncPercentOfRating = Highscore.floorDecimal(ratingPercent * 100, 2);
								scoreTxt.text = ScoreLang + songScore;
								xenoEncMissesTxt.text = MissesLang + songMisses;
								if (xenoEncPercentOfRating < 25 && xenoEncPercentOfRating >= 0) xenoEncHP.animation.play("bad", true);
								if (xenoEncPercentOfRating < 50 && xenoEncPercentOfRating >= 25) xenoEncHP.animation.play("mid", true);
								if (xenoEncPercentOfRating < 75 && xenoEncPercentOfRating >= 50) xenoEncHP.animation.play("good", true);
								if (xenoEncPercentOfRating <= 100 && xenoEncPercentOfRating >= 75) xenoEncHP.animation.play("sick", true);
							}
						} else {
							devoidUImissesTxt.text = MissesLang + songMisses;
							scoreTxt.text = ScoreLang + songScore;
							devoidHPvalue = health/2;
							if (devoidHPvalue < 1)
								devoidUIhpTxt.text = Std.int(((devoidHPvalue) * 100)) + '%';
							else
								devoidUIhpTxt.text = '100%';
							if (devoidHPvalue < 0.05 && devoidHPvalue > 0) devoidHPBar.animation.play("eleven", true);
							if (devoidHPvalue < 0.1 && devoidHPvalue > 0.05) devoidHPBar.animation.play("ten", true);
							if (devoidHPvalue < 0.2 && devoidHPvalue > 0.1) devoidHPBar.animation.play("nine", true);
							if (devoidHPvalue < 0.3 && devoidHPvalue > 0.2) devoidHPBar.animation.play("eight", true);
							if (devoidHPvalue < 0.4 && devoidHPvalue > 0.3) devoidHPBar.animation.play("seven", true);
							if (devoidHPvalue < 0.5 && devoidHPvalue > 0.4) devoidHPBar.animation.play("six", true);
							if (devoidHPvalue < 0.6 && devoidHPvalue > 0.5) devoidHPBar.animation.play("five", true);
							if (devoidHPvalue < 0.7 && devoidHPvalue > 0.6) devoidHPBar.animation.play("four", true);
							if (devoidHPvalue < 0.8 && devoidHPvalue > 0.7) devoidHPBar.animation.play("three", true);
							if (devoidHPvalue < 0.9 && devoidHPvalue > 0.8) devoidHPBar.animation.play("two", true);
							if (devoidHPvalue > 0.95) devoidHPBar.animation.play("one", true);
						}
					} else {
						var time = DateTools.format(Date.now(), "%r");
						var months = DateTools.format(Date.now(), "%b");
						var dababe:String = '';
						if (ratingFC != '') dababe = ' - ' + ratingFC;
						scoreTxt.text = ScoreLang + songScore + '\n' + MissesLang + songMisses + '\n' + RatingLang + ratingName + dababe + '\n' + AccuracyLang + '(' + Highscore.floorDecimal(ratingPercent * 100, 2) + '%)';
						if (curStage != 'DDDDD') irlTxt.text =  Std.string(time) + '\n' + Std.string(months) + ' 1998';
						else irlTxt.text =  Std.string(time) + '\n' + Std.string(months) + ' 1997';
					}
				}
		}

		if(botplayTxt.visible) {
			botplaySine += 180 * elapsed;
			botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
		}

		if (controls.PAUSE #if mobile || FlxG.android.justReleased.BACK #end && startedCountdown && canPause) {
			FlxTween.globalManager.forEach(function(tween:FlxTween)
			{
				tween.active = false;
			});

			FlxTimer.globalManager.forEach(function(timer:FlxTimer)
			{
				timer.active = false;
			});
		
			var ret:Dynamic = callOnLuas('onPause', [], false);
			if(ret != FunkinLua.Function_Stop) {
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;

				if(FlxG.sound.music != null) {
					FlxG.sound.music.pause();
					vocals.pause();
				}
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		
				#if desktop
				var rpcF:String = ' (Charting Mode)';
				if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
					rpcF = TranslationLanguages.Text[rpcF];
				if (!chartingMode)
					DiscordClient.changePresence(detailsPausedText, SongLang + SONG.song, null);
				else
					DiscordClient.changePresence(detailsPausedText, SongLang + SONG.song + rpcF, null);
				#end
				#if windows
				if (!customIconAndName)
					lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Paused";
				#end
			}
		}
		
		#if DEV_MODE
		if (FlxG.keys.pressed.SHIFT && startedCountdown && canPause) {
			FlxTween.globalManager.forEach(function(tween:FlxTween)
			{
				tween.active = false;
			});

			FlxTimer.globalManager.forEach(function(timer:FlxTimer)
			{
				timer.active = false;
			});
		
			var ret:Dynamic = callOnLuas('onPause', [], false);
			if(ret != FunkinLua.Function_Stop) {
				persistentUpdate = false;
				persistentDraw = true;
				paused = true;

				if(FlxG.sound.music != null) {
					FlxG.sound.music.pause();
					vocals.pause();
				}
				openSubState(new SongDebugSubstate());
		
				#if desktop
				var rpcF:String = ' (Charting Mode)';
				if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
					rpcF = TranslationLanguages.Text[rpcF];
				if (!chartingMode)
					DiscordClient.changePresence(detailsPausedText, SongLang + SONG.song, null);
				else
					DiscordClient.changePresence(detailsPausedText, SongLang + SONG.song + rpcF, null);
				#end
				#if windows
				if (!customIconAndName)
					lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Paused";
				#end
			}
		}
		#end
		
		if (!LockedChartEditor) {
			if (FlxG.keys.anyJustPressed(debugKeysChart) && !endingSong && !inCutscene)
			{
				openChartEditor();
			}
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);
		
		if (!xenoEncUI) {
			var multP:Float;
			if (!VHSui)
				multP = FlxMath.lerp(1, iconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			else
				multP = FlxMath.lerp(0.8, iconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			iconP1.scale.set(multP, multP);
			iconP1.updateHitbox();
			
			var multPP:Float;
			if (!VHSui)
				multPP = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			else
				multPP = FlxMath.lerp(0.8, iconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			iconP2.scale.set(multPP, multPP);
			iconP2.updateHitbox();
		} else {
			var xenoEncMultP:Float;
			xenoEncMultP = FlxMath.lerp(0.5, xenoEncIconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			xenoEncIconP1.scale.set(xenoEncMultP, xenoEncMultP);
			xenoEncIconP1.updateHitbox();
			
			var xenoEncMultPP:Float;
			xenoEncMultPP = FlxMath.lerp(1, xenoEncIconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			xenoEncIconP2.scale.set(xenoEncMultPP, xenoEncMultPP);
			xenoEncIconP2.updateHitbox();
		
			var multP:Float;
			multP = FlxMath.lerp(1, iconP1.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			iconP1.scale.set(multP, multP);
			iconP1.updateHitbox();
			
			var multPP:Float;
			multPP = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
			iconP2.scale.set(multPP, multPP);
			iconP2.updateHitbox();
		}
		
		switch (curStage)
		{
			case 'starved' | 'schoolhouse':
				iconOffset = 270;
				
			case 'godspeed':
				iconOffset = 15;
				
			default:
				switch (FEHPThing)
				{
					case 0:
						iconOffset = 26;
					case 1:
						iconOffset = 270;
					case 2:
						iconOffset = -15;
				}	
		}

		switch (curStage)
		{
			case 'starved' | 'schoolhouse':
				iconP1.y = healthBar.y
				+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
				+ (150 * iconP1.scale.x - 150) / 2
				- iconOffset;
					
				iconP2.y = healthBar.y
				+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
				- (150 * iconP2.scale.x) / 2
				- iconOffset;

			case 'godspeed':
				iconP1.x = healthBar.x
				+ (healthBar.width)
				+ (150 * iconP1.scale.x - 150) / 2
				- iconOffset - 30;
				
				iconP2.x = healthBar.x
				+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
				- (150 * iconP2.scale.x) / 2
				- iconOffset * 2;
				
			default:
				switch (FEHPThing)
				{
					case 0:
						if (!VHSui) {
							if (!devoidUI) {
								iconP1.x = healthBar.x
								+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
								+ (150 * iconP1.scale.x - 150) / 2
								- iconOffset;
								
								iconP2.x = healthBar.x
								+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
								- (150 * iconP2.scale.x) / 2
								- iconOffset * 2;
							} 
						} else {
							iconP1.x = healthBar.x
							+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 113, 87, 0) * 0.01))
							+ (150 * iconP1.scale.x - 150) / 2
							- iconOffset;
									
							iconP2.x = healthBar.x
							+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 113, 87, 0) * 0.01))
							- (150 * iconP2.scale.x) / 2
							- iconOffset * 2;
						}
					case 1:
						iconP1.y = healthBar.y
						+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
						+ (150 * iconP1.scale.x - 150) / 2
						- iconOffset;
							
						iconP2.y = healthBar.y
						+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
						- (150 * iconP2.scale.x) / 2
						- iconOffset;
					case 2:
						iconP1.x = healthBar.x
						+ (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01))
						- (150 * iconP1.scale.x) / 2
						- iconOffset * 2;
						iconP2.x = healthBar.x - 90;
				}	
		}

		if (health > 2)
			health = 2;
		if (health < 0 && devoidUI)
			health = 0;

		switch (FEHPThing)
		{
			case 0:
				if (!xenoEncUI) {
					if (healthBar.percent < 20) {
						iconP1.animation.curAnim.curFrame = 1;
					} else {
						iconP1.animation.curAnim.curFrame = 0;
					}
					if (AnimatedDadIcon) {
						if (healthBar.percent > 80) {
							iconP2.animation.play('d');
						} else {
							iconP2.animation.play('n');
						}
					} else {
						if (healthBar.percent > 80) {
							iconP2.animation.curAnim.curFrame = 1;
						} else {
							iconP2.animation.curAnim.curFrame = 0;
						}
					}
				} else {
					if (xenoEncHealthBar.percent < 20) {
						xenoEncIconP1.animation.curAnim.curFrame = 1;
					} else {
						xenoEncIconP1.animation.curAnim.curFrame = 0;
					}
					if (AnimatedDadIcon) {
						if (xenoEncHealthBar.percent > 80) {
							xenoEncIconP2.animation.play('d');
						} else {
							xenoEncIconP2.animation.play('n');
						}
					} else {
						if (xenoEncHealthBar.percent > 80) {
							xenoEncIconP2.animation.curAnim.curFrame = 1;
						} else {
							xenoEncIconP2.animation.curAnim.curFrame = 0;
						}
					}
					if (healthBar.percent < 20) {
						iconP1.animation.curAnim.curFrame = 1;
					} else {
						iconP1.animation.curAnim.curFrame = 0;
					}
					if (AnimatedDadIcon) {
						if (healthBar.percent > 80) {
							iconP2.animation.play('d');
						} else {
							iconP2.animation.play('n');
						}
					} else {
						if (healthBar.percent > 80) {
							iconP2.animation.curAnim.curFrame = 1;
						} else {
							iconP2.animation.curAnim.curFrame = 0;
						}
					}
				}
			case 1:
				if (healthBar.percent < 20) {
					iconP1.animation.curAnim.curFrame = 1;
					iconP2.animation.curAnim.curFrame = 1;
				} else {
					iconP1.animation.curAnim.curFrame = 0;
					iconP2.animation.curAnim.curFrame = 0;
				}
			case 2:
				if (healthBar.percent > 80) {
					iconP1.animation.curAnim.curFrame = 1;
					iconP2.animation.curAnim.curFrame = 1;
				} else {
					iconP1.animation.curAnim.curFrame = 0;
					iconP2.animation.curAnim.curFrame = 0;
				}
		}
		
		if (!LockedChartEditor) {
			if (FlxG.keys.anyJustPressed(debugKeysCharacter) && !endingSong && !inCutscene) {
				persistentUpdate = false;
				paused = true;
				cancelMusicFadeTween();
				Main.InPlaystate = false;
				MusicBeatState.switchState(new CharacterEditorState(SONG.player2));
			}
		}
		
		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				var curTime:Float = FlxG.sound.music.time - ClientPrefs.noteOffset;
				if (curTime < 0)
					curTime = 0;
				songPercent = (curTime / songLength);

				var secondsTotal:Int = Math.floor((songLength - curTime) / 1000);
				if (secondsTotal < 0)
					secondsTotal = 0;

				var minutesRemaining:Int = Math.floor(secondsTotal / 60);
				var secondsRemaining:String = '' + secondsTotal % 60;

				if (secondsRemaining.length < 2)
					secondsRemaining = '0' + secondsRemaining;
				
				switch (SONG.song.toLowerCase()) {
					case 'endless' | 'endless-og':
						if(curStep>=898){
							songPercent=0;
							timeTxt.text = 'Infinity';
							if (TranslationLanguages.Text.exists(timeTxt.text) && ClientPrefs.Language != 'English')
								timeTxt.text = TranslationLanguages.Text[timeTxt.text];
						} else {
							timeTxt.text = minutesRemaining + ':' + secondsRemaining;
						}
					case 'endless-encore':
						songPercent=0;
						timeTxt.text = 'Infinity';
						if (TranslationLanguages.Text.exists(timeTxt.text) && ClientPrefs.Language != 'English')
							timeTxt.text = TranslationLanguages.Text[timeTxt.text];
					default:
						if (!endingSong) {
							if (!xenoEncUI) {
								timeTxt.text = minutesRemaining + ':' + secondsRemaining;
							} else {
								var ya:String = 'Time: ';
								if (TranslationLanguages.Text.exists(ya) && ClientPrefs.Language != 'English')
									ya = TranslationLanguages.Text[ya];
								timeTxt.text = ya + minutesRemaining + ':' + secondsRemaining;
							}
						} else {
							if (!xenoEncUI) {
								timeTxt.text = '0:00';
							} else {
								var ya:String = 'Time: ';
								if (TranslationLanguages.Text.exists(ya) && ClientPrefs.Language != 'English')
									ya = TranslationLanguages.Text[ya];
								timeTxt.text = ya + '0:00';
							}
						}
				}

				var curMS:Float = Math.floor(curTime);
				var curSex:Int = Math.floor(curMS / 1000);
				if (curSex < 0)
					curSex = 0;

		   	var curMins = Math.floor(curSex / 60);
				curMS%=1000;
		   	curSex%=60;

				minNumber.number = curMins;

				var sepSex = Std.string(curSex).split("");
				if(curSex<10){
					secondNumberA.number = 0;
					secondNumberB.number = curSex;
				}else{
					secondNumberA.number = Std.parseInt(sepSex[0]);
					secondNumberB.number = Std.parseInt(sepSex[1]);
				}
				if(millisecondNumberA!=null && millisecondNumberB!=null){
					curMS = Math.round(curMS/10);
					if(curMS<10){
						millisecondNumberA.number = 0;
						millisecondNumberB.number = Math.floor(curMS);
					}else{
						var sepMSex = Std.string(curMS).split("");
						millisecondNumberA.number = Std.parseInt(sepMSex[0]);
						millisecondNumberB.number = Std.parseInt(sepMSex[1]);
					}
				}
			}
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null) {
			if (dad.curCharacter == 'scorched' || dad.curCharacter == 'starved' || dad.curCharacter == 'beast_chaotix' || dad.curCharacter == 'fatal-sonic' ||  dad.curCharacter == 'fatal-glitched') {
				updateCamFollow(elapsed);
			}
		}

		if (camZooming)
		{
			var focus:Character = boyfriend;
			var curSection:Int = Math.floor(curStep / 16);
			if(SONG.notes[curSection]!=null){
				if (gf != null && SONG.notes[curSection].gfSection)
				{
					focus = gf;
				}else if (!SONG.notes[curSection].mustHitSection)
				{
					focus = dad;
				}
			}

			switch (focus.curCharacter)
			{
				case "beast_chaotix":
					FlxG.camera.zoom = FlxMath.lerp(1.2, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
				default:
					FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
			}
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));
			camOverlay.zoom = camHUD.zoom;
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		// RESET = Quick Game Over Screen
		if (!ClientPrefs.noReset && controls.RESET && !inCutscene && !endingSong)
		{
			health = 0;
			trace("RESET = True");
		}
		doDeathCheck();

		if (unspawnNotes[0] != null)
		{
			var time:Float = 3000;//shit be werid on 4:3
			if(songSpeed < 1) time /= songSpeed;

			while (unspawnNotes.length > 0 && unspawnNotes[0].strumTime - Conductor.songPosition < time)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.insert(0, dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
		{
			if (!inCutscene) {
				if(!cpuControlled) {
					keyShit();
				} else if(boyfriend.holdTimer > Conductor.stepCrochet * 0.001 * boyfriend.singDuration && boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss')) {
					boyfriend.dance();
					//boyfriend.animation.curAnim.finish();
				}
			}

			var fakeCrochet:Float = (60 / SONG.bpm) * 1000;
			notes.forEachAlive(function(daNote:Note)
			{
				var strumGroup:FlxTypedGroup<StrumNote> = playerStrums;
				if(!daNote.mustPress) strumGroup = opponentStrums;

				var strumX:Float = strumGroup.members[daNote.noteData].x;
				var strumY:Float = strumGroup.members[daNote.noteData].y;
				var strumAngle:Float = strumGroup.members[daNote.noteData].angle;
				var strumDirection:Float = strumGroup.members[daNote.noteData].direction;
				var strumAlpha:Float = strumGroup.members[daNote.noteData].alpha;
				var strumScroll:Bool = strumGroup.members[daNote.noteData].downScroll;

				strumX += daNote.offsetX;
				strumY += daNote.offsetY;
				strumAngle += daNote.offsetAngle;
				strumAlpha *= daNote.multAlpha;

				if (strumScroll) //Downscroll
				{
					//daNote.y = (strumY + 0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
					daNote.distance = (0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
				}
				else //Upscroll
				{
					//daNote.y = (strumY - 0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
					daNote.distance = (-0.45 * (Conductor.songPosition - daNote.strumTime) * songSpeed);
				}

				var angleDir = strumDirection * Math.PI / 180;
				if (daNote.copyAngle)
					daNote.angle = strumDirection - 90 + strumAngle;

				if(daNote.copyAlpha)
					daNote.alpha = strumAlpha;
				
				if(daNote.copyX)
					daNote.x = strumX + Math.cos(angleDir) * daNote.distance;

				if(daNote.copyY)
				{
					daNote.y = strumY + Math.sin(angleDir) * daNote.distance;

					//Jesus fuck this took me so much mother fucking time AAAAAAAAAA
					if(strumScroll && daNote.isSustainNote)
					{
						if (daNote.animation.curAnim.name.endsWith('end')) {
							daNote.y += 10.5 * (fakeCrochet / 400) * 1.5 * songSpeed + (46 * (songSpeed - 1));
							daNote.y -= 46 * (1 - (fakeCrochet / 600)) * songSpeed;
							if(PlayState.isPixelStage) {
								daNote.y += 8 + (6 - daNote.originalHeightForCalcs) * PlayState.daPixelZoom;
							} else {
								daNote.y -= 19;
							}
						} 
						daNote.y += (Note.swagWidth / 2) - (60.5 * (songSpeed - 1));
						daNote.y += 27.5 * ((SONG.bpm / 100) - 1) * (songSpeed - 1);
					}
				}

				if (!daNote.mustPress && daNote.wasGoodHit && !daNote.hitByOpponent && !daNote.ignoreNote)
				{
					opponentNoteHit(daNote);
				}

				if(daNote.mustPress && cpuControlled) {
					if(daNote.isSustainNote) {
						if(daNote.canBeHit) {
							goodNoteHit(daNote);
						}
					} else if(daNote.strumTime <= Conductor.songPosition || (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress)) {
						goodNoteHit(daNote);
					}
				}
				
				var center:Float = strumY + Note.swagWidth / 2;
				if(strumGroup.members[daNote.noteData].sustainReduce && daNote.isSustainNote && (daNote.mustPress || !daNote.ignoreNote) &&
					(!daNote.mustPress || (daNote.wasGoodHit || (daNote.prevNote.wasGoodHit && !daNote.canBeHit))))
				{
					if (strumScroll)
					{
						if(daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= center)
						{
							var swagRect = new FlxRect(0, 0, daNote.frameWidth, daNote.frameHeight);
							swagRect.height = (center - daNote.y) / daNote.scale.y;
							swagRect.y = daNote.frameHeight - swagRect.height;

							daNote.clipRect = swagRect;
						}
					}
					else
					{
						if (daNote.y + daNote.offset.y * daNote.scale.y <= center)
						{
							var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
							swagRect.y = (center - daNote.y) / daNote.scale.y;
							swagRect.height -= swagRect.y;

							daNote.clipRect = swagRect;
						}
					}
				}

				// Kill extremely late notes and cause misses
				if (Conductor.songPosition > noteKillOffset + daNote.strumTime)
				{
					if (daNote.mustPress && !cpuControlled && !daNote.ignoreNote && !endingSong && (daNote.tooLate || !daNote.wasGoodHit)) {
						if (isRing) {
							if (daNote.noteData == 0) {
								noteMiss(daNote);
							}
							if (daNote.noteData == 1) {
								noteMiss(daNote);
							}
							if (daNote.noteData == 3) {
								noteMiss(daNote);
							}
							if (daNote.noteData == 4) {
								noteMiss(daNote);
							}
						} else {
							noteMiss(daNote);
						}
					}

					daNote.active = false;
					daNote.visible = false;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			});
		}
		checkEventNote();
		
		if (noteChangesFromTheStore) {
			if (ClientPrefs.arrowColorsRGB) {
				if (RGBval < 360)
					RGBval += 1; 
				else if (RGBval >= 360)
					RGBval = -360;

				rgbColorSwap.hue = RGBval / 360;
				rgbColorSwap.saturation = 0;
				rgbColorSwap.brightness = 0;
			}
		} else {
			if (ClientPrefs.arrowColorsRGB) {
				rgbColorSwap.hue = 0;
				rgbColorSwap.saturation = 0;
				rgbColorSwap.brightness = 0;
			}
		}
		
		#if debug
		if(!endingSong && !startingSong) {
			if (FlxG.keys.justPressed.ONE) {
				KillNotes();
				FlxG.sound.music.onComplete();
			}
			if(FlxG.keys.justPressed.TWO) { //Go 10 seconds into the future :O
				setSongTime(Conductor.songPosition + 10000);
				clearNotesBefore(Conductor.songPosition);
			}
		}
		#end
		/*if (!isFixedAspectRatio) {
			if (curShader == null && curShaderone == null && curShadertwo == null) {
				for (camNum in 0...1) {
					var cam:FlxCamera = camGame;
					if (camNum==1) cam=camHUD;
					cam.flashSprite.scaleX = 1.25;
					cam.flashSprite.scaleY = 1.25;
					cam.setScale(cam.zoom / 1.25, cam.zoom / 1.25);
				}
			}
		}*/
		setOnLuas('cameraX', camFollowPos.x);
		setOnLuas('cameraY', camFollowPos.y);
		setOnLuas('botPlay', cpuControlled);
		callOnLuas('onUpdatePost', [elapsed]);
	}
	
	function openChartEditor()
	{
		noteChangesFromTheStore = false;
		customArrowColors = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
		customNoteColors = false;
		noteGenesis = 0;
		SONG.splashSkin='';
		SONG.arrowSkin='';
		persistentUpdate = false;
		paused = true;
		cancelMusicFadeTween();
		Main.InPlaystate = false;
		if (ClientPrefs.ClassicChartEditor)
			MusicBeatState.switchState(new ChartingState());
		else
			MusicBeatState.switchState(new BuggyChartingState());
		chartingMode = true;

		#if desktop
		var rpcF:String = 'CE-Chart Editor';
		if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
			rpcF = TranslationLanguages.Text[rpcF];
		else
			rpcF = 'Chart Editor';
		DiscordClient.changePresence(rpcF, null, null, true);
		#end
	}

	function fireWorksDeluxe()
	{
		if (!ClientPrefs.PotatoOptimization) {
			horizonRed.animation.play('idle');
			new FlxTimer().start(2, function(tmr:FlxTimer) {
				horizonPurpur.animation.play('idle');
			});
			new FlxTimer().start(0.5, function(tmr:FlxTimer) {
				horizonYellow.animation.play('idle');
			});
		}
	}

	public var isDead:Bool = false; //Don't mess with this on Lua!!!
	function doDeathCheck(?skipHealthCheck:Bool = false) {
		if (((skipHealthCheck && instakillOnMiss) || health <= 0) && !practiceMode && !isDead)
		{
			var ret:Dynamic = callOnLuas('onGameOver', [], false);
			if(ret != FunkinLua.Function_Stop) {
				boyfriend.stunned = true;
				deathCounter++;

				paused = true;

				vocals.stop();
				FlxG.sound.music.stop();

				persistentUpdate = false;
				persistentDraw = false;
				
				switch (SONG.song.toLowerCase()) {
					case 'prey': FlxG.camera.zoom = 1.2;
					case 'b4cksl4sh': FlxG.camera.zoom = 1.4;
					case 'frenzy': FlxG.camera.zoom = 0.65;
					case 'sunshine', 'drippyshine': FlxG.camera.zoom = 1.1;
				}

				for (tween in modchartTweens) tween.active = true;
				for (tween in piss) tween.active = true;
				for (timer in modchartTimers) timer.active = true;
				Main.InPlaystate = false;
				switch (SONG.song.toLowerCase()) {
					case 'too-fest', 'too-fest-old':
						openSubState(new GameOverSanicSubstate());
					case 'forestall-desire':
						openSubState(new GameOverRequitalSubstate());
					case 'melting', 'melting-old', 'confronting':
						openSubState(new GameOverMelthogSubstate());
					case 'personel':
						openSubState(new GameOverColdsteelSubstate());
					case 'personel-serious':
						openSubState(new GameOverSeriousColdsteelSubstate());
					case 'my-horizon-wechidna':
						openSubState(new GameOverWechidnaSubstate());
					case 'haze', 'haze-og', 'marauder':
						openSubState(new GameOverGriatosSubstate(boyfriend.getScreenPosition().x - boyfriend.positionArray[0], boyfriend.getScreenPosition().y - boyfriend.positionArray[1], camFollowPos.x, camFollowPos.y));
					default:
						openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x - boyfriend.positionArray[0], boyfriend.getScreenPosition().y - boyfriend.positionArray[1], camFollowPos.x, camFollowPos.y));
				}
				#if desktop
				var rpcF:String = ' (Charting Mode)';
				if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
					rpcF = TranslationLanguages.Text[rpcF];
				var rpcS:String = 'Game Over - ';
				if (TranslationLanguages.Text.exists(rpcS) && ClientPrefs.Language != 'English')
					rpcS = TranslationLanguages.Text[rpcS];
				if (!chartingMode)
					DiscordClient.changePresence(rpcS + detailsText, SongLang + SONG.song, null);
				else
					DiscordClient.changePresence(rpcS + detailsText, SongLang + SONG.song + rpcF, null);
				#end
				#if windows
				if (!customIconAndName)
					lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Game Over";
				#end
				isDead = true;
				return true;
			}
		}
		return false;
	}

	function doSimpleJump()
	{
		trace('SIMPLE JUMPSCARE');

		var simplejump:FlxSprite;
		switch (SONG.song.toLowerCase()) {
			case 'too-slow-encore':
				simplejump = new FlxSprite(0, 0).loadGraphic(Paths.image("epicjump", 'exe'));
				FlxG.sound.play(Paths.sound('spook', 'preload'), 1);
			case 'too-slow-encore-alt':
				simplejump = new FlxSprite(0, 0).loadGraphic(Paths.image("grimbojump", 'exe'));
				FlxG.sound.play(Paths.sound('spooky', 'preload'), 1);
			default:
				simplejump = new FlxSprite(0, 0).loadGraphic(Paths.image("simplejump", 'exe'));
				FlxG.sound.play(Paths.sound('sppok', 'preload'), 1);
		}
		simplejump.setGraphicSize(FlxG.width, FlxG.height);
		simplejump.screenCenter();
		simplejump.cameras = [camOther];
		FlxG.camera.shake(0.0025, 0.50);
		add(simplejump);

		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			trace('ended simple jump');
			remove(simplejump);
		});

		// now for static

		var daStatic = new FlxSprite(0, 0);
		daStatic.frames = Paths.getSparrowAtlas('daSTAT', 'exe');
		daStatic.setGraphicSize(FlxG.width, FlxG.height);
		daStatic.screenCenter();
		daStatic.cameras = [camOther];
		daStatic.animation.addByPrefix('static', 'staticFLASH', 24, false);
		add(daStatic);

		FlxG.sound.play(Paths.sound('staticBUZZ', 'preload'));

		if (daStatic.alpha != 0)
			daStatic.alpha = FlxG.random.float(0.1, 0.5);

		daStatic.animation.play('static');

		daStatic.animation.finishCallback = function(pog:String)
		{
			trace('ended static');
			remove(daStatic);
		}
	}

	function doStaticSign(lestatic:Int = 0, leopa:Bool = true)
	{
		trace('static MOMENT HAHAHAH ' + lestatic);

		var daStatic = new FlxSprite(0, 0);
		daStatic.frames = Paths.getSparrowAtlas('daSTAT', 'exe');
		daStatic.setGraphicSize(FlxG.width, FlxG.height);
		daStatic.screenCenter();
		if (SONG.song.toLowerCase() == 'you-cant-run-encore' || SONG.song.toLowerCase() == 'faker' || SONG.song.toLowerCase() == 'too-slow' || SONG.song.toLowerCase() == 'too-slow-encore') {
			daStatic.cameras = [camOther];
		} else {
			daStatic.cameras = [camHUD];
		}
		
		switch (lestatic)
		{
			case 0:
				daStatic.animation.addByPrefix('static', 'staticFLASH', 24, false);
		}
		add(daStatic);

		FlxG.sound.play(Paths.sound('staticBUZZ', 'preload'));

		if (leopa)
		{
			if (daStatic.alpha != 0)
				daStatic.alpha = FlxG.random.float(0.1, 0.5);
		}
		else
			daStatic.alpha = 1;

		daStatic.animation.play('static');

		daStatic.animation.finishCallback = function(pog:String)
		{
			trace('ended static');
			remove(daStatic);
		}
	}

	public function checkEventNote() {
		while(eventNotes.length > 0) {
			var leStrumTime:Float = eventNotes[0].strumTime;
			if(Conductor.songPosition < leStrumTime) {
				break;
			}

			var value1:String = '';
			if(eventNotes[0].value1 != null)
				value1 = eventNotes[0].value1;

			var value2:String = '';
			if(eventNotes[0].value2 != null)
				value2 = eventNotes[0].value2;

			triggerEventNote(eventNotes[0].event, value1, value2);
			eventNotes.shift();
		}
	}

	public function getControl(key:String) {
		var pressed:Bool = Reflect.getProperty(controls, key);
		//trace('Control result: ' + pressed);
		return pressed;
	}

	var timeUse:Float;
	public function FatalityEncoreAddCorruptFiles(time:Float = 0.06) {
		timeUse = time;
		var files:Array<String>;
		if (UseWindowsDesktopFiles)
			files = WinPaths.getDesktopFileNames(false, false, false, false, false);
		else
			files = NonRealDesktopIcons;
		FatalEncoreCorruptedFilesALL.forEach(function(spr:FlxSprite) {
			if (spr.ID > files.length-1) {
				new FlxTimer().start(timeUse, function(timeee:FlxTimer) {
					FlxTween.tween(spr, {alpha: 1}, time-0.01);
				});
				timeUse += time;
			}
		});
	}
	
	public function FatalityEncoreMechanic(throwCorrFile:Bool = false, preload:Bool = false) {
		var fileSize:Int = FlxG.random.int(100, 135);
		var yuppie:Int = FlxG.random.int(0, 1);
		if (!throwCorrFile) {
			var files:Array<String>;
			if (UseWindowsDesktopFiles)
				files = WinPaths.getDesktopFileNames(false, false, false, false, false);
			else
				files = NonRealDesktopIcons;
			var randomFile:Int = FlxG.random.int(0, files.length-1);
			if (!FatalEncoreFileGotCorrupted.contains(randomFile)) {
				FatalEncoreFilesGlitch.forEach(function(spr:FlxSprite) {
					if (spr.ID == randomFile && !preload)
						FlxTween.tween(spr, {alpha: 1}, 1);
				});
				FatalEncoreFiles.forEach(function(spr:FlxSprite) {
					if (spr.ID == randomFile && !preload) {
						new FlxTimer().start(10, function(timer1:FlxTimer) {
							FlxTween.color(spr, 3, 0xFFFFFFFF, 0xFF800000, {ease: FlxEase.quadOut});
						});
					}
				});
				new FlxTimer().start(15, function(timer2:FlxTimer) {
					FatalEncoreCorruptedFilesALL.forEach(function(spr:FlxSprite) {
						if (spr.ID == randomFile && !preload)
							FlxTween.tween(spr, {alpha: 1}, 0.5);
					});
					FatalEncoreFiles.forEach(function(spr:FlxSprite) {
						if (spr.ID == randomFile && !preload)
							FlxTween.tween(spr, {alpha: 0}, 0.6);
					});
					FatalEncoreFilesGlitch.forEach(function(spr:FlxSprite) {
						if (spr.ID == randomFile && !preload)
							FlxTween.tween(spr, {alpha: 0}, 0.6);
					});
					new FlxTimer().start(0.5, function(timer3:FlxTimer) {
						var FilesFolder:String = 'fatal-encore-classic-icons/';
						if (UseWindowsDesktopFiles)
							FilesFolder = 'fatal-encore-icons/';
						var fileFlying:FlxSprite = new FlxSprite();
						#if desktop
						if (FileSystem.exists('mods/images/' + FilesFolder + files[randomFile] + '.png'))
							fileFlying.loadGraphic(Paths.image(FilesFolder + files[randomFile]));
						else
							fileFlying.loadGraphic(Paths.image('unknown'));
						#else
						fileFlying.loadGraphic(Paths.image(FilesFolder + files[randomFile]));
						#end
						fileFlying.setGraphicSize(fileSize, fileSize);
						fileFlying.scrollFactor.set(0, 0);
						fileFlying.updateHitbox();
						fileFlying.cameras = [camOther];
						fileFlying.screenCenter();
						
						switch(FlxG.random.int(0, 1)) {
							case 0:
								fileFlying.x += -750;
								fileFlying.y += -500;
								if (yuppie == 0)
									fileFlying.x += FlxG.random.int(0, 1500);
								else
									fileFlying.y += FlxG.random.int(0, 1000);
							case 1:
								fileFlying.x += 750;
								fileFlying.y += 500;
								if (yuppie == 0)
									fileFlying.x += FlxG.random.int(0, -1500);
								else
									fileFlying.y += FlxG.random.int(0, -1000);
						}
						fileFlying.antialiasing = true;
						add(fileFlying);
						if (preload)
							fileFlying.visible = false;
						if (yuppie == 1) FlxTween.tween(fileFlying, {x: -fileFlying.x + 1175}, 4, {ease: FlxEase.bounceInOut});
						if (yuppie == 0) FlxTween.tween(fileFlying, {y: -fileFlying.y + 550}, 4, {ease: FlxEase.bounceInOut});
						FlxTween.tween(fileFlying, {angle: 720}, 5, {ease: FlxEase.bounceInOut});
						new FlxTimer().start(5.5, function(timer4:FlxTimer) {
							fileFlying.destroy();
						});
					});
				});
				FatalEncoreFileGotCorrupted.push(randomFile);
			}
		} else {
			var fileFlyingCorr:FlxSprite = new FlxSprite();
			fileFlyingCorr.loadGraphic(Paths.image('CORRUPTED FILE'));
			fileFlyingCorr.setGraphicSize(fileSize, fileSize);
			fileFlyingCorr.scrollFactor.set(0, 0);
			fileFlyingCorr.updateHitbox();
			fileFlyingCorr.cameras = [camOther];
			fileFlyingCorr.screenCenter();
			
			switch(FlxG.random.int(0, 1)) {
				case 0:
					fileFlyingCorr.x += -750;
					fileFlyingCorr.y += -500;
					if (yuppie == 0)
						fileFlyingCorr.x += FlxG.random.int(0, 1500);
					else
						fileFlyingCorr.y += FlxG.random.int(0, 1000);
				case 1:
					fileFlyingCorr.x += 750;
					fileFlyingCorr.y += 500;
					if (yuppie == 0)
						fileFlyingCorr.x += FlxG.random.int(0, -1500);
					else
						fileFlyingCorr.y += FlxG.random.int(0, -1000);
			}
			fileFlyingCorr.antialiasing = true;
			add(fileFlyingCorr);
			if (yuppie == 1) FlxTween.tween(fileFlyingCorr, {x: -fileFlyingCorr.x + 1175}, 4, {ease: FlxEase.bounceInOut});
			if (yuppie == 0) FlxTween.tween(fileFlyingCorr, {y: -fileFlyingCorr.y + 550}, 4, {ease: FlxEase.bounceInOut});
			FlxTween.tween(fileFlyingCorr, {angle: 720}, 5, {ease: FlxEase.bounceInOut});
			new FlxTimer().start(5.5, function(timer4:FlxTimer) {
				fileFlyingCorr.destroy();
			});
		}
	}

	public function triggerEventNote(eventName:String, value1:String, value2:String) {
		switch(eventName) {
			case 'Hey!':
				var value:Int = 2;
				switch(value1.toLowerCase().trim()) {
					case 'bf' | 'boyfriend' | '0':
						value = 0;
					case 'gf' | 'girlfriend' | '1':
						value = 1;
				}

				var time:Float = Std.parseFloat(value2);
				if(Math.isNaN(time) || time <= 0) time = 0.6;

				if(value != 0) {
					if(dad.curCharacter.startsWith('gf')) { //Tutorial GF is actually Dad! The GF is an imposter!! ding ding ding ding ding ding ding, dindinding, end my suffering
						dad.playAnim('cheer', true);
						dad.specialAnim = true;
						dad.heyTimer = time;
					} else if (gf != null) {
						gf.playAnim('cheer', true);
						gf.specialAnim = true;
						gf.heyTimer = time;
					}

					if(curStage == 'mall') {
						bottomBoppers.animation.play('hey', true);
						heyTimer = time;
					}
				}
				if(value != 1) {
					boyfriend.playAnim('hey', true);
					boyfriend.specialAnim = true;
					boyfriend.heyTimer = time;
				}

			case 'Set GF Speed':
				var value:Int = Std.parseInt(value1);
				if(Math.isNaN(value) || value < 1) value = 1;
				gfSpeed = value;

			case 'Blammed Lights':
				var lightId:Int = Std.parseInt(value1);
				if(Math.isNaN(lightId)) lightId = 0;

				var chars:Array<Character> = [boyfriend, gf, dad];
				if(lightId > 0 && curLightEvent != lightId) {
					if(lightId > 5) lightId = FlxG.random.int(1, 5, [curLightEvent]);

					var color:Int = 0xffffffff;
					switch(lightId) {
						case 1: //Blue
							color = 0xff31a2fd;
						case 2: //Green
							color = 0xff31fd8c;
						case 3: //Pink
							color = 0xfff794f7;
						case 4: //Red
							color = 0xfff96d63;
						case 5: //Orange
							color = 0xfffba633;
					}
					curLightEvent = lightId;

					if(blammedLightsBlack.alpha == 0) {
						if(blammedLightsBlackTween != null) {
							blammedLightsBlackTween.cancel();
						}
						blammedLightsBlackTween = FlxTween.tween(blammedLightsBlack, {alpha: 1}, 1, {ease: FlxEase.quadInOut,
							onComplete: function(twn:FlxTween) {
								blammedLightsBlackTween = null;
							}
						});

						for (char in chars) {
							if(char.colorTween != null) {
								char.colorTween.cancel();
							}
							char.colorTween = FlxTween.color(char, 1, FlxColor.WHITE, color, {onComplete: function(twn:FlxTween) {
								char.colorTween = null;
							}, ease: FlxEase.quadInOut});
						}
					} else {
						if(blammedLightsBlackTween != null) {
							blammedLightsBlackTween.cancel();
						}
						blammedLightsBlackTween = null;
						blammedLightsBlack.alpha = 1;

						for (char in chars) {
							if(char.colorTween != null) {
								char.colorTween.cancel();
							}
							char.colorTween = null;
						}
						dad.color = color;
						boyfriend.color = color;
						if (gf != null)
							gf.color = color;
					}
					
					if(curStage == 'philly') {
						if(phillyCityLightsEvent != null) {
							phillyCityLightsEvent.forEach(function(spr:BGSprite) {
								spr.visible = false;
							});
							phillyCityLightsEvent.members[lightId - 1].visible = true;
							phillyCityLightsEvent.members[lightId - 1].alpha = 1;
						}
					}
				} else {
					if(blammedLightsBlack.alpha != 0) {
						if(blammedLightsBlackTween != null) {
							blammedLightsBlackTween.cancel();
						}
						blammedLightsBlackTween = FlxTween.tween(blammedLightsBlack, {alpha: 0}, 1, {ease: FlxEase.quadInOut,
							onComplete: function(twn:FlxTween) {
								blammedLightsBlackTween = null;
							}
						});
					}

					if(curStage == 'philly') {
						phillyCityLights.forEach(function(spr:BGSprite) {
							spr.visible = false;
						});
						phillyCityLightsEvent.forEach(function(spr:BGSprite) {
							spr.visible = false;
						});

						var memb:FlxSprite = phillyCityLightsEvent.members[curLightEvent - 1];
						if(memb != null) {
							memb.visible = true;
							memb.alpha = 1;
							if(phillyCityLightsEventTween != null)
								phillyCityLightsEventTween.cancel();

							phillyCityLightsEventTween = FlxTween.tween(memb, {alpha: 0}, 1, {onComplete: function(twn:FlxTween) {
								phillyCityLightsEventTween = null;
							}, ease: FlxEase.quadInOut});
						}
					}

					for (char in chars) {
						if(char.colorTween != null) {
							char.colorTween.cancel();
						}
						char.colorTween = FlxTween.color(char, 1, char.color, FlxColor.WHITE, {onComplete: function(twn:FlxTween) {
							char.colorTween = null;
						}, ease: FlxEase.quadInOut});
					}

					curLight = 0;
					curLightEvent = 0;
				}

			case 'Kill Henchmen':
				killHenchmen();

			case 'Add Camera Zoom':
				if(ClientPrefs.camZooms && FlxG.camera.zoom < 1.35) {
					var camZoom:Float = Std.parseFloat(value1);
					var hudZoom:Float = Std.parseFloat(value2);
					if(Math.isNaN(camZoom)) camZoom = 0.015;
					if(Math.isNaN(hudZoom)) hudZoom = 0.03;

					FlxG.camera.zoom += camZoom;
					camHUD.zoom += hudZoom;
				}

			case 'Trigger BG Ghouls':
				if(curStage == 'schoolEvil' && !ClientPrefs.lowQuality) {
					bgGhouls.dance(true);
					bgGhouls.visible = true;
				}

			case 'Play Animation':
				var char:Character = dad;
				switch(value2.toLowerCase().trim()) {
					case 'bf' | 'boyfriend':
						char = boyfriend;
					case 'gf' | 'girlfriend':
						char = gf;
					default:
						var val2:Int = Std.parseInt(value2);
						if(Math.isNaN(val2)) val2 = 0;
		
						switch(val2) {
							case 1: char = boyfriend;
							case 2: char = gf;
						}
				}

				switch (value1)
				{
					case 'end':
						char.specialAnim = false;
					case 'laugh' | 'justdie':
						if(dad.curCharacter == 'ycr' || dad.curCharacter == 'ycr-mad' || dad.curCharacter == 'ycr-cherribun' || dad.curCharacter == 'ycr-cherribun-hotv' || dad.curCharacter == 'ycr-mad-cherribun' || dad.curCharacter == 'Esta-YCR' || dad.curCharacter == 'Esta-YCR_Scream' || dad.curCharacter == 'Esta-YCR_Angry' || dad.curCharacter == 'Esta-YCR_JustDie') {
							camGame.zoom += 0.03;
							camHUD.zoom += 0.06;
							FlxG.camera.shake(0.0025, 0.50);
						}
						char.playAnim(value1, true);
						char.specialAnim = true;
					default:
						if (char != null)
						{
							char.playAnim(value1, true);
							char.specialAnim = true;
						}
				}

			case 'Camera Follow Pos':
				var val1:Float = Std.parseFloat(value1);
				var val2:Float = Std.parseFloat(value2);
				if(Math.isNaN(val1)) val1 = 0;
				if(Math.isNaN(val2)) val2 = 0;

				isCameraOnForcedPos = false;
				if(!Math.isNaN(Std.parseFloat(value1)) || !Math.isNaN(Std.parseFloat(value2))) {
					camFollow.x = val1;
					camFollow.y = val2;
					isCameraOnForcedPos = true;
				}

			case 'Alt Idle Animation':
				var char:Character = dad;
				switch(value1.toLowerCase()) {
					case 'gf' | 'girlfriend':
						char = gf;
					case 'boyfriend' | 'bf':
						char = boyfriend;
					default:
						var val:Int = Std.parseInt(value1);
						if(Math.isNaN(val)) val = 0;

						switch(val) {
							case 1: char = boyfriend;
							case 2: char = gf;
						}
				}

				if (char != null)
				{
					char.idleSuffix = value2;
					char.recalculateDanceIdle();
				}

			case 'Screen Shake':
				var valuesArray:Array<String> = [value1, value2];
				var targetsArray:Array<FlxCamera> = [camGame, camHUD];
				for (i in 0...targetsArray.length) {
					var split:Array<String> = valuesArray[i].split(',');
					var duration:Float = 0;
					var intensity:Float = 0;
					if(split[0] != null) duration = Std.parseFloat(split[0].trim());
					if(split[1] != null) intensity = Std.parseFloat(split[1].trim());
					if(Math.isNaN(duration)) duration = 0;
					if(Math.isNaN(intensity)) intensity = 0;

					if(duration > 0 && intensity != 0) {
						targetsArray[i].shake(intensity, duration);
					}
				}


			case 'Change Character':
				var charType:Int = 0;
				switch(value1) {
					case 'gf' | 'girlfriend':
						charType = 2;
					case 'dad' | 'opponent':
						charType = 1;
					default:
						charType = Std.parseInt(value1);
						if(Math.isNaN(charType)) charType = 0;
				}

				switch(charType) {
					case 0:
						if(boyfriend.curCharacter != value2) {
							if(!boyfriendMap.exists(value2)) {
								addCharacterToList(value2, charType);
							}

							var lastAlpha:Float = boyfriend.alpha;
							boyfriend.alpha = 0.00001;
							boyfriend = boyfriendMap.get(value2);
							boyfriend.alpha = lastAlpha;
							
							if (!xenoEncUI) {
								if (FEHPThing == 2) {
									iconP1.changeIcon(boyfriend.healthIcon);
								} else {
									if (!AnimatedDadIcon) {
										if (!bfIsLeft) {
											iconP1.changeIcon(boyfriend.healthIcon);
										} else {
											iconP1.changeIcon(dad.healthIcon);
										}
									} else {
										if (!bfIsLeft) {
											iconP1.changeIcon(boyfriend.healthIcon);
										} else {
											iconP1.changeIconAnimated(dad.healthIcon);
										}
									}
								}
							} else {
								if (!AnimatedDadIcon) {
									if (!bfIsLeft) {
										iconP1.changeIcon(boyfriend.healthIcon);
										xenoEncIconP1.changeIcon(boyfriend.healthIcon);
									} else {
										iconP1.changeIcon(dad.healthIcon);
										xenoEncIconP1.changeIcon(dad.healthIcon);
									}
								} else {
									if (!bfIsLeft) {
										iconP1.changeIcon(boyfriend.healthIcon);
										xenoEncIconP1.changeIcon(boyfriend.healthIcon);
									} else {
										iconP1.changeIconAnimated(dad.healthIcon);
										xenoEncIconP1.changeIconAnimated(dad.healthIcon);
									}
								}
							}
						}
						setOnLuas('boyfriendName', boyfriend.curCharacter);
						curBF = value2;

					case 1:
						if(dad.curCharacter != value2) {
							if(!dadMap.exists(value2)) {
								addCharacterToList(value2, charType);
							}

							var wasGf:Bool = dad.curCharacter.startsWith('gf');
							var lastAlpha:Float = dad.alpha;
							dad.alpha = 0.00001;
							dad = dadMap.get(value2);
							if(!dad.curCharacter.startsWith('gf')) {
								if(wasGf && gf != null) {
									gf.visible = true;
								}
							} else if(gf != null) {
								gf.visible = false;
							}
							dad.alpha = lastAlpha;
							
							if (!xenoEncUI) {
								if (FEHPThing == 2) {
									iconP2.changeIcon(dad.healthIcon);
								} else {
									if (!AnimatedDadIcon) {
										if (!bfIsLeft) {
											iconP2.changeIcon(dad.healthIcon);
										} else {
											iconP2.changeIcon(boyfriend.healthIcon);
										}
									} else {
										if (!bfIsLeft) {
											iconP2.changeIconAnimated(dad.healthIcon);
										} else {
											iconP2.changeIcon(boyfriend.healthIcon);
										}
									}
								}
							} else {
								if (!AnimatedDadIcon) {
									if (!bfIsLeft) {
										iconP2.changeIcon(dad.healthIcon);
										xenoEncIconP2.changeIcon(dad.healthIcon);
									} else {
										iconP2.changeIcon(boyfriend.healthIcon);
										xenoEncIconP2.changeIcon(boyfriend.healthIcon);
									}
								} else {
									if (!bfIsLeft) {
										iconP2.changeIconAnimated(dad.healthIcon);
										xenoEncIconP2.changeIconAnimated(dad.healthIcon);
									} else {
										iconP2.changeIcon(boyfriend.healthIcon);
										xenoEncIconP2.changeIcon(boyfriend.healthIcon);
									}
								}
							}
						}
						setOnLuas('dadName', dad.curCharacter);
						curDAD = value2;

					case 2:
						if(gf != null)
						{
							if(gf.curCharacter != value2)
							{
								if(!gfMap.exists(value2))
								{
									addCharacterToList(value2, charType);
								}

								var lastAlpha:Float = gf.alpha;
								gf.alpha = 0.00001;
								gf = gfMap.get(value2);
								gf.alpha = lastAlpha;
							}
							setOnLuas('gfName', gf.curCharacter);
							curGF = value2;
						}
				}
				reloadHealthBarColors();
			
			case 'BG Freaks Expression':
				if(bgGirls != null) bgGirls.swapDanceType();
			
			case 'Change Scroll Speed':
				if (songSpeedType == "constant")
					return;
				var val1:Float = Std.parseFloat(value1);
				var val2:Float = Std.parseFloat(value2);
				if(Math.isNaN(val1)) val1 = 1;
				if(Math.isNaN(val2)) val2 = 0;

				var newValue:Float = SONG.speed * ClientPrefs.getGameplaySetting('scrollspeed', 1) * val1;

				if(val2 <= 0)
				{
					songSpeed = newValue;
				}
				else
				{
					songSpeedTween = FlxTween.tween(this, {songSpeed: newValue}, val2, {ease: FlxEase.linear, onComplete:
						function (twn:FlxTween)
						{
							songSpeedTween = null;
						}
					});
				}
				
			case 'HUD opaticity':
				var alpha:Float = Std.parseFloat(value1);
				var time:Float = Std.parseFloat(value2);
				FlxTween.tween(camHUD, {alpha: alpha}, time);
			case 'Chroma Video':
				if(ClientPrefs.Shaders)chromaVideo(value1);

			case 'Genesis':
				var value:Int = Std.parseInt(value1);
				if (Math.isNaN(value))
					value = 0;

				var GFSkin:String = SONG.gfSkin;
				var GFNumber:Int = ClientPrefs.GFSkin;
				switch (GFNumber)
				{
					case 0:
						if (!isEncore) GFSkin = 'gf';
						if (isEncore) GFSkin = 'GF_hedhehog';
					case 1:
						GFSkin = 'GF_hedhehog';
					case 2:
						GFSkin = 'Encore-HoggedGF';
					case 3:
						GFSkin = 'Encore-LobsterGF';
					case 4:
						GFSkin = 'Encore-AmongGF';
					case 5:
						GFSkin = 'Encore-FakeGF';
					case 6:
						GFSkin = 'Encore-FatalGF';
					case 7:
						GFSkin = 'Encore-GFCat';
					case 8:
						GFSkin = 'Encore-RougeGF';
					case 9:
						GFSkin = 'Encore-HyperGF';
					case 10:
						GFSkin = 'Encore-SarahGF';
					case 11:
						GFSkin = 'Encore-HogGF';
					case 12:
						GFSkin = 'sunky_gf';
					case 13:
						GFSkin = 'dj-exe';
					case 14:
						GFSkin = 'Encore-GFHog';
				}

				switch (value) {
					case 1:
						if (SONG.song.toLowerCase() != 'you-cant-run' && SONG.song.toLowerCase() != 'our-horizon')
							defaultCamZoom = 0.9;
						if (!xenoEncFix) {
							scoreTxt.visible=false;
							timeBar.visible=false;
							timeBarBG.visible=false;
							if (bgTBSkin == 'tbR') timeBarBGBG.visible=false;
						}
						timeTxt.visible=false;

						removeStatics();
						generateStaticArrows(0);
						generateStaticArrows(1);
						sonicHUD.visible=true;
						pixelNoteGenesis = true;
						if (noteChangesFromTheStore)
							noteChangesFromTheStore = false;
						
						switch (SONG.song.toLowerCase())
						{
							case 'final-escape':
								if (boyfriend.curCharacter != 'bfpickel')
								{
									if (!boyfriendMap.exists('bfpickel'))
									{
										addCharacterToList('bfpickel', 0);
									}

									boyfriend.visible = false;
									boyfriend = boyfriendMap.get('bfpickel');
									boyfriend.alpha = 1;
									boyfriend.visible = true;
									iconP1.changeIcon(boyfriend.healthIcon);
									curBF = 'bfpickel';
								}
								if (dad.curCharacter != 'xeno-fake-fe-pixel')
								{
									if (!dadMap.exists('xeno-fake-fe-pixel'))
									{
										addCharacterToList('xeno-fake-fe-pixel', 1);
									}

									dad.visible = false;
									dad = dadMap.get('xeno-fake-fe-pixel');
									dad.alpha = 1;
									dad.visible = true;
									iconP2.changeIcon(dad.healthIcon);
									curDAD = 'xeno-fake-fe-pixel';
								}
								
							case 'you-cant-run-encore':
								if (xenoEncFix) {
									xenoEncUI = false;
									healthBarBG.visible = true;
									healthBar.visible = true;
									iconP1.visible = true;
									iconP2.visible = true;
									xenoEncUIthing.visible = false;
									scoreTxt.visible = false;
									xenoEncMissesTxt.visible = false;
									xenoEncHealthBar.visible = false;
									xenoEncIconP1.visible = false;
									xenoEncIconP2.visible = false;
									xenoEncHP.visible = false;
								}
								if (boyfriend.curCharacter != 'bf-pixel-sonic')
								{
									if (!boyfriendMap.exists('bf-pixel-sonic'))
									{
										addCharacterToList('bf-pixel-sonic', 0);
									}

									boyfriend.visible = false;
									boyfriend = boyfriendMap.get('bf-pixel-sonic');
									boyfriend.alpha = 1;
									boyfriend.visible = true;
									iconP1.changeIcon(boyfriend.healthIcon);
									if (xenoEncFix) xenoEncIconP1.changeIcon(boyfriend.healthIcon);
									curBF = 'bf-pixel-sonic';
								}
								if (gf.curCharacter != 'pixelrunsonic-encore')
								{
									if (!gfMap.exists('pixelrunsonic-encore'))
									{
										addCharacterToList('pixelrunsonic-encore', 2);
									}

									gf.visible = false;
									gf = gfMap.get('pixelrunsonic-encore');
									gf.alpha = 1;
									curGF = 'pixelrunsonic-encore';
								}
								if (dad.curCharacter != 'ycr-sonic-encore')
								{
									if (!dadMap.exists('ycr-sonic-encore'))
									{
										addCharacterToList('ycr-sonic-encore', 1);
									}

									dad.visible = false;
									dad = dadMap.get('ycr-sonic-encore');
									dad.alpha = 1;
									dad.visible = true;
									iconP2.changeIcon(dad.healthIcon);
									if (xenoEncFix) xenoEncIconP2.changeIcon(dad.healthIcon);
									curDAD = 'ycr-sonic-encore';
								}
								
							default:
								if (SONG.song.toLowerCase() != 'you-cant-run' && SONG.song.toLowerCase() != 'our-horizon') {
									if (boyfriend.curCharacter != 'bfpickel')
									{
										if (!boyfriendMap.exists('bfpickel'))
										{
											addCharacterToList('bfpickel', 0);
										}

										boyfriend.visible = false;
										boyfriend = boyfriendMap.get('bfpickel');
										boyfriend.alpha = 1;
										boyfriend.visible = true;
										if (!xenoEncUI) {
											iconP1.changeIcon(boyfriend.healthIcon);
										} else {
											iconP1.changeIcon(boyfriend.healthIcon);
											if (xenoEncFix) xenoEncIconP1.changeIcon(boyfriend.healthIcon);
										}
										curBF = 'bfpickel';
									}
									if (gf.curCharacter != 'gf-pixel')
									{
										if (!gfMap.exists('gf-pixel'))
										{
											addCharacterToList('gf-pixel', 2);
										}

										gf.visible = false;
										gf = gfMap.get('gf-pixel');
										gf.alpha = 1;
										curGF = 'gf-pixel';
									}
									if (dad.curCharacter != 'pixelrunsonic')
									{
										if (!dadMap.exists('pixelrunsonic'))
										{
											addCharacterToList('pixelrunsonic', 1);
										}

										dad.visible = false;
										dad = dadMap.get('pixelrunsonic');
										dad.alpha = 1;
										dad.visible = true;
										if (!xenoEncUI) {
											iconP2.changeIcon(dad.healthIcon);
										} else {
											iconP2.changeIcon(dad.healthIcon);
											if (xenoEncFix) xenoEncIconP2.changeIcon(dad.healthIcon);
										}
										curDAD = 'pixelrunsonic';
									}
								}
						}
						
						if (SONG.song.toLowerCase() != 'you-cant-run' && SONG.song.toLowerCase() != 'our-horizon') {
							dad.setPosition(70, 350);
							dad.y -= 155;
							boyfriend.setPosition(530 + 100, 170 + 200);
							if (SONG.song.toLowerCase() != 'you-cant-run-encore')
							{
								gf.x = 400;
								gf.y = 130;
							}
						}
						reloadHealthBarColors();
						
						healthBar.x += 150;
						iconP1.x += 150;
						iconP2.x += 150;
						healthBarBG.x += 150;
						
					case 2:
						scoreTxt.visible = !ClientPrefs.hideHud;
						if (ClientPrefs.timeBarType != 'Disabled') {
							if (!xenoEncFix) {
								timeBar.visible = true;
								timeBarBG.visible = true;
								if (bgTBSkin == 'tbR') timeBarBGBG.visible = true;
							}
							timeTxt.visible = true;
						}
						sonicHUD.visible=false;
						if (SONG.song.toLowerCase() != 'you-cant-run' && SONG.song.toLowerCase() != 'our-horizon')
							defaultCamZoom = 0.65;
						removeStatics();
						generateStaticArrows(0);
						generateStaticArrows(1);
						pixelNoteGenesis = false;
						if (!noteChangesFromTheStore)
							noteChangesFromTheStore = true;
						
						switch (SONG.song.toLowerCase()) {
							case 'final-escape':
								if (boyfriend.curCharacter != 'bf-fe-p2')
								{
									if (!boyfriendMap.exists('bf-fe-p2'))
									{
										addCharacterToList('bf-fe-p2', 0);
									}

									boyfriend.visible = false;
									boyfriend = boyfriendMap.get('bf-fe-p2');
									boyfriend.alpha = 1;
									boyfriend.visible = true;
									iconP1.changeIcon(boyfriend.healthIcon);
									curBF = 'bf-fe-p2';
								}
						
							case 'you-cant-run-encore':
								if (xenoEncFix) {
									xenoEncUI = true;
									healthBarBG.visible = false;
									healthBar.visible = false;
									iconP1.visible = false;
									iconP2.visible = false;

									xenoEncUIthing.visible = true;
									scoreTxt.visible = true;
									xenoEncMissesTxt.visible = true;
									xenoEncHealthBar.visible = true;
									xenoEncIconP1.visible = true;
									xenoEncIconP2.visible = true;
									xenoEncHP.visible = true;
								}
								if (boyfriend.curCharacter != 'bf-encore')
								{
									if (!boyfriendMap.exists('bf-encore'))
									{
										addCharacterToList('bf-encore', 0);
									}

									boyfriend.visible = false;
									boyfriend = boyfriendMap.get('bf-encore');
									boyfriend.alpha = 1;
									boyfriend.visible = true;
									iconP1.changeIcon(boyfriend.healthIcon);
									if (xenoEncFix) xenoEncIconP1.changeIcon(boyfriend.healthIcon);
									curBF = 'bf-encore';
								}
								if (gf.curCharacter != GFSkin)
								{
									if (!gfMap.exists(GFSkin))
									{
										addCharacterToList(GFSkin, 2);
									}

									gf.visible = false;
									gf = gfMap.get(GFSkin);
									gf.alpha = 1;
									curGF = GFSkin;
								}
								if (dad.curCharacter != 'ycr-mad-cherribun')
								{
									if (!dadMap.exists('ycr-mad-cherribun'))
									{
										addCharacterToList('ycr-mad-cherribun', 1);
									}

									dad.visible = false;
									dad = dadMap.get('ycr-mad-cherribun');
									dad.alpha = 1;
									dad.visible = true;
									iconP2.changeIcon(dad.healthIcon);
									if (xenoEncFix) xenoEncIconP2.changeIcon(dad.healthIcon);
									curDAD = 'ycr-mad-cherribun';
								}
							
							default:
								if (SONG.song.toLowerCase() != 'you-cant-run' && SONG.song.toLowerCase() != 'our-horizon') {
									if (boyfriend.curCharacter != 'bf')
									{
										if (!boyfriendMap.exists('bf'))
										{
											addCharacterToList('bf', 0);
										}

										boyfriend.visible = false; 
										boyfriend = boyfriendMap.get('bf');
										boyfriend.alpha = 1;
										boyfriend.visible = true;
										if (!xenoEncUI) {
											iconP1.changeIcon(boyfriend.healthIcon);
										} else {
											iconP1.changeIcon(boyfriend.healthIcon);
											if (xenoEncFix) xenoEncIconP1.changeIcon(boyfriend.healthIcon);
										}
										curBF = 'bf';
									}
									if (gf.curCharacter != 'gf')
									{
										if (!gfMap.exists('gf'))
										{
											addCharacterToList('gf', 2);
										}

										gf.visible = false;
										gf = gfMap.get('gf');
										gf.alpha = 1;
										curGF = 'gf';
									}
									if (dad.curCharacter != 'ycr-mad')
									{
										if (!dadMap.exists('ycr-mad'))
										{
											addCharacterToList('ycr-mad', 1);
										}

										dad.visible = false;
										dad = dadMap.get('ycr-mad');
										dad.alpha = 1;
										dad.visible = true;
										if (!xenoEncUI) {
											iconP2.changeIcon(dad.healthIcon);
										} else {
											iconP2.changeIcon(dad.healthIcon);
											if (xenoEncFix) xenoEncIconP2.changeIcon(dad.healthIcon);
										}
										curDAD = 'ycr-mad';
									}
								}
						}
						reloadHealthBarColors();
						
						healthBar.x -= 150;
						iconP1.x -= 150;
						iconP2.x -= 150;
						healthBarBG.x -= 150;

						updateCamFollow();
						camFollowPos.setPosition(camFollow.x, camFollow.y);
				}
				noteGenesis = value;
			case 'RedVG':
				switch (value1) {
					case '0':
						FlxTween.cancelTweensOf(RedVGEvent);
						FlxTween.tween(RedVGEvent, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(sus:FlxTween){
							RedVGEvent.destroy();
						}});
					default:
						if (RedVGEvent != null) {
							FlxTween.cancelTweensOf(RedVGEvent);
							FlxTween.tween(RedVGEvent, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut, onComplete: function(sus:FlxTween){
								RedVGEvent.destroy();
								if (value2.length <= 9) {
									RedVGEvent = new FlxSprite().loadGraphic(Paths.image('RedVG', 'exe'));
								} else {
									if (value2.length == 10) {
										RedVGEvent = new FlxSprite().loadGraphic(Paths.image('WhiteVG', 'exe'));
										RedVGEvent.color = Std.parseInt(value2);
									}
								}
								if (SONG.song.toLowerCase() != 'you-cant-run-encore')
									RedVGEvent.cameras = [camHUD];
								else
									RedVGEvent.cameras = [camOther];
								RedVGEvent.alpha = 0;
								add(RedVGEvent);
								FlxTween.tween(RedVGEvent, {alpha: 1}, 0.85, {type: FlxTweenType.PINGPONG});
							}});
						} else {
							if (value2.length <= 9) {
								RedVGEvent = new FlxSprite().loadGraphic(Paths.image('RedVG', 'exe'));
							} else {
								if (value2.length == 10) {
									RedVGEvent = new FlxSprite().loadGraphic(Paths.image('WhiteVG', 'exe'));
									RedVGEvent.color = Std.parseInt(value2);
								}
							}
							if (SONG.song.toLowerCase() != 'you-cant-run-encore')
								RedVGEvent.cameras = [camHUD];
							else
								RedVGEvent.cameras = [camOther];
							RedVGEvent.alpha = 0;
							add(RedVGEvent);
							FlxTween.tween(RedVGEvent, {alpha: 1}, 0.85, {type: FlxTweenType.PINGPONG});
						}
				}
			case 'static':
				doStaticSign(0, false);

			case 'TooSlowFlashinShit':
				switch (Std.parseFloat(value1))
				{
					case 1:
						doStaticSign(0);
					case 2:
						doSimpleJump();
				}

			case 'strum swap1':
				if (!ClientPrefs.middleScroll) {
					playerStrums.forEach(function(spr:FlxSprite)
					{
						spr.x -= 645;
					});
					opponentStrums.forEach(function(spr:FlxSprite)
					{
						spr.x += 645;
					});
				}
				bfIsLeft = true;
				iconP1.changeIcon(dad.healthIcon);
				iconP2.changeIcon(boyfriend.healthIcon);
				if (xenoEncUI) {
					xenoEncIconP1.changeIcon(dad.healthIcon);
					xenoEncIconP2.changeIcon(boyfriend.healthIcon);
				}
				reloadHealthBarColors();
				
			case 'strum swap2':
				if (!ClientPrefs.middleScroll) {
					playerStrums.forEach(function(spr:FlxSprite)
					{
						spr.x += 645;
					});
					opponentStrums.forEach(function(spr:FlxSprite)
					{
						spr.x -= 645;
					});
				}
				bfIsLeft = false;
				iconP1.changeIcon(dad.healthIcon);
				iconP2.changeIcon(boyfriend.healthIcon);
					if (xenoEncUI) {
					xenoEncIconP2.changeIcon(dad.healthIcon);
					xenoEncIconP1.changeIcon(boyfriend.healthIcon);
				}
				reloadHealthBarColors();

			case 'Character Fly':
				flyState = '';
				FlxTween.tween(dad, {x: DAD_X, y: DAD_Y}, 0.2, {
					onComplete: function(lol:FlxTween)
					{
						dad.setPosition(DAD_X, DAD_Y);
						flyState = value1;
					}
				});

			case 'spingbing':
				var sponge:FlxSprite = new FlxSprite(dad.getGraphicMidpoint().x - 100,
					dad.getGraphicMidpoint().y - 120).loadGraphic(Paths.image('SpingeBinge', 'exe'));

				add(sponge);

				dad.visible = false;

				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					remove(sponge);
					dad.visible = true;
				});

			case 'sonicspook':
				daJumpscare = new FlxSprite();
				daJumpscare.frames = Paths.getSparrowAtlas('sonicJUMPSCARE', 'exe');
				daJumpscare.animation.addByPrefix('jump', "sonicSPOOK", 24, false);
				daJumpscare.animation.play('jump',true);
				daJumpscare.scale.x = 1.1;
				daJumpscare.scale.y = 1.1;
				daJumpscare.updateHitbox();
				daJumpscare.screenCenter();
				daJumpscare.y += 370;
				daJumpscare.cameras = [camOther];

				FlxG.sound.play(Paths.sound('jumpscare', 'exe'), 1);
				FlxG.sound.play(Paths.sound('datOneSound', 'exe'), 1);

				add(daJumpscare);

				daJumpscare.animation.play('jump');

				daJumpscare.animation.finishCallback = function(pog:String)
				{
					trace('ended jump');
					daJumpscare.visible = false;
				}

			case 'char disappear':
				boyfriend.visible = false;

			case 'char appear':
				boyfriend.visible = true;

			case 'Pnotefade':
				playerStrums.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
				});
				switch (Std.parseInt(value1))
				{
					case 1:
						FlxTween.tween(healthBarBG, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
						FlxTween.tween(healthBar, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
						FlxTween.tween(iconP1, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
						FlxTween.tween(iconP2, {alpha: 0}, 0.2, {ease: FlxEase.sineOut});
					default:
				}
			case 'Pnotein':
				playerStrums.forEach(function(spr:FlxSprite)
				{
					FlxTween.tween(spr, {alpha: 1}, 0.1, {ease: FlxEase.sineIn});
				});
				switch (Std.parseInt(value1))
				{
					case 1:
						FlxTween.tween(healthBarBG, {alpha: 1}, 0.1, {ease: FlxEase.sineIn});
						FlxTween.tween(healthBar, {alpha: 1}, 0.1, {ease: FlxEase.sineIn});
						FlxTween.tween(iconP1, {alpha: 1}, 0.1, {ease: FlxEase.sineIn});
						FlxTween.tween(iconP2, {alpha: 1}, 0.1, {ease: FlxEase.sineIn});
					default:
				}
			case 'TDnoteshitdie':
				new FlxTimer().start(0.05, function(tmr:FlxTimer) {
					if (!ClientPrefs.middleScroll) {
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.x -= 315;
						});
					}
					opponentStrums.forEach(function(spr:FlxSprite)
					{
						spr.x -= 1000;
					});
				});

			case 'TDnoteshitlive':
				new FlxTimer().start(0.05, function(tmr:FlxTimer) {
					if (!ClientPrefs.middleScroll) {
						playerStrums.forEach(function(spr:FlxSprite)
						{
							FlxTween.tween(spr, {alpha: 1}, 0.4, {ease: FlxEase.circOut});
							spr.x += 315;
						});
					}
					opponentStrums.forEach(function(spr:FlxSprite)
					{
						spr.x += 1000;
					});
				});
				
			case 'funnystatic':
				var daP3Static:FlxSprite = new FlxSprite(0, 0);
				daP3Static.frames = Paths.getSparrowAtlas('Phase3Static', 'exe');
				daP3Static.animation.addByPrefix('P3Static', 'Phase3Static instance 1', 24, false);
				daP3Static.screenCenter();

				daP3Static.scale.x = 4;
				daP3Static.scale.y = 4;
				daP3Static.alpha = 0.5;

				daP3Static.cameras = [camHUD];
				add(daP3Static);
				daP3Static.animation.play('P3Static');

				daP3Static.animation.finishCallback = function(pog:String)
				{
					daP3Static.alpha = 0;

					remove(daP3Static);
				}

			case 'startstatic':
				goofyAhhStatic();

			case 'Clear Popups':
				while(FatalPopup.popups.length>0)
					FatalPopup.popups[0].close();
			case 'Fatality Popup':
				var value:Int = Std.parseInt(value1);
				if (Math.isNaN(value) || value<1)
					value = 1;

				var type:Int = Std.parseInt(value2);
				if (Math.isNaN(type) || type<1)
					type = 1;
				for(idx in 0...value){
					doPopup(type);
				}

			case 'tailsjump':
				spookyJumpscareAAA("tails");
				
			case 'knuxjump':
				spookyJumpscareAAA("knux");
				
			case 'eggjump':
				spookyJumpscareAAA("egg");
				
			case 'tdjump':
				spookyJumpscareAAA("td");
				
			case 'nmijump':
				spookyJumpscareAAA("nmi");
				
			case 'melthogjump':
				spookyJumpscareAAA("melthog");
				
			case 'amyjump':
				spookyJumpscareAAA("amy");
				
			case 'wechidnajump':
				spookyJumpscareAAA("wechidna");

			case 'Majin count':
				switch (Std.parseFloat(value1))
				{
					case 1:
						inCutscene = true;
						camFollow.set(FlxG.width / 2 + 50, FlxG.height / 4 * 3 + 280);
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
						majinSaysFuck(4);
					case 2:
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
						majinSaysFuck(3);
					case 3:
						FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
						majinSaysFuck(2);
					case 4:
						inCutscene = false;
						FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.7, {ease: FlxEase.cubeInOut});
						majinSaysFuck(1);
					}
			case 'Majin spin':
				strumLineNotes.forEach(function(tospin:FlxSprite)
					{
						FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
					});
					
			case 'Lyrics':
				var split = value1.split("--");
				var text = value1;
				var color = FlxColor.WHITE;
				if(split.length > 1){
					text = split[0];
					color = FlxColor.fromString(split[1]);
				}
				var duration:Float = Std.parseFloat(value2);
				if (Math.isNaN(duration) || duration <= 0)
					duration = text.length * 0.5;

				writeLyrics(text, duration, color);
				
			case 'Song Speed Change':
				var val1:Float = Std.parseFloat(value1);
				var val2:Float = Std.parseFloat(value2);
				if(Math.isNaN(val1)) val1 = 1;
				if(Math.isNaN(val2)) val2 = 0;

				var newValue:Float = SONG.speed * val1;

				if(val2 <= 0)
				{
					songSpeed = newValue;
				}
				else
				{
					songSpeedTween = FlxTween.tween(this, {songSpeed: newValue}, val2, {ease: FlxEase.linear, onComplete:
						function (twn:FlxTween)
						{
							songSpeedTween = null;
						}
					});
				}
			
			case 'Cool Bars':
				var sus:String = value1;
				if (sus == '0') {
					cinematicBars(false);
				}
				if (sus == '1') {
					cinematicBars(true);
				}
				
			case 'glitch':
				glitchFreeze();
			case 'XenoFix':
				timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
				TimeBarColorOne = 0x00D416E3;
				TimeBarColorTwo = 0xFFD416E3;
				if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
				if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
				timeBar.updateBar();
				superZoomShit = false;
				defaultCamZoom = 0.9;
			case 'Change Windows Wallpaper':
				#if windows
				var wallpaperImage:String = value1;
				Sys.command('${Sys.getCwd()}\\assets\\exe\\open-cw.bat', ['${Sys.getCwd()}\\assets\\exe\\open-cw.bat', wallpaperImage + '.png']);
				#end
		}
		callOnLuas('onEvent', [eventName, value1, value2]);
	}

	function moveCameraSection(?id:Int = 0):Void {
		if(SONG.notes[id] == null) return;

		if (gf != null && SONG.notes[id].gfSection)
		{
			camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
			camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0];
			camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1];
			tweenCamIn();
			callOnLuas('onMoveCamera', ['gf']);
			return;
		}

		if (!SONG.notes[id].mustHitSection)
		{
			moveCamera(true);
			callOnLuas('onMoveCamera', ['dad']);
		}
		else
		{
			moveCamera(false);
			callOnLuas('onMoveCamera', ['boyfriend']);
		}
	}

	var cameraTwn:FlxTween;
	public function moveCamera(isDad:Bool)
	{
		if(isDad)
		{
			camFollow.set(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
			camFollow.x += dad.cameraPosition[0] + opponentCameraOffset[0];
			camFollow.y += dad.cameraPosition[1] + opponentCameraOffset[1];
			tweenCamIn();
		}
		else
		{
			camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
			camFollow.x -= boyfriend.cameraPosition[0] - boyfriendCameraOffset[0];
			camFollow.y += boyfriend.cameraPosition[1] + boyfriendCameraOffset[1];
			if (Paths.formatToSongPath(SONG.song) == 'tutorial' && cameraTwn == null && FlxG.camera.zoom != 1)
			{
				cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut, onComplete:
					function (twn:FlxTween)
					{
						cameraTwn = null;
					}
				});
			}
		}
	}

	public function moveCameraOnNote(isDad:Bool, ?direction:String = "")
	{
		var addX:Float = 0;
		var addY:Float = 0;
		if (direction.endsWith("UP")) 
			addY -= 20;
		if (direction.endsWith("DOWN")) 
			addY += 20;
		if (direction.endsWith("LEFT")) 
			addX -= 20;
		if (direction.endsWith("RIGHT")) 
			addX += 20;

		if(isDad)
		{
			var gfSec = SONG.notes[Math.floor(curStep / 16)].gfSection;
			if (gfSec) {
				if (gf != null) {
					camFollow.set(gf.getMidpoint().x, gf.getMidpoint().y);
					camFollow.x += gf.cameraPosition[0] + girlfriendCameraOffset[0] + addX;
					camFollow.y += gf.cameraPosition[1] + girlfriendCameraOffset[1] + addY;
				}
			} else {
				camFollow.set(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
				camFollow.x += dad.cameraPosition[0] + opponentCameraOffset[0] + addX;
				camFollow.y += dad.cameraPosition[1] + opponentCameraOffset[1] + addY;
			}
		}
		else
		{
			camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
			camFollow.x -= boyfriend.cameraPosition[0] - boyfriendCameraOffset[0] - addX;
			camFollow.y += boyfriend.cameraPosition[1] + boyfriendCameraOffset[1] + addY;
		}
	}

	function laserThingy()
	{	
		dodgething.visible = true;
		dodgething.animation.play('a', true);
		GameOverSubstate.characterName = 'bf-fleetway-die';
		GameOverSubstate.deathSoundName = 'fleetway-laser';
		GameOverSubstate.loopSoundName = 'fleetway-gameover';
		GameOverCameraMove = false;
		
		new FlxTimer().start(0.5, function(a:FlxTimer)
		{
			triggerEventNote('Change Character', '1', 'fleetwaylaser');
			triggerEventNote('Play Animation', 'laser', 'Dad');
		});

		new FlxTimer().start(0.90, function(a:FlxTimer)
		{
			tailscircle = '';
			new FlxTimer().start(0.2, function(a:FlxTimer) {
				if (!dodging) MechanicBFDie = true;
				new FlxTimer().start(0.1, function(a:FlxTimer) { canDodge = true; });
			});
			new FlxTimer().start(0.3, function(a:FlxTimer)
			{
				tailscircle = 'hovering';
				dodgething.visible = false;
				triggerEventNote('Change Character', '1', 'fleetway');
				GameOverSubstate.characterName = 'bf';
				GameOverSubstate.deathSoundName = 'fleetway-death';
				GameOverSubstate.loopSoundName = 'fleetway-gameover';
				GameOverSubstate.endSoundName = 'fleetway-retry';
				GameOverCameraMove = true;
			});
		});
	}

	function SlashMechaic()
	{	
		warning.visible = true;
		warning.animation.play('warn', false);
		FlxG.sound.play(Paths.sound('sl4sh/slashwarning-1', 'exe'), 0.3);
		new FlxTimer().start(0.3, function(warnTwo:FlxTimer)
		{
			warning.animation.play('warn', false);
			FlxG.sound.play(Paths.sound('sl4sh/slashwarning-2', 'exe'), 0.3);
			new FlxTimer().start(0.3, function(warnThree:FlxTimer)
			{
				warning.animation.play('warn', false);
				FlxG.sound.play(Paths.sound('sl4sh/slashwarning-2', 'exe'), 0.3);
				new FlxTimer().start(0.3, function(warnThree:FlxTimer)
				{
					warning.animation.play('warn', false);
					FlxG.sound.play(Paths.sound('sl4sh/slashwarning-2', 'exe'), 0.3);
					new FlxTimer().start(0.3, function(Attack:FlxTimer)
					{
						triggerEventNote('Play Animation', 'attack', 'Dad');
						FlxG.sound.play(Paths.sound('sl4sh/slashslash', 'exe'), 0.2);
						new FlxTimer().start(0.2, function(HP:FlxTimer)
						{
							warning.visible = false;
							if (!dodging) {
								FlxG.sound.play(Paths.sound('sl4sh/slashhit', 'exe'), 0.6);
								health -= 0.4;
								new FlxTimer().start(0.1, function(cantdodge:FlxTimer) { canDodge = false; });
							} else {
								FlxG.sound.play(Paths.sound('sl4sh/slashmiss', 'exe'), 0.45);
							}
						});
					});
				});
			});
		});
	}

	function cinematicBars(appear:Bool)
	{
		if (SONG.song.toLowerCase() == 'you-cant-run-encore')
		{
			if (appear)
			{
				topBar.alpha = 1;
				bottomBar.alpha = 1;
				FlxTween.tween(topBar, {y: -70}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(bottomBar, {y: 620}, 0.5, {ease: FlxEase.quadOut});
			}
			else
			{
				FlxTween.tween(topBar, {y: -170}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(bottomBar, {y: 720}, 0.5, {ease: FlxEase.quadOut, onComplete: function(fuckme:FlxTween)
				{
					topBar.alpha = 0;
					bottomBar.alpha = 0;
				}});
			}
		} else {
			if (appear)
			{
				add(topBar);
				add(bottomBar);
				FlxTween.tween(topBar, {y: 0}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(bottomBar, {y: 550}, 0.5, {ease: FlxEase.quadOut});
			}
			else
			{
				FlxTween.tween(topBar, {y: -170}, 0.5, {ease: FlxEase.quadOut});
				FlxTween.tween(bottomBar, {y: 720}, 0.5, {ease: FlxEase.quadOut, onComplete: function(fuckme:FlxTween)
				{
					remove(topBar);
					remove(bottomBar);
				}});
			}
		}
	}

	var lyricText:FlxText;
	var lyricTween:FlxTween;

	function writeLyrics(text:String, duration:Float, color:FlxColor)
	{
		if(lyricText!=null){
			var old:FlxText = cast lyricText;
			FlxTween.tween(old, {alpha: 0}, 0.2, {onComplete: function(twn:FlxTween)
			{
				remove(old);
				old.destroy();
			}});
			lyricText=null;
		}
		if(lyricTween!=null){
			lyricTween.cancel();
			lyricTween=null;
		}
		if(text.trim()!='' && duration>0 && color.alphaFloat>0){
			lyricText = new FlxText(0, 0, FlxG.width, text);
			lyricText.setFormat(Paths.font("PressStart2P.ttf"), 24, color, CENTER, OUTLINE, FlxColor.BLACK);
			lyricText.alpha = 0;
			lyricText.screenCenter(XY);
			if (SONG.song.toLowerCase() == 'you-cant-run-encore')
				lyricText.y += 320;
			else
				lyricText.y += 250;
			lyricText.cameras = [camOther];
			add(lyricText);
			if (TranslationLanguages.Text.exists(lyricText.text) && ClientPrefs.Language != 'English')
				lyricText.text = TranslationLanguages.Text[lyricText.text];
			lyricTween = FlxTween.tween(lyricText, {alpha: color.alphaFloat}, 0.2, {onComplete: function(twn:FlxTween)
			{
				trace("done");
				lyricTween = FlxTween.tween(lyricText, {alpha: 0}, 0.2, {startDelay: duration, onComplete: function(twn:FlxTween)
				{
					remove(lyricText);
					lyricText.destroy();
					lyricText = null;
					if(lyricTween==twn)lyricTween = null;
				}});
			}});
		}
	}

	function spookyJumpscareAAA(char:String)
	{
		switch (char)
		{
			case "tails":
				var doP3JumpTAILS:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Tails' + (ClientPrefs.gore==false?"NoGore":""), 'exe'));
				doP3JumpTAILS.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpTAILS.screenCenter();
				doP3JumpTAILS.cameras = [camHUD];
				doP3JumpTAILS.scale.x = 1.25;
				doP3JumpTAILS.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpTAILS);
				FlxG.sound.play(Paths.sound('P3Jumps/TailsScreamLOL', 'exe'), .1);

				FlxTween.tween(doP3JumpTAILS, {alpha: 0}, .5, {
				});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpTAILS);
				});
				
			case "knux":
				var doP3JumpKNUX:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Knuckles' + (ClientPrefs.gore==false?"NoGore":""), 'exe'));
				doP3JumpKNUX.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpKNUX.screenCenter();
				doP3JumpKNUX.cameras = [camHUD];
				doP3JumpKNUX.scale.x = 1.25;
				doP3JumpKNUX.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpKNUX);
				FlxG.sound.play(Paths.sound('P3Jumps/KnucklesScreamLOL', 'exe'), .1);
				FlxTween.tween(doP3JumpKNUX, {alpha: 0}, .5, {
				});
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpKNUX);
				});
				
			case "egg":
				var doP3JumpEGG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Eggman' + (ClientPrefs.gore==false?"NoGore":""), 'exe'));
				doP3JumpEGG.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpEGG.screenCenter();
				doP3JumpEGG.cameras = [camHUD];
				doP3JumpEGG.scale.x = 1.25;
				doP3JumpEGG.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpEGG);
				FlxG.sound.play(Paths.sound('P3Jumps/EggmanScreamLOL', 'exe'), .1);

				FlxTween.tween(doP3JumpEGG, {alpha: 0}, .5, {
				});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpEGG);
				});

			case "td":
				var doP3JumpTD:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/TailsDoll', 'exe'));
				doP3JumpTD.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpTD.screenCenter();
				doP3JumpTD.cameras = [camHUD];
				doP3JumpTD.scale.x = 1.25;
				doP3JumpTD.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpTD);
				FlxG.sound.play(Paths.sound('P3Jumps/TailsScreamLOL', 'exe'), .1);

				FlxTween.tween(doP3JumpTD, {alpha: 0}, 0.5, {
				});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpTD);
				});
				
			case "nmi":
				var doP3JumpTD:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/NMI', 'exe'));
				doP3JumpTD.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpTD.screenCenter();
				doP3JumpTD.cameras = [camHUD];
				doP3JumpTD.scale.x = 1.25;
				doP3JumpTD.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpTD);

				FlxTween.tween(doP3JumpTD, {alpha: 0}, 0.5, {
				});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpTD);
				});
				
			case "melthog":
				var doP3JumpTD:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Melthog', 'exe'));
				doP3JumpTD.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpTD.screenCenter();
				doP3JumpTD.cameras = [camHUD];
				doP3JumpTD.scale.x = 1.25;
				doP3JumpTD.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpTD);

				FlxTween.tween(doP3JumpTD, {alpha: 0}, 0.5, {});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpTD);
				});
				
			case "amy":
				var doP3JumpTD:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/Amy' + (ClientPrefs.gore==false?"NoGore":""), 'exe'));
				doP3JumpTD.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpTD.screenCenter();
				doP3JumpTD.cameras = [camHUD];
				doP3JumpTD.scale.x = 1.25;
				doP3JumpTD.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpTD);

				FlxTween.tween(doP3JumpTD, {alpha: 0}, 0.5, {});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpTD);
				});
				
			case "wechidna":
				var doP3JumpTD:FlxSprite = new FlxSprite().loadGraphic(Paths.image('JUMPSCARES/wechidna', 'exe'));
				doP3JumpTD.setGraphicSize(FlxG.width, FlxG.height);
				doP3JumpTD.screenCenter();
				doP3JumpTD.cameras = [camHUD];
				doP3JumpTD.scale.x = 1.25;
				doP3JumpTD.scale.y = 1.25;
				FlxG.camera.shake(0.005, 0.10);
				add(doP3JumpTD);
				FlxG.sound.play(Paths.sound('WechScary', 'exe'), .1);

				FlxTween.tween(doP3JumpTD, {alpha: 0}, 0.5, {});

				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					remove(doP3JumpTD);
				});
		}
		var balling:FlxSprite = new FlxSprite(0, 0);
		balling.frames = Paths.getSparrowAtlas('daSTAT', 'exe');
		balling.animation.addByPrefix('static', 'staticFLASH', 24, false);
		balling.setGraphicSize(FlxG.width, FlxG.height);
		balling.screenCenter();
		balling.cameras = [camHUD];
		add(balling);

		FlxG.sound.play(Paths.sound('staticBUZZ'));

		if (balling.alpha != 0)
			balling.alpha = FlxG.random.float(0.1, 0.5);

		balling.animation.play('static');

		balling.animation.finishCallback = function(pog:String)
		{
			trace('ended static');
			remove(balling);
		}
	}

	function goofyAhhStatic()
	{
		trace('p3static XDXDXD');
		var daP3Static:FlxSprite = new FlxSprite(0, 0);
		daP3Static.frames = Paths.getSparrowAtlas('Phase3Static', 'exe');
		daP3Static.animation.addByPrefix('P3Static', 'Phase3Static instance 1', 24, false);
		daP3Static.screenCenter();

		daP3Static.scale.x = 4;
		daP3Static.scale.y = 4;
		daP3Static.alpha = 0.5;

		daP3Static.cameras = [camHUD];
		add(daP3Static);
		daP3Static.animation.play('P3Static');

		daP3Static.animation.finishCallback = function(pog:String)
		{
			trace('ended p3static');
			daP3Static.alpha = 0;

			remove(daP3Static);
		}
	}

	override function switchTo(state:FlxState){
		if (VHSui == true) VHSui = false;
		
		if(isFixedAspectRatio){
			Lib.application.window.resizable = true;
			FlxG.scaleMode = new RatioScaleMode(false);
			FlxG.resizeGame(1280, 720);
			FlxG.resizeWindow(1280, 720);
			isFixedAspectRatio = false;
		}

		return super.switchTo(state);
	}

	function tweenCamIn() {
		if (Paths.formatToSongPath(SONG.song) == 'tutorial' && cameraTwn == null && FlxG.camera.zoom != 1.3) {
			cameraTwn = FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut, onComplete:
				function (twn:FlxTween) {
					cameraTwn = null;
				}
			});
		}
	}

	function snapCamFollowToPos(x:Float, y:Float) {
		camFollow.set(x, y);
		camFollowPos.setPosition(x, y);
	}

	//Any way to do this without using a different function? kinda dumb
	private function onSongComplete()
	{
		finishSong(false);
	}
	public function finishSong(?ignoreNoteOffset:Bool = false):Void
	{
		var finishCallback:Void->Void = endSong; //In case you want to change it in a specific song.
		
		if (!ClientPrefs.earnedRings.contains(SONG.song.toLowerCase())) {
			if (!practiceMode && !cpuControlled) {
				ClientPrefs.RingsAmount += Std.int(songScore/1000);
				ClientPrefs.earnedRings.push(SONG.song.toLowerCase());
				trace('Shop: +'+Std.int(songScore/1000)+' Rings!');
				ClientPrefs.saveSettings();
			}
		} else {
			if (!practiceMode && !cpuControlled) {
				var prevScore:Int = Highscore.getScore(SONG.song.toLowerCase(), 2);
				if (prevScore < songScore) {
					ClientPrefs.RingsAmount += Std.int((songScore-prevScore)/1000);
					trace('Shop: +'+Std.int((songScore-prevScore)/1000)+' Rings!');
				}
				ClientPrefs.saveSettings();
			}
		}
		
		switch (SONG.song.toLowerCase())
		{
			case 'too-slow':
				if (ClientPrefs.storyProgressExe == 0 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressExe = 1;
					ClientPrefs.saveSettings();
				}
				if (songMisses <= 5 && !practiceMode && !cpuControlled && !ClientPrefs.TrophiesUnlocked.contains('too-slow')) {
					ClientPrefs.TrophiesUnlockedRN.push('too-slow');
					ClientPrefs.saveSettings();
				}
				
			case 'you-cant-run':
				if (ClientPrefs.storyProgressExe == 1 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressExe = 2;
					ClientPrefs.saveSettings();
				}
				if (songMisses <= 5 && !practiceMode && !cpuControlled && !ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) {
					ClientPrefs.TrophiesUnlockedRN.push('you-cant-run');
					ClientPrefs.saveSettings();
				}
				
			case 'triple-trouble':
				if (songMisses <= 25 && !practiceMode && !cpuControlled && !ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) {
					ClientPrefs.TrophiesUnlockedRN.push('triple-trouble');
					ClientPrefs.saveSettings();
				}
			
				if (ClientPrefs.storyProgressExe == 2 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressExe = 3;
					ClientPrefs.daGameCrashed = true;
					ClientPrefs.saveSettings();
				}
				
			case 'final-escape':
				if (ClientPrefs.storyProgressExe == 3 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressExe = 4;
					ClientPrefs.saveSettings();
				}

				if (songMisses <= 10 && !practiceMode && !cpuControlled && !ClientPrefs.TrophiesUnlocked.contains('final-escape')) {
					ClientPrefs.TrophiesUnlockedRN.push('final-escape');
					ClientPrefs.saveSettings();
				}
			
			case 'face-off':
				if (ClientPrefs.storyProgressExe == 4 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressExe = 5;
					ClientPrefs.saveSettings();
				}
				if (songMisses <= 5 && !practiceMode && !cpuControlled && !ClientPrefs.TrophiesUnlocked.contains('face-off')) {
					ClientPrefs.TrophiesUnlockedRN.push('face-off');
					ClientPrefs.saveSettings();
				}
			
			case 'coulrophobia':
				if (ClientPrefs.storyProgressAlt == 0 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressAlt = 1;
					ClientPrefs.saveSettings();
				}
			
			case 'broken-heart':
				if (ClientPrefs.storyProgressAlt == 1 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressAlt = 2;
					ClientPrefs.saveSettings();
				}
			
			case 'tribal':
				if (ClientPrefs.storyProgressAlt == 2 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressAlt = 3;
					ClientPrefs.saveSettings();
				}	
				
			case 'goddess':
				if (ClientPrefs.storyProgressAlt == 3 && !practiceMode && !cpuControlled) {
					ClientPrefs.storyProgressAlt = 4;
					ClientPrefs.EncoreUnlocked = true;
					ClientPrefs.SoundTestUnlocked = true;
					ClientPrefs.saveSettings();
				}
				
			case 'faker':
				if (!ClientPrefs.SkinsUnlocked.contains('cat-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('cat-gf');
					ClientPrefs.saveSettings();
				}
				if (!ClientPrefs.SongsCompleted.contains('faker') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('faker');
					ClientPrefs.saveSettings();
				}
				
			case 'chaos':
				if (!ClientPrefs.SongsCompleted.contains('chaos') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('chaos');
					ClientPrefs.saveSettings();
				}
				
			case 'cycles':
				if (!ClientPrefs.SongsCompleted.contains('cycles') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('cycles');
					ClientPrefs.saveSettings();
				}
				
			case 'endless':
				if (!ClientPrefs.SongsCompleted.contains('endless') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('endless');
					ClientPrefs.saveSettings();
				}
				
			case 'fatality':
				if (!ClientPrefs.SongsCompleted.contains('fatality') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('fatality');
					ClientPrefs.saveSettings();
				}
				
			case 'her-world':
				if (!ClientPrefs.SongsCompleted.contains('her-world') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('her-world');
					ClientPrefs.saveSettings();
				}
				
			case 'sunshine':
				if (!ClientPrefs.SongsCompleted.contains('sunshine') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('sunshine');
					ClientPrefs.saveSettings();
				}
			
			case 'faker-encore':
				if (!ClientPrefs.SkinsUnlocked.contains('faker-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('faker-gf');
					ClientPrefs.saveSettings();
				}
			
			case 'hedge':
				if (!ClientPrefs.SkinsUnlocked.contains('hogged-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('hogged-gf');
					ClientPrefs.saveSettings();
				}
				if (!ClientPrefs.SkinsUnlocked.contains('hogg-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('hogg-gf');
					ClientPrefs.saveSettings();
				}
			
			case 'manual-blast':
				if (!ClientPrefs.SkinsUnlocked.contains('hog-bf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('hog-bf');
					ClientPrefs.saveSettings();
				}
				if (!ClientPrefs.SkinsUnlocked.contains('hog-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('hog-gf');
					ClientPrefs.saveSettings();
				}
			
			case 'fatality-encore':
				if (!ClientPrefs.SkinsUnlocked.contains('fatal-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('fatal-gf');
					ClientPrefs.saveSettings();
				}
			
			case 'round-a-bout':
				if (!ClientPrefs.SkinsUnlocked.contains('sarah-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('sarah-gf');
					ClientPrefs.saveSettings();
				}
				if (!ClientPrefs.SongsCompleted.contains('round-a-bout') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('round-a-bout');
					ClientPrefs.saveSettings();
				}
			
			case 'malediction':
				if (!ClientPrefs.SkinsUnlocked.contains('hyper-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('hyper-gf');
					ClientPrefs.saveSettings();
				}
			
			case 'extricate-hex':
				if (!ClientPrefs.SkinsUnlocked.contains('fem-bf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('fem-bf');
					ClientPrefs.saveSettings();
				}
			
			case 'old-ycr-slaps':
				if (!ClientPrefs.SkinsUnlocked.contains('sunky-gf') && !practiceMode && !cpuControlled) {
					ClientPrefs.SkinsUnlockedRN.push('sunky-gf');
					ClientPrefs.saveSettings();
				}
				
			case 'hollow':
				if (!ClientPrefs.SongsCompleted.contains('hollow') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('hollow');
					ClientPrefs.saveSettings();
				}
				
			case 'color-blind':
				if (!ClientPrefs.SongsCompleted.contains('color-blind') && !practiceMode && !cpuControlled) {
					ClientPrefs.SongsCompletedRN.push('color-blind');
					ClientPrefs.saveSettings();
				}
		}
		if (!ClientPrefs.SongsCompleted.contains(SONG.song.toLowerCase()) && !practiceMode && !cpuControlled) {
			ClientPrefs.SongsCompleted.push(SONG.song.toLowerCase());
			ClientPrefs.saveSettings();
		}
		
		if (ClientPrefs.SongsCompleted.contains('too-slow-encore') && ClientPrefs.SongsCompleted.contains('you-cant-run-encore') && ClientPrefs.SongsCompleted.contains('triple-trouble-encore')) {
			if (!ClientPrefs.SkinsUnlocked.contains('dj-gf') && !practiceMode && !cpuControlled) {
				ClientPrefs.SkinsUnlockedRN.push('dj-gf');
				ClientPrefs.saveSettings();
			}
		}
		
		if (ClientPrefs.SongsCompleted.contains('animosity') && ClientPrefs.SongsCompleted.contains('reunion')) {
			if (!ClientPrefs.SkinsUnlocked.contains('merphi-bf') && !practiceMode && !cpuControlled) {
				ClientPrefs.SkinsUnlockedRN.push('merphi-bf');
				ClientPrefs.saveSettings();
			}
		}
		
		if (!practiceMode && !cpuControlled) {
			if (!ClientPrefs.UnlockedMouses.contains('xeno-cursor') && (ClientPrefs.SongsCompleted.contains('too-slow') && ClientPrefs.SongsCompleted.contains('you-cant-run') && ClientPrefs.SongsCompleted.contains('triple-trouble') && ClientPrefs.SongsCompleted.contains('final-escape') && ClientPrefs.SongsCompleted.contains('face-off'))) ClientPrefs.UnlockedMouses.push('xeno-cursor');
			if (!ClientPrefs.UnlockedMouses.contains('x-cursor') && (ClientPrefs.SongsCompleted.contains('cycles') && ClientPrefs.SongsCompleted.contains('hellbent') && ClientPrefs.SongsCompleted.contains('fate'))) ClientPrefs.UnlockedMouses.push('x-cursor');
			if (!ClientPrefs.UnlockedMouses.contains('td-cursor') && (ClientPrefs.SongsCompleted.contains('sunshine') && ClientPrefs.SongsCompleted.contains('soulless'))) ClientPrefs.UnlockedMouses.push('td-cursor');
			if (!ClientPrefs.UnlockedMouses.contains('sanic-cursor') && ClientPrefs.SongsCompleted.contains('too-fest')) ClientPrefs.UnlockedMouses.push('sanic-cursor');
			if (!ClientPrefs.UnlockedMouses.contains('devoid-cursor') && (ClientPrefs.SongsCompleted.contains('hollow') && ClientPrefs.SongsCompleted.contains('empty'))) ClientPrefs.UnlockedMouses.push('devoid-cursor');
			if (ClientPrefs.SongsCompleted.contains('hedge') && ClientPrefs.SongsCompleted.contains('manual-blast')) {
				if (!ClientPrefs.UnlockedMouses.contains('hog-cursor')) ClientPrefs.UnlockedMouses.push('hog-cursor');
				if (!ClientPrefs.UnlockedMouses.contains('scorched-cursor')) ClientPrefs.UnlockedMouses.push('scorched-cursor');
			}
			if (!ClientPrefs.UnlockedMouses.contains('curse-cursor') && (ClientPrefs.SongsCompleted.contains('malediction') && ClientPrefs.SongsCompleted.contains('extricate-hex'))) ClientPrefs.UnlockedMouses.push('curse-cursor');
			if (!ClientPrefs.UnlockedMouses.contains('fatal_mouse_cursor') && (ClientPrefs.SongsCompleted.contains('fatality') && ClientPrefs.SongsCompleted.contains('critical-error'))) ClientPrefs.UnlockedMouses.push('fatal_mouse_cursor');
			ClientPrefs.saveSettings();
		}
		
		updateTime = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		vocals.pause();
		if(ClientPrefs.noteOffset <= 0 || ignoreNoteOffset) {
			finishCallback();
		} else {
			finishTimer = new FlxTimer().start(ClientPrefs.noteOffset / 1000, function(tmr:FlxTimer) {
				finishCallback();
			});
		}
	}

	public var transitioning = false;
	public var endSongDEV:Bool = false;
	public function endSong():Void
	{
		#if mobile
		mobileControls.visible = false;
		if (ClientPrefs.isvpad && SONG.isRing && ClientPrefs.space == 'button' && MobileControls.mode != 'Keyboard')
		{
			virtualPad.visible = true;
		}
		#end
		#if desktop
		DiscordClient.smallImageRpc = '';
		#end
		
		if(!startingSong && !endSongDEV) {
			notes.forEach(function(daNote:Note) {
				if(daNote.strumTime < songLength - Conductor.safeZoneOffset) {
					health -= 0.05 * healthLoss;
				}
			});
			for (daNote in unspawnNotes) {
				if(daNote.strumTime < songLength - Conductor.safeZoneOffset) {
					health -= 0.05 * healthLoss;
				}
			}

			if(doDeathCheck()) {
				return;
			}
		}
			
		if(SONG.song.toLowerCase() == 'fatality'){
			#if windows
			try{
				Sys.command('${Sys.getCwd()}\\assets\\exe\\FatalError.exe');
			}catch(e:Dynamic){
				trace("A fatal error has ACTUALLY occured: " + e);
			}
			#end
			Main.DisableCustomCursor = false;
		}

		//timeBarBG.visible = false;
		//if (bgTBSkin == 'tbR') timeBarBGBG.visible = false;
		//timeBar.visible = false;
		//timeTxt.visible = false;
		canPause = false;
		endingSong = true;
		camZooming = false;
		inCutscene = false;
		updateTime = false;

		deathCounter = 0;
		seenCutscene = false;

		#if ACHIEVEMENTS_ALLOWED
		if(achievementObj != null) {
			return;
		} else {
			var achieve:String = checkForAchievement();

			if(achieve != null) {
				startAchievement(achieve);
				return;
			}
		}
		#end

		
		#if LUA_ALLOWED
		var ret:Dynamic = callOnLuas('onEndSong', [], false);
		#else
		var ret:Dynamic = FunkinLua.Function_Continue;
		#end

		if(ret != FunkinLua.Function_Stop && !transitioning) {
			if (SONG.validScore)
			{
				#if !switch
				var percent:Float = ratingPercent;
				if(Math.isNaN(percent)) percent = 0;
				Highscore.saveScore(SONG.song, songScore, storyDifficulty, percent);
				#end
			}

			if (chartingMode)
			{
				openChartEditor();
				return;
			}
			if ((SONG.song.toLowerCase() == 'triple-trouble' && ClientPrefs.storyProgressExe <= 3) || (SONG.song.toLowerCase() == 'goddess' && ClientPrefs.storyProgressAlt <= 4 && !ClientPrefs.youSawSoundTestCutscene) || ((SONG.song.toLowerCase() == 'malediction' && (!ClientPrefs.UnlockedEndings.contains('curse-good') || !ClientPrefs.UnlockedEndings.contains('curse-bad'))) && !practiceMode && !cpuControlled)) {
				if (SONG.song.toLowerCase() == 'triple-trouble') {
					FlxG.mouse.visible = false;
					Main.InPlaystate = false;
					MusicBeatState.switchState(new Cutscenes('FECrash'));
				}
				if (SONG.song.toLowerCase() == 'goddess') {
					FlxG.mouse.visible = false;
					Main.InPlaystate = false;
					ClientPrefs.youSawSoundTestCutscene = true;
					MusicBeatState.switchState(new Cutscenes('STCodes'));
				}
				if (SONG.song.toLowerCase() == 'malediction') {
					FlxG.sound.music.stop();	
					cancelMusicFadeTween();
					if (songMisses <= 10) {
						PlayState.SONG = Song.loadFromJson('extricate-hex' + '-hard', 'extricate-hex');
						PlayState.storyPlaylist = ['extricate-hex'];
						if (!ClientPrefs.UnlockedEndings.contains('curse-good')) {
							ClientPrefs.UnlockedEndings.push('curse-good');
							ClientPrefs.saveSettings();
						}
					} else {
						PlayState.SONG = Song.loadFromJson('unblessful-hedgehog' + '-hard', 'unblessful-hedgehog');
						PlayState.storyPlaylist = ['unblessful-hedgehog'];
						if (!ClientPrefs.UnlockedEndings.contains('curse-bad')) {
							ClientPrefs.UnlockedEndings.push('curse-bad');
							ClientPrefs.saveSettings();
						}
					}
					PlayState.storyDifficulty = 2; 
					PlayState.storyWeek = 12; 
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;
					prevCamFollowPos = camFollowPos;
					Main.InPlaystate = true;
					LoadingState.loadAndSwitchState(new PlayState());
				}
			} else {
				if (isStoryMode)
				{
					campaignScore += songScore;
					campaignMisses += songMisses;

					storyPlaylist.remove(storyPlaylist[0]);

					if (storyPlaylist.length <= 0)
					{
						cancelMusicFadeTween();
						Main.InPlaystate = false;
						showSTCutscene = true;
						if(isSound) {
							MusicBeatState.switchState(new SoundTestState());
							FlxG.sound.playMusic(Paths.music('breakfast', 'shared'));
						} else {
							MusicBeatState.switchState(new StoryMenuState());
							FlxG.sound.playMusic(Paths.music('storymode'));
						}

						if(!ClientPrefs.getGameplaySetting('practice', false) && !ClientPrefs.getGameplaySetting('botplay', false)) {
							if (SONG.validScore) {
								Highscore.saveWeekScore(WeekData.getWeekFileName(), campaignScore, storyDifficulty);
							}
							FlxG.save.flush();
						}
						changedDifficulty = false;
					} else {
						showSTCutscene = true;
						var difficulty:String = '-hard';

						trace('LOADING NEXT SONG');
						trace(Paths.formatToSongPath(PlayState.storyPlaylist[0]) + difficulty);

						FlxTransitionableState.skipNextTransIn = true;
						FlxTransitionableState.skipNextTransOut = true;

						prevCamFollow = camFollow;
						prevCamFollowPos = camFollowPos;

						PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0] + difficulty, PlayState.storyPlaylist[0]);
						FlxG.sound.music.stop();
						
						cancelMusicFadeTween();
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					}
				}
				else
				{
					Main.InPlaystate = false;
					Main.DisableCustomCursor = false;
					#if windows
					if (customIconAndName) {
						var Icon:Image = Image.fromFile('assets/exe/images/windowIcons/iconGame.png');
						lime.app.Application.current.window.setIcon(Icon);
						customIconAndName = false;
					}
					#end
					if(isStory) {
						trace('Story Mode');
						cancelMusicFadeTween();
						MusicBeatState.switchState(new StoryMenuState());
						FlxG.sound.playMusic(Paths.music('storymode'));
						changedDifficulty = false;
					} else {
						if(isEncore){
							trace('Encore');
							cancelMusicFadeTween();
							MusicBeatState.switchState(new EncoreState());
							FlxG.sound.playMusic(Paths.music('encoremode'));
							changedDifficulty = false;
						} else {
							if(isExtras){
								trace('Extras');
								cancelMusicFadeTween();
								MusicBeatState.switchState(new extras.ExtraSongsState());
								changedDifficulty = false;
								extras.ExtraSongsState.playSong = true;
							} else {
								if(isSound){
									trace('Sound Test');
									cancelMusicFadeTween();
									MusicBeatState.switchState(new SoundTestState());
									changedDifficulty = false;
								} else {
									if(isFreeplay){
										trace('Freeplay');
										cancelMusicFadeTween();
										MusicBeatState.switchState(new FreeplayState());
										FlxG.sound.playMusic(Paths.music('freeplaymode'));
										changedDifficulty = false;
									} else {
										trace('???');
										cancelMusicFadeTween();
										MusicBeatState.switchState(new MainMenuState());
										FlxG.sound.playMusic(Paths.music('storymodemenumusic'));
										changedDifficulty = false;
									}
								}
							}
						}
					}
				}
			}
			transitioning = true;
		}
	}

	#if ACHIEVEMENTS_ALLOWED
	var achievementObj:AchievementObject = null;
	function startAchievement(achieve:String) {
		achievementObj = new AchievementObject(achieve, camOther);
		achievementObj.onFinish = achievementEnd;
		add(achievementObj);
		trace('Giving achievement ' + achieve);
	}
	function achievementEnd():Void
	{
		achievementObj = null;
		if(endingSong && !inCutscene) {
			endSong();
		}
	}
	#end

	public function KillNotes() {
		while(notes.length > 0) {
			var daNote:Note = notes.members[0];
			daNote.active = false;
			daNote.visible = false;

			daNote.kill();
			notes.remove(daNote, true);
			daNote.destroy();
		}
		unspawnNotes = [];
		eventNotes = [];
	}

	public var totalPlayed:Int = 0;
	public var totalNotesHit:Float = 0.0;

	public var showCombo:Bool = true;
	public var showRating:Bool = true;

	function updateSonicScore(){
		var seperatedScore:Array<String> = Std.string(songScore).split("");
		if(seperatedScore.length<scoreNumbers.length){
			for(idx in seperatedScore.length...scoreNumbers.length){
				if(hudStyle == 'chaotix' || hudStyle == 'chotix' || hudStyle == 'sonic3' || hudStyle == 'soniccd'){
					seperatedScore.unshift('');
				}else{
					seperatedScore.unshift('0');
				}
			}
		}
		if(seperatedScore.length>scoreNumbers.length)
			seperatedScore.resize(scoreNumbers.length);

		for(idx in 0...seperatedScore.length){
			if(seperatedScore[idx]!='' || idx==scoreNumbers.length-1){
				var val = Std.parseInt(seperatedScore[idx]);
				if(Math.isNaN(val))val=0;
				scoreNumbers[idx].number = val;
				scoreNumbers[idx].visible=true;
			}else
				scoreNumbers[idx].visible=false;

		}
	}

	function updateSonicMisses(){
		var seperatedScore:Array<String> = Std.string(songMisses).split("");
		if(seperatedScore.length<missNumbers.length){
			for(idx in seperatedScore.length...missNumbers.length){
				if(hudStyle == 'chaotix' || hudStyle == 'chotix' || hudStyle == 'sonic3' || hudStyle == 'soniccd'){
					seperatedScore.unshift('');
				}else{
					seperatedScore.unshift('0');
				}
			}
		}
		if(seperatedScore.length>missNumbers.length)
			seperatedScore.resize(missNumbers.length);

		for(idx in 0...seperatedScore.length){
			if(seperatedScore[idx]!='' || idx==missNumbers.length-1){
				var val = Std.parseInt(seperatedScore[idx]);
				if(Math.isNaN(val))val=0;
				missNumbers[idx].number = val;
				missNumbers[idx].visible=true;
			}else
				missNumbers[idx].visible=false;

		}
	}

	function doGhostAnim(char:String, animToPlay:String, ?minusAlpha:Float = 0.35)
	{
		var player:Character = dad;
		var curPlayer:String = curDAD;
		switch(char.toLowerCase().trim()){
			case 'bf' | 'boyfriend' | '0':
				player = boyfriend;
				curPlayer = curBF;
			case 'dad' | 'opponent' | '1':
				player = dad;
				curPlayer = curDAD;
			case 'gf' | 'girlfriend' | '3':
				player = gf;
				curPlayer = curGF;
		}

		#if desktop
		if (player.visible && player.alpha > 0.4) {
			var path:String = Paths.modFolders('characters/' + curPlayer + '.json');
			if (!FileSystem.exists(path))
				path = Paths.getPreloadPath('characters/' + curPlayer + '.json');
			var json:Character.CharacterFile = cast Json.parse(File.getContent(path));
			var animationsArray:Array<Character.AnimArray> = json.animations;
		
			var ghost:FlxSprite = new FlxSprite();
			ghost.frames = Paths.getSparrowAtlas(json.image);
			for (anim in animationsArray) {
				if(anim.indices != null && anim.indices.length > 0) {
					ghost.animation.addByIndices(anim.anim, anim.name, anim.indices, "", anim.fps, !!anim.loop);
				} else {
					ghost.animation.addByPrefix(anim.anim, anim.name, anim.fps, !!anim.loop);
				}
			}
			
			ghost.x = player.x;
			ghost.y = player.y;
			ghost.antialiasing = player.antialiasing;
			ghost.scale.copyFrom(player.scale);
			ghost.updateHitbox();
			ghost.flipX = player.flipX;
			ghost.flipY = player.flipY;
			ghost.scrollFactor.set(player.scrollFactor.x, player.scrollFactor.y);
			//ghost.blend = HARDLIGHT;
			ghost.alpha = player.alpha-minusAlpha;
			ghost.visible = true;
			ghost.animation.play(animToPlay, true);
			ghost.offset.set(player.animOffsets.get(animToPlay)[0], player.animOffsets.get(animToPlay)[1]);
			
			trace('Double Press | Char:' + char + ' | Anim:' + animToPlay + ' | X:' + ghost.x + ' | Y:' + ghost.y);
			
			switch (char.toLowerCase().trim()) {
				case 'bf' | 'boyfriend' | '0':
					ghost.color = boyfriend.color;
					FlxTween.tween(ghost, {alpha: 0}, 0.55, {
						ease: FlxEase.linear,
						startDelay: 0.2,
						onComplete: function(bfgt:FlxTween) {
							ghost.destroy();
						}
					});
					insert(members.indexOf(boyfriendGroup), ghost);
		
				case 'dad' | 'opponent' | '1':
					ghost.color = dad.color;
					FlxTween.tween(ghost, {alpha: 0}, 0.55, {
						ease: FlxEase.linear,
						startDelay: 0.2,
						onComplete: function(dadgt:FlxTween) {
							ghost.destroy();
						}
					});
					insert(members.indexOf(dadGroup), ghost);
					
				case 'gf' | 'girlfriend' | '3':
					ghost.color = gf.color;
					FlxTween.tween(ghost, {alpha: 0}, 0.55, {
						ease: FlxEase.linear,
						startDelay: 0.2,
						onComplete: function(gfgt:FlxTween) {
							ghost.destroy();
						}
					});
					insert(members.indexOf(gfGroup), ghost);
			}
		}
		#end
	}

	private function popUpScore(note:Note = null):Void
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition + ClientPrefs.ratingOffset);
		//trace(noteDiff, ' ' + Math.abs(note.strumTime - Conductor.songPosition));

		// boyfriend.playAnim('hey');
		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.35;
		//

		var rating:FlxSprite = new FlxSprite();
		var score:Int = 350;

		//tryna do MS based judgment due to popular demand
		var daRating:String = Conductor.judgeNote(note, noteDiff);

		switch (daRating)
		{
			case "shit": // shit
				totalNotesHit += 0;
				note.ratingMod = 0;
				score = 50;
				if(!note.ratingDisabled) shits++;
			case "bad": // bad
				totalNotesHit += 0.5;
				note.ratingMod = 0.5;
				score = 100;
				if(!note.ratingDisabled) bads++;
			case "good": // good
				totalNotesHit += 0.75;
				note.ratingMod = 0.75;
				score = 200;
				if(!note.ratingDisabled) goods++;
			case "sick": // sick
				totalNotesHit += 1;
				note.ratingMod = 1;
				if(!note.ratingDisabled) sicks++;
		}
		note.rating = daRating;

		if(daRating == 'sick' && !note.noteSplashDisabled) {
			spawnNoteSplashOnNote(note);
			if(PlayState.SONG.splashSkin == 'hitmarker')
				FlxG.sound.play(Paths.sound('hitmarker', 'shared'));
		}

		if(!practiceMode && !cpuControlled) {
			songScore += score;
			updateSonicScore();
			if(!note.ratingDisabled) {
				songHits++;
				totalPlayed++;
				RecalculateRating();
			}

			if(ClientPrefs.scoreZoom && SONG.song.toLowerCase() != 'godspeed' && !VHSui && !devoidUI && !xenoEncUI && !xenoEncFix) {
				if(scoreTxtTween != null) {
					scoreTxtTween.cancel();
				}
				scoreTxt.scale.x = 1.075;
				scoreTxt.scale.y = 1.075;
				scoreTxtTween = FlxTween.tween(scoreTxt.scale, {x: 1, y: 1}, 0.2, {
					onComplete: function(twn:FlxTween) {
						scoreTxtTween = null;
					}
				});
			}
		}

		/* if (combo > 60)
				daRating = 'sick';
			else if (combo > 12)
				daRating = 'good'
			else if (combo > 4)
				daRating = 'bad';
		 */

		var pixelShitPart1:String = "";
		var pixelShitPart2:String = '';

		if (PlayState.isPixelStage) {
			pixelShitPart1 = 'pixelUI/';
			pixelShitPart2 = '-pixel';
		}
		
		if (SONG.song.toLowerCase() == 'color-blind' || SONG.song.toLowerCase() == 'color-blind-old' || SONG.song.toLowerCase() == 'color-blind-encore') {
			pixelShitPart1 = 'monoRating/';
			pixelShitPart2 = '-m';
		}

		rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
		rating.cameras = [camHUD];
		rating.screenCenter();
		rating.x = coolText.x - 40;
		rating.y -= 60;
		rating.acceleration.y = 550;
		rating.velocity.y -= FlxG.random.int(140, 175);
		rating.velocity.x -= FlxG.random.int(0, 10);
		if (!sonicHUDSongs.contains(SONG.song.toLowerCase()) || SONG.song.toLowerCase() == 'you-cant-run' || SONG.song.toLowerCase() == 'our-horizon' || SONG.song.toLowerCase() == 'final-escape') {
			if (!pixelNoteGenesis && !ClientPrefs.hideHud && !isPixelStage && !VHSui && !devoidUI && !xenoEncUI && !xenoEncFix && showRating && !isFixedAspectRatio)
				rating.visible = true;
			else
				rating.visible = false;
		} else {
			rating.visible = false;
		}
		rating.x += ClientPrefs.comboOffset[0];
		rating.y -= ClientPrefs.comboOffset[1];

		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
		comboSpr.cameras = [camHUD];
		comboSpr.screenCenter();
		comboSpr.x = coolText.x;
		comboSpr.acceleration.y = 600;
		comboSpr.velocity.y -= 150;
		if (!sonicHUDSongs.contains(SONG.song.toLowerCase()) || SONG.song.toLowerCase() == 'you-cant-run' || SONG.song.toLowerCase() == 'our-horizon' || SONG.song.toLowerCase() == 'final-escape') {
			if (!pixelNoteGenesis && !ClientPrefs.hideHud && !isPixelStage && !VHSui && !devoidUI && !xenoEncUI && !xenoEncFix && showCombo && !isFixedAspectRatio)
				comboSpr.visible = true;
			else
				comboSpr.visible = false;
		} else {
			comboSpr.visible = false;
		}
			
		comboSpr.x += ClientPrefs.comboOffset[0];
		comboSpr.y -= ClientPrefs.comboOffset[1];

		comboSpr.velocity.x += FlxG.random.int(1, 10);
		insert(members.indexOf(strumLineNotes), rating);

		if (!PlayState.isPixelStage) {
			rating.setGraphicSize(Std.int(rating.width * 0.7));
			rating.antialiasing = ClientPrefs.globalAntialiasing;
			comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
			comboSpr.antialiasing = ClientPrefs.globalAntialiasing;
		} else {
			rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.85));
			comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.85));
		}

		comboSpr.updateHitbox();
		rating.updateHitbox();

		var seperatedScore:Array<Int> = [];

		if(combo >= 1000) {
			seperatedScore.push(Math.floor(combo / 1000) % 10);
		}
		seperatedScore.push(Math.floor(combo / 100) % 10);
		seperatedScore.push(Math.floor(combo / 10) % 10);
		seperatedScore.push(combo % 10);

		var daLoop:Int = 0;
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
			numScore.cameras = [camHUD];
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 80;

			numScore.x += ClientPrefs.comboOffset[2];
			numScore.y -= ClientPrefs.comboOffset[3];

			if (!PlayState.isPixelStage) {
				numScore.antialiasing = ClientPrefs.globalAntialiasing;
				numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			} else {
				numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
			}
			numScore.updateHitbox();

			numScore.acceleration.y = FlxG.random.int(200, 300);
			numScore.velocity.y -= FlxG.random.int(140, 160);
			numScore.velocity.x = FlxG.random.float(-5, 5);
			if (!sonicHUDSongs.contains(SONG.song.toLowerCase()) || SONG.song.toLowerCase() == 'you-cant-run' || SONG.song.toLowerCase() == 'our-horizon' || SONG.song.toLowerCase() == 'final-escape') {
				if (!pixelNoteGenesis && !ClientPrefs.hideHud && !isPixelStage && !VHSui && !devoidUI && !xenoEncUI && !xenoEncFix && !isFixedAspectRatio)
					numScore.visible = true;
				else
					numScore.visible = false;
			} else {
				numScore.visible = false;
			}
			//if (combo >= 10 || combo == 0)
			insert(members.indexOf(strumLineNotes), numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
		}
		/* 
			trace(combo);
			trace(seperatedScore);
		 */

		coolText.text = Std.string(seperatedScore);
		// add(coolText);

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		});

		FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				coolText.destroy();
				comboSpr.destroy();

				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.001
		});
	}

	private function onKeyPress(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		//trace('Pressed: ' + eventKey);

		if (!cpuControlled && !paused && key > -1 && (FlxG.keys.checkStatus(eventKey, JUST_PRESSED) || ClientPrefs.controllerMode))
		{
			if(!boyfriend.stunned && generatedMusic && !endingSong)
			{
				//more accurate hit time for the ratings?
				var lastTime:Float = Conductor.songPosition;
				Conductor.songPosition = FlxG.sound.music.time;

				var canMiss:Bool = !ClientPrefs.ghostTapping;

				// heavily based on my own code LOL if it aint broke dont fix it
				var pressNotes:Array<Note> = [];
				//var notesDatas:Array<Int> = [];
				var notesStopped:Bool = false;

				var sortedNotesList:Array<Note> = [];
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote)
					{
						if(daNote.noteData == key)
						{
							sortedNotesList.push(daNote);
							//notesDatas.push(daNote.noteData);
						}
						canMiss = true;
					}
				});
				sortedNotesList.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

				if (sortedNotesList.length > 0) {
					for (epicNote in sortedNotesList)
					{
						for (doubleNote in pressNotes) {
							if (Math.abs(doubleNote.strumTime - epicNote.strumTime) < 1) {
								doubleNote.kill();
								notes.remove(doubleNote, true);
								doubleNote.destroy();
							} else
								notesStopped = true;
						}
							
						// eee jack detection before was not super good
						if (!notesStopped) {
							goodNoteHit(epicNote);
							pressNotes.push(epicNote);
						}

					}
				}
				else if (canMiss) {
					noteMissPress(key);
					callOnLuas('noteMissPress', [key]);
				}

				// I dunno what you need this for but here you go
				//									- Shubs

				// Shubs, this is for the "Just the Two of Us" achievement lol
				//									- Shadow Mario
				keysPressed[key] = true;

				//more accurate hit time for the ratings? part 2 (Now that the calculations are done, go back to the time it was before for not causing a note stutter)
				Conductor.songPosition = lastTime;
			}

			var spr:StrumNote = playerStrums.members[key];
			if(spr != null && spr.animation.curAnim.name != 'confirm')
			{
				spr.playAnim('pressed');
				spr.resetAnim = 0;
			}
			callOnLuas('onKeyPress', [key]);
		}
		//trace('pressed: ' + controlArray);
	}
	
	private function onKeyRelease(event:KeyboardEvent):Void
	{
		var eventKey:FlxKey = event.keyCode;
		var key:Int = getKeyFromEvent(eventKey);
		if(!cpuControlled && !paused && key > -1)
		{
			var spr:StrumNote = playerStrums.members[key];
			if(spr != null)
			{
				spr.playAnim('static');
				spr.resetAnim = 0;
			}
			callOnLuas('onKeyRelease', [key]);
		}
		//trace('released: ' + controlArray);
	}

	function glitchFreeze()
	{
		if (ClientPrefs.Shaders) {
			switch(SONG.song.toLowerCase()){
				case 'manual-blast':
					switch(FlxG.random.int(1,2))
					{
						case 1:
							staticlol.enabled.value = [true];
							scoreRandom = true;
							new FlxTimer().start(0.45, function(byebye:FlxTimer) {
								staticlol.enabled.value = [false];
							});
						case 2:
							glitchThingy.enabled.value = [true];
							scoreRandom = true;
							new FlxTimer().start(0.45, function(byebye:FlxTimer) {
								glitchThingy.enabled.value = [false];
								scoreRandom = true;
							});

					}
				case 'hedge':
					switch(FlxG.random.int(1,2))
					{
						case 1:
							staticlol.enabled.value = [true];
							scoreRandom = true;
							defaultCamZoom = 1.2;
							new FlxTimer().start(0.65, function(byebye:FlxTimer) {
								staticlol.enabled.value = [false];
								scoreRandom = false;
								defaultCamZoom = 0.67;
							});
						case 2:
							camFuckShader.amount = 0.15;
							scoreRandom = true;
							defaultCamZoom = 1.2;
							new FlxTimer().start(0.65, function(byebye:FlxTimer) {
								camFuckShader.amount = 0;
								scoreRandom = false;
								defaultCamZoom = 0.67;
							});
					}
			}
		}
	}	

	function set_songSpeed(value:Float):Float
	{
		if(generatedMusic)
		{
			var ratio:Float = value / songSpeed; //funny word huh
			for (note in notes)
			{
				if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end'))
				{
					note.scale.y *= ratio;
					note.updateHitbox();
				}
			}
			for (note in unspawnNotes)
			{
				if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end'))
				{
					note.scale.y *= ratio;
					note.updateHitbox();
				}
			}
		}
		songSpeed = value;
		noteKillOffset = 350 / songSpeed;
		return value;
	}

	private function getKeyFromEvent(key:FlxKey):Int
	{
		if(key != NONE)
		{
			for (i in 0...keysArray.length)
			{
				for (j in 0...keysArray[i].length)
				{
					if(key == keysArray[i][j])
					{
						return i;
					}
				}
			}
		}
		return -1;
	}

	// Hold notes
	private function keyShit():Void
	{
		// HOLDING
		var up = controls.NOTE_UP;
		var right = controls.NOTE_RIGHT;
		var ring = controls.NOTE_RING;
		var down = controls.NOTE_DOWN;
		var left = controls.NOTE_LEFT;
		var controlHoldArray:Array<Bool> = [left, down, up, right];
		if (SONG.isRing)
			controlHoldArray = [left, down, ring, up, right];
		
		// TO DO: Find a better way to handle controller inputs, this should work for now
		if(ClientPrefs.controllerMode)
		{
			var controlArray:Array<Bool> = [];
			if (!SONG.isRing)
				controlArray = [controls.NOTE_LEFT_P, controls.NOTE_DOWN_P, controls.NOTE_UP_P, controls.NOTE_RIGHT_P];
			else
				controlArray = [controls.NOTE_LEFT_P, controls.NOTE_DOWN_P, controls.NOTE_RING_P, controls.NOTE_UP_P, controls.NOTE_RIGHT_P];
			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
						onKeyPress(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, true, -1, keysArray[i][0]));
				}
			}
		}

		// FlxG.watch.addQuick('asdfa', upP);
		if (!boyfriend.stunned && generatedMusic)
		{
			// rewritten inputs???
			notes.forEachAlive(function(daNote:Note)
			{
				// hold note functions
				if (daNote.isSustainNote && controlHoldArray[daNote.noteData] && daNote.canBeHit 
				&& daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit) {
					goodNoteHit(daNote);
				}
			});

			if (controlHoldArray.contains(true) && !endingSong) {
				#if ACHIEVEMENTS_ALLOWED
				var achieve:String = checkForAchievement(['oversinging']);
				if (achieve != null) {
					startAchievement(achieve);
				}
				#end
			}
			else if (boyfriend.holdTimer > Conductor.stepCrochet * 0.001 * boyfriend.singDuration && boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				boyfriend.dance();
				//boyfriend.animation.curAnim.finish();
			}
		}

		// TO DO: Find a better way to handle controller inputs, this should work for now
		if(ClientPrefs.controllerMode)
		{
			var controlArray:Array<Bool> = [];
			if (!SONG.isRing)
				controlArray = [controls.NOTE_LEFT_R, controls.NOTE_DOWN_R, controls.NOTE_UP_R, controls.NOTE_RIGHT_R];
			else
				controlArray = [controls.NOTE_LEFT_R, controls.NOTE_DOWN_R, controls.NOTE_RING_R, controls.NOTE_UP_R, controls.NOTE_RIGHT_R];
			if(controlArray.contains(true))
			{
				for (i in 0...controlArray.length)
				{
					if(controlArray[i])
						onKeyRelease(new KeyboardEvent(KeyboardEvent.KEY_UP, true, true, -1, keysArray[i][0]));
				}
			}
		}
	}

	function noteMiss(daNote:Note):Void { //You didn't hit the key and let it go offscreen, also used by Hurt Notes
		//Dupe note remove
		notes.forEachAlive(function(note:Note) {
			if (daNote != note && daNote.mustPress && daNote.noteData == note.noteData && daNote.isSustainNote == note.isSustainNote && Math.abs(daNote.strumTime - note.strumTime) < 1) {
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		});
		combo = 0;
		
		if (daNote.noteType == 'Static Note') {
			songMisses += 1;
			daNoteStatic = new FlxSprite(0, 0);
			daNoteStatic.frames = Paths.getSparrowAtlas('hitStatic', 'exe');
			daNoteStatic.animation.addByPrefix('static', "staticANIMATION", 24, false);
			daNoteStatic.animation.play('static');
			daNoteStatic.cameras = [camHUD];
			daNoteStatic.screenCenter();
			add(daNoteStatic);
			
			FlxG.camera.shake(0.005, 0.005);

			FlxG.sound.play(Paths.sound("hitStatic1"));

			new FlxTimer().start(0.40, function(trol:FlxTimer)
			{
				daNoteStatic.alpha = 0;
				remove(daNoteStatic);
			});
		} else {
			if (cNum<=0 && !fucklesMode) {
				if (curSong != 'black-sun' && curSong != 'godspeed') {
					health -= daNote.missHealth * healthLoss;
				}
			}
			fearNo += 0.25;
			if (cNum<=0 && !fucklesMode) songMisses++;
			if(fucklesMode) drainMisses++;
			updateSonicMisses();
		}
		
		if(instakillOnMiss)
		{
			if (SONG.needsVoices) vocals.volume = 0;
			doDeathCheck(true);
		}
		
		if (SONG.needsVoices) vocals.volume = 0;
		if (!practiceMode){
			songScore -= 10;
			updateSonicScore();
		}
		
		totalPlayed++;
		RecalculateRating();

		var char:Character = boyfriend;
		if(daNote.gfNote) {
			char = gf;
		}

		if(char != null && char.hasMissAnimations)
		{
			var daAlt = '';
			if(daNote.noteType == 'Alt Animation') daAlt = '-alt';

			var animToPlay:String = '';
			if (SONG.isRing)
			{
				switch (Math.abs(daNote.noteData) % 5)
				{
					case 0:
						animToPlay = 'singLEFTmiss' + daAlt;
					case 1:
						animToPlay = 'singDOWNmiss' + daAlt;
					case 2:
						animToPlay = '';
					case 3:
						animToPlay = 'singUPmiss' + daAlt;
					case 4:
						animToPlay = 'singRIGHTmiss' + daAlt;
				}
			}
			else
			{
				switch (Math.abs(daNote.noteData) % 4)
				{
					case 0:
						animToPlay = 'singLEFTmiss' + daAlt;
					case 1:
						animToPlay = 'singDOWNmiss' + daAlt;
					case 2:
						animToPlay = 'singUPmiss' + daAlt;
					case 3:
						animToPlay = 'singRIGHTmiss' + daAlt;
				}
			}
			char.playAnim(animToPlay, true);
		}
		if(cNum>0){
			cNum--;
		}
		#if windows
		switch (SONG.song.toLowerCase()) {
			case 'fight-or-flight': if (!customIconAndName) lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Sacrifices: " + songMisses;
			case 'godspeed': if (!customIconAndName) lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Misses: " + songMisses;
			default:
				if (!customIconAndName) {
					if(!scoreRandom){
						lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Score: " + songScore +  " | Misses: " + songMisses;
					} else {
						switch(FlxG.random.int(1, 6)) {
							case 1: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | S0mn: " + SONG.song.toLowerCase() + " | " + "sC0r3: " + songScore +  " | " + "m11ses: " + songMisses;
							case 2: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | kFd5: " + SONG.song.toLowerCase() + " | " + "mIsees: " + songScore +  " | " + "raITNtg: " + songMisses;
							case 3: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | 50Hg: " + SONG.song.toLowerCase() + " | " + "Ra11utNg: " + songScore +  " | " + "scIrh4: " + songMisses;
							case 4: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | 2Un6: " + SONG.song.toLowerCase() + " | " + "342hj1: " + songScore +  " | " + "5436yu: " + songMisses;
							case 5: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | C8nq: " + SONG.song.toLowerCase() + " | " + "agehjk3: " + songScore +  " | " + "4uihja: " + songMisses;
							case 6: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Gtf5: " + SONG.song.toLowerCase() + " | " + "4276uihj: " + songScore +  " | " + "a7d5hf: " + songMisses;
						}
					}
				}
		}
		#end
		callOnLuas('noteMiss', [notes.members.indexOf(daNote), daNote.noteData, daNote.noteType, daNote.isSustainNote]);
	}
		
	function noteMissPress(direction:Int = 1):Void //You pressed a key when there was no notes to press for this key
	{
		if (!boyfriend.stunned && !(SONG.isRing && direction == 2))
		{
			if (isFear && cNum==0) {
				if (curSong != 'black-sun' && curSong != 'godspeed') {
					health -= 0.05 * healthLoss;
					fearNo += 0.25;
				}
			}
			if (cNum==0) {
				if (curSong != 'black-sun' && curSong != 'godspeed') {
					health -= 0.05 * healthLoss;
				}
			}
			
			if(instakillOnMiss)
			{
				if (SONG.needsVoices) vocals.volume = 0;
				doDeathCheck(true);
			}

			if(ClientPrefs.ghostTapping) return;

			if (combo > 5 && gf != null && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;

			if (!practiceMode){
				songScore -= 10;
				updateSonicScore();
			}
			if(!endingSong) {
				if (cNum<=0 && !fucklesMode)
					songMisses++;
					updateSonicMisses();
			}
			totalPlayed++;
			RecalculateRating();

			FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));

			if(boyfriend.hasMissAnimations) {
				boyfriend.playAnim(singAnimations[Std.int(Math.abs(direction))] + 'miss', true);
			}
			if (SONG.needsVoices) vocals.volume = 0;
		}
	}

	function opponentNoteHit(note:Note):Void
	{	
		if (Paths.formatToSongPath(SONG.song) != 'tutorial')
			camZooming = true;

		if (dad.curCharacter == 'starved')
			fearNo += 0.15;
		if (dad.curCharacter == 'Satanos')
			fearNo += 0.10;

		if(note.noteType == 'Hey!' && dad.animOffsets.exists('hey')) {
			dad.playAnim('hey', true);
			dad.specialAnim = true;
			dad.heyTimer = 0.6;
		} else if(!note.noAnimation) {
			var altAnim:String = "";
			
			var curSection:Int = Math.floor(curStep / 16);
			if (SONG.notes[curSection] != null)
			{
				if (SONG.notes[curSection].altAnim || note.noteType == 'Alt Animation')
					altAnim = '-alt';
			}

			var char:Character = dad;
			var animToPlay:String = '';
			if (SONG.isRing) {
				switch (Math.abs(note.noteData) % 5) {
					case 0:
						animToPlay = 'singLEFT';
					case 1:
						animToPlay = 'singDOWN';
					case 2:
						animToPlay = '';
					case 3:
						if (dad.curCharacter == 'monobw' && !note.isSustainNote) {
							switch (FlxG.random.int(0, 1)) {
								case 0: animToPlay = 'singUP';
								case 1: animToPlay = 'singUP-alt';
							}
						} else {
							animToPlay = 'singUP';
						}
					case 4:
						animToPlay = 'singRIGHT';
				}
			} else {
				switch (Math.abs(note.noteData) % 4) {
					case 0:
						animToPlay = 'singLEFT';
					case 1:
						animToPlay = 'singDOWN';
					case 2:
						if (dad.curCharacter == 'monobw' && !note.isSustainNote) {
							switch (FlxG.random.int(0, 1)) {
								case 0: animToPlay = 'singUP';
								case 1: animToPlay = 'singUP-alt';
							}
						} else {
							animToPlay = 'singUP';
						}
					case 3:
						animToPlay = 'singRIGHT';
				}
			}
			
			if (!SONG.notes[curSection].mustHitSection && !noCamMove) 
				moveCameraOnNote(true, animToPlay);

			var animPlay:String = animToPlay + altAnim;
			var ch:String = 'dad';
			if(note.gfNote) {
				char = gf;
				ch = 'gf';
			}
			
			if(note.noteType == 'GF and Dad')
				triggerEventNote('Play Animation', animToPlay, ch);
			
			switch(char.animation.curAnim.name){
				case 'singUP', 'singDOWN', 'singLEFT', 'singRIGHT', 'singUP-alt', 'singDOWN-alt', 'singLEFT-alt', 'singRIGHT-alt':
					if (!bfIsLeft || FEHPThing == 2) {
						if (VHSui) iconP2.scale.set(0.9, 0.9);
						if (xenoEncUI) {
							iconP2.scale.set(1.1, 1.1);
							xenoEncIconP2.scale.set(1.1, 1.1);
						}
						if (!VHSui && !xenoEncUI) iconP2.scale.set(1.1, 1.1);
					} else {
						if (VHSui) iconP1.scale.set(0.9, 0.9);
						if (xenoEncUI) {
							iconP1.scale.set(1.1, 1.1);
							xenoEncIconP1.scale.set(0.6, 0.6);
						}
						if (!VHSui && !xenoEncUI) iconP1.scale.set(1.1, 1.1);
					}
			}
			
			if(char != null) {
				char.holdTimer = 0;
				if (animToPlay != 'daRing') {
					if (doubleNoteGhost) {
						if (!note.isSustainNote && noteRows[note.mustPress?0:1][note.row].length > 1) {
							var chord = noteRows[note.mustPress?0:1][note.row];
							var animNote = chord[0];
							if (char.mostRecentRow != note.row) {
								char.playAnim(animPlay, true);
							}

							if (!note.noAnimation) {
								if(char.mostRecentRow != note.row)
									doGhostAnim(ch, animPlay);
								char.mostRecentRow = note.row;
							} else {
								char.playAnim(animPlay, true);
								char.mostRecentRow = note.row;
							}
						} else {
							char.playAnim(animPlay, true);
						}
					} else {
						char.playAnim(animPlay, true);
					}
				}
				
				switch (char.curCharacter.toLowerCase())
				{
					case 'normal':
						if (soulGlassTime)
						{
							health -= 0.018;
							if (health <= 0.01)
							{
								health = 0.01;
							}
						}
				}
				
				if(!note.isSustainNote && ClientPrefs.Shaders){
					if (camGlitchShader != null && char.curCharacter.startsWith('scorchedglitch'))
						camGlitchShader.amount += 0.075;
				}
			}
		}
		
		 if (curStage == 'needle') {
			var charDad2:Character = dad2;
			var animToPlayDad2:String = singAnimations[Std.int(Math.abs(note.noteData))];

			if(charDad2 != null)
			{
				charDad2.playAnim(animToPlayDad2, true);
				charDad2.holdTimer = 0;
			}
		}

		if (SONG.needsVoices)
			vocals.volume = 1;

		var time:Float = 0.15;
		if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
			time += 0.15;
		}
		if (SONG.isRing)
			StrumPlayAnim(true, Std.int(Math.abs(note.noteData)) % 5, time);
		else
			StrumPlayAnim(true, Std.int(Math.abs(note.noteData)) % 4, time);
		note.hitByOpponent = true;

		callOnLuas('opponentNoteHit', [notes.members.indexOf(note), Math.abs(note.noteData), note.noteType, note.isSustainNote]);

		if (!note.isSustainNote) {
			note.kill();
			notes.remove(note, true);
			note.destroy();
		}
		
	}

	function updateWires(){
		for(wireIdx in 0...barbedWires.members.length){
			var wire = barbedWires.members[wireIdx];
			wire.screenCenter();
			var flag:Bool = wire.extraInfo.get("inUse");
			if((wireIdx+1) <= hexes){
				if(!flag){
					if(wire.tweens.exists("disappear")){wire.tweens.get("disappear").cancel();wire.tweens.remove("disappear");}
					wire.alpha=1;
					wire.shake(0.01,0.05);
					wire.extraInfo.set("inUse",true);
				}
			}else{
				if(wire.tweens.exists("disappear")){wire.tweens.get("disappear").cancel();wire.tweens.remove("disappear");}
				if(flag){
					wire.extraInfo.set("inUse",false);
					wire.tweens.set("disappear", FlxTween.tween(wire, {
						alpha: 0,
						y: ((FlxG.height - wire.height)/2) + 75
					},0.2,{
						ease: FlxEase.quadIn,
						onComplete:function(tw:FlxTween){
							if(wire.tweens.get("disappear")==tw){
								wire.tweens.remove("disappear");
								wire.alpha=0;
							}
						}
					}));
				}

			}
		}
	}

	function goodNoteHit(note:Note):Void
	{
		if (!note.wasGoodHit) {
			if (ClientPrefs.hitsoundVolume > 0 && !note.hitsoundDisabled) {
				FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.hitsoundVolume);
			}

			if(cpuControlled && (note.ignoreNote || note.hitCausesMiss)) return;
			if(note.hitCausesMiss) {
				noteMiss(note);
				if(!note.noteSplashDisabled && !note.isSustainNote) {
					spawnNoteSplashOnNote(note);
				}

				switch(note.noteType) {
					case 'Hurt Note':
						if(boyfriend.animation.getByName('hurt') != null) {
							boyfriend.playAnim('hurt', true);
							boyfriend.specialAnim = true;
						}
						
					case 'Hex Note':
						hexes++;
						FlxG.sound.play(Paths.sound('hitWire', 'shared'));
						camOther.flash(0xFFAA0000, 0.35, null, true);
						hexTimer=0;
						updateWires();
						if(hexes > barbedWires.members.length){
							trace("die.");
							health = -10000; // you are dead
						}
						
					case 'Phantom Note':
						healthDrop += 0.00025;
						dropTime = 10;

					case 'Static Note':

					case 'Pixel Note':
					
					case 'Fatal Note':
						songMisses += 1;
						FatalStatic = new FlxSprite(0, 0);
						FatalStatic.frames = Paths.getSparrowAtlas('fatal-static', 'shared');
						FatalStatic.animation.addByPrefix('static', "static", 24, false);
						FatalStatic.animation.play('static');
						FatalStatic.cameras = [camHUD];
						FatalStatic.screenCenter();
						add(FatalStatic);
						
						FlxG.camera.shake(0.005, 0.005);

						FlxG.sound.play(Paths.sound("fatal-static"));

						new FlxTimer().start(0.40, function(trol:FlxTimer)
						{
							FatalStatic.alpha = 0;
							remove(FatalStatic);
						});
				}
				
				note.wasGoodHit = true;
				if (!note.isSustainNote)
				{
					note.kill();
					notes.remove(note, true);
					note.destroy();
				}
				return;
			}

			if (!note.isSustainNote && ((SONG.isRing && note.noteData != 2) || !SONG.isRing)) {
				combo += 1;
				popUpScore(note);
				if(combo > 9999) combo = 9999;
			}

			if (isRing && note.noteData == 2) {
				cNum += 1;
				FlxG.sound.play(Paths.sound('Ring', 'exe'));
			}
			
			if (!fucklesMode) {
				if (curSong != 'black-sun' && curSong != 'godspeed')
					health += note.hitHealth * healthGain;
			}
			
			if (isFear)
				fearNo -= 0.1;
			
			if(!note.noAnimation) {
				var daAlt = '';
				if(note.noteType == 'Alt Animation') daAlt = '-alt';
	
				var animToPlay:String = '';
				var curSection:Int = Math.floor(curStep / 16);

				if (SONG.isRing) {
					switch (Math.abs(note.noteData)) {
						case 0:
							animToPlay = 'singLEFT';
						case 1:
							animToPlay = 'singDOWN';
						case 2:
							animToPlay = 'daRing';
						case 3:
							animToPlay = 'singUP';
						case 4:
							animToPlay = 'singRIGHT';
					}
				} else {
					switch (Math.abs(note.noteData)) {
						case 0:
							animToPlay = 'singLEFT';
						case 1:
							animToPlay = 'singDOWN';
						case 2:
							animToPlay = 'singUP';
						case 3:
							animToPlay = 'singRIGHT';
					}
				}
				
				if (SONG.notes[curSection].mustHitSection && !noCamMove) 
					moveCameraOnNote(false, animToPlay);

				var char:Character = boyfriend;
				var ch:String = 'bf';
				if(note.gfNote) {
					char = gf;
					ch = 'gf';
				}

				if(note.noteType == 'GF and BF')
					triggerEventNote('Play Animation', animToPlay, ch);

				switch(char.animation.curAnim.name){
					case 'singUP', 'singDOWN', 'singLEFT', 'singRIGHT', 'singUP-alt', 'singDOWN-alt', 'singLEFT-alt', 'singRIGHT-alt':
						if (!bfIsLeft || FEHPThing == 2) {
							if (VHSui) iconP1.scale.set(0.9, 0.9);
							if (xenoEncUI) {
								iconP1.scale.set(1.1, 1.1);
								xenoEncIconP1.scale.set(0.6, 0.6);
							}
							if (!VHSui && !xenoEncUI) iconP1.scale.set(1.1, 1.1);
						} else {
							if (VHSui) iconP2.scale.set(0.9, 0.9);
							if (xenoEncUI) {
								iconP2.scale.set(1.1, 1.1);
								xenoEncIconP2.scale.set(1.1, 1.1);
							}
							if (!VHSui && !xenoEncUI) iconP2.scale.set(1.1, 1.1);
						}
				}

				if(note.gfNote) {
					if(gf != null) {
						gf.holdTimer = 0;
						if (animToPlay != 'daRing') {
							if (doubleNoteGhost) {
								if (!note.isSustainNote && noteRows[note.mustPress?0:1][note.row].length > 1) {
									var chord = noteRows[note.mustPress?0:1][note.row];
									var animNote = chord[0];
									if (gf.mostRecentRow != note.row) {
										gf.playAnim(animToPlay + daAlt, true);
									}

									if (!note.noAnimation) {
										if(gf.mostRecentRow != note.row)
											doGhostAnim('gf', animToPlay + daAlt);
										gf.mostRecentRow = note.row;
									} else {
										gf.playAnim(animToPlay + daAlt, true);
										gf.mostRecentRow = note.row;
									}
								} else {
									gf.playAnim(animToPlay + daAlt, true);
								}
							} else {
								gf.playAnim(animToPlay + daAlt, true);
							}
						}
					}
				} else {
					boyfriend.holdTimer = 0;
					if (animToPlay != 'daRing') {
						if (doubleNoteGhost) {
							if (!note.isSustainNote && noteRows[note.mustPress?0:1][note.row].length > 1) {
								var chord = noteRows[note.mustPress?0:1][note.row];
								var animNote = chord[0];
								if (boyfriend.mostRecentRow != note.row) {
									boyfriend.playAnim(animToPlay + daAlt, true);
								}

								if (!note.noAnimation) {
									if(boyfriend.mostRecentRow != note.row)
										doGhostAnim('bf', animToPlay + daAlt);
									boyfriend.mostRecentRow = note.row;
								} else {
									boyfriend.playAnim(animToPlay + daAlt, true);
									boyfriend.mostRecentRow = note.row;
								}
							} else {
								boyfriend.playAnim(animToPlay + daAlt, true);
							}
						} else {
							boyfriend.playAnim(animToPlay + daAlt, true);
						}
					}
				}

				if(note.noteType == 'Hey!') {
					if(boyfriend.animOffsets.exists('hey')) {
						boyfriend.playAnim('hey', true);
						boyfriend.specialAnim = true;
						boyfriend.heyTimer = 0.6;
					}
	
					if(gf != null && gf.animOffsets.exists('cheer')) {
						gf.playAnim('cheer', true);
						gf.specialAnim = true;
						gf.heyTimer = 0.6;
					}
				}
			}

			if(cpuControlled) {
				var time:Float = 0.15;
				if(note.isSustainNote && !note.animation.curAnim.name.endsWith('end')) {
					time += 0.15;
				}
				if (SONG.isRing)
					StrumPlayAnim(false, Std.int(Math.abs(note.noteData)) % 5, time);
				else
					StrumPlayAnim(false, Std.int(Math.abs(note.noteData)) % 4, time);
			} else {
				playerStrums.forEach(function(spr:StrumNote)
				{
					if (Math.abs(note.noteData) == spr.ID)
					{
						spr.playAnim('confirm', true);
					}
				});
			}
			note.wasGoodHit = true;
			vocals.volume = 1;

			var isSus:Bool = note.isSustainNote; //GET OUT OF MY HEAD, GET OUT OF MY HEAD, GET OUT OF MY HEAD
			var leData:Int = Math.round(Math.abs(note.noteData));
			var leType:String = note.noteType;
			callOnLuas('goodNoteHit', [notes.members.indexOf(note), leData, leType, isSus]);
			
			if (!note.isSustainNote)
			{
				note.kill();
				notes.remove(note, true);
				note.destroy();
			}
		}
		#if windows
		switch (SONG.song.toLowerCase()) {
			case 'fight-or-flight': if (!customIconAndName) lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Sacrifices: " + songMisses;
			case 'godspeed': if (!customIconAndName) lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Misses: " + songMisses;
			default:
				if (!customIconAndName) {
					if(!scoreRandom){
						lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Song: " + SONG.song.toLowerCase() + " | Score: " + songScore +  " | Misses: " + songMisses;
					} else {
						switch(FlxG.random.int(1, 6)) {
							case 1: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | S0mn: " + SONG.song.toLowerCase() + " | " + "sC0r3: " + songScore +  " | " + "m11ses: " + songMisses;
							case 2: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | kFd5: " + SONG.song.toLowerCase() + " | " + "mIsees: " + songScore +  " | " + "raITNtg: " + songMisses;
							case 3: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | 50Hg: " + SONG.song.toLowerCase() + " | " + "Ra11utNg: " + songScore +  " | " + "scIrh4: " + songMisses;
							case 4: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | 2Un6: " + SONG.song.toLowerCase() + " | " + "342hj1: " + songScore +  " | " + "5436yu: " + songMisses;
							case 5: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | C8nq: " + SONG.song.toLowerCase() + " | " + "agehjk3: " + songScore +  " | " + "4uihja: " + songMisses;
							case 6: lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe | Gtf5: " + SONG.song.toLowerCase() + " | " + "4276uihj: " + songScore +  " | " + "a7d5hf: " + songMisses;
						}
					}
				}
		}
		#end
	}

	function spawnNoteSplashOnNote(note:Note) {
		if(ClientPrefs.noteSplashes && note != null) {
			var strum:StrumNote = playerStrums.members[note.noteData];
			if (strum != null)
			{
				return spawnNoteSplash(strum.x, strum.y, note.noteData, note);
			}
		}
	}

	public function spawnNoteSplash(x:Float, y:Float, data:Int, ?note:Note = null) {
		var skin:String = 'BloodSplash';
		
		var hue:Float=0;
		var sat:Float=0;
		var brt:Float=0;
		
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;
		
		if(note != null) {
			skin = note.noteSplashTexture;
			hue = note.noteSplashHue;
			sat = note.noteSplashSat;
			brt = note.noteSplashBrt;
		}
		
		if (!customNoteColors) {
			if (!ClientPrefs.arrowColorsRGB && noteChangesFromTheStore) {
				hue = ClientPrefs.arrowHSV[data % 4][0] / 360;
				sat = ClientPrefs.arrowHSV[data % 4][1] / 100;
				brt = ClientPrefs.arrowHSV[data % 4][2] / 100;
			}
		} else {
			hue = customArrowColors[data % 4][0] / 360;
			sat = customArrowColors[data % 4][1] / 100;
			brt = customArrowColors[data % 4][2] / 100;
		}
		
		var splash:NoteSplash = grpNoteSplashes.recycle(NoteSplash);
		splash.setupNoteSplash(x, y, data, skin, hue, sat, brt);
		grpNoteSplashes.add(splash);
	}

	function fucklesDeluxe()
	{
		health = 2;
		//songMisses = 0;
		fucklesMode = true;

		timeBarBG.visible = false;
		if (bgTBSkin == 'tbR') timeBarBGBG.visible = false;
		timeBar.visible = false;
		timeTxt.visible = false;
		scoreTxt.visible = false;

		opponentStrums.forEach(function(spr:FlxSprite)
		{
			spr.x += 10000;
		});
	}

	var fuckedMode:Bool = false;

	function fucklesFinale()
	{
		if (fucklesMode)
			fuckedMode = true;
		if (fuckedMode)
		{
			health -= 0.1;
			if (health <= 0.01)
			{
				health = 0.01;
				fuckedMode = false;
			}
		}
	}

	function fucklesHealthRandomize()
	{
		if (fucklesMode)
			health = FlxG.random.float(0.5, 2);
		trace('fuck your health!');
	}
	
	function chromaVideo(name:String){
		var video:MP4Sprite = new MP4Sprite(0,0);
		video.scrollFactor.set();
		video.cameras = [camHUD];
		video.shader = new shaders.GreenScreenShader();
		video.finishCallback = function(){
			trace("video gone");
			remove(video);
			video.destroy();
		}
		video.playVideo(Paths.video(name));
		add(video);
	}

	function majinSaysFuck(numb:Int):Void
		{
			switch(numb)
			{
				case 4:
					MajinCountThree.alpha = 0.5;
					add(MajinCountThree);
					FlxTween.tween(MajinCountThree, {y: MajinCountThree.y + 100, alpha: 0, "scale.x": 1.05, "scale.y": 1.05}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeOut,
						onComplete: function(twn:FlxTween)
						{
							MajinCountThree.destroy();
						}
					});
				case 3:
					MajinCountTwo.alpha = 0.5;
					add(MajinCountTwo);
					FlxTween.tween(MajinCountTwo, {y: MajinCountTwo.y + 100, alpha: 0, "scale.x": 1.05, "scale.y": 1.05}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeOut,
						onComplete: function(twn:FlxTween)
						{
							MajinCountTwo.destroy();
						}
					});
				case 2:
					MajinCountOne.alpha = 0.5;
					add(MajinCountOne);
					FlxTween.tween(MajinCountOne, {y: MajinCountOne.y + 100, alpha: 0, "scale.x": 1.05, "scale.y": 1.05}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeOut,
						onComplete: function(twn:FlxTween)
						{
							MajinCountOne.destroy();
						}
					});
				case 1:
					MajinCountGo.alpha = 0.5;
					add(MajinCountGo);
					FlxTween.tween(MajinCountGo, {y: MajinCountGo.y + 100, alpha: 0, "scale.x": 1.05, "scale.y": 1.05}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							MajinCountGo.destroy();
						}
					});
			}
		}

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	var carTimer:FlxTimer;
	function fastCarDrive()
	{
		//trace('Car drive');
		FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		carTimer = new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
			carTimer = null;
		});
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			if (gf != null)
			{
				gf.playAnim('hairBlow');
				gf.specialAnim = true;
			}
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		if(gf != null)
		{
			gf.danced = false; //Sets head to the correct position once the animation ends
			gf.playAnim('hairFall');
			gf.specialAnim = true;
		}
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		if(!ClientPrefs.lowQuality) halloweenBG.animation.play('halloweem bg lightning strike');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		if(boyfriend.animOffsets.exists('scared')) {
			boyfriend.playAnim('scared', true);
		}

		if(gf != null && gf.animOffsets.exists('scared')) {
			gf.playAnim('scared', true);
		}

		if(ClientPrefs.camZooms) {
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;

			if(!camZooming) { //Just a way for preventing it to be permanently zoomed until Skid & Pump hits a note
				FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.5);
				FlxTween.tween(camHUD, {zoom: 1}, 0.5);
			}
		}

		if(ClientPrefs.flashing) {
			halloweenWhite.alpha = 0.4;
			FlxTween.tween(halloweenWhite, {alpha: 0.5}, 0.075);
			FlxTween.tween(halloweenWhite, {alpha: 0}, 0.25, {startDelay: 0.15});
		}
	}

	function killHenchmen():Void
	{
		if(!ClientPrefs.lowQuality && ClientPrefs.violence && curStage == 'limo') {
			if(limoKillingState < 1) {
				limoMetalPole.x = -400;
				limoMetalPole.visible = true;
				limoLight.visible = true;
				limoCorpse.visible = false;
				limoCorpseTwo.visible = false;
				limoKillingState = 1;

				#if ACHIEVEMENTS_ALLOWED
				Achievements.henchmenDeath++;
				FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;
				var achieve:String = checkForAchievement(['roadkill_enthusiast']);
				if (achieve != null) {
					startAchievement(achieve);
				} else {
					FlxG.save.flush();
				}
				FlxG.log.add('Deaths: ' + Achievements.henchmenDeath);
				#end
			}
		}
	}

	function resetLimoKill():Void
	{
		if(curStage == 'limo') {
			limoMetalPole.x = -500;
			limoMetalPole.visible = false;
			limoLight.x = -500;
			limoLight.visible = false;
			limoCorpse.x = -500;
			limoCorpse.visible = false;
			limoCorpseTwo.x = -500;
			limoCorpseTwo.visible = false;
		}
	}

	private var preventLuaRemove:Bool = false;
	override function destroy() {
		#if windows
		lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe";
		if (customIconAndName) {
			var Icon:Image = Image.fromFile('assets/exe/images/windowIcons/iconGame.png');
			lime.app.Application.current.window.setIcon(Icon);
			customIconAndName = false;
		}
		#end
		preventLuaRemove = true;
		for (i in 0...luaArray.length) {
			luaArray[i].call('onDestroy', []);
			luaArray[i].stop();
		}
		#if windows
		if (curStage == 'fatal-encore')
			FlxG.fullscreen = false;
		#end
		luaArray = [];
		#if hscript
		if(FunkinLua.hscript != null) FunkinLua.hscript = null;
		#end

		if(!ClientPrefs.controllerMode)
		{
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			FlxG.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		super.destroy();
	}

	var glitchShaders:Array<GlitchShaderA> = [];

	function glitchKill(spr:FlxSprite,dontKill:Bool=false){
		if (ClientPrefs.Shaders) {
			var shader = new GlitchShaderA();
			shader.iResolution.value = [spr.width, spr.height];
			piss.push(FlxTween.tween(shader, {amount: 1.25}, 2, {
				ease: FlxEase.cubeInOut,
				onComplete: function(tw: FlxTween){
					glitchShaders.remove(shader);
					spr.visible=false;
					if(!dontKill){
						remove(spr);
						spr.destroy();
					}
				}
			}));
			glitchShaders.push(shader);
			spr.shader = shader;
		}
	}

	public static function cancelMusicFadeTween() {
		if(FlxG.sound.music.fadeTween != null) {
			FlxG.sound.music.fadeTween.cancel();
		}
		FlxG.sound.music.fadeTween = null;
	}

	public function removeLua(lua:FunkinLua) {
		if(luaArray != null && !preventLuaRemove) {
			luaArray.remove(lua);
		}
	}

	var lastStepHit:Int = -1;
	override function stepHit()
	{
		super.stepHit();
		
		if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
			if(curStep % 32 == 0 && scorchedMonitor!=null && scorchedMonitor.visible && scorchedMonitor.alive){
				monitorCounter++;
				if(monitorCounter >= monitorAnims.length)monitorCounter=0;
				scorchedMonitor.animation.play(monitorAnims[monitorCounter], true);
			}
		}
		
		if (curStep > 5)
			doubleNoteGhost = true;
		
		if (SONG.song.toLowerCase() == 'substantial' && !ClientPrefs.PotatoOptimization) {
			preload('xterion/bg2D', 'exe');
			preload('characters/XTerion/2D/xterion-2D');
			switch (curStep)
			{
				case 1964:
					remove(xterionFloor);
					remove(xterionSky);
			}
		}
		if (SONG.song.toLowerCase() == 'nostalgic-duo' && !ClientPrefs.PotatoOptimization) {
			preload('bgs/nostalgic-duo/sanicbg-2');
			preload('bgs/nostalgic-duo/sanicbg-3');
		}
		if (SONG.song.toLowerCase() == 'chaos') {
			switch (curStep) {
				case 1:
					FlxTween.tween(blackFuck, {alpha: 1}, 0.25);
					FlxTween.tween(startCircle, {alpha: 1}, 0.25);
					FlxTween.tween(startText, {alpha: 1}, 0.25);
					FlxTween.tween(camHUD, {alpha: 0}, 0.25);
					new FlxTimer().start(0.6, function(tmr:FlxTimer)
					{
						FlxTween.tween(startCircle, {x: 0}, 0.5);
						FlxTween.tween(startText, {x: 0}, 0.5);
					});

					new FlxTimer().start(1.9, function(tmr:FlxTimer)
					{
						FlxTween.tween(camHUD, {alpha: 1}, 1);
						FlxTween.tween(blackFuck, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(blackFuck);
								blackFuck.destroy();
							}
						});
						FlxTween.tween(startCircle, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startCircle);
								startCircle.destroy();
							}
						});
						FlxTween.tween(startText, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startText);
								startText.destroy();
							}
						});
					});
				case 9:
					dad.visible = true;
					FlxTween.tween(dad, {y: dad.y - 500}, 0.5, {ease: FlxEase.cubeOut});
				case 16:
					dad.playAnim('fastanim', true);
					dad.specialAnim = true;
					boyfriendGroup.visible = true;
					FlxTween.tween(dad, {x: 61.15, y: -94.75}, 2, {ease: FlxEase.cubeOut});
				case 64:
					dad.specialAnim = false;
					tailscircle = 'hovering';
					camHUD.visible = true;
					camHUD.alpha = 0;
					cinematicBars(false);
					FlxTween.tween(camHUD, {alpha: 1}, 0.2, {ease: FlxEase.cubeOut});
				case 256:
					laserThingy();
					canDodge = true;
				case 380, 509, 637, 773, 1033, 1149, 1261, 1543, 1672, 1792, 1936:
					tailscircle = '';
					FlxTween.tween(dad, {x: 61.15, y: -94.75}, 0.2);
					dad.setPosition(61.15, -94.75);
				case 398, 527, 655, 783, 1039, 1167, 1295, 1551, 1679, 1807, 1951:
					dad.specialAnim = false;
					tailscircle = 'hovering';
				case 1008:
					FlxG.camera.shake(0.02, 0.2);
					FlxG.camera.flash(FlxColor.YELLOW, 0.2);
					FlxG.sound.play(Paths.sound('SUPERBF', 'exe'));
					boyfriend.scrollFactor.set(1.1, 1);
				case 1260, 1543, 1672, 1792, 1936:
					switch (curStep)
					{
						case 1260:
							dad.playAnim('Ill show you', true);
							dad.specialAnim = true;

						case 1543:
							dad.playAnim('AAAA', true);
							dad.specialAnim = true;

						case 1672:
							dad.playAnim('Growl', true);
							dad.specialAnim = true;

						case 1792:
							dad.playAnim('Shut up', true);
							dad.specialAnim = true;

						case 1936:
							dad.playAnim('Right Alt', true);
							dad.specialAnim = true;
					}
				case 383, 512, 640, 776, 1036, 1152:
					switch (curStep)
					{
						case 383:
							dad.playAnim('Step it up', true);
							dad.specialAnim = true;

						case 512:
							dad.playAnim('lmao', true);
							dad.specialAnim = true;

						case 640:
							dad.playAnim('fatphobia', true);
							dad.specialAnim = true;

						case 776:
							dad.playAnim('Finished', true);
							dad.specialAnim = true;

						case 1036:
							dad.playAnim('WHAT', true);
							dad.specialAnim = true;

						case 1152:
							dad.playAnim('Grrr', true);
							dad.specialAnim = true;
					}
			}
		}
			
		if (SONG.song.toLowerCase() == 'running-wild') {
			switch (curStep) {
				case 512:
					laserThingy();
					canDodge = true;
			}
		}
			
		if (SONG.song.toLowerCase() == 'chaos-encore') {
			switch (curStep) {
				case 504:
					laserThingy();
					canDodge = true;
			}
		}
		
		if(curSong == 'endless'){
			switch(curStep){
				case 1:
					timeBar.createFilledBar(0xFF000000, 0xFF5f41a1);
					TimeBarColorOne = 0xFF000000;
					TimeBarColorTwo = 0xFF5f41a1;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 886:
					FlxTween.tween(camHUD, {alpha: 0}, 0.5);

				case 900:
					removeStatics();
					generateStaticArrows(0);
					generateStaticArrows(1);
					FlxTween.tween(camHUD, {alpha: 1}, 0.5);
			}
		}
		
		if (SONG.song.toLowerCase() == 'godspeed')
			{
				switch (curStep)
					{
						case 800:
							RunTextFlashSpeed = 1;
							
						case 1456:
							RunTextFlashSpeed = 2;
							
						case 2272:
							RunTextFlashSpeed = 3;
							
						case 2788:
							RunTextFlashSpeed = 4;
							starvedSpeed = 110;
					}
			}
		
		if (curStage == 'needle-p2' && SONG.song.toLowerCase() == 'spike-trap')
		{
			switch (curStep)
			{	
				case 128:
					defaultCamZoom = 0.6;
					if (!ClientPrefs.PotatoOptimization) {
						needleSkyZERO.alpha = 0;
						needleSkyONE.alpha = 1;
						needleMoutainsZERO.alpha = 0;
						needleMoutainsONE.alpha = 1;
					}
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						needleRuinsZERO.alpha = 0;
						needleRuinsONE.alpha = 1;
					}
					if (!ClientPrefs.PotatoOptimization) needleBuildingsZERO.alpha = 0;
					if (!ClientPrefs.PotatoOptimization) needleBuildingsONE.alpha = 1;
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						needleFgZERO.alpha = 0;
						needleFgONE.alpha = 1;
					}
				case 384:
					defaultCamZoom = 0.75;
				case 512:
					defaultCamZoom = 0.7;
				case 640:
					defaultCamZoom = 0.75;
				case 768:
					if (!ClientPrefs.PotatoOptimization) {
						needleSkyONE.alpha = 0;
						needleSkyTWO.alpha = 1;
						needleMoutainsONE.alpha = 0;
						needleMoutainsTWO.alpha = 1;
					}
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						needleRuinsONE.alpha = 0;
						needleRuinsTWO.alpha = 1;
					}
					if (!ClientPrefs.PotatoOptimization) needleBuildingsONE.alpha = 0;
					if (!ClientPrefs.PotatoOptimization) needleBuildingsTWO.alpha = 1;
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						needleFgONE.alpha = 0;
						needleFgTWO.alpha = 1;
					}
				case 896:
					defaultCamZoom = 0.65;
				case 918,924,954,982,988,1018,1024,1416,1632,1664,1808,1840,1888:
					defaultCamZoom = 0.75;
				case 922,950,956,986,1014,1020,1408,1648,1792,1824,1856,1920:
					defaultCamZoom = 0.6;
				case 1152:
					defaultCamZoom = 0.6;
					if (!ClientPrefs.PotatoOptimization) {
						needleSkyTWO.alpha = 0;
						needleSkyTHREE.alpha = 1;
						needleMoutainsTWO.alpha = 0;
						needleMoutainsTHREE.alpha = 1;
					}
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						needleFgTWO.alpha = 0;
						needleFgTHREE.alpha = 0;
					}
				case 1280:
					defaultCamZoom = 0.75;
				case 1536:
					defaultCamZoom = 0.6;
			}
		}
		if (curStage == 'needle' && SONG.song.toLowerCase() == 'round-a-bout')
		{
			switch (curStep)
			{	
				case 741:
					if (!ClientPrefs.PotatoOptimization) FlxTween.tween(darkthing, {alpha: 0.7}, 1.3, {ease: FlxEase.quadInOut});
					defaultCamZoom = 0.9;
				case 756:
					FlxTween.tween(dad2, {alpha: 1}, 1.3, {ease: FlxEase.quadInOut});
					if (!ClientPrefs.PotatoOptimization) FlxTween.tween(darkthing, {alpha: 0}, 1.3, {ease: FlxEase.quadInOut});
					defaultCamZoom = 0.6;
				case 770:		
					var oki:Float = -0.1;
					new FlxTimer().start(0.1, function(ok:FlxTimer)
					{
						if (dad2.alpha <= 0.5) oki = 0.01;
						if (dad2.alpha >= 1) oki = -0.01;
						dad2.alpha += oki;
						ok.reset();
					});
				case 962:
					FlxTween.tween(dad2, {alpha: 0}, 2.2, {ease: FlxEase.quadInOut});
				case 978:
					dad2.visible = false;
			}
		}

		if (curStage == 'requite' && SONG.song.toLowerCase() == 'forestall-desire')
		{
			switch (curStep)
			{
				case 1313:
					bfIsLeft = true;
			}
		}

		if (SONG.song.toLowerCase() == 'fight-or-flight')
		{
			switch (curStep)
			{
				case 1:
					timeBar.createFilledBar(FlxColor.RED, 0xFF000000);
					TimeBarColorOne = FlxColor.RED;
					TimeBarColorTwo = 0xFF000000;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					if (curStage == 'starved')
					{
						if (!ClientPrefs.middleScroll)
							{
								playerStrums.forEach(function(spr:StrumNote)
								{
									spr.alpha = 0.65;
								});
							}
					}
			}
		}
		
		if (SONG.song.toLowerCase() == 'found-you')
		{
			switch (curStep)
			{
				case 1:
					if (!ClientPrefs.PotatoOptimization) normalDoor.animation.play('idle');
				case 25, 48, 56:
					FlxG.camera.zoom += 0.15;
				case 2:
					defaultCamZoom = 1.35; //1.35
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadInOut});
				case 64, 72:
					FlxG.camera.zoom += 0.05;
				case 76:
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 2, {ease: FlxEase.cubeInOut});
				case 93:
					dad.visible = true;
					camGame.shake(0.01, 1);
					defaultCamZoom = 1.35;
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1, {ease: FlxEase.quadInOut});
				case 94:
					FlxTween.tween(dad, {x: 100}, 0.5, {ease: FlxEase.quadOut});
				case 113:
					defaultCamZoom = 0.85;
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.35, {ease: FlxEase.quadOut});
				case 160:
					normalBool = true; 
					FlxG.camera.focusOn(dad.getPosition());
					camHUD.visible = true;
					camHUD.zoom += 2;
					FlxTween.tween(camHUD, {alpha: 1}, 1);
				case 416, 1184, 1696, 2720:
					wowZoomin = true;
				case 800, 1311, 1823, 2847:
					wowZoomin = false;
				case 928, 1312, 1824, 2080, 3361, 2336, 2848, 3782:
					holyFuckStopZoomin = true;
				case 1056, 1568, 2079, 2335, 3871, 2591, 3359, 4138:
					holyFuckStopZoomin = false;
				case 3360:
					GFIconChange = false;
					iconP1.changeIcon('duo');
				case 2081, 2719, 2848:
					chaotixGlass(1);
				case 2816, 2976:
					revivedIsPissed(1);
				case 2145:
					chaotixGlass(2);
				case 2334:
					revivedIsPissed(1);
					revivedIsPissed(2);
				case 3362:
					chaotixGlass(1);
					chaotixGlass(2);
				case 4135:
					revivedIsPissed(1);
					revivedIsPissed(2);
			}
		}
		
		if (SONG.song.toLowerCase() == 'final-escape')
		{
			switch (curStep)
			{
				case 32:
					FlxTween.tween(blackFuck, {alpha: 1}, 0.25);
					FlxTween.tween(startCircle, {alpha: 1}, 0.25);
					FlxTween.tween(startText, {alpha: 1}, 0.25);
					new FlxTimer().start(0.6, function(tmr:FlxTimer)
					{
						FlxTween.tween(startCircle, {x: 0}, 0.5);
						FlxTween.tween(startText, {x: 0}, 0.5);
					});

					new FlxTimer().start(1.9, function(tmr:FlxTimer)
					{
						FlxTween.tween(blackFuck, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(blackFuck);
								blackFuck.destroy();
							}
						});
						FlxTween.tween(startCircle, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startCircle);
								startCircle.destroy();
							}
						});
						FlxTween.tween(startText, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startText);
								startText.destroy();
							}
						});
					});
				case 288:
					bfIsLeft = true;
					reloadHealthBarColors();
					FEHPThing = 2;
					iconOffset = -15;
					healthBarBG.angle -= 90;
					healthBarBG.y = FlxG.height * 0.89;
					healthBarBG.screenCenter(X);
					healthBarBG.xAdd = -25;
					healthBarBG.yAdd = -4;
					if(ClientPrefs.downScroll && !offDownScroll) healthBarBG.y = 0.11 * FlxG.height;
					healthBar.angle -= 90;
					healthBar.x = healthBarBG.x + ShitO;
					healthBar.y = healthBarBG.y + 4;
					iconP1.x -= 1050;
					iconP2.x -= 1050;
					iconP1.y = healthBar.y - 75;
					iconP2.y = healthBar.y - 75;
					healthBar.alpha = 1;
					healthBarBG.alpha = 1;
					scoreTxt.alpha = 1;
				case 2398:
					bfIsLeft = false;
					iconP1.flipX = true;
					reloadHealthBarColors();
					FEHPThing = 0;
					iconOffset = 26;
				case 3128:
					bfIsLeft = true;
					iconP1.flipX = false;
					reloadHealthBarColors();
					FEHPThing = 2;
					iconOffset = -15;
			}
		}
		
		if (SONG.song.toLowerCase() == 'my-horizon')
		{
			switch (curStep)
			{
				case 896:
					FlxTween.tween(camHUD, {alpha: 0}, 2.2);
				case 908:
					dad.playAnim('transformation', true);
					dad.specialAnim = true;
					camZooming = false;
					cinematicBars(true);
				case 924:
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.5}, 12, {ease: FlxEase.cubeInOut});
					FlxTween.tween(whiteFuck, {alpha: 1}, 6, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
						{
							if (!ClientPrefs.PotatoOptimization) {
								remove(fucklesFGPixel);
								remove(fucklesBGPixel);
								fucklesBGPixel.destroy();
								fucklesFGPixel.destroy();
								fucklesFuckedUpBg.visible = true;
								fucklesFuckedUpFg.visible = true;
							}
						}
					});
					timeBar.createFilledBar(0x00FF0000, 0xFF687880);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF687880;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 975:
					cinematicBars(false);
				case 992:
					literallyMyHorizon();
				case 1120, 1248, 1376, 1632, 1888, 1952, 2048, 2054, 2060:
					fucklesHealthRandomize();
					camHUD.shake(0.005, 1);
				case 1121, 1760:
					superZoomShit = true;
				case 1503, 2015:
					superZoomShit = false;
				case 1504, 2080:
					supersuperZoomShit = true;
				case 1759, 2336:
					supersuperZoomShit = false;
				case 2208, 2222, 2240, 2254, 2320, 2324, 2328:
					fucklesFinale();
					camHUD.shake(0.003, 1);
				case 2337:
					camZooming = false;
			}
		}
		
		if (SONG.song.toLowerCase() == 'our-horizon') {
			switch (curStep) {
				case 960, 2840:
					triggerEventNote('Genesis', '2', '');
				case 2330:
					triggerEventNote('Genesis', '1', '');
				case 765:
					FlxTween.tween(camHUD, {alpha: 0}, 1.2);
					dad.playAnim('transformation', true);
					dad.specialAnim = true;
					camZooming = false;
				case 800:
					FlxTween.tween(whiteFuck, {alpha: 1}, 6, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween) { removeShit(1); }});
					FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.5}, 12, {ease: FlxEase.cubeInOut});
				case 912:
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1.5, {ease: FlxEase.cubeInOut});
					iconP2.changeIcon(dad.healthIcon);
				case 920:
					FlxTween.tween(dad, {alpha: 0}, 0.5, {ease: FlxEase.cubeInOut});
					FlxTween.tween(boyfriend, {alpha: 0}, 0.5, {ease: FlxEase.cubeInOut});
					FlxTween.tween(gf, {alpha: 0}, 0.5, {ease: FlxEase.cubeInOut});
				case 927:
					dad.specialAnim = false;
					FlxG.camera.zoom += 2;
				case 1000:
					snapCamFollowToPos(700, 900);
					defaultCamZoom = 0.7;
					dad.setPosition(200, 700);
					boyfriend.setPosition(900, 950);
					literallyOurHorizon();
					removeShit(2);
				case 2336:
					timeBar.createFilledBar(0x00FF0000, 0xFF687880);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF687880;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					
					snapCamFollowToPos(BF_X, BF_Y + 400);
					defaultCamZoom = 0.7;
					dad.setPosition(DAD_X, DAD_Y);
					boyfriend.setPosition(BF_X, BF_Y);
					startCharacterPos(dad, true);
					startCharacterPos(boyfriend);

					GameOverSubstate.deathSoundName = 'chaotix-death';
					GameOverSubstate.loopSoundName = 'chaotix-gameover';
					GameOverSubstate.endSoundName = 'chaotix-retry';
					GameOverSubstate.characterName = 'bf-chaotix-death';

					defaultCamZoom = 0.87;
					camZooming = true;
					FlxG.camera.zoom = defaultCamZoom;
					camHUD.alpha = 1;
					dad.alpha = 1;
					boyfriend.alpha = 1;
					gf.alpha = 1;
					
					if (!ClientPrefs.PotatoOptimization) {
						fucklesEspioBg.animation.resume();
						fucklesMightyBg.animation.resume();
						fucklesCharmyBg.animation.resume();
						fucklesAmyBg.animation.resume();
						fucklesKnuxBg.animation.resume();
						fucklesVectorBg.animation.resume();
						fucklesEspioBg.visible = true;
						fucklesMightyBg.visible = true;
						fucklesCharmyBg.visible = true;
						fucklesAmyBg.visible = true;
						fucklesKnuxBg.visible = true;
						fucklesVectorBg.visible = true;

						fucklesBGPixel.visible = true;
						fucklesFGPixel.visible = true;

						horizonBg.visible = false;
						horizonFloor.visible = false;
						horizonTrees.visible = false;
						horizonTrees2.visible = false;

						horizonPurpur.visible = false;
						horizonYellow.visible = false;
						horizonRed.visible = false;
					}
					
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						horizonAmy.visible = false;
						horizonCharmy.visible = false;
						horizonEspio.visible = false;
						horizonMighty.visible = false;
						horizonKnuckles.visible = false;
						horizonVector.visible = false;
					}

					FlxG.camera.flash(FlxColor.WHITE, 2);
				case 2848:
					timeBar.createFilledBar(0x00FF0000, 0xFF7665D0);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF7665D0;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					
					isPixelStage = false;
					camZooming = true;
					FlxG.camera.zoom = defaultCamZoom;
					GameOverSubstate.deathSoundName = 'fnf_loss_sfx';
					GameOverSubstate.loopSoundName = 'gameOver';
					GameOverSubstate.endSoundName = 'gameOverEnd';
					GameOverSubstate.characterName = 'bf-holding-gf-dead';
					gf.alpha = 0;
					snapCamFollowToPos(700, 900);
					defaultCamZoom = 0.7;
					dad.setPosition(200, 700);
					boyfriend.setPosition(900, 950);
							
					if (!ClientPrefs.PotatoOptimization) {
						fucklesBGPixel.visible = false;
						fucklesFGPixel.visible = false;

						horizonBg.visible = true;
						horizonFloor.visible = true;
						horizonTrees.visible = true;
						horizonTrees2.visible = true;

						horizonPurpur.visible = true;
						horizonYellow.visible = true;
						horizonRed.visible = true;
					}
					
					if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
						horizonAmy.visible = true;
						horizonCharmy.visible = true;
						horizonEspio.visible = true;
						horizonMighty.visible = true;
						horizonKnuckles.visible = true;
						horizonVector.visible = true;
					}

					opponentStrums.forEach(function(spr:FlxSprite) {
						spr.x += 10000;
					});
					FlxG.camera.flash(FlxColor.WHITE, 2);
					
					removeShit(2);
				case 2976:
					FlxTween.tween(camHUD, {alpha: 0}, 2);
				case 2992:
					var fuckinCamShit:FlxObject;
					fuckinCamShit = new FlxObject(700, 950, 1, 1);
					FlxG.camera.follow(fuckinCamShit, LOCKON, 0.06 * (30 / (cast(Lib.current.getChildAt(0), Main)).getFPS()));
					fireWorksDeluxe();
				case 3104:
					removeShit(3);
					FlxG.camera.flash(FlxColor.WHITE, 2);
			}
		}
		
		if (curStage == 'scrapped-tte-smash' && SONG.song.toLowerCase()=='scrapped-tte-smash') {
			switch (curStep) {
				case 1: //Tails
					timeBar.createFilledBar(0x00FF0000, 0xFF191919);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF191919;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.quadInOut});
					
				case 16:
					FlxTween.cancelTweensOf(FlxG.camera);
					FlxTween.tween(FlxG.camera, {zoom: 0.85}, 1, {ease: FlxEase.elasticOut});
					
				case 1040: //Xeno Left
					timeBar.createFilledBar(0x00FF0000, 0xFF2B145F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF2B145F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.9;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
					
				case 1296: //Knuckles Right
					timeBar.createFilledBar(0x00FF0000, 0xFF600000);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF600000;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}

					defaultCamZoom = 0.7;
					
				case 2320: //Xeno Right
					dad.x += 100;
					timeBar.createFilledBar(0x00FF0000, 0xFF2B145F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF2B145F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					iconP1.changeIcon('icon-BEAST');

					defaultCamZoom = 0.9;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;

						grassXeno.angle = -30;
						backtreesXeno.y += 70;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
					
				case 2832:
					//BlackBGTT.alpha = 1;
					
				case 2842: // Eggman Left
					timeBar.createFilledBar(0x00FF0000, 0xFF5D3E00);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF5D3E00;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					
					defaultCamZoom = 0.7;
					
					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						fgTree1.x += -50;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}
					
				case 2843:
					//BlackBGTT.alpha = 0;
					
				case 4122: //Xeno Left
					timeBar.createFilledBar(0x00FF0000, 0xFF2B145F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF2B145F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.9;
					
					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
						
						fgTree1.x += 50;

						grassXeno.angle = 0;
						backtreesXeno.y -= 70;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
					
				case 5148:
					//BlackBGTT.alpha = 1;
					
				case 5340: //Amy Left
					dad.x -= 100;
					timeBar.createFilledBar(0x00FF0000, 0xFFB8739B);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFFB8739B;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					
					defaultCamZoom = 0.7;
					
					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;
						
						fgTree1.x += -50;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}
					
				case 5341:
					//BlackBGTT.alpha = 0;

				case 6489: //Xeno Left
					timeBar.createFilledBar(0x00FF0000, 0xFF2B145F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF2B145F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.9;
					
					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
						
						fgTree1.x += 50;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
					
				case 7002: //Shadow Right
					timeBar.createFilledBar(0x00FF0000, 0xFF00173F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF00173F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.7;
					
					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}
					
				case 8058: //Xeno Right
					dad.x += 100;
					timeBar.createFilledBar(0x00FF0000, 0xFF2B145F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF2B145F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					iconP1.changeIcon('icon-BEAST');

					defaultCamZoom = 0.9;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;

						grassXeno.angle = -30;
						backtreesXeno.y += 70;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
					
				case 8516: //Tails Left
					//dad.x -= 100;
					timeBar.createFilledBar(0x00FF0000, 0xFF191919);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF191919;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.85;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						fgTree1.x += -50;

						grassXeno.angle = 0;
						backtreesXeno.y -= 70;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}
					
				case 8746: //Knuckles Right
					timeBar.createFilledBar(0x00FF0000, 0xFF600000);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF600000;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.7;
					
				case 8858: // Eggman Left
					timeBar.createFilledBar(0x00FF0000, 0xFF5D3E00);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF5D3E00;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					
					defaultCamZoom = 0.7;
					
				case 8973: // Amy Left
					timeBar.createFilledBar(0x00FF0000, 0xFFB8739B);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFFB8739B;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					
					defaultCamZoom = 0.7;
					
				case 9082: //Shadow Right
					timeBar.createFilledBar(0x00FF0000, 0xFF00173F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF00173F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.7;
					
				case 9201: //Xeno Left
					timeBar.createFilledBar(0x00FF0000, 0xFF2B145F);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF2B145F;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.9;
					
					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
						
						fgTree1.x += 50;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}

			}
		}
		
		if (curStage == 'trioStage' && SONG.song.toLowerCase()=='triple-trouble')
		{
			switch (curStep)
			{
				case 1:
					timeBar.createFilledBar(0x007F7E7E, 0xFF7F7E7E);
					TimeBarColorOne = 0x007F7E7E;
					TimeBarColorTwo = 0xFF7F7E7E;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.quadInOut});
				case 16:
					FlxTween.cancelTweensOf(FlxG.camera);
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1, {ease: FlxEase.elasticOut});
				case 399:
					superZoomShit = true;
				case 400:
					defaultCamZoom = 0.75;
				case 416:
					defaultCamZoom = 0.80;
				case 432:
					defaultCamZoom = 0.85;
				case 448:
					defaultCamZoom = 0.9;
				case 464:
					defaultCamZoom = 0.95;
				case 480:
					defaultCamZoom = 1;
				case 496:
					defaultCamZoom = 1.05;
				case 512:
					defaultCamZoom = 1.1;
				case 527:
					supersuperZoomShit = true;
					superZoomShit = false;
				case 528:
					defaultCamZoom = 0.7;
				case 783:
					supersuperZoomShit = false;
				case 1040:
					timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
					TimeBarColorOne = 0x00D416E3;
					TimeBarColorTwo = 0xFFD416E3;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.9;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}

				case 1072:
					vg = new FlxSprite().loadGraphic(Paths.image('RedVG', 'exe'));
					vg.alpha = 0;
					vg.cameras = [camHUD];
					add(vg);

					FlxTween.tween(vg, {alpha: 0.90}, 2.5, {ease: FlxEase.quadInOut});
				case 1104:
					FlxTween.cancelTweensOf(vg);
					FlxTween.tween(vg, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
				case 1136:
					vg = new FlxSprite().loadGraphic(Paths.image('RedVG', 'exe'));
					vg.alpha = 0;
					vg.cameras = [camHUD];
					add(vg);

					FlxTween.tween(vg, {alpha: 0.90}, 2.5, {ease: FlxEase.quadInOut});
				case 1168:
					FlxTween.cancelTweensOf(vg);
					FlxTween.tween(vg, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});
				case 1264:
					vg = new FlxSprite().loadGraphic(Paths.image('RedVG', 'exe'));
					vg.alpha = 0;
					vg.cameras = [camHUD];
					add(vg);

					FlxTween.tween(vg, {alpha: 0.90}, 2.5, {ease: FlxEase.quadInOut});
				case 1296:
					timeBar.createFilledBar(0x00AD0E0E, 0xFFAD0E0E);
					TimeBarColorOne = 0x00AD0E0E;
					TimeBarColorTwo = 0xFFAD0E0E;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					FlxTween.cancelTweensOf(vg);
					FlxTween.tween(vg, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}

					defaultCamZoom = 0.7;
				case 1424:
					superZoomShit = true;
				case 1663:
					superZoomShit = false;
				case 1664:
					supersuperZoomShit = true;
				case 1679:
					supersuperZoomShit = false;
				case 1920:
					defaultCamZoom = 0.8;
				case 1924:
					defaultCamZoom = 0.9;
				case 1928:
					defaultCamZoom = 1.2;
				case 1932:
					defaultCamZoom = 1.4;
				case 1935:
					supersuperZoomShit = true;
				case 1936:
					defaultCamZoom = 0.7;
				case 2320:
					dad.x += 100;
					supersuperZoomShit = false;
					superZoomShit = false;
					timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
					TimeBarColorOne = 0x00D416E3;
					TimeBarColorTwo = 0xFFD416E3;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					defaultCamZoom = 0.9;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;

						grassXeno.angle = -30;
						backtreesXeno.y += 70;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
					
				case 2832:
					timeBar.createFilledBar(0x00A87608, 0xFFA87608);
					TimeBarColorOne = 0x00A87608;
					TimeBarColorTwo = 0xFFA87608;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();

					superZoomShit = true;

					FlxTween.cancelTweensOf(vg);
					FlxTween.tween(vg, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut});

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 1;
						fgTree2.alpha = 1;

						fgTree1.x += -50;

						backtreesXeno.visible = false;
						grassXeno.visible = false;
						p3staticbg.visible = false;
					}

					defaultCamZoom = 0.7;

				case 4111:
					timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
					TimeBarColorOne = 0x00D416E3;
					TimeBarColorTwo = 0xFFD416E3;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					superZoomShit = false;

					defaultCamZoom = 0.9;

					if (!ClientPrefs.PotatoOptimization) {
						fgTree1.alpha = 0;
						fgTree2.alpha = 0;
						
						fgTree1.x += 50;

						grassXeno.angle = 0;
						backtreesXeno.y -= 70;

						backtreesXeno.visible = true;
						grassXeno.visible = true;
						p3staticbg.visible = true;
					}
			}
		}
		
		if (SONG.song.toLowerCase()=='triple-trouble-encore')
		{
			switch (curStep)
			{
				case 1:
					timeBar.createFilledBar(0x007F7E7E, 0xFF7F7E7E);
					TimeBarColorOne = 0x007F7E7E;
					TimeBarColorTwo = 0xFF7F7E7E;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
					FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2.5, {ease: FlxEase.quadInOut});
				case 16:
					FlxTween.cancelTweensOf(FlxG.camera);
					FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1, {ease: FlxEase.elasticOut});
				case 399:
					superZoomShit = true;
				case 527:
					supersuperZoomShit = true;
					superZoomShit = false;
				case 783:
					supersuperZoomShit = false;
				case 1040:
					timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
					TimeBarColorOne = 0x00D416E3;
					TimeBarColorTwo = 0xFFD416E3;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 1328:
					timeBar.createFilledBar(0x00AD0E0E, 0xFFAD0E0E);
					TimeBarColorOne = 0x00AD0E0E;
					TimeBarColorTwo = 0xFFAD0E0E;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 1477:
					superZoomShit = true;
				case 2238:
					supersuperZoomShit = true;
				case 2764:
					supersuperZoomShit = false;
					superZoomShit = false;
					timeBar.createFilledBar(0x00D416E3, 0xFFD416E3);
					TimeBarColorOne = 0x00D416E3;
					TimeBarColorTwo = 0xFFD416E3;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 3278:
					timeBar.createFilledBar(0x00A87608, 0xFFA87608);
					TimeBarColorOne = 0x00A87608;
					TimeBarColorTwo = 0xFFA87608;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
			}
		}
		
		if (SONG.song.toLowerCase()=='personel')
		{
			switch (curStep)
			{
				case 32:
					camGame.alpha = 1;
				case 136:
					FlxTween.tween(blackFuck, {alpha: 1}, 0.25);
					FlxTween.tween(startCircle, {alpha: 1}, 0.25);
					FlxTween.tween(startText, {alpha: 1}, 0.25);
					FlxTween.tween(camHUD, {alpha: 0}, 0.25);
					new FlxTimer().start(0.6, function(tmr:FlxTimer)
					{
						FlxTween.tween(startCircle, {x: 0}, 0.5);
						FlxTween.tween(startText, {x: 0}, 0.5);
					});

					new FlxTimer().start(1.9, function(tmr:FlxTimer)
					{
						FlxTween.tween(camHUD, {alpha: 1}, 1);
						FlxTween.tween(blackFuck, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(blackFuck);
								blackFuck.destroy();
							}
						});
						FlxTween.tween(startCircle, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startCircle);
								startCircle.destroy();
							}
						});
						FlxTween.tween(startText, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startText);
								startText.destroy();
							}
						});
					});
				case 288:
					defaultCamZoom = 1.2;
					FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.3);
				case 416:
					defaultCamZoom = 1.6;
					FlxTween.tween(FlxG.camera, {zoom: 1.6}, 0.3);
				case 543:
					defaultCamZoom = 1.0;
					FlxTween.tween(FlxG.camera, {zoom: 1.0}, 0.3);
				case 799:
					defaultCamZoom = 0.9;
					FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.3);
				case 1069:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1087:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1098:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1101:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1134:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1151:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1163:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1167:
					for (str in playerStrums)
						str.angle = str.angle + 35;
					for (str in opponentStrums)
						str.angle = str.angle + 35;
				case 1199:
					IsNoteSpinning = true;
					FlxTween.tween(FlxG.camera, {zoom: 1.6}, 0.3);
					defaultCamZoom = 1.6;
				case 1263:
					IsNoteSpinning = false;
				case 1311:
					IsNoteSpinning = true;
					isPlayersSpinning = true;
					FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.3);
					defaultCamZoom = 1.2;
				case 1401:
					IsNoteSpinning = false;
					FlxTween.tween(FlxG.camera, {zoom: 1.8}, 0.3);
					defaultCamZoom = 1.8;
				case 1403:
					defaultCamZoom = 0.9;
					FlxTween.tween(FlxG.camera, {zoom: 0.9}, 21.2);
					isPlayersSpinning = false;
					dad.angle = 0;
					boyfriend.angle = 0;
					for (str in playerStrums)
						FlxTween.tween(str, {angle: 0}, 0.5, {ease: FlxEase.circOut});
					for (str in opponentStrums)
						FlxTween.tween(str, {angle: 0}, 0.5, {ease: FlxEase.circOut});
				case 1695:
					superZoomShit = true;
				case 1872:
					superZoomShit = false;
					supersuperZoomShit = true;
				case 1888:
					superZoomShit = true;
					supersuperZoomShit = false;
				case 1936:
					supersuperZoomShit = true;
					superZoomShit = false;
				case 1975:
					superZoomShit = false;
					supersuperZoomShit = false;
			}
		}
		
		if (SONG.song.toLowerCase()=='personel-serious')
		{
			switch (curStep)
			{
				case 32:
					camGame.alpha = 1;
				case 136:
					FlxTween.tween(blackFuck, {alpha: 1}, 0.25);
					FlxTween.tween(startCircle, {alpha: 1}, 0.25);
					FlxTween.tween(startText, {alpha: 1}, 0.25);
					FlxTween.tween(camHUD, {alpha: 0}, 0.25);
					new FlxTimer().start(0.6, function(tmr:FlxTimer)
					{
						FlxTween.tween(startCircle, {x: 0}, 0.5);
						FlxTween.tween(startText, {x: 0}, 0.5);
					});

					new FlxTimer().start(1.9, function(tmr:FlxTimer)
					{
						FlxTween.tween(camHUD, {alpha: 1}, 1);
						FlxTween.tween(blackFuck, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(blackFuck);
								blackFuck.destroy();
							}
						});
						FlxTween.tween(startCircle, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startCircle);
								startCircle.destroy();
							}
						});
						FlxTween.tween(startText, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startText);
								startText.destroy();
							}
						});
					});
			}
		}
		
		if (SONG.song.toLowerCase() == 'confronting')
		{
			switch (curStep)
			{
				case 336, 656: //Pico
					timeBar.createFilledBar(0x00FF0000, 0xFFFD6822);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFFFD6822;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 400, 688, 1120: //BF
					timeBar.createFilledBar(0x00FF0000, 0xFF056CF7);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF056CF7;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 992: //Melthog
					timeBar.createFilledBar(0x00FF0000, 0xFF4646BC);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF4646BC;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
			}
		}
		
		if (SONG.song.toLowerCase() == 'marauder')
		{
			switch (curStep)
			{
				case 744, 1014, 1032, 1053, 1064, 1168, 1552, 1696: //Griatos
					timeBar.createFilledBar(0x00FF0000, 0xFF392122);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF392122;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 1007, 1024, 1048, 1061, 1152, 1399, 1632, 1760: //Demogri
					timeBar.createFilledBar(0x00FF0000, 0xFF393D85);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF393D85;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
			}
		}
		
		if (SONG.song.toLowerCase() == 'burning')
		{
			switch (curStep)
			{
				case 368, 688, 864, 1392, 1527, 1680, 1700, 1708, 1800, 1812, 1820, 1840, 1850, 1920, 1988, 1996, 2004, 2012, 2024, 2032, 2036, 2040, 2044: //Genesys
					timeBar.createFilledBar(0x00FF0000, 0xFF620000);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF620000;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 640, 704, 1152, 1408, 1660, 1692, 1704, 1718, 1808, 1816, 1824, 1844, 1856, 1984, 1992, 2000, 2008, 2020, 2028, 2034, 2038, 2042, 2046: //Burning
					timeBar.createFilledBar(0x00FF0000, 0xFF373744);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFF373744;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
			}
		}
		
		if (SONG.song.toLowerCase()=='soulless')
		{
			switch (curStep)
			{
				case 1:
					FlxTween.tween(camGame, {alpha: 1}, 12);
						opponentStrums.forEach(function(spr:FlxSprite)
						{
							spr.x += 10000;
						});
				case 257:
					FlxTween.tween(blackFuck, {alpha: 1}, 0.25);
					FlxTween.tween(startCircle, {alpha: 1}, 0.25);
					FlxTween.tween(startText, {alpha: 1}, 0.25);
					FlxTween.tween(camHUD, {alpha: 0}, 0.25);
					new FlxTimer().start(0.6, function(tmr:FlxTimer)
					{
						FlxTween.tween(startCircle, {x: 0}, 0.5);
						FlxTween.tween(startText, {x: 0}, 0.5);
					});

					new FlxTimer().start(1.9, function(tmr:FlxTimer)
					{
						FlxTween.tween(camHUD, {alpha: 1}, 1);
						FlxTween.tween(blackFuck, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(blackFuck);
								blackFuck.destroy();
							}
						});
						FlxTween.tween(startCircle, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startCircle);
								startCircle.destroy();
							}
						});
						FlxTween.tween(startText, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween)
							{
								remove(startText);
								startText.destroy();
							}
						});
					});
			}
		}

		if(SONG.song.toLowerCase()=='too-slow')
		{
			switch(curStep){
				case 765:
					FlxG.camera.flash(FlxColor.RED, 3);
				case 1305:
			}
		}
		if (SONG.song.toLowerCase() == 'too-slow-encore')
			{
				switch (curStep)
				{
					case 384:
						camGame.alpha = 0;
					case 400:
						camGame.alpha = 1;
						defaultCamZoom = 0.9;
					case 415:
						supersuperZoomShit = true;
					case 416:
						defaultCamZoom = 0.65;
					case 675:
						supersuperZoomShit = false;
					case 687:
						supersuperZoomShit = true;
					case 736:
						supersuperZoomShit = false;
					case 751:
						supersuperZoomShit = true;
					case 928:
						FlxTween.tween(FlxG.camera, {zoom: 1.0}, 0.7);
						cinematicBars(true);
						defaultCamZoom = 1.0;
						supersuperZoomShit = false;
						FlxTween.tween(camHUD, {alpha: 0}, 0.7);
					case 1039:
						cinematicBars(false);
						FlxTween.tween(FlxG.camera, {zoom: 0.6}, 1.4);
						defaultCamZoom = 0.6;
						FlxTween.tween(camHUD, {alpha: 1}, 1.4);
					case 1055:
						supersuperZoomShit = true;
				}
			}
			
		if (SONG.song.toLowerCase() == 'too-slow-encore-alt')
			{
				switch (curStep)
				{
					case 928:
						cinematicBars(true);
					case 1048:
						cinematicBars(false);
				}
			}
			
		if (curStage == 'fatality' && SONG.song.toLowerCase()=='fatality')
		{
			switch (curStep)
			{
			  #if desktop
				case 255, 1983:
					fatalTransitionStatic();
				case 256:
					if (!ClientPrefs.PotatoOptimization) {
						base.visible = false;
						domain.visible = true;
						domain2.visible = true;
					}
				case 1151:
					dadGroup.remove(dad);
					var olddx = dad.x;
					var olddy = dad.y;
					dad = new Character(olddx, olddy, 'fatal-glitched');
					dadGroup.add(dad);
				case 1984:
					Xamount += 2;
					Yamount += 2;
					fatalTransistionThingDos();
					windowX = Lib.application.window.x;
					windowY = Lib.application.window.y;
					IsWindowMoving2 = true;
				case 2208:
					IsWindowMoving = false;
					IsWindowMoving2 = false;
				case 2230:
					shakescreen();
					camGame.shake(0.02, 0.8);
					camHUD.shake(0.02, 0.8);
				case 2240:
					IsWindowMoving = true;
					IsWindowMoving2 = false;
				case 2528:
					shakescreen();
					IsWindowMoving = true;
					IsWindowMoving2 = true;
					Yamount += 3;
					Xamount += 3;
					camGame.shake(0.02, 2);
					camHUD.shake(0.02, 2);
				case 2530:
					shakescreen();
				case 2535:
					shakescreen();
				case 2540:
					shakescreen();
				case 2545:
					shakescreen();
				case 2550:
					shakescreen();
				case 2555:
					shakescreen();
				case 2560:
					IsWindowMoving = false;
					IsWindowMoving2 = false;
					windowGoBack();
				#else
				case 255, 1983:
					fatalTransitionStatic();
				case 256:
					if (!ClientPrefs.PotatoOptimization) {
						base.visible = false;
						domain.visible = true;
						domain2.visible = true;
					}
				case 1151:
					dadGroup.remove(dad);
					var olddx = dad.x;
					var olddy = dad.y;
					dad = new Character(olddx, olddy, 'fatal-glitched');
					dadGroup.add(dad);
				case 1984:
					fatalTransistionThingDos();
				case 2230:
					shakescreen();
					camGame.shake(0.02, 0.8);
					camHUD.shake(0.02, 0.8);
				case 2528:
					shakescreen();
					camGame.shake(0.02, 2);
					camHUD.shake(0.02, 2);
				case 2530:
					shakescreen();
				case 2535:
					shakescreen();
				case 2540:
					shakescreen();
				case 2545:
					shakescreen();
				case 2550:
					shakescreen();
				case 2555:
					shakescreen();
				#end
			}
		}
		
		if (curStage == 'fatality' && SONG.song.toLowerCase()=='terminal-proxy')
		{
			switch (curStep)
			{
			  #if desktop
				case 255, 1983:
					fatalTransitionStatic();
				case 256:
					if (!ClientPrefs.PotatoOptimization) {
						base.visible = false;
						domain.visible = true;
						domain2.visible = true;
					}
				case 1024:
					dadGroup.remove(dad);
					var olddx = dad.x;
					var olddy = dad.y;
					dad = new Character(olddx, olddy, 'fatal-glitched');
					dadGroup.add(dad);
				case 1280:
					Xamount += 2;
					Yamount += 2;
					fatalTransistionThingDos();
					windowX = Lib.application.window.x;
					windowY = Lib.application.window.y;
					IsWindowMoving = true;
				case 1792:
					IsWindowMoving = false;
					windowGoBack();
				#else
				case 255, 1983:
					fatalTransitionStatic();
				case 256:
					if (!ClientPrefs.PotatoOptimization) {
						base.visible = false;
						domain.visible = true;
						domain2.visible = true;
					}
				case 1024:
					dadGroup.remove(dad);
					var olddx = dad.x;
					var olddy = dad.y;
					dad = new Character(olddx, olddy, 'fatal-glitched');
					dadGroup.add(dad);
				case 1280:
					fatalTransistionThingDos();
				#end
			}
		}
		
		if (curStage == 'fatality' && SONG.song.toLowerCase()=='unresponsive')
		{
			switch (curStep)
			{
			  #if desktop
				case 256:
					fatalTransitionStatic();
					if (!ClientPrefs.PotatoOptimization) {
						base.visible = false;
						domain.visible = true;
						domain2.visible = true;
					}
				case 784:
					dadGroup.remove(dad);
					var olddx = dad.x;
					var olddy = dad.y;
					dad = new Character(olddx, olddy, 'fatal-glitched');
					dadGroup.add(dad);
				case 1064:
					fatalTransitionStatic();
					fatalTransistionThingDos();
				#end
			}
		}		
		
		if (curStage == 'sunkStage' && SONG.song.toLowerCase()=='milk')
		{
			switch (curStep)
			{
				case 64:
					FlxG.camera.zoom += 0.06;
					camHUD.zoom += 0.08;
				case 80:
					FlxG.camera.zoom += 0.06;
					camHUD.zoom += 0.08;
				case 96:
					supersuperZoomShit = true;
					FlxTween.tween(FlxG.camera, {zoom: 1.5}, 6.5);
				case 119:
					supersuperZoomShit = false;
					FlxTween.cancelTweensOf(FlxG.camera);
					FlxTween.tween(FlxG.camera, {zoom: 0.77}, 0.5);
				case 132:
					FlxTween.tween(FlxG.camera, {zoom: 1.9}, 2.5);
					camGame.shake(0.2, 0.85);
					camHUD.shake(0.2, 0.85);
					if (!ClientPrefs.PotatoOptimization) FlxTween.tween(sunker, {alpha: 1}, 1.5);
				case 144:
					FlxTween.cancelTweensOf(FlxG.camera);
					if (!ClientPrefs.PotatoOptimization) {
						FlxTween.cancelTweensOf(sunker);
						sunker.alpha = 0;
						sunker.visible = false;
					}

					FlxTween.tween(FlxG.camera, {zoom: 0.77}, 0.5);
					superZoomShit = true;
				case 352:
					FlxTween.tween(FlxG.camera, {zoom: 1.9}, 1.9);
					superZoomShit = false;
				case 367:
					FlxTween.cancelTweensOf(FlxG.camera);
					FlxTween.tween(FlxG.camera, {zoom: 0.77}, 0.5);
				case 404:
					superZoomShit = true;
				case 528:
					if (!ClientPrefs.PotatoOptimization) {
						switch(FlxG.random.int(1, 3)){
							case 1:
								FlxTween.tween(cereal, {x: 1350}, 12.5);
							case 2:
								FlxTween.tween(munch, {x: 1350}, 12.5);
							case 3:
								FlxTween.tween(pose, {x: 1350}, 12.5);
						}
					}
				case 639:
					superZoomShit = false;
					FlxTween.tween(FlxG.camera, {zoom: 1.3}, 0.5);
					defaultCamZoom = 1.3;
				case 651:
					FlxTween.tween(FlxG.camera, {zoom: 1.9}, 0.5);
					defaultCamZoom = 1.9;
				case 656:
					FlxTween.tween(FlxG.camera, {zoom: 0.77}, 0.5);
					defaultCamZoom = 0.9;
					superZoomShit = true;
				case 752:
					if (!ClientPrefs.PotatoOptimization) {
						cereal.y = -1000;
						cereal.x = 500;
						munch.y = -1000;
						munch.x = 500;
						pose.y = -1000;
						pose.x = 500;
					}
				case 784:
					if (!ClientPrefs.PotatoOptimization) {
						switch(FlxG.random.int(1, 3)){
							case 1:
								FlxTween.tween(cereal, {y: 1150}, 9.8);
							case 2:
								FlxTween.tween(munch, {y: 1150}, 9.8);
							case 3:
								FlxTween.tween(pose, {y: 1150}, 9.8);
						}
					}
				case 879:
					if (!ClientPrefs.PotatoOptimization) {
						FlxTween.cancelTweensOf(cereal);
						FlxTween.cancelTweensOf(munch);
						FlxTween.cancelTweensOf(pose);
						cereal.y = -1000;
						cereal.x = 500;
					}
				case 911:
					if (!ClientPrefs.PotatoOptimization) {
						cereal.y = -1000;
						cereal.x = -700;
						munch.y = -1000;
						munch.x = -700;
						pose.y = -1000;
						pose.x = -700;
						switch(FlxG.random.int(1, 3)){
							case 1:
								FlxTween.tween(cereal, {y: 1050}, 10.8);
								FlxTween.tween(cereal, {x: 1350}, 10.8);
							case 2:
								FlxTween.tween(munch, {y: 1050}, 9.8);
								FlxTween.tween(munch, {x: 1350}, 10.8);
							case 3:
								FlxTween.tween(pose, {y: 1050}, 9.8);
								FlxTween.tween(pose, {x: 1350}, 10.8);
						}
					}
				case 1423:
					camGame.alpha = 0;
				case 1439:
					spoOoOoOky.x -= 100;
					spoOoOoOky.visible = true;
					spoOoOoOky.alpha = 0;
					FlxTween.tween(spoOoOoOky, {alpha: 1}, 1.5);
				case 1455:
					FlxTween.cancelTweensOf(spoOoOoOky);
					spoOoOoOky.alpha = 0;
					camGame.alpha = 1;
			}
		}

		if (SONG.song.toLowerCase() == 'b4cksl4sh')
			{
				switch (curStep)
					{
						case 1823:
							SlashSecondPart = true;
							doStaticSign();
							slashChangingShit();
							dadGroup.remove(dad);
							boyfriend.visible = false;
							var olddx = dad.x + 190;
							var olddy = dad.y + 20;
							dad = new Character(olddx, olddy, 'FrontViewSl4sh');
							boyfriend.x += 50;
							boyfriend.y -= 165;
							iconP2.changeIcon(dad.healthIcon);
							dadGroup.add(dad);

						case 1888, 1952, 2016, 2080, 2128, 2192, 2336:
							SlashMechaic();
							canDodge = true;

					}
			}
				
			if (SONG.song.toLowerCase() == 'manual-blast')
				{
					switch (curStep)
						{
							case 512:
								colorTweenHog();
								FlxTween.tween(camHUD, {alpha: 0}, 2, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
									{
										camHUD.visible = false;
										camHUD.alpha = 1;
									}
								});
								blackFuck = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
								blackFuck.alpha = 0;
								blackFuck.cameras = [camOther];
								add(blackFuck);

								FlxTween.tween(blackFuck, {alpha: 1}, 1.5, {ease: FlxEase.cubeInOut});

							case 576, 582, 640, 646, 672, 678, 704, 710, 736, 742, 768, 774, 800, 806, 832, 838:
								FlxTween.tween(blackFuck, {alpha: 0}, 0.01, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
									{
										FlxTween.tween(blackFuck, {alpha: 1}, 0.4, {ease: FlxEase.cubeInOut});
									}
								});
							case 559:
								camZooming = false;
							case 848:
								timeBar.createFilledBar(0x00FF0000, 0xFF142953);
								TimeBarColorOne = 0x00FF0000;
								TimeBarColorTwo = 0xFF142953;
								if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
								if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
								timeBar.updateBar();
								FlxG.camera.flash(FlxColor.BLACK, 1);
								camZooming = true;
								if (!ClientPrefs.PotatoOptimization) hogOverlay.visible = false;
								FlxTween.tween(blackFuck, {alpha: 1}, 0.1, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
									{
										remove(blackFuck);
										blackFuck.destroy();
									}
								});
							case 864:
								FlxG.camera.flash(FlxColor.BLACK, 2.5);
								hyogStuff();
								camHUD.visible = true;
								camHUD.zoom += 2;
								
								if(ClientPrefs.Shaders){
									curShader = camGlitchFilter;
									curShaderone = staticOverlay;
									curShadertwo = camFuckFilter;

									camGame.setFilters([curShader, curShaderone]);
									camHUD.setFilters([curShader]);
								}

							case 4672:
								if(ClientPrefs.Shaders){
									curShader = camGlitchFilter;
									curShaderone = staticOverlay;
									curShadertwo = camFuckFilter;
								
									camGame.setFilters([curShader, curShadertwo, curShaderone]);
									camHUD.setFilters([curShader, curShadertwo]);
								
									camFuckShader.amount = 0.01;
								}
								if (!ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedMotain, {alpha: 0}, 1.5);
									glitchKill(scorchedMotain);
								}
							case 4704:
								if(ClientPrefs.Shaders) camFuckShader.amount = 0.035;
								if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedWaterFalls, {alpha: 0}, 1.5);
									glitchKill(scorchedWaterFalls);
								}
							case 4736:
								if(ClientPrefs.Shaders) camFuckShader.amount = 0.075;
								if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedHills, {alpha: 0}, 1.5);
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedMonitor, {alpha: 0}, 1.5);
									glitchKill(scorchedHills);
									glitchKill(scorchedMonitor);
								}
							case 4920:
								if (!ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedBg, {alpha: 0}, 1.5);
									glitchKill(scorchedBg);
								}
							case 4944:
								if(!ClientPrefs.Shaders) FlxTween.tween(boyfriend, {alpha: 0}, 1.5);
								glitchKill(boyfriend, true);
								if(ClientPrefs.Shaders){
									piss.push(FlxTween.tween(camFuckShader, {amount: 0.3}, 4, {
										ease: FlxEase.cubeInOut
									}));
								}
							case 4960:
								if (!ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedTrees, {alpha: 0}, 1.5);
									glitchKill(scorchedTrees);
								}
							case 4978:
								if (!ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedRocks, {alpha: 0}, 1.5);
									glitchKill(scorchedRocks);
								}
							case 4992:
								if (!ClientPrefs.PotatoOptimization) {
									if(!ClientPrefs.Shaders) FlxTween.tween(scorchedFloor, {alpha: 0}, 1.5);
									glitchKill(scorchedFloor);
								}
							case 5000:
								if(!ClientPrefs.Shaders) FlxTween.tween(dad, {alpha: 0}, 1.5);
								glitchKill(dad, true);
								FlxTween.tween(camGame, {alpha: 0});
								FlxTween.tween(camHUD, {alpha: 0});
						}
				}

			if (curStage == 'exe-encore' && SONG.song.toLowerCase() == 'faker-encore')
				{
					switch (curStep)
						{
							case 512:
								add(blackFuck);
								blackFuck.visible = true;
								blackFuck.alpha = 0;
								camZooming = false;
								FlxTween.tween(blackFuck, {alpha: 1}, 1.8, {ease: FlxEase.cubeInOut});
								
							case 576:
								health = 2;
								fucklesMode = true;
								timeBar.createFilledBar(0x00FF0000, 0xFF1F106B);
								TimeBarColorOne = 0x00FF0000;
								TimeBarColorTwo = 0xFF1F106B;
								if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
								if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
								timeBar.updateBar();
								camZooming = true;
								FlxTween.tween(blackFuck, {alpha: 0}, 0.65, {ease: FlxEase.cubeInOut});
								
							case 959:
								fucklesMode = false;
								blackFuck.alpha = 1;
								timeBar.createFilledBar(0x00FF0000, 0xFF1C1C72);
								TimeBarColorOne = 0x00FF0000;
								TimeBarColorTwo = 0xFF1C1C72;
								if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
								if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
								timeBar.updateBar();
								camZooming = false;
								FlxTween.tween(blackFuck, {alpha: 0}, 0.65, {ease: FlxEase.cubeInOut});
								
							case 1216:
								health = 2;
								fucklesMode = true;
								blackFuck.alpha = 1;
								timeBar.createFilledBar(0x00FF0000, 0xFF1F106B);
								TimeBarColorOne = 0x00FF0000;
								TimeBarColorTwo = 0xFF1F106B;
								if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
								if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
								timeBar.updateBar();
								camZooming = true;
								FlxTween.tween(blackFuck, {alpha: 0}, 0.65, {ease: FlxEase.cubeInOut});
						}
				}

			if (SONG.song.toLowerCase() == 'too-fest')
				{
					switch (curStep)
						{
							case 5, 9, 12, 634, 639, 642, 646, 650, 654, 710, 716, 774, 780, 838, 845, 895, 900, 905, 910, 1472, 1476, 1480, 1484:
								festSpinFull();
							case 64, 69, 73, 77, 383, 389, 393, 397, 448, 452, 456, 460, 512, 516, 520, 524, 576, 580, 584, 588, 664, 698, 729, 760, 790, 857:
								festSpinOppenet();
							case 408, 410, 412, 472, 474, 476, 536, 538, 540, 600, 602, 604, 682, 710, 745, 808, 825, 872, 888:
								festSpinPlayer();
							case 912:
								WeedShit = true;
								if(ClientPrefs.Shaders && WeedShit){
									curShader = new ShaderFilter(weedVis.shader);
									camGame.setFilters([curShader]);
									camHUD.setFilters([curShader]);
									camOther.setFilters([curShader]);
								}
								weedSpinningTime = true;
							case 1167:
								weedSpinningTime = false;
						}
				}
		
			if (SONG.song.toLowerCase() == 'you-cant-run-encore') {
				switch (curStep) {
					case 1308:
						FlxTween.tween(camHUD, {alpha: 0}, 1,{ease: FlxEase.cubeInOut});
						cinematicBars(true);
					case 1440:
						FlxTween.tween(camHUD, {alpha: 1}, 1,{ease: FlxEase.cubeInOut});
						cinematicBars(false);
				}
			}
		if (SONG.song.toLowerCase() == 'prey')
			{
				switch (curStep)
					{
						case 1:
							boyfriend.alpha = 0;
							camHUD.alpha = 0;
							FlxTween.tween(boyfriend, {alpha: 1}, 6);

						case 128:
							FlxG.camera.flash(FlxColor.WHITE, 2);
							FlxG.camera.zoom = 2;
							camZooming = true;
							if (!ClientPrefs.PotatoOptimization) {
								stardustBgPixel.visible = true;
								stardustFloorPixel.visible = true;
							}

						case 246:
							FlxTween.tween(dad, {x: 580}, 1, {ease: FlxEase.cubeInOut});
							FlxTween.tween(camHUD, {alpha: 1}, 1.2,{ease: FlxEase.cubeInOut});
						case 1530:
							FlxTween.tween(camHUD, {alpha: 0}, 0.75,{ease: FlxEase.cubeInOut});
						case 1505:
							FlxTween.tween(dad, {x: -1500}, 5, {ease: FlxEase.cubeInOut});
							FlxTween.angle(dad, 0, -180, 5, {ease: FlxEase.cubeInOut});
						case 1542:
							dadGroup.visible = false;
						case 1545:
								cinematicBars(true);
								dad.x -= 500;
								dad.y += 100;
						case 1548:
							dadGroup.visible = true;
						case 1547:
							health = 1;
							boyfriend.animation.finishCallback = function(sussys:String)
							{
								hungryManJackTime = 2;
								if (dad.animation.curAnim.name == "first dialogue")
								{
									boyfriend.specialAnim = false;
								}
							}
							dad.playAnim("dialogue", true);
							dad.specialAnim = true;
							dad.animation.finishCallback = function(sussyssys:String)
							{
								if (dad.animation.curAnim.name == "dialogue")
								{
									hungryManJackTime = 1;
									cinematicBars(false);
									dad.specialAnim = false;
								}
							}
						case 1:
							hungryManJackTime = 3;
						case 256: 
							hungryManJackTime = 1;
						case 1570:
							FlxTween.tween(dad, {x: 1300}, 2.5,{ease: FlxEase.cubeInOut});
						case 1780:
							FlxTween.tween(camHUD, {alpha: 1}, 1.0);
						case 2432:
							FlxTween.tween(stardustFurnace, {x: 3000}, 7);
						case 3328:
							FlxTween.tween(camHUD, {alpha: 0}, 1,{ease: FlxEase.cubeInOut});
							FlxTween.tween(dad, {x: -300}, 4,{ease: FlxEase.cubeInOut});
						case 3335:
							boyfriend.playAnim("dialogue peel");
							boyfriend.specialAnim = true;
						case 3367:
							FlxG.camera.flash(FlxColor.RED, 2);
							boyfriendGroup.visible = false;
							dadGroup.visible = false;
							stardustFurnace.visible = false;
							if (!ClientPrefs.PotatoOptimization) {
								stardustBgPixel.visible = false;
								stardustFloorPixel.visible = false;
							}
						case 3364:
							cinematicBars(true);
							var gotcha:FlxSprite = new FlxSprite(boyfriend.x + 1500, boyfriend.y + 505).loadGraphic(Paths.image('furnace_gotcha', 'exe'));
							gotcha.setGraphicSize(Std.int(gotcha.width * 5));
							gotcha.antialiasing = false;
							gotcha.flipX = true;
							add(gotcha);
							FlxTween.tween(gotcha, {x: boyfriend.x + 500}, 0.2, {onComplete: function(yes:FlxTween)
							{
								remove(gotcha);
							}});
					}
			}
			
			if (SONG.song.toLowerCase() == 'malediction')
			{
				switch (curStep)
					{
						case 531, 725:
							FlxTween.tween(camHUD, {alpha: 0.5}, 0.3,{ease: FlxEase.cubeInOut});
						case 558, 734:
							FlxTween.tween(camHUD, {alpha: 1}, 0.3,{ease: FlxEase.cubeInOut});
						case 736, 992:
							FlxG.camera.flash(FlxColor.PURPLE, 0.5);
						case 1184:
							FlxTween.tween(camHUD, {alpha: 0}, 1,{ease: FlxEase.cubeInOut});
					}
			}
			
		if (SONG.song.toLowerCase() == 'faker')
		{
			switch (curStep)
			{
				case 787, 795, 902, 800, 811, 819, 823, 827, 832, 835, 839, 847, 847:
					doStaticSign(0, false);
				case 768:
					FlxTween.tween(camHUD, {alpha: 0}, 1);
				case 801: // 800
					add(fakertransform);
					fakertransform.setPosition(dad.getGraphicMidpoint().x - 460, dad.getGraphicMidpoint().y - 700);
					fakertransform.x += 20;
					fakertransform.y += 128;
					fakertransform.alpha = 1;
					dad.visible = false;
					fakertransform.animation.play('1');
				case 824: // 824
					fakertransform.setPosition(dad.getGraphicMidpoint().x - 460, dad.getGraphicMidpoint().y - 700);
					fakertransform.x += -19;
					fakertransform.y += 138;
					fakertransform.animation.play('2');
				case 836: // 836
					fakertransform.setPosition(dad.getGraphicMidpoint().x - 460, dad.getGraphicMidpoint().y - 700);
					fakertransform.x += 76;
					fakertransform.y -= 110;
					fakertransform.animation.play('3');
				case 848: // 848
					fakertransform.setPosition(dad.getGraphicMidpoint().x - 460, dad.getGraphicMidpoint().y - 700);
					fakertransform.x += -110;
					fakertransform.y += 318;
					fakertransform.animation.play('4');
				case 884:
					add(blackFuck);
					blackFuck.alpha = 1;
					blackFuck.visible = true;
			}
			if (curStep > 858 && curStep < 884)
				doStaticSign(0, false); // Honestly quite incredible
		}
		
		if (curSong == 'forestall-desire')
		{
			switch (curStep)
			{
				case 1584:
					dadGroup.remove(dad);
					var olddx = dad.x;
					var olddy = dad.y;
					dad = new Character(olddx, olddy, 'requitalanim1');
					dadGroup.add(dad);
					dad.playAnim('Anim1', true);
					dad.specialAnim = true;
					dad.animation.finishCallback = function(anim:String)
					{
					
						if(anim == 'Anim1') {
							dadGroup.remove(dad);
							var olddx = dad.x;
							var olddy = dad.y;
							dad = new Character(olddx, olddy, 'requitalanim2');
							dadGroup.add(dad);
							dad.playAnim('Anim2', true);
							dad.specialAnim = true;
							dad.animation.finishCallback = function(anim:String)
							{
							
								if(anim == 'Anim2') {
									dadGroup.remove(dad);
									var olddx = dad.x;
									var olddy = dad.y;
									dad = new Character(olddx, olddy, 'requitalanim3');
									dadGroup.add(dad);
									dad.playAnim('Anim3', true);
									dad.specialAnim = true;
									dad.animation.finishCallback = function(anim:String)
									{
									
										if(anim == 'Anim3') {
											dadGroup.remove(dad);
											var olddx = dad.x;
											var olddy = dad.y;
											dad = new Character(olddx, olddy, 'requitalanim4');
											dadGroup.add(dad);
											dad.playAnim('Anim4', true);
											dad.specialAnim = true;
											dad.animation.finishCallback = function(anim:String)
											{
												if(anim == 'Anim3') {
													dad.specialAnim = false;
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		
		if (Math.abs(FlxG.sound.music.time - (Conductor.songPosition - Conductor.offset)) > 20
			|| (SONG.needsVoices && Math.abs(vocals.time - (Conductor.songPosition - Conductor.offset)) > 20))
		{
			resyncVocals();
		}

		if(curStep == lastStepHit) {
			return;
		}

		lastStepHit = curStep;
		setOnLuas('curStep', curStep);
		callOnLuas('onStepHit', []);
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;
	
	function shakescreen()
	{
	  #if desktop
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			Lib.application.window.move(Lib.application.window.x + FlxG.random.int(-10, 10), Lib.application.window.y + FlxG.random.int(-8, 8));
		}, 50);
   #end
	}
	
	function chaotixGlass(ass:Int)
	{
		switch (ass)
			{
				case 1:
					normalTrail = new FlxTrail(dad, null, 2, 12, 0.20, 0.05);
					add(normalTrail);
					soulGlassTime = true;
				case 2:
					metalTrail = new FlxTrail(boyfriend, null, 2, 12, 0.20, 0.05);
					add(metalTrail);
				case 3:
					amyTrail = new FlxTrail(gf, null, 2, 12, 0.20, 0.05);
					add(amyTrail);
			}
	}
	
	function revivedIsPissed(ass:Int)
	{
		{
			switch (ass)
				{
					case 1:
						soulGlassTime = false;
						remove(normalTrail);
					case 2:
						remove(metalTrail);
					case 3:
						remove(amyTrail);
				}
		}
	}
	
	function literallyMyHorizon()
		{
			dad.specialAnim = false;
			FlxG.camera.flash(FlxColor.BLACK, 1);
			camZooming = true;
			FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1.5, {ease: FlxEase.cubeInOut});
			FlxTween.tween(camHUD, {alpha: 1}, 1.0);
			fucklesBeats = false;
			fucklesDeluxe();
			FlxTween.tween(whiteFuck, {alpha: 0}, 1.5, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
				{
					remove(whiteFuck);
					whiteFuck.destroy();
				}
			});
			camHUD.zoom += 2;
		}

	function literallyOurHorizon() {
		timeBar.createFilledBar(0x00FF0000, 0xFF7665D0);
		TimeBarColorOne = 0x00FF0000;
		TimeBarColorTwo = 0xFF7665D0;
		if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
		if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
		timeBar.updateBar();
		camZooming = true;
		FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.35, {ease: FlxEase.quadOut});
		FlxTween.tween(camHUD, {alpha: 1}, 0.5);
		FlxTween.tween(dad, {alpha: 1}, 0.1, {ease: FlxEase.cubeInOut});
		FlxTween.tween(boyfriend, {alpha: 1}, 0.1, {ease: FlxEase.cubeInOut});
		FlxTween.tween(whiteFuck, {alpha: 0}, 1, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween) {
				remove(whiteFuck);
				whiteFuck.destroy();
				GameOverSubstate.characterName = 'bf-holding-gf-dead';
			}
		});

		if (!ClientPrefs.PotatoOptimization) {
			fucklesBGPixel.visible = false;
			fucklesFGPixel.visible = false;
			horizonBg.visible = true;
			horizonFloor.visible = true;
			horizonTrees.visible = true;
			horizonTrees2.visible = true;
			horizonPurpur.visible = true;
			horizonYellow.visible = true;
			horizonRed.visible = true;
		}
			
		if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
			horizonAmy.visible = true;
			horizonCharmy.visible = true;
			horizonEspio.visible = true;
			horizonMighty.visible = true;
			horizonKnuckles.visible = true;
			horizonVector.visible = true;
		}
			
		opponentStrums.forEach(function(spr:FlxSprite) {
			spr.x += 10000;
		});
	}

	function removeShit(fuck:Int) {
		switch(fuck) {
			case 1:
				if (!ClientPrefs.PotatoOptimization) {
					fucklesEspioBg.animation.stop();
					fucklesMightyBg.animation.stop();
					fucklesCharmyBg.animation.stop();
					fucklesAmyBg.animation.stop();
					fucklesKnuxBg.animation.stop();
					fucklesVectorBg.animation.stop();
				}
			case 2:
				if (!ClientPrefs.PotatoOptimization) {
					fucklesEspioBg.visible = false;
					fucklesMightyBg.visible = false;
					fucklesCharmyBg.visible = false;
					fucklesAmyBg.visible = false;
					fucklesKnuxBg.visible = false;
					fucklesVectorBg.visible = false;
				}
			case 3:
				if (!ClientPrefs.PotatoOptimization) {
					horizonBg.visible = false;
					horizonFloor.visible = false;
					horizonTrees.visible = false;
					horizonTrees2.visible = false;
					horizonPurpur.visible = false;
					horizonYellow.visible = false;
					horizonRed.visible = false;
				}
				if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
					horizonAmy.visible = false;
					horizonCharmy.visible = false;
					horizonEspio.visible = false;
					horizonMighty.visible = false;
					horizonKnuckles.visible = false;
					horizonVector.visible = false;
				}
				dadGroup.visible = false;
				boyfriendGroup.visible = false;
		}
	}

	function festSpinFull() {
		strumLineNotes.forEach(function(tospin:FlxSprite) {
			FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
		});
	}

	function slashChangingShit() {
		if (!ClientPrefs.PotatoOptimization) {
			slashFloor.visible = false;
			slashBg.visible = false;
			slashAssCracks.visible = false;
			slashLava.visible = false;

			slashBgPov.visible = true;
			slashLavaPov.visible = true;
			slashFloorPov.visible = true;
		}

		if (!ClientPrefs.middleScroll) {
			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.x -= 222;
				spr.alpha = 0.65;
			});
			opponentStrums.forEach(function(spr:FlxSprite)
			{
				spr.x += 5000;
			});
		}
	}

	function festSpinPlayer()
		{
			playerStrums.forEach(function(tospin:FlxSprite)
				{
					FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
				});
		}

	function festSpinOppenet()
		{
			opponentStrums.forEach(function(tospin:FlxSprite)
				{
					FlxTween.angle(tospin, 0, 360, 0.2, {ease: FlxEase.quintOut});
				});
		}

	function doPopup(type:Int)
	{
		var popup = new FatalPopup(0, 0, type);
		var popuppos:Array<Int> = [errorRandom.int(0, Std.int(FlxG.width - popup.width)), errorRandom.int(0, Std.int(FlxG.height - popup.height))];
		popup.x = popuppos[0];
		popup.y = popuppos[1];
		popup.cameras = [camOther];
		add(popup);
	}

	function managePopups(){
		if(FlxG.mouse.justPressed){
			trace("click :)");
			for(idx in 0...FatalPopup.popups.length){
				var realIdx = (FatalPopup.popups.length - 1) - idx;
				var popup = FatalPopup.popups[realIdx];
				var hitShit:Bool=false;
				for(camera in popup.cameras){
					@:privateAccess
					var hitOK = popup.clickDetector.overlapsPoint(FlxG.mouse.getWorldPosition(camera, popup.clickDetector._point), true, camera);
					if (hitOK){
						popup.close();
						hitShit=true;
						break;
					}
				}
				if(hitShit)break;
			}
		}
	}

	function tweencredits()
		{
			FlxTween.tween(creditoText, {y: FlxG.height - 625}, 0.5, {ease: FlxEase.circOut});
			FlxTween.tween(box, {y: 0}, 0.5, {ease: FlxEase.circOut});
			//tween away
			new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FlxTween.tween(creditoText, {y: -1000}, 0.5, {ease: FlxEase.circOut});
					FlxTween.tween(box, {y: -1000}, 0.5, {ease: FlxEase.circOut});
					//removal
					new FlxTimer().start(0.5, function(tmr:FlxTimer)
						{
							remove(creditsText);
							remove(box);
						});
				});
		}

	var lastBeatHit:Int = -1;
	
	function fatalTransitionStatic()
	{
		daStatix.visible = true;
		FlxG.sound.play(Paths.sound('staticBUZZ'));
		new FlxTimer().start(0.20, function(tmr:FlxTimer)
		{
			daStatix.visible = false;
		});
	}

	function fatalTransistionThingDos()
	{
		removeStatics();
		generateStaticArrows(0);
		generateStaticArrows(1);

		if (!ClientPrefs.middleScroll)
			{
				playerStrums.forEach(function(spr:FlxSprite)
					{
						spr.x -= 322;
					});
					opponentStrums.forEach(function(spr:FlxSprite)
					{
						spr.x += 10000;
					});
			}
		
		while(FatalPopup.popups.length>0)
		FatalPopup.popups[0].close();
		
		if (!ClientPrefs.PotatoOptimization) {
			domain.visible = false;
			domain2.visible = false;
			trueFatal.visible = true;
		}

		dadGroup.remove(dad);
		boyfriendGroup.remove(boyfriend);
		var olddx = dad.x + 740;
		var olddy = dad.y - 240;
		dad = new Character(olddx, olddy, 'true-fatal');
		iconP2.changeIcon(dad.healthIcon);

		var oldbfx = boyfriend.x - 250;
		var oldbfy = boyfriend.y + 135;
		boyfriend = new Boyfriend(oldbfx, oldbfy, 'bf-fatal-small');

		dadGroup.add(dad);
		boyfriendGroup.add(boyfriend);
	}
	
	override function beatHit()
	{
		super.beatHit();

		if(lastBeatHit >= curBeat) {
			//trace('BEAT HIT: ' + curBeat + ', LAST HIT: ' + lastBeatHit);
			return;
		}

		switch(noteGenesis) {
			case 1:
				strumLineNotes.forEach(function(note:StrumNote) {
					note.texture = 'PIXELNOTE_assets';
				});
				notes.forEachAlive(function(note:Note) {
					switch(note.noteType) {
						case 'Hurt Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-HURT';
							else
								note.texture = 'arrows/NOTE_assets-HURT';
						case 'Phantom Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-PHANTOM';
							else
								note.texture = 'arrows/NOTE_assets-PHANTOM';
						case 'Static Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-STATIC';
							else
								note.texture = 'arrows/NOTE_assets-STATIC';
						case 'Hex Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-HEX';
							else
								note.texture = 'arrows/NOTE_assets-HEX';
						case 'Pixel Note':
							note.texture = 'PIXELNOTE_assets';
						case 'Fatal Note':
							note.texture = 'fatal-notes';
						default:
							note.texture = 'PIXELNOTE_assets';
					}
				});
			case 2:
				var skin:String='arrows/NOTE_assets';
				var prefix:String='';
				if (noteChangesFromTheStore)
					skin = 'arrows/'+ClientPrefs.arrowSkin;
				if (customNoteColors)
					prefix = '-COLOR';
				strumLineNotes.forEach(function(note:StrumNote) {
					note.texture = skin+prefix;
				});
				notes.forEachAlive(function(note:Note) {
					switch(note.noteType) {
						case 'Hurt Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-HURT';
							else
								note.texture = 'arrows/NOTE_assets-HURT';
						case 'Phantom Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-PHANTOM';
							else
								note.texture = 'arrows/NOTE_assets-PHANTOM';
						case 'Static Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-STATIC';
							else
								note.texture = 'arrows/NOTE_assets-STATIC';
						case 'Hex Note':
							if (noteChangesFromTheStore)
								note.texture = 'arrows/'+ClientPrefs.arrowSkin+'-HEX';
							else
								note.texture = 'arrows/NOTE_assets-HEX';
						case 'Pixel Note':
							note.texture = 'PIXELNOTE_assets';
						case 'Fatal Note':
							note.texture = 'fatal-notes';
						default:
							note.texture = skin+prefix;
					}
				});
		}

		if (curBeat % 4 == 0 && sunkerTimebarFuckery)
		{
			var prevInt:Int = sunkerTimebarNumber;

			sunkerTimebarNumber = FlxG.random.int(1, 9, [sunkerTimebarNumber]);

			switch(sunkerTimebarNumber){
				case 1:
					timeBar.createFilledBar(0x00FF0000, 0xFFFF0000);
					TimeBarColorOne = 0x00FF0000;
					TimeBarColorTwo = 0xFFFF0000;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 2:
					timeBar.createFilledBar(0x001BFF00, 0xFF1BFF00);
					TimeBarColorOne = 0x001BFF00;
					TimeBarColorTwo = 0xFF1BFF00;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 3:
					timeBar.createFilledBar(0x0000C9FF, 0xFF00C9FF);
					TimeBarColorOne = 0x0000C9FF;
					TimeBarColorTwo = 0xFF00C9FF;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 4:
					timeBar.createFilledBar(0x00FC00FF, 0xFFFC00FF);
					TimeBarColorOne = 0x00FC00FF;
					TimeBarColorTwo = 0xFFFC00FF;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 5:
					timeBar.createFilledBar(0x00FFD100, 0xFFFFD100);
					TimeBarColorOne = 0x00FFD100;
					TimeBarColorTwo = 0xFFFFD100;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 6:
					timeBar.createFilledBar(0x000011FF, 0xFF0011FF);
					TimeBarColorOne = 0x000011FF;
					TimeBarColorTwo = 0xFF0011FF;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 7:
					timeBar.createFilledBar(0x00C9C9C9, 0xFFC9C9C9);
					TimeBarColorOne = 0x00C9C9C9;
					TimeBarColorTwo = 0xFFC9C9C9;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 8:
					timeBar.createFilledBar(0x0000FFE3, 0xFF00FFE3);
					TimeBarColorOne = 0x0000FFE3;
					TimeBarColorTwo = 0xFF00FFE3;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
				case 9:
					timeBar.createFilledBar(0x006300FF, 0xFF6300FF);
					TimeBarColorOne = 0x006300FF;
					TimeBarColorTwo = 0xFF6300FF;
					if (bgSkin == 'hpR' && ClientPrefs.BarsColor != 'No Color Change') healthBarBG.color = TimeBarColorTwo;
					if (bgTBSkin == 'tbR' && ClientPrefs.BarsColor != 'No Color Change') timeBarBG.color = TimeBarColorTwo;
					timeBar.updateBar();
			}
		}

		if (curBeat % 64 == 0 && normalBool)
		{
			if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
				var prevInt:Int = normalCharShit;
		
				normalCharShit = FlxG.random.int(1, 5, [normalCharShit]);
		
				switch(normalCharShit){
					case 1:
						normalChars.animation.play('chaotix');
					case 2:
						normalChars.animation.play('curse');
					case 3:
						normalChars.animation.play('rex');
					case 4:
						normalChars.animation.play('rodent');
					case 5:
						normalChars.animation.play('spoiled');
				}
			}
		}

		if (curBeat % 2 == 0 && superZoomShit)
		{
			FlxG.camera.zoom += 0.06;
			camHUD.zoom += 0.08;
		}

		if (curBeat % 1 == 0 && supersuperZoomShit)
		{
			FlxG.camera.zoom += 0.06;
			camHUD.zoom += 0.08;
		}

		if (curBeat % 4 == 0 && weedSpinningTime)
			{
				FlxG.camera.zoom += 0.06;
				camHUD.zoom += 0.08;

				strumLineNotes.forEach(function(tospin:FlxSprite)
					{
						FlxTween.angle(tospin, 0, 360, 1.2, {ease: FlxEase.quartOut});
					});
			}

		if (generatedMusic)
		{
			if (!offDownScroll)
				notes.sort(FlxSort.byY, ClientPrefs.downScroll ? FlxSort.ASCENDING : FlxSort.DESCENDING);
			else
				notes.sort(FlxSort.byY, false ? FlxSort.ASCENDING : FlxSort.DESCENDING);
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				//FlxG.log.add('CHANGED BPM!');
				setOnLuas('curBpm', Conductor.bpm);
				setOnLuas('crochet', Conductor.crochet);
				setOnLuas('stepCrochet', Conductor.stepCrochet);
			}
			setOnLuas('mustHitSection', SONG.notes[Math.floor(curStep / 16)].mustHitSection);
			setOnLuas('altAnim', SONG.notes[Math.floor(curStep / 16)].altAnim);
			setOnLuas('gfSection', SONG.notes[Math.floor(curStep / 16)].gfSection);
			// else
			// Conductor.changeBPM(SONG.bpm);
			
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection && dad.curCharacter != 'gf')
			{
				if (tailscircle == 'circling' && dad.curCharacter == 'TDoll')
					remove(ezTrail);
				dad.dance();
			}
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null && !endingSong && !isCameraOnForcedPos)
		{
			moveCameraSection(Std.int(curStep / 16));
		}
		if (camZooming && FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		
			if (ClientPrefs.Shaders) {
				if(camGlitchShader!=null && dad.curCharacter.startsWith('scorchedglitch'))
					camGlitchShader.amount += 0.2;
			}
		
		}

		if (curBeat % 2 == 0 && wowZoomin)
			{
				FlxG.camera.zoom += 0.04;
				camHUD.zoom += 0.06;
				if (ClientPrefs.Shaders) {
					if (camGlitchShader != null && dad.curCharacter.startsWith('scorchedglitch'))
						camGlitchShader.amount += 0.3;
				}
			}

		if (curBeat % 1 == 0 && holyFuckStopZoomin)
		{
			FlxG.camera.zoom += 0.04;
			camHUD.zoom += 0.06;
			if (ClientPrefs.Shaders) {
				if (camGlitchShader != null && dad.curCharacter.startsWith('scorchedglitch'))
					camGlitchShader.amount += 0.3;
			}
		}

		//i wanna kms, fucking shit code ;-;
		if (!bfIsLeft || (FEHPThing == 2 && bfIsLeft)) {
			if (!GFandDad) {
				if (!boyfriend.animation.curAnim.name.startsWith('sing') && !gf.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP1.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP1.scale.set(1.2, 1.2);
						xenoEncIconP1.scale.set(0.7, 0.7);
					}
					if (!VHSui && !xenoEncUI) iconP1.scale.set(1.2, 1.2);
				}
				if (!dad.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP2.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP2.scale.set(1.2, 1.2);
						xenoEncIconP2.scale.set(1.2, 1.2);
					}
					if (!VHSui && !xenoEncUI) iconP2.scale.set(1.2, 1.2);
				}
			} else {
				if (!boyfriend.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP1.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP1.scale.set(1.2, 1.2);
						xenoEncIconP1.scale.set(0.7, 0.7);
					}
					if (!VHSui && !xenoEncUI) iconP1.scale.set(1.2, 1.2);
				}
				if (!dad.animation.curAnim.name.startsWith('sing') && !gf.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP2.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP2.scale.set(1.2, 1.2);
						xenoEncIconP2.scale.set(1.2, 1.2);
					}
					if (!VHSui && !xenoEncUI) iconP2.scale.set(1.2, 1.2);
				}
			}
		} else {
			if (GFandDad) {
				if (!dad.animation.curAnim.name.startsWith('sing') && !gf.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP1.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP1.scale.set(1.2, 1.2);
						xenoEncIconP1.scale.set(0.7, 0.7);
					}
					if (!VHSui && !xenoEncUI) iconP1.scale.set(1.2, 1.2);
				}
				if (!boyfriend.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP2.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP2.scale.set(1.2, 1.2);
						xenoEncIconP2.scale.set(1.2, 1.2);
					}
					if (!VHSui && !xenoEncUI) iconP2.scale.set(1.2, 1.2);
				}
			} else {
				if (!dad.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP1.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP1.scale.set(1.2, 1.2);
						xenoEncIconP1.scale.set(0.7, 0.7);
					}
					if (!VHSui && !xenoEncUI) iconP1.scale.set(1.2, 1.2);
				}
				if (!boyfriend.animation.curAnim.name.startsWith('sing') && !gf.animation.curAnim.name.startsWith('sing')) {
					if (VHSui) iconP2.scale.set(1.0, 1.0);
					if (xenoEncUI) {
						iconP2.scale.set(1.2, 1.2);
						xenoEncIconP2.scale.set(1.2, 1.2);
					}
					if (!VHSui && !xenoEncUI) iconP2.scale.set(1.2, 1.2);
				}
			}
		}
		iconP1.updateHitbox();
		iconP2.updateHitbox();
		
		if (gf != null && curBeat % Math.round(gfSpeed * gf.danceEveryNumBeats) == 0 && !gf.stunned && gf.animation.curAnim.name != null && !gf.animation.curAnim.name.startsWith("sing") && !gf.stunned)
		{
			gf.dance();
		}
		if (curBeat % boyfriend.danceEveryNumBeats == 0 && boyfriend.animation.curAnim != null && !boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.stunned)
		{
			boyfriend.dance();
		}
		if (curBeat % dad.danceEveryNumBeats == 0 && dad.animation.curAnim != null && !dad.animation.curAnim.name.startsWith('sing') && !dad.stunned)
		{
			dad.dance();
		}

		switch (curStage)
		{
			case 'chamber', 'chamber-encore':
				if (!ClientPrefs.PotatoOptimization) porker.animation.play('porkerbop');
				
			case 'horizon', 'our-horizon':
				if (!ClientPrefs.PotatoOptimization) {
					if (fucklesBeats)
					{
						fucklesEspioBg.animation.play('idle');
						fucklesMightyBg.animation.play('idle');
						fucklesCharmyBg.animation.play('idle');
						fucklesAmyBg.animation.play('idle');
						fucklesKnuxBg.animation.play('idle');
						fucklesVectorBg.animation.play('idle');
					} else {
						fucklesAmyBg.animation.play('fear');
						fucklesCharmyBg.animation.play('fear');
						fucklesMightyBg.animation.play('fear');
						fucklesEspioBg.animation.play('fear');
						fucklesKnuxBg.animation.play('fear');
						fucklesVectorBg.animation.play('fear');
					}
				}
				if (SONG.song.toLowerCase() == 'our-horizon' && !ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization)
				{
					horizonAmy.animation.play('idle');
					horizonEspio.animation.play('idle');
					horizonKnuckles.animation.play('idle');
					horizonCharmy.animation.play('idle');
					horizonVector.animation.play('idle');
					horizonMighty.animation.play('idle');
				}
		}

		if (curStage == 'spooky' && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit();
		}
		lastBeatHit = curBeat;

		setOnLuas('curBeat', curBeat); //DAWGG?????
		callOnLuas('onBeatHit', []);
	}

	function hyogStuff() 
	{
		if (!ClientPrefs.PotatoOptimization) {
			hogBg.visible = false;
			hogMotain.visible = false;
		}
		if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
			hogWaterFalls.visible = false;
			hogLoops.visible = false;
		}
		if (!ClientPrefs.PotatoOptimization) {
			hogTrees.visible = false;
			hogFloor.visible = false;
			hogRocks.visible = false;	
			scorchedBg.visible = true;
			scorchedMotain.visible = true;
		}
		if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
			scorchedWaterFalls.visible = true;
			scorchedHills.visible = true;
			scorchedMonitor.visible = true;
		}
		if (!ClientPrefs.PotatoOptimization) {
			scorchedTrees.visible = true;
			scorchedFloor.visible = true;
			scorchedRocks.visible = true;
		}
	}
		
	function colorTweenHog()
	{	
		if (!ClientPrefs.PotatoOptimization) {
			FlxTween.color(hogBg, 15, FlxColor.WHITE, 0xFF1f1f1f);
			FlxTween.color(hogMotain, 15, FlxColor.WHITE, 0xFF1f1f1f);
		}
		if (!ClientPrefs.Optimization && !ClientPrefs.PotatoOptimization) {
			FlxTween.color(hogWaterFalls, 15, FlxColor.WHITE, 0xFF1f1f1f);
			FlxTween.color(hogLoops, 15, FlxColor.WHITE, 0xFF1f1f1f);
		}
		if (!ClientPrefs.PotatoOptimization) {
			FlxTween.color(hogTrees, 15, FlxColor.WHITE, 0xFF1f1f1f);
			FlxTween.color(hogFloor, 15, FlxColor.WHITE, 0xFF1f1f1f);
			FlxTween.color(hogRocks, 15, FlxColor.WHITE, 0xFF1f1f1f);  
			FlxTween.color(hogOverlay, 15, FlxColor.WHITE, 0xFF1f1f1f);
		}
	}

	public var closeLuas:Array<FunkinLua> = [];
	public function callOnLuas(event:String, args:Array<Dynamic>, ignoreStops = true, exclusions:Array<String> = null):Dynamic {
		var returnVal:Dynamic = FunkinLua.Function_Continue;
		#if LUA_ALLOWED
		if(exclusions == null) exclusions = [];
		for (script in luaArray) {
			if(exclusions.contains(script.scriptName))
				continue;

			var ret:Dynamic = script.call(event, args);
			if(ret == FunkinLua.Function_StopLua && !ignoreStops)
				break;
			
			// had to do this because there is a bug in haxe where Stop != Continue doesnt work
			var bool:Bool = ret == FunkinLua.Function_Continue;
			if(!bool && ret != 0) {
				returnVal = cast ret;
			}
		}
		#end
		//trace(event, returnVal);
		return returnVal;
	}

	public function setOnLuas(variable:String, arg:Dynamic) {
		#if LUA_ALLOWED
		for (i in 0...luaArray.length) {
			luaArray[i].set(variable, arg);
		}
		#end
	}

	function StrumPlayAnim(isDad:Bool, id:Int, time:Float) {
		var spr:StrumNote = null;
		if(isDad) {
			spr = strumLineNotes.members[id];
		} else {
			spr = playerStrums.members[id];
		}

		if(spr != null) {
			spr.playAnim('confirm', true);
			spr.resetAnim = time;
		}
	}

	public var ratingName:String = '?';
	public var ratingPercent:Float;
	public var ratingFC:String;
	public function RecalculateRating() {
		setOnLuas('score', songScore);
		setOnLuas('misses', songMisses);
		setOnLuas('hits', songHits);

		var ret:Dynamic = callOnLuas('onRecalculateRating', [], false);
		if(ret != FunkinLua.Function_Stop)
		{
			if(totalPlayed < 1)
				ratingName = '?';
			else {
				ratingPercent = Math.min(1, Math.max(0, totalNotesHit / totalPlayed));
				if(ratingPercent >= 1) {
					ratingName = ratingStuff[ratingStuff.length-1][0];
				} else {
					for (i in 0...ratingStuff.length-1) {
						if(ratingPercent < ratingStuff[i][1]) {
							ratingName = ratingStuff[i][0];
							break;
						}
					}
				}
			}

			// Rating FC
			ratingFC = "";
			if (sicks > 0) ratingFC = "SFC";
			if (goods > 0) ratingFC = "GFC";
			if (bads > 0 || shits > 0) ratingFC = "FC";
			if (songMisses > 0 && songMisses < 10) ratingFC = "SDCB";
			else if (songMisses >= 10) ratingFC = "Clear";
			if (TranslationLanguages.Text.exists(ratingFC) && ClientPrefs.Language != 'English')
				ratingFC = TranslationLanguages.Text[ratingFC];
		}
		setOnLuas('rating', ratingPercent);
		setOnLuas('ratingName', ratingName);
		setOnLuas('ratingFC', ratingFC);
	}

	public static var othersCodeName:String = 'otherAchievements';
	#if ACHIEVEMENTS_ALLOWED
	private function checkForAchievement(achievesToCheck:Array<String> = null):String {

		if(chartingMode) return null;

		var usedPractice:Bool = (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false));
		var achievementsToCheck:Array<String> = achievesToCheck;
		if (achievementsToCheck == null) {
			achievementsToCheck = [];
			for (i in 0...Achievements.achievementsStuff.length) {
				achievementsToCheck.push(Achievements.achievementsStuff[i][2]);
			}
			achievementsToCheck.push(othersCodeName);
		}

		for (i in 0...achievementsToCheck.length) {
			var achievementName:String = achievementsToCheck[i];
			var unlock:Bool = false;

			if (achievementName == othersCodeName) {
				if(isStoryMode && campaignMisses + songMisses < 1 && CoolUtil.difficultyString() == 'HARD' && storyPlaylist.length <= 1 && !changedDifficulty && !usedPractice)
				{
					var weekName:String = WeekData.getWeekFileName();

					for (json in Achievements.loadedAchievements) {
						if (json.unlocksAfter == weekName && !Achievements.isAchievementUnlocked(json.icon) && !json.customGoal) unlock = true;
						achievementName = json.icon;
					}

					for (k in 0...Achievements.achievementsStuff.length) {
						var unlockPoint:String = Achievements.achievementsStuff[k][3];
						if (unlockPoint != null) {
							if (unlockPoint == weekName && !unlock && !Achievements.isAchievementUnlocked(Achievements.achievementsStuff[k][2])) unlock = true;
							achievementName = Achievements.achievementsStuff[k][2];
						}
					}
				}
			}

			for (json in Achievements.loadedAchievements) { //Requires jsons for call
				var ret:Dynamic = callOnLuas('onCheckForAchievement', [json.icon]); //Set custom goals

				//IDK, like
				// if getProperty('misses') > 10 and leName == 'lmao_skill_issue' then return Function_Continue end

				if (ret == FunkinLua.Function_Continue && !Achievements.isAchievementUnlocked(json.icon) && json.customGoal && !unlock) {
					unlock = true;
					achievementName = json.icon;
				}
			}

			if(!Achievements.isAchievementUnlocked(achievementName) && !cpuControlled && !unlock) {
				switch(achievementName)
				{
					case 'ur_bad':
						if(ratingPercent < 0.2 && !practiceMode) {
							unlock = true;
						}
					case 'ur_good':
						if(ratingPercent >= 1 && !usedPractice) {
							unlock = true;
						}
					case 'roadkill_enthusiast':
						if(Achievements.henchmenDeath >= 100) {
							unlock = true;
						}
					case 'oversinging':
						if(boyfriend.holdTimer >= 10 && !usedPractice) {
							unlock = true;
						}
					case 'hype':
						if(!boyfriendIdled && !usedPractice) {
							unlock = true;
						}
					case 'two_keys':
						if(!usedPractice) {
							var howManyPresses:Int = 0;
							for (j in 0...keysPressed.length) {
								if(keysPressed[j]) howManyPresses++;
							}

							if(howManyPresses <= 2) {
								unlock = true;
							}
						}
					case 'toastie':
						if(/*ClientPrefs.framerate <= 60 &&*/ ClientPrefs.lowQuality && !ClientPrefs.globalAntialiasing /*&& !ClientPrefs.imagesPersist*/) {
							unlock = true;
						}
					case 'debugger':
						if(Paths.formatToSongPath(SONG.song) == 'test' && !usedPractice) {
							unlock = true;
						}
				}
			}

			if(unlock) {
				Achievements.unlockAchievement(achievementName);
				return achievementName;
			}
		}
		return null;
	}
	#end

	var curLight:Int = 0;
	var curLightEvent:Int = 0;
}
