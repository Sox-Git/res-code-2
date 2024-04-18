package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxState;
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
import flixel.FlxCamera;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;

class SonicDisclaimerState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var PressEnterToContinue:FlxText;

	var canControl:Bool = false;
	var Main:FlxSprite;
	var Sonic:FlxSprite;
	var blackScreen:FlxSprite;

	override function create() {
		FlxG.mouse.visible = false;
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;

		Main = new FlxSprite(0, 0).loadGraphic(Paths.image('warnings/disclaimer/main'));
		Main.antialiasing = ClientPrefs.globalAntialiasing;
		Main.screenCenter();
		Main.scrollFactor.set();
		add(Main);
		
		Sonic = new FlxSprite(750, 300);
		Sonic.frames = Paths.getSparrowAtlas('warnings/disclaimer/sonic');
		Sonic.animation.addByPrefix("idle", "idle", 24, true);
		Sonic.animation.play('idle');
		Sonic.scrollFactor.set();
		Sonic.antialiasing = ClientPrefs.globalAntialiasing;
		add(Sonic);
		
		PressEnterToContinue = new FlxText(10, FlxG.height - 60, FlxG.width, "[press Enter to continue]");
		PressEnterToContinue.setFormat(Paths.font("advanced.ttf"), 40, 0xFFFFFFFF, LEFT);
		add(PressEnterToContinue);
		if (TranslationLanguages.Text.exists(PressEnterToContinue.text) && ClientPrefs.Language != 'English')
			PressEnterToContinue.text = TranslationLanguages.Text[PressEnterToContinue.text];
		FlxTween.tween(PressEnterToContinue, {alpha: 0.4}, 1, {ease: FlxEase.quadInOut, type: PINGPONG}); 
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.scrollFactor.set();
		blackScreen.screenCenter(X);
		add(blackScreen);
		new FlxTimer().start(0.2, function(off:FlxTimer) {
			FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {onComplete: function(twn:FlxTween) {
				canControl = true;
			}});
		});
		super.create();
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if ((controls.ACCEPT || FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && canControl) {
			if (!ClientPrefs.firstLaunchMenusWas.contains('sonic-disclaimer'))
				ClientPrefs.firstLaunchMenusWas.push('sonic-disclaimer');
			FlxG.sound.play(Paths.sound('hahaha'), 0.6);
			blackScreen.alpha = 1;
			FlxG.camera.flash(FlxColor.RED, 3);
			new FlxTimer().start(4.2, function(kkkk:FlxTimer) {
				ClientPrefs.saveSettings();
				MusicBeatState.switchState(new Cutscenes());
			});
			new FlxTimer().start(0.005, function(kkkk:FlxTimer) { canControl = false; });
		}
	}
}