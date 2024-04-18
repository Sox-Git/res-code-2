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

class ExtrasState extends MusicBeatState
{
	var Extras:FlxSprite;
	var ExtrasWG:FlxSprite;
	var blackScreen:FlxSprite;
	
	var Skins:FlxSprite;
	var ExtraSongs:FlxSprite;
	var Gallery:FlxSprite;
	var Debug:FlxSprite;
	var DebugWG:FlxSprite;
	
	var SkinsSel:FlxSprite;
	var BFEncoreSkinsSel:FlxSprite;
	var ExtraSongsSel:FlxSprite;
	var GallerySel:FlxSprite;
	var DebugSel:FlxSprite;
	var DebugWGSel:FlxSprite;
	
	private var camGame:FlxCamera;
	var shaderO:ShaderFilter;
	var shaderT:ShaderFilter;
	
	var WithGallery:Bool = true;
	var CanPress:Bool = true;
	
	private static var curSelected:Int = 0;
	var boomGallery:Array<Int> = [0,1,2,3];
	var boom:Array<Int> = [0,1,2];
	
	var hitboxOne:FlxSprite;
	var hitboxTwo:FlxSprite;
	var hitboxThree:FlxSprite;
	var hitboxFour:FlxSprite;

	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		FlxG.sound.playMusic(Paths.music('extras'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.filtersEnabled = true;
		camGame.zoom = 0.85;
		if (ClientPrefs.Shaders) {
			shaderO = ExtrasVCRHandler.vcr;
			//shaderT = ExtrasScanlineHandler.scanline;
			ExtrasVCRHandler.vcrSet(0.5, false, true, true);
			camGame.setFilters([shaderO]);
		}
		
		Extras = new FlxSprite(337, 35).loadGraphic(Paths.image('extra/extras/Extras'));
		Extras.antialiasing = ClientPrefs.globalAntialiasing;
		Extras.scrollFactor.set();
		
		ExtrasWG = new FlxSprite(337, 35).loadGraphic(Paths.image('extra/extras/ExtrasWG'));
		ExtrasWG.antialiasing = ClientPrefs.globalAntialiasing;
		ExtrasWG.scrollFactor.set();
		
		if (WithGallery) {
			add(Extras);
		} else {
			add(ExtrasWG);
		}
		
		Skins = new FlxSprite(362, 180).loadGraphic(Paths.image('extra/extras/Choice/Skins'));
		Skins.antialiasing = ClientPrefs.globalAntialiasing;
		Skins.scrollFactor.set();
		Skins.alpha = 0;
		add(Skins);
		
		ExtraSongs = new FlxSprite(362, 269).loadGraphic(Paths.image('extra/extras/Choice/Songs'));
		ExtraSongs.antialiasing = ClientPrefs.globalAntialiasing;
		ExtraSongs.scrollFactor.set();
		ExtraSongs.alpha = 1;
		add(ExtraSongs);
		
		Gallery = new FlxSprite(362, 358).loadGraphic(Paths.image('extra/extras/Choice/Gallery'));
		Gallery.antialiasing = ClientPrefs.globalAntialiasing;
		Gallery.scrollFactor.set();
		Gallery.alpha = 1;
		
		Debug = new FlxSprite(362, 447).loadGraphic(Paths.image('extra/extras/Choice/Debug'));
		Debug.antialiasing = ClientPrefs.globalAntialiasing;
		Debug.scrollFactor.set();
		Debug.alpha = 1;
		
		DebugWG = new FlxSprite(362, 358).loadGraphic(Paths.image('extra/extras/Choice/Debug'));
		DebugWG.antialiasing = ClientPrefs.globalAntialiasing;
		DebugWG.scrollFactor.set();
		DebugWG.alpha = 1;
		
		if (WithGallery) {
			add(Gallery);
			add(Debug);
		} else {
			add(DebugWG);
		}
		
		SkinsSel = new FlxSprite(277, 170).loadGraphic(Paths.image('extra/extras/SelectedChoice/Skins'));
		SkinsSel.antialiasing = ClientPrefs.globalAntialiasing;
		SkinsSel.scrollFactor.set();
		SkinsSel.alpha = 1;
		add(SkinsSel);
		
		ExtraSongsSel = new FlxSprite(277, 259).loadGraphic(Paths.image('extra/extras/SelectedChoice/Songs'));
		ExtraSongsSel.antialiasing = ClientPrefs.globalAntialiasing;
		ExtraSongsSel.scrollFactor.set();
		ExtraSongsSel.alpha = 0;
		add(ExtraSongsSel);
		
		GallerySel = new FlxSprite(277, 348).loadGraphic(Paths.image('extra/extras/SelectedChoice/Gallery'));
		GallerySel.antialiasing = ClientPrefs.globalAntialiasing;
		GallerySel.scrollFactor.set();
		GallerySel.alpha = 0;
		
		DebugSel = new FlxSprite(277, 437).loadGraphic(Paths.image('extra/extras/SelectedChoice/Debug'));
		DebugSel.antialiasing = ClientPrefs.globalAntialiasing;
		DebugSel.scrollFactor.set();
		DebugSel.alpha = 0;
		
		DebugWGSel = new FlxSprite(277, 348).loadGraphic(Paths.image('extra/extras/SelectedChoice/Debug'));
		DebugWGSel.antialiasing = ClientPrefs.globalAntialiasing;
		DebugWGSel.scrollFactor.set();
		DebugWGSel.alpha = 0;
		
		hitboxOne = new FlxSprite(345,165).makeGraphic(557, 81, 0x00000000);
		add(hitboxOne);
		hitboxTwo = new FlxSprite(345,254).makeGraphic(557, 81, 0x00000000);
		add(hitboxTwo);
		hitboxThree = new FlxSprite(345,343).makeGraphic(557, 81, 0x00000000);
		add(hitboxThree);
		hitboxFour = new FlxSprite(345,432).makeGraphic(557, 81, 0x00000000);
		add(hitboxFour);
		
		if (WithGallery) {
			add(GallerySel);
			add(DebugSel);
		} else {
			add(DebugWGSel);
		}
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);
		
		FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {});
		
		Select(curSelected, false);
		super.create();
	}
	
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if ((controls.BACK || FlxG.mouse.justPressedRight) && CanPress)
		{
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
			FlxG.sound.music.fadeOut(0.5, 0);
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new MainMenuState());
			});
			CanPress = false;
		}
		
		if (CanPress) {
			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			if (!FlxG.mouse.overlaps(hitboxOne) && !FlxG.mouse.overlaps(hitboxTwo) && !FlxG.mouse.overlaps(hitboxThree) && !FlxG.mouse.overlaps(hitboxThree) && !FlxG.mouse.overlaps(hitboxFour)) {
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
			} 
			if (FlxG.mouse.overlaps(hitboxOne) && curSelected != 0) Select(0, true, true);
			if (FlxG.mouse.overlaps(hitboxTwo) && curSelected != 1) Select(1, true, true);
			if (FlxG.mouse.overlaps(hitboxThree) && curSelected != 2 && WithGallery) Select(2, true, true);
			if (FlxG.mouse.overlaps(hitboxThree) && curSelected != 2 && !WithGallery) Select(2, true, true);
			if (FlxG.mouse.overlaps(hitboxFour) && curSelected != 3 && WithGallery) Select(3, true, true);
		}
		
		if (CanPress) {
			if (controls.ACCEPT || ((FlxG.mouse.overlaps(hitboxOne) || FlxG.mouse.overlaps(hitboxTwo) || (FlxG.mouse.overlaps(hitboxThree) && WithGallery) || (FlxG.mouse.overlaps(hitboxThree) && !WithGallery) || (FlxG.mouse.overlaps(hitboxFour) && WithGallery)) && FlxG.mouse.justReleased)) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
				switch(curSelected) {
					case 0:
						new FlxTimer().start(1, function(tmr:FlxTimer) {
							FlxG.switchState(new SkinsState());
						});
						CanPress = false;
					case 1:
						new FlxTimer().start(1, function(tmr:FlxTimer) {
							FlxG.switchState(new ExtraSongsState());
						});
						CanPress = false;
					case 2:
						if (WithGallery) {
							new FlxTimer().start(1, function(tmr:FlxTimer) {
								FlxG.switchState(new GalleryState());
							});
							CanPress = false;
						} else {
							new FlxTimer().start(1, function(tmr:FlxTimer) {
								FlxG.switchState(new DebugState());
							});
							CanPress = false;
						}
					case 3:
						if (WithGallery) {
							new FlxTimer().start(1, function(tmr:FlxTimer) {
								FlxG.switchState(new DebugState());
							});
							CanPress = false;
						}
				}
			}
		}
	}
	
	function Select(oaoao:Int = 0, ?PlayTick:Bool = true, ?mouse:Bool = false) {
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		if (!mouse) {
			if (WithGallery) {
				curSelected += oaoao;
				if (curSelected >= boomGallery.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = boomGallery.length - 1;
			} else {
				curSelected += oaoao;
				if (curSelected >= boom.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = boom.length - 1;
			}
		} else {
			curSelected = oaoao;
		}
	
		switch(curSelected) {
			case 0:
				Skins.alpha = 0;
				ExtraSongs.alpha = 1;
				Gallery.alpha = 1;
				Debug.alpha = 1;
				DebugWG.alpha = 1;
				
				SkinsSel.alpha = 1;
				ExtraSongsSel.alpha = 0;
				GallerySel.alpha = 0;
				DebugSel.alpha = 0;
				DebugWGSel.alpha = 0;
			case 1:
				Skins.alpha = 1;
				ExtraSongs.alpha = 0;
				Gallery.alpha = 1;
				Debug.alpha = 1;
				DebugWG.alpha = 1;
				
				SkinsSel.alpha = 0;
				ExtraSongsSel.alpha = 1;
				GallerySel.alpha = 0;
				DebugSel.alpha = 0;
				DebugWGSel.alpha = 0;
			case 2:
				if (WithGallery) {
					Skins.alpha = 1;
					ExtraSongs.alpha = 1;
					Gallery.alpha = 0;
					Debug.alpha = 1;
					DebugWG.alpha = 1;
					
					SkinsSel.alpha = 0;
					ExtraSongsSel.alpha = 0;
					GallerySel.alpha = 1;
					DebugSel.alpha = 0;
					DebugWGSel.alpha = 0;
				} else {
					Skins.alpha = 1;
					ExtraSongs.alpha = 1;
					Gallery.alpha = 1;
					Debug.alpha = 1;
					DebugWG.alpha = 0;
					
					SkinsSel.alpha = 0;
					ExtraSongsSel.alpha = 0;
					GallerySel.alpha = 0;
					DebugSel.alpha = 0;
					DebugWGSel.alpha = 1;
				}
			case 3:
				if (WithGallery) {
					Skins.alpha = 1;
					ExtraSongs.alpha = 1;
					Gallery.alpha = 1;
					Debug.alpha = 0;
					DebugWG.alpha = 1;
					
					SkinsSel.alpha = 0;
					ExtraSongsSel.alpha = 0;
					GallerySel.alpha = 0;
					DebugSel.alpha = 1;
					DebugWGSel.alpha = 0;
			}
		}
	}
}