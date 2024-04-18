package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.util.FlxTimer; 
import flixel.input.gamepad.FlxGamepad; 
import flash.text.TextField; 
import flixel.FlxG; 
import flixel.FlxSprite; 
import flixel.addons.display.FlxGridOverlay; 
import flixel.group.FlxGroup.FlxTypedGroup; 
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup; 
import flixel.addons.transition.FlxTransitionableState; 
import flixel.math.FlxMath; 
import flixel.text.FlxText; 
import flixel.util.FlxColor; 
import flixel.tweens.FlxEase; 
import flixel.tweens.FlxTween; 
import lime.utils.Assets; 
import flixel.FlxCamera;
import flixel.system.FlxSound; 
import sys.FileSystem; 
import flixel.addons.display.FlxBackdrop; 
import flixel.addons.effects.FlxSkewedSprite;
import shaders.GlitchShader.Fuck;
import openfl.filters.ShaderFilter;
import flixel.math.FlxRandom;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.DisplacementMapFilterMode;
import openfl.geom.Point;
import openfl.filters.DisplacementMapFilter;
import openfl.filters.BitmapFilter;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.FlxObject;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var scoreBG:FlxSprite;
	var artItems:FlxTypedGroup<FlxSprite>;
	var coverBorders:FlxTypedGroup<FlxSprite>;
	var artStatic:FlxTypedGroup<FlxSprite>;
	var whiteshit:FlxSprite;
	var blackbg:FlxSprite;
	var scorchedMoment:FlxSprite;
	var hitboxEnterO:FlxSprite;
	
	var bg:FlxBackdrop;
	var fg:FlxBackdrop;
	
	var charText:FlxText;
	var scoreText:FlxText;
	var textList:FlxTypedGroup<FlxText>;
	
	public static var curSelected:Int = 0;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var sm_cur:Int = 0;
	var intendedColor:Int;
	var countShit:Int = 0;
	var glitchNum:Float = 0;
	var glitchAmount:Float = 0;
	var ErrorsSpeed:Float = 0;
	
	var selectingMode:Bool = false;
	var canScroll:Bool = true;
	var canControl:Bool = true;
	var shit:Bool = false;
	var glitch:Bool = false;
	var DisableGlitch:Bool = false;
	var musicVol:Bool = true;
	var scorchedMomentRN:Bool = false;
	var FatalErrors:Bool = false;
	var Error:Bool = false;
	var ErrorMouse:Bool = false;
	var GoreContent:Bool = false;
	var GoreWarningMenu:Bool = false;
	
	var charArray:Array<String>; 
	var charUnlocked:Array<String>; 
	var beatedSongs:Array<String>; 
	var songSelected:String;
	var okay:Array<String>;
	var bruuuhh:String;
	var artName:String;
	
	var camGame:FlxCamera;
	var camOther:FlxCamera;
	var intendedRating:Float = 0;
	var GlitchMusic:FlxSound;
	var errorRandom:FlxRandom = new FlxRandom(666);
	var ErrorTimer:FlxTimer = null;
	var ShittyErrorTimer:FlxTimer = null;
	
	var camFuckShader:Fuck;
	var camFuckFilter:ShaderFilter;
	var displacementFilter:DisplacementMapFilter;
	var shaders = new Array<BitmapFilter>();
	var shadersEmpty = new Array<BitmapFilter>();
	
	var hitboxes:FlxTypedSpriteGroup<FlxSprite>;
	var hitbox1:FlxSprite;
	var hitbox2:FlxSprite;
	var hitbox3:FlxSprite;
	var hitbox4:FlxSprite;
	var hitbox5:FlxSprite;
	var hitbox6:FlxSprite;
	var hitbox7:FlxSprite;
	var hitbox8:FlxSprite;

	var TooFarChoice:FlxTypedSpriteGroup<FlxSprite>;
	var TooFarVerOne:FlxSprite;
	var TooFarVerTwo:FlxSprite;
	var TooFarWindow:FlxSprite;
	var TooFarChoiceExit:FlxSprite;
	var TooFarSelection:Bool = false;
	var TooFarSelectedOne:Bool = true;
	var TooFarMenuCanControl:Bool = false;
	var DeniedSound:Bool = false;
	
	var EndlessChoice:FlxTypedSpriteGroup<FlxSprite>;
	var EndlessVerOne:FlxSprite;
	var EndlessVerTwo:FlxSprite;
	var EndlessVerThree:FlxSprite;
	var EndlessVerFour:FlxSprite;
	var EndlessWindow:FlxSprite;
	var EndlessChoiceExit:FlxSprite;
	var EndlessSelectedNum:Int = 0;
	var EndlessSelection:Bool = false;
	var EndlessMenuCanControl:Bool = false;
	
	var CurseChoice:FlxTypedSpriteGroup<FlxSprite>;
	var CurseGoodEnding:FlxSprite;
	var CurseBadEnding:FlxSprite;
	var CurseWindow:FlxSprite;
	var CurseChoiceExit:FlxSprite;
	var CurseEndingSelection:Bool = false;
	var CurseSelectedGood:Bool = true;
	var CurseMenuCanControl:Bool = false;
	public static var goreCloseShit:Bool = false;
	
	var scoreChoiceText:FlxText;
	var scoreChoiceSongSeleted:String = '';
	var lerpChoiceScore:Int = 0;
	var lerpChoiceRating:Float = 0;
	var intendedChoiceScore:Int = 0;
	var intendedChoiceRating:Float = 0;

	var Checkbox:FlxSprite;
	var CheckboxCheck:FlxSprite;
	var ShowCutscene:FlxText;

	override function create()
	{
		Paths.clearUnusedMemory();
		goreCloseShit = false;
		persistentUpdate = persistentDraw = true;
		
		if (FlxG.sound.music == null || !FlxG.sound.music.playing) {
			FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.7);
		}

		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;

		CharSongList.init(); 
		charArray = CharSongList.characters;
		charUnlocked = ClientPrefs.charactersUnlocked;
		beatedSongs = ClientPrefs.SongsCompleted;
		okay = CharSongList.getSongsByChar(charArray[curSelected]);
		songSelected = okay[sm_cur];
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camOther = new FlxCamera();
		camOther.bgColor.alpha = 0;
		FlxG.cameras.add(camOther);
		
		FlxG.sound.playMusic(Paths.music('freeplaymode'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);

		PlayState.isStory = false;
		PlayState.isEncore = false;
		PlayState.isExtras = false;
		PlayState.isSound = false;
		PlayState.isFreeplay = true;
			
		PlayState.BFEncoreSkins = false;
		PlayState.BFSkins = false;
		PlayState.GFEncoreSkins = false;
		PlayState.GFSkins = false;
			 
		PlayState.ChaosCutscene = true;
		PlayState.showSTCutscene = true;

		GlitchMusic = new FlxSound().loadEmbedded(Paths.music('storymodemenumusic-glitch', 'preload'), true, true);
		GlitchMusic.volume = 0;
		GlitchMusic.play();
		FlxG.sound.list.add(GlitchMusic);

		bg = new FlxBackdrop(Paths.image('freeplay-encore/backgroundlool'), 1, 1, true, false);
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		fg = new FlxBackdrop(Paths.image('freeplay-encore/sidebar'), 1, 1, false, true);
		fg.antialiasing = ClientPrefs.globalAntialiasing;
		add(fg);

		var blackLine:FlxSprite = new FlxSprite().makeGraphic(15, Std.int(FlxG.height * 1.5), FlxColor.BLACK);
		blackLine.screenCenter();
		blackLine.x -= 320;
		add(blackLine);

		artItems = new FlxTypedGroup<FlxSprite>();
		add(artItems);

		artStatic = new FlxTypedGroup<FlxSprite>();
		add(artStatic);

		coverBorders = new FlxTypedGroup<FlxSprite>();
		add(coverBorders);

		textList = new FlxTypedGroup<FlxText>();
		add(textList);
		
		for (i in 0...charArray.length)
		{
			if (charUnlocked.contains(charArray[i])) {
				#if desktop
				if (FileSystem.exists('assets/images/freeplay-encore/freeplay/' + charArray[i].toLowerCase() + '.png')) {
					if (beatedSongs.contains(CharSongList.getSongsByChar(charArray[i])[0]))
						artName = charArray[i];
					else
						artName = 'uncompleted';
				} else {
					artName = 'placeholder';
				}
				#else
				if (beatedSongs.contains(CharSongList.getSongsByChar(charArray[i])[0]))
					artName = charArray[i];
				else
					artName = 'uncompleted';
				#end
			} else {
				artName = 'locked';
			}
			
			#if debug
			countShit += 1;
			bruuuhh = Std.string(countShit);
			trace('artName: #' + bruuuhh + ' - ' + artName);
			#end

			var art:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplay-encore/freeplay/' + artName)); 
			art.ID = i;
			art.scale.set(0.55, 0.55);
			art.antialiasing = ClientPrefs.globalAntialiasing;
			var spot = ((FlxG.height / 2) - (art.frameHeight / 2)) - (400 * (0 - i));
			art.y = spot;
			artItems.add(art);

			var artStat:FlxSprite = new FlxSprite();
			artStat.frames = Paths.getSparrowAtlas('freeplay-encore/static');
			artStat.animation.addByPrefix('static', 'static', 24, true);
			artStat.animation.play('static');
			artStat.x = art.x;
			artStat.y = spot;
			artStat.scale.set(0.56, 0.56);
			artStat.antialiasing = ClientPrefs.globalAntialiasing;
			artStat.ID = i;
			artStatic.add(artStat);

			var cover:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplay-encore/FreeBox'));
			cover.ID = i;
			cover.scale.set(0.55, 0.55);
			cover.antialiasing = ClientPrefs.globalAntialiasing;
			coverBorders.add(cover);
		}

		hitboxEnterO = new FlxSprite(126,213).makeGraphic(378, 294, 0x00000000);
		add(hitboxEnterO);

		if (charUnlocked.contains(charArray[0])) charText = new FlxText(0, 25, 0, "majin", 32);
		else charText = new FlxText(0 , 25, 0, "???", 32); 
		charText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), charText.size, FlxColor.WHITE, CENTER);
		charText.screenCenter(X);
		add(charText);

		scoreText = new FlxText(FlxG.width * 0.7, charText.y + 65, 0, "", 16);
		scoreText.screenCenter(X);
		scoreText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), scoreText.size, FlxColor.WHITE, RIGHT);
		add(scoreText);

		Checkbox = new FlxSprite(FlxG.width - 68, FlxG.height - 72).loadGraphic(Paths.image('checkbox'));
		Checkbox.antialiasing = ClientPrefs.globalAntialiasing;
		Checkbox.alpha = 0;
		add(Checkbox);	
		
		CheckboxCheck = new FlxSprite(FlxG.width - 68, FlxG.height - 72).loadGraphic(Paths.image('checkbox-check'));
		CheckboxCheck.antialiasing = ClientPrefs.globalAntialiasing;
		CheckboxCheck.alpha = 0;
		add(CheckboxCheck);	
		
		ShowCutscene = new FlxText(-68, FlxG.height - 54, FlxG.width, "Cutscene", 22);
		ShowCutscene.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 22, 0xFFFF0000, RIGHT);
		ShowCutscene.alpha = 0;
		add(ShowCutscene);
		if (TranslationLanguages.Text.exists(ShowCutscene.text) && ClientPrefs.Language != 'English')
			ShowCutscene.text = TranslationLanguages.Text[ShowCutscene.text];

		hitboxes = new FlxTypedSpriteGroup<FlxSprite>();
		add(hitboxes);
		hitbox1 = new FlxSprite(659,221).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox1);
		hitbox2 = new FlxSprite(659,263).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox2);
		hitbox3 = new FlxSprite(659,305).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox3);
		hitbox4 = new FlxSprite(659,347).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox4);
		hitbox5 = new FlxSprite(659,389).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox5);
		hitbox6 = new FlxSprite(659,431).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox6);
		hitbox7 = new FlxSprite(659,473).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox7);
		hitbox8 = new FlxSprite(659,515).makeGraphic(621, 40, 0x00000000);
		hitboxes.add(hitbox8);

		changeSelection();
		changeDiff();
		mouseHitboxes(okay.length);
		
		blackbg = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK); 
		blackbg.alpha = 0; 
		add(blackbg);
		
		
		TooFarChoice = new FlxTypedSpriteGroup<FlxSprite>();
		add(TooFarChoice);
		TooFarVerOne = new FlxSprite(137, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-far/ver-1'));
		TooFarVerOne.antialiasing = ClientPrefs.globalAntialiasing;
		TooFarChoice.add(TooFarVerOne);
		if (ClientPrefs.SongsCompleted.contains('too-far'))
			TooFarVerTwo = new FlxSprite(643, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-far/ver-2'));
		else
			TooFarVerTwo = new FlxSprite(643, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-far/ver-2-locked'));
		TooFarVerTwo.antialiasing = ClientPrefs.globalAntialiasing;
		TooFarChoice.add(TooFarVerTwo);
		TooFarWindow = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay-encore/song-version-select/too-far/window'));
		TooFarWindow.antialiasing = ClientPrefs.globalAntialiasing;
		TooFarWindow.screenCenter();
		TooFarChoice.add(TooFarWindow);
		TooFarChoiceExit = new FlxSprite(118, 45).loadGraphic(Paths.image('exit'));
		TooFarChoiceExit.antialiasing = ClientPrefs.globalAntialiasing;
		TooFarChoice.add(TooFarChoiceExit);
		TooFarChoice.forEach(function(spr:FlxSprite) {
			spr.alpha = 0;
		});
		
		
		EndlessChoice = new FlxTypedSpriteGroup<FlxSprite>();
		add(EndlessChoice);
		EndlessVerOne = new FlxSprite(137, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-1'));
		EndlessVerOne.antialiasing = ClientPrefs.globalAntialiasing;
		EndlessChoice.add(EndlessVerOne);
		if (ClientPrefs.SongsCompleted.contains('endless'))
			EndlessVerTwo = new FlxSprite(643, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-2'));
		else
			EndlessVerTwo = new FlxSprite(643, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-2-locked'));
		EndlessVerTwo.antialiasing = ClientPrefs.globalAntialiasing;
		EndlessChoice.add(EndlessVerTwo);
		if (ClientPrefs.SongsCompleted.contains('endless'))
			EndlessVerThree = new FlxSprite(137, 401).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-3'));
		else
			EndlessVerThree = new FlxSprite(137, 401).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-3-locked'));
		EndlessVerThree.antialiasing = ClientPrefs.globalAntialiasing;
		EndlessChoice.add(EndlessVerThree);
		if (ClientPrefs.SongsCompleted.contains('endless'))
			EndlessVerFour = new FlxSprite(643, 401).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-4'));
		else
			EndlessVerFour = new FlxSprite(643, 401).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/ver-4-locked'));
		EndlessVerFour.antialiasing = ClientPrefs.globalAntialiasing;
		EndlessChoice.add(EndlessVerFour);
		EndlessWindow = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay-encore/song-version-select/endless/window'));
		EndlessWindow.antialiasing = ClientPrefs.globalAntialiasing;
		EndlessWindow.screenCenter();
		EndlessChoice.add(EndlessWindow);
		EndlessChoiceExit = new FlxSprite(118, 45).loadGraphic(Paths.image('exit'));
		EndlessChoiceExit.antialiasing = ClientPrefs.globalAntialiasing;
		EndlessChoice.add(EndlessChoiceExit);
		EndlessChoice.forEach(function(spr:FlxSprite) {
			spr.alpha = 0;
		});
		
		
		CurseChoice = new FlxTypedSpriteGroup<FlxSprite>();
		add(CurseChoice);
		if (ClientPrefs.UnlockedEndings.contains('curse-good'))
			CurseGoodEnding = new FlxSprite(137, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/curse-ending/good'));
		else
			CurseGoodEnding = new FlxSprite(137, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/curse-ending/good-locked'));
		CurseGoodEnding.antialiasing = ClientPrefs.globalAntialiasing;
		CurseChoice.add(CurseGoodEnding);
		if (ClientPrefs.UnlockedEndings.contains('curse-bad'))
			CurseBadEnding = new FlxSprite(643, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/curse-ending/bad'));
		else
			CurseBadEnding = new FlxSprite(643, 156).loadGraphic(Paths.image('freeplay-encore/song-version-select/curse-ending/bad-locked'));
		CurseBadEnding.antialiasing = ClientPrefs.globalAntialiasing;
		CurseChoice.add(CurseBadEnding);
		CurseWindow = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay-encore/song-version-select/curse-ending/window'));
		CurseWindow.antialiasing = ClientPrefs.globalAntialiasing;
		CurseWindow.screenCenter();
		CurseChoice.add(CurseWindow);
		CurseChoiceExit = new FlxSprite(118, 45).loadGraphic(Paths.image('exit'));
		CurseChoiceExit.antialiasing = ClientPrefs.globalAntialiasing;
		CurseChoice.add(CurseChoiceExit);
		CurseChoice.forEach(function(spr:FlxSprite) {
			spr.alpha = 0;
		});
		
		scoreChoiceText = new FlxText(0, FlxG.height - 65, 0, "", 20);
		scoreChoiceText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), scoreChoiceText.size, FlxColor.WHITE, RIGHT);
		scoreChoiceText.screenCenter(X);
		scoreChoiceText.visible = false;
		add(scoreChoiceText);
		
		whiteshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE); 
		whiteshit.alpha = 0; 
		add(whiteshit);

		scorchedMoment = new FlxSprite().loadGraphic(Paths.image('scorched'));
		scorchedMoment.screenCenter();
		scorchedMoment.antialiasing = ClientPrefs.globalAntialiasing;
		scorchedMoment.alpha = 0; 
		add(scorchedMoment);

		if (ClientPrefs.Shaders) {
			camFuckShader = new Fuck();
			camFuckFilter = new ShaderFilter(camFuckShader);
			camGame.setFilters([camFuckFilter]);
		}

		#if desktop
		var rpcName:String = 'In Freeplay Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.smallImageRpc = '';
		DiscordClient.changePresence(rpcName, null);
		artItems.forEach(function(obj:FlxSprite) {
			if (obj.ID == curSelected) {
				switch(charArray[curSelected]) {
					case 'lord x':
						if (charUnlocked.contains('lord x')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'lord-x';
									DiscordClient.changePresence();
								case 'execution':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'execution';
									DiscordClient.changePresence();
								case 'hellbent':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'hellbent';
									DiscordClient.changePresence();
								case 'fate':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'fate';
									DiscordClient.changePresence();
								case 'judgement':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'judgement';
									DiscordClient.changePresence();
								case 'gatekeepers':
									DiscordClient.imageRpc = 'guardians';
									DiscordClient.changePresence();
							}
						} else {
							switch(songSelected.toLowerCase())
							{
								default:
									DiscordClient.imageRpc = 'locked';
									DiscordClient.changePresence();
								case 'gatekeepers':
									DiscordClient.imageRpc = 'locked';
									DiscordClient.changePresence();
							}
						}
					case 'hog':
						if (charUnlocked.contains('hog')) {
							switch(songSelected.toLowerCase())
							{
								case 'hedge':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'hog';
									DiscordClient.changePresence();
								case 'manual-blast':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'scorched';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'faker':
						if (charUnlocked.contains('faker')) {
							switch(songSelected.toLowerCase())
							{
								case 'faker':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'faker';
									DiscordClient.changePresence();
								case 'black-sun':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'exe';
									DiscordClient.changePresence();
								case 'godspeed':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'godspeed';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'furnace':
						if (charUnlocked.contains('furnace')) {
							switch(songSelected.toLowerCase())
							{
								case 'prey':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'furnace';
									DiscordClient.changePresence();
								case 'fight-or-flight':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'starved';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'coldsteel':
						if (charUnlocked.contains('coldsteel')) {
							switch(songSelected.toLowerCase())
							{
								case 'personel':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'coldsteel';
									DiscordClient.changePresence();
								case 'personel-serious':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'coldsteel-serious';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'melthog':
						if (charUnlocked.contains('melthog')) {
							switch(songSelected.toLowerCase())
							{
								case 'melting':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'melthog';
									DiscordClient.changePresence();
								case 'confronting':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'confronting';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'curse':
						if (charUnlocked.contains('curse')) {
							switch(songSelected.toLowerCase())
							{
								case 'malediction':
									if (!ClientPrefs.SongsCompleted.contains('malediction'))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'curse';
									DiscordClient.changePresence();
								case "'choice-of-ending'":
									if (!ClientPrefs.SongsCompleted.contains('malediction'))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'curse';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'fatal error':
						if (charUnlocked.contains('fatal error')) {
							switch(songSelected.toLowerCase())
							{
								case 'fatality':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'fatal-error';
									DiscordClient.changePresence();
								case 'critical-error':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'critical-error';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'tails doll':
						if (charUnlocked.contains('tails doll')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'tails-doll';
									DiscordClient.changePresence();
								case 'soulless':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'soulless';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'no name':
						if (charUnlocked.contains('no name')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'no-name';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'normal cd':
						if (charUnlocked.contains('normal cd')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'normal-cd';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'mono.bw':
						if (charUnlocked.contains('mono.bw')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'mono_bw';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'shp and genesys':
						if (charUnlocked.contains('shp and genesys')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'shp-and-genesys';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'sonic.lmn':
						if (charUnlocked.contains('sonic.lmn')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'sonic_lmn';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'ugly sonic':
						if (charUnlocked.contains('ugly sonic')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'ugly-sonic';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'lumpy sonic':
						if (charUnlocked.contains('lumpy sonic')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'lumpy-sonic';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'demogri':
						if (charUnlocked.contains('demogri')) {
							switch(songSelected.toLowerCase())
							{
								case 'insidious':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'insidious';
									DiscordClient.changePresence();
								case 'haze':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'haze';
									DiscordClient.changePresence();
								case 'marauder':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'demogri-and-griatos';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'sh tails':
						if (charUnlocked.contains('sh tails')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'sh-tails';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'needlemouse':
						if (charUnlocked.contains('needlemouse')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'needlemouse';
									DiscordClient.changePresence();
								case 'round-a-bout':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'roundabout';
									DiscordClient.changePresence();
								case 'spike-trap':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'spike-trap';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'xterion':
						if (charUnlocked.contains('xterion')) {
							switch(songSelected.toLowerCase())
							{
								case 'substantial':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'xterion';
									DiscordClient.changePresence();
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'digitalized';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'majin':
						if (charUnlocked.contains('majin')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'majin';
									DiscordClient.changePresence();
								case 'endeavors':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'endeavors';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'apollyon':
						if (charUnlocked.contains('apollyon')) {
							switch(songSelected.toLowerCase())
							{
								case 'genesis':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'genesis';
									DiscordClient.changePresence();
								case 'corinthians':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'apollyon';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					case 'chaotix':
						if (charUnlocked.contains('chaotix')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'chaotix';
									DiscordClient.changePresence();
								case 'our-horizon':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'horizon';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
					default:
						if (charUnlocked.contains(charArray[curSelected])) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = charArray[curSelected];
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
				}
			}
		});
		#end

		#if mobile
		addVirtualPad(UP_DOWN, A_B);
		virtualPad.y = -26;
		#end
		super.create();
	}

	function mouseHitboxes(length:Int) {
		switch(length) {
			case 1:
				hitbox1.y = 347;
			case 2:
				hitbox1.y = 329;
				hitbox2.y = 371;
			case 3:
				hitbox1.y = 314;
				hitbox2.y = 356;
				hitbox3.y = 398;
			case 4:
				hitbox1.y = 299;
				hitbox2.y = 341;
				hitbox3.y = 383;
				hitbox4.y = 425;
			case 5:
				hitbox1.y = 281;
				hitbox2.y = 323;
				hitbox3.y = 365;
				hitbox4.y = 407;
				hitbox5.y = 449;
			case 6:
				hitbox1.y = 263;
				hitbox2.y = 305;
				hitbox3.y = 347;
				hitbox4.y = 389;
				hitbox5.y = 431;
				hitbox6.y = 473;
			case 7:
				hitbox1.y = 245;
				hitbox2.y = 287;
				hitbox3.y = 329;
				hitbox4.y = 371;
				hitbox5.y = 413;
				hitbox6.y = 455;
				hitbox7.y = 497;
			case 8:
				hitbox1.y = 230;
				hitbox2.y = 272;
				hitbox3.y = 314;
				hitbox4.y = 356;
				hitbox5.y = 398;
				hitbox6.y = 439;
				hitbox7.y = 481;
				hitbox8.y = 523;
		}
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}
	
	function ScorchedSeeYou() {
		scorchedMomentRN = true;
		FlxTween.tween(scorchedMoment, {alpha: 1}, 0.5, {});
		canControl = false;
		FlxG.sound.play(Paths.sound('scorched-glitch-laugh', 'preload'), 1);
		GlitchMusic.fadeOut(0.5, 0);
		new FlxTimer().start(3, function(boom:FlxTimer) { Sys.exit(0); });
		glitchAmount = 0.3;
		glitchNum = 40;
	}
	
	#if desktop
	function ScorchedGlitchDisable() {
		DisableGlitch = true;
		glitchNum = 0;
		glitchAmount = 0;
		camFuckShader.iTime.value[0] = 0;
		camFuckShader.amount = 0;
		GlitchMusic.volume = 0;
		FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
	}
	#end
	
	function doPopup(type:Int)
	{
		if(FatalErrors){
			if (ErrorsSpeed == 5 && !ErrorMouse) {
				var Cursor = new CursorLoadState(false, true);
				if (ErrorsSpeed == 5) FlxG.mouse.load(Paths.image('cursor/fatal_mouse_cursor', 'exe').bitmap, 1.5, 0);
				if (ErrorsSpeed == 5 && !FlxG.mouse.visible) FlxG.mouse.visible = true;
				ErrorMouse = true;
			}
			if (ErrorsSpeed > 0.01) FlxG.camera.shake(0.01, 0.025);
			if (ErrorsSpeed <= 0.01) FlxG.camera.shake(0.05, 0.5);
			if (ErrorsSpeed > 0.01) FlxG.sound.play(Paths.sound('error'));
			if (ErrorsSpeed <= 0.01) FlxG.sound.play(Paths.sound('glitch'));
			var popup = new FatalPopup(0, 0, type);
			var popuppos:Array<Int> = [errorRandom.int(0, Std.int(FlxG.width - popup.width)), errorRandom.int(0, Std.int(FlxG.height - popup.height))];
			popup.x = popuppos[0];
			popup.y = popuppos[1];
			popup.cameras = [camOther];
			add(popup);
		}
	}
	
	function managePopups(){
		if(FlxG.mouse.justPressed){
			trace("click :)");
			for(idx in 0...FatalPopup.popups.length){
				var realIdx = (FatalPopup.popups.length - 1) - idx;
				var popup = FatalPopup.popups[realIdx];
				var hitShit:Bool=false;
				for(camera in popup.cameras){
					@:privateAccess
					var hitOK = popup.clickDetector.overlapsPoint(FlxG.mouse.getWorldPosition(camera, popup.clickDetector._point), true, camera);
					if (hitOK){
						popup.close();
						hitShit=true;
						break;
					}
				}
				if(hitShit)break;
			}
		}
	}
	
	function CloseError(){
		FatalErrors = false;
		Error = false;
		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;
		if (ErrorMouse) {
			var Cursor = new CursorLoadState();
			ErrorMouse = false;
		}
		if (ErrorTimer != null) ErrorTimer.cancel();
		if (ShittyErrorTimer != null) ShittyErrorTimer.cancel();
		while(FatalPopup.popups.length>0) FatalPopup.popups[0].close();
		ErrorsSpeed = 0;
		blackbg.alpha = 0; 
	}
	
	function Crash(){
		var red:Array<Float> = [
			1, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			0, 0, 0, 1, 0,
		];
		shaders.push(new ColorMatrixFilter(red));
		displacementFilter = new DisplacementMapFilter(openfl.Assets.getBitmapData("assets/images/staticMap.png"), new Point(0, 0), 1, 1, 1, 1, DisplacementMapFilterMode.COLOR, 1, 0);
		shaders.push(displacementFilter);
		canScroll = false;
		canControl = false;
		doPopup(3);
		FatalErrors = false;
		if (ErrorTimer != null) ErrorTimer.cancel();
		if (ShittyErrorTimer != null) ShittyErrorTimer.cancel();
		camGame.setFilters(shaders);
		camOther.setFilters(shaders);
		new FlxTimer().start(0.6, function(boom:FlxTimer) { Sys.exit(0); });
	}
	
	function ScoreChoiceUPD()
	{
		if (CurseEndingSelection || EndlessSelection || TooFarSelection) {
			if (CurseEndingSelection) {
				if (CurseSelectedGood) {
					scoreChoiceSongSeleted = 'extricate-hex';
					if (ClientPrefs.UnlockedEndings.contains('curse-good'))
						scoreChoiceText.visible = true;
					else
						scoreChoiceText.visible = false;
				} else {
					scoreChoiceSongSeleted = 'unblessful-hedgehog';
					if (ClientPrefs.UnlockedEndings.contains('curse-bad'))
						scoreChoiceText.visible = true;
					else
						scoreChoiceText.visible = false;
				}
			}
			if (EndlessSelection) {
				switch(EndlessSelectedNum) {
					case 0: scoreChoiceSongSeleted = 'endless';
							scoreChoiceText.visible = true;
					case 1: scoreChoiceSongSeleted = 'endless-og';
							if (ClientPrefs.SongsCompleted.contains('endless'))
								scoreChoiceText.visible = true;
							else
								scoreChoiceText.visible = false;
					case 2: scoreChoiceSongSeleted = 'endless-jp';
							if (ClientPrefs.SongsCompleted.contains('endless'))
								scoreChoiceText.visible = true;
							else
								scoreChoiceText.visible = false;
					case 3: scoreChoiceSongSeleted = 'endless-us';
							if (ClientPrefs.SongsCompleted.contains('endless'))
								scoreChoiceText.visible = true;
							else
								scoreChoiceText.visible = false;
				}
			}
			if (TooFarSelection) {
				if (TooFarSelectedOne) {
					scoreChoiceSongSeleted = 'too-far';
					scoreChoiceText.visible = true;
				} else {
					scoreChoiceSongSeleted = 'too-far-alt';
					if (ClientPrefs.SongsCompleted.contains('too-far'))
						scoreChoiceText.visible = true;
					else
						scoreChoiceText.visible = false;
				}
			}
			#if !switch
			intendedChoiceScore = Highscore.getScore(scoreChoiceSongSeleted, 2);
			intendedChoiceRating = Highscore.getRating(scoreChoiceSongSeleted, 2);
			#end
			scoreChoiceText.text = 'Freeplay-Score: ';
			if (TranslationLanguages.Text.exists(scoreChoiceText.text) && ClientPrefs.Language != 'English')
				scoreChoiceText.text = TranslationLanguages.Text[scoreChoiceText.text] + lerpChoiceScore;
			else
				scoreChoiceText.text = 'Score: ' + lerpChoiceScore;
			scoreChoiceText.screenCenter(X);
			scoreChoiceText.x += 7;
		} else {
			scoreChoiceText.visible = false;
			scoreChoiceSongSeleted = '';
		}
	}
	
	function TooFarSelectionMenu(option:String, playSound:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		switch (option) {
			case 'open':
				TooFarSelection = true;
				canControl = false;
				canScroll = false;
				new FlxTimer().start(0.25, function(lkjh:FlxTimer)
				{
					TooFarMenuCanControl = true;
				});
				TooFarChoice.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 1}, 0.125);
				});
				FlxTween.tween(blackbg, {alpha: 0.75}, 0.125);
				if (TooFarSelectedOne) {
					TooFarVerOne.color = 0xFFFFFFFF;
					TooFarVerTwo.color = 0xFF232323;
				} else {					
					TooFarVerOne.color = 0xFF232323;
					TooFarVerTwo.color = 0xFFFFFFFF;
				}
			case 'close':
				FlxG.sound.play(Paths.sound('cancelMenu'));
				TooFarSelection = false;
				canControl = true;
				canScroll = true;
				TooFarMenuCanControl = false;
				TooFarChoice.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 0}, 0.125);
				});
				FlxTween.tween(blackbg, {alpha: 0}, 0.125);
			case 'sel-1':
				TooFarSelectedOne = true;
				TooFarVerOne.color = 0xFFFFFFFF;
				TooFarVerTwo.color = 0xFF232323;
			case 'sel-2':
				TooFarSelectedOne = false;
				TooFarVerOne.color = 0xFF232323;
				TooFarVerTwo.color = 0xFFFFFFFF;
		}
	}
	function EndlessSelectionMenu(option:String, playSound:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		switch (option) {
			case 'open':
				EndlessSelection = true;
				canControl = false;
				canScroll = false;
				new FlxTimer().start(0.25, function(lkjh:FlxTimer)
				{
					EndlessMenuCanControl = true;
				});
				EndlessChoice.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 1}, 0.125);
				});
				FlxTween.tween(blackbg, {alpha: 0.75}, 0.125);
				switch(EndlessSelectedNum) {
					case 0:
						EndlessVerOne.color = 0xFFFFFFFF;
						EndlessVerTwo.color = 0xFF232323;
						EndlessVerThree.color = 0xFF232323;
						EndlessVerFour.color = 0xFF232323;
					case 1:
						EndlessVerOne.color = 0xFF232323;
						EndlessVerTwo.color = 0xFFFFFFFF;
						EndlessVerThree.color = 0xFF232323;
						EndlessVerFour.color = 0xFF232323;
					case 2:
						EndlessVerOne.color = 0xFF232323;
						EndlessVerTwo.color = 0xFF232323;
						EndlessVerThree.color = 0xFFFFFFFF;
						EndlessVerFour.color = 0xFF232323;
					case 3:
						EndlessVerOne.color = 0xFF232323;
						EndlessVerTwo.color = 0xFF232323;
						EndlessVerThree.color = 0xFF232323;
						EndlessVerFour.color = 0xFFFFFFFF;
				}
			case 'close':
				FlxG.sound.play(Paths.sound('cancelMenu'));
				EndlessSelection = false;
				canControl = true;
				canScroll = true;
				EndlessMenuCanControl = false;
				EndlessChoice.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 0}, 0.125);
				});
				FlxTween.tween(blackbg, {alpha: 0}, 0.125);
			case 'sel-1':
				EndlessSelectedNum = 0;
				EndlessVerOne.color = 0xFFFFFFFF;
				EndlessVerTwo.color = 0xFF232323;
				EndlessVerThree.color = 0xFF232323;
				EndlessVerFour.color = 0xFF232323;
			case 'sel-2':
				EndlessSelectedNum = 1;
				EndlessVerOne.color = 0xFF232323;
				EndlessVerTwo.color = 0xFFFFFFFF;
				EndlessVerThree.color = 0xFF232323;
				EndlessVerFour.color = 0xFF232323;
			case 'sel-3':
				EndlessSelectedNum = 2;
				EndlessVerOne.color = 0xFF232323;
				EndlessVerTwo.color = 0xFF232323;
				EndlessVerThree.color = 0xFFFFFFFF;
				EndlessVerFour.color = 0xFF232323;
			case 'sel-4':
				EndlessSelectedNum = 3;
				EndlessVerOne.color = 0xFF232323;
				EndlessVerTwo.color = 0xFF232323;
				EndlessVerThree.color = 0xFF232323;
				EndlessVerFour.color = 0xFFFFFFFF;
		}
	}
	function CurseEndingSelectionMenu(option:String, playSound:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		switch (option) {
			case 'open':
				CurseEndingSelection = true;
				canControl = false;
				canScroll = false;
				new FlxTimer().start(0.25, function(lkjh:FlxTimer)
				{
					CurseMenuCanControl = true;
				});
				CurseChoice.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 1}, 0.125);
				});
				FlxTween.tween(blackbg, {alpha: 0.75}, 0.125);
				if (CurseSelectedGood) {
					CurseGoodEnding.color = 0xFFFFFFFF;
					CurseBadEnding.color = 0xFF232323;
				} else {					
					CurseGoodEnding.color = 0xFF232323;
					CurseBadEnding.color = 0xFFFFFFFF;
				}
			case 'close':
				FlxG.sound.play(Paths.sound('cancelMenu'));
				CurseEndingSelection = false;
				canControl = true;
				canScroll = true;
				CurseMenuCanControl = false;
				CurseChoice.forEach(function(spr:FlxSprite) {
					FlxTween.tween(spr, {alpha: 0}, 0.125);
				});
				FlxTween.tween(blackbg, {alpha: 0}, 0.125);
			case 'sel-1':
				CurseSelectedGood = true;
				CurseGoodEnding.color = 0xFFFFFFFF;
				CurseBadEnding.color = 0xFF232323;
			case 'sel-2':
				CurseSelectedGood = false;
				CurseGoodEnding.color = 0xFF232323;
				CurseBadEnding.color = 0xFFFFFFFF;
		}
	}
	
	function PlaySong() {
		canControl = false;
		var songLowercase:String = songSelected.toLowerCase();
		PlayState.SONG = Song.loadFromJson(songLowercase + '-hard', songLowercase);
		PlayState.storyDifficulty = 2;
		FlxTransitionableState.skipNextTransIn = true; 
		FlxTransitionableState.skipNextTransOut = true; 
		if (!GoreContent) {
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.music.fadeOut(0.7, 0);
			FlxTween.tween(whiteshit, {alpha: 1}, 0.5);
			new FlxTimer().start(1, function(tmr:FlxTimer) { 
				Main.InPlaystate = true;
				LoadingState.loadAndSwitchState(new PlayState()); 
			});
		} else {
			openSubState(new GoreWarningSubstate());
			GoreWarningMenu = true;
		}
	}
	function PlaySongWithCutscene() {
		canControl = false;
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		if (!GoreContent) {
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.music.fadeOut(0.4, 0);
			FlxTween.tween(whiteshit, {alpha: 1}, 0.5);
			new FlxTimer().start(1, function(tmr:FlxTimer) { 
				switch(songSelected) {
					case 'ugly': MusicBeatState.switchState(new Cutscenes('ugly', 'ugly-intro', 0.3, 'Freeplay', 'ugly'));
					case 'soulless': MusicBeatState.switchState(new Cutscenes('soulless', 'soulless-intro', 0.3, 'Freeplay', 'soulless'));
					case 'critical-error': MusicBeatState.switchState(new Cutscenes('critical-error', 'critical-error-intro', 0.3, 'Freeplay', 'critical-error'));
					case 'fight-or-flight': MusicBeatState.switchState(new Cutscenes('fight-or-flight', 'fof-intro', 0.3, 'Freeplay', 'fight-or-flight'));
				}
			});
		} else {
			switch(songSelected) {
				case 'ugly': openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'freeplay', 'cutscene', 'ugly', 'ugly-intro', 0.3, 'Freeplay', 'ugly'));
				case 'soulless': openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'freeplay', 'cutscene', 'soulless', 'soulless-intro', 0.3, 'Freeplay', 'soulless'));
				case 'critical-error': openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'freeplay', 'cutscene', 'critical-error', 'critical-error-intro', 0.3, 'Freeplay', 'critical-error'));
				case 'fight-or-flight': openSubState(new GoreWarningSubstate(true, true, true, 1, true, 'freeplay', 'cutscene', 'fight-or-flight', 'fof-intro', 0.3, 'Freeplay', 'fight-or-flight'));
			}
			GoreWarningMenu = true;
		}
	}
	function PlaySongVersion(song:String) {
		PlayState.SONG = Song.loadFromJson(song + '-hard', song);
		FlxTransitionableState.skipNextTransIn = true; 
		FlxTransitionableState.skipNextTransOut = true; 
		if (!GoreContent) {
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.music.fadeOut(0.7, 0);
			FlxTween.tween(whiteshit, {alpha: 1}, 0.4);
			new FlxTimer().start(2, function(tmr:FlxTimer) { 
				Main.InPlaystate = true;
				LoadingState.loadAndSwitchState(new PlayState()); 
			});
		} else {
			openSubState(new GoreWarningSubstate());
			GoreWarningMenu = true;
		}
	}
	
	var holdTime:Float = 0;
	var disable:Bool = false;
	override function update(elapsed:Float)
	{
		if (goreCloseShit) {
			GoreWarningMenu = false;
			if (!TooFarMenuCanControl && TooFarSelection)
				TooFarMenuCanControl = true;
			if (!CurseMenuCanControl && CurseEndingSelection)
				CurseMenuCanControl = true;
			if (!EndlessMenuCanControl && EndlessSelection)
				EndlessMenuCanControl = true;
			if (!TooFarMenuCanControl && !CurseMenuCanControl && !EndlessMenuCanControl) canControl = true;
			FlxTransitionableState.skipNextTransIn = false; 
			FlxTransitionableState.skipNextTransOut = false; 
			goreCloseShit = false;
		}
		lerpChoiceScore = Math.floor(FlxMath.lerp(lerpChoiceScore, intendedChoiceScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpChoiceRating = FlxMath.lerp(lerpChoiceRating, intendedChoiceRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpChoiceScore - intendedChoiceScore) <= 10)
			lerpChoiceScore = intendedChoiceScore;
		if (Math.abs(lerpChoiceRating - intendedChoiceRating) <= 0.01)
			lerpChoiceRating = intendedChoiceRating;
		ScoreChoiceUPD();
		
		if (charArray[curSelected] == 'fatal error' || charArray[curSelected] == 'critical error')
			Main.DisableCustomCursor = true;
		else
			Main.DisableCustomCursor = false;
		if (ClientPrefs.Shaders) {
			if (glitch && !DisableGlitch) {
				glitch = false;
				new FlxTimer().start(0.05, function(a:FlxTimer) {
					glitchNum += 0.01;
					//trace('glitchNum: ' + glitchNum);
				});
				
				new FlxTimer().start(0.7, function(a:FlxTimer) {
					glitch = true;
					glitchAmount += 0.0001;
					if (GlitchMusic.volume < 0.8) GlitchMusic.volume += 0.0001;
					FlxG.sound.music.volume -= 0.0001;
					//trace('glitchAmount: ' + glitchAmount);
				});
			}
			camFuckShader.amount = glitchAmount;
			camFuckShader.iTime.value[0] = glitchNum;
			GlitchMusic.time = FlxG.sound.music.time;
			
			#if desktop if (glitchNum >= 100 && glitchAmount >= 1 && !scorchedMomentRN) ScorchedSeeYou(); #end
		}
		songSelected = okay[sm_cur];
		
		if (FatalErrors && ErrorsSpeed != 0) {
			if (ErrorsSpeed <= 0.01) Crash();
			if (!Error) {
				Error = true;
				ShittyErrorTimer = new FlxTimer().start(ErrorsSpeed, function(tmr:FlxTimer) 
				{ 
					doPopup(2);
					Error = false;
					if (blackbg.alpha < 1) blackbg.alpha += 0.025; 
					if (ErrorsSpeed > 0.2) ErrorsSpeed -= 0.3;
					if (ErrorsSpeed < 0.3 && ErrorsSpeed > 0.01) ErrorsSpeed -= 0.01;
				});
			}
			managePopups();
		}
		
		if (FlxG.sound.music.volume < 0.7 && musicVol)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		
		if (songSelected.toLowerCase() != "'choice-of-ending'" && songSelected.toLowerCase() != "endless" && songSelected.toLowerCase() != "too-far")
			scoreText.visible = selectingMode;
		else
			scoreText.visible = false;
			
		for(i in 0...textList.members.length)
		{
			if(i == sm_cur && selectingMode)
				textList.members[i].alpha = 1;
			else
				textList.members[i].alpha = 0.3;
		}
		
		fg.velocity.set(0, 50);
		bg.velocity.set(50, 0);
		artItems.forEach(function(spr:FlxSprite){
			spr.x = -325;
			var spot = ((FlxG.height / 2) - (spr.frameHeight / 2)) - (400 * (curSelected - spr.ID));
			spr.y = FlxMath.lerp(spr.y, spot, CoolUtil.boundTo(elapsed * 7, 0, 1));
			if(spr.ID == curSelected)
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.55, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.55, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
			else
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.4, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.45, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.45, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}

			coverBorders.members[spr.ID].setPosition(spr.x, spr.y);
			coverBorders.members[spr.ID].alpha = spr.alpha;
			coverBorders.members[spr.ID].scale.x = spr.scale.x;
			coverBorders.members[spr.ID].scale.y = spr.scale.y;
		});

		artStatic.forEach(function(spr:FlxSprite){
			spr.x = 5;

			var spot = ((FlxG.height / 2) - (spr.frameHeight / 2)) - (400 * (curSelected - spr.ID));

			spr.y = FlxMath.lerp(spr.y, spot, CoolUtil.boundTo(elapsed * 7, 0, 1));

			if(spr.ID == curSelected)
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.2, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.56, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.56, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
			else
			{
				spr.alpha = FlxMath.lerp(spr.alpha, 0.1, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.x = FlxMath.lerp(spr.scale.x, 0.46, CoolUtil.boundTo(elapsed * 6, 0, 1));
				spr.scale.y = FlxMath.lerp(spr.scale.y, 0.46, CoolUtil.boundTo(elapsed * 6, 0, 1));
			}
		});

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}
		
		if (songSelected.toLowerCase() != 'gatekeepers' && songSelected.toLowerCase() != "'choice-of-ending'") {
			scoreText.text = 'Freeplay-Score: ';
			if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
				scoreText.text = TranslationLanguages.Text[scoreText.text] + lerpScore;
			else
				scoreText.text = 'Score: ' + lerpScore;
		}
		positionHighscore();

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
		
		if (!GoreWarningMenu) {
			if(canScroll && canControl) {
				if (selectingMode && FlxG.mouse.overlaps(textList)) disable = true;
				if ((selectingMode && !FlxG.mouse.overlaps(textList)) || !selectingMode) disable = false;
				
				if (!disable) {
					if (controls.UI_UP_P) {
						changeSelection(-shiftMult);
						holdTime = 0;
					}
					if (controls.UI_DOWN_P) {
						changeSelection(shiftMult);
						holdTime = 0;
					}
					if(controls.UI_DOWN || controls.UI_UP) {
						var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

						if(holdTime > 0.5 && checkNewHold - checkLastHold > 0) {
							changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
							changeDiff();
						}
					}
					if(FlxG.mouse.wheel != 0) {
						changeSelection(-shiftMult * FlxG.mouse.wheel);
						holdTime = 0;
					}
				}
				if (ClientPrefs.cutsceneYouSaw.contains(songSelected) && ClientPrefs.songsHaveCutsceneCheckbox.contains(songSelected) && selectingMode) {
					Checkbox.alpha = 1;
					ShowCutscene.alpha = 1;
					if (ClientPrefs.showCutscene.contains(songSelected))
						CheckboxCheck.alpha = 1;
					else
						CheckboxCheck.alpha = 0;
				} else {
					Checkbox.alpha = 0;
					CheckboxCheck.alpha = 0;
					ShowCutscene.alpha = 0;
				}
				if ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(Checkbox) && ClientPrefs.cutsceneYouSaw.contains(songSelected) && ClientPrefs.songsHaveCutsceneCheckbox.contains(songSelected)) {
					if (ClientPrefs.showCutscene.contains(songSelected))
						ClientPrefs.showCutscene.remove(songSelected);
					else
						ClientPrefs.showCutscene.push(songSelected);
					ClientPrefs.saveSettings();
				}
				
				if (selectingMode && FlxG.mouse.overlaps(textList)) {
					if (FlxG.mouse.overlaps(hitbox1) && sm_cur != 0 && CharSongList.getSongsByChar(charArray[curSelected]).length > 0) changeSelection(0, true, true);
					if (FlxG.mouse.overlaps(hitbox2) && sm_cur != 1 && CharSongList.getSongsByChar(charArray[curSelected]).length > 1) changeSelection(1, true, true);
					if (FlxG.mouse.overlaps(hitbox3) && sm_cur != 2 && CharSongList.getSongsByChar(charArray[curSelected]).length > 2) changeSelection(2, true, true);
					if (FlxG.mouse.overlaps(hitbox4) && sm_cur != 3 && CharSongList.getSongsByChar(charArray[curSelected]).length > 3) changeSelection(3, true, true);
					if (FlxG.mouse.overlaps(hitbox5) && sm_cur != 4 && CharSongList.getSongsByChar(charArray[curSelected]).length > 4) changeSelection(4, true, true);
					if (FlxG.mouse.overlaps(hitbox6) && sm_cur != 5 && CharSongList.getSongsByChar(charArray[curSelected]).length > 5) changeSelection(5, true, true);
					if (FlxG.mouse.overlaps(hitbox7) && sm_cur != 6 && CharSongList.getSongsByChar(charArray[curSelected]).length > 6) changeSelection(6, true, true);
					if (FlxG.mouse.overlaps(hitbox8) && sm_cur != 7 && CharSongList.getSongsByChar(charArray[curSelected]).length > 7) changeSelection(7, true, true);
				}
			} else {
				if (TooFarSelection) {
					if ((controls.UI_LEFT_P || FlxG.mouse.overlaps(TooFarVerOne)) && !TooFarSelectedOne) TooFarSelectionMenu('sel-1', true);
					if ((controls.UI_RIGHT_P || FlxG.mouse.overlaps(TooFarVerTwo)) && TooFarSelectedOne) TooFarSelectionMenu('sel-2', true);
				}
				if (EndlessSelection) {
					if (!FlxG.mouse.overlaps(EndlessVerOne) && !FlxG.mouse.overlaps(EndlessVerTwo) && !FlxG.mouse.overlaps(EndlessVerThree) && !FlxG.mouse.overlaps(EndlessVerFour)) {
						if (controls.UI_LEFT_P && EndlessSelectedNum == 1) EndlessSelectionMenu('sel-1', true);
						if (controls.UI_LEFT_P && EndlessSelectedNum == 3) EndlessSelectionMenu('sel-3', true);
						if (controls.UI_RIGHT_P && EndlessSelectedNum == 0) EndlessSelectionMenu('sel-2', true);
						if (controls.UI_RIGHT_P && EndlessSelectedNum == 2) EndlessSelectionMenu('sel-4', true);
						if (controls.UI_UP_P && EndlessSelectedNum == 2) EndlessSelectionMenu('sel-1', true);
						if (controls.UI_UP_P && EndlessSelectedNum == 3) EndlessSelectionMenu('sel-2', true);
						if (controls.UI_DOWN_P && EndlessSelectedNum == 0) EndlessSelectionMenu('sel-3', true);
						if (controls.UI_DOWN_P && EndlessSelectedNum == 1) EndlessSelectionMenu('sel-4', true);
					} else {
						if (FlxG.mouse.overlaps(EndlessVerOne) && EndlessSelectedNum != 0) EndlessSelectionMenu('sel-1', true);
						if (FlxG.mouse.overlaps(EndlessVerTwo) && EndlessSelectedNum != 1) EndlessSelectionMenu('sel-2', true);
						if (FlxG.mouse.overlaps(EndlessVerThree) && EndlessSelectedNum != 2) EndlessSelectionMenu('sel-3', true);
						if (FlxG.mouse.overlaps(EndlessVerFour) && EndlessSelectedNum != 3) EndlessSelectionMenu('sel-4', true);
					}
				}
				if (CurseEndingSelection) {
					if ((controls.UI_LEFT_P || FlxG.mouse.overlaps(CurseGoodEnding)) && !CurseSelectedGood) CurseEndingSelectionMenu('sel-1', true);
					if ((controls.UI_RIGHT_P || FlxG.mouse.overlaps(CurseBadEnding)) && CurseSelectedGood) CurseEndingSelectionMenu('sel-2', true);
				}
			}
		}
		
		if (!GoreWarningMenu) {
			if (controls.BACK || FlxG.mouse.justPressedRight) {
				if (canControl) {
					if(selectingMode) {
						FlxG.sound.play(Paths.sound('cancelMenu'));
						selectingMode = false;
						sm_cur = 0;
						if (charUnlocked.contains(charArray[curSelected]))
							charText.text = (charArray[curSelected]);
						else
							charText.text = '???';
						scoreText.text = 'Freeplay-Score: ';
						if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
							scoreText.text = TranslationLanguages.Text[scoreText.text] + lerpScore;
						else
							scoreText.text = 'Score: ' + lerpScore;
						charText.screenCenter(X);
						scoreText.screenCenter(X);

						if (charArray[curSelected] == 'fatal error' || charArray[curSelected] == 'critical error') CloseError();
						if (charArray[curSelected] == 'hog') #if desktop ScorchedGlitchDisable(); #end
						changeSelection(0, false);
					} else {
						persistentUpdate = false;
						FlxG.sound.play(Paths.sound('cancelMenu'));
						MusicBeatState.switchState(new MainMenuState());
					}
				}
			} else {
				if(!canControl) {
					if (TooFarSelection) {
						if (controls.BACK || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(TooFarChoiceExit) && (FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed))) TooFarSelectionMenu('close');
					}
					if (EndlessSelection) {
						if (controls.BACK || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(EndlessChoiceExit) && (FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed))) EndlessSelectionMenu('close');
					}
					if (CurseEndingSelection) {
						if (controls.BACK || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(CurseChoiceExit) && (FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed))) CurseEndingSelectionMenu('close');
					}
				}
			}
		}
		if (!ClientPrefs.gore) {
			switch(songSelected.toLowerCase()) {
				case 'melting', 'confronting', 'black-sun', 'godspeed', 'fight-or-flight', 'digitalized', 'manual-blast', 'soulless', 'too-far', 'last-hope', 'envy', 'gorefest', 'lurk', 'skincrawler':
					GoreContent = true;
				default:
					GoreContent = false;
			}
		}
		
		if (controls.ACCEPT) {
			if (!GoreWarningMenu) {
				if (canControl) {
					if(selectingMode) {
						if (charUnlocked.contains(charArray[curSelected]) && songSelected.toLowerCase() != 'gatekeepers') {
							if (songSelected.toLowerCase() != 'too-far' && !TooFarSelection) {
								if (songSelected.toLowerCase() != 'endless' && !EndlessSelection) {
									if (songSelected.toLowerCase() != "'choice-of-ending'" && !CurseEndingSelection) {
										if (!FatalErrors) {
											if (!ClientPrefs.showCutscene.contains(songSelected))
												PlaySong();
											else
												PlaySongWithCutscene();
										}
									} else {
										CurseEndingSelectionMenu('open');
									}
								} else {
									EndlessSelectionMenu('open');
								}
							} else {
								TooFarSelectionMenu('open');
							}
						} else {
							canControl = false;
							FlxG.sound.play(Paths.sound('deniedMOMENT'), 1, false, null, false, function() {
								canControl = true; 
							}); 
						}
					} else {
						selectingMode = true;
						changeSelection();
					}
				}
			}
		}
		
		if (canControl && !GoreWarningMenu) {
			if (selectingMode) {
				if (FlxG.mouse.overlaps(textList) && FlxG.mouse.justPressed) {
					if (charUnlocked.contains(charArray[curSelected]) && songSelected.toLowerCase() != 'gatekeepers') {
						if (songSelected.toLowerCase() != 'too-far' && !TooFarSelection) {
							if (songSelected.toLowerCase() != 'endless' && !EndlessSelection) {
								if (songSelected.toLowerCase() != "'choice-of-ending'" && !CurseEndingSelection) {
									if (!FatalErrors) {
										if (!ClientPrefs.showCutscene.contains(songSelected))
											PlaySong();
										else
											PlaySongWithCutscene();
									}
								} else {
									CurseEndingSelectionMenu('open');
								}
							} else {
								EndlessSelectionMenu('open');
							}
						} else {
							TooFarSelectionMenu('open');
						}
					} else {
						canControl = false;
						FlxG.sound.play(Paths.sound('deniedMOMENT'), 1, false, null, false, function() {
							canControl = true; 
						}); 
					}
				}
			} else {
				if (FlxG.mouse.overlaps(hitboxEnterO) && FlxG.mouse.justPressed) {
					selectingMode = true;
					changeSelection();
				}
			}
		}
		
		if (!canControl) {
			if ((controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(TooFarVerOne) || FlxG.mouse.overlaps(TooFarVerTwo)))) && TooFarMenuCanControl && !GoreWarningMenu) {
				Main.DisableCustomCursor = false;
				switch(TooFarSelectedOne) {
					case true:
						PlaySongVersion('too-far');
						TooFarMenuCanControl = false;
					case false:
						if (ClientPrefs.SongsCompleted.contains('too-far')) {
							PlaySongVersion('too-far-alt');
							TooFarMenuCanControl = false;
						} else {
							if (!DeniedSound) {
								new FlxTimer().start(0.5, function(tmr:FlxTimer) { DeniedSound = false; });
								FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
								DeniedSound = true;
							}
						}
				}
			}
			if ((controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(EndlessVerOne) || FlxG.mouse.overlaps(EndlessVerTwo) || FlxG.mouse.overlaps(EndlessVerThree) || FlxG.mouse.overlaps(EndlessVerFour)))) && EndlessMenuCanControl && !GoreWarningMenu) {
				Main.DisableCustomCursor = false;
				switch(EndlessSelectedNum) {
					case 0:
						PlaySongVersion('endless');
						EndlessMenuCanControl = false;
					case 1 | 2 | 3:
						if (ClientPrefs.SongsCompleted.contains('endless')) {
							switch(EndlessSelectedNum) {
								case 1: PlaySongVersion('endless-og');
								case 2: PlaySongVersion('endless-jp');
								case 3: PlaySongVersion('endless-us');
							}
							EndlessMenuCanControl = false;
						} else {
							if (!DeniedSound) {
								new FlxTimer().start(0.5, function(tmr:FlxTimer) { DeniedSound = false; });
								FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
								DeniedSound = true;
							}
						}
				}
			}
			if ((controls.ACCEPT || ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && (FlxG.mouse.overlaps(CurseGoodEnding) || FlxG.mouse.overlaps(CurseBadEnding)))) && CurseMenuCanControl && !GoreWarningMenu) {
				Main.DisableCustomCursor = false;
				switch(CurseSelectedGood) {
					case true:
						if (ClientPrefs.UnlockedEndings.contains('curse-good')) {
							PlaySongVersion('extricate-hex');
							CurseMenuCanControl = false;
						} else {
							if (!DeniedSound) {
								new FlxTimer().start(0.5, function(tmr:FlxTimer) { DeniedSound = false; });
								FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
								DeniedSound = true;
							}
						}
					case false:
						if (ClientPrefs.UnlockedEndings.contains('curse-bad')) {
							PlaySongVersion('unblessful-hedgehog');
							CurseMenuCanControl = false;
						} else {
							if (!DeniedSound) {
								new FlxTimer().start(0.5, function(tmr:FlxTimer) { DeniedSound = false; });
								FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
								DeniedSound = true;
							}
						}
				}
			}
		}
		
		artItems.forEach(function(obj:FlxSprite) {
			if (obj.ID == curSelected) {
				switch(charArray[curSelected]) {
					case 'lord x':
						#if desktop
						if (charUnlocked.contains('lord x')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'lord-x';
									DiscordClient.changePresence();
								case 'execution':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'execution';
									DiscordClient.changePresence();
								case 'hellbent':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'hellbent';
									DiscordClient.changePresence();
								case 'fate':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'fate';
									DiscordClient.changePresence();
								case 'judgement':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'judgement';
									DiscordClient.changePresence();
								case 'gatekeepers':
									DiscordClient.imageRpc = 'guardians';
									DiscordClient.changePresence();
							}
						} else {
							switch(songSelected.toLowerCase()) {
								default:
									DiscordClient.imageRpc = 'locked';
									DiscordClient.changePresence();
								case 'gatekeepers':
									DiscordClient.imageRpc = 'locked';
									DiscordClient.changePresence();
							}
						}
						#end
					case 'hog':
						if (charUnlocked.contains('hog')) {
							switch(songSelected.toLowerCase())
							{
								case 'hedge':
									#if desktop if (ClientPrefs.SongsCompleted.contains('hedge')) ScorchedGlitchDisable(); #end
									#if desktop
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'hog';
									DiscordClient.changePresence();
									#end
								case 'manual-blast':
									if (ClientPrefs.SongsCompleted.contains('manual-blast')) {
										glitch = true;
										musicVol = false;
										DisableGlitch = false;
									}
									#if desktop
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'scorched';
									DiscordClient.changePresence();
									#end
							}
						} else {
							#if desktop
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
							#end
						}
					case 'faker':
						#if desktop
						if (charUnlocked.contains('faker')) {
							switch(songSelected.toLowerCase())
							{
								case 'faker':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'faker';
									DiscordClient.changePresence();
								case 'black-sun':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'exe';
									DiscordClient.changePresence();
								case 'godspeed':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'godspeed';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'furnace':
						#if desktop
						if (charUnlocked.contains('furnace')) {
							switch(songSelected.toLowerCase())
							{
								case 'prey':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'furnace';
									DiscordClient.changePresence();
								case 'fight-or-flight':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'starved';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'coldsteel':
						#if desktop
						if (charUnlocked.contains('coldsteel')) {
							switch(songSelected.toLowerCase())
							{
								case 'personel':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'coldsteel';
									DiscordClient.changePresence();
								case 'personel-serious':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'coldsteel-serious';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'melthog':
						#if desktop
						if (charUnlocked.contains('melthog')) {
							switch(songSelected.toLowerCase())
							{
								case 'melting':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'melthog';
									DiscordClient.changePresence();
								case 'confronting':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'confronting';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'curse':
						#if desktop
						if (charUnlocked.contains('curse')) {
							switch(songSelected.toLowerCase())
							{
								case 'malediction':
									if (!ClientPrefs.SongsCompleted.contains('malediction'))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'curse';
									DiscordClient.changePresence();
								case "'choice-of-ending'":
									if (!ClientPrefs.SongsCompleted.contains('malediction'))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'curse';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'fatal error':
						if (charUnlocked.contains('fatal error')) {
							switch(songSelected.toLowerCase())
							{
								case 'fatality':
									if (ClientPrefs.SongsCompleted.contains('fatality')) {
										if (selectingMode) {
											if (!FatalErrors) {
												ErrorTimer = new FlxTimer().start(5.0, function(tmr:FlxTimer) { 
													ErrorsSpeed = 5;
													FatalErrors = true;
												}); 
											}
										} else { CloseError(); }
									}
									#if desktop
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'fatal-error';
									DiscordClient.changePresence();
									#end
								case 'critical-error':
									#if desktop
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'critical-error';
									DiscordClient.changePresence();
									#end
									CloseError();
							}
						} else {
							#if desktop
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
							#end
						}
					case 'tails doll':
						#if desktop
						if (charUnlocked.contains('tails doll')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'tails-doll';
									DiscordClient.changePresence();
								case 'soulless':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'soulless';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'no name':
						#if desktop
						if (charUnlocked.contains('no name')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'no-name';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'normal cd':
						#if desktop
						if (charUnlocked.contains('normal cd')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'normal-cd';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'mono.bw':
						#if desktop
						if (charUnlocked.contains('mono.bw')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'mono_bw';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'sonic.lmn':
						#if desktop
						if (charUnlocked.contains('sonic.lmn')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'sonic_lmn';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'ugly sonic':
						#if desktop
						if (charUnlocked.contains('ugly sonic')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'ugly-sonic';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'lumpy sonic':
						#if desktop
						if (charUnlocked.contains('lumpy sonic')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'lumpy-sonic';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'demogri':
						#if desktop
						if (charUnlocked.contains('demogri')) {
							switch(songSelected.toLowerCase())
							{
								case 'insidious':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'insidious';
									DiscordClient.changePresence();
								case 'haze':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'haze';
									DiscordClient.changePresence();
								case 'marauder':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'demogri-and-griatos';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'sh tails':
						#if desktop
						if (charUnlocked.contains('sh tails')) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = 'sh-tails';
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'needlemouse':
						#if desktop
						if (charUnlocked.contains('needlemouse')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'needlemouse';
									DiscordClient.changePresence();
								case 'round-a-bout':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'roundabout';
									DiscordClient.changePresence();
								case 'spike-trap':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'spike-trap';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'xterion':
						#if desktop
						if (charUnlocked.contains('xterion')) {
							switch(songSelected.toLowerCase())
							{
								case 'substantial':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'xterion';
									DiscordClient.changePresence();
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'digitalized';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'majin':
						#if desktop
						if (charUnlocked.contains('majin')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'majin';
									DiscordClient.changePresence();
								case 'endeavors':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'endeavors';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'apollyon':
						#if desktop
						if (charUnlocked.contains('apollyon')) {
							switch(songSelected.toLowerCase())
							{
								case 'genesis':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'genesis';
									DiscordClient.changePresence();
								case 'corinthians':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'apollyon';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					case 'chaotix':
						#if desktop
						if (charUnlocked.contains('chaotix')) {
							switch(songSelected.toLowerCase())
							{
								default:
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'chaotix';
									DiscordClient.changePresence();
								case 'our-horizon':
									if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
										DiscordClient.imageRpc = 'uncompleted';
									else
										DiscordClient.imageRpc = 'horizon';
									DiscordClient.changePresence();
							}
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
					default:
						#if desktop
						if (charUnlocked.contains(charArray[curSelected])) {
							if (!ClientPrefs.SongsCompleted.contains(songSelected.toLowerCase()))
								DiscordClient.imageRpc = 'uncompleted';
							else
								DiscordClient.imageRpc = charArray[curSelected];
							DiscordClient.changePresence();
						} else {
							DiscordClient.imageRpc = 'locked';
							DiscordClient.changePresence();
						}
						#end
				}
			}
		});
		
		super.update(elapsed);
	}

	function changeDiff()
	{
		#if !switch
		intendedScore = Highscore.getScore(songSelected, 2);
		intendedRating = Highscore.getRating(songSelected, 2);
		#end

		PlayState.storyDifficulty = 2;
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true, ?mouse:Bool = false)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if(selectingMode) {
			if (!mouse) {
				sm_cur += change;
				if (sm_cur < 0)
					sm_cur = okay.length - 1;
				if (sm_cur >= okay.length)
					sm_cur = 0;
			} else {
				sm_cur = change;
			}

			#if !switch
			intendedScore = Highscore.getScore(okay[sm_cur], 2);
			intendedRating = Highscore.getRating(okay[sm_cur], 2);
			#end
			
			artItems.forEach(function(obj:FlxSprite) {
				if (obj.ID == curSelected) {
					switch(charArray[curSelected]) {
						case 'lord x':
							if (charUnlocked.contains('lord x')) {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/lord x'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'lord x';
										scoreText.text = 'Freeplay-Score: ';
										if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
											scoreText.text = TranslationLanguages.Text[scoreText.text] + lerpScore;
										else
											scoreText.text = 'Score: ' + lerpScore;
										charText.screenCenter(X);
										scoreText.screenCenter(X);
									case 'execution':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/execution'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'lord x';
										charText.screenCenter(X);
									case 'hellbent':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/hellbent'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'lord x';
										charText.screenCenter(X);
									case 'fate':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/fate'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'lord x';
										charText.screenCenter(X);
									case 'judgement':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/judgement'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'lord x';
										charText.screenCenter(X);
									case 'gatekeepers':
										obj.loadGraphic(Paths.image('freeplay-encore/freeplay/guardians'));
										charText.text = 'guardians';
										scoreText.text = 'Will be available in 2.0';
										if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
											scoreText.text = TranslationLanguages.Text[scoreText.text];
										charText.screenCenter(X);
										scoreText.screenCenter(X);
								}
							} else {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
										charText.text = '???';
										scoreText.text = 'Freeplay-Score: ';
										if (TranslationLanguages.Text.exists(scoreText.text) && ClientPrefs.Language != 'English')
											scoreText.text = TranslationLanguages.Text[scoreText.text] + lerpScore;
										else
											scoreText.text = 'Score: ' + lerpScore;
										charText.screenCenter(X);
										scoreText.screenCenter(X);
									case 'gatekeepers':
										obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
										charText.text = '???';
										scoreText.text = '???';
										charText.screenCenter(X);
										scoreText.screenCenter(X);
								}
							}
						case 'hog':
							if (charUnlocked.contains('hog')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'hedge':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/hog'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'hog';
										charText.screenCenter(X);
										#if destkop
										if (ClientPrefs.SongsCompleted.contains('hedge')) ScorchedGlitchDisable();
										#end
									case 'manual-blast':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/scorched'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'scorched';
										charText.screenCenter(X);
										if (ClientPrefs.SongsCompleted.contains('manual-blast')) {
											glitch = true;
											musicVol = false;
											DisableGlitch = false;
										}
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'faker':
							if (charUnlocked.contains('faker')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'faker':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/faker'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'faker';
										charText.screenCenter(X);
									case 'black-sun':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/exe'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'exe';
										charText.screenCenter(X);
									case 'godspeed':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/godspeed'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'exe';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'furnace':
							if (charUnlocked.contains('furnace')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'prey':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/furnace'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'furnace';
										charText.screenCenter(X);
									case 'fight-or-flight':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/starved'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'starved';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'coldsteel':
							if (charUnlocked.contains('coldsteel')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'personel':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/coldsteel'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'coldsteel';
										charText.screenCenter(X);
									case 'personel-serious':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/coldsteel-serious'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'coldsteel';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'melthog':
							if (charUnlocked.contains('melthog')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'melting':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/melthog'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'melthog';
										charText.screenCenter(X);
									case 'confronting':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/confronting'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'melthog';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'curse':
							if (charUnlocked.contains('curse')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'malediction':
										if (!ClientPrefs.SongsCompleted.contains('malediction'))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/curse'));
										if (!ClientPrefs.SongsCompleted.contains('malediction'))
											charText.text = '???';
										else 
											charText.text = 'curse';
										charText.screenCenter(X);
									case "'choice-of-ending'":
										if (!ClientPrefs.SongsCompleted.contains('malediction'))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/curse'));
										if (!ClientPrefs.SongsCompleted.contains('malediction'))
											charText.text = '???';
										else 
											charText.text = 'curse';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'majin':
							if (charUnlocked.contains('majin')) {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/majin'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'majin';
										charText.screenCenter(X);
									case 'endeavors':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/endeavors'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'majin';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'fatal error':
							if (charUnlocked.contains('fatal error')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'fatality':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/fatal error'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'fatal error';
										charText.screenCenter(X);
									case 'critical-error':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/critical-error'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'critical error';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'tails doll':
							if (charUnlocked.contains('tails doll')) {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/tails doll'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'tails doll';
										charText.screenCenter(X);
									case 'soulless':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/soulless'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'tails doll';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'xterion':
							if (charUnlocked.contains('xterion')) {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/xterion'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'xterion';
										charText.screenCenter(X);
									case 'substantial':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/substantial'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'xterion';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'needlemouse':
							if (charUnlocked.contains('needlemouse')) {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/needlemouse'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'needlemouse';
										charText.screenCenter(X);
									case 'round-a-bout':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/roundabout'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'needlemouse';
										charText.screenCenter(X);
									case 'spike-trap':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/spike-trap'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'needlemouse';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'apollyon':
							if (charUnlocked.contains('apollyon')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'genesis':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/apollyon'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'apollyon';
										charText.screenCenter(X);
									case 'corinthians':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/apollyon-p3'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'apollyon';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'demogri':
							if (charUnlocked.contains('demogri')) {
								switch(okay[sm_cur].toLowerCase())
								{
									case 'insidious':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/demogri'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'demogri';
										charText.screenCenter(X);
									case 'haze':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/griatos'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'griatos';
										charText.screenCenter(X);
									case 'marauder':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/demogri and griatos'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'demogri and griatos';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						case 'chaotix':
							if (charUnlocked.contains('chaotix')) {
								switch(okay[sm_cur].toLowerCase())
								{
									default:
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/chaotix'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'chaotix';
										charText.screenCenter(X);
									case 'our-horizon':
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
										else
											obj.loadGraphic(Paths.image('freeplay-encore/freeplay/horizon'));
										if (!ClientPrefs.SongsCompleted.contains(okay[sm_cur].toLowerCase()))
											charText.text = '???';
										else 
											charText.text = 'chaotix';
										charText.screenCenter(X);
								}
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
						default:
							if (charUnlocked.contains(charArray[curSelected])) {
								if (!beatedSongs.contains(okay[sm_cur].toLowerCase()))
									obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
								else
									obj.loadGraphic(Paths.image('freeplay-encore/freeplay/' + charArray[curSelected]));
								if (!beatedSongs.contains(okay[sm_cur].toLowerCase()))
									charText.text = '???';
								else 
									charText.text = charArray[curSelected];
								charText.screenCenter(X);
							} else {
								obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
								charText.text = '???';
								charText.screenCenter(X);
							}
					}
				}
			});
		} else {
			curSelected += change;
			if (curSelected < 0)
				curSelected = charArray.length - 1;
			if (curSelected >= charArray.length)
				curSelected = 0;	
				
			switch(charArray[curSelected]) 
			{ 
				case 'majin': PlayState.storyWeek = 2;
				case 'lord x': PlayState.storyWeek = 3;
				case 'tails doll': PlayState.storyWeek = 4;
				case 'fleetway': PlayState.storyWeek = 5;
				case 'faker': PlayState.storyWeek = 6;
				case 'christmas': PlayState.storyWeek = 7;
				case 'furnace': PlayState.storyWeek = 8;
				case 'needlemouse': PlayState.storyWeek = 9;
				case 'xterion': PlayState.storyWeek = 10;
				case 'hog': PlayState.storyWeek = 11;
				case 'curse': PlayState.storyWeek = 12;
				case 'satanos': PlayState.storyWeek = 13;
				case 'apollyon': PlayState.storyWeek = 14;
				case 'shp and genesys': PlayState.storyWeek = 15;
				case 'sonichu': PlayState.storyWeek = 16;
				case 'demogri': PlayState.storyWeek = 17;
				case 'requital': PlayState.storyWeek = 18;
				case 'no name': PlayState.storyWeek = 19;
				case 'oxxymajin': PlayState.storyWeek = 20;
				case 'sanic': PlayState.storyWeek = 21;
				case 'fatal error': PlayState.storyWeek = 22;
				case 'luther': PlayState.storyWeek = 23;
				case 'coldsteel': PlayState.storyWeek = 24;
				case 'devoid': PlayState.storyWeek = 25;
				case 'chaotix': PlayState.storyWeek = 26;
				case 'sl4sh': PlayState.storyWeek = 27;
				case 'mono.bw': PlayState.storyWeek = 28;
				case 'dsk': PlayState.storyWeek = 29;
				case 'educator': PlayState.storyWeek = 30;
				case 'sally alt': PlayState.storyWeek = 31;
				case 'omw': PlayState.storyWeek = 32;
				case 'bratwurst': PlayState.storyWeek = 33;
				case 'nmi': PlayState.storyWeek = 34;
				case 'sh tails': PlayState.storyWeek = 35;
				case 'batman': PlayState.storyWeek = 36;
				case 'gameover': PlayState.storyWeek = 37;
				case 'sonic.lmn': PlayState.storyWeek = 38;
				case 'sunky': PlayState.storyWeek = 39;
				case 'grimeware': PlayState.storyWeek = 40;
				case 'ugly sonic': PlayState.storyWeek = 41;
				case 'futagami': PlayState.storyWeek = 42;
				case 'slaps': PlayState.storyWeek = 43;
				case 'exetior': PlayState.storyWeek = 44;
				case 'melthog': PlayState.storyWeek = 45;
				case 'normal cd': PlayState.storyWeek = 46;
				case 'lumpy sonic': PlayState.storyWeek = 47;
			}
				
			okay = CharSongList.getSongsByChar(charArray[curSelected]);
			textList.clear();
			mouseHitboxes(okay.length);
			
			for(i in 0...okay.length)
			{
				var peepeepoopoocheck:String;
				peepeepoopoocheck = okay[i];
				if (peepeepoopoocheck.contains('-'))
					peepeepoopoocheck = peepeepoopoocheck.replace('-', ' ');
				if (TranslationLanguages.Text.exists(peepeepoopoocheck) && ClientPrefs.Language != 'English')
					peepeepoopoocheck = TranslationLanguages.Text[peepeepoopoocheck];
				var SongsText:FlxText;
				if (charUnlocked.contains(charArray[curSelected])) {
					if (ClientPrefs.SongsCompleted.contains(okay[i])) {
						SongsText = new FlxText(0, 25, 0, peepeepoopoocheck, 32);
					} else {
						if (okay[i] != 'gatekeepers' && okay[i] != "'choice-of-ending'")
							SongsText = new FlxText(0, 25, 0, '...', 32);
						else
							SongsText = new FlxText(0, 25, 0, peepeepoopoocheck, 32);
					}
				} else {
					SongsText = new FlxText(0, 25, 0, '???', 32);
				}
				SongsText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), SongsText.size, FlxColor.WHITE, CENTER);
				SongsText.screenCenter();

				var midPoint = (FlxG.height / 2) - (SongsText.frameHeight / 2);
				SongsText.x += 325;
				SongsText.y = (midPoint + (25 * i)) - (((SongsText.frameHeight / 2) * ((okay.length - 1) - i)) / 2);
				SongsText.alpha = (selectingMode) ? 1 : 0.3;
				textList.add(SongsText);
			}
			artItems.forEach(function(obj:FlxSprite) {
				if (obj.ID == curSelected) {
					if (charUnlocked.contains(charArray[curSelected])) {
						if (!beatedSongs.contains(okay[sm_cur].toLowerCase()))
							obj.loadGraphic(Paths.image('freeplay-encore/freeplay/uncompleted'));
						else
							obj.loadGraphic(Paths.image('freeplay-encore/freeplay/' + charArray[curSelected]));
						if (!beatedSongs.contains(okay[sm_cur].toLowerCase()))
							charText.text = '???';
						else 
							charText.text = charArray[curSelected];
						charText.screenCenter(X);
					} else {
						obj.loadGraphic(Paths.image('freeplay-encore/freeplay/locked'));
						charText.text = '???';
						charText.screenCenter(X);
					}
				}
			});
		}
	}
	private function positionHighscore() {
		scoreText.screenCenter(X);
		scoreText.x += 7;
	}
}