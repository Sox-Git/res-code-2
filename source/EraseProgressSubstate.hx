package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class EraseProgressSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var Window:FlxSprite;
	var Yes:FlxSprite;
	var No:FlxSprite;
	var blackScreen:FlxSprite;

	var EraseDate:Bool = false;
	public function new()
	{
		super();
		
		#if desktop
		var rpcName:String = "In Main Menu (Erase Progress)";
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'erase-progress';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.8;
		add(bg);
		
		Window = new FlxSprite(0, 0).loadGraphic(Paths.image('erase-progress/window'));
		Window.antialiasing = ClientPrefs.globalAntialiasing;
		Window.scrollFactor.set();
		add(Window);
		
		Yes = new FlxSprite(372, 358).loadGraphic(Paths.image('erase-progress/yes'));
		Yes.antialiasing = ClientPrefs.globalAntialiasing;
		Yes.scrollFactor.set();
		add(Yes);
		
		No = new FlxSprite(662, 358).loadGraphic(Paths.image('erase-progress/no'));
		No.antialiasing = ClientPrefs.globalAntialiasing;
		No.scrollFactor.set();
		add(No);
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.alpha = 0;
		add(blackScreen);
		
		if (!EraseDate) {
			Yes.color = 0xFF1E1E1E;
			No.color = 0xFFFFFFFF;
		} else {
			Yes.color = 0xFFFFFFFF;
			No.color = 0xFF1E1E1E;
		}
		#if mobile
		addVirtualPad(LEFT_RIGHT, A_B);
		#end
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if ((controls.UI_RIGHT_P #if desktop || FlxG.mouse.overlaps(No) #end) && EraseDate) EraseDate = false;

		if ((controls.UI_LEFT_P #if desktop || FlxG.mouse.overlaps(Yes) #end) && !EraseDate) EraseDate = true;
		
		if (controls.BACK || (controls.ACCEPT && !EraseDate) || #if desktop (FlxG.mouse.overlaps(No) && FlxG.mouse.justReleased) || FlxG.mouse.justPressedRight #else FlxG.android.justReleased.BACK #end) {
			new FlxTimer().start(0.02, function(tmr:FlxTimer) {
				MainMenuState.instance.lockedControl = false;
				MainMenuState.instance.selectedSomethin = false;
				MainMenuState.instance.lockMouseSelection = false;
				#if desktop
				var rpcName:String = "In Main Menu";
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.imageRpc = 'icon';
				DiscordClient.changePresence(rpcName, null);
				#end
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
				#if desktop
				close();
				#else
				FlxG.resetState();
				#end
			});
		}
		
		if ((controls.ACCEPT && EraseDate) #if desktop || (FlxG.mouse.overlaps(Yes) && FlxG.mouse.justReleased) #end) {
			new FlxTimer().start(0.02, function(tmr:FlxTimer) {
				#if desktop
				var rpcName:String = "In Main Menu (Erase Progress)";
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.imageRpc = 'erase-yes';
				DiscordClient.changePresence(rpcName, null);
				#end
				Reset();
			});
		}
		
		if (!EraseDate) {
			Yes.color = 0xFF1E1E1E;
			No.color = 0xFFFFFFFF;
		} else {
			Yes.color = 0xFFFFFFFF;
			No.color = 0xFF1E1E1E;
		}
	}
	
	function EraseProgress()
	{
		ClientPrefs.SoundTestUnlocked = false;
		ClientPrefs.EncoreUnlocked = false;
		
		ClientPrefs.storyProgressExe = 0;
		ClientPrefs.storyProgressAlt = 0;
		ClientPrefs.ShowExtrasCode = false;
		ClientPrefs.ExtrasMathSolved = false;
		ClientPrefs.BFEncoreSkin = 0;
		ClientPrefs.GFEncoreSkin = 0;
		ClientPrefs.BFSkin = 0;
		ClientPrefs.GFSkin = 0;
		ClientPrefs.TrophieSelected = 0;
		ClientPrefs.SelectedMouse = 0;
		ClientPrefs.MainMenuFPSBarX = 0;
		ClientPrefs.StartVideoSaw = false;
		ClientPrefs.GalleryCanSkip = false;
		ClientPrefs.vineboom = false;
		ClientPrefs.daGameCrashed = false;
		ClientPrefs.animatedMouse = false;
		Main.PEEPEEPOOPOOCHECK = true;
		Main.DisableCustomCursor = false;
		Main.InPlaystate = false;
		ClientPrefs.lastMenuArt = '';
		ClientPrefs.youSawSoundTestCutscene = false;
		
		ClientPrefs.gameplaySettings.set("botplay", false);
		ClientPrefs.gameplaySettings.set("practice", false);
			
		ClientPrefs.TrophiesUnlocked = []; 
		ClientPrefs.TrophiesUnlockedRN = []; 
		ClientPrefs.charactersUnlocked = []; 
		ClientPrefs.SongsCompletedRN = []; 
		ClientPrefs.SongsCompleted = []; 
		ClientPrefs.SkinsUnlockedRN = [];
		ClientPrefs.SkinsUnlocked = [];
		ClientPrefs.UnlockedEndings = [];
		ClientPrefs.UnlockedGalleryVideos = [];
		ClientPrefs.UnlockedMenuArts = ['xeno-1'];
		ClientPrefs.UnlockedMouses = ['exe-cursor'];
		ClientPrefs.firstLaunchMenusWas = [];
		ClientPrefs.cutsceneYouSaw = [];
		ClientPrefs.showCutscene = ['you-cant-run-encore', 'fatality-encore', 'ugly', 'soulless', 'fight-or-flight', 'critical-error'];
		
		ClientPrefs.arrowsSkinNum = 0;
		ClientPrefs.arrowsSplashNum = 0;
		ClientPrefs.arrowsColorNumLeft = 0;
		ClientPrefs.arrowsColorNumDown = 0;
		ClientPrefs.arrowsColorNumUp = 0;
		ClientPrefs.arrowsColorNumRight = 0;
		ClientPrefs.arrowSkin = 'NOTE_assets';
		ClientPrefs.arrowSplash = 'noteSplashes';
		ClientPrefs.arrowHSV = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
		ClientPrefs.arrowColorsRGB = false;
		ClientPrefs.boughtSkin = [];
		ClientPrefs.boughtSplash = [];
		ClientPrefs.boughtColor = [];
		ClientPrefs.earnedRings = [];
		ClientPrefs.RingsAmount = 0;
		
		FreeplayState.curSelected = 0;
		MainMenuState.curSelected = 0;
		Highscore.weekScores = ["crashfix" => 0];
		Highscore.songScores = ["crashfix" => 0];
		Highscore.songRating = ["crashfix" => 0];
		FlxG.save.data.weekScores = ["crashfix" => 0];
		FlxG.save.data.songScores = ["crashfix" => 0];
		FlxG.save.data.songRating = ["crashfix" => 0];
		
		ClientPrefs.saveSettings();
	}
	
	function Reset()
	{
		FlxTransitionableState.skipNextTransIn = true;
		FlxTween.tween(blackScreen, {alpha: 1}, 2, {});
		FlxG.sound.music.fadeOut(2, 0);
		new FlxTimer().start(2.05, function(tmr:FlxTimer) {
			MainMenuState.instance.blackScreen.alpha = 1;
			#if desktop
			close();
			#else
			FlxG.resetState();
			#end
			EraseProgress();
			MusicBeatState.switchState(new Cutscenes());
		});
	}
}
