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

class GameplayNewState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var bg:FlxBackdrop;
	var window:FlxSprite;
	var FGup:FlxBackdrop;
	var FGdown:FlxBackdrop;
	var curSelected:Int = 0;
	var fuck:Array<String> = ["1", "2", "3", "4", "5"];
	
	var OptionClassicChartEditor:FlxSprite;
	var OptionDownScroll:FlxSprite;
	var OptionMiddleScroll:FlxSprite;
	var OptionGhostTapping:FlxSprite;
	var OptionDisableResetButton:FlxSprite;
	
	var ClassicChartEditor:FlxText;
	var DownScroll:FlxText;
	var MiddleScroll:FlxText;
	var GhostTapping:FlxText;
	var DisableResetButton:FlxText;
	
	var ClassicChartEditorCheck:FlxSprite;
	var DownScrollCheck:FlxSprite;
	var MiddleScrollCheck:FlxSprite;
	var GhostTappingCheck:FlxSprite;
	var DisableResetButtonCheck:FlxSprite;
	
	var descBox:FlxSprite;
	var descText:FlxText;
	
	var blackScreen:FlxSprite;
	var locked:Bool = true;
	var mouseHitbox:FlxSprite;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Options Menu (Gameplay)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'options-gameplay';
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
		
		OptionClassicChartEditor = new FlxSprite(355, 95).loadGraphic(Paths.image('options/box-option'));
		OptionClassicChartEditor.antialiasing = ClientPrefs.globalAntialiasing;
		OptionClassicChartEditor.scrollFactor.set();
		add(OptionClassicChartEditor);
		
		OptionDownScroll = new FlxSprite(355, 205).loadGraphic(Paths.image('options/box-option'));
		OptionDownScroll.antialiasing = ClientPrefs.globalAntialiasing;
		OptionDownScroll.scrollFactor.set();
		add(OptionDownScroll);
		
		OptionMiddleScroll = new FlxSprite(355, 315).loadGraphic(Paths.image('options/box-option'));
		OptionMiddleScroll.antialiasing = ClientPrefs.globalAntialiasing;
		OptionMiddleScroll.scrollFactor.set();
		add(OptionMiddleScroll);
		
		OptionGhostTapping = new FlxSprite(355, 425).loadGraphic(Paths.image('options/box-option'));
		OptionGhostTapping.antialiasing = ClientPrefs.globalAntialiasing;
		OptionGhostTapping.scrollFactor.set();
		add(OptionGhostTapping);
		
		OptionDisableResetButton = new FlxSprite(355, 535).loadGraphic(Paths.image('options/box-option'));
		OptionDisableResetButton.antialiasing = ClientPrefs.globalAntialiasing;
		OptionDisableResetButton.scrollFactor.set();
		add(OptionDisableResetButton);
		
		ClassicChartEditor = new FlxText(370, 110, FlxG.width, "Chart Editor");
		ClassicChartEditor.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFFFF0000, LEFT);
		ClassicChartEditor.scrollFactor.set();
		ClassicChartEditor.antialiasing = ClientPrefs.globalAntialiasing;
		add(ClassicChartEditor);
		if (TranslationLanguages.Text.exists(ClassicChartEditor.text) && ClientPrefs.Language != 'English')
			ClassicChartEditor.text = TranslationLanguages.Text[ClassicChartEditor.text];
		
		DownScroll = new FlxText(370, 220, FlxG.width, "Down Scroll");
		DownScroll.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		DownScroll.scrollFactor.set();
		DownScroll.antialiasing = ClientPrefs.globalAntialiasing;
		add(DownScroll);
		if (TranslationLanguages.Text.exists(DownScroll.text) && ClientPrefs.Language != 'English')
			DownScroll.text = TranslationLanguages.Text[DownScroll.text];
		
		MiddleScroll = new FlxText(370, 330, FlxG.width, "Middle Scroll");
		MiddleScroll.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		MiddleScroll.scrollFactor.set();
		MiddleScroll.antialiasing = ClientPrefs.globalAntialiasing;
		add(MiddleScroll);
		if (TranslationLanguages.Text.exists(MiddleScroll.text) && ClientPrefs.Language != 'English')
			MiddleScroll.text = TranslationLanguages.Text[MiddleScroll.text];
		
		GhostTapping = new FlxText(370, 440, FlxG.width, "Ghost Tapping");
		GhostTapping.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		GhostTapping.scrollFactor.set();
		GhostTapping.antialiasing = ClientPrefs.globalAntialiasing;
		add(GhostTapping);
		if (TranslationLanguages.Text.exists(GhostTapping.text) && ClientPrefs.Language != 'English')
			GhostTapping.text = TranslationLanguages.Text[GhostTapping.text];
		
		DisableResetButton = new FlxText(370, 550, FlxG.width, "Disable Reset");
		DisableResetButton.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		DisableResetButton.scrollFactor.set();
		DisableResetButton.antialiasing = ClientPrefs.globalAntialiasing;
		add(DisableResetButton);
		if (TranslationLanguages.Text.exists(DisableResetButton.text) && ClientPrefs.Language != 'English')
			DisableResetButton.text = TranslationLanguages.Text[DisableResetButton.text];
		
		ClassicChartEditorCheck = new FlxSprite(800, 100);
		ClassicChartEditorCheck.frames = Paths.getSparrowAtlas('options/check');
		ClassicChartEditorCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		ClassicChartEditorCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		ClassicChartEditorCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		ClassicChartEditorCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.ClassicChartEditor) ClassicChartEditorCheck.animation.play('idle-c');
		if (!ClientPrefs.ClassicChartEditor) ClassicChartEditorCheck.animation.play('unchecked');
		ClassicChartEditorCheck.scrollFactor.set();
		ClassicChartEditorCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(ClassicChartEditorCheck);
		
		DownScrollCheck = new FlxSprite(800, 210);
		DownScrollCheck.frames = Paths.getSparrowAtlas('options/check');
		DownScrollCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		DownScrollCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		DownScrollCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		DownScrollCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.downScroll) DownScrollCheck.animation.play('idle-c');
		if (!ClientPrefs.downScroll) DownScrollCheck.animation.play('unchecked');
		DownScrollCheck.scrollFactor.set();
		DownScrollCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(DownScrollCheck);
		
		MiddleScrollCheck = new FlxSprite(800, 320);
		MiddleScrollCheck.frames = Paths.getSparrowAtlas('options/check');
		MiddleScrollCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		MiddleScrollCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		MiddleScrollCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		MiddleScrollCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.middleScroll) MiddleScrollCheck.animation.play('idle-c');
		if (!ClientPrefs.middleScroll) MiddleScrollCheck.animation.play('unchecked');
		MiddleScrollCheck.scrollFactor.set();
		MiddleScrollCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(MiddleScrollCheck);
		
		GhostTappingCheck = new FlxSprite(800, 430);
		GhostTappingCheck.frames = Paths.getSparrowAtlas('options/check');
		GhostTappingCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		GhostTappingCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		GhostTappingCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		GhostTappingCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.ghostTapping) GhostTappingCheck.animation.play('idle-c');
		if (!ClientPrefs.ghostTapping) GhostTappingCheck.animation.play('unchecked');
		GhostTappingCheck.scrollFactor.set();
		GhostTappingCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(GhostTappingCheck);
		
		DisableResetButtonCheck = new FlxSprite(800, 540);
		DisableResetButtonCheck.frames = Paths.getSparrowAtlas('options/check');
		DisableResetButtonCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		DisableResetButtonCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		DisableResetButtonCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		DisableResetButtonCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.noReset) DisableResetButtonCheck.animation.play('idle-c');
		if (!ClientPrefs.noReset) DisableResetButtonCheck.animation.play('unchecked');
		DisableResetButtonCheck.scrollFactor.set();
		DisableResetButtonCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(DisableResetButtonCheck);

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
		
		ClassicChartEditor.color = 0xFF5B0000;
		DownScroll.color = 0xFF5B0000;
		MiddleScroll.color = 0xFF5B0000;
		GhostTapping.color = 0xFF5B0000;
		DisableResetButton.color = 0xFF5B0000;
		
		OptionClassicChartEditor.color = 0xFF5B0000;
		OptionDownScroll.color = 0xFF5B0000;
		OptionMiddleScroll.color = 0xFF5B0000;
		OptionGhostTapping.color = 0xFF5B0000;
		OptionDisableResetButton.color = 0xFF5B0000;
	
		switch(curSelected) {
			case 0: ClassicChartEditor.color = 0xFFFF0000;
					OptionClassicChartEditor.color = 0xFFFF0000;
					descText.text = 'Check this if you need a classic chart editor. Without Ring mechanic.';
			case 1: DownScroll.color = 0xFFFF0000;
					OptionDownScroll.color = 0xFFFF0000;
					descText.text = 'If checked, notes go Down instead of Up, simple enough.';
			case 2: MiddleScroll.color = 0xFFFF0000;
					OptionMiddleScroll.color = 0xFFFF0000;
					descText.text = 'If checked, your notes get centered.';
			case 3: GhostTapping.color = 0xFFFF0000;
					OptionGhostTapping.color = 0xFFFF0000;
					descText.text = "If checked, you won't get misses from pressing keys while there are no notes able to be hit.";
			case 4: DisableResetButton.color = 0xFFFF0000;
					OptionDisableResetButton.color = 0xFFFF0000;
					descText.text = "If checked, pressing Reset won't do anything.";
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
						if (controls.UI_UP) Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
						if (controls.UI_DOWN) Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
				if (FlxG.mouse.wheel != 0)
				{
					Select(-shiftMult * FlxG.mouse.wheel);
					holdTime = 0;
				}
			} else {
				if ((FlxG.mouse.overlaps(OptionClassicChartEditor) || FlxG.mouse.overlaps(ClassicChartEditorCheck)) && curSelected != 0) Select(0, true, true);
				if ((FlxG.mouse.overlaps(OptionDownScroll) || FlxG.mouse.overlaps(DownScrollCheck)) && curSelected != 1) Select(1, true, true);
				if ((FlxG.mouse.overlaps(OptionMiddleScroll) || FlxG.mouse.overlaps(MiddleScrollCheck)) && curSelected != 2) Select(2, true, true);
				if ((FlxG.mouse.overlaps(OptionGhostTapping) || FlxG.mouse.overlaps(GhostTappingCheck)) && curSelected != 3) Select(3, true, true);
				if ((FlxG.mouse.overlaps(OptionDisableResetButton) || FlxG.mouse.overlaps(DisableResetButtonCheck)) && curSelected != 4) Select(4, true, true);
			}
			if (controls.BACK || FlxG.mouse.justPressedRight) {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(blackScreen, {alpha: 1}, 0.25, {onComplete: function(twn:FlxTween) {
					ClientPrefs.saveSettings();
					MusicBeatState.switchState(new OptionsNewState());
				}});
				new FlxTimer().start(0.015, function(kkkk:FlxTimer) { locked = true; });
			}
			if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(ClassicChartEditorCheck) || FlxG.mouse.overlaps(DownScrollCheck) || FlxG.mouse.overlaps(MiddleScrollCheck) || FlxG.mouse.overlaps(GhostTappingCheck) || FlxG.mouse.overlaps(DisableResetButtonCheck)))) {
				switch(curSelected) {
					case 0:
						if (ClientPrefs.ClassicChartEditor) {
							ClassicChartEditorCheck.animation.play('unch');
							ClassicChartEditorCheck.animation.finishCallback = function(uncheck:String) { ClassicChartEditorCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(lqoff:FlxTimer) {
								ClientPrefs.ClassicChartEditor = false;
							});
						}
						if (!ClientPrefs.ClassicChartEditor){
							ClassicChartEditorCheck.animation.play('ch');
							ClassicChartEditorCheck.animation.finishCallback = function(check:String) { ClassicChartEditorCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(lqon:FlxTimer) {
								ClientPrefs.ClassicChartEditor = true;
							});
						}
					case 1:
						if (ClientPrefs.downScroll) {
							DownScrollCheck.animation.play('unch');
							DownScrollCheck.animation.finishCallback = function(uncheck:String) { DownScrollCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(shoff:FlxTimer) {
								ClientPrefs.downScroll = false;
							});
						}
						if (!ClientPrefs.downScroll){
							DownScrollCheck.animation.play('ch');
							DownScrollCheck.animation.finishCallback = function(check:String) { DownScrollCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(shon:FlxTimer) {
								ClientPrefs.downScroll = true;
							});
						}
					case 2:
						if (ClientPrefs.middleScroll) {	
							MiddleScrollCheck.animation.play('unch');
							MiddleScrollCheck.animation.finishCallback = function(uncheck:String) { MiddleScrollCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(optioff:FlxTimer) {
								ClientPrefs.middleScroll = false;
							});
						}
						if (!ClientPrefs.middleScroll){			
							MiddleScrollCheck.animation.play('ch');
							MiddleScrollCheck.animation.finishCallback = function(check:String) { MiddleScrollCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(option:FlxTimer) {
								ClientPrefs.middleScroll = true;
							});
						}
					case 3:
						if (ClientPrefs.ghostTapping) {
							GhostTappingCheck.animation.play('unch');
							GhostTappingCheck.animation.finishCallback = function(uncheck:String) { GhostTappingCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(pooff:FlxTimer) {
								ClientPrefs.ghostTapping = false;
							});
						}
						if (!ClientPrefs.ghostTapping){
							GhostTappingCheck.animation.play('ch');
							GhostTappingCheck.animation.finishCallback = function(check:String) { GhostTappingCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(poon:FlxTimer) {
								ClientPrefs.ghostTapping = true;
							});							
						}
					case 4:
						if (ClientPrefs.noReset) {
							DisableResetButtonCheck.animation.play('unch');
							DisableResetButtonCheck.animation.finishCallback = function(uncheck:String) { DisableResetButtonCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(gaoff:FlxTimer) {
								ClientPrefs.noReset = false;
							});
						}
						if (!ClientPrefs.noReset){
							DisableResetButtonCheck.animation.play('ch');
							DisableResetButtonCheck.animation.finishCallback = function(check:String) { DisableResetButtonCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(gaon:FlxTimer) {
								ClientPrefs.noReset = true;
							});
						}
				}
			}
		}
	}
}