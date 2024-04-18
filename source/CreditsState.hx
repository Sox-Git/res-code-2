// VINE BOOM
// SHIT CODE MOMENT

package;

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
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import openfl.utils.Assets;
import sys.FileSystem;
import flixel.math.FlxMath;

using StringTools;

class CreditsState extends MusicBeatState
{
	var bgDay:FlxSprite;
	var starsDay:FlxSprite;
	var UWUDay:FlxSprite;

	var bgNight:FlxSprite;
	var starsNight:FlxSprite;
	var UWUNight:FlxSprite;
	
	var Panel:FlxSprite;
	var CreditsLeft:FlxSprite;
	var CreditsRight:FlxSprite;
	var ChangeTeamUp:FlxSprite;
	var ChangeTeamDown:FlxSprite;
	var ChangeTeamMidUP:FlxSprite;
	var ChangeTeamMidDOWN:FlxSprite;
	var CurrentTeam:FlxSprite;
	var OldTeam:FlxSprite;
	var SpecialThanks:FlxSprite;

	var curSelected:Int = 0;
	var curFlag:String = 'RU';
	public static var curPage:String = 'NEW';
	var IsNight:Bool = false;
	var canPress:Bool = false;
	public static var RNIsHere:Bool = false;
	var CreditsX:Float = 0;
	var shiftMult:Int = 1;
	var holdTime:Float = 0;
	private var camGame:FlxCamera;
	var mouseHitbox:FlxSprite;
	
	var Credits:FlxTypedSpriteGroup<FlxSprite>;
	var CreditIcon:FlxTypedSpriteGroup<FlxSprite>;
	var CreditFlag:FlxTypedSpriteGroup<FlxSprite>;
	var CreditFrame:FlxTypedSpriteGroup<FlxSprite>;
	var CreditsTextOne:FlxTypedSpriteGroup<FlxSprite>;
	var CreditsTextTwo:FlxTypedSpriteGroup<FlxSprite>;
	var NicknameCredits:Array<String> = [
		'Merphi',
		'Sulonam',
		'Angelgamepad',
		'Artisus',
		'Bawnic',
		'Benimus',
		'BeyTail',
		'B_Fezz',
		'Boring345',
		'Bosu',
		'Boyo',
		'Capitan Jorge',
		'Chron Delta',
		'Colin',
		'DanlyDaMusicant',
		'Doge',
		'DroCaleb',
		'DStickman',
		'EmisadorCWO',
		'Enginerr',
		'Estaguy',
		'Exe',
		'FatalVoid',
		'Flexmaster',
		'GhostLab',
		'GioIsDead',
		'GoldieHub',
		'HyperDream',
		'Inski',
		'JDogg',
		'Kamilion1444455',
		'Kawaii',
		'Kea.Bat',
		'Kophy232',
		'KraimDS',
		'L-4GXE',
		'Leafy-Ivy_Ray',
		'LeefLett',
		'LonelyKris',
		'Luc',
		'MajinCrast',
		'Majora',
		'MarioMaster',
		'Mastex',
		'MaysLastPlay',
		'MeDicenKay',
		'Mr. Half',
		'OtherWorldly',
		'Pringle',
		'Raimbowcore12',
		'Ralsei',
		'RedyShines',
		'ReX',
		'Sanko',
		'Scarcen',
		'Sebas1554',
		'Shyllis',
		'Simplistic',
		'SonicDDY',
		'SonicPlay',
		'STG55544',
		'SunTime',
		'Surf',
		'Tailsfangut2',
		'TheG',
		'TheGreatBeyond',
		'TimoX',
		'Tomis13t',
		'TRENO',
		'Wolfie_1985',
		'ZolZarolZ'
	];
	var NicknameCreditsWorker:Array<String> = [
		'Director, Main Coder',
		'CoDirector, Coder, Artist',
		'Artist',
		'Artist',
		'Artist',
		'Artist',
		'Composer',
		'Artist',
		'Composer',
		'Artist',
		'Artist',
		'Composer',
		'Composer',
		'Charter',
		'Composer',
		'Composer',
		'Composer',
		'Artist, Animator',
		'Composer',
		'Artist',
		'Artist, Pixel Artist',
		'Composer',
		'Charter',
		'Voice Actor',
		'Composer',
		'Artist',
		'Mobile Port Coder',
		'Artist',
		'Artist, Composer',
		'Charter',
		'Artist',
		'Composer',
		'Composer',
		'Charter',
		'Composer',
		'Charter',
		'Charter, Voice Actor',
		'Artist, Animator',
		'Charter',
		'Artist, Animator',
		'Artist, Animator',
		'Artist, Animator',
		'Mobile Port Coder',
		'Composer',
		'Mobile Port Coder',
		'Archivist, Song Credits',
		'Charter',
		'Artist',
		'Charter',
		'Charter',
		'Mobile Port Coder',
		'Artist, Pixel Artist',
		'Artist',
		'Composer',
		'Composer',
		'Artist',
		'Coder, Composer',
		'Artist, Pixel Artist',
		'Charter',
		'Coder, Artist',
		'Artist, Animator',
		'Composer',
		'Artist, Animator',
		'Artist',
		'Artist',
		'Artist, Animator',
		'Charter, Animator',
		'Composer',
		'Artist, Animator',
		'Coder, Charter',
		'Artist'
	];
	
	var NicknameCreditsOld:Array<String> = [
		'Futagami',
		'A1zen',
		'Aughnubis',
		'BaTIF104',
		'CapybaraSonic',
		'Cartoon Cat',
		'DuduGD',
		'FNAFfan1',
		'Frobissuck',
		'Geovanito',
		'Goldenfoxy2604',
		'Gray',
		'Hog',
		'InsertName011',
		'ItsFellow',
		'LilMip',
		'LOSER',
		'Luigio2',
		'Megalovb',
		'M0nke',
		'Nefarionus',
		'NicolasMyt',
		'Niko',
		'Red',
		'RS Productions',
		'Sedol',
		'Sirox',
		'SleepyCat',
		'Synth',
		'TwinGeoduk',
		'UNI',
		'ViSanguis',
		'Weeetete12',
		'Willosaur',
		'Xpastelxbloodx',
		'ZeroXSP'
	];
	var NicknameCreditsWorkerOld:Array<String> = [
		'Director, Artist, Charter',
		'Artist',
		'Charter',
		'Artist',
		'Artist',
		'Artist',
		'Charter',
		'Artist',
		'Artist',
		'Artist',
		'Charter',
		'Artist',
		'Artist',
		'Charter',
		'Code Helper',
		'Artist',
		'Charter',
		'Charter',
		'Pixel Artist',
		'Artist',
		'Charter',
		'Code Helper',
		'Composer',
		'Composer',
		'Artist',
		'Artist',
		'Code Helper',
		'Charter',
		'Charter',
		'Charter',
		'Charter',
		'Artist',
		'Artist',
		'Pixel Artist',
		'Composer',
		'Charter'
	];
	
	var NicknameCreditsST:Array<String> = [
		'Ashburn',
		'Astronomical',
		'Blue Demon',
		'Break010',
		'CinderSamurai',
		'Claude Speed',
		'Cynx303',
		'Danix',
		'Dark Blaze',
		'Dayron',
		'Diego VideoGames',
		'Dolor de Duodeno',
		'Dumboy Mikey',
		'Dupanims',
		'EliteHack',
		'Galaxy Drawing',
		'GasGrass',
		'GAto',
		'Gh0st542',
		'John9Doe',
		'KingFox',
		'Mad',
		'NayreFunkin',
		'Nefastius',
		'NickLivePro',
		'O Mundo',
		'OniiAnubis',
		'Oratual',
		'PootisTF2',
		'RexNeo2190',
		'RoFos',
		'Ruisna',
		'Ryzzon',
		'Saldavid',
		'Sami',
		'ShutUpJojo',
		'Socoolidied',
		'SSG950',
		'SusanMiada',
		'TheForgotten',
		'TOKCU4',
		'Torresmmo',
		'Travis',
		'Wewer'
	];
	var NicknameCreditsWorkerST:Array<String> = [
		'Voice Actor',
		'YT Support',
		'Artist',
		'Artist',
		'Soonc Creator',
		'Support',
		'Artist',
		'Charter, Artist',
		'Support',
		'Icons Artist',
		'YT Support',
		'Artist In Memes',
		'YT Sponsor',
		'Artist, Animator',
		'Support, Charter',
		'Support, Artist',
		'Sl4sh Voice Actor',
		'Support',
		'GMod BG Artist',
		'3D Artist, Animator',
		'Curse Voice Actor',
		'Support',
		'Artist, Support',
		'Support',
		'Support',
		'Artist',
		'YT Sponsor',
		'Voice Actor',
		'Artist, Voice Actor',
		'Support',
		'Composer',
		'YT Sponsor',
		'YT Sponsor',
		'Support',
		'Lady Tails Creator',
		'Needlemouse Creator',
		'Support',
		'Exieco Creator',
		'Eris Creator',
		'Support',
		'YT Support',
		'Artist, Animator',
		'Funkipedia Editor',
		'Artist',
	];
	
	override function create()
	{
		Paths.clearUnusedMemory();
		Paths.clearStoredMemory();

		#if desktop
		DiscordClient.imageRpc = 'credits';
		var rpcName:String = 'In Credits Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.changePresence(rpcName, null);
		#end
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		FlxG.sound.playMusic(Paths.music('credits'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);

		//Day
		bgDay = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/day/bg'));
		bgDay.antialiasing = ClientPrefs.globalAntialiasing;
		bgDay.scrollFactor.set();
		add(bgDay);
		
		starsDay = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/day/stars'));
		starsDay.antialiasing = ClientPrefs.globalAntialiasing;
		starsDay.scrollFactor.set();
		add(starsDay);
		
		UWUDay = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/day/uwu'));
		UWUDay.antialiasing = ClientPrefs.globalAntialiasing;
		UWUDay.scrollFactor.set();
		add(UWUDay);
		
		//Night
		bgNight = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/night/bg'));
		bgNight.antialiasing = ClientPrefs.globalAntialiasing;
		bgNight.scrollFactor.set();
		bgNight.alpha = 0;
		add(bgNight);
		
		starsNight = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/night/stars'));
		starsNight.antialiasing = ClientPrefs.globalAntialiasing;
		starsNight.scrollFactor.set();
		starsNight.alpha = 0;
		add(starsNight);

		UWUNight = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/night/uwu'));
		UWUNight.antialiasing = ClientPrefs.globalAntialiasing;
		UWUNight.scrollFactor.set();
		UWUNight.alpha = 0;
		add(UWUNight);
		
		//Credits
		Panel = new FlxSprite(0, 420).loadGraphic(Paths.image('credits/credits-stuff/panel'));
		Panel.antialiasing = ClientPrefs.globalAntialiasing;
		Panel.scrollFactor.set();
		Panel.alpha = 0;
		add(Panel);
		
		CreditIcon = new FlxTypedSpriteGroup<FlxSprite>();
		add(CreditIcon);
		CreditFlag = new FlxTypedSpriteGroup<FlxSprite>();
		add(CreditFlag);
		CreditFrame = new FlxTypedSpriteGroup<FlxSprite>();
		add(CreditFrame);
		CreditsTextOne = new FlxTypedSpriteGroup<FlxSprite>();
		add(CreditsTextOne);
		CreditsTextTwo = new FlxTypedSpriteGroup<FlxSprite>();
		add(CreditsTextTwo);
		
		switch(curPage) {
			case 'NEW':
				for (i in 0...NicknameCredits.length)
				{			
					var icon:FlxSprite = new FlxSprite(437 + CreditsX, 465);
					icon.ID = i;
					switch(NicknameCredits[i]) {
						case 'Torresmmo':
							icon.frames = Paths.getSparrowAtlas('credits/credits-stuff/icons/Torresmmo');
							icon.animation.addByPrefix('torr', 'Torresmmo', 24);
							icon.animation.play('torr', true);
						default:
					  	#if desktop
							if (FileSystem.exists('assets/images/credits/credits-stuff/icons/' + NicknameCredits[i] + '.png'))
							#else
							if (Assets.exists('assets/images/credits/credits-stuff/icons/' + NicknameCredits[i] + '.png'))
							#end
								icon.loadGraphic(Paths.image('credits/credits-stuff/icons/' + NicknameCredits[i]));
							else
								icon.loadGraphic(Paths.image('credits/credits-stuff/icons/placeholder'));
					}
					icon.antialiasing = ClientPrefs.globalAntialiasing;
					icon.scrollFactor.set();
					CreditIcon.add(icon);
					
					switch(NicknameCredits[i]) {
						case 'Capitan Jorge', 'Luc': curFlag = 'AR';
						case 'SonicDDY': curFlag = 'AU';
						case 'Tomis13t', 'ZolZarolZ': curFlag = 'BR';
						case 'Estaguy': curFlag = 'CH';
						case 'Sulonam', 'Boyo', 'KraimDS', 'MeDicenKay': curFlag = 'CL';
						case 'Angelgamepad', 'Bosu': curFlag = 'CO';
						case 'Kawaii', 'Raimbowcore12': curFlag = 'ES';
						case 'DroCaleb', 'TheG': curFlag = 'GB';
						case 'FatalVoid': curFlag = 'HU';
						case 'TimoX': curFlag = 'MD';
						case 'HyperDream': curFlag = 'MN';
						case 'Inski', 'Sanko': curFlag = 'MX';
						case 'RedyShines': curFlag = 'NZ';
						case 'B_Fezz', 'Kophy232', 'MarioMaster', 'ReX', 'Sebas1554', 'Surf': curFlag = 'PE';
						case 'Kamilion1444455': curFlag = 'PL';
						case 'Merphi', 'DanlyDaMusicant', 'GhostLab', 'MajinCrast', 'Majora', 'Sanya', 'SonicPlay': curFlag = 'RU';
						case 'Flexmaster': curFlag = 'SA';
						case 'Boring345': curFlag = 'TR';
						case 'Mastex', 'MaysLastPlay', 'Shyllis', 'TheGreatBeyond': curFlag = 'UA';
						case 'Artisus', 'Chron Delta', 'Colin', 'Doge', 'Enginerr', 'Exe', 'GioIsDead', 'JDogg', 'L-4GXE', 'LeefLett', 'Leafy-Ivy_Ray', 'LonelyKris',  'Mr. Half', 'Pringle', 'Scarcen', 'STG55544', 'Wolfie_1985': curFlag = 'US';
						case 'DStickman', 'TRENO': curFlag = 'VE';
						case 'Bawnic': curFlag = 'VN';
						default: curFlag = 'placeholder';
					}
					
					var flag:FlxSprite = new FlxSprite(791 + CreditsX, 467);
					flag.ID = i;
					flag.loadGraphic(Paths.image('credits/credits-stuff/flags/' + curFlag));
					flag.antialiasing = ClientPrefs.globalAntialiasing;
					flag.scrollFactor.set();
					CreditFlag.add(flag);
				
					var frame:FlxSprite = new FlxSprite(420 + CreditsX, 448);
					frame.ID = i;
					frame.loadGraphic(Paths.image('credits/credits-stuff/frame'));
					frame.antialiasing = ClientPrefs.globalAntialiasing;
					frame.scrollFactor.set();
					CreditFrame.add(frame);
					
					var nickname:FlxText = new FlxText(CreditsX + 200, 505, FlxG.width, NicknameCredits[i], 18);
					nickname.ID = i;
					nickname.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 18, FlxColor.fromRGB(255, 255, 255));
					nickname.antialiasing = ClientPrefs.globalAntialiasing;
					CreditsTextOne.add(nickname);
					
					var work:FlxText = new FlxText(CreditsX + 200, 590, FlxG.width, NicknameCreditsWorker[i], 18);
					work.ID = i;
					work.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 18, FlxColor.fromRGB(255, 255, 255));
					work.antialiasing = ClientPrefs.globalAntialiasing;
					CreditsTextTwo.add(work);
					
					CreditsX += 400;
				}
			case 'OLD':
				for (i in 0...NicknameCreditsOld.length)
				{			
					var icon:FlxSprite = new FlxSprite(437 + CreditsX, 465);
					icon.ID = i;
					#if desktop
					if (FileSystem.exists('assets/images/credits/credits-stuff/icons/' + NicknameCreditsOld[i] + '.png'))
					#else
					if (Assets.exists('assets/images/credits/credits-stuff/icons/' + NicknameCreditsOld[i] + '.png'))
					#end
						icon.loadGraphic(Paths.image('credits/credits-stuff/icons/' + NicknameCreditsOld[i]));
					else
						icon.loadGraphic(Paths.image('credits/credits-stuff/icons/placeholder'));
					icon.antialiasing = ClientPrefs.globalAntialiasing;
					icon.scrollFactor.set();
					CreditIcon.add(icon);
					
					switch(NicknameCreditsOld[i]) {
						case 'Goldenfoxy2604': curFlag = 'BR';
						case 'Cartoon Cat': curFlag = 'ID';
						case 'TwinGeoduk': curFlag = 'MX';
						case 'Futagami': curFlag = 'RU';
						case 'RS Productions': curFlag = 'TR';
						case 'Red': curFlag = 'US';
						default: curFlag = 'placeholder';
					}
					
					var flag:FlxSprite = new FlxSprite(791 + CreditsX, 467);
					flag.ID = i;
					flag.loadGraphic(Paths.image('credits/credits-stuff/flags/' + curFlag));
					flag.antialiasing = ClientPrefs.globalAntialiasing;
					flag.scrollFactor.set();
					CreditFlag.add(flag);
				
					var frame:FlxSprite = new FlxSprite(420 + CreditsX, 448);
					frame.ID = i;
					frame.loadGraphic(Paths.image('credits/credits-stuff/frame'));
					frame.antialiasing = ClientPrefs.globalAntialiasing;
					frame.scrollFactor.set();
					CreditFrame.add(frame);
					
					var nickname:FlxText = new FlxText(CreditsX + 200, 505, FlxG.width, NicknameCreditsOld[i], 18);
					nickname.ID = i;
					nickname.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 18, FlxColor.fromRGB(255, 255, 255));
					nickname.antialiasing = ClientPrefs.globalAntialiasing;
					CreditsTextOne.add(nickname);
					
					var work:FlxText = new FlxText(CreditsX + 200, 590, FlxG.width, NicknameCreditsWorkerOld[i], 18);
					work.ID = i;
					work.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 18, FlxColor.fromRGB(255, 255, 255));
					work.antialiasing = ClientPrefs.globalAntialiasing;
					CreditsTextTwo.add(work);
					
					CreditsX += 400;
				}
			case 'ST':
				for (i in 0...NicknameCreditsST.length)
				{			
					var icon:FlxSprite = new FlxSprite(437 + CreditsX, 465);
					icon.ID = i;
					#if desktop
					if (FileSystem.exists('assets/images/credits/credits-stuff/icons/' + NicknameCreditsST[i] + '.png'))
					#else
					if (Assets.exists('assets/images/credits/credits-stuff/icons/' + NicknameCreditsST[i] + '.png'))
					#end
						icon.loadGraphic(Paths.image('credits/credits-stuff/icons/' + NicknameCreditsST[i]));
					else
						icon.loadGraphic(Paths.image('credits/credits-stuff/icons/placeholder'));
					icon.antialiasing = ClientPrefs.globalAntialiasing;
					icon.scrollFactor.set();
					CreditIcon.add(icon);
					
					switch(NicknameCreditsST[i]) {
						case 'Galaxy Drawing', 'Mad', 'Oratual', 'TheForgotten', 'Travis': curFlag = 'AR';
						case 'Blue Demon', 'O Mundo', 'Torresmmo': curFlag = 'BR';
						case 'PootisTF2': curFlag = 'CA';
						case 'Danix', 'GAto': curFlag = 'CL';
						case 'NayreFunkin', 'Saldavid': curFlag = 'CO';
						case 'SSG950': curFlag = 'DZ';
						case 'Nefastius': curFlag = 'EC';
						case 'Dolor de Duodeno': curFlag = 'ES';
						case 'Astronomical', 'EliteHack': curFlag = 'GB';
						case 'Dark Blaze', 'NickLivePro': curFlag = 'IT';
						case 'Sami': curFlag = 'LB';
						case 'Dupanims', 'RexNeo2190', 'Ruisna', 'SusanMiada', 'Wewer': curFlag = 'MX';
						case 'RoFos', 'TOKCU4': curFlag = 'RU';
						case 'Ashburn', 'CinderSamurai', 'Dumboy Mikey', 'GasGrass', 'Gh0st542', 'OniiAnubis', 'Ryzzon', 'Socoolidied': curFlag = 'US';
						default: curFlag = 'placeholder';
					}
					
					var flag:FlxSprite = new FlxSprite(791 + CreditsX, 467);
					flag.ID = i;
					flag.loadGraphic(Paths.image('credits/credits-stuff/flags/' + curFlag));
					flag.antialiasing = ClientPrefs.globalAntialiasing;
					flag.scrollFactor.set();
					CreditFlag.add(flag);
				
					var frame:FlxSprite = new FlxSprite(420 + CreditsX, 448);
					frame.ID = i;
					frame.loadGraphic(Paths.image('credits/credits-stuff/frame'));
					frame.antialiasing = ClientPrefs.globalAntialiasing;
					frame.scrollFactor.set();
					CreditFrame.add(frame);
					
					var nickname:FlxText = new FlxText(CreditsX + 200, 505, FlxG.width, NicknameCreditsST[i], 18);
					nickname.ID = i;
					nickname.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 18, FlxColor.fromRGB(255, 255, 255));
					nickname.antialiasing = ClientPrefs.globalAntialiasing;
					CreditsTextOne.add(nickname);
					
					var work:FlxText = new FlxText(CreditsX + 200, 600, 390, NicknameCreditsWorkerST[i], 13);
					work.ID = i;
					work.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 13, FlxColor.fromRGB(255, 255, 255));
					work.antialiasing = ClientPrefs.globalAntialiasing;
					CreditsTextTwo.add(work);
					
					CreditsX += 400;
				}
		}
		CreditIcon.alpha = 0;
		CreditFlag.alpha = 0;
		CreditFrame.alpha = 0;
		CreditsTextOne.alpha = 0;
		CreditsTextTwo.alpha = 0;
		
		CreditsLeft = new FlxSprite(355, 524).loadGraphic(Paths.image('credits/credits-stuff/left'));
		CreditsLeft.antialiasing = ClientPrefs.globalAntialiasing;
		CreditsLeft.scrollFactor.set();
		CreditsLeft.alpha = 0;
		add(CreditsLeft);
		
		CreditsRight = new FlxSprite(889, 524).loadGraphic(Paths.image('credits/credits-stuff/right'));
		CreditsRight.antialiasing = ClientPrefs.globalAntialiasing;
		CreditsRight.scrollFactor.set();
		CreditsRight.alpha = 0;
		add(CreditsRight);
		
		ChangeTeamUp = new FlxSprite(962, 384).loadGraphic(Paths.image('credits/credits-stuff/up'));
		ChangeTeamUp.antialiasing = ClientPrefs.globalAntialiasing;
		ChangeTeamUp.scrollFactor.set();
		ChangeTeamUp.alpha = 0;
		add(ChangeTeamUp);
		
		ChangeTeamDown = new FlxSprite(962, 384).loadGraphic(Paths.image('credits/credits-stuff/down'));
		ChangeTeamDown.antialiasing = ClientPrefs.globalAntialiasing;
		ChangeTeamDown.scrollFactor.set();
		ChangeTeamDown.alpha = 0;
		add(ChangeTeamDown);
		
		ChangeTeamMidUP = new FlxSprite(962, 373).loadGraphic(Paths.image('credits/credits-stuff/up'));
		ChangeTeamMidUP.antialiasing = ClientPrefs.globalAntialiasing;
		ChangeTeamMidUP.scrollFactor.set();
		ChangeTeamMidUP.alpha = 0;
		add(ChangeTeamMidUP);
		
		ChangeTeamMidDOWN = new FlxSprite(962, 395).loadGraphic(Paths.image('credits/credits-stuff/down'));
		ChangeTeamMidDOWN.antialiasing = ClientPrefs.globalAntialiasing;
		ChangeTeamMidDOWN.scrollFactor.set();
		ChangeTeamMidDOWN.alpha = 0;
		add(ChangeTeamMidDOWN);
		
		CurrentTeam = new FlxSprite(997, 383).loadGraphic(Paths.image('credits/credits-stuff/current-team'));
		CurrentTeam.antialiasing = ClientPrefs.globalAntialiasing;
		CurrentTeam.scrollFactor.set();
		CurrentTeam.alpha = 0;
		add(CurrentTeam);

		OldTeam = new FlxSprite(1089, 383).loadGraphic(Paths.image('credits/credits-stuff/old-team'));
		OldTeam.antialiasing = ClientPrefs.globalAntialiasing;
		OldTeam.scrollFactor.set();
		OldTeam.alpha = 0;
		add(OldTeam);
		if (TranslationLanguages.Files.contains("credits/credits-stuff/old-team") && ClientPrefs.Language != 'English')
			OldTeam.x = 997;
		
		SpecialThanks = new FlxSprite(1034, 383).loadGraphic(Paths.image('credits/credits-stuff/special-thanks'));
		SpecialThanks.antialiasing = ClientPrefs.globalAntialiasing;
		SpecialThanks.scrollFactor.set();
		SpecialThanks.alpha = 0;
		add(SpecialThanks);
		if (TranslationLanguages.Files.contains("credits/credits-stuff/special-thanks") && ClientPrefs.Language != 'English')
			SpecialThanks.x = 997;
		
		mouseHitbox = new FlxSprite(420,448).makeGraphic(440,204, 0x00000000);
		add(mouseHitbox);
		
		if (!RNIsHere) {
			new FlxTimer().start(1.5, function(hello:FlxTimer)
			{
				FlxTween.tween(bgDay, {alpha: 0}, 1.0, {ease: FlxEase.expoInOut});
				FlxTween.tween(starsDay, {alpha: 0}, 1.0, {ease: FlxEase.expoInOut});
				FlxTween.tween(UWUDay, {alpha: 0}, 1.0, {ease: FlxEase.expoInOut});
				
				FlxTween.tween(bgNight, {alpha: 1}, 1.0, {ease: FlxEase.expoInOut});
				FlxTween.tween(starsNight, {alpha: 1}, 1.0, {ease: FlxEase.expoInOut});
				FlxTween.tween(UWUNight, {alpha: 1}, 0.8, {ease: FlxEase.expoInOut});
				
				new FlxTimer().start(1.5, function(hello:FlxTimer)
				{
					Credits = new FlxTypedSpriteGroup<FlxSprite>();
					Credits.add(CreditIcon);
					Credits.add(CreditFlag);
					Credits.add(CreditFrame);
					IsNight = true;
					RNIsHere = true;
					canPress = true;
					FlxTween.tween(Panel, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditIcon, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditFlag, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditFrame, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditsTextOne, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditsTextTwo, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditsLeft, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CreditsRight, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(ChangeTeamDown, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					FlxTween.tween(CurrentTeam, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
					
					Select(curSelected, '', false);
				});
			});
		} else {
			bgDay.alpha = 0;
			starsDay.alpha = 0;
			UWUDay.alpha = 0;
			bgNight.alpha = 1;
			starsNight.alpha = 1;
			UWUNight.alpha = 1;
			Credits = new FlxTypedSpriteGroup<FlxSprite>();
			Credits.add(CreditIcon);
			Credits.add(CreditFlag);
			Credits.add(CreditFrame);
			IsNight = true;
			canPress = true;
			if (curPage == 'NEW') ChangeTeamDown.alpha = 1;
			if (curPage == 'OLD') ChangeTeamMidUP.alpha = 1;
			if (curPage == 'OLD') ChangeTeamMidDOWN.alpha = 1;
			if (curPage == 'ST') ChangeTeamUp.alpha = 1;
			if (curPage == 'NEW') CurrentTeam.alpha = 1;
			if (curPage == 'OLD') OldTeam.alpha = 1;
			if (curPage == 'ST') SpecialThanks.alpha = 1;
			FlxTween.tween(Panel, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditIcon, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditFlag, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditFrame, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditsTextOne, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditsTextTwo, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditsLeft, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
			FlxTween.tween(CreditsRight, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});

			Select(curSelected, '', false);
		}
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		if ((controls.BACK || FlxG.mouse.justPressedRight #if mobile || FlxG.android.justReleased.BACK #end) && canPress)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
			FlxG.switchState(new MainMenuState());
			canPress = false;
			RNIsHere = false;
			curPage = 'NEW';
		}
		
		if(FlxG.keys.pressed.SHIFT) {
			shiftMult = 3;
		} else {
			shiftMult = 1;
		}
		
		if (IsNight && canPress) {
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;
			var leftP = controls.UI_LEFT_P;
			var rightP = controls.UI_RIGHT_P;
			
			if (leftP)
			{
				Select(-shiftMult, 'left', true);
				holdTime = 0;
			}
			if (rightP)
			{
				Select(shiftMult, 'right', true);
				holdTime = 0;
			}
			if (controls.UI_LEFT || controls.UI_RIGHT)
			{
				var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

				if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
				{
					if (controls.UI_LEFT) Select((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult), 'left', true);
					if (controls.UI_RIGHT) Select((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult), 'right', true);
				}
			}
			if (FlxG.mouse.wheel != 0)
			{
				if (FlxG.mouse.wheel > 0) Select(-shiftMult * FlxG.mouse.wheel,'left', true);
				if (FlxG.mouse.wheel < 0) Select(-shiftMult * FlxG.mouse.wheel,'right', true);
			}
			if (FlxG.mouse.overlaps(CreditsLeft) && FlxG.mouse.justPressed) Select(-1, 'left', true);
			if (FlxG.mouse.overlaps(CreditsRight) && FlxG.mouse.justPressed) Select(1, 'right', true);
			if (upP || (FlxG.mouse.overlaps(ChangeTeamUp) && FlxG.mouse.justPressed) || (FlxG.mouse.overlaps(ChangeTeamMidUP) && FlxG.mouse.justPressed)) {
				switch(curPage){
					case 'OLD':
						FlxTween.tween(ChangeTeamDown, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidUP, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidDOWN, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamUp, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CurrentTeam, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(OldTeam, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(SpecialThanks, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						FlxTween.tween(Panel, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(Credits, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextOne, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextTwo, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsLeft, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsRight, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						new FlxTimer().start(0.5, function(hello:FlxTimer)
						{
							curPage = 'NEW';
							FlxTransitionableState.skipNextTransIn = true; 
							FlxTransitionableState.skipNextTransOut = true; 
							MusicBeatState.switchState(new CreditsState());
						});
						canPress = false;
						IsNight = false;
					case 'ST':
						FlxTween.tween(ChangeTeamDown, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidUP, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidDOWN, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamUp, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CurrentTeam, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(OldTeam, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(SpecialThanks, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						FlxTween.tween(Panel, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(Credits, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextOne, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextTwo, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsLeft, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsRight, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						new FlxTimer().start(0.5, function(hello:FlxTimer)
						{
							curPage = 'OLD';
							FlxTransitionableState.skipNextTransIn = true; 
							FlxTransitionableState.skipNextTransOut = true; 
							MusicBeatState.switchState(new CreditsState());
						});
						canPress = false;
						IsNight = false;
				}
			}
			if (downP || (FlxG.mouse.overlaps(ChangeTeamDown) && FlxG.mouse.justPressed) || (FlxG.mouse.overlaps(ChangeTeamMidDOWN) && FlxG.mouse.justPressed)) {
				switch(curPage){
					case 'OLD':
						FlxTween.tween(ChangeTeamDown, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidUP, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidDOWN, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamUp, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CurrentTeam, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(OldTeam, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(SpecialThanks, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						
						FlxTween.tween(Panel, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(Credits, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextOne, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextTwo, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsLeft, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsRight, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						new FlxTimer().start(0.5, function(hello:FlxTimer)
						{
							curPage = 'ST';
							FlxTransitionableState.skipNextTransIn = true; 
							FlxTransitionableState.skipNextTransOut = true; 
							MusicBeatState.switchState(new CreditsState());
						});
						canPress = false;
						IsNight = false;
					case 'NEW':
						FlxTween.tween(ChangeTeamDown, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidUP, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamMidDOWN, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(ChangeTeamUp, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CurrentTeam, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(OldTeam, {alpha: 1}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(SpecialThanks, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						FlxTween.tween(Panel, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(Credits, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextOne, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsTextTwo, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsLeft, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						FlxTween.tween(CreditsRight, {alpha: 0}, 0.2, {ease: FlxEase.expoInOut});
						
						new FlxTimer().start(0.5, function(hello:FlxTimer)
						{
							curPage = 'OLD';
							FlxTransitionableState.skipNextTransIn = true; 
							FlxTransitionableState.skipNextTransOut = true; 
							MusicBeatState.switchState(new CreditsState());
						});
						canPress = false;
						IsNight = false;
				}
			}
			
			switch(curPage) {
				case 'NEW':
					if ((controls.ACCEPT || (FlxG.mouse.overlaps(mouseHitbox) && (FlxG.mouse.justPressed || FlxG.mouse.justPressedMiddle))) && canPress) {
						switch (NicknameCredits[curSelected]) {
							case 'Merphi': CoolUtil.browserLoad('https://www.youtube.com/c/MerphiPlay');
							case 'Sulonam': CoolUtil.browserLoad('https://www.youtube.com/@MMMandComino');
							case 'Angelgamepad': CoolUtil.browserLoad('https://www.youtube.com/@Angelgamepad0456');
							case 'Artisus': CoolUtil.browserLoad('https://www.youtube.com/@TrustedArtist');
							case 'Bawnic': CoolUtil.browserLoad('https://www.youtube.com/channel/UCDmeDB6bvF66KDIYwH8vs_Q');
							case 'Benimus': CoolUtil.browserLoad('https://www.youtube.com/channel/UCLq06OQvxyRH7HvPvHsN0PQ');
							case 'BeyTail': CoolUtil.browserLoad('https://www.youtube.com/@BeyTail/videos');
							case 'B_Fezz': CoolUtil.browserLoad('https://www.youtube.com/channel/UCA_psctOiIibCKUgrD6UvWg');
							case 'Boring345': CoolUtil.browserLoad('https://www.youtube.com/@borin345');
							case 'Capitan Jorge': CoolUtil.browserLoad('https://www.youtube.com/@CapitanJorge24/videos');
							case 'Chron Delta': CoolUtil.browserLoad('https://www.youtube.com/channel/UCJKp_mponFzJo6m8ZdiauUQ');
							case 'Colin': CoolUtil.browserLoad('https://www.youtube.com/@Phun-Bun');
							case 'DanlyDaMusicant': CoolUtil.browserLoad('https://youtube.com/@DanlyDaMusician');
							case 'Doge': CoolUtil.browserLoad('https://soundcloud.com/iamdadogeofdafuture');
							case 'DroCaleb': CoolUtil.browserLoad('https://www.youtube.com/channel/UCcHEPIK5F4I6EWbHVfhDG9g');
							case 'DStickman': CoolUtil.browserLoad('https://www.youtube.com/@DStickmanP');
							case 'EmisadorCWO': CoolUtil.browserLoad('https://www.youtube.com/channel/UCUH02yIFrtKECcTuPwGAAag');
							case 'Enginerr': CoolUtil.browserLoad('https://www.youtube.com/watch?v=xvFZjo5PgG0');
							case 'Estaguy': CoolUtil.browserLoad('https://youtube.com/@Estaguy24');
							case 'Exe': CoolUtil.browserLoad('https://www.youtube.com/channel/UCNVYZhuZyzQyPmRQAKvQqXQ');
							case 'FatalVoid': CoolUtil.browserLoad('https://www.youtube.com/@fatalvoid');
							case 'Flexmaster': CoolUtil.browserLoad('https://www.youtube.com/channel/UCJlN9ZaQp4mtIJ3yRvT_Oxg');
							case 'GhostLab': CoolUtil.browserLoad('https://www.youtube.com/@GhostLab1321');
							case 'HyperDream': CoolUtil.browserLoad('https://www.youtube.com/@-Illusional-');
							case 'Inski': CoolUtil.browserLoad('https://www.youtube.com/@inski-fansonic99/featured');
							case 'JDogg': CoolUtil.browserLoad('https://www.youtube.com/channel/UCqf4rPf84V9UpUuobY__qXQ');
							case 'Kawaii': CoolUtil.browserLoad('https://youtube.com/@TheSpookyKawasFLP');
							case 'Kea.Bat': CoolUtil.browserLoad('https://soundcloud.com/weedlem0use-flac');
							case 'Kophy232': CoolUtil.browserLoad('https://www.youtube.com/channel/UCZ1H8wMsJ0jVH57bFj6dRsA');
							case 'KraimDS': CoolUtil.browserLoad('https://www.youtube.com/@KraimYT2lol/videos');
							case 'L-4GXE': CoolUtil.browserLoad('https://www.youtube.com/@L-4GXE/videos');
							case 'Leafy-Ivy_Ray': CoolUtil.browserLoad('https://www.youtube.com/@TheReal-Leafy');
							case 'LeefLett': CoolUtil.browserLoad('https://www.youtube.com/@LeefLett');
							case 'LonelyKris': CoolUtil.browserLoad('https://www.youtube.com/@Lonely-Kris');
							case 'Luc': CoolUtil.browserLoad('https://www.youtube.com/@Luc009');
							case 'MajinCrast': CoolUtil.browserLoad('https://www.youtube.com/channel/UCZEIlnS1W2WOvK1A0A2p4wQ');
							case 'Majora': CoolUtil.browserLoad('https://www.youtube.com/channel/UCZEIlnS1W2WOvK1A0A2p4wQ');
							case 'MarioMaster': CoolUtil.browserLoad('https://www.youtube.com/@MarioMaster39');
							case 'MaysLastPlay': CoolUtil.browserLoad('https://www.youtube.com/@MaysLastPlay');
							case 'MeDicenKay': CoolUtil.browserLoad('https://www.youtube.com/@iamthekay2204');
							case 'Mr. Half': CoolUtil.browserLoad('https://www.youtube.com/channel/UCQHyjL9maTqV0bABww9bzvw');
							case 'OtherWorldly': CoolUtil.browserLoad('https://www.youtube.com/@otherworldly488/videos');
							case 'Raimbowcore12': CoolUtil.browserLoad('https://www.youtube.com/channel/UCkfi2umVQlsj6SUs1sTxPHg');
							case 'RedyShines': CoolUtil.browserLoad('https://www.youtube.com/channel/UCukCkDsY7d_ReJEluJSCY_w');
							case 'ReX': CoolUtil.browserLoad('https://www.youtube.com/channel/UC6yF-thmmGN2YuZCXjSUqUw');
							case 'Sanko': CoolUtil.browserLoad('https://www.youtube.com/@sank8985');
							case 'Shyllis': CoolUtil.browserLoad('https://www.youtube.com/channel/UCFcRalyx5xObwAANx-fJ2fQ');
							case 'SonicDDY': CoolUtil.browserLoad('https://youtube.com/@spiney_sans6955');
							case 'SonicPlay': CoolUtil.browserLoad('https://www.youtube.com/channel/UCvHAqSEdZm6-dkGHixEQUNg');
							case 'STG55544': CoolUtil.browserLoad('https://www.youtube.com/channel/UC34Wt7mia3cpExcaLOoDSvA');
							case 'TheG': CoolUtil.browserLoad('https://www.youtube.com/channel/UC2fkCCdBzllS0UEWMYP0ejQ');
							case 'TheGreatBeyond': CoolUtil.browserLoad('https://www.youtube.com/@TheGreatBeyond-sj6ic');
							case 'TimoX': CoolUtil.browserLoad('https://www.youtube.com/channel/UCxoPc-Tciw2Jg9VGzolqgmQ');
							case 'Tomis13t': CoolUtil.browserLoad('https://www.youtube.com/channel/UC7SiLKAgguwWPcZb7zU9K8g');
							case 'TRENO': CoolUtil.browserLoad('https://www.youtube.com/channel/UCONuNNcnJn7y12TjZvsbILg');
							case 'Wolfie_1985': CoolUtil.browserLoad('https://www.youtube.com/channel/UC8mx-rDEJcj8PzT49bifHzw');
						}
					}
				case 'OLD':
					if ((controls.ACCEPT || (FlxG.mouse.overlaps(mouseHitbox) && (FlxG.mouse.justPressed || FlxG.mouse.justPressedMiddle))) && canPress) {
						switch (NicknameCreditsOld[curSelected]) {
							case 'BaTIF104': CoolUtil.browserLoad('https://twitter.com/BaTIF104');
							case 'Cartoon Cat': CoolUtil.browserLoad('https://www.youtube.com/@CARTOONCAT123/videos');
							case 'Goldenfoxy2604': CoolUtil.browserLoad('https://www.youtube.com/@goldenfoxy2604/videos');
							case 'ItsFellow': CoolUtil.browserLoad('https://www.youtube.com/@itsfellow17/videos');
							case 'LilMip': CoolUtil.browserLoad('https://www.youtube.com/@OneBoredCatbug/videos');
							case 'NicolasMyt': CoolUtil.browserLoad('https://gamebanana.com/members/2063514');
							case 'Red': CoolUtil.browserLoad('https://www.youtube.com/@r3d_real');
							case 'RS Productions': CoolUtil.browserLoad('https://www.youtube.com/@RSproductions3425/videos');
							case 'Sirox': CoolUtil.browserLoad('https://www.youtube.com/@sirox3851/videos');
							case 'TwinGeoduk': CoolUtil.browserLoad('https://www.youtube.com/@TwinGeoduk/videos');
							case 'Xpastelxbloodx': CoolUtil.browserLoad('https://www.youtube.com/@xpastelxbloodx/videos');
							case 'ZeroXSP': CoolUtil.browserLoad('https://www.youtube.com/@ZeroXSP/videos');
						}
					}
				case 'ST':
			}
		}
		
		if (IsNight) {
			Credits.forEach(function(spr:FlxSprite)
			{
				switch (curSelected) {
					case 0: Credits.x = FlxMath.lerp(Credits.x, 0, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 1: Credits.x = FlxMath.lerp(Credits.x, -400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 2: Credits.x = FlxMath.lerp(Credits.x, -800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 3: Credits.x = FlxMath.lerp(Credits.x, -1200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 4: Credits.x = FlxMath.lerp(Credits.x, -1600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 5: Credits.x = FlxMath.lerp(Credits.x, -2000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 6: Credits.x = FlxMath.lerp(Credits.x, -2400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 7: Credits.x = FlxMath.lerp(Credits.x, -2800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 8: Credits.x = FlxMath.lerp(Credits.x, -3200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 9: Credits.x = FlxMath.lerp(Credits.x, -3600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 10: Credits.x = FlxMath.lerp(Credits.x, -4000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 11: Credits.x = FlxMath.lerp(Credits.x, -4400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 12: Credits.x = FlxMath.lerp(Credits.x, -4800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 13: Credits.x = FlxMath.lerp(Credits.x, -5200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 14: Credits.x = FlxMath.lerp(Credits.x, -5600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 15: Credits.x = FlxMath.lerp(Credits.x, -6000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 16: Credits.x = FlxMath.lerp(Credits.x, -6400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 17: Credits.x = FlxMath.lerp(Credits.x, -6800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 18: Credits.x = FlxMath.lerp(Credits.x, -7200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 19: Credits.x = FlxMath.lerp(Credits.x, -7600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 20: Credits.x = FlxMath.lerp(Credits.x, -8000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 21: Credits.x = FlxMath.lerp(Credits.x, -8400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 22: Credits.x = FlxMath.lerp(Credits.x, -8800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 23: Credits.x = FlxMath.lerp(Credits.x, -9200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 24: Credits.x = FlxMath.lerp(Credits.x, -9600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 25: Credits.x = FlxMath.lerp(Credits.x, -10000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 26: Credits.x = FlxMath.lerp(Credits.x, -10400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 27: Credits.x = FlxMath.lerp(Credits.x, -10800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 28: Credits.x = FlxMath.lerp(Credits.x, -11200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 29: Credits.x = FlxMath.lerp(Credits.x, -11600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 30: Credits.x = FlxMath.lerp(Credits.x, -12000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 31: Credits.x = FlxMath.lerp(Credits.x, -12400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 32: Credits.x = FlxMath.lerp(Credits.x, -12800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 33: Credits.x = FlxMath.lerp(Credits.x, -13200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 34: Credits.x = FlxMath.lerp(Credits.x, -13600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 35: Credits.x = FlxMath.lerp(Credits.x, -14000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 36: Credits.x = FlxMath.lerp(Credits.x, -14400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 37: Credits.x = FlxMath.lerp(Credits.x, -14800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 38: Credits.x = FlxMath.lerp(Credits.x, -15200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 39: Credits.x = FlxMath.lerp(Credits.x, -15600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 40: Credits.x = FlxMath.lerp(Credits.x, -16000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 41: Credits.x = FlxMath.lerp(Credits.x, -16400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 42: Credits.x = FlxMath.lerp(Credits.x, -16800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 43: Credits.x = FlxMath.lerp(Credits.x, -17200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 44: Credits.x = FlxMath.lerp(Credits.x, -17600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 45: Credits.x = FlxMath.lerp(Credits.x, -18000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 46: Credits.x = FlxMath.lerp(Credits.x, -18400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 47: Credits.x = FlxMath.lerp(Credits.x, -18800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 48: Credits.x = FlxMath.lerp(Credits.x, -19200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 49: Credits.x = FlxMath.lerp(Credits.x, -19600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 50: Credits.x = FlxMath.lerp(Credits.x, -20000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 51: Credits.x = FlxMath.lerp(Credits.x, -20400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 52: Credits.x = FlxMath.lerp(Credits.x, -20800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 53: Credits.x = FlxMath.lerp(Credits.x, -21200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 54: Credits.x = FlxMath.lerp(Credits.x, -21600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 55: Credits.x = FlxMath.lerp(Credits.x, -22000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 56: Credits.x = FlxMath.lerp(Credits.x, -22400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 57: Credits.x = FlxMath.lerp(Credits.x, -22800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 58: Credits.x = FlxMath.lerp(Credits.x, -23200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 59: Credits.x = FlxMath.lerp(Credits.x, -23600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 60: Credits.x = FlxMath.lerp(Credits.x, -24000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 61: Credits.x = FlxMath.lerp(Credits.x, -24400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 62: Credits.x = FlxMath.lerp(Credits.x, -24800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 63: Credits.x = FlxMath.lerp(Credits.x, -25200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 64: Credits.x = FlxMath.lerp(Credits.x, -25600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 65: Credits.x = FlxMath.lerp(Credits.x, -26000, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 66: Credits.x = FlxMath.lerp(Credits.x, -26400, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 67: Credits.x = FlxMath.lerp(Credits.x, -26800, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 68: Credits.x = FlxMath.lerp(Credits.x, -27200, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 69: Credits.x = FlxMath.lerp(Credits.x, -27600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					case 70: Credits.x = FlxMath.lerp(Credits.x, -28000, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			});
			CreditIcon.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curSelected) {
					spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 465, CoolUtil.boundTo(elapsed * 8, 0, 1));
				} else {
					spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 555, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			});
			CreditFlag.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curSelected) {
					spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 467, CoolUtil.boundTo(elapsed * 8, 0, 1));
				} else {
					spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 557, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			});
			CreditFrame.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curSelected) {
					spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 448, CoolUtil.boundTo(elapsed * 8, 0, 1));
				} else {
					spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 538, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			});
			CreditsTextOne.x = Credits.x + 343;
			CreditsTextTwo.x = Credits.x + 245;
			CreditsTextOne.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curSelected) {
					spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 505, CoolUtil.boundTo(elapsed * 8, 0, 1));
				} else {
					spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.y = FlxMath.lerp(spr.y, 510, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			});
			CreditsTextTwo.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curSelected) {
					spr.alpha = FlxMath.lerp(spr.alpha, 1, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 1, CoolUtil.boundTo(elapsed * 8, 0, 1));
					if (curPage == 'ST') spr.y = FlxMath.lerp(spr.y, 600, CoolUtil.boundTo(elapsed * 8, 0, 1));
					else spr.y = FlxMath.lerp(spr.y, 590, CoolUtil.boundTo(elapsed * 8, 0, 1));
				} else {
					spr.alpha = FlxMath.lerp(spr.alpha, 0, CoolUtil.boundTo(elapsed * 24, 0, 1));
					spr.scale.x = FlxMath.lerp(spr.scale.x, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					spr.scale.y = FlxMath.lerp(spr.scale.y, 0.7, CoolUtil.boundTo(elapsed * 8, 0, 1));
					if (curPage == 'ST') spr.y = FlxMath.lerp(spr.y, 605, CoolUtil.boundTo(elapsed * 8, 0, 1));
					else spr.y = FlxMath.lerp(spr.y, 595, CoolUtil.boundTo(elapsed * 8, 0, 1));
				}
			});
		}
	}
	
	function Select(sel:Int = 0, woo:String = '', ?kys:Bool = false) {
		if (kys) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected += sel;
		switch(curPage) {
			case 'NEW':
				if (curSelected >= NicknameCredits.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = NicknameCredits.length - 1;
			case 'OLD':
				if (curSelected >= NicknameCreditsOld.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = NicknameCreditsOld.length - 1;
			case 'ST':
				if (curSelected >= NicknameCreditsST.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = NicknameCreditsST.length - 1;
		}
		
		var CreditsWooLeft:FlxSprite;
		var CreditsWooRight:FlxSprite;
		switch(woo) {
			case 'left':				
				CreditsWooLeft = new FlxSprite(355, 524).loadGraphic(Paths.image('credits/credits-stuff/left'));
				CreditsWooLeft.antialiasing = ClientPrefs.globalAntialiasing;
				CreditsWooLeft.scrollFactor.set();
				add(CreditsWooLeft);
				FlxTween.tween(CreditsWooLeft, {x: 105}, 0.3, {ease: FlxEase.quadIn});
				FlxTween.tween(CreditsWooLeft, {alpha: 0}, 0.3, {ease: FlxEase.quadIn});
				new FlxTimer().start(0.31, function(tmr:FlxTimer) {
					CreditsWooLeft.destroy();
				});
			case 'right':			
				CreditsWooRight = new FlxSprite(889, 524).loadGraphic(Paths.image('credits/credits-stuff/right'));
				CreditsWooRight.antialiasing = ClientPrefs.globalAntialiasing;
				CreditsWooRight.scrollFactor.set();
				add(CreditsWooRight);
				FlxTween.tween(CreditsWooRight, {x: 1139}, 0.3, {ease: FlxEase.quadIn});
				FlxTween.tween(CreditsWooRight, {alpha: 0}, 0.3, {ease: FlxEase.quadIn});
				new FlxTimer().start(0.31, function(tmr:FlxTimer) {
					CreditsWooRight.destroy();
				});
		}
	}
}