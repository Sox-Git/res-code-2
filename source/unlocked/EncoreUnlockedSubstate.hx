package unlocked;

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

class EncoreUnlockedSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var Window:FlxSprite;
	var Art:FlxSprite;
	var Frame:FlxSprite;
	var Song:FlxSprite;
	var Play:FlxSprite;
	var Ok:FlxSprite;
	var win:FlxTypedGroup<FlxSprite>;
	var PlayB:Bool = false;
	var shit:String = ClientPrefs.SongsCompletedRN[0];
	var CanControl:Bool = true;
	public static var EncoreSongSel:Int = 0;
	public function new()
	{
		super();
		
		#if desktop
		var rpcName:String = 'In Main Menu (Encore Song Unlocked)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'unlocked-encore';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		win = new FlxTypedGroup<FlxSprite>();
		FlxG.sound.play(Paths.sound('unlocked'));
		
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);
		
		Window = new FlxSprite(0, 0).loadGraphic(Paths.image('unlock/encore/window'));
		Window.antialiasing = ClientPrefs.globalAntialiasing;
		Window.alpha = 0;
		Window.scrollFactor.set();
		win.add(Window);
		
		Art = new FlxSprite(0, 0).loadGraphic(Paths.image('unlock/encore/songs-art/' + shit));
		Art.antialiasing = ClientPrefs.globalAntialiasing;
		Art.alpha = 0;
		Art.scrollFactor.set();
		win.add(Art);
		
		Frame = new FlxSprite(0, 0).loadGraphic(Paths.image('unlock/encore/frame'));
		Frame.antialiasing = ClientPrefs.globalAntialiasing;
		Frame.alpha = 0;
		Frame.scrollFactor.set();
		win.add(Frame);
		
		Song = new FlxSprite(0, 0).loadGraphic(Paths.image('unlock/encore/songs/' + shit));
		Song.antialiasing = ClientPrefs.globalAntialiasing;
		Song.alpha = 0;
		Song.scrollFactor.set();
		win.add(Song);
		
		Play = new FlxSprite(896, 530).loadGraphic(Paths.image('unlock/encore/play'));
		Play.antialiasing = ClientPrefs.globalAntialiasing;
		Play.alpha = 0;
		Play.scrollFactor.set();
		win.add(Play);
		
		Ok = new FlxSprite(226, 530).loadGraphic(Paths.image('unlock/encore/ok'));
		Ok.antialiasing = ClientPrefs.globalAntialiasing;
		Ok.alpha = 0;
		Ok.scrollFactor.set();
		win.add(Ok);
		
		add(win);
		
		FlxTween.tween(bg, {alpha: 0.7}, 0.25);
		win.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 1}, 0.25); FlxTween.tween(ok.scale, {x:1, y:1}, 0.25, { ease: FlxEase.quadInOut}); });
		
		if (!PlayB) {
			Play.color = 0xFF1E1E1E;
			Ok.color = 0xFFFFFFFF;
		} else {
			Play.color = 0xFFFFFFFF;
			Ok.color = 0xFF1E1E1E;
		}
		if (!ClientPrefs.SongsCompleted.contains(shit)) {
			ClientPrefs.SongsCompleted.push(shit);
		}
		#if mobile
		addVirtualPad(LEFT_RIGHT, A_B);
		addVirtualPadCamera();
		#end
	}
	
	function OkF() {
		CanControl = false;
		FlxG.sound.play(Paths.sound('unlocked-ok'));
		FlxTween.tween(bg, {alpha: 0}, 0.25);
		win.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 0}, 0.25); FlxTween.tween(ok.scale, {x:0.7, y:0.7}, 0.25, { ease: FlxEase.quadInOut}); });
		#if desktop
		var rpcName:String = 'In Main Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'icon';
		DiscordClient.changePresence(rpcName, null);
		#end
	
		new FlxTimer().start(0.6, function(tmr:FlxTimer) {
			MainMenuState.instance.lockedControl = false;
			MainMenuState.instance.selectedSomethin = false;
			MainMenuState.instance.lockMouseSelection = false;
			ClientPrefs.SongsCompletedRN.remove(shit);
			ClientPrefs.saveSettings();
			close();
		});
	}
	
	function PlayF() {
		CanControl = false;
		FlxG.sound.play(Paths.sound('unlocked-apply'));
		FlxTransitionableState.skipNextTransIn = true;
		FlxTween.tween(bg, {alpha: 1}, 0.5);
		win.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 0}, 0.25); FlxTween.tween(ok.scale, {x:0.7, y:0.7}, 0.25, { ease: FlxEase.quadInOut}); });
	
		new FlxTimer().start(0.6, function(tmr:FlxTimer) {
			MainMenuState.instance.blackScreen.alpha = 1;
			MainMenuState.instance.lockedControl = false;
			MainMenuState.instance.selectedSomethin = false;
			MainMenuState.instance.lockMouseSelection = true;
			switch(shit) {
				case 'endless':
					EncoreSongSel = 3;
				case 'cycles':
					EncoreSongSel = 4;
				case 'sunshine':
					EncoreSongSel = 5;
				case 'chaos':
					EncoreSongSel = 6;
				case 'faker':
					EncoreSongSel = 7;
				case 'fatality':
					EncoreSongSel = 8;
				case 'round-a-bout':
					EncoreSongSel = 9;
				case 'her-world':
					EncoreSongSel = 10;
				case 'hollow':
					EncoreSongSel = 11;
				case 'color-blind':
					EncoreSongSel = 12;
			}
			ClientPrefs.SongsCompletedRN.remove(shit);
			ClientPrefs.saveSettings();
			MusicBeatState.switchState(new EncoreState());
		});
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (CanControl) {
			if ((controls.UI_RIGHT_P #if desktop || FlxG.mouse.overlaps(Play) #end) && !PlayB) PlayB = true;
			if ((controls.UI_LEFT_P #if desktop || FlxG.mouse.overlaps(Ok) #end) && PlayB) PlayB = false;
			if ((controls.BACK || controls.ACCEPT #if desktop || (FlxG.mouse.overlaps(Ok) && FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle) #end && !PlayB) || #if mobile FlxG.android.justReleased.BACK #else FlxG.mouse.justPressedRight #end) OkF();
			if ((controls.ACCEPT #if desktop || (FlxG.mouse.overlaps(Play) && FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle) #end) && PlayB) PlayF();
		}
		
		if (!PlayB) {
			Play.color = 0xFF1E1E1E;
			Ok.color = 0xFFFFFFFF;
		} else {
			Play.color = 0xFFFFFFFF;
			Ok.color = 0xFF1E1E1E;
		}
	}
}
