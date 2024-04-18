package;

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
import Controls;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class GoreWarningSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var Window:FlxSprite;
	var Yes:FlxSprite;
	var No:FlxSprite;
	var YesSel:FlxSprite;
	var NoSel:FlxSprite;
	var shit:FlxSprite;
	var ExitBtn:FlxSprite;
	var GoreWarning:FlxTypedGroup<FlxSprite>;

	var Exit:Bool = true;
	var control:Bool = false;
	var pressed:Bool = false;
	
	var musicFadeOut:Bool = true;
	var whiteflash:Bool = true;
	var time:Float = 2;
	var playSound:Bool = true;
	var flashWorks:Bool = true;
	var state:String = 'freeplay';
	var toState:String = 'playstate';
	
	var cutsceneName:String = 'disabled';
	var MP4FileName:String = '';
	var WaitTime:Float = 0.3;
	var EndState:String = '';
	var songToPlay:String = '';
	var DiscordRPCimg:String = 'icon';
	var DiscordRPCtext:String = 'In Cutscene';
	
	public function new(?flash = true, ?flashwhite:Bool = true, ?musicOut:Bool = true, ?timeshit:Float = 2, ?Sound:Bool = true, ?menu:String = 'freeplay', ?toMenu:String = 'playstate', ?cutsceneName:String = 'disabled', ?MP4FileName:String = '', ?WaitTime:Float = 0.3, ?EndState:String = '', ?songToPlay:String = '', ?DiscordRPCimg:String = 'icon', ?DiscordRPCtext:String = 'In Cutscene')
	{
		super();
		musicFadeOut = musicOut;
		whiteflash = flashwhite;
		time = timeshit;
		playSound = Sound;
		flashWorks = flash;
		state = menu;
		toState = toMenu;
		
		this.cutsceneName = cutsceneName;
		this.MP4FileName = MP4FileName;
		this.WaitTime = WaitTime;
		this.EndState = EndState;
		this.songToPlay = songToPlay;
		this.DiscordRPCimg = DiscordRPCimg;
		this.DiscordRPCtext = DiscordRPCtext;
		
		if (TranslationLanguages.Text.exists(DiscordRPCtext) && ClientPrefs.Language != 'English')
			DiscordRPCtext = TranslationLanguages.Text[DiscordRPCtext];
		
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.65;
		add(bg);
		
		GoreWarning = new FlxTypedGroup<FlxSprite>();
		add(GoreWarning);
		
		Window = new FlxSprite(0, 0).loadGraphic(Paths.image('warnings/gore/window'));
		Window.antialiasing = ClientPrefs.globalAntialiasing;
		Window.scrollFactor.set();
		GoreWarning.add(Window);
		
		Yes = new FlxSprite(167, 486).loadGraphic(Paths.image('warnings/gore/yes'));
		Yes.antialiasing = ClientPrefs.globalAntialiasing;
		Yes.scrollFactor.set();
		GoreWarning.add(Yes);
		
		No = new FlxSprite(965, 486).loadGraphic(Paths.image('warnings/gore/no'));
		No.antialiasing = ClientPrefs.globalAntialiasing;
		No.scrollFactor.set();
		GoreWarning.add(No);
		
		YesSel = new FlxSprite(167, 486).loadGraphic(Paths.image('warnings/gore/yes-sel'));
		YesSel.antialiasing = ClientPrefs.globalAntialiasing;
		YesSel.scrollFactor.set();
		GoreWarning.add(YesSel);
		
		NoSel = new FlxSprite(965, 486).loadGraphic(Paths.image('warnings/gore/no-sel'));
		NoSel.antialiasing = ClientPrefs.globalAntialiasing;
		NoSel.scrollFactor.set();
		GoreWarning.add(NoSel);
		
		ExitBtn = new FlxSprite(97, 50).loadGraphic(Paths.image('exit'));
		ExitBtn.antialiasing = ClientPrefs.globalAntialiasing;
		ExitBtn.scrollFactor.set();
		GoreWarning.add(ExitBtn);
		
		if (whiteflash)
			shit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE); 
		else
			shit = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK); 
		shit.alpha = 0; 
		add(shit);
		
		if (!Exit) {
			Yes.alpha = 0;
			YesSel.alpha = 1;
			No.alpha = 1;
			NoSel.alpha = 0;
		} else {
			Yes.alpha = 1;
			YesSel.alpha = 0;
			No.alpha = 0;
			NoSel.alpha = 1;
		}
		new FlxTimer().start(0.1, function(tmr:FlxTimer) {
			control = true;
		});
		persistentUpdate = true;
		
		#if mobile
		addVirtualPad(LEFT_RIGHT, A_B);
		addVirtualPadCamera();
		#end
	}
	
	override function update(elapsed:Float)
	{
		if (control && !pressed) {
			if ((controls.UI_RIGHT_P #if desktop || FlxG.mouse.overlaps(No) #end) && !Exit) Exit = true;
			if ((controls.UI_LEFT_P #if desktop || FlxG.mouse.overlaps(Yes) #end) && Exit) Exit = false;
			if (controls.BACK || (controls.ACCEPT && Exit) || #if mobile FlxG.android.justReleased.BACK #else (FlxG.mouse.overlaps(No) && FlxG.mouse.justReleased) || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(ExitBtn) && FlxG.mouse.justReleased) #end) {
				GoreWarning.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 0}, 0.22); FlxTween.tween(ok.scale, {x:0.7, y:0.7}, 0.22, { ease: FlxEase.quadInOut}); });
				FlxTween.tween(bg, {alpha: 0}, 0.22, {ease: FlxEase.quadInOut});
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
				switch (state) {
					case 'freeplay': FreeplayState.goreCloseShit = true;
					case 'story': StoryMenuState.GoreBack = true;
					case 'encore': EncoreState.goreCloseShit = true;
					case 'st': SoundTestState.goreCloseShit = true;
				}
				new FlxTimer().start(0.22, function(tmr:FlxTimer) {
					close();
				});
				pressed = true;
				control = false;
			}
			if ((controls.ACCEPT && !Exit) #if desktop || (FlxG.mouse.overlaps(Yes) && FlxG.mouse.justReleased) #end) {
				GoreWarning.forEach(function(ok:FlxSprite) { FlxTween.tween(ok, {alpha: 0}, 0.22); FlxTween.tween(ok.scale, {x:0.7, y:0.7}, 0.22, { ease: FlxEase.quadInOut}); });
				FlxTween.tween(bg, {alpha: 0}, 0.22, {ease: FlxEase.quadInOut});
				new FlxTimer().start(0.22, function(tmr:FlxTimer) {
					if (playSound) FlxG.sound.play(Paths.sound('confirmMenu'));
					if (flashWorks) FlxTween.tween(shit, {alpha: 1}, time - 0.4);
					if (musicFadeOut) FlxG.sound.music.fadeOut(time - 0.5, 0);
					switch (state) {
						case 'story': StoryMenuState.GoreAccept = true;
					}
					new FlxTimer().start(time, function(tmr:FlxTimer) { 
						if (cutsceneName == 'disabled') {
							Main.InPlaystate = true;
							switch (toState) {
								case 'playstate': LoadingState.loadAndSwitchState(new PlayState());
								case 'rosy-mechanic': openSubState(new RosyMechanicSubstate());
							}
						} else {
							MusicBeatState.switchState(new Cutscenes(cutsceneName, MP4FileName, WaitTime, EndState, songToPlay, DiscordRPCimg, DiscordRPCtext));
						}
					});
				});
				pressed = true;
				control = false;
			}
		}
		
		if (!pressed) {
			if (!Exit) {
				Yes.alpha = 0;
				YesSel.alpha = 1;
				No.alpha = 1;
				NoSel.alpha = 0;
			} else {
				Yes.alpha = 1;
				YesSel.alpha = 0;
				No.alpha = 0;
				NoSel.alpha = 1;
			}
		}
		super.update(elapsed);
	}
}
