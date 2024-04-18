package extras;

#if desktop
import Discord.DiscordClient;
#end
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
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
import Song.SwagSong;
import Section.SwagSection;
import flixel.FlxCamera;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import openfl.display.Shader;
import shaders.BunchOfShittyShaders;

using StringTools;

class DefaultBFSkinsState extends MusicBeatState
{
	var Txt:FlxText;
	var blackScreen:FlxSprite;
	
	var Skins:FlxSprite;
	var ArrowL:FlxSprite;
	var ArrowR:FlxSprite;
	var BFDef:FlxSprite;
	var BFEnc:FlxSprite;
	var BFHog:FlxSprite;
	var BFFem:FlxSprite;
	var Merphi:FlxSprite;
	var MerphiChaos:FlxSprite;
	
	var Locked:FlxSprite;
	var LockedBox:FlxSprite;
	var LockedTxt:FlxText;
	
	var VersionTxt:FlxText;
	var VersionBox:FlxSprite;
	var ArrowU:FlxSprite;
	var ArrowD:FlxSprite;
	
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	
	private static var curSelected:Int = 0;
	private static var VercurSelected:Int = 0;
	
	var CanPress:Bool = true;
	var MerphiBool:Bool = true;
	
	var boom:Array<Int> = [0,1,2,3,4];
	var shiftMult:Int = 1;
	var holdTime:Float = 0;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu (BF Skins)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-bf-skins';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		curSelected = ClientPrefs.BFSkin;
		VercurSelected = ClientPrefs.BFVerSkin;
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.setFilters(filters);
		camGame.filtersEnabled = true;
		camGame.zoom = 0.85;
		
		if (ClientPrefs.Shaders) {
			filters.push(ExtrasVCRHandler.vcr);
			//filters.push(ExtrasScanlineHandler.scanline);
			ExtrasVCRHandler.vcrSet(0, true, true, true);
		}
		
		Skins = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF'));
		Skins.antialiasing = ClientPrefs.globalAntialiasing;
		Skins.scrollFactor.set();
		add(Skins);
		
		ArrowL = new FlxSprite(368, 636).loadGraphic(Paths.image('extra/skins/SelArrowL'));
		ArrowL.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowL.scrollFactor.set();
		ArrowL.alpha = 0;
		add(ArrowL);
		
		ArrowR = new FlxSprite(863, 636).loadGraphic(Paths.image('extra/skins/SelArrowR'));
		ArrowR.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowR.scrollFactor.set();
		add(ArrowR);
		
		BFDef = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF/Default'));
		BFDef.antialiasing = ClientPrefs.globalAntialiasing;
		BFDef.scrollFactor.set();
		add(BFDef);
		
		BFEnc = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF/Encore'));
		BFEnc.antialiasing = ClientPrefs.globalAntialiasing;
		BFEnc.scrollFactor.set();
		add(BFEnc);
		
		BFHog = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF/Hog'));
		BFHog.antialiasing = ClientPrefs.globalAntialiasing;
		BFHog.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('manual-blast')) {
			BFHog.color = 0xFF161616;
		}
		add(BFHog);
		
		BFFem = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF/Fem'));
		BFFem.antialiasing = ClientPrefs.globalAntialiasing;
		BFFem.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('extricate-hex')) {
			BFFem.color = 0xFF161616;
		}
		add(BFFem);
		
		Merphi = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF/Merphi'));
		Merphi.antialiasing = ClientPrefs.globalAntialiasing;
		Merphi.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('animosity') || !ClientPrefs.SongsCompleted.contains('reunion')) {
			Merphi.color = 0xFF161616;
		}
		add(Merphi);
		
		MerphiChaos = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/BF/Merphi-Chaos'));
		MerphiChaos.antialiasing = ClientPrefs.globalAntialiasing;
		MerphiChaos.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('animosity') || !ClientPrefs.SongsCompleted.contains('reunion')) {
			MerphiChaos.color = 0xFF161616;
		}
		add(MerphiChaos);
		
		Locked = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Locked'));
		Locked.antialiasing = ClientPrefs.globalAntialiasing;
		Locked.scrollFactor.set();
		add(Locked);
		
		LockedBox = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Locked_BoxText'));
		LockedBox.antialiasing = ClientPrefs.globalAntialiasing;
		LockedBox.scrollFactor.set();
		add(LockedBox);
		
		LockedTxt = new FlxText(0, 545, FlxG.width, '');
		LockedTxt.setFormat(Paths.font("orange-kid.ttf"), 40, 0xFFFFFFFF, CENTER);
		LockedTxt.scrollFactor.set();
		
		Txt = new FlxText(0, 625, FlxG.width, '');
		Txt.setFormat(Paths.font("orange-kid.ttf"), 75, 0xFFFFFFFF, CENTER);
		Txt.scrollFactor.set();
		
		VersionTxt = new FlxText(465, 545, FlxG.width, '');
		VersionTxt.setFormat(Paths.font("orange-kid.ttf"), 75, 0xFFFFFFFF, CENTER);
		VersionTxt.scrollFactor.set();
		
		VersionBox = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Version_BoxText'));
		VersionBox.antialiasing = ClientPrefs.globalAntialiasing;
		VersionBox.scrollFactor.set();
		add(VersionBox);
		
		ArrowU = new FlxSprite(1068, 489).loadGraphic(Paths.image('extra/skins/SelArrowU'));
		ArrowU.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowU.scrollFactor.set();
		add(ArrowU);
		
		ArrowD = new FlxSprite(1068, 655).loadGraphic(Paths.image('extra/skins/SelArrowD'));
		ArrowD.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowD.scrollFactor.set();
		add(ArrowD);

		add(VersionTxt);
		add(LockedTxt);
		add(Txt);
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);
		
		FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {});
		
		Select(curSelected, false);
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		if ((controls.BACK || FlxG.mouse.justPressedRight) && CanPress)
		{
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			ClientPrefs.saveSettings();
			FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new SkinsState());
			});
			
			CanPress = false;
		}
		
		if(FlxG.keys.pressed.SHIFT) {
			shiftMult = 3;
		} else {
			shiftMult = 1;
		}
		
		if (curSelected == 4)
			MerphiBool = true;
		else
			MerphiBool = false;
		
		if (CanPress) {
			if (controls.UI_LEFT_P || (FlxG.mouse.overlaps(ArrowL) && FlxG.mouse.justReleased))
			{
				Select(-shiftMult,true,'left');
				holdTime = 0;
			}
			if (controls.UI_RIGHT_P || (FlxG.mouse.overlaps(ArrowR) && FlxG.mouse.justReleased))
			{
				Select(shiftMult,true,'right');
				holdTime = 0;
			}
			if (controls.UI_RIGHT || controls.UI_LEFT)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					if (controls.UI_LEFT) Select((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult),true,'left');
					if (controls.UI_RIGHT) Select((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult),true,'right');
				}
			}
			if (FlxG.mouse.wheel != 0)
			{
				if (FlxG.mouse.wheel > 0) Select(shiftMult * FlxG.mouse.wheel,true,'right');
				if (FlxG.mouse.wheel < 0) Select(shiftMult * FlxG.mouse.wheel,true,'left');
				holdTime = 0;
			}
			
			if (MerphiBool) {
				if ((controls.UI_DOWN_P || (FlxG.mouse.overlaps(ArrowD) && FlxG.mouse.justReleased)) && VercurSelected == 0)
				{
					Select(0,true,'down');
					holdTime = 0;
				}
				if ((controls.UI_UP_P || (FlxG.mouse.overlaps(ArrowU) && FlxG.mouse.justReleased)) && VercurSelected == 1)
				{
					Select(0,true,'up');
					holdTime = 0;
				}
			}
		}
	}
	
	function Select(oaoao:Int = 0, ?PlayTick:Bool = true, ?pressed:String = '') {
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		if (!MerphiBool) {
			curSelected += oaoao;
		} else {
			if (curSelected == 4) {
				if (pressed == 'left') {
					curSelected = 3;
				}
				if (VercurSelected == 0) {
					if (pressed == 'down') {
						VercurSelected = 1;
					}
				}
				if (VercurSelected == 1) {
					if (pressed == 'up') {
						VercurSelected = 0;
					}
				}
			}
		}
		if (!MerphiBool) {
			if (curSelected < 0)
				curSelected = 0;
			if (curSelected > 4)
				curSelected = 4;
		}
		
		ArrowL.alpha = 0;
		ArrowR.alpha = 0;
		BFDef.alpha = 0;
		BFEnc.alpha = 0;
		BFHog.alpha = 0;
		BFFem.alpha = 0;
		Merphi.alpha = 0;
		MerphiChaos.alpha = 0;
		Locked.alpha = 0;
		LockedBox.alpha = 0;
		LockedTxt.alpha = 0;
		VersionTxt.alpha = 0;
		VersionBox.alpha = 0;
		ArrowU.alpha = 0;
		ArrowD.alpha = 0;
		
		switch(curSelected) {
			case 0:
				ClientPrefs.BFSkin = 0;
				Txt.text = 'Classic BF';
				VersionTxt.text = '';
				ArrowR.alpha = 1;
				BFDef.alpha = 1;
				ClientPrefs.saveSettings();
			case 1:
				ClientPrefs.BFSkin = 1;
				Txt.text = 'Encore BF';
				VersionTxt.text = '';
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				BFEnc.alpha = 1;
				ClientPrefs.saveSettings();
			case 2:
				if (ClientPrefs.SongsCompleted.contains('manual-blast')) {
					ClientPrefs.BFSkin = 2;
					Txt.text = 'Hog BF';
					VersionTxt.text = '';
				} else {
					Txt.text = 'Locked';
					VersionTxt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Manual Blast to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				BFHog.alpha = 1;
				ClientPrefs.saveSettings();
			case 3:
				if (ClientPrefs.SongsCompleted.contains('extricate-hex')) {
					ClientPrefs.BFSkin = 3;
					Txt.text = 'Fem BF';
					VersionTxt.text = '';
				} else {
					Txt.text = 'Locked';
					VersionTxt.text = 'Locked';
					
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Extricate Hex to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				BFFem.alpha = 1;
				ClientPrefs.saveSettings();
			case 4:
				if (VercurSelected == 0) {
					if (ClientPrefs.SongsCompleted.contains('animosity') && ClientPrefs.SongsCompleted.contains('reunion')) {
						ClientPrefs.BFVerSkin = 0;
						ClientPrefs.BFSkin = 4;
						Txt.text = 'Merphi';
						VersionTxt.text = 'Classic';
					} else {
						Txt.text = 'Locked';
						VersionTxt.text = 'Locked';
						
						Locked.alpha = 1;
						LockedBox.alpha = 1;
						LockedTxt.alpha = 1;
						LockedTxt.text = 'Beat Futagami to unlock';
					}
					ArrowL.alpha = 1;
					Merphi.alpha = 1;
					VersionTxt.alpha = 1;
					VersionBox.alpha = 1;
					ArrowD.alpha = 1;
					ClientPrefs.saveSettings();
				}
				
				if (VercurSelected == 1) {
					if (ClientPrefs.SongsCompleted.contains('animosity') && ClientPrefs.SongsCompleted.contains('reunion')) {
						ClientPrefs.BFVerSkin = 1;
						ClientPrefs.BFSkin = 4;
						Txt.text = 'Merphi';
						VersionTxt.text = 'Chaos';
					} else {
						Txt.text = 'Locked';
						VersionTxt.text = 'Locked';
						Locked.alpha = 1;
						LockedBox.alpha = 1;
						LockedTxt.alpha = 1;
						LockedTxt.text = 'Beat Futagami to unlock';
					}
					ArrowL.alpha = 1;
					MerphiChaos.alpha = 1;
					VersionTxt.alpha = 1;
					VersionBox.alpha = 1;
					ArrowU.alpha = 1;
					ClientPrefs.saveSettings();
				}
		}
		if (TranslationLanguages.Text.exists(Txt.text) && ClientPrefs.Language != 'English')
			Txt.text = TranslationLanguages.Text[Txt.text];
		if (TranslationLanguages.Text.exists(VersionTxt.text) && ClientPrefs.Language != 'English')
			VersionTxt.text = TranslationLanguages.Text[VersionTxt.text];
		if (TranslationLanguages.Text.exists(LockedTxt.text) && ClientPrefs.Language != 'English')
			LockedTxt.text = TranslationLanguages.Text[LockedTxt.text];
	}
}