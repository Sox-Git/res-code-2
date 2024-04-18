package;

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
import Song.SwagSong;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath;
import openfl.display.BlendMode;

using StringTools;

class SongDebugSubstate extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var main:FlxSprite;
	var curSelected:Int = 0;
	var pauseMusic:FlxSound;
	var Options:Array<String> = ['PRACTICE MODE', 'BOTPLAY', 'SKIP TIME', 'END SONG'];
	var textY:Int = 35;
	
	var PracticeMode:FlxText;
	var BotPlay:FlxText;
	var SkipTime:FlxText;
	var EndSong:FlxText;
	
	var DevMenu:FlxTypedSpriteGroup<FlxSprite>;
	var curTime:Float = Math.max(0, Conductor.songPosition);
	var holdTime:Float = 0;
	
	public function new()
	{
		super();
		
		if (ClientPrefs.Language != 'English') {
			switch(ClientPrefs.Language) {
				case 'Russian': Options = ['РЕЖИМ ПРАКТИКИ', 'БОТПЛЕЙ', 'ПЕРЕМОТАТЬ ВРЕМЯ', 'ЗАКОНЧИТЬ ПЕСНЮ'];
				case 'Spanish': Options = ['PRACTICE MODE', 'BOTPLAY', 'SKIP TIME', 'END SONG'];
				default: Options = ['PRACTICE MODE', 'BOTPLAY', 'SKIP TIME', 'END SONG'];
			}
		}
		
		pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
		FlxG.sound.list.add(pauseMusic);
		FlxG.sound.play(Paths.sound('pause', 'shared'), 0.7);

		DevMenu = new FlxTypedSpriteGroup<FlxSprite>();

		bg = new FlxSprite(0, 0);
		bg.frames = Paths.getSparrowAtlas('staticBACKGROUND2-g', 'exe');
		bg.animation.addByPrefix('idle', "menuSTATICNEW instance 1", 24);
		bg.animation.play('idle');
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.scrollFactor.set();
		bg.blend = BlendMode.MULTIPLY;
		bg.alpha = 0;
		DevMenu.add(bg);

		main = new FlxSprite(-800, 0).loadGraphic(Paths.image('dev-menu'));
		main.antialiasing = ClientPrefs.globalAntialiasing;
		main.screenCenter(X);
		main.scrollFactor.set();
		DevMenu.add(main);

		for (i in 0...4) {
			var text:FlxText = new FlxText(0, textY, FlxG.width, Options[i]);
			text.setFormat(Paths.font("advanced.ttf"), 80, 0xFFFFFFFF, CENTER);
			text.scrollFactor.set();
			DevMenu.add(text);
			textY += 160;
		}
		
		PracticeMode = new FlxText(0, 105, FlxG.width, '');
		PracticeMode.setFormat(Paths.font("advanced.ttf"), 60, 0xFFFFFFFF, CENTER);
		PracticeMode.scrollFactor.set();
		DevMenu.add(PracticeMode);
		
		BotPlay = new FlxText(0, 262, FlxG.width, '');
		BotPlay.setFormat(Paths.font("advanced.ttf"), 60, 0xFFFFFFFF, CENTER);
		BotPlay.scrollFactor.set();
		DevMenu.add(BotPlay);
		
		SkipTime = new FlxText(0, 425, FlxG.width, FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false));
		SkipTime.setFormat(Paths.font("advanced.ttf"), 60, 0xFFFFFFFF, CENTER);
		SkipTime.scrollFactor.set();
		DevMenu.add(SkipTime);
		
		EndSong = new FlxText(0, 585, FlxG.width, '>PRESS HERE<');
		EndSong.setFormat(Paths.font("advanced.ttf"), 60, 0xFFFFFFFF, CENTER);
		EndSong.scrollFactor.set();
		DevMenu.add(EndSong);
		if (TranslationLanguages.Text.exists(EndSong.text) && ClientPrefs.Language != 'English')
			EndSong.text = TranslationLanguages.Text[EndSong.text];
		
		add(DevMenu);
		DevMenu.alpha = 0;
		
		FlxTween.tween(bg, {alpha: 0.7}, 0.30, {
			ease: FlxEase.expoInOut,
		});
		FlxTween.tween(DevMenu, {alpha: 1}, 0.30, {
			ease: FlxEase.expoInOut,
		});

		changeSelection(0, false);

		FlxG.mouse.visible = false;
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (controls.UI_UP_P)
			changeSelection(-1);
		if (controls.UI_DOWN_P)
			changeSelection(1);
			
		if (curSelected == 2) {
			if (controls.UI_LEFT_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				curTime -= 1000;
				holdTime = 0;
			}
			if (controls.UI_RIGHT_P) {
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				curTime += 1000;
				holdTime = 0;
			}
			if(controls.UI_LEFT || controls.UI_RIGHT) {
				holdTime += elapsed;
				if(holdTime > 0.5) {
					curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
				}

				if(curTime >= FlxG.sound.music.length)
					curTime -= FlxG.sound.music.length;
				else if(curTime < 0)
					curTime += FlxG.sound.music.length;
				updateSkipTimeText();
			}
		}
		
		if (controls.ACCEPT) {
			switch(curSelected) {
				case 0:
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
				case 1:
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case 2:
					if(curTime < Conductor.songPosition) {
						PlayState.startOnTime = curTime;
						restartSong(true);
					} else {
						if (curTime != Conductor.songPosition) {
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						close();
					}
				case 3:
					close();
					PlayState.startOnTime = 0;
					PlayState.instance.endSongDEV = true;
					PlayState.instance.finishSong(true);
			}
		}
		
		if (controls.BACK || FlxG.mouse.justPressedRight) {
			close();
			FlxG.sound.play(Paths.sound('unpause', 'shared'), 0.4);
			FlxG.mouse.visible = false;
		}
		
		if (!PlayState.instance.practiceMode)
			PracticeMode.text = '[OFF]';
		else
			PracticeMode.text = '[ON]';
		if (TranslationLanguages.Text.exists(PracticeMode.text) && ClientPrefs.Language != 'English')
			PracticeMode.text = TranslationLanguages.Text[PracticeMode.text];
			
		if (!PlayState.instance.cpuControlled)
			BotPlay.text = '[OFF]';
		else 
			BotPlay.text = '[ON]';
		if (TranslationLanguages.Text.exists(BotPlay.text) && ClientPrefs.Language != 'English')
			BotPlay.text = TranslationLanguages.Text[BotPlay.text];
			
		switch (curSelected) {
			case 0:
				PracticeMode.color = 0xFFFF0000;
				BotPlay.color = 0xFFFFFFFF;
				SkipTime.color = 0xFFFFFFFF;
				EndSong.color = 0xFFFFFFFF;
			case 1:
				BotPlay.color = 0xFFFF0000;
				PracticeMode.color = 0xFFFFFFFF;
				SkipTime.color = 0xFFFFFFFF;
				EndSong.color = 0xFFFFFFFF;
			case 2:
				SkipTime.color = 0xFFFF0000;
				BotPlay.color = 0xFFFFFFFF;
				PracticeMode.color = 0xFFFFFFFF;
				EndSong.color = 0xFFFFFFFF;
			case 3:
				EndSong.color = 0xFFFF0000;
				BotPlay.color = 0xFFFFFFFF;
				SkipTime.color = 0xFFFFFFFF;
				PracticeMode.color = 0xFFFFFFFF;
		}
	}
	override function destroy()
	{
		#if windows
		lime.app.Application.current.window.title = "FNF': Restoration Of Sonic.exe";
		#end
		pauseMusic.stop();
		ClientPrefs.saveSettings();
		pauseMusic.destroy();
		super.destroy();
	}
	function changeSelection(change:Int = 0, ?playS:Bool = true):Void
	{
		if (playS) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected += change;
		if (curSelected < 0)
			curSelected = 3;
		if (curSelected >= 4)
			curSelected = 0;
	}
	function restartSong(noTrans:Bool = false)
	{
		Main.DisableCustomCursor = false;
		FlxG.mouse.visible = false;
		PlayState.instance.paused = true;
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans) {
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		} else {
			Main.InPlaystate = true;
			MusicBeatState.resetState();
		}
	}
	function updateSkipTimeText()
	{
		SkipTime.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}