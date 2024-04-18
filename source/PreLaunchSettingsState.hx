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

class PreLaunchSettingsState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var Options:FlxText;
	var Gore:FlxText;
	var Shaders:FlxText;
	var GPUCaching:FlxText;
	var Optimization:FlxText;
	var PotatoOptimization:FlxText;
	var Description:FlxText;
	
	var GoreCheck:FlxSprite;
	var GPUCachingCheck:FlxSprite;
	var ShadersCheck:FlxSprite;
	var OptimizationCheck:FlxSprite;
	var PotatoOptimizationCheck:FlxSprite;
	
	var selection:Int = 0;
	var canControl:Bool = false;
	var Apply:FlxSprite;
	var blackScreen:FlxSprite;
	var dafuk:FlxSprite;
	var mouseIsHerelol:Bool = false;
	
	var LangRu:FlxSprite;
	var LangEng:FlxSprite;
	var LangEs:FlxSprite;

	override function create() {
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		
		dafuk = new FlxSprite(0, 510).makeGraphic(1240, 90, 0xFF0F0F0F);
		dafuk.scrollFactor.set();
		dafuk.screenCenter(X);
		add(dafuk);
		
		Description = new FlxText(0, 510, FlxG.width, "");
		Description.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, CENTER);
		add(Description);
		
		
		Options = new FlxText(0, -5, FlxG.width, "pre-launch settings");
		Options.setFormat(Paths.font("advanced.ttf"), 110, 0xFFFFFFFF, CENTER);
		Options.screenCenter(X);
		add(Options);
		if (TranslationLanguages.Text.exists(Options.text) && ClientPrefs.Language != 'English')
			Options.text = TranslationLanguages.Text[Options.text];
		
		Gore = new FlxText(10, 170, FlxG.width, "gore:");
		Gore.setFormat(Paths.font("advanced.ttf"), 80, 0xFFFFFFFF, LEFT);
		add(Gore);
		if (TranslationLanguages.Text.exists(Gore.text) && ClientPrefs.Language != 'English')
			Gore.text = TranslationLanguages.Text[Gore.text];
		
		Shaders = new FlxText(10, 290, FlxG.width, "shaders:");
		Shaders.setFormat(Paths.font("advanced.ttf"), 80, 0xFFFFFFFF, LEFT);
		add(Shaders);
		if (TranslationLanguages.Text.exists(Shaders.text) && ClientPrefs.Language != 'English')
			Shaders.text = TranslationLanguages.Text[Shaders.text];
		
		GPUCaching = new FlxText(10, 410, FlxG.width, "gpu caching:");
		GPUCaching.setFormat(Paths.font("advanced.ttf"), 80, 0xFFFFFFFF, LEFT);
		add(GPUCaching);
		if (TranslationLanguages.Text.exists(GPUCaching.text) && ClientPrefs.Language != 'English')
			GPUCaching.text = TranslationLanguages.Text[GPUCaching.text];
		
		Optimization = new FlxText(500, 170, FlxG.width, "optimization:");
		Optimization.setFormat(Paths.font("advanced.ttf"), 80, 0xFFFFFFFF, LEFT);
		add(Optimization);
		if (TranslationLanguages.Text.exists(Optimization.text) && ClientPrefs.Language != 'English')
			Optimization.text = TranslationLanguages.Text[Optimization.text];
		
		PotatoOptimization = new FlxText(500, 290, FlxG.width, "potato optimization:");
		PotatoOptimization.setFormat(Paths.font("advanced.ttf"), 80, 0xFFFFFFFF, LEFT);
		add(PotatoOptimization);
		if (TranslationLanguages.Text.exists(PotatoOptimization.text) && ClientPrefs.Language != 'English')
			PotatoOptimization.text = TranslationLanguages.Text[PotatoOptimization.text];
		
		GoreCheck = new FlxSprite(170, 180);
		GoreCheck.frames = Paths.getSparrowAtlas('options/pre-launch/check');
		GoreCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		GoreCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		GoreCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		GoreCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.gore) GoreCheck.animation.play('idle-c');
		if (!ClientPrefs.gore) GoreCheck.animation.play('unchecked');
		GoreCheck.scrollFactor.set();
		GoreCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(GoreCheck);
		
		ShadersCheck = new FlxSprite(280, 300);
		ShadersCheck.frames = Paths.getSparrowAtlas('options/pre-launch/check');
		ShadersCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		ShadersCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		ShadersCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		ShadersCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.Shaders) ShadersCheck.animation.play('idle-c');
		if (!ClientPrefs.Shaders) ShadersCheck.animation.play('unchecked');
		ShadersCheck.scrollFactor.set();
		ShadersCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(ShadersCheck);
		
		GPUCachingCheck = new FlxSprite(380, 420);
		GPUCachingCheck.frames = Paths.getSparrowAtlas('options/pre-launch/check');
		GPUCachingCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		GPUCachingCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		GPUCachingCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		GPUCachingCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.GPUCaching) GPUCachingCheck.animation.play('idle-c');
		if (!ClientPrefs.GPUCaching) GPUCachingCheck.animation.play('unchecked');
		GPUCachingCheck.scrollFactor.set();
		GPUCachingCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(GPUCachingCheck);
		
		OptimizationCheck = new FlxSprite(880, 180);
		OptimizationCheck.frames = Paths.getSparrowAtlas('options/pre-launch/check');
		OptimizationCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		OptimizationCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		OptimizationCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		OptimizationCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.Optimization) OptimizationCheck.animation.play('idle-c');
		if (!ClientPrefs.Optimization) OptimizationCheck.animation.play('unchecked');
		OptimizationCheck.scrollFactor.set();
		OptimizationCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(OptimizationCheck);
		
		PotatoOptimizationCheck = new FlxSprite(1105, 300);
		PotatoOptimizationCheck.frames = Paths.getSparrowAtlas('options/pre-launch/check');
		PotatoOptimizationCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		PotatoOptimizationCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		PotatoOptimizationCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		PotatoOptimizationCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.PotatoOptimization) PotatoOptimizationCheck.animation.play('idle-c');
		if (!ClientPrefs.PotatoOptimization) PotatoOptimizationCheck.animation.play('unchecked');
		PotatoOptimizationCheck.scrollFactor.set();
		PotatoOptimizationCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(PotatoOptimizationCheck);
		
		Apply = new FlxSprite(486, 606).loadGraphic(Paths.image('options/pre-launch/apply'));
		Apply.antialiasing = ClientPrefs.globalAntialiasing;
		Apply.scrollFactor.set();
		add(Apply);
		
		LangRu = new FlxSprite(FlxG.width-171, FlxG.height-103).loadGraphic(Paths.image('options/lang/ru'));
		LangRu.antialiasing = ClientPrefs.globalAntialiasing;
		LangRu.scrollFactor.set();
		add(LangRu);
		LangEng = new FlxSprite(FlxG.width-171, FlxG.height-103).loadGraphic(Paths.image('options/lang/eng'));
		LangEng.antialiasing = ClientPrefs.globalAntialiasing;
		LangEng.scrollFactor.set();
		add(LangEng);
		LangEs = new FlxSprite(FlxG.width-171, FlxG.height-103).loadGraphic(Paths.image('options/lang/es'));
		LangEs.antialiasing = ClientPrefs.globalAntialiasing;
		LangEs.scrollFactor.set();
		add(LangEs);
		
		switch(ClientPrefs.Language) {
			case 'Russian':
				LangRu.alpha = 1;
				LangEng.alpha = 0;
				LangEs.alpha = 0;
				LangRu.color = 0xFF404040;
				
				GoreCheck.x += 245;
				GPUCachingCheck.x -= 125;
				Optimization.x += 50;
				OptimizationCheck.x += 80;
				PotatoOptimization.x += 50;
				PotatoOptimizationCheck.x -= 94;
			case 'Spanish':
				LangRu.alpha = 0;
				LangEng.alpha = 0;
				LangEs.alpha = 1;
				LangEs.color = 0xFF404040;
				
				GoreCheck.x += 68;
			case 'English':
				LangRu.alpha = 0;
				LangEng.alpha = 1;
				LangEs.alpha = 0;
				LangEng.color = 0xFF404040;
		}
		
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
		select(0);
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (canControl) {
			FlxG.mouse.visible = true;
			if (!FlxG.mouse.overlaps(Gore) && !FlxG.mouse.overlaps(GoreCheck) && !FlxG.mouse.overlaps(Optimization) && !FlxG.mouse.overlaps(OptimizationCheck) && !FlxG.mouse.overlaps(Shaders) && !FlxG.mouse.overlaps(ShadersCheck) && !FlxG.mouse.overlaps(PotatoOptimization) && !FlxG.mouse.overlaps(PotatoOptimizationCheck) && !FlxG.mouse.overlaps(GPUCaching) && !FlxG.mouse.overlaps(GPUCachingCheck) && !FlxG.mouse.overlaps(Apply)) {
				if (controls.UI_UP_P) {
					switch(selection) {
						case 1: select(0, false);
						case 2: select(1, false);
						case 4: select(3, false);
					}
				}
				if (controls.UI_DOWN_P) {
					switch(selection) {
						case 0: select(1, false);
						case 1: select(2, false);
						case 3: select(4, false);
					}
				}
				if (controls.UI_LEFT_P) {
					switch(selection) {
						case 3: select(0, false);
						case 4: select(1, false);
					}
				}
				if (controls.UI_RIGHT_P) {
					switch(selection) {
						case 0: select(3, false);
						case 1: select(4, false);
						case 3: select(4, false);
					}
				}
			} else {
				if ((FlxG.mouse.overlaps(Gore) || FlxG.mouse.overlaps(GoreCheck)) && selection != 0) select(0, true);
				if ((FlxG.mouse.overlaps(Shaders) || FlxG.mouse.overlaps(ShadersCheck)) && selection != 1) select(1, true);
				if ((FlxG.mouse.overlaps(GPUCaching) || FlxG.mouse.overlaps(GPUCachingCheck)) && selection != 2) select(2, true);
				if ((FlxG.mouse.overlaps(Optimization) || FlxG.mouse.overlaps(OptimizationCheck)) && selection != 3) select(3, true);
				if ((FlxG.mouse.overlaps(PotatoOptimization) || FlxG.mouse.overlaps(PotatoOptimizationCheck)) && selection != 4) select(4, true);
				if (FlxG.mouse.overlaps(Apply) && selection != 5) select(5, true);
			}
			if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(GoreCheck) || FlxG.mouse.overlaps(OptimizationCheck) || FlxG.mouse.overlaps(ShadersCheck) || FlxG.mouse.overlaps(PotatoOptimizationCheck) || FlxG.mouse.overlaps(GPUCachingCheck) || FlxG.mouse.overlaps(Apply)))) {
				switch(selection) {
					case 0:
						FlxG.sound.play(Paths.sound('tick'));
						if (ClientPrefs.gore) {
							GoreCheck.animation.play('unch');
							GoreCheck.animation.finishCallback = function(uncheck:String) { GoreCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.gore = false;
							});
						}
						if (!ClientPrefs.gore){
							GoreCheck.animation.play('ch');
							GoreCheck.animation.finishCallback = function(check:String) { GoreCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.gore = true;
							});
						}
					case 1:
						FlxG.sound.play(Paths.sound('tick'));
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
						FlxG.sound.play(Paths.sound('tick'));
						if (ClientPrefs.GPUCaching) {
							GPUCachingCheck.animation.play('unch');
							GPUCachingCheck.animation.finishCallback = function(uncheck:String) { GPUCachingCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(gpucoff:FlxTimer) {
								ClientPrefs.GPUCaching = false;
							});
						}
						if (!ClientPrefs.GPUCaching){
							GPUCachingCheck.animation.play('ch');
							GPUCachingCheck.animation.finishCallback = function(check:String) { GPUCachingCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(gpucon:FlxTimer) {
								ClientPrefs.GPUCaching = true;
							});
						}
					case 3:
						FlxG.sound.play(Paths.sound('tick'));
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
					case 4:
						FlxG.sound.play(Paths.sound('tick'));
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
					case 5:
						if (!ClientPrefs.firstLaunchMenusWas.contains('pre-launch-settings'))
							ClientPrefs.firstLaunchMenusWas.push('pre-launch-settings');
						FlxG.sound.play(Paths.sound('tick'));
						FlxTween.tween(blackScreen, {alpha: 1}, 1, {onComplete: function(twn:FlxTween) {
							ClientPrefs.saveSettings();
							MusicBeatState.switchState(new SonicDisclaimerState());
						}});
						new FlxTimer().start(0.005, function(kkkk:FlxTimer) { canControl = false; });
				}
			}
			
			if (FlxG.mouse.overlaps(LangEng)) {
				switch(ClientPrefs.Language) {
					case 'English': LangEng.color = 0xFFFFFFFF;
					case 'Spanish': LangEs.color = 0xFFFFFFFF;
					case 'Russian': LangRu.color = 0xFFFFFFFF;
				}
				if (FlxG.mouse.justPressed) {
					switch(ClientPrefs.Language) {
						case 'English':
							LangRu.alpha = 0;
							LangEng.alpha = 1;
							LangEs.alpha = 0;
							ClientPrefs.Language = 'Spanish';
							ClientPrefs.saveSettings();
							MusicBeatState.switchState(new Cutscenes('Haxe-LangChange'));
						case 'Spanish':
							LangRu.alpha = 0;
							LangEng.alpha = 0;
							LangEs.alpha = 1;
							ClientPrefs.Language = 'Russian';
							ClientPrefs.saveSettings();
							MusicBeatState.switchState(new Cutscenes('Haxe-LangChange'));
						case 'Russian':
							LangRu.alpha = 1;
							LangEng.alpha = 0;
							LangEs.alpha = 0;
							ClientPrefs.Language = 'English';
							ClientPrefs.saveSettings();
							MusicBeatState.switchState(new Cutscenes('Haxe-LangChange'));

					}
				}
			} else {
				switch(ClientPrefs.Language) {
					case 'English': LangEng.color = 0xFF404040;
					case 'Spanish': LangEs.color = 0xFF404040;
					case 'Russian': LangRu.color = 0xFF404040;
				}
			}
		}
		
		if (mouseIsHerelol) {
			if (!FlxG.mouse.overlaps(Gore) && !FlxG.mouse.overlaps(GoreCheck) && !FlxG.mouse.overlaps(Optimization) && !FlxG.mouse.overlaps(OptimizationCheck) && !FlxG.mouse.overlaps(Shaders) && !FlxG.mouse.overlaps(ShadersCheck) && !FlxG.mouse.overlaps(PotatoOptimization) && !FlxG.mouse.overlaps(PotatoOptimizationCheck) && !FlxG.mouse.overlaps(GPUCaching) && !FlxG.mouse.overlaps(GPUCachingCheck)) {
				Description.alpha = 0;
				dafuk.alpha = 0;
			} else {
				Description.alpha = 1;
				dafuk.alpha = 1;
			}
		} else {
			if (selection == 5) {
				Description.alpha = 0;
				dafuk.alpha = 0;
			} else {
				Description.alpha = 1;
				dafuk.alpha = 1;
			}
		}
	}
	function select(sel:Int, ?mouse:Bool = false) {
		if (selection != sel) selection = sel;
		if (mouse)
			mouseIsHerelol = true;
		else
			mouseIsHerelol = false;
		
		switch (selection) {
			case 0:
				Description.text = "If the option is still disabled, then most of the Gore content will not be displayed.\n(If, however, the song contains Gore content, then you will see a warning.)";
				Gore.color = 0xFFFFFFFF;
				GoreCheck.color = 0xFFFFFFFF;
				Shaders.color = 0xFF404040;
				ShadersCheck.color = 0xFF404040;
				GPUCaching.color = 0xFF404040;
				GPUCachingCheck.color = 0xFF404040;
				Optimization.color = 0xFF404040;
				OptimizationCheck.color = 0xFF404040;
				PotatoOptimization.color = 0xFF404040;
				PotatoOptimizationCheck.color = 0xFF404040;
				Apply.color = 0xFF404040;
			case 1:
				Description.text = "If checked, some songs will have shaders.\n(Not recommended for low devices)";
				Gore.color = 0xFF404040;
				GoreCheck.color = 0xFF404040;
				Shaders.color = 0xFFFFFFFF;
				ShadersCheck.color = 0xFFFFFFFF;
				GPUCaching.color = 0xFF404040;
				GPUCachingCheck.color = 0xFF404040;
				Optimization.color = 0xFF404040;
				OptimizationCheck.color = 0xFF404040;
				PotatoOptimization.color = 0xFF404040;
				PotatoOptimizationCheck.color = 0xFF404040;
				Apply.color = 0xFF404040;
			case 2:
				Description.text = "If checked, improves performance due to the video card. ";
				Gore.color = 0xFF404040;
				GoreCheck.color = 0xFF404040;
				Shaders.color = 0xFF404040;
				ShadersCheck.color = 0xFF404040;
				GPUCaching.color = 0xFFFFFFFF;
				GPUCachingCheck.color = 0xFFFFFFFF;
				Optimization.color = 0xFF404040;
				OptimizationCheck.color = 0xFF404040;
				PotatoOptimization.color = 0xFF404040;
				PotatoOptimizationCheck.color = 0xFF404040;
				Apply.color = 0xFF404040;
			case 3:
				Description.text = "If checked, some parts of the backgrounds will be removed.\n(Suitable for more average devices, requires 6-8GB RAM.)";
				Gore.color = 0xFF404040;
				GoreCheck.color = 0xFF404040;
				Shaders.color = 0xFF404040;
				ShadersCheck.color = 0xFF404040;
				GPUCaching.color = 0xFF404040;
				GPUCachingCheck.color = 0xFF404040;
				Optimization.color = 0xFFFFFFFF;
				OptimizationCheck.color = 0xFFFFFFFF;
				PotatoOptimization.color = 0xFF404040;
				PotatoOptimizationCheck.color = 0xFF404040;
				Apply.color = 0xFF404040;
			case 4:
				Description.text = "If checked, all bg's in songs will be removed.\n(Suitable for weaker devices, 4-6GB RAM required.)";
				Gore.color = 0xFF404040;
				GoreCheck.color = 0xFF404040;
				Shaders.color = 0xFF404040;
				ShadersCheck.color = 0xFF404040;
				GPUCaching.color = 0xFF404040;
				GPUCachingCheck.color = 0xFF404040;
				Optimization.color = 0xFF404040;
				OptimizationCheck.color = 0xFF404040;
				PotatoOptimization.color = 0xFFFFFFFF;
				PotatoOptimizationCheck.color = 0xFFFFFFFF;
				Apply.color = 0xFF404040;
			case 5:
				Description.text = "";
				Gore.color = 0xFF404040;
				GoreCheck.color = 0xFF404040;
				Shaders.color = 0xFF404040;
				ShadersCheck.color = 0xFF404040;
				GPUCaching.color = 0xFF404040;
				GPUCachingCheck.color = 0xFF404040;
				Optimization.color = 0xFF404040;
				OptimizationCheck.color = 0xFF404040;
				PotatoOptimization.color = 0xFF404040;
				PotatoOptimizationCheck.color = 0xFF404040;
				Apply.color = 0xFFFFFFFF;
		}
		if (TranslationLanguages.Text.exists(Description.text) && ClientPrefs.Language != 'English')
			Description.text = TranslationLanguages.Text[Description.text];
	}
}