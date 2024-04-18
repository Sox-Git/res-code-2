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

class TrophyUnlockedSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var Window:FlxSprite;
	var Char:FlxSprite;
	var Apply:FlxSprite;
	var Ok:FlxSprite;
	var win:FlxTypedGroup<FlxSprite>;
	var ApplyB:Bool = false;
	var shit:String = ClientPrefs.TrophiesUnlockedRN[0];
	var CanControl:Bool = true;
	public function new()
	{
		super();
		
		#if desktop
		var rpcName:String = 'In Main Menu (Trophy Unlocked)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'unlocked-trophy';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		win = new FlxTypedGroup<FlxSprite>();
		FlxG.sound.play(Paths.sound('unlocked'));
		
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);
		
		Window = new FlxSprite(0, 0).loadGraphic(Paths.image('unlock/trophies/window'));
		Window.antialiasing = ClientPrefs.globalAntialiasing;
		Window.alpha = 0;
		Window.scrollFactor.set();
		win.add(Window);
		
		Char = new FlxSprite(0, 0).loadGraphic(Paths.image('unlock/trophies/trophies/' + shit));
		Char.antialiasing = ClientPrefs.globalAntialiasing;
		Char.alpha = 0;
		Char.scrollFactor.set();
		win.add(Char);
		
		Apply = new FlxSprite(896, 520).loadGraphic(Paths.image('unlock/trophies/apply'));
		Apply.antialiasing = ClientPrefs.globalAntialiasing;
		Apply.alpha = 0;
		Apply.scrollFactor.set();
		win.add(Apply);
		
		Ok = new FlxSprite(226, 520).loadGraphic(Paths.image('unlock/trophies/ok'));
		Ok.antialiasing = ClientPrefs.globalAntialiasing;
		Ok.alpha = 0;
		Ok.scrollFactor.set();
		win.add(Ok);
		
		add(win);
		
		FlxTween.tween(bg, {alpha: 0.7}, 0.25);
		win.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 1}, 0.25); FlxTween.tween(ok.scale, {x:1, y:1}, 0.25, { ease: FlxEase.quadInOut}); });
		
		if (!ApplyB) {
			Apply.color = 0xFF1E1E1E;
			Ok.color = 0xFFFFFFFF;
		} else {
			Apply.color = 0xFFFFFFFF;
			Ok.color = 0xFF1E1E1E;
		}
		if (!ClientPrefs.TrophiesUnlocked.contains(shit)) {
			ClientPrefs.TrophiesUnlocked.push(shit);
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
			ClientPrefs.TrophiesUnlockedRN.remove(shit);
			ClientPrefs.saveSettings();
			close();
		});
	}
	
	function ApplyF() {
		CanControl = false;
		FlxG.sound.play(Paths.sound('unlocked-apply'));
		FlxTween.tween(bg, {alpha: 0}, 0.25);
		win.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 0}, 0.25); FlxTween.tween(ok.scale, {x:0.7, y:0.7}, 0.25, { ease: FlxEase.quadInOut}); });
	
		new FlxTimer().start(0.3, function(tmr:FlxTimer) {
			MainMenuState.instance.lockedControl = false;
			MainMenuState.instance.selectedSomethin = false;
			MainMenuState.instance.openTrophyMenu = true;
			MainMenuState.instance.lockMouseSelection = true;
			close();
			ClientPrefs.TrophiesUnlockedRN.remove(shit);
			ClientPrefs.saveSettings();
		});
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (CanControl) {
			if ((controls.UI_RIGHT_P #if desktop || FlxG.mouse.overlaps(Apply) #end) && !ApplyB) ApplyB = true;
			if ((controls.UI_LEFT_P #if desktop || FlxG.mouse.overlaps(Ok) #end) && ApplyB) ApplyB = false;
			if ((controls.BACK || controls.ACCEPT #if desktop || (FlxG.mouse.overlaps(Ok) && FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle) #end && !ApplyB) || #if mobile FlxG.android.justReleased.BACK #else FlxG.mouse.justPressedRight #end) OkF();
			if ((controls.ACCEPT #if desktop || (FlxG.mouse.overlaps(Apply) && FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle) #end) && ApplyB) ApplyF();
		}
		
		if (!ApplyB) {
			Apply.color = 0xFF1E1E1E;
			Ok.color = 0xFFFFFFFF;
		} else {
			Apply.color = 0xFFFFFFFF;
			Ok.color = 0xFF1E1E1E;
		}
	}
}
