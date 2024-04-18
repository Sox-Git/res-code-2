package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop; 
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import sys.FileSystem; 
import flixel.ui.FlxBar;
import flixel.input.mouse.FlxMouseEventManager;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2 (v1.0)'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var Buttons:FlxTypedSpriteGroup<FlxSprite>;
	private var camGame:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'encore',
		'freeplay',
		'sound_test',
		'credits',
		'options',
		'extras'
	];

	var debugKeys:Array<FlxKey>;
	var BG:FlxSprite;
	
	public var SoundTestUnlocked:Bool = false;
	public var EncoreUnlocked:Bool = false;
	
	public var lockedControl:Bool = false;
	public var selectedSomethin:Bool = false;
	public static var instance:MainMenuState;
	public static var scrollsDown:Bool = false;
	var Accepted:Bool = false;
	var IhateThatFuckingShitCode:Bool = false;
	public var openTrophyMenu:Bool = false;
	
	var NoTrophy:FlxSprite;
	var TrophieBG:FlxSprite;
	var TooSlowTrophy:FlxSprite;
	var YouCantRunTrophy:FlxSprite;
	var TripleTroubleTrophy:FlxSprite;
	var FinalEscapeTrophy:FlxSprite;
	var FaceOffTrophy:FlxSprite;
	public var blackScreen:FlxSprite;
	
	var ButtonsBG:FlxSprite;
	var ArrowUp:FlxSprite;
	var ArrowDown:FlxSprite;
	var ArrowUpSel:FlxSprite;
	var ArrowDownSel:FlxSprite;
	var FGup:FlxSprite;
	var FGdown:FlxSprite;
	var PressAlt:FlxSprite;
	var art:FlxSprite;
	var secretArts:Array<String> = [];
	var artsArrayJustForFun:FlxTypedSpriteGroup<FlxSprite>;
	
	#if desktop
	var keybindsMenu:FlxTypedSpriteGroup<FlxSprite>;
	var keyBinds:FlxSprite;
	var keyBindsExit:FlxSprite;
	var kBtime:Bool = false;
	var NoteLEFTO:FlxText;
	var NoteDOWNO:FlxText;
	var NoteSPECIALO:FlxText;
	var NoteUPO:FlxText;
	var NoteRIGHTO:FlxText;
	var NoteLEFTT:FlxText;
	var NoteDOWNT:FlxText;
	var NoteSPECIALT:FlxText;
	var NoteUPT:FlxText;
	var NoteRIGHTT:FlxText;
	
	var DownArrow:FlxSprite;
	var DownArrowPressed:FlxSprite;
	var LeftArrow:FlxSprite;
	var LeftArrowPressed:FlxSprite;
	var RightArrow:FlxSprite;
	var RightArrowPressed:FlxSprite;
	var SpaceArrow:FlxSprite;
	var SpaceArrowPressed:FlxSprite;
	var UpArrow:FlxSprite;
	var UpArrowPressed:FlxSprite;
	
	var NLeft:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_left')[0], ClientPrefs.keyBinds.get('note_left')[1]];
	var NDown:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_down')[0], ClientPrefs.keyBinds.get('note_down')[1]];
	var NSpace:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_ring')[0]];
	var NUp:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_up')[0], ClientPrefs.keyBinds.get('note_up')[1]];
	var NRight:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_right')[0], ClientPrefs.keyBinds.get('note_right')[1]];
	
	var NLeftO:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_left')[0]];
	var NLeftT:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_left')[1]];
	var NDownO:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_down')[0]];
	var NDownT:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_down')[1]];
	var NSpaceO:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_ring')[0]];
	var NSpaceT:Array<FlxKey> = [];
	var NUpO:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_up')[0]];
	var NUpT:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_up')[1]];
	var NRightO:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_right')[0]];
	var NRightT:Array<FlxKey> = [ClientPrefs.keyBinds.get('note_right')[1]];
	
	public var keyBindTime:Bool = false;
	#end
	public var offButtonsThing:Bool = false;
	public var coolKeybindsArrows:Bool = false;
	var cursorArrowsFix:Bool = false;
	var InCustomCursor:Bool = false;
	var CustomCursorCooldown:Bool = false;
	public var lockMouseSelection:Bool = false;
	var secondPage:Bool = false;
	
	var songsCompFrame:FlxSprite;
	var songsCompleted:FlxText;
	public var compSongsStuffOne:String;
	public var compSongsStuffTwo:FlxColor;
	public var compSongsStuffThree:FlxColor;
	var songsCompBar:FlxBar;
	var songsCompBarSprite:FlxSprite;
	var songsCompletedPercent:Float;
	
	#if desktop
	var CursorLockedIcons:Array<FlxSprite> = [];
	var curMouseCustomSelection:Int = -1;
	var CursorCustomizationButton:FlxSprite;
	var CursorCustomMenu:FlxSprite;
	var CursorCustomSelection:FlxSprite;
	var Cursors:FlxSprite;
	var CursorCustomizationLocked:FlxTypedSpriteGroup<FlxSprite>;
	var CursorCustomizationMenu:FlxTypedSpriteGroup<FlxSprite>;
	var CursorCustomizationMenuHigher:FlxTypedSpriteGroup<FlxSprite>;
	var CursorCooldown:FlxSprite;
	var CursorCustomizationExitButton:FlxSprite;
	var CursorHowToGet:FlxText;
	var hitboxOfAxunnayaZalupa:FlxSprite;
	#end
	var MouseScrollUp:FlxSprite;
	var MouseScrollDown:FlxSprite;
	var MouseScrollUpSel:FlxSprite;
	var MouseScrollDownSel:FlxSprite;
	#if mobile
	var countOfSongsForMobile:Int = 129;
	#end

	#if desktop
	var FPSButton:FlxSprite;
	var FPSSlider:FlxSprite;
	var FPSNumPlace:FlxSprite;
	var FPSNum:FlxText;
	var FPSBARThingie:FlxSprite;
	var FPSbarSprite:FlxSprite;
	var FPSbar:FlxBar;
	var FPSMenu:FlxTypedSpriteGroup<FlxSprite>;
	var FPSMenuSliderStuff:FlxTypedSpriteGroup<FlxSprite>;
	var FPSMenuNUMStuff:FlxTypedSpriteGroup<FlxSprite>;
	var FPSFR:Float;
	var FPSMenuInside:Bool = false;
	var FPSSliderHoldingMouse:Bool = false;
	var FPSSliderPercent:Float;
	var FPSBarMove:Bool = false;
	var FPSbarPerc:Float;
	var CurFPSinBar:Float = ClientPrefs.framerate-30;
	var FPSFIXSHIT:Bool = false;
	var FPSTimer:FlxTimer;
	var FIXSHIT:Bool = false;
	var FPSClassic30:FlxSprite;
	var FPSClassic60:FlxSprite;
	var FPSClassic120:FlxSprite;
	var FPSClassic144:FlxSprite;
	var FPSClassic240:FlxSprite;
	var FPSClassic360:FlxSprite;
	var FPSClassicMenuStuff30:FlxTypedSpriteGroup<FlxSprite>;
	var FPSClassicMenuStuff60:FlxTypedSpriteGroup<FlxSprite>;
	var FPSClassicMenuStuff120:FlxTypedSpriteGroup<FlxSprite>;
	var FPSClassicMenuStuff144:FlxTypedSpriteGroup<FlxSprite>;
	var FPSClassicMenuStuff240:FlxTypedSpriteGroup<FlxSprite>;
	var FPSClassicMenuStuff360:FlxTypedSpriteGroup<FlxSprite>;
	#end
	
	#if UPDATE_CHANGELOG
	var UpdInfoBG:FlxSprite;
	var UpdInfoINF:FlxSprite;
	var UpdInfoNewDark:FlxSprite;
	var UpdInfoNew:FlxSprite;
	var versions:Array<String> = [];
	var descOrChL:Array<String> = [];
	var onoff:Bool = false;
	var UpdInfoOnOrOffTween:FlxTimer = null;
	var onOffUpdInfoOnFPS:Bool = false;
	var ErrorLoadingUpdateInfo:Bool = false;
	#end
	
	var ShopButton:FlxSprite;

	override function create()
	{	
		instance = this;
		if (lockMouseSelection) lockMouseSelection = false;
		if (CustomCursorCooldown) CustomCursorCooldown = false;
		FlxG.sound.playMusic(Paths.music('storymodemenumusic'), 0.7);
		
		if (ClientPrefs.SongsCompleted.length < 10 && ClientPrefs.SongsCompleted.length >= 0) {
			compSongsStuffOne = '0';
			compSongsStuffTwo = 0xFFBABABA;
			compSongsStuffThree = 0xFF606060;
		}
		if (ClientPrefs.SongsCompleted.length < 40 && ClientPrefs.SongsCompleted.length >= 10) {
			compSongsStuffOne = '10';
			compSongsStuffTwo = 0xFF7268A0;
			compSongsStuffThree = 0xFF443E60;
		}
		if (ClientPrefs.SongsCompleted.length < 80 && ClientPrefs.SongsCompleted.length >= 40) {
			compSongsStuffOne = '40';
			compSongsStuffTwo = 0xFF8551C5;
			compSongsStuffThree = 0xFF412860;
		}
		if (ClientPrefs.SongsCompleted.length < #if mobile countOfSongsForMobile #else FileSystem.readDirectory('assets/songs/').length #end && ClientPrefs.SongsCompleted.length >= 80) {
			compSongsStuffOne = '80';
			compSongsStuffTwo = 0xFFAA5EAF;
			compSongsStuffThree = 0xFF5D3460;
		}
		if (ClientPrefs.SongsCompleted.length == #if mobile countOfSongsForMobile #else FileSystem.readDirectory('assets/songs/').length #end) {
			compSongsStuffOne = 'all';
			compSongsStuffTwo = 0xFFF136C7;
			compSongsStuffThree = 0xFF601650;
		}
		
		PlayState.isStoryMode = false;
		PlayState.isStory = false;
		PlayState.isEncore = false;
		PlayState.isExtras = false;
		PlayState.isSound = false;
		PlayState.isFreeplay = false;
		if (ClientPrefs.VisibleMouse)
			FlxG.mouse.visible = true;
		else
			FlxG.mouse.visible = false;
		
		PlayState.BFEncoreSkins = false;
		PlayState.BFSkins = false;
		PlayState.GFEncoreSkins = false;
		PlayState.GFSkins = false;
		
		PlayState.ChaosCutscene = false;
		PlayState.showSTCutscene = true;
		PlayState.storyPlaylist = [];

		#if desktop
		var rpcName:String = 'In Main Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.smallImageRpc = '';
		DiscordClient.imageRpc = 'icon';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));
		#if desktop
		if (ClientPrefs.keyBinds.get('note_ring')[0] != NONE) NSpace.push(ClientPrefs.keyBinds.get('note_ring')[0]);
		if (ClientPrefs.keyBinds.get('note_ring')[1] != NONE) NSpaceT.push(ClientPrefs.keyBinds.get('note_ring')[1]);
		#end

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		FlxTransitionableState.skipNextTransIn = false;
		openSubState(new SonicTransition(1.0, true));
		
		persistentUpdate = persistentDraw = true;

		BG = new FlxSprite(0, 0);
		BG.frames = Paths.getSparrowAtlas('mainmenu/bg-new');
		BG.antialiasing = ClientPrefs.globalAntialiasing;
		BG.animation.addByPrefix('bgAnim', 'bg', 20);
		BG.setGraphicSize(Std.int(BG.width * 2.00));
		BG.animation.play('bgAnim');
		BG.color = 0xFF515151;
		BG.updateHitbox();
		BG.screenCenter();
		add(BG);
		
		ButtonsBG = new FlxSprite().loadGraphic(Paths.image('mainmenu/buttons-bg'));
		ButtonsBG.antialiasing = ClientPrefs.globalAntialiasing;
		ButtonsBG.screenCenter();
		add(ButtonsBG);

		Buttons = new FlxTypedSpriteGroup<FlxSprite>();
		add(Buttons);

		for (i in 0...optionShit.length)
		{			
			var Button:FlxSprite = new FlxSprite(0, 0);
			Button.frames = Paths.getSparrowAtlas('mainmenu/buttons/' + optionShit[i]);
			Button.animation.addByIndices('idle', optionShit[i], [0], "", 24);
			Button.animation.addByIndices('sel', optionShit[i], [1], "", 24);
			Button.animation.addByIndices('epilepsy', optionShit[i], [0,1], "", 24);
			if (optionShit[i] == 'encore' || optionShit[i] == 'sound_test') {
				Button.animation.addByIndices('locked', optionShit[i], [2], "", 24);
				Button.animation.addByIndices('lock-sel', optionShit[i], [3], "", 24);
			}
			Button.animation.play('idle');
			Button.antialiasing = true;
			Button.updateHitbox();
			Button.scrollFactor.set();
			Button.ID = i;
			switch(i) {
				case 0:
					Button.setPosition(735, 105);
				case 1:
					Button.setPosition(770, 217);
				case 2:
					Button.setPosition(805, 329);
				case 3:
					Button.setPosition(840, 441);
				case 4:
					Button.setPosition(875, 553);
					Button.alpha = 0;
				case 5:
					Button.setPosition(910, 665);
					Button.alpha = 0;
				case 6:
					Button.setPosition(945, 777);
					Button.alpha = 0;
			}
			#if desktop
			FlxMouseEventManager.add(Button, null, null, GOOGOOGAAGAA,null,false,true,false);
			#end
			Buttons.add(Button);
		}
		#if desktop
		hitboxOfAxunnayaZalupa = new FlxSprite(714,0).makeGraphic(565, 720, 0x00000000);
		add(hitboxOfAxunnayaZalupa);
		#end

		ArrowUp = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/arrow-up'));
		ArrowUp.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowUp.screenCenter();
		add(ArrowUp);
		
		ArrowDown = new FlxSprite(0,10).loadGraphic(Paths.image('mainmenu/arrow-down'));
		ArrowDown.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowDown.screenCenter();
		add(ArrowDown);
		
		ArrowUpSel = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/arrow-up-sel'));
		ArrowUpSel.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowUpSel.screenCenter();
		add(ArrowUpSel);
		ArrowUpSel.alpha = 0;
		
		ArrowDownSel = new FlxSprite(0,10).loadGraphic(Paths.image('mainmenu/arrow-down-sel'));
		ArrowDownSel.antialiasing = ClientPrefs.globalAntialiasing;
		ArrowDownSel.screenCenter();
		add(ArrowDownSel);
		ArrowDownSel.alpha = 0;
		
		MouseScrollUp = new FlxSprite(783,65).loadGraphic(Paths.image('mainmenu/mouse-scroll'));
		MouseScrollUp.antialiasing = ClientPrefs.globalAntialiasing;
		MouseScrollUp.flipY = true;
		add(MouseScrollUp);
		MouseScrollUp.alpha = 0;
		
		MouseScrollDown = new FlxSprite(907,559).loadGraphic(Paths.image('mainmenu/mouse-scroll'));
		MouseScrollDown.antialiasing = ClientPrefs.globalAntialiasing;
		add(MouseScrollDown);
		MouseScrollDown.alpha = 0;
		
		MouseScrollUpSel = new FlxSprite(783,65).loadGraphic(Paths.image('mainmenu/mouse-scroll-sel'));
		MouseScrollUpSel.antialiasing = ClientPrefs.globalAntialiasing;
		MouseScrollUpSel.flipY = true;
		add(MouseScrollUpSel);
		MouseScrollUpSel.alpha = 0;
		
		MouseScrollDownSel = new FlxSprite(907,559).loadGraphic(Paths.image('mainmenu/mouse-scroll-sel'));
		MouseScrollDownSel.antialiasing = ClientPrefs.globalAntialiasing;
		add(MouseScrollDownSel);
		MouseScrollDownSel.alpha = 0;
		
		FGup = new FlxBackdrop(Paths.image('mainmenu/fg-up'), 1, 1, true, false);
		FGup.antialiasing = ClientPrefs.globalAntialiasing;
		FGup.screenCenter();
		add(FGup);

		artsArrayJustForFun = new FlxTypedSpriteGroup<FlxSprite>();
		add(artsArrayJustForFun);		
		MenuArts();
		
		FGdown = new FlxBackdrop(Paths.image('mainmenu/fg-down'), 1, 1, true, false);
		FGdown.antialiasing = ClientPrefs.globalAntialiasing;
		FGdown.screenCenter();
		add(FGdown);
		
		#if desktop
		PressAlt = new FlxSprite(949, 676).loadGraphic(Paths.image('mainmenu/press-alt'));
		PressAlt.antialiasing = ClientPrefs.globalAntialiasing;
		PressAlt.scrollFactor.set();
		PressAlt.alpha = 0;
		add(PressAlt);
		if (ClientPrefs.Language == 'Russian')
			PressAlt.x = 857;
		if (ClientPrefs.Language == 'Spanish')
			PressAlt.x = 899;
		
		var keybinds:FlxText = new FlxText(FlxG.width - 605, FlxG.height - 36, 600, "Press ALT to open keybinds", 3);
		keybinds.scrollFactor.set();
		keybinds.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 14, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(keybinds);
		if (TranslationLanguages.Text.exists(keybinds.text) && ClientPrefs.Language != 'English')
			keybinds.text = TranslationLanguages.Text[keybinds.text];
		#end
		
		TrophieBG = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/trophies/bg'));
		TrophieBG.antialiasing = ClientPrefs.globalAntialiasing;
		TrophieBG.scrollFactor.set();
		TrophieBG.screenCenter();

		NoTrophy = new FlxSprite(14, 554).loadGraphic(Paths.image('mainmenu/trophies/no-trophy'));
		NoTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		NoTrophy.scrollFactor.set();
		NoTrophy.alpha = 0;

		TooSlowTrophy = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/trophies/too-slow'));
		TooSlowTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		TooSlowTrophy.scrollFactor.set();
		TooSlowTrophy.screenCenter();
		
		YouCantRunTrophy = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/trophies/you-cant-run'));
		YouCantRunTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		YouCantRunTrophy.scrollFactor.set();
		YouCantRunTrophy.screenCenter();
		
		TripleTroubleTrophy = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/trophies/triple-trouble'));
		TripleTroubleTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		TripleTroubleTrophy.scrollFactor.set();
		TripleTroubleTrophy.screenCenter();
		
		FinalEscapeTrophy = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/trophies/final-escape'));
		FinalEscapeTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		FinalEscapeTrophy.scrollFactor.set();
		FinalEscapeTrophy.screenCenter();
		
		FaceOffTrophy = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/trophies/face-off'));
		FaceOffTrophy.antialiasing = ClientPrefs.globalAntialiasing;
		FaceOffTrophy.scrollFactor.set();
		FaceOffTrophy.screenCenter();
		
		switch (ClientPrefs.TrophieSelected) {
			case 0:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 1:
				TooSlowTrophy.alpha = 1;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 2:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 1;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 3:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 1;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 4:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 1;
				FaceOffTrophy.alpha = 0;
			case 5:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 1;
		}
		//if (ClientPrefs.TrophieSelected > 0) TrophieBG.alpha = 1;
		//if (ClientPrefs.TrophieSelected <= 0) TrophieBG.alpha = 0;
		
		//add(TrophieBG);
		add(NoTrophy);
		add(TooSlowTrophy);
		add(YouCantRunTrophy);
		add(TripleTroubleTrophy);
		add(FinalEscapeTrophy);
		add(FaceOffTrophy);
		
		
		#if desktop
		//CURSOR CUSTOMIZATION		
		CursorCustomizationButton = new FlxSprite(206,FlxG.height - 110).loadGraphic(Paths.image('mainmenu/custom-cursor/button'));
		CursorCustomizationButton.antialiasing = ClientPrefs.globalAntialiasing;
		CursorCustomizationButton.scrollFactor.set();
		add(CursorCustomizationButton);
		
		CursorCustomizationMenu = new FlxTypedSpriteGroup<FlxSprite>();
		add(CursorCustomizationMenu);
		
		CursorCustomMenu = new FlxSprite(206,FlxG.height - 140).loadGraphic(Paths.image('mainmenu/custom-cursor/menu'));
		CursorCustomMenu.antialiasing = ClientPrefs.globalAntialiasing;
		CursorCustomMenu.scrollFactor.set();
		CursorCustomizationMenu.add(CursorCustomMenu);
		
		CursorCustomSelection = new FlxSprite().loadGraphic(Paths.image('mainmenu/custom-cursor/selected'));
		CursorCustomSelection.antialiasing = ClientPrefs.globalAntialiasing;
		CursorCustomSelection.scrollFactor.set();
		CursorCustomizationMenu.add(CursorCustomSelection);
		switch(ClientPrefs.SelectedMouse) {
			case 0:
				CursorCustomSelection.setPosition(213, 615);
			case 1:
				CursorCustomSelection.setPosition(263, 615);
			case 2:
				CursorCustomSelection.setPosition(313, 615);
			case 3:
				CursorCustomSelection.setPosition(363, 615);
			case 4:
				CursorCustomSelection.setPosition(413, 615);
			case 5:
				CursorCustomSelection.setPosition(213, 665);
			case 6:
				CursorCustomSelection.setPosition(263, 665);
			case 7:
				CursorCustomSelection.setPosition(313, 665);
			case 8:
				CursorCustomSelection.setPosition(363, 665);
			case 9:
				CursorCustomSelection.setPosition(413, 665);
		}
		
		Cursors = new FlxSprite(206,FlxG.height - 140);
		Cursors.frames = Paths.getSparrowAtlas('mainmenu/custom-cursor/cursors');
		Cursors.antialiasing = ClientPrefs.globalAntialiasing;
		Cursors.animation.addByPrefix('idle', 'idle', 24, true);
		Cursors.animation.play('idle');
		CursorCustomizationMenu.add(Cursors);
		
		CursorHowToGet = new FlxText(-307, 582, FlxG.width, "", 11);
		CursorHowToGet.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 11, FlxColor.WHITE, CENTER);
		CursorCustomizationMenu.add(CursorHowToGet);
		
		CursorCustomizationLocked = new FlxTypedSpriteGroup<FlxSprite>();
		add(CursorCustomizationLocked);
		for (i in 0...ClientPrefs.Mouses.length)
		{			
			var CursorLocked:FlxSprite = new FlxSprite();
			CursorLocked.loadGraphic(Paths.image('mainmenu/custom-cursor/locked'));
			CursorLocked.updateHitbox();
			CursorLocked.antialiasing = ClientPrefs.globalAntialiasing;
			add(CursorLocked);
			CursorLocked.ID = i;
			if (!ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[i]))
				CursorLocked.alpha = 1;
			else
				CursorLocked.alpha = 0;
			switch(i) {
				case 0:
					CursorLocked.setPosition(213, 615);
				case 1:
					CursorLocked.setPosition(263, 615);
				case 2:
					CursorLocked.setPosition(313, 615);
				case 3:
					CursorLocked.setPosition(363, 615);
				case 4:
					CursorLocked.setPosition(413, 615);
				case 5:
					CursorLocked.setPosition(213, 665);
				case 6:
					CursorLocked.setPosition(263, 665);
				case 7:
					CursorLocked.setPosition(313, 665);
				case 8:
					CursorLocked.setPosition(363, 665);
				case 9:
					CursorLocked.setPosition(413, 665);
			}
			FlxMouseEventManager.add(CursorLocked, null, null, MouseCustomHoverCallback,null,false,true,false);
			CursorLockedIcons.push(CursorLocked);
			CursorCustomizationLocked.add(CursorLocked);
		}
		
		CursorCustomizationMenuHigher = new FlxTypedSpriteGroup<FlxSprite>();
		add(CursorCustomizationMenuHigher);
		CursorCooldown = new FlxSprite(206,FlxG.height - 140);
		CursorCooldown.frames = Paths.getSparrowAtlas('mainmenu/custom-cursor/cooldown');
		CursorCooldown.antialiasing = ClientPrefs.globalAntialiasing;
		CursorCooldown.animation.addByPrefix('cd', 'cooldown', 30, false);
		CursorCooldown.animation.addByPrefix('idle', 'idle', 24, false);
		CursorCooldown.animation.play('idle');
		CursorCustomizationMenuHigher.add(CursorCooldown);
		
		CursorCustomizationExitButton = new FlxSprite(453,FlxG.height - 144).loadGraphic(Paths.image('mainmenu/custom-cursor/close-button'));
		CursorCustomizationExitButton.antialiasing = ClientPrefs.globalAntialiasing;
		CursorCustomizationExitButton.scrollFactor.set();
		CursorCustomizationMenuHigher.add(CursorCustomizationExitButton);
		
		FlxTween.tween(CursorCustomizationMenu, {y: 2000}, 0.0001);
		FlxTween.tween(CursorCustomizationLocked, {y: 2000}, 0.0001);
		FlxTween.tween(CursorCustomizationMenuHigher, {y: 2000}, 0.0001);
		#end
		
		
		//Beated songs bar
		songsCompFrame = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/completedSongs/' + compSongsStuffOne +'/frame'));
		songsCompFrame.antialiasing = ClientPrefs.globalAntialiasing;
		songsCompFrame.scrollFactor.set();
		add(songsCompFrame);
		songsCompleted = new FlxText(-558, 30.5, FlxG.width, ClientPrefs.SongsCompleted.length + '/' + #if mobile countOfSongsForMobile #else FileSystem.readDirectory('assets/songs/').length #end);
		songsCompleted.setFormat(Paths.font("advanced.ttf"), 50, compSongsStuffTwo, CENTER);
		songsCompleted.scrollFactor.set();
		add(songsCompleted);
		
		songsCompletedPercent = (ClientPrefs.SongsCompleted.length / #if mobile countOfSongsForMobile #else FileSystem.readDirectory('assets/songs/').length #end);
		songsCompBar = new FlxBar(6, 100, LEFT_TO_RIGHT, 196, 26, this, 'songsCompletedPercent', 0, 1);
		songsCompBar.scrollFactor.set();
		add(songsCompBar);
		songsCompBar.createFilledBar(compSongsStuffThree, compSongsStuffTwo);
		songsCompBarSprite = new FlxSprite(0,97).loadGraphic(Paths.image('mainmenu/completedSongs/' + compSongsStuffOne +'/progressBar'));
		songsCompBarSprite.antialiasing = ClientPrefs.globalAntialiasing;
		songsCompBarSprite.scrollFactor.set();
		add(songsCompBarSprite);
		
		
		//Update Info
		#if UPDATE_CHANGELOG
		var info;
		switch(ClientPrefs.Language) {
			case 'Russian': info = new haxe.Http("https://raw.githubusercontent.com/MerphiG/R.O.S.E.---Tests/main/update-infos-ru.txt");
			case 'Spanish': info = new haxe.Http("https://raw.githubusercontent.com/MerphiG/R.O.S.E.---Tests/main/update-infos-es.txt");
			default: info = new haxe.Http("https://raw.githubusercontent.com/MerphiG/R.O.S.E.---Tests/main/update-infos-eng.txt");
		}
		info.onData = function (data:String) {
			for (i in 0...data.split('[-v]').length-1) {
				versions.push(data.split('[-v]')[1+i].split('[v-]')[0]);
				descOrChL.push(data.split('[-c]')[1+i].split('[c-]')[0]);
			}
			trace('LOADED UPDATE INFO');
		}
		info.onError = function (error) {
			trace('ERROR');
			ErrorLoadingUpdateInfo = true;
		}
		info.request();
		
		if (!ErrorLoadingUpdateInfo) {
			UpdInfoBG = new FlxSprite(1039-65, 0).loadGraphic(Paths.image('mainmenu/update-info/back-thing'));
			UpdInfoBG.antialiasing = ClientPrefs.globalAntialiasing;
			UpdInfoBG.scrollFactor.set();
			add(UpdInfoBG);
			
			if (versions[versions.length-1].split('<')[1] > Application.current.meta.get('version')) {
				UpdInfoNewDark = new FlxSprite(1039-65, 0).loadGraphic(Paths.image('mainmenu/update-info/new-upd-dark'));
				UpdInfoNewDark.antialiasing = ClientPrefs.globalAntialiasing;
				UpdInfoNewDark.scrollFactor.set();
				add(UpdInfoNewDark);
				
				UpdInfoNew = new FlxSprite(1039-65, 0).loadGraphic(Paths.image('mainmenu/update-info/new-upd'));
				UpdInfoNew.antialiasing = ClientPrefs.globalAntialiasing;
				UpdInfoNew.scrollFactor.set();
				add(UpdInfoNew);
				
				newUpdateLightOnOff(true);
			} else {
				UpdInfoINF = new FlxSprite(1039-65, 0).loadGraphic(Paths.image('mainmenu/update-info/info'));
				UpdInfoINF.antialiasing = ClientPrefs.globalAntialiasing;
				UpdInfoINF.scrollFactor.set();
				add(UpdInfoINF);
			}
		}
		#end
		
		ShopButton = new FlxSprite(#if desktop 1155 #else #end,0).loadGraphic(Paths.image('mainmenu/shop'));
		ShopButton.antialiasing = ClientPrefs.globalAntialiasing;
		ShopButton.scrollFactor.set();
		add(ShopButton);
		
		#if desktop
		//FPS Change thing
		FPSMenu = new FlxTypedSpriteGroup<FlxSprite>();
		add(FPSMenu);
		FPSMenuSliderStuff = new FlxTypedSpriteGroup<FlxSprite>();
		FPSMenuNUMStuff = new FlxTypedSpriteGroup<FlxSprite>();
		FPSClassicMenuStuff30 = new FlxTypedSpriteGroup<FlxSprite>();
		FPSClassicMenuStuff60 = new FlxTypedSpriteGroup<FlxSprite>();
		FPSClassicMenuStuff120 = new FlxTypedSpriteGroup<FlxSprite>();
		FPSClassicMenuStuff144 = new FlxTypedSpriteGroup<FlxSprite>();
		FPSClassicMenuStuff240 = new FlxTypedSpriteGroup<FlxSprite>();
		FPSClassicMenuStuff360 = new FlxTypedSpriteGroup<FlxSprite>();
		
		FPSBARThingie = new FlxSprite(995,23).makeGraphic(220, 14, 0xFF280000);
		FPSMenuSliderStuff.add(FPSBARThingie);
		
		FPSbar = new FlxBar(995, 23, LEFT_TO_RIGHT, 220, 14, this, 'CurFPSinBar', 0, 330);
		FPSbar.scrollFactor.set();
		FPSbar.numDivisions = 330;
		FPSMenuSliderStuff.add(FPSbar);
		FPSbar.createFilledBar(0xFF1E1E1E, 0xFF280000);
		FPSbarPerc = FPSbar.percent;
		FPSbar.alpha = 0;
		
		FPSNumPlace = new FlxSprite(1220,45).loadGraphic(Paths.image('mainmenu/fps/fps-num'));
		FPSNumPlace.antialiasing = ClientPrefs.globalAntialiasing;
		FPSNumPlace.scrollFactor.set();
		FPSMenuNUMStuff.add(FPSNumPlace);
		
		FPSNum = new FlxText(610, 62, FlxG.width, Std.string(ClientPrefs.framerate));
		FPSNum.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSNum.scrollFactor.set();
		FPSMenuNUMStuff.add(FPSNum);
		
		FPSClassic30 = new FlxSprite(1220,85).loadGraphic(Paths.image('mainmenu/fps/fps-classic'));
		FPSClassic30.antialiasing = ClientPrefs.globalAntialiasing;
		FPSClassic30.scrollFactor.set();
		FPSClassicMenuStuff30.add(FPSClassic30);
		
		var FPSClassic30Text:FlxText = new FlxText(610, 93, FlxG.width, '30');
		FPSClassic30Text.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSClassic30Text.scrollFactor.set();
		FPSClassicMenuStuff30.add(FPSClassic30Text);
		
		FPSClassic60 = new FlxSprite(1220,116).loadGraphic(Paths.image('mainmenu/fps/fps-classic'));
		FPSClassic60.antialiasing = ClientPrefs.globalAntialiasing;
		FPSClassic60.scrollFactor.set();
		FPSClassicMenuStuff60.add(FPSClassic60);
		
		var FPSClassic60Text:FlxText = new FlxText(610, 124, FlxG.width, '60');
		FPSClassic60Text.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSClassic60Text.scrollFactor.set();
		FPSClassicMenuStuff60.add(FPSClassic60Text);
		
		FPSClassic120 = new FlxSprite(1220,147).loadGraphic(Paths.image('mainmenu/fps/fps-classic'));
		FPSClassic120.antialiasing = ClientPrefs.globalAntialiasing;
		FPSClassic120.scrollFactor.set();
		FPSClassicMenuStuff120.add(FPSClassic120);
		
		var FPSClassic120Text:FlxText = new FlxText(610, 155, FlxG.width, '120');
		FPSClassic120Text.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSClassic120Text.scrollFactor.set();
		FPSClassicMenuStuff120.add(FPSClassic120Text);
		
		FPSClassic144 = new FlxSprite(1220,178).loadGraphic(Paths.image('mainmenu/fps/fps-classic'));
		FPSClassic144.antialiasing = ClientPrefs.globalAntialiasing;
		FPSClassic144.scrollFactor.set();
		FPSClassicMenuStuff144.add(FPSClassic144);
		
		var FPSClassic144Text:FlxText = new FlxText(610, 186, FlxG.width, '144');
		FPSClassic144Text.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSClassic144Text.scrollFactor.set();
		FPSClassicMenuStuff144.add(FPSClassic144Text);
		
		FPSClassic240 = new FlxSprite(1220,209).loadGraphic(Paths.image('mainmenu/fps/fps-classic'));
		FPSClassic240.antialiasing = ClientPrefs.globalAntialiasing;
		FPSClassic240.scrollFactor.set();
		FPSClassicMenuStuff240.add(FPSClassic240);
		
		var FPSClassic240Text:FlxText = new FlxText(610, 217, FlxG.width, '240');
		FPSClassic240Text.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSClassic240Text.scrollFactor.set();
		FPSClassicMenuStuff240.add(FPSClassic240Text);
		
		FPSClassic360 = new FlxSprite(1220,240).loadGraphic(Paths.image('mainmenu/fps/fps-classic'));
		FPSClassic360.antialiasing = ClientPrefs.globalAntialiasing;
		FPSClassic360.scrollFactor.set();
		FPSClassicMenuStuff360.add(FPSClassic360);
		
		var FPSClassic360Text:FlxText = new FlxText(610, 248, FlxG.width, '360');
		FPSClassic360Text.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 7, 0xFFFFFFFF, CENTER);
		FPSClassic360Text.scrollFactor.set();
		FPSClassicMenuStuff360.add(FPSClassic360Text);
		
		FPSButton = new FlxSprite(1220,0).loadGraphic(Paths.image('mainmenu/fps/button'));
		FPSButton.antialiasing = ClientPrefs.globalAntialiasing;
		FPSButton.scrollFactor.set();
		
		FPSbarSprite = new FlxSprite(990,18).loadGraphic(Paths.image('mainmenu/fps/slider-bar'));
		FPSbarSprite.antialiasing = ClientPrefs.globalAntialiasing;
		FPSbarSprite.scrollFactor.set();
		FPSMenuSliderStuff.add(FPSbarSprite);
		
		if (ClientPrefs.MainMenuFPSBarX == 0)
			FPSSlider = new FlxSprite(992 + 20,9).loadGraphic(Paths.image('mainmenu/fps/slider'));
		else
			FPSSlider = new FlxSprite(ClientPrefs.MainMenuFPSBarX,9).loadGraphic(Paths.image('mainmenu/fps/slider'));
		FPSSlider.antialiasing = ClientPrefs.globalAntialiasing;
		FPSSlider.scrollFactor.set();
		FPSSlider.alpha = 0;
		
		FPSMenu.add(FPSClassicMenuStuff360);
		FPSMenu.add(FPSClassicMenuStuff240);
		FPSMenu.add(FPSClassicMenuStuff144);
		FPSMenu.add(FPSClassicMenuStuff120);
		FPSMenu.add(FPSClassicMenuStuff60);
		FPSMenu.add(FPSClassicMenuStuff30);
		FPSMenu.add(FPSMenuSliderStuff);
		FPSMenu.add(FPSMenuNUMStuff);
		FPSMenu.add(FPSSlider);
		FPSMenu.add(FPSButton);

		FPSMenuSliderStuff.x = 290;
		FPSMenuNUMStuff.y = -34;
		FPSClassicMenuStuff30.y = -100;
		FPSClassicMenuStuff60.y = -140;
		FPSClassicMenuStuff120.y = -180;
		FPSClassicMenuStuff144.y = -220;
		FPSClassicMenuStuff240.y = -260;
		FPSClassicMenuStuff360.y = -300;
		
		
		//KEYBINDS
		keybindsMenu = new FlxTypedSpriteGroup<FlxSprite>();
		add(keybindsMenu);
		
		keyBinds = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/keybinds'));
		keyBinds.antialiasing = ClientPrefs.globalAntialiasing;
		keyBinds.scrollFactor.set();
		keybindsMenu.add(keyBinds);
		
		keyBindsExit = new FlxSprite(683, 88).loadGraphic(Paths.image('mainmenu/keybinds/exit'));
		keyBindsExit.antialiasing = ClientPrefs.globalAntialiasing;
		keyBindsExit.scrollFactor.set();
		keybindsMenu.add(keyBindsExit);
		
		NoteLEFTO = new FlxText(168, 80, FlxG.width, ClientPrefs.keyBinds.get('note_left')[0]);
		NoteLEFTO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteLEFTO.scrollFactor.set();
		NoteLEFTO.alpha = 0.4;
		keybindsMenu.add(NoteLEFTO);
		NoteDOWNO = new FlxText(230, 80, FlxG.width, ClientPrefs.keyBinds.get('note_down')[0]);
		NoteDOWNO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteDOWNO.scrollFactor.set();
		NoteDOWNO.alpha = 0.4;
		keybindsMenu.add(NoteDOWNO);
		NoteSPECIALO = new FlxText(296, 80, FlxG.width, ClientPrefs.keyBinds.get('note_ring')[0]);
		NoteSPECIALO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteSPECIALO.scrollFactor.set();
		NoteSPECIALO.alpha = 0.4;
		keybindsMenu.add(NoteSPECIALO);
		NoteUPO = new FlxText(362, 80, FlxG.width, ClientPrefs.keyBinds.get('note_up')[0]);
		NoteUPO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteUPO.scrollFactor.set();
		NoteUPO.alpha = 0.4;
		keybindsMenu.add(NoteUPO);
		NoteRIGHTO = new FlxText(430, 80, FlxG.width, ClientPrefs.keyBinds.get('note_right')[0]);
		NoteRIGHTO.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteRIGHTO.scrollFactor.set();
		NoteRIGHTO.alpha = 0.4;
		keybindsMenu.add(NoteRIGHTO);
		
		NoteLEFTT = new FlxText(168, 100, FlxG.width, ClientPrefs.keyBinds.get('note_left')[1]);
		NoteLEFTT.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteLEFTT.scrollFactor.set();
		NoteLEFTT.alpha = 0.4;
		keybindsMenu.add(NoteLEFTT);
		NoteDOWNT = new FlxText(230, 100, FlxG.width, ClientPrefs.keyBinds.get('note_down')[1]);
		NoteDOWNT.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteDOWNT.scrollFactor.set();
		NoteDOWNT.alpha = 0.4;
		keybindsMenu.add(NoteDOWNT);
		NoteSPECIALT = new FlxText(296, 100, FlxG.width, ClientPrefs.keyBinds.get('note_ring')[1]);
		NoteSPECIALT.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteSPECIALT.scrollFactor.set();
		NoteSPECIALT.alpha = 0.4;
		keybindsMenu.add(NoteSPECIALT);
		NoteUPT = new FlxText(362, 100, FlxG.width, ClientPrefs.keyBinds.get('note_up')[1]);
		NoteUPT.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteUPT.scrollFactor.set();
		NoteUPT.alpha = 0.4;
		keybindsMenu.add(NoteUPT);
		NoteRIGHTT = new FlxText(430, 100, FlxG.width, ClientPrefs.keyBinds.get('note_right')[1]);
		NoteRIGHTT.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 10, 0xFFFFFFFF, CENTER);
		NoteRIGHTT.scrollFactor.set();
		NoteRIGHTT.alpha = 0.4;
		keybindsMenu.add(NoteRIGHTT);
		
		DownArrow = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/down'));
		DownArrow.antialiasing = ClientPrefs.globalAntialiasing;
		DownArrow.scrollFactor.set();
		keybindsMenu.add(DownArrow);
		DownArrowPressed = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/down-pressed'));
		DownArrowPressed.antialiasing = ClientPrefs.globalAntialiasing;
		DownArrowPressed.scrollFactor.set();
		DownArrowPressed.alpha = 0;
		keybindsMenu.add(DownArrowPressed);
		LeftArrow = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/left'));
		LeftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		LeftArrow.scrollFactor.set();
		keybindsMenu.add(LeftArrow);
		LeftArrowPressed = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/left-pressed'));
		LeftArrowPressed.antialiasing = ClientPrefs.globalAntialiasing;
		LeftArrowPressed.scrollFactor.set();
		LeftArrowPressed.alpha = 0;
		keybindsMenu.add(LeftArrowPressed);
		RightArrow = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/right'));
		RightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		RightArrow.scrollFactor.set();
		keybindsMenu.add(RightArrow);
		RightArrowPressed = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/right-pressed'));
		RightArrowPressed.antialiasing = ClientPrefs.globalAntialiasing;
		RightArrowPressed.scrollFactor.set();
		RightArrowPressed.alpha = 0;
		keybindsMenu.add(RightArrowPressed);
		SpaceArrow = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/space'));
		SpaceArrow.antialiasing = ClientPrefs.globalAntialiasing;
		SpaceArrow.scrollFactor.set();
		keybindsMenu.add(SpaceArrow);
		SpaceArrowPressed = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/space-pressed'));
		SpaceArrowPressed.antialiasing = ClientPrefs.globalAntialiasing;
		SpaceArrowPressed.scrollFactor.set();
		SpaceArrowPressed.alpha = 0;
		keybindsMenu.add(SpaceArrowPressed);
		UpArrow = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/up'));
		UpArrow.antialiasing = ClientPrefs.globalAntialiasing;
		UpArrow.scrollFactor.set();
		keybindsMenu.add(UpArrow);
		UpArrowPressed = new FlxSprite(0,0).loadGraphic(Paths.image('mainmenu/keybinds/up-pressed'));
		UpArrowPressed.antialiasing = ClientPrefs.globalAntialiasing;
		UpArrowPressed.scrollFactor.set();
		UpArrowPressed.alpha = 0;
		keybindsMenu.add(UpArrowPressed);
		keybindsMenu.y = 720;
		#end
		
		
		//ETC
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.alpha = 0;
		add(blackScreen);
		
		#if mobile
			addVirtualPad(UP_DOWN, A_B_C_D);
			virtualPad.y = -150;
		#end
		
		select(false);
		super.create();
	}

	#if UPDATE_CHANGELOG
	var UpdInfoOnOrOffRN:Bool = false;
	function newUpdateLightOnOff(on:Bool) {
		if (on) {
			if (!UpdInfoOnOrOffRN) {
				onoff = true;
				UpdInfoOnOrOffTween = new FlxTimer().start(0.75, function(tmr:FlxTimer) {
					if (!onoff) {
						UpdInfoNewDark.alpha = 1;
						UpdInfoNew.alpha = 0;
					} else {
						UpdInfoNewDark.alpha = 0;
						UpdInfoNew.alpha = 1;
					}
					onoff = !onoff;
					tmr.reset(0.75);
				});
			}
			UpdInfoOnOrOffRN = true;
		} else {
			UpdInfoOnOrOffTween.cancel();
			UpdInfoOnOrOffRN = false;
		}
	}
	#end

	function MenuArts()
	{
		MainMenuArtsList.init();
		var ArtNum:Int = 0;
		var SongNum:Int = 0;
		for (i in 0...MainMenuArtsList.arts.length) {
			ArtNum = i;
			if (!ClientPrefs.UnlockedMenuArts.contains(MainMenuArtsList.arts[ArtNum])) {
				for (i in 0...MainMenuArtsList.getSongsByArt(MainMenuArtsList.arts[ArtNum]).length) {
					SongNum = i;
					if (ClientPrefs.SongsCompleted.contains(MainMenuArtsList.getSongsByArt(MainMenuArtsList.arts[ArtNum])[SongNum])) {
						ClientPrefs.UnlockedMenuArts.push(MainMenuArtsList.arts[ArtNum]);
					} else {
						trace('You needs to beat ' + MainMenuArtsList.getSongsByArt(MainMenuArtsList.arts[ArtNum])[SongNum] + ' to unlock ' + MainMenuArtsList.arts[ArtNum]);
					}
				}
			} else {
				trace(MainMenuArtsList.arts[ArtNum] + ' - Already Unlocked');
			}
		}
		ClientPrefs.saveSettings();
		MenuArtRandom(ClientPrefs.UnlockedMenuArts.length, false);
	}

	function MenuArtRandom(TotalUnlockedArts:Int, reset:Bool)
	{
		if (!reset) {
			if (TotalUnlockedArts > 1) {
				var RandomMenuArt:Int = 0;
				var RandomChanceOfSecretArt:Int = FlxG.random.int(0, 100);
				if (TotalUnlockedArts > 20) {
					if (RandomChanceOfSecretArt != 49) {
						RandomMenuArt = FlxG.random.int(0, TotalUnlockedArts - 1);
						if (ClientPrefs.lastMenuArt == ClientPrefs.UnlockedMenuArts[RandomMenuArt]) {
							MenuArtRandom(TotalUnlockedArts, false);
						} else {
							art = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/arts/' + ClientPrefs.UnlockedMenuArts[RandomMenuArt]));
							ClientPrefs.lastMenuArt = ClientPrefs.UnlockedMenuArts[RandomMenuArt];
							ClientPrefs.saveSettings();
							art.antialiasing = ClientPrefs.globalAntialiasing;
							art.scrollFactor.set();
							art.screenCenter();
							artsArrayJustForFun.add(art);
						}
					} else {
						RandomMenuArt = FlxG.random.int(0, MainMenuArtsList.secretArts.length - 1);
						if (ClientPrefs.lastMenuArt == MainMenuArtsList.secretArts[RandomMenuArt]) {
							MenuArtRandom(TotalUnlockedArts, false);
						} else {
							art = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/arts/secret/' + MainMenuArtsList.secretArts[RandomMenuArt]));
							ClientPrefs.lastMenuArt = MainMenuArtsList.secretArts[RandomMenuArt];
							ClientPrefs.saveSettings();
							art.antialiasing = ClientPrefs.globalAntialiasing;
							art.scrollFactor.set();
							art.screenCenter();
							artsArrayJustForFun.add(art);
						}
					}
				} else {
					RandomMenuArt = FlxG.random.int(0, TotalUnlockedArts - 1);
					if (ClientPrefs.lastMenuArt == ClientPrefs.UnlockedMenuArts[RandomMenuArt]) {
						MenuArtRandom(TotalUnlockedArts, false);
					} else {
						art = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/arts/' + ClientPrefs.UnlockedMenuArts[RandomMenuArt]));
						ClientPrefs.lastMenuArt = ClientPrefs.UnlockedMenuArts[RandomMenuArt];
						ClientPrefs.saveSettings();
						art.antialiasing = ClientPrefs.globalAntialiasing;
						art.scrollFactor.set();
						art.screenCenter();
						artsArrayJustForFun.add(art);
					}
				}
			}
			if (TotalUnlockedArts <= 1) {
				art = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/arts/xeno-1'));
				art.antialiasing = ClientPrefs.globalAntialiasing;
				art.scrollFactor.set();
				art.screenCenter();
				artsArrayJustForFun.add(art);
			}
			trace('Unlocked arts: ' + ClientPrefs.UnlockedMenuArts);
			trace('Total Unlocked Arts: ' + TotalUnlockedArts);
		} else {
			if (art != null) art.kill();
			MenuArtRandom(TotalUnlockedArts, false);
		}
	}
	
	#if desktop
	function KeyBindsOpen(In:Bool = true)
	{
		if (In == true) {
			offButtonsThing = true;
			keyBindTime = true;
			FlxTween.tween(ArrowUp, {x: 700}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowDown, {x: 700}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowUpSel, {x: 700}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowDownSel, {x: 700}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ButtonsBG, {x: 700}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(Buttons, {x: 700}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(keybindsMenu, {y: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(keybindsMenu, {y: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(keybindsMenu, {y: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollUp, {x: 1483}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollDown, {x: 1607}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollUpSel, {x: 1483}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollDownSel, {x: 1607}, 0.3, {ease: FlxEase.quadInOut});
			new FlxTimer().start(0.35, function(ff:FlxTimer) {
				new FlxTimer().start(0.35, function(ff:FlxTimer) {
					keyBindTime = false;
				});
				lockedControl = true;
				selectedSomethin = true;
				coolKeybindsArrows = true;
				kBtime = true;
				#if desktop
				var rpcName:String = 'In Main Menu (Keybinds)';
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.imageRpc = 'keybinds';
				DiscordClient.changePresence(rpcName, null);
				#end
			});
		} else {
			keyBindTime = true;
			coolKeybindsArrows = false;
			FlxTween.tween(keybindsMenu, {y: 720}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowUp, {x: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowDown, {x: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowUpSel, {x: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ArrowDownSel, {x: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(ButtonsBG, {x: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(Buttons, {x: 0}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollUp, {x: 783}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollDown, {x: 907}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollUpSel, {x: 783}, 0.3, {ease: FlxEase.quadInOut});
			FlxTween.tween(MouseScrollDownSel, {x: 907}, 0.3, {ease: FlxEase.quadInOut});
			new FlxTimer().start(0.2, function(tttttt:FlxTimer) {
				offButtonsThing = false;
			});
			new FlxTimer().start(0.35, function(gg:FlxTimer) {
				new FlxTimer().start(0.35, function(ff:FlxTimer) {
					keyBindTime = false;
				});
				lockedControl = false;
				selectedSomethin = false;
				kBtime = false;
				#if desktop
				var rpcName:String = 'In Main Menu';
				if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
					rpcName = TranslationLanguages.Text[rpcName];
				DiscordClient.imageRpc = 'icon';
				DiscordClient.changePresence(rpcName, null);
				#end
			});
		}
	}
	#end

	function select(SoundPlay:Bool = true, num:Int = 0, ?Pressed:String = '', ?mouse:Bool = false)
	{
		if (SoundPlay) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (!mouse) {
			curSelected += num;
			if (curSelected >= Buttons.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = Buttons.length - 1;
		} else {
			if (curSelected != num) curSelected = num;
		}
		if (!cursorArrowsFix) {
			if (Pressed == 'up') {
				scrollsDown = false;
				ArrowUp.alpha = 0;
				ArrowUpSel.alpha = 1;
				ArrowUp.y = -10;
				ArrowUpSel.y = -10;
			}
			if (Pressed == 'down') {
				scrollsDown = true;
				ArrowDown.alpha = 0;
				ArrowDownSel.alpha = 1;
				ArrowDown.y = 20;
				ArrowDownSel.y = 20;
			}
		}
		
		Buttons.forEach(function(spr:FlxSprite)
		{
			switch (spr.ID)
			{
				case 1:
					if (spr.ID == curSelected) {
						if (ClientPrefs.EncoreUnlocked) {
							spr.animation.play('sel');
						} else {
							spr.animation.play('lock-sel');
						}
					} else {
						if (ClientPrefs.EncoreUnlocked) {
							spr.animation.play('idle');
						} else {
							spr.animation.play('locked');
						}
					}
				case 3:
					if (spr.ID == curSelected) {
						if (ClientPrefs.SoundTestUnlocked) {
							spr.animation.play('sel');
						} else {
							spr.animation.play('lock-sel');
						}
					} else {
						if (ClientPrefs.SoundTestUnlocked) {
							spr.animation.play('idle');
						} else {
							spr.animation.play('locked');
						}
					}
				default:
					if (spr.ID == curSelected) {
						spr.animation.play('sel');
					} else {
						spr.animation.play('idle');
					}
			}
			spr.updateHitbox();
		});
	}
	
	#if desktop
	function MouseCustomHoverCallback(object:FlxObject)
	{
		//trace("overlap " + object.ID);
		MouseCustomSelection(object.ID);
		curMouseCustomSelection = object.ID;
	}
	function GOOGOOGAAGAA(object:FlxObject) {
		if (FlxG.mouse.overlaps(hitboxOfAxunnayaZalupa) && !Accepted) {
			if (object.ID != curSelected) {
				if (!selectedSomethin && !lockedControl) {
					if (object.ID < 4 && !secondPage) select(true, object.ID, '', true);
					if (object.ID > 2 && secondPage) select(true, object.ID, '', true);
				}
			}
		}
	}
	
	function MouseCustomSelection(sel:Int, ?press = false)
	{
		if (press) {
			switch(sel) {
				case 0:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 1:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 2:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 3:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = true;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 4:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 5:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 6:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 7:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = true;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 8:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = true;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
				case 9:
					if (ClientPrefs.UnlockedMouses.contains(ClientPrefs.Mouses[sel]) && ClientPrefs.SelectedMouse != sel) {
						ClientPrefs.animatedMouse = false;
						ClientPrefs.SelectedMouse = sel;
						ClientPrefs.saveSettings();
						CursorCooldown.animation.play('cd');
						CursorCooldown.animation.finishCallback = function (name:String) {
							if (name == 'cd') {
								CursorCooldown.animation.play('idle');
								CursorCooldown.animation.finishCallback = null;
							}
						};
						new FlxTimer().start(1.6, function(qwerty:FlxTimer) { CustomCursorCooldown = false; });
						CustomCursorCooldown = true;
						var Cursor = new CursorLoadState();
					}
			}
			switch(ClientPrefs.SelectedMouse) {
				case 0:
					CursorCustomSelection.setPosition(213, 615);
				case 1:
					CursorCustomSelection.setPosition(263, 615);
				case 2:
					CursorCustomSelection.setPosition(313, 615);
				case 3:
					CursorCustomSelection.setPosition(363, 615);
				case 4:
					CursorCustomSelection.setPosition(413, 615);
				case 5:
					CursorCustomSelection.setPosition(213, 665);
				case 6:
					CursorCustomSelection.setPosition(263, 665);
				case 7:
					CursorCustomSelection.setPosition(313, 665);
				case 8:
					CursorCustomSelection.setPosition(363, 665);
				case 9:
					CursorCustomSelection.setPosition(413, 665);
			}
		}
	}
	#end
	
	#if desktop
	function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		} else {
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}
	#end
	
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		#if desktop
		if (FPSBarMove) {
			if (!FPSFIXSHIT) {
				if (!FIXSHIT) {
					FPSTimer = new FlxTimer().start(0.76, function(FPSTime:FlxTimer) {
						FPSFIXSHIT = true;
					});
					FIXSHIT = true;
				}
			}
			if (FPSFIXSHIT) {
				CurFPSinBar = FPSFR;
				FPSbarPerc = FPSbar.percent;
				FPSSliderPercent = (FPSSlider.x - 992)/(1205 - 992);
				if (FPSbar.max*FPSSliderPercent > FPSbar.min)
					FPSFR = FPSbar.max*FPSSliderPercent;
				else
					FPSFR = FPSbar.min;
				FPSNum.text = Std.string(ClientPrefs.framerate);
				ClientPrefs.MainMenuFPSBarX = FPSSlider.x;
				ClientPrefs.framerate = Std.int(FPSFR+30);
			}
		}
		#end
		
		#if UPDATE_CHANGELOG
		if (!ErrorLoadingUpdateInfo) {
			if (onOffUpdInfoOnFPS) {
				UpdInfoBG.alpha = FlxMath.lerp(UpdInfoBG.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
				if (versions[versions.length-1].split('<')[1] > Application.current.meta.get('version')) {
					newUpdateLightOnOff(false);
					UpdInfoNewDark.alpha = FlxMath.lerp(UpdInfoNewDark.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
					UpdInfoNew.alpha = FlxMath.lerp(UpdInfoNew.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
				} else {
					UpdInfoINF.alpha = FlxMath.lerp(UpdInfoINF.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
				}
			} else {
				UpdInfoBG.alpha = FlxMath.lerp(UpdInfoBG.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
				if (versions[versions.length-1].split('<')[1] > Application.current.meta.get('version')) {
					newUpdateLightOnOff(true);
					UpdInfoNewDark.alpha = FlxMath.lerp(UpdInfoNewDark.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
				} else {
					UpdInfoINF.alpha = FlxMath.lerp(UpdInfoINF.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
				}
			}
		}
		#end
		
		if (onOffUpdInfoOnFPS)
			ShopButton.alpha = FlxMath.lerp(ShopButton.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
		else
			ShopButton.alpha = FlxMath.lerp(ShopButton.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
		
		if (!Accepted) select(false);
		FGup.velocity.set(50, 0);
		FGdown.velocity.set(-50, 0);
		if (!openTrophyMenu) {
			if (ClientPrefs.SongsCompletedRN.length <= 0) {
				if (ClientPrefs.SkinsUnlockedRN.length <= 0) {
					if (ClientPrefs.TrophiesUnlockedRN.length > 0 && !lockedControl && !selectedSomethin) {
						#if mobile
						removeVirtualPad();
						#end
						openSubState(new unlocked.TrophyUnlockedSubstate());
						lockedControl = true;
						selectedSomethin = true;
						lockMouseSelection = true;
					}
				} else {
					if (ClientPrefs.SkinsUnlockedRN.length > 0 && !lockedControl && !selectedSomethin) {
						#if mobile
						removeVirtualPad();
						#end
						openSubState(new unlocked.SkinUnlockedSubstate());
						lockedControl = true;
						selectedSomethin = true;
						lockMouseSelection = true;
					}
				}
			} else {
				if (ClientPrefs.SongsCompletedRN.length > 0 && !lockedControl && !selectedSomethin) {
					#if mobile
					removeVirtualPad();
					#end
					openSubState(new unlocked.EncoreUnlockedSubstate());
					lockedControl = true;
					selectedSomethin = true;
					lockMouseSelection = true;
				}
			}
		} else {
			if (!lockedControl && !selectedSomethin) {
				new FlxTimer().start(0.05, function(tmr:FlxTimer) {
					#if mobile
					removeVirtualPad();
					#end
					openSubState(new TrophiesSubstate());
					lockedControl = true;
					selectedSomethin = true;
					lockMouseSelection = true;
				});
			}
		}
		
		switch (ClientPrefs.TrophieSelected) {
			case 0:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 1:
				TooSlowTrophy.alpha = 1;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 2:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 1;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 3:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 1;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 0;
			case 4:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 1;
				FaceOffTrophy.alpha = 0;
			case 5:
				TooSlowTrophy.alpha = 0;
				YouCantRunTrophy.alpha = 0;
				TripleTroubleTrophy.alpha = 0;
				FinalEscapeTrophy.alpha = 0;
				FaceOffTrophy.alpha = 1;
		}

		if (!offButtonsThing && !lockedControl && !selectedSomethin) {
			#if desktop
			if (!FlxG.mouse.overlaps(hitboxOfAxunnayaZalupa)) {
			#end
				Buttons.forEach(function(spr:FlxSprite)
				{
					if (scrollsDown) {
						switch (curSelected)
						{
							case 0:
								Buttons.x = FlxMath.lerp(Buttons.x, 0, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, 0, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
							case 1:
								Buttons.x = FlxMath.lerp(Buttons.x, -35, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -105, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
							case 2:
								Buttons.x = FlxMath.lerp(Buttons.x, -70, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -217, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
							case 3,4,5,6:
								Buttons.x = FlxMath.lerp(Buttons.x, -105, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -329, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
						}
					} else {
						switch (curSelected)
						{
							case 0,1,2,3:
								Buttons.x = FlxMath.lerp(Buttons.x, 0, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, 0, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
							case 4:
								Buttons.x = FlxMath.lerp(Buttons.x, -35, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -105, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
							case 5:
								Buttons.x = FlxMath.lerp(Buttons.x, -70, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -217, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
							case 6:
								Buttons.x = FlxMath.lerp(Buttons.x, -105, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -336, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
						}
					}
				});
		#if desktop	} else {
				Buttons.forEach(function(spr:FlxSprite)
				{
					if (!secondPage) {
						switch (curSelected)
						{
							case 0,1,2,3:
								Buttons.x = FlxMath.lerp(Buttons.x, 0, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, 0, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
						}
					} else {
						switch (curSelected)
						{
							case 3,4,5,6:
								Buttons.x = FlxMath.lerp(Buttons.x, -105, CoolUtil.boundTo(elapsed * 6, 0, 1));
								Buttons.y = FlxMath.lerp(Buttons.y, -336, CoolUtil.boundTo(elapsed * 6, 0, 1));
								if (spr.ID == 0) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 1) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 2) spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
								if (spr.ID == 3) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 4) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 5) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
								if (spr.ID == 6) spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 12, 0, 1));
						}
					}
				});
			} #end
		}
		
		if (FlxG.keys.justPressed.DELETE #if mobile || virtualPad.buttonC.justPressed #end && !lockedControl && !selectedSomethin) {
			#if mobile
			removeVirtualPad();
			#end
			openSubState(new EraseProgressSubstate());
			lockedControl = true;
			selectedSomethin = true;
			lockMouseSelection = true;
		}
		
		if (!lockedControl && !selectedSomethin) {
			#if desktop
			if (InCustomCursor) {
				if (!CustomCursorCooldown) {
					for (i in 0...CursorLockedIcons.length)
					{
						if ((curMouseCustomSelection == i && FlxG.mouse.overlaps(CursorLockedIcons[curMouseCustomSelection])))
						{
							if (FlxG.mouse.justReleased)
							{
								MouseCustomSelection(curMouseCustomSelection, true);
							}
						}
					}
				}
				if (FlxG.mouse.overlaps(CursorCustomizationExitButton) && FlxG.mouse.justReleased) {
					FlxTween.tween(CursorCustomizationMenu, {y: 2000}, 0.0001);
					FlxTween.tween(CursorCustomizationLocked, {y: 2000}, 0.0001);
					FlxTween.tween(CursorCustomizationMenuHigher, {y: 2000}, 0.0001);
					InCustomCursor = false;
				}
				if (FlxG.mouse.overlaps(CursorCustomMenu)) {
					CursorHowToGet.alpha = 1;
					switch(curMouseCustomSelection) {
						case 1: CursorHowToGet.text = 'beat xeno week';
						case 2: CursorHowToGet.text = 'beat lord x week';
						case 3: CursorHowToGet.text = 'beat tails doll week';
						case 4:	CursorHowToGet.text = 'beat too fest song';
						case 5: CursorHowToGet.text = 'beat devoid week';
						case 6: CursorHowToGet.text = 'beat hedge song';
						case 7: CursorHowToGet.text = 'beat manual blast song';
						case 8: CursorHowToGet.text = 'beat curse week';
						case 9: CursorHowToGet.text = 'beat fatal error week';
						default: CursorHowToGet.alpha = 0.5;
								CursorHowToGet.text = '...';
						
					}
					if (TranslationLanguages.Text.exists(CursorHowToGet.text) && ClientPrefs.Language != 'English')
						CursorHowToGet.text = TranslationLanguages.Text[CursorHowToGet.text];
				} else {
					CursorHowToGet.alpha = 0.5;
					CursorHowToGet.text = '...';
				}
			} else {
				if (FlxG.mouse.overlaps(CursorCustomizationButton) && FlxG.mouse.justReleased) {
					FlxTween.tween(CursorCustomizationMenu, {y: 0}, 0.0001);
					FlxTween.tween(CursorCustomizationLocked, {y: 0}, 0.0001);
					FlxTween.tween(CursorCustomizationMenuHigher, {y: 0}, 0.0001);
					InCustomCursor = true;
				}
			}
			#end
			if (FlxG.mouse.overlaps(NoTrophy)) {
				#if desktop
					if (ClientPrefs.TrophieSelected == 0) NoTrophy.alpha = FlxMath.lerp(NoTrophy.alpha, 0.7, CoolUtil.boundTo(elapsed * 24, 0, 1));
				#end
				if (FlxG.mouse.justReleased) {
					new FlxTimer().start(0.025, function(tmr:FlxTimer) {
						openSubState(new TrophiesSubstate());
						lockedControl = true;
						selectedSomethin = true;
						lockMouseSelection = true;
					});
				}
			}
			#if mobile
			if (ClientPrefs.TrophieSelected == 0)
				NoTrophy.alpha = FlxMath.lerp(NoTrophy.alpha, 0.7, CoolUtil.boundTo(elapsed * 24, 0, 1));
			else
				NoTrophy.alpha = FlxMath.lerp(NoTrophy.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
			#end
			#if desktop if (FlxG.mouse.overlaps(PressAlt)) PressAlt.alpha = FlxMath.lerp(PressAlt.alpha, 0.7, CoolUtil.boundTo(elapsed * 24, 0, 1)); #end
			
			#if UPDATE_CHANGELOG
			if (!ErrorLoadingUpdateInfo) {
				if (!FPSMenuInside) {
					if (FlxG.mouse.overlaps(UpdInfoBG)) {
						UpdInfoBG.color = 0xFF606060;
						if (versions[versions.length-1].split('<')[1] > Application.current.meta.get('version'))
							UpdInfoNew.color = 0xFF3A3A3A;
						else
							UpdInfoINF.color = 0xFF3A3A3A;
						if (FlxG.mouse.pressed)
							MusicBeatState.switchState(new Changelog());
					} else {
						if (versions[versions.length-1].split('<')[1] > Application.current.meta.get('version'))
							UpdInfoNew.color = 0xFFFFFFFF;
						else
							UpdInfoINF.color = 0xFFFFFFFF;
					}
				}
			}
			#end
			
			if (!FPSMenuInside) {
				if (FlxG.mouse.overlaps(ShopButton)) {
					ShopButton.color = 0xFF3A3A3A;
					if (FlxG.mouse.pressed)
						MusicBeatState.switchState(new Shop());
				} else {
					ShopButton.color = 0xFFFFFFFF;
				}
			}
			
			#if desktop
			if (FPSMenuInside) {
				if (FlxG.mouse.overlaps(FPSButton))
					FPSButton.color = 0xFFFFFFFF;
				else
					FPSButton.color = 0xFF606060;
				FPSMenuSliderStuff.x = FlxMath.lerp(FPSMenuSliderStuff.x, 0, CoolUtil.boundTo(elapsed * 14, 0, 1));
				FPSMenuNUMStuff.y = FlxMath.lerp(FPSMenuNUMStuff.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSSlider.alpha = FlxMath.lerp(FPSSlider.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSbar.alpha = FlxMath.lerp(FPSbar.alpha, 1, CoolUtil.boundTo(elapsed * 3, 0, 1));
				FPSClassicMenuStuff30.y = FlxMath.lerp(FPSClassicMenuStuff30.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff60.y = FlxMath.lerp(FPSClassicMenuStuff60.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff120.y = FlxMath.lerp(FPSClassicMenuStuff120.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff144.y = FlxMath.lerp(FPSClassicMenuStuff144.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff240.y = FlxMath.lerp(FPSClassicMenuStuff240.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff360.y = FlxMath.lerp(FPSClassicMenuStuff360.y, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				if (FlxG.mouse.overlaps(FPSClassic30)) {
					if (FlxG.mouse.justReleased) FPSSlider.x = 992;
					FPSClassicMenuStuff30.color = 0xFFFFFFFF;
				} else { FPSClassicMenuStuff30.color = 0xFF606060; }
				if (FlxG.mouse.overlaps(FPSClassic60)) {
					if (FlxG.mouse.justReleased) FPSSlider.x = 1012;
					FPSClassicMenuStuff60.color = 0xFFFFFFFF;
				} else { FPSClassicMenuStuff60.color = 0xFF606060; }
				if (FlxG.mouse.overlaps(FPSClassic120)) {
					if (FlxG.mouse.justReleased) FPSSlider.x = 1050.5;
					FPSClassicMenuStuff120.color = 0xFFFFFFFF;
				} else { FPSClassicMenuStuff120.color = 0xFF606060; }
				if (FlxG.mouse.overlaps(FPSClassic144)) {
					if (FlxG.mouse.justReleased) FPSSlider.x = 1066;
					FPSClassicMenuStuff144.color = 0xFFFFFFFF;
				} else { FPSClassicMenuStuff144.color = 0xFF606060; }
				if (FlxG.mouse.overlaps(FPSClassic240)) {
					if (FlxG.mouse.justReleased) FPSSlider.x = 1128;
					FPSClassicMenuStuff240.color = 0xFFFFFFFF;
				} else { FPSClassicMenuStuff240.color = 0xFF606060; }
				if (FlxG.mouse.overlaps(FPSClassic360)) {
					if (FlxG.mouse.justReleased) FPSSlider.x = 1205;
					FPSClassicMenuStuff360.color = 0xFFFFFFFF;
				} else { FPSClassicMenuStuff360.color = 0xFF606060; }
				
				if (!FPSBarMove)
					FPSBarMove = true;
				if (FlxG.mouse.overlaps(FPSSlider)) {
					if (FlxG.mouse.pressed) {
						FPSSliderHoldingMouse = true;
						onChangeFramerate();
						if (FlxG.mouse.x >= 992 && FlxG.mouse.x <= 1205)
							FPSSlider.x = FlxG.mouse.x;
					}
				} else {
					if (FlxG.mouse.pressed && FPSSliderHoldingMouse) {
						onChangeFramerate();
						if (FlxG.mouse.x >= 992 && FlxG.mouse.x <= 1205)
							FPSSlider.x = FlxG.mouse.x;
					}
					if (FlxG.mouse.pressed && FPSSliderHoldingMouse)
						FPSSliderHoldingMouse = true;
					else
						FPSSliderHoldingMouse = false;
				}
			} else {
				if (!FlxG.mouse.overlaps(FPSButton))
					FPSButton.color = 0xFFFFFFFF;
				else
					FPSButton.color = 0xFF606060;
				FPSMenuSliderStuff.x = FlxMath.lerp(FPSMenuSliderStuff.x, 290, CoolUtil.boundTo(elapsed * 12, 0, 1));
				FPSMenuNUMStuff.y = FlxMath.lerp(FPSMenuNUMStuff.y, -34, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSSlider.alpha = FlxMath.lerp(FPSSlider.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSbar.alpha = FlxMath.lerp(FPSbar.alpha, 0, CoolUtil.boundTo(elapsed * 50, 0, 1));
				FPSClassicMenuStuff30.y = FlxMath.lerp(FPSClassicMenuStuff30.y, -100, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff60.y = FlxMath.lerp(FPSClassicMenuStuff60.y, -140, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff120.y = FlxMath.lerp(FPSClassicMenuStuff120.y, -180, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff144.y = FlxMath.lerp(FPSClassicMenuStuff144.y, -220, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff240.y = FlxMath.lerp(FPSClassicMenuStuff240.y, -260, CoolUtil.boundTo(elapsed * 24, 0, 1));
				FPSClassicMenuStuff360.y = FlxMath.lerp(FPSClassicMenuStuff360.y, -300, CoolUtil.boundTo(elapsed * 24, 0, 1));
			}
			if (FlxG.mouse.overlaps(FPSButton)) {
				if (FlxG.mouse.justReleased) {
					if (!FPSMenuInside) {
						FPSMenuInside = true;
						onOffUpdInfoOnFPS = true;
					} else {
						ClientPrefs.saveSettings();
						FPSMenuInside = false;
						onOffUpdInfoOnFPS = false;
						FPSBarMove = false;
						FPSBarMove = false;
						FIXSHIT = false;
						if(FPSTimer!=null){
							FPSTimer.cancel();
						}
					}
				}
			} else {
				if (!FlxG.mouse.overlaps(FPSMenu) && FlxG.mouse.justReleased) {
					ClientPrefs.saveSettings();
					FPSMenuInside = false;
					onOffUpdInfoOnFPS = false;
					FPSBarMove = false;
					FPSBarMove = false;
					FIXSHIT = false;
					if(FPSTimer!=null){
						FPSTimer.cancel();
					}
				}
			}
			#end
		}
		#if desktop
		if (InCustomCursor) {
			if ((!FlxG.mouse.overlaps(CursorCustomizationButton) && !FlxG.mouse.overlaps(CursorCustomizationExitButton) && !FlxG.mouse.overlaps(CursorCustomMenu)) && FlxG.mouse.justPressed) {
				FlxTween.tween(CursorCustomizationMenu, {y: 2000}, 0.0001);
				FlxTween.tween(CursorCustomizationLocked, {y: 2000}, 0.0001);
				FlxTween.tween(CursorCustomizationMenuHigher, {y: 2000}, 0.0001);
				InCustomCursor = false;
			}
		}
		
		if (!lockedControl && !selectedSomethin) {
			if (FlxG.mouse.overlaps(MouseScrollUp) && secondPage) {
				MouseScrollUp.alpha = 0;
				MouseScrollUpSel.alpha = 1;
				MouseScrollUp.y = 55;
				MouseScrollUpSel.y = 55;
				secondPage = false;
			}
			if (FlxG.mouse.overlaps(MouseScrollDown) && !secondPage) {
				MouseScrollDown.alpha = 0;
				MouseScrollDownSel.alpha = 1;
				MouseScrollDown.y = 569;
				MouseScrollDownSel.y = 569;
				secondPage = true;
			}
		}

		if (FlxG.mouse.overlaps(hitboxOfAxunnayaZalupa)) {
				cursorArrowsFix = true;
				ArrowUp.alpha = FlxMath.lerp(ArrowUp.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				ArrowUpSel.alpha = FlxMath.lerp(ArrowUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				ArrowDown.alpha = FlxMath.lerp(ArrowDown.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				ArrowDownSel.alpha = FlxMath.lerp(ArrowDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
				
				if (secondPage) {
					MouseScrollUp.alpha = FlxMath.lerp(MouseScrollUp.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					MouseScrollUpSel.alpha = FlxMath.lerp(MouseScrollUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 15, 0, 1));
					MouseScrollDown.alpha = FlxMath.lerp(MouseScrollDown.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					MouseScrollDownSel.alpha = FlxMath.lerp(MouseScrollDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 15, 0, 1));
				} else {
					MouseScrollUp.alpha = FlxMath.lerp(MouseScrollUp.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					MouseScrollUpSel.alpha = FlxMath.lerp(MouseScrollUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 15, 0, 1));
					MouseScrollDown.alpha = FlxMath.lerp(MouseScrollDown.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					MouseScrollDownSel.alpha = FlxMath.lerp(MouseScrollDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 15, 0, 1));
				}
		} else {
			cursorArrowsFix = false;
			ArrowUp.alpha = FlxMath.lerp(ArrowUp.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
			ArrowUpSel.alpha = FlxMath.lerp(ArrowUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
			ArrowDown.alpha = FlxMath.lerp(ArrowDown.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
			ArrowDownSel.alpha = FlxMath.lerp(ArrowDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
			
			MouseScrollUp.alpha = FlxMath.lerp(MouseScrollUp.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
			MouseScrollUpSel.alpha = FlxMath.lerp(MouseScrollUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
			MouseScrollDown.alpha = FlxMath.lerp(MouseScrollDown.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
			MouseScrollDownSel.alpha = FlxMath.lerp(MouseScrollDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		}
		#else
		cursorArrowsFix = false;
		ArrowUp.alpha = FlxMath.lerp(ArrowUp.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
		ArrowUpSel.alpha = FlxMath.lerp(ArrowUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		ArrowDown.alpha = FlxMath.lerp(ArrowDown.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
		ArrowDownSel.alpha = FlxMath.lerp(ArrowDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		
		MouseScrollUp.alpha = FlxMath.lerp(MouseScrollUp.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		MouseScrollUpSel.alpha = FlxMath.lerp(MouseScrollUpSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		MouseScrollDown.alpha = FlxMath.lerp(MouseScrollDown.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		MouseScrollDownSel.alpha = FlxMath.lerp(MouseScrollDownSel.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		#end
		ArrowUp.y = FlxMath.lerp(ArrowUp.y, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
		ArrowUpSel.y = FlxMath.lerp(ArrowUpSel.y, 0, CoolUtil.boundTo(elapsed * 12, 0, 1));
		ArrowDown.y = FlxMath.lerp(ArrowDown.y, 10, CoolUtil.boundTo(elapsed * 12, 0, 1));
		ArrowDownSel.y = FlxMath.lerp(ArrowDownSel.y, 10, CoolUtil.boundTo(elapsed * 12, 0, 1));
		
		MouseScrollUp.y = FlxMath.lerp(MouseScrollUp.y, 65, CoolUtil.boundTo(elapsed * 12, 0, 1));
		MouseScrollUpSel.y = FlxMath.lerp(MouseScrollUpSel.y, 65, CoolUtil.boundTo(elapsed * 12, 0, 1));
		MouseScrollDown.y = FlxMath.lerp(MouseScrollDown.y, 559, CoolUtil.boundTo(elapsed * 12, 0, 1));
		MouseScrollDownSel.y = FlxMath.lerp(MouseScrollDownSel.y, 559, CoolUtil.boundTo(elapsed * 12, 0, 1));
		
		#if desktop if (!FlxG.mouse.overlaps(NoTrophy)) NoTrophy.alpha = FlxMath.lerp(NoTrophy.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
		if (!FlxG.mouse.overlaps(PressAlt)) PressAlt.alpha = FlxMath.lerp(PressAlt.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1)); #end
		
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		
		#if DEV_MODE
		if (FlxG.keys.justPressed.Q && !lockedControl && !selectedSomethin)
			MenuArtRandom(ClientPrefs.UnlockedMenuArts.length, true);
		if (#if desktop FlxG.keys.justPressed.F1 #else virtualPad.buttonD.justPressed #end && !lockedControl && !selectedSomethin) {
			new FlxTimer().start(0.05, function(tmr:FlxTimer) {
				#if mobile
				removeVirtualPad();
				#end
				openSubState(new DebugSubstate());
				lockedControl = true;
				selectedSomethin = true;
				lockMouseSelection = true;
			});
		}
		#end
		
		#if desktop
		if (FlxG.keys.justPressed.TAB && !lockedControl && !selectedSomethin) {
			new FlxTimer().start(0.05, function(tmr:FlxTimer) {
				openSubState(new TrophiesSubstate());
				lockedControl = true;
				selectedSomethin = true;
				lockMouseSelection = true;
			});
		}
		
		if (coolKeybindsArrows) {
			if (FlxG.keys.anyPressed(NLeft)) {
				FlxTween.cancelTweensOf(LeftArrowPressed);
				LeftArrowPressed.alpha = 1;
				FlxTween.tween(LeftArrowPressed, {alpha: 0}, 0.3);
			}
			if (FlxG.keys.anyPressed(NDown)) {
				FlxTween.cancelTweensOf(DownArrowPressed);
				DownArrowPressed.alpha = 1;
				FlxTween.tween(DownArrowPressed, {alpha: 0}, 0.3);
			}
			if (FlxG.keys.anyPressed(NSpace)) {
				FlxTween.cancelTweensOf(SpaceArrowPressed);
				SpaceArrowPressed.alpha = 1;
				FlxTween.tween(SpaceArrowPressed, {alpha: 0}, 0.3);
			}
			if (FlxG.keys.anyPressed(NUp)) {
				FlxTween.cancelTweensOf(UpArrowPressed);
				UpArrowPressed.alpha = 1;
				FlxTween.tween(UpArrowPressed, {alpha: 0}, 0.3);
			}
			if (FlxG.keys.anyPressed(NRight)) {
				FlxTween.cancelTweensOf(RightArrowPressed);
				RightArrowPressed.alpha = 1;
				FlxTween.tween(RightArrowPressed, {alpha: 0}, 0.3);
			}
			
			if (FlxG.keys.anyPressed(NLeftO)) {
				FlxTween.cancelTweensOf(NoteLEFTO);
				NoteLEFTO.alpha = 1;
				FlxTween.tween(NoteLEFTO, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NDownO)) {
				FlxTween.cancelTweensOf(NoteDOWNO);
				NoteDOWNO.alpha = 1;
				FlxTween.tween(NoteDOWNO, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NSpaceO)) {
				FlxTween.cancelTweensOf(NoteSPECIALO);
				NoteSPECIALO.alpha = 1;
				FlxTween.tween(NoteSPECIALO, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NUpO)) {
				FlxTween.cancelTweensOf(NoteUPO);
				NoteUPO.alpha = 1;
				FlxTween.tween(NoteUPO, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NRightO)) {
				FlxTween.cancelTweensOf(NoteRIGHTO);
				NoteRIGHTO.alpha = 1;
				FlxTween.tween(NoteRIGHTO, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NLeftT)) {
				FlxTween.cancelTweensOf(NoteLEFTT);
				NoteLEFTT.alpha = 1;
				FlxTween.tween(NoteLEFTT, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NDownT)) {
				FlxTween.cancelTweensOf(NoteDOWNT);
				NoteDOWNT.alpha = 1;
				FlxTween.tween(NoteDOWNT, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NSpaceT)) {
				FlxTween.cancelTweensOf(NoteSPECIALT);
				NoteSPECIALT.alpha = 1;
				FlxTween.tween(NoteSPECIALT, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NUpT)) {
				FlxTween.cancelTweensOf(NoteUPT);
				NoteUPT.alpha = 1;
				FlxTween.tween(NoteUPT, {alpha: 0.4}, 0.3);
			}
			if (FlxG.keys.anyPressed(NRightT)) {
				FlxTween.cancelTweensOf(NoteRIGHTT);
				NoteRIGHTT.alpha = 1;
				FlxTween.tween(NoteRIGHTT, {alpha: 0.4}, 0.3);
			}
		}
		
		if (!keyBindTime) {
			if (!lockedControl && !selectedSomethin) {
				if ((FlxG.keys.justPressed.ALT || (FlxG.mouse.overlaps(PressAlt) && (FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle))) && !kBtime) {
					KeyBindsOpen(true);
				}
			}
			if (lockedControl && selectedSomethin) {
				if ((FlxG.keys.justPressed.ALT || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(keyBindsExit) && (FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle))) && kBtime) {
					KeyBindsOpen(false);
					LeftArrowPressed.alpha = 0;
					DownArrowPressed.alpha = 0;
					SpaceArrowPressed.alpha = 0;
					UpArrowPressed.alpha = 0;
					RightArrowPressed.alpha = 0;
				}
			}
		}
		#end
		if (!selectedSomethin && !lockedControl)
		{
			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			#if desktop if (!FlxG.mouse.overlaps(hitboxOfAxunnayaZalupa)) { #end
				if (controls.UI_UP_P)
				{
					select(true,-shiftMult,'up');
					holdTime = 0;
				}
				if (controls.UI_DOWN_P)
				{
					select(true,shiftMult,'down');
					holdTime = 0;
				}
				if (controls.UI_DOWN_P || controls.UI_UP_P)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						if (controls.UI_UP_P) select(true,(checkNewHold - checkLastHold) * (controls.UI_UP_P ? -shiftMult : shiftMult), 'up');
						if (controls.UI_DOWN_P) select(true,(checkNewHold - checkLastHold) * (controls.UI_UP_P ? -shiftMult : shiftMult), 'down');
					}
				}
				#if desktop
				if (FlxG.mouse.wheel != 0)
				{
					if (FlxG.mouse.wheel > 0) select(true,-shiftMult * FlxG.mouse.wheel,'up');
					if (FlxG.mouse.wheel < 0) select(true,-shiftMult * FlxG.mouse.wheel,'down');
					holdTime = 0;
				}
			}
			if (!InCustomCursor) {
			#end
				if (controls.BACK || #if desktop FlxG.mouse.justPressedRight #else FlxG.android.justReleased.BACK #end) {
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
					MusicBeatState.switchState(new TitleState());
				}
			#if desktop
			} else {
				if (controls.BACK || FlxG.mouse.justPressedRight) {
					FlxTween.tween(CursorCustomizationMenu, {y: 2000}, 0.0001);
					FlxTween.tween(CursorCustomizationLocked, {y: 2000}, 0.0001);
					FlxTween.tween(CursorCustomizationMenuHigher, {y: 2000}, 0.0001);
					InCustomCursor = false;
				}
			}
			#end
			
			if (controls.ACCEPT #if desktop || (FlxG.mouse.overlaps(Buttons) && (FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle)) && ((!FlxG.mouse.overlaps(CursorCustomizationButton)) && !FlxG.mouse.overlaps(CursorCustomizationExitButton) && !FlxG.mouse.overlaps(CursorCustomMenu) && !FlxG.mouse.overlaps(NoTrophy) && !FlxG.mouse.overlaps(keyBindsExit) && !FlxG.mouse.overlaps(PressAlt))#end) {
				if ((optionShit[curSelected] == 'sound_test' && !ClientPrefs.SoundTestUnlocked) || (optionShit[curSelected] == 'encore' && !ClientPrefs.EncoreUnlocked)) {
					FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
				} else {
					#if desktop
					if (InCustomCursor) {
						FlxTween.tween(CursorCustomizationMenu, {y: 2000}, 0.0001);
						FlxTween.tween(CursorCustomizationLocked, {y: 2000}, 0.0001);
						FlxTween.tween(CursorCustomizationMenuHigher, {y: 2000}, 0.0001);
						InCustomCursor = false;
					}
					lockMouseSelection = true;
					#end
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);

					Buttons.forEach(function(spr:FlxSprite)
					{
						Accepted = true;
						if (!IhateThatFuckingShitCode) accept();
						new FlxTimer().start(1, function(hello:FlxTimer)
						{
							var daChoice:String = optionShit[curSelected];
							switch (daChoice)
							{
								case 'story_mode':
									MusicBeatState.switchState(new StoryMenuState());
								case 'encore':
									MusicBeatState.switchState(new EncoreState());
								case 'freeplay':
									MusicBeatState.switchState(new FreeplayState());
								case 'sound_test':
									FlxTransitionableState.skipNextTransIn = false;
									FlxTransitionableState.skipNextTransOut = false;
									MusicBeatState.switchState(new SoundTestState());
								case 'credits':
									MusicBeatState.switchState(new CreditsState());
								case 'options':
									MusicBeatState.switchState(new options.OptionsNewState());
								case 'extras':
									FlxG.sound.music.fadeOut(0.85, 0);
									if (!ClientPrefs.ExtrasMathSolved) {
										MusicBeatState.switchState(new extras.CodeState());
									} else {
										if (ClientPrefs.ShowExtrasCode) {
											MusicBeatState.switchState(new extras.CodeState());
										} else {
											MusicBeatState.switchState(new extras.ExtrasState());
										}
									}
							}
						});
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				LoadingState.loadAndSwitchState(new editors.CharacterEditorState(Character.DEFAULT_CHARACTER, false));
				FlxG.sound.music.volume = 0;
			}
			#end
		}
	}
	
	function accept()
	{
		if (Accepted) {
			#if desktop
			if (!FlxG.mouse.overlaps(Buttons)) {
				if (scrollsDown) {
					Buttons.forEach(function(spr:FlxSprite) {
						switch (curSelected) {
							case 0:
								if (spr.ID == 0) spr.animation.play('epilepsy');
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 1:
								if (spr.ID == 1) spr.animation.play('epilepsy');
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 2:
								if (spr.ID == 2) spr.animation.play('epilepsy');
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 3:
								if (spr.ID == 3) spr.animation.play('epilepsy');
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 4:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) spr.animation.play('epilepsy');
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 5:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) spr.animation.play('epilepsy');
								if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 6:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) spr.animation.play('epilepsy');
						}
					});
				} else {
					Buttons.forEach(function(spr:FlxSprite) {
						switch (curSelected) {
							case 0:
								if (spr.ID == 0) spr.animation.play('epilepsy');
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 1:
								if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 1) spr.animation.play('epilepsy');
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 2:
								if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) spr.animation.play('epilepsy');
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 3:
								if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) spr.animation.play('epilepsy');
							case 4:
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) spr.animation.play('epilepsy');
							case 5:
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) spr.animation.play('epilepsy');
							case 6:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) spr.animation.play('epilepsy');
						}
					});
				}
			} else {
				if (!secondPage) {
					Buttons.forEach(function(spr:FlxSprite) {
						switch (curSelected) {
							case 0:
								if (spr.ID == 0) spr.animation.play('epilepsy');
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 1:
								if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 1) spr.animation.play('epilepsy');
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 2:
								if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) spr.animation.play('epilepsy');
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 3:
								if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 3) spr.animation.play('epilepsy');
						}
					});
				} else {
					Buttons.forEach(function(spr:FlxSprite) {
						switch (curSelected) {
							case 3:
								if (spr.ID == 3) spr.animation.play('epilepsy');
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 4:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) spr.animation.play('epilepsy');
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 5:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) spr.animation.play('epilepsy');
								if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							case 6:
								if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
								if (spr.ID == 6) spr.animation.play('epilepsy');
						}
					});
				}
			}
			#else
			if (scrollsDown) {
				Buttons.forEach(function(spr:FlxSprite) {
					switch (curSelected) {
						case 0:
							if (spr.ID == 0) spr.animation.play('epilepsy');
							if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 1:
							if (spr.ID == 1) spr.animation.play('epilepsy');
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 2:
							if (spr.ID == 2) spr.animation.play('epilepsy');
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 3:
							if (spr.ID == 3) spr.animation.play('epilepsy');
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 4:
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) spr.animation.play('epilepsy');
							if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 5:
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 5) spr.animation.play('epilepsy');
							if (spr.ID == 6) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 6:
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 6) spr.animation.play('epilepsy');
					}
				});
			} else {
				Buttons.forEach(function(spr:FlxSprite) {
					switch (curSelected) {
						case 0:
							if (spr.ID == 0) spr.animation.play('epilepsy');
							if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 1:
							if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 1) spr.animation.play('epilepsy');
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 2:
							if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 2) spr.animation.play('epilepsy');
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
						case 3:
							if (spr.ID == 0) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) spr.animation.play('epilepsy');
						case 4:
							if (spr.ID == 1) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) spr.animation.play('epilepsy');
						case 5:
							if (spr.ID == 2) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 5) spr.animation.play('epilepsy');
						case 6:
							if (spr.ID == 3) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 4) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 5) FlxTween.color(spr, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
							if (spr.ID == 6) spr.animation.play('epilepsy');
					}
				});
			}
			#end
		}
		if (!cursorArrowsFix) {
			FlxTween.color(ArrowUp, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
			FlxTween.color(ArrowDown, 0.3, 0xFFFFFFFF, 0xFF515151, {ease: FlxEase.quadOut});
		}
		IhateThatFuckingShitCode = true;
	}
}