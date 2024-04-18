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

class GraphicsNewState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var bg:FlxBackdrop;
	var window:FlxSprite;
	var FGup:FlxBackdrop;
	var FGdown:FlxBackdrop;
	var curSelected:Int = 0;
	var fuck:Array<String> = ["1", "2", "3", "4", "5"];
	
	var OptionGPUCaching:FlxSprite;
	var OptionShaders:FlxSprite;
	var OptionOptimization:FlxSprite;
	var OptionPotatoOptimization:FlxSprite;
	var OptionAntiAliasing:FlxSprite;
	
	var GPUCaching:FlxText;
	var Shaders:FlxText;
	var Optimization:FlxText;
	var PotatoOptimization:FlxText;
	var AntiAliasing:FlxText;
	
	var GPUCachingCheck:FlxSprite;
	var ShadersCheck:FlxSprite;
	var OptimizationCheck:FlxSprite;
	var PotatoOptimizationCheck:FlxSprite;
	var AntiAliasingCheck:FlxSprite;
	
	var descBox:FlxSprite;
	var descText:FlxText;
	
	var blackScreen:FlxSprite;
	var locked:Bool = true;
	var mouseHitbox:FlxSprite;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Options Menu (Graphics)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'options-graphics';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		bg = new FlxBackdrop(Paths.image('options/main/bg'), 1, 1, false, true);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);
		
		window = new FlxSprite(284, 14).loadGraphic(Paths.image('options/graphics-gameplay'));
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
		
		OptionGPUCaching = new FlxSprite(355, 95).loadGraphic(Paths.image('options/box-option'));
		OptionGPUCaching.antialiasing = ClientPrefs.globalAntialiasing;
		OptionGPUCaching.scrollFactor.set();
		add(OptionGPUCaching);
		
		OptionShaders = new FlxSprite(355, 205).loadGraphic(Paths.image('options/box-option'));
		OptionShaders.antialiasing = ClientPrefs.globalAntialiasing;
		OptionShaders.scrollFactor.set();
		add(OptionShaders);
		
		OptionOptimization = new FlxSprite(355, 315).loadGraphic(Paths.image('options/box-option'));
		OptionOptimization.antialiasing = ClientPrefs.globalAntialiasing;
		OptionOptimization.scrollFactor.set();
		add(OptionOptimization);
		
		OptionPotatoOptimization = new FlxSprite(355, 425).loadGraphic(Paths.image('options/box-option'));
		OptionPotatoOptimization.antialiasing = ClientPrefs.globalAntialiasing;
		OptionPotatoOptimization.scrollFactor.set();
		add(OptionPotatoOptimization);
		
		OptionAntiAliasing = new FlxSprite(355, 535).loadGraphic(Paths.image('options/box-option'));
		OptionAntiAliasing.antialiasing = ClientPrefs.globalAntialiasing;
		OptionAntiAliasing.scrollFactor.set();
		add(OptionAntiAliasing);
		
		GPUCaching = new FlxText(370, 110, FlxG.width, "GPU Caching");
		GPUCaching.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFFFF0000, LEFT);
		GPUCaching.scrollFactor.set();
		GPUCaching.antialiasing = ClientPrefs.globalAntialiasing;
		add(GPUCaching);
		if (TranslationLanguages.Text.exists(GPUCaching.text) && ClientPrefs.Language != 'English')
			GPUCaching.text = TranslationLanguages.Text[GPUCaching.text];
		
		Shaders = new FlxText(370, 220, FlxG.width, "Shaders");
		Shaders.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		Shaders.scrollFactor.set();
		Shaders.antialiasing = ClientPrefs.globalAntialiasing;
		add(Shaders);
		if (TranslationLanguages.Text.exists(Shaders.text) && ClientPrefs.Language != 'English')
			Shaders.text = TranslationLanguages.Text[Shaders.text];
		
		Optimization = new FlxText(370, 330, FlxG.width, "Optimization");
		Optimization.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		Optimization.scrollFactor.set();
		Optimization.antialiasing = ClientPrefs.globalAntialiasing;
		add(Optimization);
		if (TranslationLanguages.Text.exists(Optimization.text) && ClientPrefs.Language != 'English')
			Optimization.text = TranslationLanguages.Text[Optimization.text];
		
		PotatoOptimization = new FlxText(370, 440, FlxG.width, "Potato Mode");
		PotatoOptimization.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		PotatoOptimization.scrollFactor.set();
		PotatoOptimization.antialiasing = ClientPrefs.globalAntialiasing;
		add(PotatoOptimization);
		if (TranslationLanguages.Text.exists(PotatoOptimization.text) && ClientPrefs.Language != 'English')
			PotatoOptimization.text = TranslationLanguages.Text[PotatoOptimization.text];
		
		AntiAliasing = new FlxText(370, 550, FlxG.width, "Anti-Aliasing");
		AntiAliasing.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		AntiAliasing.scrollFactor.set();
		AntiAliasing.antialiasing = ClientPrefs.globalAntialiasing;
		add(AntiAliasing);
		if (TranslationLanguages.Text.exists(AntiAliasing.text) && ClientPrefs.Language != 'English')
			AntiAliasing.text = TranslationLanguages.Text[AntiAliasing.text];
			
		GPUCachingCheck = new FlxSprite(800, 100);
		GPUCachingCheck.frames = Paths.getSparrowAtlas('options/check');
		GPUCachingCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		GPUCachingCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		GPUCachingCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		GPUCachingCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.GPUCaching) GPUCachingCheck.animation.play('idle-c');
		if (!ClientPrefs.GPUCaching) GPUCachingCheck.animation.play('unchecked');
		GPUCachingCheck.scrollFactor.set();
		GPUCachingCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(GPUCachingCheck);
		
		ShadersCheck = new FlxSprite(800, 210);
		ShadersCheck.frames = Paths.getSparrowAtlas('options/check');
		ShadersCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		ShadersCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		ShadersCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		ShadersCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.Shaders) ShadersCheck.animation.play('idle-c');
		if (!ClientPrefs.Shaders) ShadersCheck.animation.play('unchecked');
		ShadersCheck.scrollFactor.set();
		ShadersCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(ShadersCheck);
		
		OptimizationCheck = new FlxSprite(800, 320);
		OptimizationCheck.frames = Paths.getSparrowAtlas('options/check');
		OptimizationCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		OptimizationCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		OptimizationCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		OptimizationCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.Optimization) OptimizationCheck.animation.play('idle-c');
		if (!ClientPrefs.Optimization) OptimizationCheck.animation.play('unchecked');
		OptimizationCheck.scrollFactor.set();
		OptimizationCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(OptimizationCheck);
		
		PotatoOptimizationCheck = new FlxSprite(800, 430);
		PotatoOptimizationCheck.frames = Paths.getSparrowAtlas('options/check');
		PotatoOptimizationCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		PotatoOptimizationCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		PotatoOptimizationCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		PotatoOptimizationCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.PotatoOptimization) PotatoOptimizationCheck.animation.play('idle-c');
		if (!ClientPrefs.PotatoOptimization) PotatoOptimizationCheck.animation.play('unchecked');
		PotatoOptimizationCheck.scrollFactor.set();
		PotatoOptimizationCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(PotatoOptimizationCheck);
		
		AntiAliasingCheck = new FlxSprite(800, 540);
		AntiAliasingCheck.frames = Paths.getSparrowAtlas('options/check');
		AntiAliasingCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		AntiAliasingCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		AntiAliasingCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		AntiAliasingCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.globalAntialiasing) AntiAliasingCheck.animation.play('idle-c');
		if (!ClientPrefs.globalAntialiasing) AntiAliasingCheck.animation.play('unchecked');
		AntiAliasingCheck.scrollFactor.set();
		AntiAliasingCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(AntiAliasingCheck);

		mouseHitbox = new FlxSprite(342,75).makeGraphic(596,570, 0x00000000);
		add(mouseHitbox);

		descBox = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, 315, 1200, "", 15);
		descText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 15, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		descText.antialiasing = ClientPrefs.globalAntialiasing;
		add(descText);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.scrollFactor.set();
		blackScreen.screenCenter(X);
		add(blackScreen);
		FlxTween.tween(blackScreen, {alpha: 0}, 0.25, {onComplete: function(twn:FlxTween) {
			locked = false;
		}});

		Select(curSelected, false);
		super.create();
	}
	
	function Select(change:Int = 0, ?playSound:Bool = true, ?mouse:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (!mouse) {
			curSelected += change;
			if (curSelected < 0)
				curSelected = fuck.length - 1;
			if (curSelected >= fuck.length)
				curSelected = 0;
		} else {
			curSelected = change;
		}
		
		GPUCaching.color = 0xFF5B0000;
		Shaders.color = 0xFF5B0000;
		Optimization.color = 0xFF5B0000;
		PotatoOptimization.color = 0xFF5B0000;
		AntiAliasing.color = 0xFF5B0000;
		
		OptionGPUCaching.color = 0xFF5B0000;
		OptionShaders.color = 0xFF5B0000;
		OptionOptimization.color = 0xFF5B0000;
		OptionPotatoOptimization.color = 0xFF5B0000;
		OptionAntiAliasing.color = 0xFF5B0000;
	
		switch(curSelected) {
			case 0: GPUCaching.color = 0xFFFF0000;
					OptionGPUCaching.color = 0xFFFF0000;
					descText.text = 'If checked, improves performance due to the video card.';
			case 1: Shaders.color = 0xFFFF0000;
					OptionShaders.color = 0xFFFF0000;
					descText.text = 'Uncheck this box if shaders cause lag. Some scenes without shaders can look terrible.\nMay increase performance a bit.';
			case 2: Optimization.color = 0xFFFF0000;
					OptionOptimization.color = 0xFFFF0000;
					descText.text = 'If checked, objects will disappear in some songs, increasing performance.';
			case 3: PotatoOptimization.color = 0xFFFF0000;
					OptionPotatoOptimization.color = 0xFFFF0000;
					descText.text = 'If checked, increases optimization to the level of potatoes.';
			case 4: AntiAliasing.color = 0xFFFF0000;
					OptionAntiAliasing.color = 0xFFFF0000;
					descText.text = 'If unchecked, disables anti-aliasing, increases performance at the cost of sharper visuals.';
		}
		if (TranslationLanguages.Text.exists(descText.text) && ClientPrefs.Language != 'English')
			descText.text = TranslationLanguages.Text[descText.text];
		descText.screenCenter(Y);
		descText.y += 315;
		
		descBox.setPosition(descText.x - 10, descText.y - 10);
		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
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
			if (!FlxG.mouse.overlaps(mouseHitbox)) {
				if (controls.UI_UP_P)
				{
					Select(-shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN_P)
				{
					Select(shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
				if (FlxG.mouse.wheel != 0)
				{
					Select(-shiftMult * FlxG.mouse.wheel);
					holdTime = 0;
				}
			} else {
				if ((FlxG.mouse.overlaps(OptionGPUCaching) || FlxG.mouse.overlaps(GPUCachingCheck)) && curSelected != 0) Select(0, true, true);
				if ((FlxG.mouse.overlaps(OptionShaders) || FlxG.mouse.overlaps(ShadersCheck)) && curSelected != 1) Select(1, true, true);
				if ((FlxG.mouse.overlaps(OptionOptimization) || FlxG.mouse.overlaps(OptimizationCheck)) && curSelected != 2) Select(2, true, true);
				if ((FlxG.mouse.overlaps(OptionPotatoOptimization) || FlxG.mouse.overlaps(PotatoOptimizationCheck)) && curSelected != 3) Select(3, true, true);
				if ((FlxG.mouse.overlaps(OptionAntiAliasing) || FlxG.mouse.overlaps(AntiAliasingCheck)) && curSelected != 4) Select(4, true, true);
			}
			if (controls.BACK || FlxG.mouse.justPressedRight) {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(blackScreen, {alpha: 1}, 0.25, {onComplete: function(twn:FlxTween) {
					ClientPrefs.saveSettings();
					MusicBeatState.switchState(new OptionsNewState());
				}});
				new FlxTimer().start(0.015, function(kkkk:FlxTimer) { locked = true; });
			}
			if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(GPUCachingCheck) || FlxG.mouse.overlaps(OptimizationCheck) || FlxG.mouse.overlaps(ShadersCheck) || FlxG.mouse.overlaps(PotatoOptimizationCheck) || FlxG.mouse.overlaps(AntiAliasingCheck)))) {
				switch(curSelected) {
					case 0:
						if (ClientPrefs.GPUCaching) {
							GPUCachingCheck.animation.play('unch');
							GPUCachingCheck.animation.finishCallback = function(uncheck:String) { GPUCachingCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(lqoff:FlxTimer) {
								ClientPrefs.GPUCaching = false;
							});
						}
						if (!ClientPrefs.GPUCaching){
							GPUCachingCheck.animation.play('ch');
							GPUCachingCheck.animation.finishCallback = function(check:String) { GPUCachingCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(lqon:FlxTimer) {
								ClientPrefs.GPUCaching = true;
							});
						}
					case 1:
						if (ClientPrefs.Shaders) {
							ShadersCheck.animation.play('unch');
							ShadersCheck.animation.finishCallback = function(uncheck:String) { ShadersCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(shoff:FlxTimer) {
								ClientPrefs.Shaders = false;
							});
						}
						if (!ClientPrefs.Shaders){
							ShadersCheck.animation.play('ch');
							ShadersCheck.animation.finishCallback = function(check:String) { ShadersCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(shon:FlxTimer) {
								ClientPrefs.Shaders = true;
							});
						}
					case 2:
						if (ClientPrefs.Optimization) {	
							OptimizationCheck.animation.play('unch');
							OptimizationCheck.animation.finishCallback = function(uncheck:String) { OptimizationCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(optioff:FlxTimer) {
								ClientPrefs.Optimization = false;
							});
						}
						if (!ClientPrefs.Optimization){			
							OptimizationCheck.animation.play('ch');
							OptimizationCheck.animation.finishCallback = function(check:String) { OptimizationCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(option:FlxTimer) {
								ClientPrefs.Optimization = true;
							});
						}
					case 3:
						if (ClientPrefs.PotatoOptimization) {
							PotatoOptimizationCheck.animation.play('unch');
							PotatoOptimizationCheck.animation.finishCallback = function(uncheck:String) { PotatoOptimizationCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(pooff:FlxTimer) {
								ClientPrefs.PotatoOptimization = false;
							});
						}
						if (!ClientPrefs.PotatoOptimization){
							PotatoOptimizationCheck.animation.play('ch');
							PotatoOptimizationCheck.animation.finishCallback = function(check:String) { PotatoOptimizationCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(poon:FlxTimer) {
								ClientPrefs.PotatoOptimization = true;
							});							
						}
					case 4:
						if (ClientPrefs.globalAntialiasing) {
							AntiAliasingCheck.animation.play('unch');
							AntiAliasingCheck.animation.finishCallback = function(uncheck:String) { AntiAliasingCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(gaoff:FlxTimer) {
								ClientPrefs.globalAntialiasing = false;
							});
						}
						if (!ClientPrefs.globalAntialiasing){
							AntiAliasingCheck.animation.play('ch');
							AntiAliasingCheck.animation.finishCallback = function(check:String) { AntiAliasingCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(gaon:FlxTimer) {
								ClientPrefs.globalAntialiasing = true;
							});
						}
				}
			}
		}
	}
}