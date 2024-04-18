package options;

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
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop; 
import Controls;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class OptionsNewState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var bg:FlxBackdrop;
	var window:FlxSprite;
	var FGup:FlxBackdrop;
	var FGdown:FlxBackdrop;
	var contr:FlxSprite;
	var contrSel:FlxSprite;
	var graphics:FlxSprite;
	var graphicsSel:FlxSprite;
	var visandui:FlxSprite;
	var visanduiSel:FlxSprite;
	var gameplay:FlxSprite;
	var gameplaySel:FlxSprite;
	var curSelected:Int = 0;
	var optionsArray:Array<String> = ["Controls", "Graphics", "Visuals And UI", "Gameplay"];
	var blackScreen:FlxSprite;
	var locked:Bool = true;
	var hitboxControls:FlxSprite;
	var hitboxGraphics:FlxSprite;
	var hitboxVisAndUI:FlxSprite;
	var hitboxGameplay:FlxSprite;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Options Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'options';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		FlxG.sound.playMusic(Paths.music('options'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);

		bg = new FlxBackdrop(Paths.image('options/main/bg'), 1, 1, false, true);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);
		
		window = new FlxSprite(210, 77).loadGraphic(Paths.image('options/main/window'));
		window.antialiasing = ClientPrefs.globalAntialiasing;
		window.scrollFactor.set();
		add(window);
		
		FGup = new FlxBackdrop(Paths.image('options/main/fg-up'), 1, 1, true, false);
		FGup.antialiasing = ClientPrefs.globalAntialiasing;
		FGup.screenCenter();
		add(FGup);
		
		FGdown = new FlxBackdrop(Paths.image('options/main/fg-down'), 1, 1, true, false);
		FGdown.antialiasing = ClientPrefs.globalAntialiasing;
		FGdown.screenCenter();
		add(FGdown);
		
		contr = new FlxSprite(332, 116).loadGraphic(Paths.image('options/main/buttons/controls'));
		contr.antialiasing = ClientPrefs.globalAntialiasing;
		contr.scrollFactor.set();
		add(contr);

		contrSel = new FlxSprite(332, 116).loadGraphic(Paths.image('options/main/buttons/controls-sel'));
		contrSel.antialiasing = ClientPrefs.globalAntialiasing;
		contrSel.scrollFactor.set();
		add(contrSel);
		
		graphics = new FlxSprite(332, 220).loadGraphic(Paths.image('options/main/buttons/graphics'));
		graphics.antialiasing = ClientPrefs.globalAntialiasing;
		graphics.scrollFactor.set();
		add(graphics);
		
		graphicsSel = new FlxSprite(332, 220).loadGraphic(Paths.image('options/main/buttons/graphics-sel'));
		graphicsSel.antialiasing = ClientPrefs.globalAntialiasing;
		graphicsSel.scrollFactor.set();
		add(graphicsSel);
		
		visandui = new FlxSprite(332, 323).loadGraphic(Paths.image('options/main/buttons/visuals-and-ui'));
		visandui.antialiasing = ClientPrefs.globalAntialiasing;
		visandui.scrollFactor.set();
		add(visandui);
		
		visanduiSel = new FlxSprite(332, 323).loadGraphic(Paths.image('options/main/buttons/visuals-and-ui-sel'));
		visanduiSel.antialiasing = ClientPrefs.globalAntialiasing;
		visanduiSel.scrollFactor.set();
		add(visanduiSel);
		
		gameplay = new FlxSprite(332, 427).loadGraphic(Paths.image('options/main/buttons/gameplay'));
		gameplay.antialiasing = ClientPrefs.globalAntialiasing;
		gameplay.scrollFactor.set();
		add(gameplay);
		
		gameplaySel = new FlxSprite(332, 427).loadGraphic(Paths.image('options/main/buttons/gameplay-sel'));
		gameplaySel.antialiasing = ClientPrefs.globalAntialiasing;
		gameplaySel.scrollFactor.set();
		add(gameplaySel);
		
		hitboxControls = new FlxSprite(380,164).makeGraphic(520,89, 0x00000000);
		add(hitboxControls);
		hitboxGraphics = new FlxSprite(380,268).makeGraphic(520,89, 0x00000000);
		add(hitboxGraphics);
		hitboxVisAndUI = new FlxSprite(380,371).makeGraphic(520,89, 0x00000000);
		add(hitboxVisAndUI);
		hitboxGameplay = new FlxSprite(380,475).makeGraphic(520,89, 0x00000000);
		add(hitboxGameplay);
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.scrollFactor.set();
		blackScreen.screenCenter(X);
		add(blackScreen);
		FlxTween.tween(blackScreen, {alpha: 0}, 0.25, {onComplete: function(twn:FlxTween) {
			locked = false;
		}});
		
		changeSel(0, false);
		
		#if mobile
		var tipText:FlxText = new FlxText(10, FlxG.height - 24, 0, 'Press C to customize your android controls', 16);
		tipText.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		tipText.borderSize = 2.4;
		tipText.scrollFactor.set();
		add(tipText);
		
		if (TranslationLanguages.Text.exists(tipText.text) && ClientPrefs.Language != 'English')
			tipText.text = TranslationLanguages.Text[tipText.text];
		
		addVirtualPad(UP_DOWN, A_B_C);
		virtualPad.y = -24;
		#end
		super.create();
	}
	
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		bg.velocity.set(0, 50);
		FGup.velocity.set(-50, 0);
		FGdown.velocity.set(50, 0);
		
		if (!locked) {
			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			#if desktop if (!FlxG.mouse.overlaps(window)) { #end
				if (controls.UI_UP_P)
				{
					changeSel(-shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN_P)
				{
					changeSel(shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSel((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
				#if desktop
				if (FlxG.mouse.wheel != 0)
				{
					changeSel(-shiftMult * FlxG.mouse.wheel);
					holdTime = 0;
				}
			} else {
				if (FlxG.mouse.overlaps(hitboxControls) && curSelected != 0) changeSel(0, true, true);
				if (FlxG.mouse.overlaps(hitboxGraphics) && curSelected != 1) changeSel(1, true, true);
				if (FlxG.mouse.overlaps(hitboxVisAndUI) && curSelected != 2) changeSel(2, true, true);
				if (FlxG.mouse.overlaps(hitboxGameplay) && curSelected != 3) changeSel(3, true, true);
			}
			#end
			if (controls.BACK #if desktop || FlxG.mouse.justPressedRight #end) {
				FlxTween.tween(blackScreen, {alpha: 1}, 0.25, {onComplete: function(twn:FlxTween) {
					ClientPrefs.saveSettings();
					MusicBeatState.switchState(new MainMenuState());
				}});
				new FlxTimer().start(0.015, function(kkkk:FlxTimer) { locked = true; });
			}
			if (controls.ACCEPT #if desktop || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(hitboxControls) || FlxG.mouse.overlaps(hitboxGraphics) || FlxG.mouse.overlaps(hitboxVisAndUI) || FlxG.mouse.overlaps(hitboxGameplay))) #end) {
				FlxTween.tween(blackScreen, {alpha: 1}, 0.25, {onComplete: function(twn:FlxTween) {
					switch(curSelected) {
						case 0: #if mobile removeVirtualPad(); #end MusicBeatState.switchState(new options.ControlsNewState());
						case 1: #if mobile removeVirtualPad(); #end MusicBeatState.switchState(new options.GraphicsNewState());
						case 2: #if mobile removeVirtualPad(); #end MusicBeatState.switchState(new options.VisualsUINewState());
						case 3: #if mobile removeVirtualPad(); #end MusicBeatState.switchState(new options.GameplayNewState());
					}
				}});
			}
			#if mobile
			if (virtualPad.buttonC.justPressed) {
				removeVirtualPad();
				openSubState(new mobile.MobileControlsSubState());
			}
			#end
		}
	}
	
	function changeSel(change:Int = 0, ?playSound:Bool = true, ?mouse:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		
		if (!mouse) {
			curSelected += change;
			
			if (curSelected < 0)
				curSelected = optionsArray.length - 1;
			if (curSelected >= optionsArray.length)
				curSelected = 0;	
		} else {
			curSelected = change;
		}
	
		switch(curSelected) {
			case 0:
				contr.alpha = 0;
				contrSel.alpha = 1;
				graphics.alpha = 1;
				graphicsSel.alpha = 0;
				visandui.alpha = 1;
				visanduiSel.alpha = 0;
				gameplay.alpha = 1;
				gameplaySel.alpha = 0;
			case 1:
				contr.alpha = 1;
				contrSel.alpha = 0;
				graphics.alpha = 0;
				graphicsSel.alpha = 1;
				visandui.alpha = 1;
				visanduiSel.alpha = 0;
				gameplay.alpha = 1;
				gameplaySel.alpha = 0;
			case 2:
				contr.alpha = 1;
				contrSel.alpha = 0;
				graphics.alpha = 1;
				graphicsSel.alpha = 0;
				visandui.alpha = 0;
				visanduiSel.alpha = 1;
				gameplay.alpha = 1;
				gameplaySel.alpha = 0;
			case 3:
				contr.alpha = 1;
				contrSel.alpha = 0;
				graphics.alpha = 1;
				graphicsSel.alpha = 0;
				visandui.alpha = 1;
				visanduiSel.alpha = 0;
				gameplay.alpha = 0;
				gameplaySel.alpha = 1;
		}
	}
}