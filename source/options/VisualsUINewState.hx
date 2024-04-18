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

class VisualsUINewState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var bg:FlxBackdrop;
	var window:FlxSprite;
	var FGup:FlxBackdrop;
	var FGdown:FlxBackdrop;
	var curSelected:Int = 0;
	var fuck:Array<String> = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
	
	var OptionNoteSplashes:FlxSprite;
	var OptionHideHud:FlxSprite;
	var OptionBarsOutline:FlxSprite;
	var OptionGore:FlxSprite;
	var OptionLogo:FlxSprite;
	
	var OptionFlashes:FlxSprite;
	var OptionCameraZooms:FlxSprite;
	var OptionScoreZoom:FlxSprite;
	var OptionHPTransp:FlxSprite;
	var OptionFPSCounter:FlxSprite;
	
	var NoteSplashes:FlxText;
	var HideHud:FlxText;
	var BarsOutline:FlxText;
	var Gore:FlxText;
	var Logo:FlxText;
	
	var RestorationLogo:FlxSprite;
	var RestoredLogo:FlxSprite;
	var RestoredOldLogo:FlxSprite;
	var OGLogo:FlxSprite;
	
	var Flashes:FlxText;
	var CameraZooms:FlxText;
	var ScoreZoom:FlxText;
	var HPTransp:FlxText;
	var FPSCounter:FlxText;
	
	var BarsOutlineValue:FlxText;
	var HPTranspValue:FlxText;
	
	var BarsOutlineCheck:FlxSprite;
	var LogoCheck:FlxSprite;
	var HPTranspCheck:FlxSprite;
	var NoteSplashesCheck:FlxSprite;
	var HideHudCheck:FlxSprite;
	var GoreCheck:FlxSprite;
	var FlashesCheck:FlxSprite;
	var CameraZoomsCheck:FlxSprite;
	var ScoreZoomCheck:FlxSprite;
	var FPSCounterCheck:FlxSprite;
	
	var descBox:FlxSprite;
	var descText:FlxText;
	
	var blackScreen:FlxSprite;
	var locked:Bool = true;
	var fuckIt:Array<Int> = [0,1,2,3,4,5,6,7,8,9];
	var mouseHitbox:FlxSprite;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Options Menu (Vis. & UI)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'options-vis-and-ui';
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
		
		window = new FlxSprite(38, 14).loadGraphic(Paths.image('options/vis-ui'));
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
		
		OptionNoteSplashes = new FlxSprite(108, 95).loadGraphic(Paths.image('options/box-option'));
		OptionNoteSplashes.antialiasing = ClientPrefs.globalAntialiasing;
		OptionNoteSplashes.scrollFactor.set();
		add(OptionNoteSplashes);
		
		OptionHideHud = new FlxSprite(108, 205).loadGraphic(Paths.image('options/box-option'));
		OptionHideHud.antialiasing = ClientPrefs.globalAntialiasing;
		OptionHideHud.scrollFactor.set();
		add(OptionHideHud);
		
		OptionBarsOutline = new FlxSprite(108, 315).loadGraphic(Paths.image('options/box-option-smaller'));
		OptionBarsOutline.antialiasing = ClientPrefs.globalAntialiasing;
		OptionBarsOutline.scrollFactor.set();
		add(OptionBarsOutline);
		
		OptionGore = new FlxSprite(108, 425).loadGraphic(Paths.image('options/box-option'));
		OptionGore.antialiasing = ClientPrefs.globalAntialiasing;
		OptionGore.scrollFactor.set();
		add(OptionGore);
		
		OptionLogo = new FlxSprite(108, 535).loadGraphic(Paths.image('options/box-option-smaller'));
		OptionLogo.antialiasing = ClientPrefs.globalAntialiasing;
		OptionLogo.scrollFactor.set();
		add(OptionLogo);
		
		OptionFlashes = new FlxSprite(646, 95).loadGraphic(Paths.image('options/box-option'));
		OptionFlashes.antialiasing = ClientPrefs.globalAntialiasing;
		OptionFlashes.scrollFactor.set();
		add(OptionFlashes);
		
		OptionCameraZooms = new FlxSprite(646, 205).loadGraphic(Paths.image('options/box-option'));
		OptionCameraZooms.antialiasing = ClientPrefs.globalAntialiasing;
		OptionCameraZooms.scrollFactor.set();
		add(OptionCameraZooms);
		
		OptionScoreZoom = new FlxSprite(646, 315).loadGraphic(Paths.image('options/box-option'));
		OptionScoreZoom.antialiasing = ClientPrefs.globalAntialiasing;
		OptionScoreZoom.scrollFactor.set();
		add(OptionScoreZoom);
		
		OptionHPTransp = new FlxSprite(646, 425).loadGraphic(Paths.image('options/box-option-smaller'));
		OptionHPTransp.antialiasing = ClientPrefs.globalAntialiasing;
		OptionHPTransp.scrollFactor.set();
		add(OptionHPTransp);
		
		OptionFPSCounter = new FlxSprite(646, 535).loadGraphic(Paths.image('options/box-option'));
		OptionFPSCounter.antialiasing = ClientPrefs.globalAntialiasing;
		OptionFPSCounter.scrollFactor.set();
		add(OptionFPSCounter);
		
		NoteSplashes = new FlxText(123, 110, FlxG.width, "Note Splash");
		NoteSplashes.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFFFF0000, LEFT);
		NoteSplashes.scrollFactor.set();
		NoteSplashes.antialiasing = ClientPrefs.globalAntialiasing;
		add(NoteSplashes);
		if (TranslationLanguages.Text.exists(NoteSplashes.text) && ClientPrefs.Language != 'English')
			NoteSplashes.text = TranslationLanguages.Text[NoteSplashes.text];
		
		HideHud = new FlxText(123, 220, FlxG.width, "Hide Hud");
		HideHud.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		HideHud.scrollFactor.set();
		HideHud.antialiasing = ClientPrefs.globalAntialiasing;
		add(HideHud);
		if (TranslationLanguages.Text.exists(HideHud.text) && ClientPrefs.Language != 'English')
			HideHud.text = TranslationLanguages.Text[HideHud.text];
		
		BarsOutline = new FlxText(123, 330, FlxG.width, "Bars Outline");
		BarsOutline.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		BarsOutline.scrollFactor.set();
		BarsOutline.antialiasing = ClientPrefs.globalAntialiasing;
		add(BarsOutline);
		if (TranslationLanguages.Text.exists(BarsOutline.text) && ClientPrefs.Language != 'English')
			BarsOutline.text = TranslationLanguages.Text[BarsOutline.text];
		
		Gore = new FlxText(123, 440, FlxG.width, "Gore");
		Gore.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		Gore.scrollFactor.set();
		Gore.antialiasing = ClientPrefs.globalAntialiasing;
		add(Gore);
		if (TranslationLanguages.Text.exists(Gore.text) && ClientPrefs.Language != 'English')
			Gore.text = TranslationLanguages.Text[Gore.text];
		
		Logo = new FlxText(123, 550, FlxG.width, "Logo");
		Logo.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		Logo.scrollFactor.set();
		Logo.antialiasing = ClientPrefs.globalAntialiasing;
		add(Logo);
		if (TranslationLanguages.Text.exists(Logo.text) && ClientPrefs.Language != 'English')
			Logo.text = TranslationLanguages.Text[Logo.text];
		
		Flashes = new FlxText(661, 110, FlxG.width, "Flashes");
		Flashes.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFFFF0000, LEFT);
		Flashes.scrollFactor.set();
		Flashes.antialiasing = ClientPrefs.globalAntialiasing;
		add(Flashes);
		if (TranslationLanguages.Text.exists(Flashes.text) && ClientPrefs.Language != 'English')
			Flashes.text = TranslationLanguages.Text[Flashes.text];
		
		CameraZooms = new FlxText(661, 220, FlxG.width, "Camera Zooms");
		CameraZooms.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		CameraZooms.scrollFactor.set();
		CameraZooms.antialiasing = ClientPrefs.globalAntialiasing;
		add(CameraZooms);
		if (TranslationLanguages.Text.exists(CameraZooms.text) && ClientPrefs.Language != 'English')
			CameraZooms.text = TranslationLanguages.Text[CameraZooms.text];
		
		ScoreZoom = new FlxText(661, 330, FlxG.width, "Score Zoom");
		ScoreZoom.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		ScoreZoom.scrollFactor.set();
		ScoreZoom.antialiasing = ClientPrefs.globalAntialiasing;
		add(ScoreZoom);
		if (TranslationLanguages.Text.exists(ScoreZoom.text) && ClientPrefs.Language != 'English')
			ScoreZoom.text = TranslationLanguages.Text[ScoreZoom.text];
		
		HPTransp = new FlxText(661, 440, FlxG.width, "HP Transp.");
		HPTransp.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		HPTransp.scrollFactor.set();
		HPTransp.antialiasing = ClientPrefs.globalAntialiasing;
		add(HPTransp);
		if (TranslationLanguages.Text.exists(HPTransp.text) && ClientPrefs.Language != 'English')
			HPTransp.text = TranslationLanguages.Text[HPTransp.text];
		
		FPSCounter = new FlxText(661, 550, FlxG.width, "FPS Counter");
		FPSCounter.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 35, 0xFF5B0000, LEFT);
		FPSCounter.scrollFactor.set();
		FPSCounter.antialiasing = ClientPrefs.globalAntialiasing;
		add(FPSCounter);
		if (TranslationLanguages.Text.exists(FPSCounter.text) && ClientPrefs.Language != 'English')
			FPSCounter.text = TranslationLanguages.Text[FPSCounter.text];
		
		BarsOutlineCheck = new FlxSprite(538, 325).loadGraphic(Paths.image('options/val'));
		BarsOutlineCheck.antialiasing = ClientPrefs.globalAntialiasing;
		BarsOutlineCheck.scrollFactor.set();
		add(BarsOutlineCheck);
		
		HPTranspCheck = new FlxSprite(1076, 435).loadGraphic(Paths.image('options/val'));
		HPTranspCheck.antialiasing = ClientPrefs.globalAntialiasing;
		HPTranspCheck.scrollFactor.set();
		add(HPTranspCheck);
		
		BarsOutlineValue = new FlxText(548, 345, FlxG.width, "");
		BarsOutlineValue.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 15, 0xFF5B0000, LEFT);
		BarsOutlineValue.scrollFactor.set();
		if (ClientPrefs.BarsColor == 'Dark Color') BarsOutlineValue.text = 'Dark';
		if (ClientPrefs.BarsColor == 'Light Color') BarsOutlineValue.text = 'Light';
		if (ClientPrefs.BarsColor == 'No Color Change') BarsOutlineValue.text = 'OFF';
		BarsOutlineValue.antialiasing = ClientPrefs.globalAntialiasing;
		add(BarsOutlineValue);
		if (TranslationLanguages.Text.exists(BarsOutlineValue.text) && ClientPrefs.Language != 'English')
			BarsOutlineValue.text = TranslationLanguages.Text[BarsOutlineValue.text];
		
		HPTranspValue = new FlxText(1095, 455, FlxG.width, "");
		HPTranspValue.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 15, 0xFF5B0000, LEFT);
		HPTranspValue.scrollFactor.set();
		if (ClientPrefs.healthBarAlpha == 1) HPTranspValue.text = '100';
		if (ClientPrefs.healthBarAlpha == 0.75) HPTranspValue.text = '75';
		if (ClientPrefs.healthBarAlpha == 0.5) HPTranspValue.text = '50';
		if (ClientPrefs.healthBarAlpha == 0.25) HPTranspValue.text = '25';
		if (ClientPrefs.healthBarAlpha == 0) HPTranspValue.text = '0';
		HPTranspValue.antialiasing = ClientPrefs.globalAntialiasing;
		add(HPTranspValue);
		if (TranslationLanguages.Text.exists(HPTranspValue.text) && ClientPrefs.Language != 'English')
			HPTranspValue.text = TranslationLanguages.Text[HPTranspValue.text];
			
		LogoCheck = new FlxSprite(538, 545).loadGraphic(Paths.image('options/val'));
		LogoCheck.antialiasing = ClientPrefs.globalAntialiasing;
		LogoCheck.scrollFactor.set();
		add(LogoCheck);
		
		RestorationLogo = new FlxSprite(5, 440).loadGraphic(Paths.image('options/logo/restoration'));
		RestorationLogo.antialiasing = ClientPrefs.globalAntialiasing;
		RestorationLogo.scrollFactor.set();
		if (ClientPrefs.LogoStyle != 'Restoration') RestorationLogo.alpha = 0;
		add(RestorationLogo);
		
		RestoredLogo = new FlxSprite(5, 440).loadGraphic(Paths.image('options/logo/restored'));
		RestoredLogo.antialiasing = ClientPrefs.globalAntialiasing;
		RestoredLogo.scrollFactor.set();
		if (ClientPrefs.LogoStyle != 'Restored') RestoredLogo.alpha = 0;
		add(RestoredLogo);
		
		RestoredOldLogo = new FlxSprite(5, 440).loadGraphic(Paths.image('options/logo/old-restored'));
		RestoredOldLogo.antialiasing = ClientPrefs.globalAntialiasing;
		RestoredOldLogo.scrollFactor.set();
		if (ClientPrefs.LogoStyle != 'Restored Old') RestoredOldLogo.alpha = 0;
		add(RestoredOldLogo);
		
		OGLogo = new FlxSprite(5, 440).loadGraphic(Paths.image('options/logo/og'));
		OGLogo.antialiasing = ClientPrefs.globalAntialiasing;
		OGLogo.scrollFactor.set();
		if (ClientPrefs.LogoStyle != 'Sonic.exe') OGLogo.alpha = 0;
		add(OGLogo);
		
		NoteSplashesCheck = new FlxSprite(549, 100);
		NoteSplashesCheck.frames = Paths.getSparrowAtlas('options/check');
		NoteSplashesCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		NoteSplashesCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		NoteSplashesCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		NoteSplashesCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.noteSplashes) NoteSplashesCheck.animation.play('idle-c');
		if (!ClientPrefs.noteSplashes) NoteSplashesCheck.animation.play('unchecked');
		NoteSplashesCheck.scrollFactor.set();
		NoteSplashesCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(NoteSplashesCheck);
		
		HideHudCheck = new FlxSprite(549, 210);
		HideHudCheck.frames = Paths.getSparrowAtlas('options/check');
		HideHudCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		HideHudCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		HideHudCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		HideHudCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.hideHud) HideHudCheck.animation.play('idle-c');
		if (!ClientPrefs.hideHud) HideHudCheck.animation.play('unchecked');
		HideHudCheck.scrollFactor.set();
		HideHudCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(HideHudCheck);
		
		GoreCheck = new FlxSprite(549, 430);
		GoreCheck.frames = Paths.getSparrowAtlas('options/check');
		GoreCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		GoreCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		GoreCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		GoreCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.gore) GoreCheck.animation.play('idle-c');
		if (!ClientPrefs.gore) GoreCheck.animation.play('unchecked');
		GoreCheck.scrollFactor.set();
		GoreCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(GoreCheck);
		
		FlashesCheck = new FlxSprite(1087, 100);
		FlashesCheck.frames = Paths.getSparrowAtlas('options/check');
		FlashesCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		FlashesCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		FlashesCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		FlashesCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.flashing) FlashesCheck.animation.play('idle-c');
		if (!ClientPrefs.flashing) FlashesCheck.animation.play('unchecked');
		FlashesCheck.scrollFactor.set();
		FlashesCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(FlashesCheck);
		
		CameraZoomsCheck = new FlxSprite(1087, 210);
		CameraZoomsCheck.frames = Paths.getSparrowAtlas('options/check');
		CameraZoomsCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		CameraZoomsCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		CameraZoomsCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		CameraZoomsCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.camZooms) CameraZoomsCheck.animation.play('idle-c');
		if (!ClientPrefs.camZooms) CameraZoomsCheck.animation.play('unchecked');
		CameraZoomsCheck.scrollFactor.set();
		CameraZoomsCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(CameraZoomsCheck);
		
		ScoreZoomCheck = new FlxSprite(1085, 320);
		ScoreZoomCheck.frames = Paths.getSparrowAtlas('options/check');
		ScoreZoomCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		ScoreZoomCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		ScoreZoomCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		ScoreZoomCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.scoreZoom) ScoreZoomCheck.animation.play('idle-c');
		if (!ClientPrefs.scoreZoom) ScoreZoomCheck.animation.play('unchecked');
		ScoreZoomCheck.scrollFactor.set();
		ScoreZoomCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(ScoreZoomCheck);
		
		#if !mobile
		FPSCounterCheck = new FlxSprite(1087, 540);
		FPSCounterCheck.frames = Paths.getSparrowAtlas('options/check');
		FPSCounterCheck.animation.addByIndices('idle-c', 'check', [10], "", 24, false);
		FPSCounterCheck.animation.addByIndices('unchecked', 'check', [0], "", 24, false);
		FPSCounterCheck.animation.addByIndices('ch', 'check', [1,2,3,4,5,6,7,8,9,10], "", 24, false);
		FPSCounterCheck.animation.addByIndices('unch', 'check', [11,12,13,14,15,16,17,18,19,20], "", 24, false);
		if (ClientPrefs.showFPS) FPSCounterCheck.animation.play('idle-c');
		if (!ClientPrefs.showFPS) FPSCounterCheck.animation.play('unchecked');
		FPSCounterCheck.scrollFactor.set();
		FPSCounterCheck.antialiasing = ClientPrefs.globalAntialiasing;
		add(FPSCounterCheck);
		#end

		mouseHitbox = new FlxSprite(96,75).makeGraphic(1088,570, 0x00000000);
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

		Select(false, '');
		super.create();
	}
	
	function Select(playSound:Bool = true, yes:String = '', ?holyjesus:Int = 0, ?mouse:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		
		if (!mouse) {
			curSelected += holyjesus;
			if (curSelected < 0)
				curSelected = fuckIt.length - 1;
			if (curSelected >= fuckIt.length)
				curSelected = 0;	
		} else {
			curSelected = holyjesus;
		}
		
		switch(yes) {
			case 'up' | 'down':
			case 'left' | 'right':
				switch(curSelected) {
					case 0: curSelected = 5;
					case 1: curSelected = 6;
					case 2: curSelected = 7;
					case 3: curSelected = 8;
					case 4: curSelected = 9;
					case 5: curSelected = 0;
					case 6: curSelected = 1;
					case 7: curSelected = 2;
					case 8: curSelected = 3;
					case 9: curSelected = 4;
				}
		}

		NoteSplashes.color = 0xFF5B0000;
		HideHud.color = 0xFF5B0000;
		BarsOutline.color = 0xFF5B0000;
		Gore.color = 0xFF5B0000;
		Logo.color = 0xFF5B0000;
		Flashes.color = 0xFF5B0000;
		CameraZooms.color = 0xFF5B0000;
		ScoreZoom.color = 0xFF5B0000;
		HPTransp.color = 0xFF5B0000;
		FPSCounter.color = 0xFF5B0000;
		
		OptionNoteSplashes.color = 0xFF5B0000;
		OptionHideHud.color = 0xFF5B0000;
		OptionBarsOutline.color = 0xFF5B0000;
		OptionGore.color = 0xFF5B0000;
		OptionLogo.color = 0xFF5B0000;
		OptionFlashes.color = 0xFF5B0000;
		OptionCameraZooms.color = 0xFF5B0000;
		OptionScoreZoom.color = 0xFF5B0000;
		OptionHPTransp.color = 0xFF5B0000;
		OptionFPSCounter.color = 0xFF5B0000;
	
		switch(curSelected) {
			case 0: NoteSplashes.color = 0xFFFF0000;
					OptionNoteSplashes.color = 0xFFFF0000;
					descText.text = "If unchecked, hitting \"Sick!\" notes won't show particles.";
			case 1: HideHud.color = 0xFFFF0000;
					OptionHideHud.color = 0xFFFF0000;
					descText.text = 'If checked, hides most HUD elements.';
			case 2: BarsOutline.color = 0xFFFF0000;
					OptionBarsOutline.color = 0xFFFF0000;
					descText.text = 'Outline color on Time Bar and Health Bar.';
			case 3: Gore.color = 0xFFFF0000;
					OptionGore.color = 0xFFFF0000;
					descText.text = "Uncheck this if you're sensitive to gore, blood or smth like this.";
			case 4: Logo.color = 0xFFFF0000;
					OptionLogo.color = 0xFFFF0000;
					descText.text = "The logo that will be displayed when the game starts.";
			case 5: Flashes.color = 0xFFFF0000;
					OptionFlashes.color = 0xFFFF0000;
					descText.text = "Uncheck this if you're sensitive to flashing lights.";
			case 6: CameraZooms.color = 0xFFFF0000;
					OptionCameraZooms.color = 0xFFFF0000;
					descText.text = "If unchecked, the camera won't zoom in on a beat hit.";
			case 7: ScoreZoom.color = 0xFFFF0000;
					OptionScoreZoom.color = 0xFFFF0000;
					descText.text = 'If unchecked, disables the Score text zooming everytime you hit a note.';
			case 8: HPTransp.color = 0xFFFF0000;
					OptionHPTransp.color = 0xFFFF0000;
					descText.text = "How much transparent should the health bar and icons be.";
			case 9: FPSCounter.color = 0xFFFF0000;
					OptionFPSCounter.color = 0xFFFF0000;
					descText.text = "If unchecked, hides FPS Counter.";
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
					Select(true,'up',-shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN_P)
				{
					Select(true,'down',shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						if (controls.UI_UP) Select(true,'up',(checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
						if (controls.UI_DOWN) Select(true,'down',(checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
				if (FlxG.mouse.wheel != 0)
				{
					if (FlxG.mouse.wheel > 0) Select(true,'up',-shiftMult * FlxG.mouse.wheel);
					if (FlxG.mouse.wheel < 0) Select(true,'down',-shiftMult * FlxG.mouse.wheel);
					holdTime = 0;
				}
				if (controls.UI_LEFT_P) Select(true, 'left');
				if (controls.UI_RIGHT_P) Select(true, 'right');
			} else {
				if ((FlxG.mouse.overlaps(OptionNoteSplashes) || FlxG.mouse.overlaps(NoteSplashesCheck)) && curSelected != 0) Select(true,'',0,true);
				if ((FlxG.mouse.overlaps(OptionHideHud) || FlxG.mouse.overlaps(HideHudCheck)) && curSelected != 1) Select(true,'',1,true);
				if ((FlxG.mouse.overlaps(OptionBarsOutline) || FlxG.mouse.overlaps(BarsOutlineCheck)) && curSelected != 2) Select(true,'',2,true);
				if ((FlxG.mouse.overlaps(OptionGore) || FlxG.mouse.overlaps(GoreCheck)) && curSelected != 3) Select(true,'',3,true);
				if ((FlxG.mouse.overlaps(OptionLogo) || FlxG.mouse.overlaps(LogoCheck)) && curSelected != 4) Select(true,'',4,true);
				if ((FlxG.mouse.overlaps(OptionFlashes) || FlxG.mouse.overlaps(FlashesCheck)) && curSelected != 5) Select(true,'',5,true);
				if ((FlxG.mouse.overlaps(OptionCameraZooms) || FlxG.mouse.overlaps(CameraZoomsCheck)) && curSelected != 6) Select(true,'',6,true);
				if ((FlxG.mouse.overlaps(OptionScoreZoom) || FlxG.mouse.overlaps(ScoreZoomCheck)) && curSelected != 7) Select(true,'',7,true);
				if ((FlxG.mouse.overlaps(OptionHPTransp) || FlxG.mouse.overlaps(HPTranspCheck)) && curSelected != 8) Select(true,'',8,true);
				if ((FlxG.mouse.overlaps(OptionFPSCounter) || FlxG.mouse.overlaps(FPSCounterCheck)) && curSelected != 9) Select(true,'',9,true);
			}
			if (controls.BACK || FlxG.mouse.justPressedRight) {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(blackScreen, {alpha: 1}, 0.25, {onComplete: function(twn:FlxTween) {
					ClientPrefs.saveSettings();
					MusicBeatState.switchState(new OptionsNewState());
				}});
				new FlxTimer().start(0.015, function(kkkk:FlxTimer) { locked = true; });
			}
			if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(NoteSplashesCheck) || FlxG.mouse.overlaps(HideHudCheck) || FlxG.mouse.overlaps(BarsOutlineCheck) || FlxG.mouse.overlaps(GoreCheck) || FlxG.mouse.overlaps(LogoCheck) || FlxG.mouse.overlaps(FlashesCheck) || FlxG.mouse.overlaps(CameraZoomsCheck) || FlxG.mouse.overlaps(ScoreZoomCheck) || FlxG.mouse.overlaps(HPTranspCheck) || FlxG.mouse.overlaps(FPSCounterCheck)))) {
				switch(curSelected) {
					case 0:
						if (ClientPrefs.noteSplashes) {
							NoteSplashesCheck.animation.play('unch');
							NoteSplashesCheck.animation.finishCallback = function(uncheck:String) { NoteSplashesCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.noteSplashes = false;
							});
						}
						if (!ClientPrefs.noteSplashes){
							NoteSplashesCheck.animation.play('ch');
							NoteSplashesCheck.animation.finishCallback = function(check:String) { NoteSplashesCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.noteSplashes = true;
							});
						}
					case 1:
						if (ClientPrefs.hideHud) {
							HideHudCheck.animation.play('unch');
							HideHudCheck.animation.finishCallback = function(uncheck:String) { HideHudCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.hideHud = false;
							});
						}
						if (!ClientPrefs.hideHud){
							HideHudCheck.animation.play('ch');
							HideHudCheck.animation.finishCallback = function(check:String) { HideHudCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.hideHud = true;
							});
						}
					case 2:
						if (ClientPrefs.BarsColor == 'No Color Change') {
							BarsOutlineValue.text = 'Dark';
							if (TranslationLanguages.Text.exists(BarsOutlineValue.text) && ClientPrefs.Language != 'English')
								BarsOutlineValue.text = TranslationLanguages.Text[BarsOutlineValue.text];
							new FlxTimer().start(0.02, function(no:FlxTimer) {
								ClientPrefs.BarsColor = 'Dark Color';
							});
						}
						if (ClientPrefs.BarsColor == 'Light Color') {
							BarsOutlineValue.text = 'OFF';
							if (TranslationLanguages.Text.exists(BarsOutlineValue.text) && ClientPrefs.Language != 'English')
								BarsOutlineValue.text = TranslationLanguages.Text[BarsOutlineValue.text];
							new FlxTimer().start(0.02, function(li:FlxTimer) {
								ClientPrefs.BarsColor = 'No Color Change';
							});
						}
						if (ClientPrefs.BarsColor == 'Dark Color') {
							BarsOutlineValue.text = 'Light';
							if (TranslationLanguages.Text.exists(BarsOutlineValue.text) && ClientPrefs.Language != 'English')
								BarsOutlineValue.text = TranslationLanguages.Text[BarsOutlineValue.text];
							new FlxTimer().start(0.02, function(da:FlxTimer) {
								ClientPrefs.BarsColor = 'Light Color';
							});
						}
					case 3:
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
					case 4:
						if (ClientPrefs.LogoStyle == 'Restoration') {
							RestorationLogo.alpha = 0;
							RestoredLogo.alpha = 1;
							RestoredOldLogo.alpha = 0;
							OGLogo.alpha = 0;
							new FlxTimer().start(0.02, function(no:FlxTimer) {
								ClientPrefs.LogoStyle = 'Restored';
							});
						}
						if (ClientPrefs.LogoStyle == 'Restored') {
							RestorationLogo.alpha = 0;
							RestoredLogo.alpha = 0;
							RestoredOldLogo.alpha = 1;
							OGLogo.alpha = 0;
							new FlxTimer().start(0.02, function(li:FlxTimer) {
								ClientPrefs.LogoStyle = 'Restored Old';
							});
						}
						if (ClientPrefs.LogoStyle == 'Restored Old') {
							RestorationLogo.alpha = 0;
							RestoredLogo.alpha = 0;
							RestoredOldLogo.alpha = 0;
							OGLogo.alpha = 1;
							new FlxTimer().start(0.02, function(da:FlxTimer) {
								ClientPrefs.LogoStyle = 'Sonic.exe';
							});
						}
						if (ClientPrefs.LogoStyle == 'Sonic.exe') {
							RestorationLogo.alpha = 1;
							RestoredLogo.alpha = 0;
							RestoredOldLogo.alpha = 0;
							OGLogo.alpha = 0;
							new FlxTimer().start(0.02, function(da:FlxTimer) {
								ClientPrefs.LogoStyle = 'Restoration';
							});
						}
					case 5:
						if (ClientPrefs.flashing) {
							FlashesCheck.animation.play('unch');
							FlashesCheck.animation.finishCallback = function(uncheck:String) { FlashesCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.flashing = false;
							});
						}
						if (!ClientPrefs.flashing){
							FlashesCheck.animation.play('ch');
							FlashesCheck.animation.finishCallback = function(check:String) { FlashesCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.flashing = true;
							});
						}
					case 6:
						if (ClientPrefs.camZooms) {
							CameraZoomsCheck.animation.play('unch');
							CameraZoomsCheck.animation.finishCallback = function(uncheck:String) { CameraZoomsCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.camZooms = false;
							});
						}
						if (!ClientPrefs.camZooms){
							CameraZoomsCheck.animation.play('ch');
							CameraZoomsCheck.animation.finishCallback = function(check:String) { CameraZoomsCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.camZooms = true;
							});
						}
					case 7:
						if (ClientPrefs.scoreZoom) {
							ScoreZoomCheck.animation.play('unch');
							ScoreZoomCheck.animation.finishCallback = function(uncheck:String) { ScoreZoomCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.scoreZoom = false;
							});
						}
						if (!ClientPrefs.scoreZoom){
							ScoreZoomCheck.animation.play('ch');
							ScoreZoomCheck.animation.finishCallback = function(check:String) { ScoreZoomCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.scoreZoom = true;
							});
						}
					case 8:
						if (ClientPrefs.healthBarAlpha == 1) {
							HPTranspValue.text = '75';
							new FlxTimer().start(0.02, function(eh:FlxTimer) {
								ClientPrefs.healthBarAlpha = 0.75;
							});
						}
						if (ClientPrefs.healthBarAlpha == 0.75) {
							HPTranspValue.text = '50';
							new FlxTimer().start(0.02, function(eheh:FlxTimer) {
								ClientPrefs.healthBarAlpha = 0.5;
							});
						}
						if (ClientPrefs.healthBarAlpha == 0.5) {
							HPTranspValue.text = '25';
							new FlxTimer().start(0.02, function(eheheh:FlxTimer) {
								ClientPrefs.healthBarAlpha = 0.25;
							});
						}
						if (ClientPrefs.healthBarAlpha == 0.25) {
							HPTranspValue.text = '0';
							new FlxTimer().start(0.02, function(eheheheh:FlxTimer) {
								ClientPrefs.healthBarAlpha = 0;
							});
						}
						if (ClientPrefs.healthBarAlpha == 0) {
							HPTranspValue.text = '100';
							new FlxTimer().start(0.02, function(eheheheheh:FlxTimer) {
								ClientPrefs.healthBarAlpha = 1;
							});
						}
					case 9:
						#if !mobile
						if (ClientPrefs.showFPS) {
							FPSCounterCheck.animation.play('unch');
							FPSCounterCheck.animation.finishCallback = function(uncheck:String) { FPSCounterCheck.animation.play('unchecked'); }
							new FlxTimer().start(0.05, function(off:FlxTimer) {
								ClientPrefs.showFPS = false;
							});
							if(Main.fpsVar != null) Main.fpsVar.visible = false;
						}
						if (!ClientPrefs.showFPS){
							FPSCounterCheck.animation.play('ch');
							FPSCounterCheck.animation.finishCallback = function(check:String) { FPSCounterCheck.animation.play('idle-c'); }
							new FlxTimer().start(0.05, function(on:FlxTimer) {
								ClientPrefs.showFPS = true;
							});
							if(Main.fpsVar != null) Main.fpsVar.visible = true;
						}
						#end
				}
			}
		}
	}
}