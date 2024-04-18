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

class CodeState extends MusicBeatState
{
	var EnterCode:FlxSprite;
	var Story:FlxSprite;
	var Code:FlxSprite;
	var blackScreen:FlxSprite;
	
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	
	var FirstNumberBool:Bool = false;
	var SecondNumberBool:Bool = false;
	var ThirdNumberBool:Bool = false;
	var FourthNumberBool:Bool = false;
	var CanEnter:Bool = true;
	var CodeEntered:Bool = false;
	var shit:Bool = false;
	
	var FirstNumber:FlxText;
	var SecondNumber:FlxText;
	var ThirdNumber:FlxText;
	var FourthNumber:FlxText;
	var Math:FlxText;
	var Solve:FlxText;
	
	var NumOfShit:Int = 0;
	var FirstNum:Int = 0;
	var SecondNum:Int = 0;
	var ThirdNum:Int = 0;
	var FourthNum:Int = 0;
	
	var FirstNumOfCode:Int = 0;
	var SecondNumOfCode:Int = 0;
	var ThirdNumOfCode:Int = 0;
	var FourthNumOfCode:Int = 0;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu (Code)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-code';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		FlxG.sound.playMusic(Paths.music('extras'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);
		
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
		
		EnterCode = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/code/EnterCode'));
		EnterCode.antialiasing = ClientPrefs.globalAntialiasing;
		EnterCode.scrollFactor.set();
		add(EnterCode);
		
		Story = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/code/Story'));
		Story.antialiasing = ClientPrefs.globalAntialiasing;
		Story.scrollFactor.set();
		
		Code = new FlxSprite(0, 10).loadGraphic(Paths.image('extra/code/Code'));
		Code.antialiasing = ClientPrefs.globalAntialiasing;
		Code.scrollFactor.set();
		
		FirstNumber = new FlxText(250, 110, FlxG.width, "0");
		FirstNumber.setFormat(Paths.font("orange-kid.ttf"), 300, 0xFFFFFFFF, LEFT);
		FirstNumber.scrollFactor.set();
		
		SecondNumber = new FlxText(465, 110, FlxG.width, "0");
		SecondNumber.setFormat(Paths.font("orange-kid.ttf"), 300, 0xFFFFFFFF, LEFT);
		SecondNumber.scrollFactor.set();
		
		ThirdNumber = new FlxText(690, 110, FlxG.width, "0");
		ThirdNumber.setFormat(Paths.font("orange-kid.ttf"), 300, 0xFFFFFFFF, LEFT);
		ThirdNumber.scrollFactor.set();
		
		FourthNumber = new FlxText(905, 110, FlxG.width, "0");
		FourthNumber.setFormat(Paths.font("orange-kid.ttf"), 300, 0xFFFFFFFF, LEFT);
		FourthNumber.scrollFactor.set();
		
		Solve = new FlxText(0, 550, FlxG.width, "Solve math example");
		Solve.setFormat(Paths.font("orange-kid.ttf"), 70, 0xFFFFFFFF, CENTER);
		Solve.scrollFactor.set();
		Solve.screenCenter(X);
		if (TranslationLanguages.Text.exists(Solve.text) && ClientPrefs.Language != 'English')
			Solve.text = TranslationLanguages.Text[Solve.text];
		
		Math = new FlxText(0, 650, FlxG.width, "");
		Math.setFormat(Paths.font("orange-kid.ttf"), 90, 0xFFFFFFFF, CENTER);
		Math.scrollFactor.set();
		Math.screenCenter(X);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.scrollFactor.set();
		blackScreen.scale.x = 2;
		blackScreen.scale.y = 2;
		blackScreen.screenCenter(X);
		FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {});

		randomMath();
		super.create();
	}
	
	function press(Num:Int) {
		CanEnter = false;
		if (!CodeEntered) {
			if (FirstNumberBool && NumOfShit == 0) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				FirstNum = Num;
				FirstNumber.text = Std.string(FirstNum);
				new FlxTimer().start(0.02, function(one:FlxTimer) {
					FirstNumberBool = false;
					SecondNumberBool = true;
					ThirdNumberBool = false;
					FourthNumberBool = false;
					new FlxTimer().start(0.02, function(one:FlxTimer) { NumOfShit = 1; });
				});
			}
			if (SecondNumberBool && NumOfShit == 1) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				SecondNum = Num;
				SecondNumber.text = Std.string(SecondNum);
				new FlxTimer().start(0.02, function(two:FlxTimer) {
					FirstNumberBool = false;
					SecondNumberBool = false;
					ThirdNumberBool = true;
					FourthNumberBool = false;
					new FlxTimer().start(0.02, function(one:FlxTimer) { NumOfShit = 2; });
				});
			}
			if (ThirdNumberBool && NumOfShit == 2) {
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				ThirdNum = Num;
				ThirdNumber.text = Std.string(ThirdNum);
				new FlxTimer().start(0.02, function(three:FlxTimer) {
					FirstNumberBool = false;
					SecondNumberBool = false;
					ThirdNumberBool = false;
					FourthNumberBool = true;
					new FlxTimer().start(0.02, function(one:FlxTimer) { NumOfShit = 3; });
				});
			}
			if (FourthNumberBool && NumOfShit == 3) {
				FourthNum = Num;
				FlxG.sound.play(Paths.sound('tick'), 0.4);
				FourthNumber.text = Std.string(FourthNum);
				new FlxTimer().start(0.02, function(four:FlxTimer) {
					FirstNumberBool = false;
					SecondNumberBool = false;
					ThirdNumberBool = false;
					FourthNumberBool = false;
					CodeEntered = true;
					new FlxTimer().start(0.02, function(one:FlxTimer) { NumOfShit = 4; });
				});
			}
		}
		new FlxTimer().start(0.03, function(tmr:FlxTimer) { Num = 0; });
		if (NumOfShit < 4) new FlxTimer().start(0.06, function(tmr:FlxTimer) { CanEnter = true; });
	}
	
	function wrongCode() {
		new FlxTimer().start(0.10, function(tmr:FlxTimer) {
			FirstNumber.color = 0xFFFF0010;
			SecondNumber.color = 0xFFFF0010;
			ThirdNumber.color = 0xFFFF0010;
			FourthNumber.color = 0xFFFF0010;
			new FlxTimer().start(0.10, function(tmr:FlxTimer) {
				FirstNumber.color = 0xFFFFFFFF;
				SecondNumber.color = 0xFFFFFFFF;
				ThirdNumber.color = 0xFFFFFFFF;
				FourthNumber.color = 0xFFFFFFFF;
				new FlxTimer().start(0.10, function(tmr:FlxTimer) {
					FirstNumber.color = 0xFFFF0010;
					SecondNumber.color = 0xFFFF0010;
					ThirdNumber.color = 0xFFFF0010;
					FourthNumber.color = 0xFFFF0010;
					new FlxTimer().start(0.10, function(tmr:FlxTimer) {
						FirstNumber.color = 0xFFFFFFFF;
						SecondNumber.color = 0xFFFFFFFF;
						ThirdNumber.color = 0xFFFFFFFF;
						FourthNumber.color = 0xFFFFFFFF;
					});
				});
			});
		});
		
		new FlxTimer().start(0.5, function(tmr:FlxTimer) {
			CanEnter = true;
			CodeEntered = false;
			shit = false;
		
			FirstNumberBool = true;
			SecondNumberBool = false;
			ThirdNumberBool = false;
			FourthNumberBool = false;
			
			NumOfShit = 0;
			FirstNum = 0;
			SecondNum = 0;
			ThirdNum = 0;
			FourthNum = 0;
			
			FirstNumber.text = '0';
			SecondNumber.text = '0';
			ThirdNumber.text = '0';
			FourthNumber.text = '0';
		});
	}
	
	function randomMath() {
		switch(FlxG.random.int(1, 10)) {
			case 1:
				Math.text = '2x(180/12x22+117/13x82)+9' + '=???';
				FirstNumOfCode = 2;
				SecondNumOfCode = 1;
				ThirdNumOfCode = 4;
				FourthNumOfCode = 5;	
			case 2:
				Math.text = '(99+227x11-10)/2' + '=???';
				FirstNumOfCode = 1;
				SecondNumOfCode = 2;
				ThirdNumOfCode = 9;
				FourthNumOfCode = 3;
			case 3:
				Math.text = '(6666x2+3333-114)-(1375x5+532-423)' + '=???';
				FirstNumOfCode = 9;
				SecondNumOfCode = 5;
				ThirdNumOfCode = 6;
				FourthNumOfCode = 7;
			case 4:
				Math.text = '543x0-500+1754/22x44+243' + '=???';
				FirstNumOfCode = 3;
				SecondNumOfCode = 2;
				ThirdNumOfCode = 5;
				FourthNumOfCode = 1;
			case 5:
				Math.text = '(620-63/3+11x111)x3+9' + '=???';
				FirstNumOfCode = 5;
				SecondNumOfCode = 4;
				ThirdNumOfCode = 6;
				FourthNumOfCode = 9;
			case 6:
				Math.text = '423+893+56+305x23-9' + '=???';
				FirstNumOfCode = 8;
				SecondNumOfCode = 3;
				ThirdNumOfCode = 7;
				FourthNumOfCode = 8;
			case 7:
				Math.text = '(373+53x96/4+91x4)+450' + '=???';
				FirstNumOfCode = 2;
				SecondNumOfCode = 4;
				ThirdNumOfCode = 5;
				FourthNumOfCode = 9;
			case 8:
				Math.text = '(273+432x654/8)-28121' + '=???';
				FirstNumOfCode = 7;
				SecondNumOfCode = 4;
				ThirdNumOfCode = 6;
				FourthNumOfCode = 8;
			case 9:
				Math.text = '(120x22/10+1702)+342x3' + '=???';
				FirstNumOfCode = 2;
				SecondNumOfCode = 9;
				ThirdNumOfCode = 9;
				FourthNumOfCode = 2;
			case 10:
				Math.text = '(5435-5320+1421x9)-6432' + '=???';
				FirstNumOfCode = 6;
				SecondNumOfCode = 4;
				ThirdNumOfCode = 7;
				FourthNumOfCode = 2;
		}
	}
	
	override function update(elapsed:Float)
	{
		if (ClientPrefs.storyProgressAlt != 4) {
			add(Story);
			add(blackScreen);
		}
		if (ClientPrefs.storyProgressAlt == 4) {
			FirstNumberBool = true;
			add(Code);
			add(FirstNumber);
			add(SecondNumber);
			add(ThirdNumber);
			add(FourthNumber);
			add(Math);
			add(Solve);
			add(blackScreen);
		}
	
		if (controls.BACK || FlxG.mouse.justPressedRight)
		{
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
			FlxG.sound.music.fadeOut(0.5, 0);
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new MainMenuState());
			});
		}
		
		if (FlxG.keys.justPressed.ONE && CanEnter) press(1);
		if (FlxG.keys.justPressed.TWO && CanEnter) press(2);
		if (FlxG.keys.justPressed.THREE && CanEnter) press(3);
		if (FlxG.keys.justPressed.FOUR && CanEnter) press(4);
		if (FlxG.keys.justPressed.FIVE && CanEnter) press(5);
		if (FlxG.keys.justPressed.SIX && CanEnter) press(6);
		if (FlxG.keys.justPressed.SEVEN && CanEnter) press(7);
		if (FlxG.keys.justPressed.EIGHT && CanEnter) press(8);
		if (FlxG.keys.justPressed.NINE && CanEnter) press(9);
		
		if (CodeEntered) {
			if (FirstNum == FirstNumOfCode) {
				if (SecondNum == SecondNumOfCode) {
					if (ThirdNum == ThirdNumOfCode) {
						if (FourthNum == FourthNumOfCode) {
							if (!shit) {
								new FlxTimer().start(0.10, function(tmr:FlxTimer) {
									FirstNumber.color = 0xFF00FF04;
									SecondNumber.color = 0xFF00FF04;
									ThirdNumber.color = 0xFF00FF04;
									FourthNumber.color = 0xFF00FF04;
									new FlxTimer().start(0.10, function(tmr:FlxTimer) {
										FirstNumber.color = 0xFFFFFFFF;
										SecondNumber.color = 0xFFFFFFFF;
										ThirdNumber.color = 0xFFFFFFFF;
										FourthNumber.color = 0xFFFFFFFF;
										new FlxTimer().start(0.10, function(tmr:FlxTimer) {
											FirstNumber.color = 0xFF00FF04;
											SecondNumber.color = 0xFF00FF04;
											ThirdNumber.color = 0xFF00FF04;
											FourthNumber.color = 0xFF00FF04;
											new FlxTimer().start(0.10, function(tmr:FlxTimer) {
												FirstNumber.color = 0xFFFFFFFF;
												SecondNumber.color = 0xFFFFFFFF;
												ThirdNumber.color = 0xFFFFFFFF;
												FourthNumber.color = 0xFFFFFFFF;
											});
										});
									});
								});
								
								new FlxTimer().start(0.5, function(tmr:FlxTimer) {
									FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
									FlxG.sound.music.fadeOut(0.5, 0);
									if (ClientPrefs.ExtrasMathSolved == false) ClientPrefs.ExtrasMathSolved = true;
									ClientPrefs.saveSettings();
								});
								
								new FlxTimer().start(1.1, function(tmr:FlxTimer) {
									FlxG.switchState(new ExtrasState());
								});
								shit = true;
							}
						} else { if (!shit) { wrongCode(); shit = true; }}
					} else { if (!shit) { wrongCode(); shit = true; }}
				} else { if (!shit) { wrongCode(); shit = true; }}
			} else { if (!shit) { wrongCode(); shit = true; }}
		}
	}
}