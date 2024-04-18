package extras;

#if desktop
import Discord.DiscordClient;
#end
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import Song.SwagSong;
import Section.SwagSection;
import flixel.FlxCamera;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import openfl.display.Shader;
import shaders.BunchOfShittyShaders;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath; 

using StringTools;

class ExtraSongsState extends MusicBeatState
{
	var ExtraSongsPOne:FlxSprite;
	var ExtraSongsPTwo:FlxSprite;
	var CTRL:FlxSprite;
	var blackScreen:FlxSprite;
	
	var HOTV:FlxSprite;
	var IceCap:FlxSprite;
	var Endeavors:FlxSprite;
	var ExecutionInski:FlxSprite;
	var GottaGoRed:FlxSprite;
	var CoolParty:FlxSprite;
	var Melting:FlxSprite;
	var Drippyshine:FlxSprite;
	var Terror:FlxSprite;
	var TooFest:FlxSprite;
	var NostalgicDuo:FlxSprite;
	var Unresponsive:FlxSprite;
	var HerWorld:FlxSprite;
	var LukasWorld:FlxSprite;
	var HazeOG:FlxSprite;
	var HollowOld:FlxSprite;
	var LongSky:FlxSprite;
	var PerditionApollyon:FlxSprite;
	var MyHorizonWechidna:FlxSprite;
	var Playful:FlxSprite;
	var Tetrabrachial:FlxSprite;
	var ColorBlind:FlxSprite;
	var JusticeOld:FlxSprite;
	var Thunderbolt:FlxSprite;
	
	var HOTVSel:FlxSprite;
	var IceCapSel:FlxSprite;
	var EndeavorsSel:FlxSprite;
	var ExecutionInskiSel:FlxSprite;
	var GottaGoRedSel:FlxSprite;
	var CoolPartySel:FlxSprite;
	var MeltingSel:FlxSprite;
	var DrippyshineSel:FlxSprite;
	var TerrorSel:FlxSprite;
	var TooFestSel:FlxSprite;
	var NostalgicDuoSel:FlxSprite;
	var UnresponsiveSel:FlxSprite;
	var HerWorldSel:FlxSprite;
	var LukasWorldSel:FlxSprite;
	var HazeOGSel:FlxSprite;
	var HollowOldSel:FlxSprite;
	var LongSkySel:FlxSprite;
	var PerditionApollyonSel:FlxSprite;
	var MyHorizonWechidnaSel:FlxSprite;
	var PlayfulSel:FlxSprite;
	var TetrabrachialSel:FlxSprite;
	var ColorBlindSel:FlxSprite;
	var JusticeOldSel:FlxSprite;
	var ThunderboltSel:FlxSprite;
	
	var selone:FlxSprite;
	var seltwo:FlxSprite;
	var selthree:FlxSprite;
	var selfour:FlxSprite;
	var selfive:FlxSprite;
	var selsix:FlxSprite;
	var selseven:FlxSprite;
	var seleight:FlxSprite;
	var selnine:FlxSprite;
	var selten:FlxSprite;
	var seleleven:FlxSprite;
	var seltwelve:FlxSprite;
	
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	
	var curSelected:Int = 1;
	var curSelectedPage:Int = 1;
	var CanSelect:Bool = true;
	
	var scoreText:FlxText; 
	var scoreSong:String = 'her-world-old'; 
	var shiftMult:Int = 1;
	var holdTime:Float = 0;
	public static var playSong:Bool = false;
	
	var hitboxes:FlxTypedSpriteGroup<FlxSprite>;
	var hitboxOne:FlxSprite;
	var hitboxTwo:FlxSprite;
	var hitboxThree:FlxSprite;
	var hitboxFour:FlxSprite;
	var hitboxFive:FlxSprite;
	var hitboxSix:FlxSprite;
	var hitboxSeven:FlxSprite;
	var hitboxEight:FlxSprite;
	var hitboxNine:FlxSprite;
	var hitboxTen:FlxSprite;
	var hitboxEleven:FlxSprite;
	var hitboxTwelve:FlxSprite;
	
	override function create()
	{
		Paths.clearUnusedMemory();
		#if desktop
		var rpcName:String = 'In Extras Menu (Songs)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-songs';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		if (!playSong) {
			if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
				FlxG.sound.playMusic(Paths.music('extras'), 0);
				FlxG.sound.music.fadeIn(0.5, 0, 0.6);
			}
		} else {
			FlxG.sound.playMusic(Paths.music('extras'), 0);
			FlxG.sound.music.fadeIn(0.5, 0, 0.6);
		}
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		PlayState.isStory = false;
		PlayState.isEncore = false;
		PlayState.isExtras = false;
		PlayState.isSound = false;
		PlayState.isFreeplay = false;
		
		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;
		
		PlayState.BFEncoreSkins = false;
		PlayState.BFSkins = false;
		PlayState.GFEncoreSkins = false;
		PlayState.GFSkins = false;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.setFilters(filters);
		camGame.filtersEnabled = true;
		camGame.zoom = 0.85;
		
		if (ClientPrefs.Shaders) {
			filters.push(ExtrasVCRHandler.vcr);    
			//filters.push(ExtrasScanlineHandler.scanline);   
			ExtrasVCRHandler.vcrSet(0, true, true, true);
		}
		
		ExtraSongsPOne = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/songs'));
		ExtraSongsPOne.antialiasing = ClientPrefs.globalAntialiasing;
		ExtraSongsPOne.scrollFactor.set();
		add(ExtraSongsPOne);
		
		ExtraSongsPTwo = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/songs'));
		ExtraSongsPTwo.antialiasing = ClientPrefs.globalAntialiasing;
		ExtraSongsPTwo.scrollFactor.set();
		ExtraSongsPTwo.alpha = 0;
		add(ExtraSongsPTwo);
		
		CTRL = new FlxSprite(1089, 37).loadGraphic(Paths.image('extra/songs/ctrl-back'));
		CTRL.antialiasing = ClientPrefs.globalAntialiasing;
		CTRL.scrollFactor.set();
		CTRL.alpha = 0.4;
		add(CTRL);
		
		// Songs
		
		HOTV = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/hill-of-the-void'));
		HOTV.antialiasing = ClientPrefs.globalAntialiasing;
		HOTV.scrollFactor.set();
		HOTV.alpha = 0;
		add(HOTV);
		
		IceCap = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/ice-cap'));
		IceCap.antialiasing = ClientPrefs.globalAntialiasing;
		IceCap.scrollFactor.set();
		IceCap.alpha = 1;
		add(IceCap);
		
		Endeavors = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/endeavors-og'));
		Endeavors.antialiasing = ClientPrefs.globalAntialiasing;
		Endeavors.scrollFactor.set();
		Endeavors.alpha = 1;
		add(Endeavors);
		
		ExecutionInski = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/execution-inski'));
		ExecutionInski.antialiasing = ClientPrefs.globalAntialiasing;
		ExecutionInski.scrollFactor.set();
		ExecutionInski.alpha = 0;
		add(ExecutionInski);
		
		GottaGoRed = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/gotta-go-red'));
		GottaGoRed.antialiasing = ClientPrefs.globalAntialiasing;
		GottaGoRed.scrollFactor.set();
		GottaGoRed.alpha = 1;
		add(GottaGoRed);
		
		CoolParty = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/cool-party'));
		CoolParty.antialiasing = ClientPrefs.globalAntialiasing;
		CoolParty.scrollFactor.set();
		CoolParty.alpha = 1;
		add(CoolParty);
		
		Melting = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/melting'));
		Melting.antialiasing = ClientPrefs.globalAntialiasing;
		Melting.scrollFactor.set();
		Melting.alpha = 0;
		add(Melting);
		
		Drippyshine = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/drippyshine'));
		Drippyshine.antialiasing = ClientPrefs.globalAntialiasing;
		Drippyshine.scrollFactor.set();
		Drippyshine.alpha = 0;
		add(Drippyshine);
		
		Terror = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/terror'));
		Terror.antialiasing = ClientPrefs.globalAntialiasing;
		Terror.scrollFactor.set();
		Terror.alpha = 0;
		add(Terror);
		
		TooFest = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/too-fest-old'));
		TooFest.antialiasing = ClientPrefs.globalAntialiasing;
		TooFest.scrollFactor.set();
		TooFest.alpha = 1;
		add(TooFest);

		NostalgicDuo = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/nostalgic-duo'));
		NostalgicDuo.antialiasing = ClientPrefs.globalAntialiasing;
		NostalgicDuo.scrollFactor.set();
		NostalgicDuo.alpha = 1;
		add(NostalgicDuo);

		Unresponsive = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/unresponsive'));
		Unresponsive.antialiasing = ClientPrefs.globalAntialiasing;
		Unresponsive.scrollFactor.set();
		Unresponsive.alpha = 1;
		add(Unresponsive);
	
		HerWorld = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/her-world'));
		HerWorld.antialiasing = ClientPrefs.globalAntialiasing;
		HerWorld.scrollFactor.set();
		HerWorld.alpha = 0;
		add(HerWorld);
		
		LukasWorld = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/lukas-world'));
		LukasWorld.antialiasing = ClientPrefs.globalAntialiasing;
		LukasWorld.scrollFactor.set();
		LukasWorld.alpha = 0;
		add(LukasWorld);
		
		HazeOG = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/haze-og'));
		HazeOG.antialiasing = ClientPrefs.globalAntialiasing;
		HazeOG.scrollFactor.set();
		HazeOG.alpha = 0;
		add(HazeOG);
		
		HollowOld = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/hollow-old'));
		HollowOld.antialiasing = ClientPrefs.globalAntialiasing;
		HollowOld.scrollFactor.set();
		HollowOld.alpha = 1;
		add(HollowOld);
		
		LongSky = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/long-sky'));
		LongSky.antialiasing = ClientPrefs.globalAntialiasing;
		LongSky.scrollFactor.set();
		LongSky.alpha = 1;
		add(LongSky);
		
		PerditionApollyon = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/perdition-apollyon'));
		PerditionApollyon.antialiasing = ClientPrefs.globalAntialiasing;
		PerditionApollyon.scrollFactor.set();
		PerditionApollyon.alpha = 1;
		add(PerditionApollyon);
		
		MyHorizonWechidna = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/my-horizon-wechidna'));
		MyHorizonWechidna.antialiasing = ClientPrefs.globalAntialiasing;
		MyHorizonWechidna.scrollFactor.set();
		MyHorizonWechidna.alpha = 1;
		add(MyHorizonWechidna);
		
		Playful = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/playful'));
		Playful.antialiasing = ClientPrefs.globalAntialiasing;
		Playful.scrollFactor.set();
		Playful.alpha = 0;
		add(Playful);
		
		Tetrabrachial = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/tetrabrachial'));
		Tetrabrachial.antialiasing = ClientPrefs.globalAntialiasing;
		Tetrabrachial.scrollFactor.set();
		Tetrabrachial.alpha = 1;
		add(Tetrabrachial);
		
		ColorBlind = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/color-blind-old'));
		ColorBlind.antialiasing = ClientPrefs.globalAntialiasing;
		ColorBlind.scrollFactor.set();
		ColorBlind.alpha = 0;
		add(ColorBlind);
		
		JusticeOld = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/call-of-justice-old'));
		JusticeOld.antialiasing = ClientPrefs.globalAntialiasing;
		JusticeOld.scrollFactor.set();
		JusticeOld.alpha = 0;
		add(JusticeOld);
		
		Thunderbolt = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Songs/thunderbolt'));
		Thunderbolt.antialiasing = ClientPrefs.globalAntialiasing;
		Thunderbolt.scrollFactor.set();
		Thunderbolt.alpha = 1;
		add(Thunderbolt);
		
		// Songs Selected
		
		HOTVSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/hill-of-the-void'));
		HOTVSel.antialiasing = ClientPrefs.globalAntialiasing;
		HOTVSel.scrollFactor.set();
		HOTVSel.alpha = 0;
		add(HOTVSel);
		
		IceCapSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/ice-cap'));
		IceCapSel.antialiasing = ClientPrefs.globalAntialiasing;
		IceCapSel.scrollFactor.set();
		IceCapSel.alpha = 0;
		add(IceCapSel);
	
		EndeavorsSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/endeavors-og'));
		EndeavorsSel.antialiasing = ClientPrefs.globalAntialiasing;
		EndeavorsSel.scrollFactor.set();
		EndeavorsSel.alpha = 0;
		add(EndeavorsSel);
	
		ExecutionInskiSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/execution-inski'));
		ExecutionInskiSel.antialiasing = ClientPrefs.globalAntialiasing;
		ExecutionInskiSel.scrollFactor.set();
		ExecutionInskiSel.alpha = 0;
		add(ExecutionInskiSel);
		
		GottaGoRedSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/gotta-go-red'));
		GottaGoRedSel.antialiasing = ClientPrefs.globalAntialiasing;
		GottaGoRedSel.scrollFactor.set();
		GottaGoRedSel.alpha = 0;
		add(GottaGoRedSel);
		
		CoolPartySel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/cool-party'));
		CoolPartySel.antialiasing = ClientPrefs.globalAntialiasing;
		CoolPartySel.scrollFactor.set();
		CoolPartySel.alpha = 0;
		add(CoolPartySel);
		
		MeltingSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/melting'));
		MeltingSel.antialiasing = ClientPrefs.globalAntialiasing;
		MeltingSel.scrollFactor.set();
		MeltingSel.alpha = 0;
		add(MeltingSel);
		
		DrippyshineSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/drippyshine'));
		DrippyshineSel.antialiasing = ClientPrefs.globalAntialiasing;
		DrippyshineSel.scrollFactor.set();
		DrippyshineSel.alpha = 0;
		add(DrippyshineSel);
		
		TerrorSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/terror'));
		TerrorSel.antialiasing = ClientPrefs.globalAntialiasing;
		TerrorSel.scrollFactor.set();
		TerrorSel.alpha = 0;
		add(TerrorSel);
		
		TooFestSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/too-fest-old'));
		TooFestSel.antialiasing = ClientPrefs.globalAntialiasing;
		TooFestSel.scrollFactor.set();
		TooFestSel.alpha = 0;
		add(TooFestSel);
		
		NostalgicDuoSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/nostalgic-duo'));
		NostalgicDuoSel.antialiasing = ClientPrefs.globalAntialiasing;
		NostalgicDuoSel.scrollFactor.set();
		NostalgicDuoSel.alpha = 0;
		add(NostalgicDuoSel);		
		
		UnresponsiveSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/unresponsive'));
		UnresponsiveSel.antialiasing = ClientPrefs.globalAntialiasing;
		UnresponsiveSel.scrollFactor.set();
		UnresponsiveSel.alpha = 0;
		add(UnresponsiveSel);		
		
		HerWorldSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/her-world'));
		HerWorldSel.antialiasing = ClientPrefs.globalAntialiasing;
		HerWorldSel.scrollFactor.set();
		HerWorldSel.alpha = 1;
		add(HerWorldSel);
		
		LukasWorldSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/lukas-world'));
		LukasWorldSel.antialiasing = ClientPrefs.globalAntialiasing;
		LukasWorldSel.scrollFactor.set();
		LukasWorldSel.alpha = 0;
		add(LukasWorldSel);
		
		HazeOGSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/haze-og'));
		HazeOGSel.antialiasing = ClientPrefs.globalAntialiasing;
		HazeOGSel.scrollFactor.set();
		HazeOGSel.alpha = 0;
		add(HazeOGSel);
		
		HollowOldSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/hollow-old'));
		HollowOldSel.antialiasing = ClientPrefs.globalAntialiasing;
		HollowOldSel.scrollFactor.set();
		HollowOldSel.alpha = 0;
		add(HollowOldSel);
		
		LongSkySel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/long-sky'));
		LongSkySel.antialiasing = ClientPrefs.globalAntialiasing;
		LongSkySel.scrollFactor.set();
		LongSkySel.alpha = 0;
		add(LongSkySel);
		
		PerditionApollyonSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/perdition-apollyon'));
		PerditionApollyonSel.antialiasing = ClientPrefs.globalAntialiasing;
		PerditionApollyonSel.scrollFactor.set();
		PerditionApollyonSel.alpha = 0;
		add(PerditionApollyonSel);
		
		MyHorizonWechidnaSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/my-horizon-wechidna'));
		MyHorizonWechidnaSel.antialiasing = ClientPrefs.globalAntialiasing;
		MyHorizonWechidnaSel.scrollFactor.set();
		MyHorizonWechidnaSel.alpha = 0;
		add(MyHorizonWechidnaSel);
		
		PlayfulSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/playful'));
		PlayfulSel.antialiasing = ClientPrefs.globalAntialiasing;
		PlayfulSel.scrollFactor.set();
		PlayfulSel.alpha = 0;
		add(PlayfulSel);
		
		TetrabrachialSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/tetrabrachial'));
		TetrabrachialSel.antialiasing = ClientPrefs.globalAntialiasing;
		TetrabrachialSel.scrollFactor.set();
		TetrabrachialSel.alpha = 0;
		add(TetrabrachialSel);
		
		ColorBlindSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/color-blind-old'));
		ColorBlindSel.antialiasing = ClientPrefs.globalAntialiasing;
		ColorBlindSel.scrollFactor.set();
		ColorBlindSel.alpha = 0;
		add(ColorBlindSel);
		
		JusticeOldSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/call-of-justice-old'));
		JusticeOldSel.antialiasing = ClientPrefs.globalAntialiasing;
		JusticeOldSel.scrollFactor.set();
		JusticeOldSel.alpha = 0;
		add(JusticeOldSel);
		
		ThunderboltSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/SelectedSongs/thunderbolt'));
		ThunderboltSel.antialiasing = ClientPrefs.globalAntialiasing;
		ThunderboltSel.scrollFactor.set();
		ThunderboltSel.alpha = 0;
		add(ThunderboltSel);
		
		// Select
		
		selone = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel1'));
		selone.antialiasing = ClientPrefs.globalAntialiasing;
		selone.scrollFactor.set();
		selone.alpha = 1;
		add(selone);
		
		seltwo = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel2'));
		seltwo.antialiasing = ClientPrefs.globalAntialiasing;
		seltwo.scrollFactor.set();
		seltwo.alpha = 0;
		add(seltwo);
		
		selthree = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel3'));
		selthree.antialiasing = ClientPrefs.globalAntialiasing;
		selthree.scrollFactor.set();
		selthree.alpha = 0;
		add(selthree);
		
		selfour = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel4'));
		selfour.antialiasing = ClientPrefs.globalAntialiasing;
		selfour.scrollFactor.set();
		selfour.alpha = 0;
		add(selfour);
		
		selfive = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel5'));
		selfive.antialiasing = ClientPrefs.globalAntialiasing;
		selfive.scrollFactor.set();
		selfive.alpha = 0;
		add(selfive);
		
		selsix = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel6'));
		selsix.antialiasing = ClientPrefs.globalAntialiasing;
		selsix.scrollFactor.set();
		selsix.alpha = 0;
		add(selsix);
		
		selseven = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel7'));
		selseven.antialiasing = ClientPrefs.globalAntialiasing;
		selseven.scrollFactor.set();
		selseven.alpha = 0;
		add(selseven);
		
		seleight = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel8'));
		seleight.antialiasing = ClientPrefs.globalAntialiasing;
		seleight.scrollFactor.set();
		seleight.alpha = 0;
		add(seleight);
		
		selnine = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel9'));
		selnine.antialiasing = ClientPrefs.globalAntialiasing;
		selnine.scrollFactor.set();
		selnine.alpha = 0;
		add(selnine);
		
		selten = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel10'));
		selten.antialiasing = ClientPrefs.globalAntialiasing;
		selten.scrollFactor.set();
		selten.alpha = 0;
		add(selten);
		
		seleleven = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel11'));
		seleleven.antialiasing = ClientPrefs.globalAntialiasing;
		seleleven.scrollFactor.set();
		seleleven.alpha = 0;
		add(seleleven);
		
		seltwelve = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/songs/Select/sel12'));
		seltwelve.antialiasing = ClientPrefs.globalAntialiasing;
		seltwelve.scrollFactor.set();
		seltwelve.alpha = 0;
		add(seltwelve);

		scoreText = new FlxText(60, 640, FlxG.width, ""); 
		scoreText.setFormat(Paths.font("orange-kid.ttf"), 60, FlxColor.WHITE, LEFT); 
		scoreText.scrollFactor.set();
		add(scoreText); 

		hitboxes = new FlxTypedSpriteGroup<FlxSprite>();
		add(hitboxes);
		hitboxOne = new FlxSprite(46,165).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxOne);
		hitboxTwo = new FlxSprite(46,246).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxTwo);
		hitboxThree = new FlxSprite(46,327).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxThree);
		hitboxFour = new FlxSprite(46,408).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxFour);
		hitboxFive = new FlxSprite(46,489).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxFive);
		hitboxSix = new FlxSprite(46,570).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxSix);
		hitboxSeven = new FlxSprite(628,165).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxSeven);
		hitboxEight = new FlxSprite(628,246).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxEight);
		hitboxNine = new FlxSprite(628,327).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxNine);
		hitboxTen = new FlxSprite(628,408).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxTen);
		hitboxEleven = new FlxSprite(628,489).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxEleven);
		hitboxTwelve = new FlxSprite(628,570).makeGraphic(574, 73, 0x00000000);
		hitboxes.add(hitboxTwelve);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);
		
		FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {});
		
		Select(curSelected, '', false);

		super.create();
	}
	override function update(elapsed:Float)
	{
		if ((controls.BACK || FlxG.mouse.justPressedRight) && CanSelect)
		{
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new ExtrasState());
			});
			playSong = false;
			CanSelect = false;
		}
		
		if(FlxG.keys.pressed.SHIFT) {
			shiftMult = 3;
		} else {
			shiftMult = 1;
		}
		
		if (CanSelect) {
			if (!FlxG.mouse.overlaps(hitboxes)) {
				if (controls.UI_UP_P)
				{
					Select(-shiftMult,'up',true);
					holdTime = 0;
				}
				if (controls.UI_DOWN_P)
				{
					Select(shiftMult,'down',true);
					holdTime = 0;
				}
				if (controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						if (controls.UI_UP) Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult),'up',true);
						if (controls.UI_DOWN) Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult),'down',true);
					}
				}
				if (FlxG.mouse.wheel != 0)
				{
					if (FlxG.mouse.wheel > 0) {
						if (FlxG.mouse.wheel > 1) {
							Select(-shiftMult * 1,'up',true);
						} else {
							Select(-shiftMult * FlxG.mouse.wheel,'up',true);
						}
					}
					if (FlxG.mouse.wheel < 0) {
						if (FlxG.mouse.wheel < -1) {
							Select(-shiftMult * -1,'down',true);
						} else {
							Select(-shiftMult * FlxG.mouse.wheel,'down',true);
						}
					}
					holdTime = 0;
				}
				if (controls.UI_LEFT_P) Select(0,'left',true);
				if (controls.UI_RIGHT_P) Select(0,'right',true);
			}
			
			switch (curSelectedPage) {
				case 1:
					if (FlxG.mouse.overlaps(hitboxOne) && curSelected != 1) Select(1,'',true,true);
					if (FlxG.mouse.overlaps(hitboxTwo) && curSelected != 2) Select(2,'',true,true);
					if (FlxG.mouse.overlaps(hitboxThree) && curSelected != 3) Select(3,'',true,true);
					if (FlxG.mouse.overlaps(hitboxFour) && curSelected != 4) Select(4,'',true,true);
					if (FlxG.mouse.overlaps(hitboxFive) && curSelected != 5) Select(5,'',true,true);
					if (FlxG.mouse.overlaps(hitboxSix) && curSelected != 6) Select(6,'',true,true);
					if (FlxG.mouse.overlaps(hitboxSeven) && curSelected != 7) Select(7,'',true,true);
					if (FlxG.mouse.overlaps(hitboxEight) && curSelected != 8) Select(8,'',true,true);
					if (FlxG.mouse.overlaps(hitboxNine) && curSelected != 9) Select(9,'',true,true);
					if (FlxG.mouse.overlaps(hitboxTen) && curSelected != 10) Select(10,'',true,true);
					if (FlxG.mouse.overlaps(hitboxEleven) && curSelected != 11) Select(11,'',true,true);
					if (FlxG.mouse.overlaps(hitboxTwelve) && curSelected != 12) Select(12,'',true,true);
				case 2:
					if (FlxG.mouse.overlaps(hitboxOne) && curSelected != 1) Select(1,'',true,true);
					if (FlxG.mouse.overlaps(hitboxTwo) && curSelected != 2) Select(2,'',true,true);
					if (FlxG.mouse.overlaps(hitboxThree) && curSelected != 3) Select(3,'',true,true);
					if (FlxG.mouse.overlaps(hitboxFour) && curSelected != 4) Select(4,'',true,true);
					if (FlxG.mouse.overlaps(hitboxFive) && curSelected != 5) Select(5,'',true,true);
					if (FlxG.mouse.overlaps(hitboxSix) && curSelected != 6) Select(6,'',true,true);
					if (FlxG.mouse.overlaps(hitboxSeven) && curSelected != 7) Select(7,'',true,true);
					if (FlxG.mouse.overlaps(hitboxEight) && curSelected != 8) Select(8,'',true,true);
					if (FlxG.mouse.overlaps(hitboxNine) && curSelected != 9) Select(9,'',true,true);
					if (FlxG.mouse.overlaps(hitboxTen) && curSelected != 10) Select(10,'',true,true);
					if (FlxG.mouse.overlaps(hitboxEleven) && curSelected != 11) Select(11,'',true,true);
					if (FlxG.mouse.overlaps(hitboxTwelve) && curSelected != 12) Select(12,'',true,true);
			}
			
			if (FlxG.mouse.overlaps(CTRL))
				CTRL.alpha = FlxMath.lerp(CTRL.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
			else
				CTRL.alpha = FlxMath.lerp(CTRL.alpha, 0.4, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
			
			switch (curSelectedPage) {
				case 1:
					if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(hitboxes))) {
						FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
						FlxG.sound.music.fadeOut(0.5, 0);
						
						switch (curSelected) {
							case 1:
								PlayState.SONG = Song.loadFromJson('hill-of-the-void' + '-hard', 'hill-of-the-void');
							case 2:
								PlayState.SONG = Song.loadFromJson('ice-cap' + '-hard', 'ice-cap');
							case 3:
								PlayState.SONG = Song.loadFromJson('endeavors-og' + '-hard', 'endeavors-og');
							case 4:
								PlayState.SONG = Song.loadFromJson('execution-inski' + '-hard', 'execution-inski');
							case 5:
								PlayState.SONG = Song.loadFromJson('gotta-go-red-glove' + '-hard', 'gotta-go-red-glove');
							case 6:
								PlayState.SONG = Song.loadFromJson('cool-party' + '-hard', 'cool-party');
							case 7:
								PlayState.SONG = Song.loadFromJson('melting-old' + '-hard', 'melting-old');
							case 8:
								PlayState.SONG = Song.loadFromJson('drippyshine' + '-hard', 'drippyshine');
							case 9:
								PlayState.SONG = Song.loadFromJson('terror' + '-hard', 'terror');
							case 10:
								PlayState.SONG = Song.loadFromJson('too-fest-old' + '-hard', 'too-fest-old');
							case 11:
								PlayState.SONG = Song.loadFromJson('nostalgic-duo' + '-hard', 'nostalgic-duo');
							case 12:
								PlayState.SONG = Song.loadFromJson('unresponsive' + '-hard', 'unresponsive');
						}
						if (curSelected == 10)
							Main.DisableCustomCursor = true;
						else
							Main.DisableCustomCursor = false;
						
						PlayState.isStory = false; 
						PlayState.isEncore = false;
						PlayState.isExtras = true; 
						PlayState.isSound = false;
						PlayState.isFreeplay = false;
						PlayState.storyDifficulty = 2; 
						PlayState.storyWeek = 1; 
						FlxG.sound.play(Paths.sound('tick'), 0.4);
						new FlxTimer().start(0.8, function(tmr:FlxTimer) 
						{ 
							Main.InPlaystate = true;
							LoadingState.loadAndSwitchState(new PlayState()); 
						}); 
						
						CanSelect = false;
					}
					
					if (FlxG.keys.justPressed.CONTROL || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(CTRL))) {
						curSelected = 1;
						curSelectedPage = 2;
						Select(curSelected);
						CTRL.loadGraphic(Paths.image('extra/songs/ctrl-back'));
					}
					
				case 2:
					if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(hitboxes))) {
						FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
						FlxG.sound.music.fadeOut(0.5, 0);
						
						switch (curSelected) {
							case 1:
								PlayState.SONG = Song.loadFromJson('her-world-old' + '-hard', 'her-world-old');
							case 2:
								PlayState.SONG = Song.loadFromJson('lukas-world' + '-hard', 'lukas-world');
							case 3:
								PlayState.SONG = Song.loadFromJson('haze-og' + '-hard', 'haze-og');
							case 4:
								PlayState.SONG = Song.loadFromJson('hollow-old' + '-hard', 'hollow-old');
							case 5:
								PlayState.SONG = Song.loadFromJson('long-sky' + '-hard', 'long-sky');
							case 6:
								PlayState.SONG = Song.loadFromJson('perdition-apollyon' + '-hard', 'perdition-apollyon');
							case 7:
								PlayState.SONG = Song.loadFromJson('my-horizon-wechidna' + '-hard', 'my-horizon-wechidna');
							case 8:
								PlayState.SONG = Song.loadFromJson('playful' + '-hard', 'playful');
							case 9:
								PlayState.SONG = Song.loadFromJson('tetrabrachial' + '-hard', 'tetrabrachial');
							case 10:
								PlayState.SONG = Song.loadFromJson('color-blind-old' + '-hard', 'color-blind-old');
							case 11:
								PlayState.SONG = Song.loadFromJson('call-of-justice-old' + '-hard', 'call-of-justice-old');
							case 12:
								PlayState.SONG = Song.loadFromJson('thunderbolt' + '-hard', 'thunderbolt');
						}
						
						PlayState.isStory = false; 
						PlayState.isEncore = false;
						PlayState.isExtras = true; 
						PlayState.isSound = false;
						PlayState.isFreeplay = false;
						PlayState.storyDifficulty = 2; 
						PlayState.storyWeek = 1; 
						FlxG.sound.play(Paths.sound('tick'), 0.4);
						new FlxTimer().start(0.8, function(tmr:FlxTimer) 
						{ 
							Main.InPlaystate = true;
							LoadingState.loadAndSwitchState(new PlayState()); 
						}); 
						
						CanSelect = false;
					}
					
					if (FlxG.keys.justPressed.CONTROL || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(CTRL))) {
						curSelected = 1;
						curSelectedPage = 1;
						Select(curSelected);
						CTRL.loadGraphic(Paths.image('extra/songs/ctrl'));
					}
			}
		}
	}
	
	function Select(Sel:Int, bruh:String = '', ?PlayTick:Bool = true, ?mouse:Bool = false):Void
	{	
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		switch(bruh) {
			case 'up':
				switch (curSelectedPage) {
					case 1:
						if (shiftMult == 1) {
							switch (curSelected) {
								case 1:
									curSelected = 8;
									curSelectedPage = 2;
									Select(curSelected, '', true);
								case 2,3,4,5,6,7,8,9,10,11,12:
									curSelected += Sel;
							}
						}
						if (shiftMult == 3) {
							switch (curSelected) {
								case 1,2,3:
									curSelected = 8;
									curSelectedPage = 2;
									Select(curSelected, '', true);
								case 4,5,6,7,8,9,10,11,12:
									curSelected += Sel;
							}
						}
					case 2:
						if (shiftMult == 1) {
							switch (curSelected) {
								case 1:
									curSelected = 8;
									curSelectedPage = 2;
									Select(curSelected, '', true);
								case 2,3,4,5,6,7,8,9,10,11,12:
									curSelected += Sel;
							}
						}
						if (shiftMult == 3) {
							switch (curSelected) {
								case 1,2,3:
									curSelected = 8;
									curSelectedPage = 2;
									Select(curSelected, '', true);
								case 4,5,6,7,8,9,10,11,12:
									curSelected += Sel;
							}
						}
					}
			case 'down':
				switch (curSelectedPage) {
					case 1:
						if (shiftMult == 1) {
							switch (curSelected) {
								case 1,2,3,4,5,6,7,8,9,10,11:
									curSelected += Sel;
								case 12:
									curSelected = 1;
									curSelectedPage = 2;
									Select(curSelected, '', true);
							}
						}
						if (shiftMult == 3) {
							switch (curSelected) {
								case 1,2,3,4,5,6,7,8,9:
									curSelected += Sel;
								case 10,11,12:
									curSelected = 1;
									curSelectedPage = 2;
									Select(curSelected, '', true);
							}
						}
					case 2:
						if (shiftMult == 1) {
							switch (curSelected) {
								case 1,2,3,4,5,6,7,8,9,10,11:
									curSelected += Sel;
								case 12:
									curSelected = 1;
									curSelectedPage = 2;
									Select(curSelected, '', true);
							}
						}
						if (shiftMult == 3) {
							switch (curSelected) {
								case 1,2,3,4,5,6,7,8,9:
									curSelected += Sel;
								case 10,11,12:
									curSelected = 1;
									curSelectedPage = 2;
									Select(curSelected, '', true);
							}
						}
				}
			case 'left':
				switch (curSelectedPage) {
					case 1:
						switch (curSelected) {
							case 7: curSelected = 1;
							case 8: curSelected = 2;
							case 9: curSelected = 3;
							case 10: curSelected = 4;
							case 11: curSelected = 5;
							case 12: curSelected = 6;
						}
					case 2:
						switch (curSelected) {
							case 7: curSelected = 1;
							case 8: curSelected = 2;
							case 9: curSelected = 3;
							case 10: curSelected = 4;
							case 11: curSelected = 5;
							case 12: curSelected = 6;
						}
				}
			case 'right':
				switch (curSelectedPage) {
					case 1:
						switch (curSelected) {
							case 1: curSelected = 7;
							case 2: curSelected = 8;
							case 3: curSelected = 9;
							case 4: curSelected = 10;
							case 5: curSelected = 11;
							case 6: curSelected = 12;
						}
					case 2:
						switch (curSelected) {
							case 1: curSelected = 7;
							case 2: curSelected = 8;
							case 3: curSelected = 9;
							case 4: curSelected = 10;
							case 5: curSelected = 11;
							case 6: curSelected = 12;
						}
				}
			default:
				if (mouse) curSelected = Sel;
		}
		ExtraSongsPOne.alpha = 0;
		ExtraSongsPTwo.alpha = 0;
		
		selone.alpha = 0;
		seltwo.alpha = 0;
		selthree.alpha = 0;
		selfour.alpha = 0;
		selfive.alpha = 0;
		selsix.alpha = 0;
		selseven.alpha = 0;
		seleight.alpha = 0;
		selnine.alpha = 0;
		selten.alpha = 0;
		seleleven.alpha = 0;
		seltwelve.alpha = 0;
		
		HOTV.alpha = 0;
		IceCap.alpha = 0;
		Endeavors.alpha = 0;
		ExecutionInski.alpha = 0;
		GottaGoRed.alpha = 0;
		CoolParty.alpha = 0;
		Melting.alpha = 0;
		Drippyshine.alpha = 0;
		Terror.alpha = 0;
		TooFest.alpha = 0;
		NostalgicDuo.alpha = 0;
		Unresponsive.alpha = 0;
		HerWorld.alpha = 0;
		LukasWorld.alpha = 0;
		HazeOG.alpha = 0;
		HollowOld.alpha = 0;
		LongSky.alpha = 0;
		PerditionApollyon.alpha = 0;
		MyHorizonWechidna.alpha = 0;
		Playful.alpha = 0;
		Tetrabrachial.alpha = 0;
		ColorBlind.alpha = 0;
		JusticeOld.alpha = 0;
		Thunderbolt.alpha = 0;
			
		HOTVSel.alpha = 0;
		IceCapSel.alpha = 0;
		EndeavorsSel.alpha = 0;
		ExecutionInskiSel.alpha = 0;
		GottaGoRedSel.alpha = 0;
		CoolPartySel.alpha = 0;
		MeltingSel.alpha = 0;
		DrippyshineSel.alpha = 0;
		TerrorSel.alpha = 0;
		TooFestSel.alpha = 0;
		NostalgicDuoSel.alpha = 0;
		UnresponsiveSel.alpha = 0;
		HerWorldSel.alpha = 0;
		LukasWorldSel.alpha = 0;
		HazeOGSel.alpha = 0;
		HollowOldSel.alpha = 0;
		LongSkySel.alpha = 0;
		PerditionApollyonSel.alpha = 0;
		MyHorizonWechidnaSel.alpha = 0;
		PlayfulSel.alpha = 0;
		TetrabrachialSel.alpha = 0;
		ColorBlindSel.alpha = 0;
		JusticeOldSel.alpha = 0;
		ThunderboltSel.alpha = 0;
		
		switch (curSelectedPage) {
			case 1:
				ExtraSongsPOne.alpha = 1;
				switch (curSelected) {
					case 1:
						scoreSong = 'hill-of-the-void';
						selone.alpha = 1;
						HOTVSel.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 2:
						scoreSong = 'ice-cap';
						seltwo.alpha = 1;
						IceCapSel.alpha = 1;
						HOTV.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 3:
						scoreSong = 'endeavors-og';
						selthree.alpha = 1;
						EndeavorsSel.alpha = 1;
						ExecutionInski.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 4:
						scoreSong = 'execution-inski';
						selfour.alpha = 1;
						GottaGoRed.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInskiSel.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 5:
						scoreSong = 'gotta-go-red-glove';
						selfive.alpha = 1;
						CoolParty.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRedSel.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 6:
						scoreSong = 'cool-party';
						selsix.alpha = 1;
						Melting.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolPartySel.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 7:
						scoreSong = 'melting-old';
						selseven.alpha = 1;
						Drippyshine.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						MeltingSel.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 8:
						scoreSong = 'drippyshine';
						seleight.alpha = 1;
						Terror.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						DrippyshineSel.alpha = 1;
						TooFest.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 9:
						scoreSong = 'terror';
						selnine.alpha = 1;
						TooFest.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						TerrorSel.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 10:
						scoreSong = 'too-fest-old';
						selten.alpha = 1;
						TooFestSel.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						NostalgicDuo.alpha = 1;
						Unresponsive.alpha = 1;
					case 11:
						scoreSong = 'nostalgic-duo';
						seleleven.alpha = 1;
						NostalgicDuoSel.alpha = 1;
						Endeavors.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						TooFest.alpha = 1;
						Unresponsive.alpha = 1;
					case 12:
						scoreSong = 'unresponsive';
						seltwelve.alpha = 1;
						UnresponsiveSel.alpha = 1;
						HOTV.alpha = 1;
						IceCap.alpha = 1;
						Endeavors.alpha = 1;
						ExecutionInski.alpha = 1;
						GottaGoRed.alpha = 1;
						CoolParty.alpha = 1;
						Melting.alpha = 1;
						Drippyshine.alpha = 1;
						Terror.alpha = 1;
						NostalgicDuo.alpha = 1;
						TooFest.alpha = 1;
				}
				
			case 2:
				ExtraSongsPTwo.alpha = 1;
				switch (curSelected) {
					case 1:
						scoreSong = 'her-world-old';
						selone.alpha = 1;
						HerWorldSel.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
					case 2:
						scoreSong = 'lukas-world';
						seltwo.alpha = 1;
						LukasWorldSel.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
					case 3:
						scoreSong = 'haze-og';
						selthree.alpha = 1;
						HazeOGSel.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
					case 4:
						scoreSong = 'hollow-old';
						selfour.alpha = 1;
						HollowOldSel.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
					case 5:
						scoreSong = 'long-sky';
						selfive.alpha = 1;
						LongSkySel.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
					case 6:
						scoreSong = 'perdition-apollyon';
						selsix.alpha = 1;
						PerditionApollyonSel.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
					case 7:
						scoreSong = 'my-horizon-wechidna';
						selseven.alpha = 1;
						MyHorizonWechidnaSel.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
					case 8:
						scoreSong = 'playful';
						seleight.alpha = 1;
						PlayfulSel.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
					case 9:
						scoreSong = 'tetrabrachial';
						selnine.alpha = 1;
						TetrabrachialSel.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
					case 10:
						scoreSong = 'color-blind-old';
						selten.alpha = 1;
						ColorBlindSel.alpha = 1;
						JusticeOld.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
					case 11:
						scoreSong = 'call-of-justice-old';
						seleleven.alpha = 1;
						JusticeOldSel.alpha = 1;
						Thunderbolt.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
					case 12:
						scoreSong = 'thunderbolt';
						seltwelve.alpha = 1;
						ThunderboltSel.alpha = 1;
						HerWorld.alpha = 1;
						LukasWorld.alpha = 1;
						HazeOG.alpha = 1;
						HollowOld.alpha = 1;
						LongSky.alpha = 1;
						PerditionApollyon.alpha = 1;
						MyHorizonWechidna.alpha = 1;
						Playful.alpha = 1;
						Tetrabrachial.alpha = 1;
						ColorBlind.alpha = 1;
						JusticeOld.alpha = 1;
				}
			}
		scoreText.text = 'Extras-Score: ';
		if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
			scoreText.text = TranslationLanguages.Text[scoreText.text] + Highscore.getScore(scoreSong, 2);
		else
			scoreText.text = 'Score: ' + Highscore.getScore(scoreSong, 2);
	}
}