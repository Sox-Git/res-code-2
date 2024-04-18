package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxCamera;
import Controls;
#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

class GameOverSeriousColdsteelSubstate extends MusicBeatSubstate
{
	public static var instance:GameOverSeriousColdsteelSubstate;

	var coolcamera:FlxCamera;
	var blackScreen:FlxSprite;
	var video:MP4Handler;
	var videoIsFinished:Bool = false;

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new()
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		coolcamera = new FlxCamera();
		coolcamera.bgColor.alpha = 0;
		FlxG.cameras.add(coolcamera);

		Conductor.changeBPM(100);
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);
		blackScreen.cameras = [coolcamera];
		video = new MP4Handler();
		switch(FlxG.random.int(0, 10)) {
			default:
				switch(FlxG.random.int(1, 4)) {
					case 1:
						if (!ClientPrefs.UnlockedGalleryVideos.contains('coldsteelSerious-1')) { ClientPrefs.UnlockedGalleryVideos.push('coldsteelSerious-1'); }
						ClientPrefs.saveSettings();
						video.playVideo(Paths.video('PersonelSeriousGameOvers/1'));
					case 2:
						if (!ClientPrefs.UnlockedGalleryVideos.contains('coldsteelSerious-2')) { ClientPrefs.UnlockedGalleryVideos.push('coldsteelSerious-2'); }
						ClientPrefs.saveSettings();
						video.playVideo(Paths.video('PersonelSeriousGameOvers/2'));
					case 3:
						if (!ClientPrefs.UnlockedGalleryVideos.contains('coldsteelSerious-3')) { ClientPrefs.UnlockedGalleryVideos.push('coldsteelSerious-3'); }
						ClientPrefs.saveSettings();
						video.playVideo(Paths.video('PersonelSeriousGameOvers/3'));
					case 4:
						if (!ClientPrefs.UnlockedGalleryVideos.contains('coldsteelSerious-4')) { ClientPrefs.UnlockedGalleryVideos.push('coldsteelSerious-4'); }
						ClientPrefs.saveSettings();
						video.playVideo(Paths.video('PersonelSeriousGameOvers/4'));
				}
			case 6:
				if (!ClientPrefs.UnlockedGalleryVideos.contains('coldsteelSerious-5')) { ClientPrefs.UnlockedGalleryVideos.push('coldsteelSerious-5'); }
				ClientPrefs.saveSettings();
				video.playVideo(Paths.video('PersonelSeriousGameOvers/Secret'));
		}
		video.finishCallback = function() { videoIsFinished = true; }
		
		#if mobile
		addVirtualPad(NONE, A_B);
		addHitboxCamera();
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);

		if (controls.ACCEPT)
		{
			endBullshit();
			if (!videoIsFinished)
				video.finishVideo();
		}

		if (controls.BACK)
		{
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			if (!videoIsFinished)
				video.finishVideo();
			if(PlayState.isStory) {
				MusicBeatState.switchState(new StoryMenuState());
				FlxG.sound.playMusic(Paths.music('storymode'));
			} else {
				if(PlayState.isEncore) {
					MusicBeatState.switchState(new EncoreState());
					FlxG.sound.playMusic(Paths.music('encoremode'));
				} else {
					if(PlayState.isExtras) {
						MusicBeatState.switchState(new extras.ExtraSongsState());
					} else {
						if(PlayState.isSound) {
							MusicBeatState.switchState(new SoundTestState());
						} else {
							if(PlayState.isFreeplay) {
								MusicBeatState.switchState(new FreeplayState());
								FlxG.sound.playMusic(Paths.music('freeplaymode'));
							} else {
								MusicBeatState.switchState(new MainMenuState());
							}
						}
					}
				}
			}
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				#if android
				FlxTween.tween(virtualPad, {alpha: 0}, 2); //mariomaster was here
				#end
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					Main.InPlaystate = true;
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
