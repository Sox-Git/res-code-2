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

class SkinsState extends MusicBeatState
{
	var Skins:FlxSprite;
	var DefBF:FlxSprite;
	var DefGF:FlxSprite;
	var EncBF:FlxSprite;
	var EncGF:FlxSprite;
	var DefBFSel:FlxSprite;
	var DefGFSel:FlxSprite;
	var EncBFSel:FlxSprite;
	var EncGFSel:FlxSprite;
	var blackScreen:FlxSprite;
	var hitboxOne:FlxSprite;
	var hitboxTwo:FlxSprite;
	
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	
	var CanPress:Bool = true;
	
	private static var curSelected:Int = 0;
	var abababbababa:Array<Int> = [0,1];
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu (Skins)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-skins';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
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
		
		Skins = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/skins-without-encore'));
		Skins.antialiasing = ClientPrefs.globalAntialiasing;
		Skins.scrollFactor.set();
		add(Skins);
		
		//Skins
		
		DefBF = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Choice/DBF'));
		DefBF.antialiasing = ClientPrefs.globalAntialiasing;
		DefBF.scrollFactor.set();
		add(DefBF);
		
		DefGF = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Choice/DGF'));
		DefGF.antialiasing = ClientPrefs.globalAntialiasing;
		DefGF.scrollFactor.set();
		add(DefGF);
		
		/*
		EncBF = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Choice/EBF'));
		EncBF.antialiasing = ClientPrefs.globalAntialiasing;
		EncBF.scrollFactor.set();
		add(EncBF);
		
		EncGF = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/Choice/EGF'));
		EncGF.antialiasing = ClientPrefs.globalAntialiasing;
		EncGF.scrollFactor.set();
		add(EncGF);
		*/
		
		// Selected Skins
		
		DefBFSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/SelectedChoice/DBF'));
		DefBFSel.antialiasing = ClientPrefs.globalAntialiasing;
		DefBFSel.scrollFactor.set();
		add(DefBFSel);
		
		DefGFSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/SelectedChoice/DGF'));
		DefGFSel.antialiasing = ClientPrefs.globalAntialiasing;
		DefGFSel.scrollFactor.set();
		add(DefGFSel);
		
		/*
		EncBFSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/SelectedChoice/EBF'));
		EncBFSel.antialiasing = ClientPrefs.globalAntialiasing;
		EncBFSel.scrollFactor.set();
		add(EncBFSel);
		
		EncGFSel = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/skins/SelectedChoice/EGF'));
		EncGFSel.antialiasing = ClientPrefs.globalAntialiasing;
		EncGFSel.scrollFactor.set();
		add(EncGFSel);
		*/
		
		hitboxOne = new FlxSprite(345,165).makeGraphic(557, 81, 0x00000000);
		add(hitboxOne);
		hitboxTwo = new FlxSprite(345,254).makeGraphic(557, 81, 0x00000000);
		add(hitboxTwo);
		
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
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new ExtrasState());
			});
			CanPress = false;
		}
		
		if (CanPress) {
			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			if (!FlxG.mouse.overlaps(hitboxOne) || !FlxG.mouse.overlaps(hitboxTwo)) {
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
		}
		if (FlxG.mouse.overlaps(hitboxOne) && curSelected != 0) Select(0, true, true);
		if (FlxG.mouse.overlaps(hitboxTwo) && curSelected != 1) Select(1, true, true);
		if (CanPress) {
			if (controls.ACCEPT || ((FlxG.mouse.overlaps(hitboxOne) || FlxG.mouse.overlaps(hitboxTwo)) && FlxG.mouse.justReleased)) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
				switch(curSelected) {
					case 0:
						new FlxTimer().start(1, function(tmr:FlxTimer) {
							FlxG.switchState(new DefaultBFSkinsState());
						});
						CanPress = false;
					case 1:
						new FlxTimer().start(1, function(tmr:FlxTimer) {
							FlxG.switchState(new DefaultGFSkinsState());
						});
						CanPress = false;
				}
			}
		}
	}
	
	
	function Select(oaoao:Int = 0, ?PlayTick:Bool = true, ?mouse:Bool = false) {
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		if (!mouse) {
			curSelected += oaoao;
			if (curSelected >= abababbababa.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = abababbababa.length - 1;
		} else {
			curSelected = oaoao;
		}
		
		switch (curSelected) {
			case 0:
				DefBF.alpha = 0;
				DefGF.alpha = 1;
				DefBFSel.alpha = 1;
				DefGFSel.alpha = 0;
			case 1:
				DefBF.alpha = 1;
				DefGF.alpha = 0;
				DefBFSel.alpha = 0;
				DefGFSel.alpha = 1;
		}
	}
}