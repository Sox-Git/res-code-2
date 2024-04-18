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
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

using StringTools;

class GalleryModState extends MusicBeatState
{
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	var shaderO:ShaderFilter;
	
	private static var curSelected:Int = 1;
	var CanPress:Bool = false;
	var blackScreen:FlxSprite;
	public static var AlreadyHere:Bool = false;
	
	var VideoIconsSanicOne:FlxSprite;
	var VideoIconsSanicTwo:FlxSprite;
	var VideoIconsSanicThree:FlxSprite;
	var VideoIconsSanicFour:FlxSprite;
	var VideoIconsSanicFive:FlxSprite;
	var VideoIconsSanicSix:FlxSprite;
	var VideoIconsSanicSeven:FlxSprite;
	var VideoIconsSTOne:FlxSprite;
	var VideoIconsSTTwo:FlxSprite;
	var VideoIconsSTThree:FlxSprite;
	var VideoIconsSTFour:FlxSprite;
	var VideoIconsSTFive:FlxSprite;
	var VideoIconsSTSix:FlxSprite;
	var VideoIconsFinalEscape:FlxSprite;
	var VideoIconsSoundTest:FlxSprite;
	var VideoIconsTTCrash:FlxSprite;
	var DaBaby:FlxSprite;
	
	var jesus:Array<Int> = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
	var hitboxes:FlxTypedSpriteGroup<FlxSprite>;
	var hitbox1:FlxSprite;
	var hitbox2:FlxSprite;
	var hitbox3:FlxSprite;
	var hitbox4:FlxSprite;
	var hitbox5:FlxSprite;
	var hitbox6:FlxSprite;
	var hitbox7:FlxSprite;
	var hitbox8:FlxSprite;
	var hitbox9:FlxSprite;
	var hitbox10:FlxSprite;
	var hitbox11:FlxSprite;
	var hitbox12:FlxSprite;
	var hitbox13:FlxSprite;
	var hitbox14:FlxSprite;
	var hitbox15:FlxSprite;
	var hitbox16:FlxSprite;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu (Mod Gallery)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-mod-gallery';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		ClientPrefs.GalleryCanSkip = true;
		
		if (FlxG.sound.music.volume == 0.00045) {
			FlxG.sound.music.fadeIn(0.5, 0, 0.6);
		}

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.filtersEnabled = true;
		camGame.zoom = 0.85;
		if (ClientPrefs.Shaders) {
			shaderO = ExtrasVCRHandler.vcr;
			ExtrasVCRHandler.vcrSet(0.5, false, true, true);
			camGame.setFilters([shaderO]);
		}
		
		VideoIconsSanicOne = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-1'));
		VideoIconsSanicOne.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicOne.scrollFactor.set();
		VideoIconsSanicOne.alpha = 1;
		add(VideoIconsSanicOne);

		VideoIconsSanicTwo = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-2'));
		VideoIconsSanicTwo.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicTwo.scrollFactor.set();
		VideoIconsSanicTwo.alpha = 1;
		add(VideoIconsSanicTwo);
		
		VideoIconsSanicThree = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-3'));
		VideoIconsSanicThree.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicThree.scrollFactor.set();
		VideoIconsSanicThree.alpha = 1;
		add(VideoIconsSanicThree);
		
		VideoIconsSanicFour = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-4'));
		VideoIconsSanicFour.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicFour.scrollFactor.set();
		VideoIconsSanicFour.alpha = 1;
		add(VideoIconsSanicFour);
		
		VideoIconsSanicFive = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-5'));
		VideoIconsSanicFive.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicFive.scrollFactor.set();
		VideoIconsSanicFive.alpha = 1;
		add(VideoIconsSanicFive);

		VideoIconsSanicSix = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-6'));
		VideoIconsSanicSix.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicSix.scrollFactor.set();
		VideoIconsSanicSix.alpha = 1;
		add(VideoIconsSanicSix);

		VideoIconsSanicSeven = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sanic-7'));
		VideoIconsSanicSeven.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSanicSeven.scrollFactor.set();
		VideoIconsSanicSeven.alpha = 1;
		add(VideoIconsSanicSeven);

		VideoIconsSTOne = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-1'));
		VideoIconsSTOne.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSTOne.scrollFactor.set();
		VideoIconsSTOne.alpha = 1;
		add(VideoIconsSTOne);

		VideoIconsSTTwo = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-2'));
		VideoIconsSTTwo.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSTTwo.scrollFactor.set();
		VideoIconsSTTwo.alpha = 1;
		add(VideoIconsSTTwo);

		VideoIconsSTThree = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-3'));
		VideoIconsSTThree.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSTThree.scrollFactor.set();
		VideoIconsSTThree.alpha = 1;
		add(VideoIconsSTThree);

		VideoIconsSTFour = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-4'));
		VideoIconsSTFour.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSTFour.scrollFactor.set();
		VideoIconsSTFour.alpha = 1;
		add(VideoIconsSTFour);

		VideoIconsSTFive = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-5'));
		VideoIconsSTFive.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSTFive.scrollFactor.set();
		VideoIconsSTFive.alpha = 1;
		add(VideoIconsSTFive);

		VideoIconsSTSix = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-6'));
		VideoIconsSTSix.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSTSix.scrollFactor.set();
		VideoIconsSTSix.alpha = 1;
		add(VideoIconsSTSix);
		
		VideoIconsFinalEscape = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/final-escape'));
		VideoIconsFinalEscape.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsFinalEscape.scrollFactor.set();
		VideoIconsFinalEscape.alpha = 1;
		add(VideoIconsFinalEscape);
		
		VideoIconsSoundTest = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/sound-test-codes'));
		VideoIconsSoundTest.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsSoundTest.scrollFactor.set();
		VideoIconsSoundTest.alpha = 1;
		add(VideoIconsSoundTest);
		
		VideoIconsTTCrash = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/video-icons/tt-crash'));
		VideoIconsTTCrash.antialiasing = ClientPrefs.globalAntialiasing;
		VideoIconsTTCrash.scrollFactor.set();
		VideoIconsTTCrash.alpha = 1;
		add(VideoIconsTTCrash);
		
		for (i in 0...jesus.length)
		{
			var playAndLock:FlxSprite = new FlxSprite();
			playAndLock.ID = i;
			switch(i) {
				case 0: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-1')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/1'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/1'));
							VideoIconsSanicOne.color = 0xFF161616;
						}
				case 1: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-2')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/2'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/2'));
							VideoIconsSanicTwo.color = 0xFF161616;
						}
				case 2: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-3')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/3'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/3'));
							VideoIconsSanicThree.color = 0xFF161616;
						}
				case 3: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-4')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/4'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/4'));
							VideoIconsSanicFour.color = 0xFF161616;
						}
				case 4: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-5')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/5'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/5'));
							VideoIconsSanicFive.color = 0xFF161616;
						}
				case 5: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-6')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/6'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/6'));
							VideoIconsSanicSix.color = 0xFF161616;
						}
				case 6: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-7')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/7'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/7'));
							VideoIconsSanicSeven.color = 0xFF161616;
						}
				case 7: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-1')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/8'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/8'));
							VideoIconsSTOne.color = 0xFF161616;
						}
				case 8: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-2')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/9'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/9'));
							VideoIconsSTTwo.color = 0xFF161616;
						}
				case 9: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-3')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/10'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/10'));
							VideoIconsSTThree.color = 0xFF161616;
						}
				case 10: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-4')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/11'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/11'));
							VideoIconsSTFour.color = 0xFF161616;
						}
				case 11: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-5')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/12'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/12'));
							VideoIconsSTFive.color = 0xFF161616;
						}
				case 12: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-6')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/13'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/13'));
							VideoIconsSTSix.color = 0xFF161616;
						}
				case 13: if (ClientPrefs.UnlockedGalleryVideos.contains('fe-intro')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/14'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/14'));
							VideoIconsFinalEscape.color = 0xFF161616;
						}
				case 14: if (ClientPrefs.UnlockedGalleryVideos.contains('st-codes')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/15'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/15'));
							VideoIconsSoundTest.color = 0xFF161616;
						}
				case 15: if (ClientPrefs.UnlockedGalleryVideos.contains('tt-final')) {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/play/16'));
						} else {
							playAndLock.loadGraphic(Paths.image('extra/gallery/mod/locked/16'));
							VideoIconsTTCrash.color = 0xFF161616;
						}
			}
			playAndLock.antialiasing = ClientPrefs.globalAntialiasing;
			playAndLock.scrollFactor.set();
			add(playAndLock);
		}		
		
		hitboxes = new FlxTypedSpriteGroup<FlxSprite>();
		add(hitboxes);
		hitbox1 = new FlxSprite(15,13).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox1);
		hitbox2 = new FlxSprite(335,13).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox2);
		hitbox3 = new FlxSprite(656,13).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox3);
		hitbox4 = new FlxSprite(975,13).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox4);
		hitbox5 = new FlxSprite(15,192).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox5);
		hitbox6 = new FlxSprite(335,192).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox6);
		hitbox7 = new FlxSprite(656,192).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox7);
		hitbox8 = new FlxSprite(975,192).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox8);
		hitbox9 = new FlxSprite(15,371).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox9);
		hitbox10 = new FlxSprite(335,371).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox10);
		hitbox11 = new FlxSprite(656,371).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox11);
		hitbox12 = new FlxSprite(975,371).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox12);
		hitbox13 = new FlxSprite(15,550).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox13);
		hitbox14 = new FlxSprite(335,550).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox14);
		hitbox15 = new FlxSprite(656,550).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox15);
		hitbox16 = new FlxSprite(975,550).makeGraphic(289, 156, 0x00000000);
		hitboxes.add(hitbox16);

		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);
		DaBaby = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/gallery/mod/text'));
		DaBaby.antialiasing = ClientPrefs.globalAntialiasing;
		DaBaby.scrollFactor.set();
		DaBaby.alpha = 0;
		add(DaBaby);
		
		Select(curSelected, '', false);
		if (!AlreadyHere) {
			FlxTween.tween(DaBaby, {alpha: 1}, 0.25, {});
			new FlxTimer().start(0.5, function(tmr:FlxTimer) {
				FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {});
				FlxTween.tween(DaBaby, {alpha: 0}, 0.5, {});
				CanPress = true;
				AlreadyHere = true;
			});
		} else {
			blackScreen.alpha = 0;
			CanPress = true;
		}
		super.create();
	}
	
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if ((controls.BACK || FlxG.mouse.justPressedRight) && CanPress)
		{
			ClientPrefs.GalleryCanSkip = false;
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new GalleryState());
			});
			CanPress = false;
		}
		
		if (CanPress) {
			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			if (!FlxG.mouse.overlaps(hitboxes)) {
				if (controls.UI_UP_P) Select(0, 'up');
				if (controls.UI_DOWN_P) Select(0, 'down');
				if (controls.UI_LEFT_P)
				{
					Select(-shiftMult, 'left');
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					Select(shiftMult, 'right');
					holdTime = 0;
				}
				if (controls.UI_LEFT || controls.UI_RIGHT)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						if (controls.UI_LEFT) Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult), 'left');
						if (controls.UI_RIGHT) Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult), 'right');
					}
				}
				if (FlxG.mouse.wheel != 0)
				{
					if (FlxG.mouse.wheel > 0) Select(-shiftMult * FlxG.mouse.wheel,'left');
					if (FlxG.mouse.wheel < 0) Select(-shiftMult * FlxG.mouse.wheel,'right');
					holdTime = 0;
				}
			}
			if (FlxG.mouse.overlaps(hitbox1) && curSelected != 1) Select(1,'',true,true);
			if (FlxG.mouse.overlaps(hitbox2) && curSelected != 2) Select(2,'',true,true);
			if (FlxG.mouse.overlaps(hitbox3) && curSelected != 3) Select(3,'',true,true);
			if (FlxG.mouse.overlaps(hitbox4) && curSelected != 4) Select(4,'',true,true);
			if (FlxG.mouse.overlaps(hitbox5) && curSelected != 5) Select(5,'',true,true);
			if (FlxG.mouse.overlaps(hitbox6) && curSelected != 6) Select(6,'',true,true);
			if (FlxG.mouse.overlaps(hitbox7) && curSelected != 7) Select(7,'',true,true);
			if (FlxG.mouse.overlaps(hitbox8) && curSelected != 8) Select(8,'',true,true);
			if (FlxG.mouse.overlaps(hitbox9) && curSelected != 9) Select(9,'',true,true);
			if (FlxG.mouse.overlaps(hitbox10) && curSelected != 10) Select(10,'',true,true);
			if (FlxG.mouse.overlaps(hitbox11) && curSelected != 11) Select(11,'',true,true);
			if (FlxG.mouse.overlaps(hitbox12) && curSelected != 12) Select(12,'',true,true);
			if (FlxG.mouse.overlaps(hitbox13) && curSelected != 13) Select(13,'',true,true);
			if (FlxG.mouse.overlaps(hitbox14) && curSelected != 14) Select(14,'',true,true);
			if (FlxG.mouse.overlaps(hitbox15) && curSelected != 15) Select(15,'',true,true);
			if (FlxG.mouse.overlaps(hitbox16) && curSelected != 16) Select(16,'',true,true);


			if (controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(hitboxes))) {
				switch(curSelected) {
					case 1: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-1')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/1'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 2: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-2')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/2'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 3: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-3')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/3'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 4: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-4')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/4'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 5: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-5')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/5'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 6: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-6')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/6'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 7: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-7')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SanicGameOvers/7'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 8: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-1')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SoundTest/Musicians'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 9: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-2')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SoundTest/ArtFlex'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 10: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-3')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SoundTest/BeOneWithRestored'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 11: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-4')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SoundTest/GSBL'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 12: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-5')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SoundTest/SpiderSonic'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 13: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-6')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('SoundTest/RestoredIsDead'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 14: if (ClientPrefs.UnlockedGalleryVideos.contains('fe-intro')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('sonicexe-intro-fe'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 15: if (ClientPrefs.UnlockedGalleryVideos.contains('st-codes')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('sound-test-codes'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
					case 16: if (ClientPrefs.UnlockedGalleryVideos.contains('tt-final')) {
							FlxG.sound.play(Paths.sound('tick'), 0.4);
							FlxG.sound.music.volume = 0.00045;
							var video:MP4Handler = new MP4Handler();
							video.playVideo(Paths.video('tt-final'));
							video.finishCallback = function() {	MusicBeatState.switchState(new extras.GalleryModState()); }
							CanPress = false;
						}
				}
			}
		}
	}
	
	function Select(oaoao:Int = 1, to:String = '', ?PlayTick:Bool = true, ?mouse:Bool = false) {
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		if (!mouse) {
			if (CanPress) {
				switch(to) {
					case 'left' | 'right':
						curSelected += oaoao;
						if (curSelected < 1)
							curSelected = 16;
						if (curSelected > 16)
							curSelected = 1;
					case 'up':
						switch(curSelected){
							case 5: curSelected = 1;
							case 6: curSelected = 2;
							case 7: curSelected = 3;
							case 8: curSelected = 4;
							case 9: curSelected = 5;
							case 10: curSelected = 6;
							case 11: curSelected = 7;
							case 12: curSelected = 8;
							case 13: curSelected = 9;
							case 14: curSelected = 10;
							case 15: curSelected = 11;
							case 16: curSelected = 12;
						}
					case 'down':
						switch(curSelected){
							case 1: curSelected = 5;
							case 2: curSelected = 6;
							case 3: curSelected = 7;
							case 4: curSelected = 8;
							case 5: curSelected = 9;
							case 6: curSelected = 10;
							case 7: curSelected = 11;
							case 8: curSelected = 12;
							case 9: curSelected = 13;
							case 10: curSelected = 14;
							case 11: curSelected = 15;
							case 12: curSelected = 16;
						}
				}
			} else {
				curSelected = oaoao;
			}
		} else {
			curSelected = oaoao;
		}
	
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-1')) VideoIconsSanicOne.color = 0xFF444444;
		else VideoIconsSanicOne.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-2')) VideoIconsSanicTwo.color = 0xFF444444;
		else VideoIconsSanicTwo.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-3')) VideoIconsSanicThree.color = 0xFF444444;
		else VideoIconsSanicThree.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-4')) VideoIconsSanicFour.color = 0xFF444444;
		else VideoIconsSanicFour.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-5')) VideoIconsSanicFive.color = 0xFF444444;
		else VideoIconsSanicFive.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-6')) VideoIconsSanicSix.color = 0xFF444444;
		else VideoIconsSanicSix.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-7')) VideoIconsSanicSeven.color = 0xFF444444;
		else VideoIconsSanicSeven.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-1')) VideoIconsSTOne.color = 0xFF444444;
		else VideoIconsSTOne.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-2')) VideoIconsSTTwo.color = 0xFF444444;
		else VideoIconsSTTwo.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-3')) VideoIconsSTThree.color = 0xFF444444;
		else VideoIconsSTThree.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-4')) VideoIconsSTFour.color = 0xFF444444;
		else VideoIconsSTFour.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-5')) VideoIconsSTFive.color = 0xFF444444;
		else VideoIconsSTFive.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-6')) VideoIconsSTSix.color = 0xFF444444;
		else VideoIconsSTSix.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('fe-intro')) VideoIconsFinalEscape.color = 0xFF444444;
		else VideoIconsFinalEscape.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('st-codes')) VideoIconsSoundTest.color = 0xFF444444;
		else VideoIconsSoundTest.color = 0xFF161616;
		if (ClientPrefs.UnlockedGalleryVideos.contains('tt-final')) VideoIconsTTCrash.color = 0xFF444444;
		else VideoIconsTTCrash.color = 0xFF161616;
	
		switch(curSelected) {
			case 1: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-1')) VideoIconsSanicOne.color = 0xFFFFFFFF;
					else VideoIconsSanicOne.color = 0xFF444444;
			case 2: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-2')) VideoIconsSanicTwo.color = 0xFFFFFFFF;
					else VideoIconsSanicTwo.color = 0xFF444444;
			case 3: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-3')) VideoIconsSanicThree.color = 0xFFFFFFFF;
					else VideoIconsSanicThree.color = 0xFF444444;
			case 4: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-4')) VideoIconsSanicFour.color = 0xFFFFFFFF;
					else VideoIconsSanicFour.color = 0xFF444444;
			case 5: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-5')) VideoIconsSanicFive.color = 0xFFFFFFFF;
					else VideoIconsSanicFive.color = 0xFF444444;
			case 6: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-6')) VideoIconsSanicSix.color = 0xFFFFFFFF;
					else VideoIconsSanicSix.color = 0xFF444444;
			case 7: if (ClientPrefs.UnlockedGalleryVideos.contains('sanic-7')) VideoIconsSanicSeven.color = 0xFFFFFFFF;
					else VideoIconsSanicSeven.color = 0xFF444444;
			case 8: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-1')) VideoIconsSTOne.color = 0xFFFFFFFF;
					else VideoIconsSTOne.color = 0xFF444444;
			case 9: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-2')) VideoIconsSTTwo.color = 0xFFFFFFFF;
					else VideoIconsSTTwo.color = 0xFF444444;
			case 10: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-3')) VideoIconsSTThree.color = 0xFFFFFFFF;
					else VideoIconsSTThree.color = 0xFF444444;
			case 11: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-4')) VideoIconsSTFour.color = 0xFFFFFFFF;
					else VideoIconsSTFour.color = 0xFF444444;
			case 12: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-5')) VideoIconsSTFive.color = 0xFFFFFFFF;
					else VideoIconsSTFive.color = 0xFF444444;
			case 13: if (ClientPrefs.UnlockedGalleryVideos.contains('sound-test-6')) VideoIconsSTSix.color = 0xFFFFFFFF;
					else VideoIconsSTSix.color = 0xFF444444;
			case 14: if (ClientPrefs.UnlockedGalleryVideos.contains('fe-intro')) VideoIconsFinalEscape.color = 0xFFFFFFFF;
					else VideoIconsFinalEscape.color = 0xFF444444;
			case 15: if (ClientPrefs.UnlockedGalleryVideos.contains('st-codes')) VideoIconsSoundTest.color = 0xFFFFFFFF;
					else VideoIconsSoundTest.color = 0xFF444444;
			case 16: if (ClientPrefs.UnlockedGalleryVideos.contains('tt-final')) VideoIconsTTCrash.color = 0xFFFFFFFF;
					else VideoIconsTTCrash.color = 0xFF444444;

		}
	}
}