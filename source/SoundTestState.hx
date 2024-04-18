package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop; 
#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end
#if windows
import Discord.DiscordClient;
#end

class SoundTestState extends MusicBeatState
{
	var woahmanstopspammin:Bool = true;

	var whiteshit:FlxSprite;
	var bg:FlxBackdrop;

	var daValue:Int = 0;
	var pcmValue:Int = 0;

	var soundCooldown:Bool = true;

	var funnymonke:Bool = true;

	var incameo:Bool = false;

	var cameoBg:FlxSprite;
	var cameoImg:FlxSprite;
	var cameoThanks:FlxSprite;

	var pcmNO:FlxText;
	var daNO:FlxText;

	var pcmNO_NUMBER:FlxText;
	var daNO_NUMBER:FlxText;
	
	private var camGame:FlxCamera;
	var cheats:Bool = (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false));

	var GoreContent:Bool = false;
	var GoreWarningMenu:Bool = false;
	public static var goreCloseShit:Bool = false;
    override function create()
        {
			Paths.clearUnusedMemory();
			persistentUpdate = persistentDraw = true;
			goreCloseShit = false;
			#if desktop
			var rpcName:String = 'In Sound Test Menu';
			if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
				rpcName = TranslationLanguages.Text[rpcName];
			DiscordClient.imageRpc = 'sound-test';
			DiscordClient.smallImageRpc = '';
			DiscordClient.changePresence(rpcName, null);
			#end	
			PlayState.storyPlaylist = [];
			
			FlxTransitionableState.skipNextTransIn = false;
			openSubState(new SonicTransition(1.0, true));
				
			camGame = new FlxCamera();
			FlxG.cameras.reset(camGame);
			FlxCamera.defaultCameras = [camGame];

			new FlxTimer().start(0.1, function(tmr:FlxTimer) {
				FlxG.sound.playMusic(Paths.music('breakfast', 'shared'));
			});
		
			whiteshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
			whiteshit.alpha = 0;

			PlayState.isStory = false;
			PlayState.isEncore = false;
			PlayState.isExtras = false;
			PlayState.isSound = true;
			PlayState.isFreeplay = false;
			
			PlayState.BFEncoreSkins = false;
			PlayState.BFSkins = false;
			PlayState.GFEncoreSkins = false;
			PlayState.GFSkins = false;
			
			PlayState.ChaosCutscene = true;
			PlayState.showSTCutscene = true;

			cameoBg = new FlxSprite();
			cameoImg = new FlxSprite();
			cameoThanks = new FlxSprite();

			FlxG.sound.music.stop();

			bg = new FlxBackdrop(Paths.image('backgroundST'), 0, 0, false, true);
			bg.antialiasing = ClientPrefs.globalAntialiasing;
			bg.screenCenter();
			add(bg);

			var soundtesttext = new FlxText(0, 0, 0, 'SOUND TEST', 35);
			soundtesttext.screenCenter();
			soundtesttext.y -= 160;
			soundtesttext.x -= 46;
			soundtesttext.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, FlxColor.fromRGB(0, 163, 255));
			soundtesttext.setBorderStyle(SHADOW, FlxColor.BLACK, 4, 1);
			add(soundtesttext);
			if (TranslationLanguages.Text.exists(soundtesttext.text) && ClientPrefs.Language != 'English')
				soundtesttext.text = TranslationLanguages.Text[soundtesttext.text];
			
			pcmNO = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, 'PCM  NO .', 25);
			pcmNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(174, 179, 251));
			pcmNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			pcmNO.x += 50;
			add(pcmNO);
			
			daNO = new FlxText(768, FlxG.height / 2, 0, 'DA  NO .', 25);
			daNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(174, 179, 251));
			daNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			add(daNO);
			
			pcmNO_NUMBER = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, '0', 25);
			pcmNO_NUMBER.x += 350;
			pcmNO_NUMBER.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(174, 179, 251));
			pcmNO_NUMBER.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			add(pcmNO_NUMBER);
			
			daNO_NUMBER = new FlxText(FlxG.width / 6, FlxG.height / 2, 0, '0', 25);
			daNO_NUMBER.x += daNO.x + 45;
			daNO_NUMBER.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(174, 179, 251));
			daNO_NUMBER.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			add(daNO_NUMBER);
			
			pcmNO.x -= 15;
			pcmNO_NUMBER.x -= 126;
			daNO_NUMBER.x -= 100;

			cameoBg.visible = false;
			add(cameoBg);

			cameoThanks.visible = false;
			add(cameoThanks);

			cameoImg.visible = false;
			add(cameoImg);

			add(whiteshit);
			
			#if mobile
			addVirtualPad(LEFT_FULL, A_B);
			#end
        }

	function changeNumber(selection:Int) 
	{
		if (funnymonke)
		{
			pcmValue += selection;
			if (pcmValue < 0) pcmValue = 99;
			if (pcmValue > 99) pcmValue = 0;
		}
		else
		{
			daValue += selection;
			if (daValue < 0) daValue = 99;
			if (daValue > 99) daValue = 0;
		}
	}

	function flashyWashy(a:Bool)
	{
		if (a == true)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
			FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
		} else {
			FlxTween.color(whiteshit, 0.1, FlxColor.WHITE, FlxColor.BLUE);
			FlxTween.tween(whiteshit, {alpha: 0}, 0.2);
		}
	}

	function doTheThing(first:Int, second:Int) 
	{
		FlxTransitionableState.skipNextTransIn = true;
		if (first == 3 && second == 11)
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('oxxynless' + '-hard', 'oxxynless');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 20; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 12 && second == 25) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['endless', 'endeavors'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 2;
				PlayState.campaignScore = 0;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('majin') && !cheats) {
					ClientPrefs.charactersUnlocked.push('majin');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 7 && second == 7) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['cycles', 'hellbent', 'fate'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 3;
				PlayState.campaignScore = 0;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
				if (!ClientPrefs.charactersUnlocked.contains('lord x') && !cheats) {
					ClientPrefs.charactersUnlocked.push('lord x');
					ClientPrefs.saveSettings();
				}
			}
		else if (first == 18 && second == 21) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['melting', 'confronting'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 45;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('melthog') && !cheats) {
					ClientPrefs.charactersUnlocked.push('melthog');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 66 && second == 6) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['sunshine', 'soulless'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 4;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('tails doll') && !cheats) {
					ClientPrefs.charactersUnlocked.push('tails doll');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 8 && second == 21) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['chaos', 'running wild'/*, 'heroes and villains'*/];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 5;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('fleetway') && !cheats) {
					ClientPrefs.charactersUnlocked.push('fleetway');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 31 && second == 13) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['faker', 'black sun', 'godspeed'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 6;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('faker') && !cheats) {
					ClientPrefs.charactersUnlocked.push('faker');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 0 && second == 0) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('too fest' + '-hard', 'too fest');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 21; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sanic') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sanic');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 25 && second == 12) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['missiletoe', 'slaybells', 'jingle hells'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 7;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('christmas') && !cheats) {
					ClientPrefs.charactersUnlocked.push('christmas');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 0 && second == 50) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['fatality', 'critical error'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 22;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('fatal error') && !cheats) {
					ClientPrefs.charactersUnlocked.push('fatal error');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 23 && second == 2) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['prey', 'fight or flight'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 8;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('furnace') && !cheats) {
					ClientPrefs.charactersUnlocked.push('furnace');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 16 && second == 10) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['relax', 'round a bout', 'spike trap'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 9;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('needlemouse') && !cheats) {
					ClientPrefs.charactersUnlocked.push('needlemouse');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 20 && second == 8) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['her world'];
				PlayState.SONG = Song.loadFromJson('her world' + '-hard', 'her world');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 23; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('luther') && !cheats) {
					ClientPrefs.charactersUnlocked.push('luther');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 5 && second == 23) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('personel' + '-hard', 'personel');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 24; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('coldsteel') && !cheats) {
					ClientPrefs.charactersUnlocked.push('coldsteel');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 0 && second == 25) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['digitalized', 'substantial'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 10;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('xterion') && !cheats) {
					ClientPrefs.charactersUnlocked.push('xterion');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 5 && second == 12) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['hollow', 'empty'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2; 
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 25; 
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('devoid') && !cheats) {
					ClientPrefs.charactersUnlocked.push('devoid');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 1 && second == 11) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('my horizon' + '-hard', 'my horizon');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 26; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('chaotix') && !cheats) {
					ClientPrefs.charactersUnlocked.push('chaotix');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 50 && second == 50) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['hedge', 'manual blast'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 11;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('hog') && !cheats) {
					ClientPrefs.charactersUnlocked.push('hog');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 9 && second == 19) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['malediction', "'choice-of-ending'"];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 12;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('curse') && !cheats) {
					ClientPrefs.charactersUnlocked.push('curse');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 66 && second == 99) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['perdition', 'underworld'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 13;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('satanos') && !cheats) {
					ClientPrefs.charactersUnlocked.push('satanos');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 99 && second == 99) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['genesis', 'corinthians'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 14;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('apollyon') && !cheats) {
					ClientPrefs.charactersUnlocked.push('apollyon');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 30 && second == 17) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('burning' + '-hard', 'burning');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 15; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('shp and genesys') && !cheats) {
					ClientPrefs.charactersUnlocked.push('shp and genesys');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 6 && second == 4) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('forestall desire' + '-hard', 'forestall desire');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 18; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('requital') && !cheats) {
					ClientPrefs.charactersUnlocked.push('requital');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 20 && second == 5) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('b4cksl4sh' + '-hard', 'b4cksl4sh');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 27; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sl4sh') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sl4sh');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 80 && second == 80) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('color blind' + '-hard', 'color blind');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 28; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('mono.bw') && !cheats) {
					ClientPrefs.charactersUnlocked.push('mono.bw');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 16 && second == 24) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('miasma' + '-hard', 'miasma');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 29; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('dsk') && !cheats) {
					ClientPrefs.charactersUnlocked.push('dsk');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 19 && second == 96) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('expulsion' + '-hard', 'expulsion');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 30; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('educator') && !cheats) {
					ClientPrefs.charactersUnlocked.push('educator');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		/*
		else if (first == 19 && second == 93) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('agony' + '-hard', 'agony');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 31; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sally alt') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sally alt');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		*/
		else if (first == 90 && second == 19) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['universal-collapse', 'planestrider'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 32;
				PlayState.campaignScore = 0;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('omw') && !cheats) {
					ClientPrefs.charactersUnlocked.push('omw');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 4 && second == 11) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['life-and-death', 'gods-will'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 33;
				PlayState.campaignScore = 0;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('bratwurst') && !cheats) {
					ClientPrefs.charactersUnlocked.push('bratwurst');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 9 && second == 11) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('fake baby' + '-hard', 'fake baby');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 34; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('nmi') && !cheats) {
					ClientPrefs.charactersUnlocked.push('nmi');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 2 && second == 24) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('mania' + '-hard', 'mania');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 35; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sh tails') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sh tails');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 13 && second == 12) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('frenzy' + '-hard', 'frenzy');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 47; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('lumpy sonic') && !cheats) {
					ClientPrefs.charactersUnlocked.push('lumpy sonic');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 39 && second == 19) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['call-of-justice', 'gotta-go'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 36;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('batman') && !cheats) {
					ClientPrefs.charactersUnlocked.push('batman');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 3 && second == 0) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['too-far', 'last-hope'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 37;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('gameover') && !cheats) {
					ClientPrefs.charactersUnlocked.push('gameover');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 88 && second == 19) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['shocker', 'extreme zap'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 16;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sonichu') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sonichu');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 24 && second == 3) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('soured' + '-hard', 'soured');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 38; 
				FlxTransitionableState.skipNextTransIn = true; 
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sonic.lmn') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sonic.lmn');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 69 && second == 69) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('milk' + '-hard', 'milk');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 39; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('sunky') && !cheats) {
					ClientPrefs.charactersUnlocked.push('sunky');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 42 && second == 75) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['insidious', 'haze', 'marauder'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 17;
				PlayState.campaignScore = 0;
				
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('demogri') && !cheats) {
					ClientPrefs.charactersUnlocked.push('demogri');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 11 && second == 27) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('envy' + '-hard', 'envy');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 40; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('grimeware') && !cheats) {
					ClientPrefs.charactersUnlocked.push('grimeware');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 30 && second == 19) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('ugly' + '-hard', 'ugly');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 41; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('ugly sonic') && !cheats) {
					ClientPrefs.charactersUnlocked.push('ugly sonic');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 12 && second == 8) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['animosity', 'reunion'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 42;  
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('futagami') && !cheats) {
					ClientPrefs.charactersUnlocked.push('futagami');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 96 && second == 96) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('old-ycr-slaps' + '-hard', 'old-ycr-slaps');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 43; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 26 && second == 17) 
			{
				woahmanstopspammin = false;
				PlayState.storyPlaylist = ['hellstorm', 'sharpy-showdown'];
				PlayState.isStoryMode = true;
				PlayState.isSound = true;
				PlayState.storyDifficulty = 2; 
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
				PlayState.storyWeek = 44;
				PlayState.campaignScore = 0;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('exetior') && !cheats) {
					ClientPrefs.charactersUnlocked.push('exetior');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 18 && second == 38) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('forever-unnamed' + '-hard', 'forever-unnamed');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 19; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('no name') && !cheats) {
					ClientPrefs.charactersUnlocked.push('no name');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 19 && second == 1) 
			{
				woahmanstopspammin = false;
				PlayState.SONG = Song.loadFromJson('found-you' + '-hard', 'found-you');
				PlayState.storyDifficulty = 2; 
				PlayState.storyWeek = 46; 
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if (!ClientPrefs.charactersUnlocked.contains('normal cd') && !cheats) {
					ClientPrefs.charactersUnlocked.push('normal cd');
					ClientPrefs.saveSettings();
				}
				if (!GoreContent) {
					FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.music.fadeOut(0.5, 0);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						Main.InPlaystate = true;
						LoadingState.loadAndSwitchState(new PlayState());
					});
				} else {
					openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'st', 'playstate'));
					GoreWarningMenu = true;
				}
			}
		else if (first == 41 && second == 1) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/Razencro'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					FlxG.sound.play(Paths.sound('cameostuff/Razencro'));	
					incameo = true;
				});
			}
		else if (first == 1 && second == 13) // This for you div, R.I.P
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/divide'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else if (first == 9 && second == 10)
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/Sunkeh'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else if (first == 6 && second == 6)
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					cameoImg.visible = true;
					cameoImg.loadGraphic(Paths.image('cameostuff/GamerX'));
					cameoImg.setSize(1280, 720);
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					incameo = true;
				});
			}
		else if (first == 23 && second == 23) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					if (!ClientPrefs.UnlockedGalleryVideos.contains('sound-test-3')) {
						ClientPrefs.UnlockedGalleryVideos.push('sound-test-3');
						ClientPrefs.saveSettings();
					}
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('SoundTest/BeOneWithRestored'));
					video.finishCallback = function()
					{
						LoadingState.loadAndSwitchState(new SoundTestState());
					}
				});
			}
		else if (first == 11 && second == 11) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					if (!ClientPrefs.UnlockedGalleryVideos.contains('sound-test-6')) {
						ClientPrefs.UnlockedGalleryVideos.push('sound-test-6');
						ClientPrefs.saveSettings();
					}
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('SoundTest/RestoredIsDead'));
					video.finishCallback = function()
					{
						LoadingState.loadAndSwitchState(new SoundTestState());
					}
				});
			}
		else if (first == 20 && second == 20) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					if (!ClientPrefs.UnlockedGalleryVideos.contains('sound-test-2')) {
						ClientPrefs.UnlockedGalleryVideos.push('sound-test-2');
						ClientPrefs.saveSettings();
					}
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('SoundTest/ArtFlex'));
					video.finishCallback = function()
					{
						LoadingState.loadAndSwitchState(new SoundTestState());
					}
				});
			}
		else if (first == 81 && second == 73) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					if (!ClientPrefs.UnlockedGalleryVideos.contains('sound-test-1')) {
						ClientPrefs.UnlockedGalleryVideos.push('sound-test-1');
						ClientPrefs.saveSettings();
					}
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('SoundTest/Musicians'));
					video.finishCallback = function()
					{
						LoadingState.loadAndSwitchState(new SoundTestState());
					}
				});
			}
		else if (first == 19 && second == 83) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					if (!ClientPrefs.UnlockedGalleryVideos.contains('sound-test-5')) {
						ClientPrefs.UnlockedGalleryVideos.push('sound-test-5');
						ClientPrefs.saveSettings();
					}
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('SoundTest/SpiderSonic'));
					video.finishCallback = function()
					{
						LoadingState.loadAndSwitchState(new SoundTestState());
					}
				});
			}
		else if (first == 12 && second == 34) 
			{
				woahmanstopspammin = false;
				flashyWashy(true);
				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					flashyWashy(false);
					FlxG.sound.music.stop();
	
				});
				new FlxTimer().start(2.1, function(tmr:FlxTimer)
				{
					if (!ClientPrefs.UnlockedGalleryVideos.contains('sound-test-4')) {
						ClientPrefs.UnlockedGalleryVideos.push('sound-test-4');
						ClientPrefs.saveSettings();
					}
					var video:MP4Handler = new MP4Handler();
					video.playVideo(Paths.video('SoundTest/GSBL'));
					video.finishCallback = function()
					{
						LoadingState.loadAndSwitchState(new SoundTestState());
					}
				});
			}
		else if (first == 32 && second == 8) 
		{
			woahmanstopspammin = false;
			flashyWashy(true);
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				cameoImg.visible = true;
				cameoImg.loadGraphic(Paths.image('cameostuff/Marstarbro'));
				cameoImg.setSize(1280, 720);
				flashyWashy(false);
				FlxG.sound.music.stop();

			});
			new FlxTimer().start(2.1, function(tmr:FlxTimer)
			{
				FlxG.sound.play(Paths.sound('cameostuff/Marstarbro'));
				incameo = true;
			});
		}
		else
		{
			if (soundCooldown)
			{
				soundCooldown = false;
				FlxG.sound.play(Paths.sound('deniedMOMENT'));
				new FlxTimer().start(0.8, function(tmr:FlxTimer)
				{
					soundCooldown = true;
				});
			}
        }
		if (first == 0 && second == 50) 
			Main.DisableCustomCursor = true;
		else
			Main.DisableCustomCursor = false;
	}
		
	var holdTime:Float = 0;
	override public function update(elapsed:Float)
		{
			bg.velocity.set(0, 50);
			if ((controls.UI_LEFT_P || controls.UI_RIGHT_P) #if desktop && !FlxG.mouse.overlaps(pcmNO) && !FlxG.mouse.overlaps(pcmNO_NUMBER) && !FlxG.mouse.overlaps(daNO) && !FlxG.mouse.overlaps(daNO_NUMBER) #end && woahmanstopspammin) funnymonke = !funnymonke;
			#if desktop
			if (FlxG.mouse.overlaps(pcmNO) || FlxG.mouse.overlaps(pcmNO_NUMBER)) funnymonke = true;
			if (FlxG.mouse.overlaps(daNO) || FlxG.mouse.overlaps(daNO_NUMBER)) funnymonke = false;
			#end

			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			
			if (!GoreWarningMenu) {
				if (woahmanstopspammin) {
					if (controls.UI_UP_P) {
						changeNumber(-shiftMult);
						holdTime = 0;
					}
					if (controls.UI_DOWN_P) {
						changeNumber(shiftMult);
						holdTime = 0;
					}
					if(controls.UI_DOWN || controls.UI_UP)
					{
						var checkLastHold:Int = Math.floor((holdTime - 0.5) * 15);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.5) * 15);

						if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						{
							changeNumber((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
						}
					}
					#if desktop
					if(FlxG.mouse.wheel != 0)
					{
						changeNumber(-shiftMult * FlxG.mouse.wheel);
						holdTime = 0;
					}
					#end
				}

				if ((controls.ACCEPT #if desktop || FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed #end) && woahmanstopspammin) doTheThing(pcmValue, daValue);
				if ((controls.ACCEPT #if desktop || FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed #end) && !woahmanstopspammin && incameo) LoadingState.loadAndSwitchState(new SoundTestState());
				if ((controls.BACK #if desktop || FlxG.mouse.justPressedRight #end) && woahmanstopspammin && !incameo) LoadingState.loadAndSwitchState(new MainMenuState());
			}

			if (funnymonke) {
				pcmNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(254, 174, 0));
				pcmNO.setBorderStyle(SHADOW, FlxColor.fromRGB(253, 36, 3), 4, 1);
		
				daNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(174, 179, 251));
				daNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
			} else {
				pcmNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(174, 179, 251));
				pcmNO.setBorderStyle(SHADOW, FlxColor.fromRGB(106, 110, 159), 4, 1);
		
				daNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 25, FlxColor.fromRGB(254, 174, 0));
				daNO.setBorderStyle(SHADOW, FlxColor.fromRGB(253, 36, 3), 4, 1);
				
			}
			
			if (pcmValue < 10)	pcmNO_NUMBER.text = '0' + Std.string(pcmValue);
			else pcmNO_NUMBER.text = Std.string(pcmValue);
			if (daValue < 10)	daNO_NUMBER.text = '0' + Std.string(daValue);
			else daNO_NUMBER.text = Std.string(daValue);
			
			if (goreCloseShit) {
				GoreWarningMenu = false;
				woahmanstopspammin = true;
				FlxTransitionableState.skipNextTransIn = false; 
				FlxTransitionableState.skipNextTransOut = false; 
				goreCloseShit = false;
			}
			
			if (!ClientPrefs.gore) {
				if (pcmValue == 18 && daValue == 21) GoreContent = true;
				else if (pcmValue == 31 && daValue == 13) GoreContent = true;
				else if (pcmValue == 23 && daValue == 2) GoreContent = true;
				else if (pcmValue == 0 && daValue == 25) GoreContent = true;
				else if (pcmValue == 50 && daValue == 50) GoreContent = true;
				else if (pcmValue == 66 && daValue == 6) GoreContent = true;
				else if (pcmValue == 3 && daValue == 0) GoreContent = true;
				else if (pcmValue == 11 && daValue == 27) GoreContent = true;
				else GoreContent = false;
			}
			
			
			super.update(elapsed);
		}
}