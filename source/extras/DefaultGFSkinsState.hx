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

class DefaultGFSkinsState extends MusicBeatState
{
	var Txt:FlxText;
	var blackScreen:FlxSprite;
	
	var Skins:FlxSprite;
	var ArrowL:FlxSprite;
	var ArrowR:FlxSprite;
	var GFDefault:FlxSprite;
	var GFEncore:FlxSprite;
	var GFHogged:FlxSprite;
	var GFLobster:FlxSprite;
	var GFSus:FlxSprite;
	var GFFaker:FlxSprite;
	var GFFatal:FlxSprite;
	var GFCat:FlxSprite;
	var GFRouge:FlxSprite;
	var GFHyper:FlxSprite;
	var GFSarah:FlxSprite;
	var GFHog:FlxSprite;
	var GFSunky:FlxSprite;
	var DJEXE:FlxSprite;
	var GFHogg:FlxSprite;
	
	var Locked:FlxSprite;
	var LockedBox:FlxSprite;
	var LockedTxt:FlxText;
	
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	
	private static var curSelected:Int = 0;
	var CanPress:Bool = true;
	var shiftMult:Int = 1;
	var holdTime:Float = 0;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu (GF Skins)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-gf-skins';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		curSelected = ClientPrefs.GFSkin;
		
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
		
		Skins = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF'));
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
		
		GFDefault = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Default'));
		GFDefault.antialiasing = ClientPrefs.globalAntialiasing;
		GFDefault.scrollFactor.set();
		add(GFDefault);
		
		GFEncore = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Encore'));
		GFEncore.antialiasing = ClientPrefs.globalAntialiasing;
		GFEncore.scrollFactor.set();
		add(GFEncore);
		
		GFHogged = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Hog'));
		GFHogged.antialiasing = ClientPrefs.globalAntialiasing;
		GFHogged.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('manual-blast')) {
			GFHogged.color = 0xFF161616;
		}
		add(GFHogged);
		
		GFLobster = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Lobster'));
		GFLobster.antialiasing = ClientPrefs.globalAntialiasing;
		GFLobster.scrollFactor.set();
		add(GFLobster);
		
		GFSus = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Sus'));
		GFSus.antialiasing = ClientPrefs.globalAntialiasing;
		GFSus.scrollFactor.set();
		add(GFSus);
		
		GFFaker = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Faker'));
		GFFaker.antialiasing = ClientPrefs.globalAntialiasing;
		GFFaker.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('faker-encore')) {
			GFFaker.color = 0xFF161616;
		}
		add(GFFaker);
		
		GFFatal = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Error'));
		GFFatal.antialiasing = ClientPrefs.globalAntialiasing;
		GFFatal.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('fatality-encore')) {
			GFFatal.color = 0xFF161616;
		}
		add(GFFatal);
		
		GFCat = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Cat'));
		GFCat.antialiasing = ClientPrefs.globalAntialiasing;
		GFCat.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('faker')) {
			GFCat.color = 0xFF161616;
		}
		add(GFCat);
		
		GFRouge = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Rouge'));
		GFRouge.antialiasing = ClientPrefs.globalAntialiasing;
		GFRouge.scrollFactor.set();
		add(GFRouge);
		
		GFHyper = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Hyper'));
		GFHyper.antialiasing = ClientPrefs.globalAntialiasing;
		GFHyper.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('malediction')) {
			GFHyper.color = 0xFF161616;
		}
		add(GFHyper);
		
		GFSarah = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Sarah'));
		GFSarah.antialiasing = ClientPrefs.globalAntialiasing;
		GFSarah.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('round-a-bout')) {
			GFSarah.color = 0xFF161616;
		}
		add(GFSarah);
		
		GFHog = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Hogged'));
		GFHog.antialiasing = ClientPrefs.globalAntialiasing;
		GFHog.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('hedge')) {
			GFHog.color = 0xFF161616;
		}
		add(GFHog);
		
		GFSunky = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Sunky'));
		GFSunky.antialiasing = ClientPrefs.globalAntialiasing;
		GFSunky.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('old-ycr-slaps')) {
			GFSunky.color = 0xFF161616;
		}
		add(GFSunky);
		
		DJEXE = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Dj'));
		DJEXE.antialiasing = ClientPrefs.globalAntialiasing;
		DJEXE.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('too-slow-encore') || !ClientPrefs.SongsCompleted.contains('you-cant-run-encore') || !ClientPrefs.SongsCompleted.contains('triple-trouble-encore')) {
			DJEXE.color = 0xFF161616;
		}
		add(DJEXE);
		
		GFHogg = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/GF/Hogg'));
		GFHogg.antialiasing = ClientPrefs.globalAntialiasing;
		GFHogg.scrollFactor.set();
		if (!ClientPrefs.SongsCompleted.contains('hedge')) {
			GFHogg.color = 0xFF161616;
		}
		add(GFHogg);
		
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
		}
	}
	
	function Select(oaoao:Int = 0, ?PlayTick:Bool = true, ?pressed:String = '') {
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		curSelected += oaoao;
		
		if (curSelected < 0)
			curSelected = 0;
		if (curSelected > 14)
			curSelected = 14;
		
		ArrowL.alpha = 0;
		ArrowR.alpha = 0;
		GFDefault.alpha = 0;
		GFEncore.alpha = 0;
		GFHogged.alpha = 0;
		GFLobster.alpha = 0;
		GFSus.alpha = 0;
		GFFaker.alpha = 0;
		GFFatal.alpha = 0;
		GFCat.alpha = 0;
		GFRouge.alpha = 0;
		GFHyper.alpha = 0;
		GFSarah.alpha = 0;
		GFHog.alpha = 0;
		GFSunky.alpha = 0;
		DJEXE.alpha = 0;
		GFHogg.alpha = 0;
		Locked.alpha = 0;
		LockedBox.alpha = 0;
		LockedTxt.alpha = 0;
		
		switch(curSelected) {
			case 0:
				ClientPrefs.GFSkin = 0;
				Txt.text = 'Classic GF';
				ArrowR.alpha = 1;
				GFDefault.alpha = 1;
				ClientPrefs.saveSettings();
			case 1:
				ClientPrefs.GFSkin = 1;
				Txt.text = 'Encore GF';
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFEncore.alpha = 1;
				ClientPrefs.saveSettings();
			case 2:
				if (ClientPrefs.SongsCompleted.contains('manual-blast')) {
					ClientPrefs.GFSkin = 2;
					Txt.text = 'Hog GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Manual Blast to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFHogged.alpha = 1;
				ClientPrefs.saveSettings();
			case 3:
				ClientPrefs.GFSkin = 3;
				Txt.text = 'Lobster GF';
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFLobster.alpha = 1;
				ClientPrefs.saveSettings();
			case 4:
				ClientPrefs.GFSkin = 4;
				Txt.text = 'Sus GF';
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFSus.alpha = 1;
				ClientPrefs.saveSettings();
			case 5:
				if (ClientPrefs.SongsCompleted.contains('faker-encore')) {
					ClientPrefs.GFSkin = 5;
					Txt.text = 'Faker GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Faker Encore to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFFaker.alpha = 1;
				ClientPrefs.saveSettings();
			case 6:
				if (ClientPrefs.SongsCompleted.contains('fatality-encore')) {
					ClientPrefs.GFSkin = 6;
					Txt.text = 'Fatal GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Fatality Encore to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFFatal.alpha = 1;
				ClientPrefs.saveSettings();
			case 7:
				if (ClientPrefs.SongsCompleted.contains('faker')) {
					ClientPrefs.GFSkin = 7;
					Txt.text = 'Cat GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Faker to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFCat.alpha = 1;
				ClientPrefs.saveSettings();
			case 8:
				ClientPrefs.GFSkin = 8;
				Txt.text = 'Rouge GF';
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFRouge.alpha = 1;
				ClientPrefs.saveSettings();
			case 9:
				if (ClientPrefs.SongsCompleted.contains('malediction')) {
					ClientPrefs.GFSkin = 9;
					Txt.text = 'Hyper GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Malediction to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFHyper.alpha = 1;
				ClientPrefs.saveSettings();
			case 10:
				if (ClientPrefs.SongsCompleted.contains('round-a-bout')) {
					ClientPrefs.GFSkin = 10;
					Txt.text = 'Sarah GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Round A Bout to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFSarah.alpha = 1;
				ClientPrefs.saveSettings();
			case 11:
				if (ClientPrefs.SongsCompleted.contains('hedge')) {
					ClientPrefs.GFSkin = 11;
					Txt.text = 'Hogged GF 1';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Hedge to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFHog.alpha = 1;
				ClientPrefs.saveSettings();
			case 12:
				if (ClientPrefs.SongsCompleted.contains('old-ycr-slaps')) {
					ClientPrefs.GFSkin = 12;
					Txt.text = 'Sunky GF';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat ??? to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				GFSunky.alpha = 1;
				ClientPrefs.saveSettings();
			case 13:
				if (ClientPrefs.SongsCompleted.contains('too-slow-encore') && ClientPrefs.SongsCompleted.contains('you-cant-run-encore') && ClientPrefs.SongsCompleted.contains('triple-trouble-encore')) {
					ClientPrefs.GFSkin = 13;
					Txt.text = 'DJ.EXE';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat EXE Encore Songs to unlock';
				}
				ArrowL.alpha = 1;
				ArrowR.alpha = 1;
				DJEXE.alpha = 1;
				ClientPrefs.saveSettings();
			case 14:
				if (ClientPrefs.SongsCompleted.contains('hedge')) {
					ClientPrefs.GFSkin = 14;
					Txt.text = 'Hogged GF 2';
				} else {
					Txt.text = 'Locked';
					Locked.alpha = 1;
					LockedBox.alpha = 1;
					LockedTxt.alpha = 1;
					LockedTxt.text = 'Beat Hedge to unlock';
				}
				ArrowL.alpha = 1;
				GFHogg.alpha = 1;
				ClientPrefs.saveSettings();
		}
		if (TranslationLanguages.Text.exists(Txt.text) && ClientPrefs.Language != 'English')
			Txt.text = TranslationLanguages.Text[Txt.text];
		if (TranslationLanguages.Text.exists(LockedTxt.text) && ClientPrefs.Language != 'English')
			LockedTxt.text = TranslationLanguages.Text[LockedTxt.text];
	}
}