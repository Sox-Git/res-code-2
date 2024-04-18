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
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

using StringTools;

class TrophiesSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var TrophiesTxt:FlxText;
	var HowToGetTrophy:FlxText;
	var curSelected:Int = 0;
	
	var Nothing:FlxSprite;
	var TooSlow:FlxSprite;
	var YouCantRun:FlxSprite;
	var TripleTrouble:FlxSprite;
	var FinalEscape:FlxSprite;
	var FaceOff:FlxSprite;
	var TooSlowLocked:FlxSprite;
	var YouCantRunLocked:FlxSprite;
	var TripleTroubleLocked:FlxSprite;
	var FinalEscapeLocked:FlxSprite;
	var FaceOffLocked:FlxSprite;
	var AllTrophies:FlxTypedSpriteGroup<FlxSprite>;
	var ExitButton:FlxSprite;
	
	var Select:FlxSprite;
	var cheats:Bool = (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false));
	var shiftMult:Int = 1;
	var holdTime:Float = 0;
	
	public function new()
	{
		super();
		
		if (MainMenuState.instance.openTrophyMenu) MainMenuState.instance.openTrophyMenu = false;
		#if desktop
		var rpcName:String = 'In Main Menu (Trophy Room)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'trophy-room';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.8;
		add(bg);
		
		TrophiesTxt = new FlxText(0, 15, FlxG.width, "Trophies");
		TrophiesTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 40, 0xFFFFFFFF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		TrophiesTxt.scrollFactor.set();
		TrophiesTxt.borderSize = 1.25;
		add(TrophiesTxt);
		if (TranslationLanguages.Text.exists(TrophiesTxt.text) && ClientPrefs.Language != 'English')
			TrophiesTxt.text = TranslationLanguages.Text[TrophiesTxt.text];
		
		AllTrophies = new FlxTypedSpriteGroup<FlxSprite>();
		add(AllTrophies);
		
		Nothing = new FlxSprite(-350, -225).loadGraphic(Paths.image('trophies/nothing'));
		Nothing.antialiasing = ClientPrefs.globalAntialiasing;
		Nothing.scrollFactor.set();
		Nothing.alpha = 1;
		Nothing.setGraphicSize(Std.int(Nothing.width * 0.27));
		Nothing.updateHitbox();
		AllTrophies.add(Nothing);
		
		TooSlow = new FlxSprite(100, -225).loadGraphic(Paths.image('trophies/too-slow'));
		TooSlow.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlow.scrollFactor.set();
		if (!ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF000000;
		TooSlow.setGraphicSize(Std.int(TooSlow.width * 0.27));
		TooSlow.updateHitbox();
		AllTrophies.add(TooSlow);
		
		YouCantRun = new FlxSprite(500, -225).loadGraphic(Paths.image('trophies/you-cant-run'));
		YouCantRun.antialiasing = ClientPrefs.globalAntialiasing;
		YouCantRun.scrollFactor.set();
		if (!ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF000000;
		YouCantRun.setGraphicSize(Std.int(YouCantRun.width * 0.27));
		YouCantRun.updateHitbox();
		AllTrophies.add(YouCantRun);
		
		TripleTrouble = new FlxSprite(-350, 50).loadGraphic(Paths.image('trophies/triple-trouble'));
		TripleTrouble.antialiasing = ClientPrefs.globalAntialiasing;
		TripleTrouble.scrollFactor.set();
		if (!ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF000000;
		TripleTrouble.setGraphicSize(Std.int(TripleTrouble.width * 0.27));
		TripleTrouble.updateHitbox();
		AllTrophies.add(TripleTrouble);
		
		FinalEscape = new FlxSprite(100, 50).loadGraphic(Paths.image('trophies/final-escape'));
		FinalEscape.antialiasing = ClientPrefs.globalAntialiasing;
		FinalEscape.scrollFactor.set();
		if (!ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF000000;
		FinalEscape.setGraphicSize(Std.int(FinalEscape.width * 0.27));
		FinalEscape.updateHitbox();
		AllTrophies.add(FinalEscape);
		
		FaceOff = new FlxSprite(500, 50).loadGraphic(Paths.image('trophies/face-off'));
		FaceOff.antialiasing = ClientPrefs.globalAntialiasing;
		FaceOff.scrollFactor.set();
		if (!ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF000000;
		FaceOff.setGraphicSize(Std.int(FaceOff.width * 0.27));
		FaceOff.updateHitbox();
		AllTrophies.add(FaceOff);
		
		AllTrophies.x += 400;
		AllTrophies.y += 350;
		
		
		TooSlowLocked = new FlxSprite(100, -225).loadGraphic(Paths.image('trophies/locked'));
		TooSlowLocked.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowLocked.scrollFactor.set();
		TooSlowLocked.setGraphicSize(Std.int(TooSlowLocked.width * 0.27));
		if (!ClientPrefs.TrophiesUnlocked.contains('too-slow')) add(TooSlowLocked);
		
		YouCantRunLocked = new FlxSprite(500, -225).loadGraphic(Paths.image('trophies/locked'));
		YouCantRunLocked.antialiasing = ClientPrefs.globalAntialiasing;
		YouCantRunLocked.scrollFactor.set();
		YouCantRunLocked.setGraphicSize(Std.int(YouCantRunLocked.width * 0.27));
		if (!ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) add(YouCantRunLocked);
		
		TripleTroubleLocked = new FlxSprite(-350, 50).loadGraphic(Paths.image('trophies/locked'));
		TripleTroubleLocked.antialiasing = ClientPrefs.globalAntialiasing;
		TripleTroubleLocked.scrollFactor.set();
		TripleTroubleLocked.setGraphicSize(Std.int(TripleTroubleLocked.width * 0.27));
		if (!ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) add(TripleTroubleLocked);
		
		FinalEscapeLocked = new FlxSprite(100, 50).loadGraphic(Paths.image('trophies/locked'));
		FinalEscapeLocked.antialiasing = ClientPrefs.globalAntialiasing;
		FinalEscapeLocked.scrollFactor.set();
		FinalEscapeLocked.setGraphicSize(Std.int(FinalEscapeLocked.width * 0.27));
		if (!ClientPrefs.TrophiesUnlocked.contains('final-escape')) add(FinalEscapeLocked);
		
		FaceOffLocked = new FlxSprite(500, 50).loadGraphic(Paths.image('trophies/locked'));
		FaceOffLocked.antialiasing = ClientPrefs.globalAntialiasing;
		FaceOffLocked.scrollFactor.set();
		FaceOffLocked.setGraphicSize(Std.int(FaceOffLocked.width * 0.27));
		if (!ClientPrefs.TrophiesUnlocked.contains('face-off')) add(FaceOffLocked);
		
		Select = new FlxSprite(350, -200).loadGraphic(Paths.image('trophies/select'));
		Select.antialiasing = ClientPrefs.globalAntialiasing;
		Select.scrollFactor.set();
		Select.setGraphicSize(Std.int(Select.width * 0.30));
		add(Select);
		
		HowToGetTrophy = new FlxText(0, 655, FlxG.width, "");
		HowToGetTrophy.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 20, 0xFFFFFFFF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		HowToGetTrophy.scrollFactor.set();
		HowToGetTrophy.borderSize = 1.25;
		add(HowToGetTrophy);
		
		ExitButton = new FlxSprite(FlxG.width - 79, 4).loadGraphic(Paths.image('exit'));
		ExitButton.antialiasing = ClientPrefs.globalAntialiasing;
		ExitButton.scrollFactor.set();
		add(ExitButton);
		
		Sel(curSelected,false);
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.TAB || controls.BACK || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(ExitButton) && FlxG.mouse.justReleased)) {
			new FlxTimer().start(0.05, function(tmr:FlxTimer) {
				MainMenuState.instance.lockedControl = false;
				MainMenuState.instance.selectedSomethin = false;
				MainMenuState.instance.lockMouseSelection = false;
				#if desktop
				var rpcName:String = 'In Main Menu';
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.imageRpc = 'icon';
				DiscordClient.changePresence(rpcName, null);
				#end
				close();
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
			});
		}
		
		if(FlxG.keys.pressed.SHIFT) {
			shiftMult = 3;
		} else {
			shiftMult = 1;
		}
		if (controls.UI_LEFT_P && (!FlxG.mouse.overlaps(Nothing) || !FlxG.mouse.overlaps(TooSlow) || !FlxG.mouse.overlaps(YouCantRun) || !FlxG.mouse.overlaps(TripleTrouble) || !FlxG.mouse.overlaps(FinalEscape) || !FlxG.mouse.overlaps(FaceOff)))
		{
			Sel(-shiftMult,true,'');
			holdTime = 0;
		}
		if (controls.UI_RIGHT_P && (!FlxG.mouse.overlaps(Nothing) || !FlxG.mouse.overlaps(TooSlow) || !FlxG.mouse.overlaps(YouCantRun) || !FlxG.mouse.overlaps(TripleTrouble) || !FlxG.mouse.overlaps(FinalEscape) || !FlxG.mouse.overlaps(FaceOff)))
		{
			Sel(shiftMult,true,'');
			holdTime = 0;
		}
		if((controls.UI_LEFT || controls.UI_RIGHT) && (!FlxG.mouse.overlaps(Nothing) || !FlxG.mouse.overlaps(TooSlow) || !FlxG.mouse.overlaps(YouCantRun) || !FlxG.mouse.overlaps(TripleTrouble) || !FlxG.mouse.overlaps(FinalEscape) || !FlxG.mouse.overlaps(FaceOff)))
		{
			var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
			holdTime += elapsed;
			var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
			if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
			{
				Sel((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult),true,'');
			}
		}
		if(FlxG.mouse.wheel != 0 && (!FlxG.mouse.overlaps(Nothing) || !FlxG.mouse.overlaps(TooSlow) || !FlxG.mouse.overlaps(YouCantRun) || !FlxG.mouse.overlaps(TripleTrouble) || !FlxG.mouse.overlaps(FinalEscape) || !FlxG.mouse.overlaps(FaceOff)))
		{
			Sel(shiftMult * FlxG.mouse.wheel,true,'');
			holdTime = 0;
		}
		
		if (FlxG.mouse.overlaps(Nothing) && curSelected != 0) Sel(0,true,'', true, 0);
		if (FlxG.mouse.overlaps(TooSlow) && curSelected != 1) Sel(0,true,'', true, 1);
		if (FlxG.mouse.overlaps(YouCantRun) && curSelected != 2) Sel(0,true,'', true, 2);
		if (FlxG.mouse.overlaps(TripleTrouble) && curSelected != 3) Sel(0,true,'', true, 3);
		if (FlxG.mouse.overlaps(FinalEscape) && curSelected != 4) Sel(0,true,'', true, 4);
		if (FlxG.mouse.overlaps(FaceOff) && curSelected != 5) Sel(0,true,'', true, 5);
		
		if (controls.UI_UP_P && (!FlxG.mouse.overlaps(Nothing) || !FlxG.mouse.overlaps(TooSlow) || !FlxG.mouse.overlaps(YouCantRun) || !FlxG.mouse.overlaps(TripleTrouble) || !FlxG.mouse.overlaps(FinalEscape) || !FlxG.mouse.overlaps(FaceOff))) Sel(0,true,'u');
		if (controls.UI_DOWN_P && (!FlxG.mouse.overlaps(Nothing) || !FlxG.mouse.overlaps(TooSlow) || !FlxG.mouse.overlaps(YouCantRun) || !FlxG.mouse.overlaps(TripleTrouble) || !FlxG.mouse.overlaps(FinalEscape) || !FlxG.mouse.overlaps(FaceOff))) Sel(0,true,'d');
		
		if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justReleased) && (FlxG.mouse.overlaps(Nothing) || FlxG.mouse.overlaps(TooSlow) || FlxG.mouse.overlaps(YouCantRun) || FlxG.mouse.overlaps(TripleTrouble) || FlxG.mouse.overlaps(FinalEscape) || FlxG.mouse.overlaps(FaceOff))))
		{	
			switch (curSelected) {
				case 0:
					if (ClientPrefs.TrophieSelected != curSelected) FlxG.sound.play(Paths.sound('trophy'));
					ClientPrefs.TrophieSelected = curSelected;
				case 1:
					if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) {
						if (ClientPrefs.TrophieSelected != curSelected) FlxG.sound.play(Paths.sound('trophy'));
						ClientPrefs.TrophieSelected = curSelected;
					} else {
						FlxG.sound.play(Paths.sound('trophy-denied'));
					}
				case 2:
					if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) {
						if (ClientPrefs.TrophieSelected != curSelected) FlxG.sound.play(Paths.sound('trophy'));
						ClientPrefs.TrophieSelected = curSelected;
					} else {
						FlxG.sound.play(Paths.sound('trophy-denied'));
					}
				case 3:
					if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) {
						if (ClientPrefs.TrophieSelected != curSelected) FlxG.sound.play(Paths.sound('trophy'));
						ClientPrefs.TrophieSelected = curSelected;
					} else {
						FlxG.sound.play(Paths.sound('trophy-denied'));
					}
				case 4:
					if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) {
						if (ClientPrefs.TrophieSelected != curSelected) FlxG.sound.play(Paths.sound('trophy'));
						ClientPrefs.TrophieSelected = curSelected;
					} else {
						FlxG.sound.play(Paths.sound('trophy-denied'));
					}
				case 5:
					if (ClientPrefs.TrophiesUnlocked.contains('face-off')) {
						if (ClientPrefs.TrophieSelected != curSelected) FlxG.sound.play(Paths.sound('trophy'));
						ClientPrefs.TrophieSelected = curSelected;
					} else {
						FlxG.sound.play(Paths.sound('trophy-denied'));
					}
			}
			ClientPrefs.saveSettings();
		}
	}
	function Sel(oaoao:Int = 0, ?PlayTick:Bool = true, ?k:String = '', ?mouse:Bool = false, ?dafuk:Int = 0) {
		if (PlayTick) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		
		if (!mouse) {
			if (k == '') {
				curSelected += oaoao;
				if (curSelected < 0)
					curSelected = 5;
				if (curSelected > 5)
					curSelected = 0;
			}
			if (k == 'u') {
				switch (curSelected) {
					case 3: curSelected = 0;
					case 4: curSelected = 1;
					case 5: curSelected = 2;
				}
			}
			if (k == 'd') {
				switch (curSelected) {
					case 0: curSelected = 3;
					case 1: curSelected = 4;
					case 2: curSelected = 5;
				}
			}
		} else {
			curSelected = dafuk;
		}
	
		switch (curSelected) {
			case -1:
				Select.alpha = 0;
				HowToGetTrophy.text = '';
				
				Nothing.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF606060;
			case 0:
				Select.x = -350;
				Select.y = -200;
				HowToGetTrophy.text = '';
				
				Nothing.color = 0xFFFFFFFF;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF606060;
			case 1:
				Select.x = 100;
				Select.y = -200;
				HowToGetTrophy.text = 'Complete \"Too Slow\" in less than 5 misses to get this trophy.';
				
				Nothing.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFFFFFFFF;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF606060;
			case 2:
				Select.x = 500;
				Select.y = -200;
				HowToGetTrophy.text = 'Complete \"You Cant Run\" in less than 5 misses to get this trophy.';
				
				Nothing.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFFFFFFFF;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF606060;
			case 3:
				Select.x = -350;
				Select.y = 50;
				HowToGetTrophy.text = 'Complete \"Triple Trouble\" in less than 25 misses to get this trophy.';
				
				Nothing.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFFFFFFFF;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF606060;
			case 4:
				Select.x = 100;
				Select.y = 50;
				HowToGetTrophy.text = 'Complete \"Final Escape\" in less than 10 misses to get this trophy.';
				
				Nothing.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFFFFFFFF;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFF606060;
			case 5:
				Select.x = 500;
				Select.y = 50;
				HowToGetTrophy.text = 'Complete \"Face Off\" in less than 5 misses to get this trophy.';
				
				Nothing.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('too-slow')) TooSlow.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('you-cant-run')) YouCantRun.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('triple-trouble')) TripleTrouble.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('final-escape')) FinalEscape.color = 0xFF606060;
				if (ClientPrefs.TrophiesUnlocked.contains('face-off')) FaceOff.color = 0xFFFFFFFF;
		}
		if (TranslationLanguages.Text.exists(HowToGetTrophy.text) && ClientPrefs.Language != 'English')
			HowToGetTrophy.text = TranslationLanguages.Text[HowToGetTrophy.text];
	}
}
