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

using StringTools;

class DebugSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var BotplayTxt:FlxText;
	var PracticeTxt:FlxText;
	var EncoreTxt:FlxText;
	var SoundTestTxt:FlxText;
	var ProgressTxt:FlxText;
	var ProgressAltTxt:FlxText;
	var CodeTxt:FlxText;
	var Songs:FlxText;
	var Trophies:FlxText;
	var curSelected:Int = 0;
	var SecondPage:Bool = false;
	
	var SkinsTxt:FlxText;
	var SkinUnlockedTxt:FlxText;
	var EncoreAllTxt:FlxText;
	var SongEncTxt:FlxText;
	var TrophiesUnlockedTxt:FlxText;
	var BeatAllFreeplaySongs:FlxText;
	
	public function new()
	{
		super();
		
		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.5;
		add(bg);
		
		BotplayTxt = new FlxText(30, 15, FlxG.width, "Botplay ");
		BotplayTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		BotplayTxt.scrollFactor.set();
		BotplayTxt.borderSize = 1.25;
		add(BotplayTxt);
		if (TranslationLanguages.Text.exists(BotplayTxt.text) && ClientPrefs.Language != 'English')
			BotplayTxt.text = TranslationLanguages.Text[BotplayTxt.text];
		
		PracticeTxt = new FlxText(30, 80, FlxG.width, "Practice Mode ");
		PracticeTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		PracticeTxt.scrollFactor.set();
		PracticeTxt.borderSize = 1.25;
		add(PracticeTxt);
		if (TranslationLanguages.Text.exists(PracticeTxt.text) && ClientPrefs.Language != 'English')
			PracticeTxt.text = TranslationLanguages.Text[PracticeTxt.text];
		
		EncoreTxt = new FlxText(30, 155, FlxG.width, "Encore ");
		EncoreTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		EncoreTxt.scrollFactor.set();
		EncoreTxt.borderSize = 1.25;
		add(EncoreTxt);
		if (TranslationLanguages.Text.exists(EncoreTxt.text) && ClientPrefs.Language != 'English')
			EncoreTxt.text = TranslationLanguages.Text[EncoreTxt.text];
		
		SoundTestTxt = new FlxText(30, 230, FlxG.width, "Sound Test ");
		SoundTestTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		SoundTestTxt.scrollFactor.set();
		SoundTestTxt.borderSize = 1.25;
		add(SoundTestTxt);
		if (TranslationLanguages.Text.exists(SoundTestTxt.text) && ClientPrefs.Language != 'English')
			SoundTestTxt.text = TranslationLanguages.Text[SoundTestTxt.text];
		
		ProgressTxt = new FlxText(30, 305, FlxG.width, "Exe Story Progress ");
		ProgressTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		ProgressTxt.scrollFactor.set();
		ProgressTxt.borderSize = 1.25;
		add(ProgressTxt);
		if (TranslationLanguages.Text.exists(ProgressTxt.text) && ClientPrefs.Language != 'English')
			ProgressTxt.text = TranslationLanguages.Text[ProgressTxt.text];
		
		ProgressAltTxt = new FlxText(30, 380, FlxG.width, "Alt Story Progress ");
		ProgressAltTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		ProgressAltTxt.scrollFactor.set();
		ProgressAltTxt.borderSize = 1.25;
		add(ProgressAltTxt);
		if (TranslationLanguages.Text.exists(ProgressAltTxt.text) && ClientPrefs.Language != 'English')
			ProgressAltTxt.text = TranslationLanguages.Text[ProgressAltTxt.text];
		
		CodeTxt = new FlxText(30, 455, FlxG.width, "Extras Code ");
		CodeTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		CodeTxt.scrollFactor.set();
		CodeTxt.borderSize = 1.25;
		add(CodeTxt);
		if (TranslationLanguages.Text.exists(CodeTxt.text) && ClientPrefs.Language != 'English')
			CodeTxt.text = TranslationLanguages.Text[CodeTxt.text];
		
		Songs = new FlxText(30, 530, FlxG.width, "Unlock Freeplay Songs");
		Songs.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		Songs.scrollFactor.set();
		Songs.borderSize = 1.25;
		add(Songs);
		if (TranslationLanguages.Text.exists(Songs.text) && ClientPrefs.Language != 'English')
			Songs.text = TranslationLanguages.Text[Songs.text];
		
		Trophies = new FlxText(30, 605, FlxG.width, "Unlock All Trophies");
		Trophies.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		Trophies.scrollFactor.set();
		Trophies.borderSize = 1.25;
		add(Trophies);
		if (TranslationLanguages.Text.exists(Trophies.text) && ClientPrefs.Language != 'English')
			Trophies.text = TranslationLanguages.Text[Trophies.text];
		
		
		SkinsTxt = new FlxText(30, 15, FlxG.width, "Unlock All Skins");
		SkinsTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		SkinsTxt.scrollFactor.set();
		SkinsTxt.borderSize = 1.25;
		add(SkinsTxt);
		if (TranslationLanguages.Text.exists(SkinsTxt.text) && ClientPrefs.Language != 'English')
			SkinsTxt.text = TranslationLanguages.Text[SkinsTxt.text];
		
		SkinUnlockedTxt = new FlxText(30, 80, FlxG.width, "Skin Unlocked Test");
		SkinUnlockedTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		SkinUnlockedTxt.scrollFactor.set();
		SkinUnlockedTxt.borderSize = 1.25;
		add(SkinUnlockedTxt);
		if (TranslationLanguages.Text.exists(SkinUnlockedTxt.text) && ClientPrefs.Language != 'English')
			SkinUnlockedTxt.text = TranslationLanguages.Text[SkinUnlockedTxt.text];
		
		EncoreAllTxt = new FlxText(30, 155, FlxG.width, "Unlock All Encore Songs");
		EncoreAllTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		EncoreAllTxt.scrollFactor.set();
		EncoreAllTxt.borderSize = 1.25;
		add(EncoreAllTxt);
		if (TranslationLanguages.Text.exists(EncoreAllTxt.text) && ClientPrefs.Language != 'English')
			EncoreAllTxt.text = TranslationLanguages.Text[EncoreAllTxt.text];
		
		SongEncTxt = new FlxText(30, 230, FlxG.width, "Encore Song Unlocked Test");
		SongEncTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		SongEncTxt.scrollFactor.set();
		SongEncTxt.borderSize = 1.25;
		add(SongEncTxt);
		if (TranslationLanguages.Text.exists(SongEncTxt.text) && ClientPrefs.Language != 'English')
			SongEncTxt.text = TranslationLanguages.Text[SongEncTxt.text];
		
		TrophiesUnlockedTxt = new FlxText(30, 305, FlxG.width, "Trophies Unlocked Test");
		TrophiesUnlockedTxt.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		TrophiesUnlockedTxt.scrollFactor.set();
		TrophiesUnlockedTxt.borderSize = 1.25;
		add(TrophiesUnlockedTxt);
		if (TranslationLanguages.Text.exists(TrophiesUnlockedTxt.text) && ClientPrefs.Language != 'English')
			TrophiesUnlockedTxt.text = TranslationLanguages.Text[TrophiesUnlockedTxt.text];
			
		BeatAllFreeplaySongs = new FlxText(30, 380, FlxG.width, "Beat All Freeplay Songs");
		BeatAllFreeplaySongs.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 30, 0xFF757575, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		BeatAllFreeplaySongs.scrollFactor.set();
		BeatAllFreeplaySongs.borderSize = 1.25;
		add(BeatAllFreeplaySongs);
		if (TranslationLanguages.Text.exists(BeatAllFreeplaySongs.text) && ClientPrefs.Language != 'English')
			BeatAllFreeplaySongs.text = TranslationLanguages.Text[BeatAllFreeplaySongs.text];
		
		#if mobile
		addVirtualPad(LEFT_FULL, A_B);
		#end
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (!SecondPage) {
			BotplayTxt.alpha = 1;
			PracticeTxt.alpha = 1;
			EncoreTxt.alpha = 1;
			SoundTestTxt.alpha = 1;
			ProgressTxt.alpha = 1;
			ProgressAltTxt.alpha = 1;
			CodeTxt.alpha = 1;
			Songs.alpha = 1;
			Trophies.alpha = 1;
			
			SkinsTxt.alpha = 0;
			SkinUnlockedTxt.alpha = 0;
			EncoreAllTxt.alpha = 0;
			SongEncTxt.alpha = 0;
			TrophiesUnlockedTxt.alpha = 0;
			BeatAllFreeplaySongs.alpha = 0;
		
			if (controls.UI_RIGHT_P) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				SecondPage = true;
				curSelected = 0;
			}
		
			if (controls.UI_UP_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				if (curSelected != 0)
					curSelected -= 1;
				else
					curSelected = 8;
			}

			if (controls.UI_DOWN_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				if (curSelected != 8)
					curSelected += 1;
				else
					curSelected = 0;
			}
			
			if (controls.ACCEPT)
				FlxG.sound.play(Paths.sound('tick'), 0.4);
			
			switch (curSelected) {
				case 0:
					BotplayTxt.color = 0xFFFFFFFF;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					ProgressAltTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 1:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFFFFFFFF;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					ProgressAltTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 2:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFFFFFFFF;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					ProgressAltTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 3:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFFFFFFFF;
					ProgressTxt.color = 0xFF757575;
					ProgressAltTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 4:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFFFFFFFF;
					ProgressAltTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 5:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					ProgressAltTxt.color = 0xFFFFFFFF;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 6:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					ProgressAltTxt.color = 0xFF757575;
					CodeTxt.color = 0xFFFFFFFF;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFF757575;
				case 7:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFFFFFFFF;
					Trophies.color = 0xFF757575;
				case 8:
					BotplayTxt.color = 0xFF757575;
					PracticeTxt.color = 0xFF757575;
					EncoreTxt.color = 0xFF757575;
					SoundTestTxt.color = 0xFF757575;
					ProgressTxt.color = 0xFF757575;
					CodeTxt.color = 0xFF757575;
					Songs.color = 0xFF757575;
					Trophies.color = 0xFFFFFFFF;
			}
			
			switch (curSelected) {
				case 0:
					if (ClientPrefs.gameplaySettings.get("botplay") == false) {
						if (controls.ACCEPT)
							ClientPrefs.gameplaySettings.set("botplay", true);
					} else {
						if (controls.ACCEPT)
							ClientPrefs.gameplaySettings.set("botplay", false);
					}
				case 1:
					if (ClientPrefs.gameplaySettings.get("practice") == false) {
						if (controls.ACCEPT)
							ClientPrefs.gameplaySettings.set("practice", true);
					} else {
						if (controls.ACCEPT)
							ClientPrefs.gameplaySettings.set("practice", false);
					}
				case 2:
					if (ClientPrefs.EncoreUnlocked == false) {
						if (controls.ACCEPT)
							ClientPrefs.EncoreUnlocked = true;
					} else {
						if (controls.ACCEPT)
							ClientPrefs.EncoreUnlocked = false;
					}
				case 3:
					if (ClientPrefs.SoundTestUnlocked == false) {
						if (controls.ACCEPT)
							ClientPrefs.SoundTestUnlocked = true;
					} else {
						if (controls.ACCEPT)
							ClientPrefs.SoundTestUnlocked = false;
					}
				case 4:
					if (ClientPrefs.storyProgressExe == 0) {
						if (controls.ACCEPT)
							ClientPrefs.storyProgressExe = 1;
					} else {
						if (ClientPrefs.storyProgressExe == 1) {
							if (controls.ACCEPT)
								ClientPrefs.storyProgressExe = 2;
						} else {
							if (ClientPrefs.storyProgressExe == 2) {
								if (controls.ACCEPT)
									ClientPrefs.storyProgressExe = 3;
							} else {
								if (ClientPrefs.storyProgressExe == 3) {
									if (controls.ACCEPT)
										ClientPrefs.storyProgressExe = 4;
								} else {
									if (ClientPrefs.storyProgressExe == 4) {
										if (controls.ACCEPT)
											ClientPrefs.storyProgressExe = 5;
									} else {
										if (ClientPrefs.storyProgressExe == 5) {
											if (controls.ACCEPT)
												ClientPrefs.storyProgressExe = 0;
										}
									}
								}
							}
						}
					}
				case 5:
					if (ClientPrefs.storyProgressAlt == 0) {
						if (controls.ACCEPT)
							ClientPrefs.storyProgressAlt = 1;
					} else {
						if (ClientPrefs.storyProgressAlt == 1) {
							if (controls.ACCEPT)
								ClientPrefs.storyProgressAlt = 2;
						} else {
							if (ClientPrefs.storyProgressAlt == 2) {
								if (controls.ACCEPT)
									ClientPrefs.storyProgressAlt = 3;
							} else {
								if (ClientPrefs.storyProgressAlt == 3) {
									if (controls.ACCEPT)
										ClientPrefs.storyProgressAlt = 4;
								} else {
									if (ClientPrefs.storyProgressAlt == 4) {
										if (controls.ACCEPT)
											ClientPrefs.storyProgressAlt = 0;
									}
								}
							}
						}
					}
				case 6:
					if (ClientPrefs.ShowExtrasCode == false) {
						if (controls.ACCEPT)
							ClientPrefs.ShowExtrasCode = true;
					} else {
						if (controls.ACCEPT)
							ClientPrefs.ShowExtrasCode = false;
					}
				case 7:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);
						CharSongList.init(); 
						var chars:Array<String> = CharSongList.characters;
						for (charNum in 0...chars.length) {
							if (!ClientPrefs.charactersUnlocked.contains(chars[charNum])) ClientPrefs.charactersUnlocked.push(chars[charNum]);
						} 
					}
				case 8:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);
						ClientPrefs.TrophiesUnlocked = ["too-slow", "you-cant-run", "triple-trouble", "final-escape", "face-off"];			
					}
			}
			
			if (ClientPrefs.gameplaySettings.get("botplay") == false) BotplayTxt.text = 'Botplay OFF';
			if (ClientPrefs.gameplaySettings.get("botplay") == true) BotplayTxt.text = 'Botplay ON';
			if (TranslationLanguages.Text.exists(BotplayTxt.text) && ClientPrefs.Language != 'English')
				BotplayTxt.text = TranslationLanguages.Text[BotplayTxt.text];
			
			if (ClientPrefs.gameplaySettings.get("practice") == false) PracticeTxt.text = 'Practice Mode OFF';
			if (ClientPrefs.gameplaySettings.get("practice") == true) PracticeTxt.text = 'Practice Mode ON';
			if (TranslationLanguages.Text.exists(PracticeTxt.text) && ClientPrefs.Language != 'English')
				PracticeTxt.text = TranslationLanguages.Text[PracticeTxt.text];
			
			if (ClientPrefs.EncoreUnlocked == false) EncoreTxt.text = 'Encore LOCKED';
			if (ClientPrefs.EncoreUnlocked == true) EncoreTxt.text = 'Encore UNLOCKED';
			if (TranslationLanguages.Text.exists(EncoreTxt.text) && ClientPrefs.Language != 'English')
				EncoreTxt.text = TranslationLanguages.Text[EncoreTxt.text];
			
			if (ClientPrefs.SoundTestUnlocked == false) SoundTestTxt.text = 'Sound Test LOCKED';
			if (ClientPrefs.SoundTestUnlocked == true) SoundTestTxt.text = 'Sound Test UNLOCKED';
			if (TranslationLanguages.Text.exists(SoundTestTxt.text) && ClientPrefs.Language != 'English')
				SoundTestTxt.text = TranslationLanguages.Text[SoundTestTxt.text];
			
			if (ClientPrefs.storyProgressExe == 0) ProgressTxt.text = 'Exe Story Progress Too Slow';
			if (ClientPrefs.storyProgressExe == 1) ProgressTxt.text = 'Exe Story Progress You Cant Run';
			if (ClientPrefs.storyProgressExe == 2) ProgressTxt.text = 'Exe Story Progress Triple Trouble';
			if (ClientPrefs.storyProgressExe == 3) ProgressTxt.text = 'Exe Story Progress Final Escape';
			if (ClientPrefs.storyProgressExe == 4) ProgressTxt.text = 'Exe Story Progress Face Off';
			if (ClientPrefs.storyProgressExe == 5) ProgressTxt.text = 'Exe Story Progress Story Complete';
			if (TranslationLanguages.Text.exists(ProgressTxt.text) && ClientPrefs.Language != 'English')
				ProgressTxt.text = TranslationLanguages.Text[ProgressTxt.text];
			
			if (ClientPrefs.storyProgressAlt == 0) ProgressAltTxt.text = 'Alt Story Progress Coulrophobia';
			if (ClientPrefs.storyProgressAlt == 1) ProgressAltTxt.text = 'Alt Story Progress Broken Heart';
			if (ClientPrefs.storyProgressAlt == 2) ProgressAltTxt.text = 'Alt Story Progress Tribal';
			if (ClientPrefs.storyProgressAlt == 3) ProgressAltTxt.text = 'Alt Story Progress Goddess';
			if (ClientPrefs.storyProgressAlt == 4) ProgressAltTxt.text = 'Alt Story Progress Story Complete';
			if (TranslationLanguages.Text.exists(ProgressAltTxt.text) && ClientPrefs.Language != 'English')
				ProgressAltTxt.text = TranslationLanguages.Text[ProgressAltTxt.text];
			
			if (ClientPrefs.ShowExtrasCode == true) CodeTxt.text = 'Extras Code SHOW';
			if (ClientPrefs.ShowExtrasCode == false) CodeTxt.text = 'Extras Code HIDE';
			if (TranslationLanguages.Text.exists(CodeTxt.text) && ClientPrefs.Language != 'English')
				CodeTxt.text = TranslationLanguages.Text[CodeTxt.text];
		} else {
			BotplayTxt.alpha = 0;
			PracticeTxt.alpha = 0;
			EncoreTxt.alpha = 0;
			SoundTestTxt.alpha = 0;
			ProgressTxt.alpha = 0;
			ProgressAltTxt.alpha = 0;
			CodeTxt.alpha = 0;
			Songs.alpha = 0;
			Trophies.alpha = 0;
			
			SkinsTxt.alpha = 1;
			SkinUnlockedTxt.alpha = 1;
			EncoreAllTxt.alpha = 1;
			SongEncTxt.alpha = 1;
			TrophiesUnlockedTxt.alpha = 1;
			BeatAllFreeplaySongs.alpha = 1;
			
			switch (curSelected) {
				case 0:
					SkinsTxt.color = 0xFFFFFFFF;
					SkinUnlockedTxt.color = 0xFF757575;
					EncoreAllTxt.color = 0xFF757575;
					SongEncTxt.color = 0xFF757575;
					TrophiesUnlockedTxt.color = 0xFF757575;
					BeatAllFreeplaySongs.color = 0xFF757575;
				case 1:
					SkinsTxt.color = 0xFF757575;
					SkinUnlockedTxt.color = 0xFFFFFFFF;
					EncoreAllTxt.color = 0xFF757575;
					SongEncTxt.color = 0xFF757575;
					TrophiesUnlockedTxt.color = 0xFF757575;
					BeatAllFreeplaySongs.color = 0xFF757575;
				case 2:
					SkinsTxt.color = 0xFF757575;
					SkinUnlockedTxt.color = 0xFF757575;
					EncoreAllTxt.color = 0xFFFFFFFF;
					SongEncTxt.color = 0xFF757575;
					TrophiesUnlockedTxt.color = 0xFF757575;
					BeatAllFreeplaySongs.color = 0xFF757575;
				case 3:
					SkinsTxt.color = 0xFF757575;
					SkinUnlockedTxt.color = 0xFF757575;
					EncoreAllTxt.color = 0xFF757575;
					SongEncTxt.color = 0xFFFFFFFF;
					TrophiesUnlockedTxt.color = 0xFF757575;
					BeatAllFreeplaySongs.color = 0xFF757575;
				case 4:
					SkinsTxt.color = 0xFF757575;
					SkinUnlockedTxt.color = 0xFF757575;
					EncoreAllTxt.color = 0xFF757575;
					SongEncTxt.color = 0xFF757575;
					TrophiesUnlockedTxt.color = 0xFFFFFFFF;
					BeatAllFreeplaySongs.color = 0xFF757575;
				case 5:
					SkinsTxt.color = 0xFF757575;
					SkinUnlockedTxt.color = 0xFF757575;
					EncoreAllTxt.color = 0xFF757575;
					SongEncTxt.color = 0xFF757575;
					TrophiesUnlockedTxt.color = 0xFF757575;
					BeatAllFreeplaySongs.color = 0xFFFFFFFF;
			}
			
			if (controls.UI_LEFT_P) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				SecondPage = false;
				curSelected = 0;
			}
			
			if (controls.UI_UP_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				if (curSelected != 0)
					curSelected -= 1;
				else
					curSelected = 5;
			}

			if (controls.UI_DOWN_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				if (curSelected != 5)
					curSelected += 1;
				else
					curSelected = 0;
			}
			
			switch (curSelected) {
				case 0:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);
						if (!ClientPrefs.SongsCompleted.contains('manual-blast')) ClientPrefs.SongsCompleted.push('manual-blast');
						if (!ClientPrefs.SongsCompleted.contains('extricate-hex')) ClientPrefs.SongsCompleted.push('extricate-hex');
						if (!ClientPrefs.SongsCompleted.contains('animosity')) ClientPrefs.SongsCompleted.push('animosity');
						if (!ClientPrefs.SongsCompleted.contains('reunion')) ClientPrefs.SongsCompleted.push('reunion');
						if (!ClientPrefs.SongsCompleted.contains('faker-encore')) ClientPrefs.SongsCompleted.push('faker-encore');
						if (!ClientPrefs.SongsCompleted.contains('fatality-encore')) ClientPrefs.SongsCompleted.push('fatality-encore');
						if (!ClientPrefs.SongsCompleted.contains('faker')) ClientPrefs.SongsCompleted.push('faker');
						if (!ClientPrefs.SongsCompleted.contains('malediction')) ClientPrefs.SongsCompleted.push('malediction');
						if (!ClientPrefs.SongsCompleted.contains('round-a-bout')) ClientPrefs.SongsCompleted.push('round-a-bout');
						if (!ClientPrefs.SongsCompleted.contains('hedge')) ClientPrefs.SongsCompleted.push('hedge');
						if (!ClientPrefs.SongsCompleted.contains('old-ycr-slaps')) ClientPrefs.SongsCompleted.push('old-ycr-slaps');
						if (!ClientPrefs.SongsCompleted.contains('too-slow-encore')) ClientPrefs.SongsCompleted.push('too-slow-encore');
						if (!ClientPrefs.SongsCompleted.contains('you-cant-run-encore')) ClientPrefs.SongsCompleted.push('you-cant-run-encore');
						if (!ClientPrefs.SongsCompleted.contains('triple-trouble-encore')) ClientPrefs.SongsCompleted.push('triple-trouble-encore');
					}
				case 1:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);
						if (!ClientPrefs.SkinsUnlockedRN.contains('cat-gf')) ClientPrefs.SkinsUnlockedRN.push('cat-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('faker-gf')) ClientPrefs.SkinsUnlockedRN.push('faker-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('hogged-gf')) ClientPrefs.SkinsUnlockedRN.push('hogged-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('hog-bf')) ClientPrefs.SkinsUnlockedRN.push('hog-bf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('hog-gf')) ClientPrefs.SkinsUnlockedRN.push('hog-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('fatal-gf')) ClientPrefs.SkinsUnlockedRN.push('fatal-gf');	
						if (!ClientPrefs.SkinsUnlockedRN.contains('sarah-gf')) ClientPrefs.SkinsUnlockedRN.push('sarah-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('hyper-gf')) ClientPrefs.SkinsUnlockedRN.push('hyper-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('fem-bf')) ClientPrefs.SkinsUnlockedRN.push('fem-bf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('sunky-gf')) ClientPrefs.SkinsUnlockedRN.push('sunky-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('dj-gf')) ClientPrefs.SkinsUnlockedRN.push('dj-gf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('merphi-bf')) ClientPrefs.SkinsUnlockedRN.push('merphi-bf');
						if (!ClientPrefs.SkinsUnlockedRN.contains('hogg-gf')) ClientPrefs.SkinsUnlockedRN.push('hogg-gf');
					}
				case 2:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);	
						if (!ClientPrefs.SongsCompleted.contains('too-slow-encore')) ClientPrefs.SongsCompleted.push('too-slow-encore');	
						if (!ClientPrefs.SongsCompleted.contains('endless')) ClientPrefs.SongsCompleted.push('endless');	
						if (!ClientPrefs.SongsCompleted.contains('cycles')) ClientPrefs.SongsCompleted.push('cycles');
						if (!ClientPrefs.SongsCompleted.contains('sunshine')) ClientPrefs.SongsCompleted.push('sunshine');
						if (!ClientPrefs.SongsCompleted.contains('chaos')) ClientPrefs.SongsCompleted.push('chaos');
						if (!ClientPrefs.SongsCompleted.contains('faker')) ClientPrefs.SongsCompleted.push('faker');
						if (!ClientPrefs.SongsCompleted.contains('fatality')) ClientPrefs.SongsCompleted.push('fatality');
						if (!ClientPrefs.SongsCompleted.contains('round-a-bout')) ClientPrefs.SongsCompleted.push('round-a-bout');
						if (!ClientPrefs.SongsCompleted.contains('her-world')) ClientPrefs.SongsCompleted.push('her-world');
						if (!ClientPrefs.SongsCompleted.contains('hollow')) ClientPrefs.SongsCompleted.push('hollow');
					}
				case 3:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);	
						if (!ClientPrefs.SongsCompletedRN.contains('endless')) ClientPrefs.SongsCompletedRN.push('endless');	
						if (!ClientPrefs.SongsCompletedRN.contains('cycles')) ClientPrefs.SongsCompletedRN.push('cycles');
						if (!ClientPrefs.SongsCompletedRN.contains('sunshine')) ClientPrefs.SongsCompletedRN.push('sunshine');
						if (!ClientPrefs.SongsCompletedRN.contains('chaos')) ClientPrefs.SongsCompletedRN.push('chaos');
						if (!ClientPrefs.SongsCompletedRN.contains('faker')) ClientPrefs.SongsCompletedRN.push('faker');
						if (!ClientPrefs.SongsCompletedRN.contains('fatality')) ClientPrefs.SongsCompletedRN.push('fatality');
						if (!ClientPrefs.SongsCompletedRN.contains('round-a-bout')) ClientPrefs.SongsCompletedRN.push('round-a-bout');
						if (!ClientPrefs.SongsCompletedRN.contains('her-world')) ClientPrefs.SongsCompletedRN.push('her-world');
						if (!ClientPrefs.SongsCompletedRN.contains('hollow')) ClientPrefs.SongsCompletedRN.push('hollow');
					}
				case 4:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);
						if (!ClientPrefs.TrophiesUnlockedRN.contains('too-slow')) ClientPrefs.TrophiesUnlockedRN.push('too-slow');
						if (!ClientPrefs.TrophiesUnlockedRN.contains('you-cant-run')) ClientPrefs.TrophiesUnlockedRN.push('you-cant-run');
						if (!ClientPrefs.TrophiesUnlockedRN.contains('triple-trouble')) ClientPrefs.TrophiesUnlockedRN.push('triple-trouble');
						if (!ClientPrefs.TrophiesUnlockedRN.contains('final-escape')) ClientPrefs.TrophiesUnlockedRN.push('final-escape');
						if (!ClientPrefs.TrophiesUnlockedRN.contains('face-off')) ClientPrefs.TrophiesUnlockedRN.push('face-off');
					}
				case 5:
					if (controls.ACCEPT) {
						FlxG.sound.play(Paths.sound('hitStatic1'), 0.4);
						CharSongList.init(); 
						for (charNum in 0...CharSongList.characters.length) {
							for (songNum in 0...CharSongList.getSongsByChar(CharSongList.characters[charNum]).length) {
								var song:String = CharSongList.getSongsByChar(CharSongList.characters[charNum])[songNum];
								if (!ClientPrefs.SongsCompleted.contains(song)) ClientPrefs.SongsCompleted.push(song);
							}
						}
						if (!ClientPrefs.UnlockedEndings.contains('curse-good')) ClientPrefs.UnlockedEndings.push('curse-good');
						if (!ClientPrefs.UnlockedEndings.contains('curse-bad')) ClientPrefs.UnlockedEndings.push('curse-bad');
					}
			}
		}
		
		if (#if desktop FlxG.keys.justPressed.F1 #else controls.BACK || FlxG.android.justReleased.BACK #end) {
			new FlxTimer().start(0.05, function(tmr:FlxTimer) {
				MainMenuState.instance.lockedControl = false;
				MainMenuState.instance.selectedSomethin = false;
				MainMenuState.instance.lockMouseSelection = false;
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
				#if desktop
				close();
				#else
				FlxG.resetState();
				#end
			});
		}
	}
}
