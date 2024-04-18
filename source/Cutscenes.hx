package;

#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
#if sys
import sys.FileSystem;
import sys.io.File;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.FlxCamera;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import flash.text.TextField; 
import flixel.group.FlxGroup.FlxTypedGroup; 
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup; 
import flixel.addons.transition.FlxTransitionableState; 
#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

using StringTools;
class Cutscenes extends MusicBeatState
{	
	//HaxeIntro.hx
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	
	//FinalEscapeThing.hx
	public static var instance:Cutscenes;
	private var camGame:FlxCamera;
	var debugKeys:Array<FlxKey>;
	public static var closedStat:Bool = false;
	public static var psychVersion:String = '0.5.2 (v1.0)'; //This is also used for Discord RPC

	//FatalEncoreCutscene.hx
	var cmdY:Int = 54;
	var textCMD:FlxTypedSpriteGroup<FlxSprite>;
	
	//Cutscenes.hx
	var cutsceneName:String = 'Haxe';
	var MP4FileName:String = '';
	var WaitTime:Float = 0.3;
	var EndState:String = 'Haxe';
	var songToPlay:String = 'none';
	var DiscordRPCimg:String = 'icon';
	var DiscordRPCtext:String = 'In Cutscene';
	
	public function new(?cutsceneName:String = 'Haxe', ?MP4FileName:String = '', ?WaitTime:Float = 0.3, ?EndState:String = '', ?songToPlay:String = 'none', ?DiscordRPCimg:String = 'icon', ?DiscordRPCtext:String = 'In Cutscene')
	{
		super();
		this.cutsceneName = cutsceneName;
		this.MP4FileName = MP4FileName;
		this.WaitTime = WaitTime;
		this.EndState = EndState;
		this.songToPlay = songToPlay;
		this.DiscordRPCimg = DiscordRPCimg;
		this.DiscordRPCtext = DiscordRPCtext;
		
		switch (cutsceneName) {
			case 'Haxe' | 'FEStory' | 'Fatal Encore' | 'Haxe-LangChange':
			case 'SEGA' | 'FECrash' | 'STCodes':
				PlayCutscene(cutsceneName);
		}
	}
	
	override function create()
	{
		instance = this;
		switch (cutsceneName) {
			case 'Haxe':
				#if windows
				WinPaths.getDesktopFileNames(false, false, false, false, true);
				#end
			
				FlxG.mouse.visible = false;
				if (FlxG.sound.music != null)
					FlxG.sound.music.volume = 0;
				
				FlxG.sound.muteKeys = muteKeys;
				FlxG.sound.volumeDownKeys = volumeDownKeys;
				FlxG.sound.volumeUpKeys = volumeUpKeys;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				
				if (ClientPrefs.storyProgressExe != 3) {
					CoolUtil.precacheSound('TitleLaugh');
					CoolUtil.precacheMusic('freakyMenu');
					CoolUtil.precacheMusic('storymodemenumusic');
					CoolUtil.precacheMusic('storymode');
					CoolUtil.precacheMusic('encoremode');
					CoolUtil.precacheMusic('freeplaymode');
					CoolUtil.precacheMusic('extras');
					CoolUtil.precacheMusic('options');
					CoolUtil.precacheSound('showMoment', 'shared');
					CoolUtil.precacheSound('menulaugh');
					CoolUtil.precacheSound('menumomentclick');
				}
				persistentUpdate = true;

				Paths.clearStoredMemory();
				Paths.clearUnusedMemory();

				#if desktop
				WeekData.loadTheFirstEnabledMod();
				#end

				FlxG.game.focusLostFramerate = 60;
				FlxG.keys.preventDefaultKeys = [TAB];
				PlayerSettings.init();
				FlxG.save.bind('funkin', 'ninjamuffin99');
				ClientPrefs.loadPrefs();
				Highscore.load();
				
				FlxG.sound.muted = ClientPrefs.volMuted;
				FlxG.sound.volume = ClientPrefs.volVolume;
				
				switch(ClientPrefs.Language) {
					case 'Russian':
						TranslationLanguages.Text = TranslationLanguages.TextRussian;
						TranslationLanguages.Files = TranslationLanguages.FilesRussian;
					case 'Spanish':
						TranslationLanguages.Text = TranslationLanguages.TextSpanish;
						TranslationLanguages.Files = TranslationLanguages.FilesSpanish;
					case 'English':
						TranslationLanguages.Text = [];
						TranslationLanguages.Files = [];
				}
				
				#if windows
				if (FlxG.fullscreen)
					FlxG.fullscreen = false;
				#end

				#if desktop
				if (!DiscordClient.isInitialized)
				{
					DiscordClient.initialize();
					Application.current.onExit.add (function (exitCode) {
						DiscordClient.shutdown();
					});
				}
				#end
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{	
					#if FREEPLAY
					MusicBeatState.switchState(new FreeplayState());
					#elseif CHARTING
					if (ClientPrefs.ClassicChartEditor)
						MusicBeatState.switchState(new ChartingState());
					else
						MusicBeatState.switchState(new BuggyChartingState());
					#else
					PlayCutscene('Haxe');
					#end
				});
				
			case 'Haxe-LangChange':
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				persistentUpdate = true;
				
				FlxG.sound.muted = ClientPrefs.volMuted;
				FlxG.sound.volume = ClientPrefs.volVolume;
				
				switch(ClientPrefs.Language) {
					case 'Russian':
						TranslationLanguages.Text = TranslationLanguages.TextRussian;
						TranslationLanguages.Files = TranslationLanguages.FilesRussian;
					case 'Spanish':
						TranslationLanguages.Text = TranslationLanguages.TextSpanish;
						TranslationLanguages.Files = TranslationLanguages.FilesSpanish;
					case 'English':
						TranslationLanguages.Text = [];
						TranslationLanguages.Files = [];
				}
				
				#if windows
				if (FlxG.fullscreen)
					FlxG.fullscreen = false;
				#end

				new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{	
					MusicBeatState.switchState(new PreLaunchSettingsState());
				});
				
			case 'FEStory':
				FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.0);
				FlxG.mouse.visible = false;
				Conductor.changeBPM(102);
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				
				PlayState.BFEncoreSkins = false;
				PlayState.BFSkins = false;
				PlayState.GFEncoreSkins = false;
				PlayState.GFSkins = false;
				
				WeekData.loadTheFirstEnabledMod();
				
				#if desktop
				var rpcName:String = 'You must die';
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.changePresence(rpcName, "scary");
				#end
				
				debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

				camGame = new FlxCamera();
				FlxG.cameras.reset(camGame);
				FlxCamera.defaultCameras = [camGame];
				persistentUpdate = true;
				
				new FlxTimer().start(0.2, function(omg:FlxTimer) {
					PlayState.storyPlaylist = ['final-escape', 'face-off'];
					PlayState.isStoryMode = true;
					PlayState.isStory = true;
					PlayState.storyDifficulty = 2;
					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
					PlayState.storyWeek = 1;
					new FlxTimer().start(0.4, function(tmr:FlxTimer) 
					{ 
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState()); 
					}); 
				});
				
			case 'Fatal Encore':
				#if desktop
				var rpcName:String = 'NOT FOUND';
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.imageRpc = 'scary';
				DiscordClient.changePresence(rpcName, null);
				#end
				Main.DisableCustomCursor = true;
				FlxG.mouse.visible = false;
				
				var HaxeFEIntro:MP4Handler = new MP4Handler();
				HaxeFEIntro.playVideo(Paths.video('HaxeFlixelIntro-fatal-enc'));
				HaxeFEIntro.finishCallback = function() {	
					var SonicFEIntro:MP4Handler = new MP4Handler();
					SonicFEIntro.playVideo(Paths.video('sonicexe-intro-fatal-enc'));
					SonicFEIntro.finishCallback = function() {	
						if (ClientPrefs.showFPS && Main.fpsVar != null)
							Main.fpsVar.visible = false;
						textCMD = new FlxTypedSpriteGroup<FlxSprite>();
						add(textCMD);
						
						var Windows = new FlxText(0, 0, FlxG.width, 'Microsoft Windows [Version 10.0.19045.3324]\n(c) Microsoft Corporation. All rights reserved.');
						Windows.setFormat(Paths.font("cmd/consolas.ttf"), 16, 0xFFFFFFFF, LEFT);
						Windows.scrollFactor.set();
						textCMD.add(Windows);
						
						cmdTextInput('Text', '[!Error!] Restoration.exe not found', 0xFFFFFFFF, 1, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Error!] explorer.exe not found', 0xFFFFFFFF, 1.2, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] winload.exe not found', 0xFFFFFFFF, 1.4, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] wimserv.exe not found', 0xFFFFFFFF, 1.5, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] XInput1_4.dll not found', 0xFFFFFFFF, 1.7, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] xwreg.dll not found', 0xFFFFFFFF, 1.8, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] regsvr32.exe not found', 0xFFFFFFFF, 1.95, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] propsys.dll not found', 0xFFFFFFFF, 2.1, false, false, 0xFFFF0000);
						cmdTextInput('Sys', '[!Warning!] powercfg.exe not found', 0xFFFFFFFF, 2.2, false, false, 0xFFFF0000);
						cmdTextInput('Loading', 'Data Recovery', 0xFFFFFFFF, 2.5);
						cmdTextInput('Text', '[!Error!] Data cannot be recovered', 0xFFFFFFFF, 12.5, false, false, 0xFFFF0000);
						cmdTextInput('User', "[!Warning!] You don't have permission", 0xFFFFFFFF, 13, false, false, 0xFFFF0000);
						cmdTextInput('Fatal', 'Successfully authorized', 0xFFFFFFFF, 13.4);
						cmdTextInput('Fatal', 'Full access rights successfully obtained', 0xFFFFFFFF, 13.6);
						
						new FlxTimer().start(14.5, function(centerTalk:FlxTimer) {
							textCMD.destroy();
							switch(ClientPrefs.Language) {
								case 'Russian':
									centerTalkText('П|р|и|в|е|т|,| |п|о|л|ь|з|о|в|а|т|е|л|ь|.|', 0xFFFF0000, 1, 0.095, 'fatal-encore-cutscene-voice/1', 'exe');
									centerTalkText('Т|в|о|ё| |б|е|з|р|а|с|с|у|д|с|т|в|о| |п|р|и|в|е|л|о| |т|е|б|я| |с|ю|д|а|.|', 0xFFFF0000, 4, 0.065, 'fatal-encore-cutscene-voice/2', 'exe');
									centerTalkText('П|о|с|л|е| |с|т|о|л|ь|к|и|х| |п|о|п|ы|т|о|к|.|.|.|', 0xFFFF0000, 7.8, 0.09, 'fatal-encore-cutscene-voice/3', 'exe');
									centerTalkText('М|о|е| |в|р|е|м|я| |п|р|и|ш|л|о|,| |Т|В|О|Ё| |-| |О|К|О|Н|Ч|Е|Н|О|', 0xFFFF0000, 11.7, 0.105, 'fatal-encore-cutscene-voice/4', 'exe');
								case 'Spanish':
									centerTalkText('H|o|l|a|,| |U|s|u|a|r|i|o|.|', 0xFFFF0000, 1, 0.10, 'fatal-encore-cutscene-voice/1', 'exe');
									centerTalkText('T|u| |i|m|p|r|u|d|e|n|c|i|a| |t|e| |t|r|a|j|o |a|q|u|í|.|', 0xFFFF0000, 4, 0.08, 'fatal-encore-cutscene-voice/2', 'exe');
									centerTalkText('D|e|s|p|u|é|s |d|e| |v|a|r|i|o|s |i|n|t|e|n|t|o|s|.|.|.|', 0xFFFF0000, 8, 0.08, 'fatal-encore-cutscene-voice/3', 'exe');
									centerTalkText('M|i| |m|o|m|e|n|t|o |a| |l|l|e|g|a|d|o|,| |E|L| |T|U|Y|O| |S|E| |A|C|A|B|Ó|', 0xFFFF0000, 12, 0.065, 'fatal-encore-cutscene-voice/4', 'exe');
								default:
									centerTalkText('H|e|l|l|o|,| |U|s|e|r|.|', 0xFFFF0000, 1, 0.11, 'fatal-encore-cutscene-voice/1', 'exe');
									centerTalkText('Y|o|u|r| |r|e|c|k|l|e|s|s|n|e|s|s| |h|a|s| |b|r|o|u|g|h|t| |y|o|u| |h|e|r|e|', 0xFFFF0000, 4, 0.065, 'fatal-encore-cutscene-voice/2', 'exe');
									centerTalkText('A|f|t|e|r| |s|o| |m|a|n|y| |t|r|i|e|s|.|.|.|', 0xFFFF0000, 8, 0.09, 'fatal-encore-cutscene-voice/3', 'exe');
									centerTalkText('M|y| |t|i|m|e| |h|a|s| |c|o|m|e|,| |Y|O|U|R|S| |i|s| |O|V|E|R|', 0xFFFF0000, 12, 0.105, 'fatal-encore-cutscene-voice/4', 'exe');
							}
							if (!ClientPrefs.cutsceneYouSaw.contains('fatality-encore'))
								ClientPrefs.cutsceneYouSaw.push('fatality-encore');
							ClientPrefs.saveSettings();

							new FlxTimer().start(18, function(startSong:FlxTimer) {
								PlayState.SONG = Song.loadFromJson('fatality-encore', 'fatality-encore');
								PlayState.isStory = false;
								PlayState.isEncore = true;
								PlayState.isExtras = false;
								PlayState.isSound = false;
								PlayState.isFreeplay = false;
								PlayState.storyDifficulty = 1;
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
								new FlxTimer().start(0.5, function(songtimer:FlxTimer)
								{
									if (ClientPrefs.showFPS && Main.fpsVar != null)
										Main.fpsVar.visible = true;
									Main.InPlaystate = true;
									FlxG.mouse.visible = true;
									LoadingState.loadAndSwitchState(new PlayState());
								});
							});
						});
					}
				}
				
			default:
				if (TranslationLanguages.Text.exists(DiscordRPCtext) && ClientPrefs.Language != 'English')
					DiscordRPCtext = TranslationLanguages.Text[DiscordRPCtext];
				if (FlxG.sound.music != null)
					FlxG.sound.music.volume = 0;
				#if desktop
				DiscordClient.imageRpc = DiscordRPCimg;
				DiscordClient.changePresence(DiscordRPCtext, null);
				#end
				FlxG.mouse.visible = false;
				if (!ClientPrefs.cutsceneYouSaw.contains(cutsceneName)) {
					ClientPrefs.cutsceneYouSaw.push(cutsceneName);
					ClientPrefs.saveSettings();
				}
				new FlxTimer().start(WaitTime, function(WaitTimer:FlxTimer) {
					var Cutscene:MP4Handler = new MP4Handler();
					Cutscene.playVideo(Paths.video(MP4FileName), false, false, cutsceneName);
					Cutscene.finishCallback = function() {	
						switch (songToPlay) {
							case 'none':
								switch(EndState) {
									case 'Main': MusicBeatState.switchState(new MainMenuState());
									case 'Encore': MusicBeatState.switchState(new EncoreState());
									case 'Freeplay': MusicBeatState.switchState(new FreeplayState());
									case 'Extras': MusicBeatState.switchState(new extras.ExtraSongsState());
									case 'Story': MusicBeatState.switchState(new StoryMenuState());
									case 'Title': MusicBeatState.switchState(new TitleState());
								}
							default:
								PlayState.isStory = false;
								PlayState.isEncore = false;
								PlayState.isExtras = false;
								PlayState.isSound = false;
								PlayState.isFreeplay = false;
								switch(EndState) {
									case 'Main':
									case 'Encore': PlayState.isEncore = true;
									case 'Freeplay': PlayState.isFreeplay = true;
									case 'Extras': PlayState.isExtras = true;
									case 'Story': PlayState.isStory = true;
								}
								switch(EndState) {
									case 'Encore': PlayState.SONG = Song.loadFromJson(songToPlay, songToPlay);
									default: PlayState.SONG = Song.loadFromJson(songToPlay+'-hard', songToPlay);
								}
								PlayState.storyDifficulty = 1;
								FlxTransitionableState.skipNextTransIn = true;
								FlxTransitionableState.skipNextTransOut = true;
								new FlxTimer().start(0.1, function(PlayStateTimer:FlxTimer)
								{
									Main.InPlaystate = true;
									LoadingState.loadAndSwitchState(new PlayState());
								});		
						}
					}
				});
		}
		super.create();
	}
	
	function PlayCutscene(Name:String)
	{
		switch(Name) {
			case 'Haxe':
				if (ClientPrefs.firstLaunchMenusWas.contains('pre-launch-settings') && ClientPrefs.firstLaunchMenusWas.contains('sonic-disclaimer')) {
					ClientPrefs.StartVideo = true;
					ClientPrefs.saveSettings();
					new FlxTimer().start(0.3, function(tmr:FlxTimer)
					{	
						var video:MP4Handler = new MP4Handler();
						video.playVideo(Paths.video('HaxeFlixelIntro'));
						video.finishCallback = function()
						{	
							PlayCutscene('SEGA');
						}
					});
				} else {
					MusicBeatState.switchState(new PreLaunchSettingsState());
				}
			case 'STCodes':
				#if desktop
				DiscordClient.STCutscene();
				#end
				if (!ClientPrefs.UnlockedGalleryVideos.contains('st-codes')) {
					ClientPrefs.UnlockedGalleryVideos.push('st-codes');
					ClientPrefs.saveSettings();
				}
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				new FlxTimer().start(0.3, function(tmr:FlxTimer)
				{	
					ClientPrefs.vineboom = true;
					ClientPrefs.saveSettings();
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('sound-test-codes'));
					video.finishCallback = function()
					{	
						MusicBeatState.switchState(new StoryMenuState());
					}
				});
			case 'FECrash':
				#if desktop
				DiscordClient.FinalCrash();
				#end
				if (!ClientPrefs.UnlockedGalleryVideos.contains('tt-final')) {
					ClientPrefs.UnlockedGalleryVideos.push('tt-final');
					ClientPrefs.saveSettings();
				}
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				new FlxTimer().start(0.3, function(tmr:FlxTimer)
				{	
					ClientPrefs.vineboom = true;
					ClientPrefs.saveSettings();
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('tt-final'));
					video.finishCallback = function() {	
						#if desktop
						Sys.command('${Sys.getCwd()}\\assets\\exe\\open-cw.bat', ['${Sys.getCwd()}\\assets\\exe\\', 'epicjump.png']);
						#end
						Sys.exit(0);
					}
				});
			case 'SEGA':
				#if desktop
				DiscordClient.SonicIntro();
				#end
				if (ClientPrefs.storyProgressExe == 3) {
					if (!ClientPrefs.UnlockedGalleryVideos.contains('fe-intro')) {
						ClientPrefs.UnlockedGalleryVideos.push('fe-intro');
						ClientPrefs.saveSettings();
					}
				}
				new FlxTimer().start(0.3, function(tmr:FlxTimer)
				{	
					if (ClientPrefs.storyProgressExe == 3) {
						var video:MP4Handler = new MP4Handler();
						video.playVideo(Paths.video('sonicexe-intro-fe'));
						video.finishCallback = function()
						{	
							Main.PEEPEEPOOPOOCHECK = false;
							MusicBeatState.switchState(new Cutscenes('FEStory'));
							ClientPrefs.daGameCrashed = false;
							ClientPrefs.saveSettings();
						}
					} else {
						var video:MP4Handler = new MP4Handler();
						video.playVideo(Paths.video('sonicexe-intro'));
						Main.PEEPEEPOOPOOCHECK = false;
						FlxG.mouse.visible = false;
						video.finishCallback = function()
						{	
							MusicBeatState.switchState(new TitleState());
						}
					}
				});
		}
	}
	
	override function update(elapsed:Float)
	{
		switch(cutsceneName) {
			case 'Haxe':
				FlxG.sound.muteKeys = Cutscenes.muteKeys;
				FlxG.sound.volumeDownKeys = Cutscenes.volumeDownKeys;
				FlxG.sound.volumeUpKeys = Cutscenes.volumeUpKeys;
			case 'FEStory':
				if (FlxG.sound.music != null)
					Conductor.songPosition = FlxG.sound.music.time;
				super.update(elapsed);
		}
	}
	
	function centerTalkText(text:String, color:FlxColor, time:Float, speechSpeed:Float, ?voiceFile:String = '', ?voiceFileLib:String = 'preload') {
		new FlxTimer().start(time, function(startTalk:FlxTimer) {
			var centerTalk:FlxText = new FlxText(0, 0, FlxG.width, '');
			centerTalk.setFormat(Paths.font('sonic-cd-menu-font.ttf'), 40, color, CENTER);
			centerTalk.scrollFactor.set();
			centerTalk.screenCenter();
			add(centerTalk);
			if (voiceFile != '') FlxG.sound.play(Paths.sound(voiceFile, voiceFileLib), 0.7);
			var SplitMoment:Array<String> = text.split('|');
			var talkin:Float = 0;
			for (i in 0...SplitMoment.length) {
				new FlxTimer().start(talkin, function(talks:FlxTimer) {
					centerTalk.text = centerTalk.text + SplitMoment[i];
				});
				if (i == SplitMoment.length-1) {
					new FlxTimer().start(1+talkin, function(talkEnd:FlxTimer) {
						centerTalk.destroy();
					});
				}
				talkin += speechSpeed;
			}
		});
	}
	
	function cmdTextInput(who:String, text:String, color:FlxColor, time:Float, ?bold:Bool = false, ?italic:Bool = false, ?markerColor:FlxColor = 0xFFFFFFFF) {
		var colorM = new FlxTextFormatMarkerPair(new FlxTextFormat(markerColor), "!");
		var author:String = '';
		var cmdFont:String;
		if (who == 'Text') author = '';
		if (who == 'User') author = 'C:\\Users\\' + Main.PCuserName + '>';
		if (who == 'Sys') author = 'C:\\Windows\\System32>';
		if (who == 'Def') author = 'C:\\Program Files\\Windows Defender>';
		if (who == 'Fatal') author = 'C:\\Fatal Error>';
		if (bold) cmdFont = 'cmd/consolas-bold.ttf';
		if (italic) cmdFont = 'cmd/consolas-italic.ttf';
		if (bold && italic) cmdFont = 'cmd/consolas-italic-bold.ttf';
		if (!bold && !italic) cmdFont = 'cmd/consolas.ttf';
		new FlxTimer().start(time, function(cmd:FlxTimer) {
			var cmdtext:FlxText = new FlxText(0, cmdY, FlxG.width, '');
			cmdtext.setFormat(Paths.font(cmdFont), 16, color, LEFT);
			cmdtext.scrollFactor.set();
			textCMD.add(cmdtext);
			if (who == 'Loading') {
				var qwerty:Int = 0;
				var loadDots:String = '';
				var TextYe:String = text;
				for (i in 0...2) {
					new FlxTimer().start(1 + qwerty, function(t1:FlxTimer) {
						cmdtext.text = TextYe + '.';
						cmdtext.applyMarkup(cmdtext.text, [colorM]);
					});
					new FlxTimer().start(2 + qwerty, function(t2:FlxTimer) {
						cmdtext.text = TextYe + '..';
						cmdtext.applyMarkup(cmdtext.text, [colorM]);
					});
					new FlxTimer().start(3 + qwerty, function(t3:FlxTimer) {
						cmdtext.text = TextYe + '...';
						cmdtext.applyMarkup(cmdtext.text, [colorM]);
					});
					new FlxTimer().start(4 + qwerty, function(t4:FlxTimer) {
						cmdtext.text = TextYe;
						cmdtext.applyMarkup(cmdtext.text, [colorM]);
					});
					if (i == 1) {
						new FlxTimer().start(5 + qwerty, function(t5:FlxTimer) {
							cmdtext.destroy();
							trace(5);
						});
					}
					qwerty += 4;
				}
			} else {
				cmdtext.applyMarkup(author + text, [colorM]);
				cmdY += 18;
			}
		});
	}
}