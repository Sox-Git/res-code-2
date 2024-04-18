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

using StringTools;

class DebugState extends MusicBeatState
{
	var Debug:FlxSprite;
	
	var botplayON:FlxSprite;
	var botplayOFF:FlxSprite;
	
	var practiceON:FlxSprite;
	var practiceOFF:FlxSprite;
	
	var encoreUNLOCKED:FlxSprite;
	var encoreLOCKED:FlxSprite;
	
	var soundUNLOCKED:FlxSprite;
	var soundLOCKED:FlxSprite;
	
	var spTooS:FlxSprite;
	var spYouCR:FlxSprite;
	var spTripleT:FlxSprite;
	var spFinalE:FlxSprite;
	var spFaceOff:FlxSprite;
	var spComplete:FlxSprite;
	
	var spAltCoulrophobia:FlxSprite;
	var spAltBrokenH:FlxSprite;
	var spAltTribal:FlxSprite;
	var spAltGoddess:FlxSprite;
	var spAltComplete:FlxSprite;
	
	var codeSHOW:FlxSprite;
	var codeHIDE:FlxSprite;
	
	var SelOne:FlxSprite;
	var SelTwo:FlxSprite;
	var SelThree:FlxSprite;
	var SelFour:FlxSprite;
	var SelFive:FlxSprite;
	var SelSix:FlxSprite;
	var SelSeven:FlxSprite;
	
	var blackScreen:FlxSprite;
	
	private var camGame:FlxCamera;
	var filters:Array<BitmapFilter> = [];
	
	var CanPress:Bool = true;
	
	var curSelected:Int = 1;
	var shiftMult:Int = 1;
	var holdTime:Float = 0;
	
	var hitboxes:FlxTypedSpriteGroup<FlxSprite>;
	var hitbox1:FlxSprite;
	var hitbox2:FlxSprite;
	var hitbox3:FlxSprite;
	var hitbox4:FlxSprite;
	var hitbox5:FlxSprite;
	var hitbox6:FlxSprite;
	var hitbox7:FlxSprite;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Extras Menu (Debug)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'extras-debug';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		camGame.setFilters(filters);
		camGame.filtersEnabled = true;
		camGame.zoom = 0.70;
		
		if (ClientPrefs.Shaders) {
			filters.push(ExtrasVCRHandler.vcr);
			//filters.push(ExtrasScanlineHandler.scanline);   
			ExtrasVCRHandler.vcrSet(0, true, true, true);
		}
		
		Debug = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/debug'));
		Debug.antialiasing = ClientPrefs.globalAntialiasing;
		Debug.scrollFactor.set();
		add(Debug);


		botplayON = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/botplayON'));
		botplayON.antialiasing = ClientPrefs.globalAntialiasing;
		botplayON.scrollFactor.set();
		add(botplayON);

		botplayOFF = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/botplayOFF'));
		botplayOFF.antialiasing = ClientPrefs.globalAntialiasing;
		botplayOFF.scrollFactor.set();
		add(botplayOFF);


		practiceON = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/practiceON'));
		practiceON.antialiasing = ClientPrefs.globalAntialiasing;
		practiceON.scrollFactor.set();
		add(practiceON);
		
		practiceOFF = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/practiceOFF'));
		practiceOFF.antialiasing = ClientPrefs.globalAntialiasing;
		practiceOFF.scrollFactor.set();
		add(practiceOFF);


		encoreUNLOCKED = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/encoreUNLOCKED'));
		encoreUNLOCKED.antialiasing = ClientPrefs.globalAntialiasing;
		encoreUNLOCKED.scrollFactor.set();
		add(encoreUNLOCKED);
		
		encoreLOCKED = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/encoreLOCKED'));
		encoreLOCKED.antialiasing = ClientPrefs.globalAntialiasing;
		encoreLOCKED.scrollFactor.set();
		add(encoreLOCKED);


		soundUNLOCKED = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/soundUNLOCKED'));
		soundUNLOCKED.antialiasing = ClientPrefs.globalAntialiasing;
		soundUNLOCKED.scrollFactor.set();
		add(soundUNLOCKED);
		
		soundLOCKED = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/soundLOCKED'));
		soundLOCKED.antialiasing = ClientPrefs.globalAntialiasing;
		soundLOCKED.scrollFactor.set();
		add(soundLOCKED);


		spTooS = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp0Exe'));
		spTooS.antialiasing = ClientPrefs.globalAntialiasing;
		spTooS.scrollFactor.set();
		add(spTooS);
		
		spYouCR = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp1Exe'));
		spYouCR.antialiasing = ClientPrefs.globalAntialiasing;
		spYouCR.scrollFactor.set();
		add(spYouCR);
		
		spTripleT = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp2Exe'));
		spTripleT.antialiasing = ClientPrefs.globalAntialiasing;
		spTripleT.scrollFactor.set();
		add(spTripleT);
		
		spFinalE = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp3Exe'));
		spFinalE.antialiasing = ClientPrefs.globalAntialiasing;
		spFinalE.scrollFactor.set();
		add(spFinalE);
		
		spFaceOff = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp4Exe'));
		spFaceOff.antialiasing = ClientPrefs.globalAntialiasing;
		spFaceOff.scrollFactor.set();
		add(spFaceOff);
		
		spComplete = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp5Exe'));
		spComplete.antialiasing = ClientPrefs.globalAntialiasing;
		spComplete.scrollFactor.set();
		add(spComplete);


		spAltCoulrophobia = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp0Alt'));
		spAltCoulrophobia.antialiasing = ClientPrefs.globalAntialiasing;
		spAltCoulrophobia.scrollFactor.set();
		add(spAltCoulrophobia);
		
		spAltBrokenH = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp1Alt'));
		spAltBrokenH.antialiasing = ClientPrefs.globalAntialiasing;
		spAltBrokenH.scrollFactor.set();
		add(spAltBrokenH);
		
		spAltTribal = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp2Alt'));
		spAltTribal.antialiasing = ClientPrefs.globalAntialiasing;
		spAltTribal.scrollFactor.set();
		add(spAltTribal);
		
		spAltGoddess = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp3Alt'));
		spAltGoddess.antialiasing = ClientPrefs.globalAntialiasing;
		spAltGoddess.scrollFactor.set();
		add(spAltGoddess);
		
		spAltComplete = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sp4Alt'));
		spAltComplete.antialiasing = ClientPrefs.globalAntialiasing;
		spAltComplete.scrollFactor.set();
		add(spAltComplete);


		codeSHOW = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/codeSHOW'));
		codeSHOW.antialiasing = ClientPrefs.globalAntialiasing;
		codeSHOW.scrollFactor.set();
		add(codeSHOW);
		
		codeHIDE = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/codeHIDE'));
		codeHIDE.antialiasing = ClientPrefs.globalAntialiasing;
		codeHIDE.scrollFactor.set();
		add(codeHIDE);


		SelOne = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel1'));
		SelOne.antialiasing = ClientPrefs.globalAntialiasing;
		SelOne.scrollFactor.set();
		add(SelOne);

		SelTwo = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel2'));
		SelTwo.antialiasing = ClientPrefs.globalAntialiasing;
		SelTwo.scrollFactor.set();
		add(SelTwo);

		SelThree = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel3'));
		SelThree.antialiasing = ClientPrefs.globalAntialiasing;
		SelThree.scrollFactor.set();
		add(SelThree);

		SelFour = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel4'));
		SelFour.antialiasing = ClientPrefs.globalAntialiasing;
		SelFour.scrollFactor.set();
		add(SelFour);
		
		SelFive = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel5'));
		SelFive.antialiasing = ClientPrefs.globalAntialiasing;
		SelFive.scrollFactor.set();
		add(SelFive);

		SelSix = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel6'));
		SelSix.antialiasing = ClientPrefs.globalAntialiasing;
		SelSix.scrollFactor.set();
		add(SelSix);
		
		SelSeven = new FlxSprite(0, 0).loadGraphic(Paths.image('extra/debug/Choice/sel7'));
		SelSeven.antialiasing = ClientPrefs.globalAntialiasing;
		SelSeven.scrollFactor.set();
		add(SelSeven);

		hitboxes = new FlxTypedSpriteGroup<FlxSprite>();
		add(hitboxes);
		hitbox1 = new FlxSprite(226,165).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox1);
		hitbox2 = new FlxSprite(226,246).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox2);
		hitbox3 = new FlxSprite(226,327).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox3);
		hitbox4 = new FlxSprite(226,408).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox4);
		hitbox5 = new FlxSprite(226,489).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox5);
		hitbox6 = new FlxSprite(226,570).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox6);
		hitbox7 = new FlxSprite(226,651).makeGraphic(827, 73, 0x00000000);
		hitboxes.add(hitbox7);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width + 200, FlxG.height + 200, FlxColor.BLACK);
		add(blackScreen);
		
		FlxTween.tween(blackScreen, {alpha: 0}, 0.5, {});

		Select(curSelected,false);
		super.create();
	}
	
	override function update(elapsed:Float)
	{
		if ((controls.BACK || FlxG.mouse.justPressedRight) && CanPress)
		{
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			ClientPrefs.saveSettings();
			FlxTween.tween(blackScreen, {alpha: 1}, 0.5, {});
			new FlxTimer().start(0.6, function(tmr:FlxTimer) {
				FlxG.switchState(new ExtrasState());
			});
			
			CanPress = false;
		}
		
		if (CanPress) {
			var shiftMult:Int = 1;
			if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
			if (!FlxG.mouse.overlaps(hitboxes)) {
				if (controls.UI_UP_P)
				{
					Select(-shiftMult,true,'nothing');
					holdTime = 0;
				}
				if (controls.UI_DOWN_P)
				{
					Select(shiftMult,true,'nothing');
					holdTime = 0;
				}
				if (controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						Select((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult),true,'nothing');
					}
				}
				if (FlxG.mouse.wheel != 0)
				{
					Select(-shiftMult * FlxG.mouse.wheel,true,'nothing');
					holdTime = 0;
				}
				
				if (controls.UI_LEFT_P)
				{
					Select(0,true,'left');
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					Select(0,true,'right');
					holdTime = 0;
				}
			}
			if (FlxG.mouse.overlaps(hitbox1) && curSelected != 1) Select(1,true,'',true);
			if (FlxG.mouse.overlaps(hitbox2) && curSelected != 2) Select(2,true,'',true);
			if (FlxG.mouse.overlaps(hitbox3) && curSelected != 3) Select(3,true,'',true);
			if (FlxG.mouse.overlaps(hitbox4) && curSelected != 4) Select(4,true,'',true);
			if (FlxG.mouse.overlaps(hitbox5) && curSelected != 5) Select(5,true,'',true);
			if (FlxG.mouse.overlaps(hitbox6) && curSelected != 6) Select(6,true,'',true);
			if (FlxG.mouse.overlaps(hitbox7) && curSelected != 7) Select(7,true,'',true);
			if ((FlxG.mouse.justPressedMiddle || FlxG.mouse.justPressed) && FlxG.mouse.overlaps(hitboxes)) {
				switch(curSelected) {
					case 1:
						if (ClientPrefs.gameplaySettings.get("botplay") == false) { 
							botplayON.alpha = 1;
							botplayOFF.alpha = 0;
							ClientPrefs.gameplaySettings.set("botplay", true);
						} else {
							botplayON.alpha = 0;
							botplayOFF.alpha = 1;
							ClientPrefs.gameplaySettings.set("botplay", false);
						}
					case 2:
						if (ClientPrefs.gameplaySettings.get("practice") == false) { 
							practiceON.alpha = 1;
							practiceOFF.alpha = 0;
							ClientPrefs.gameplaySettings.set("practice", true);
						} else {
							practiceON.alpha = 0;
							practiceOFF.alpha = 1;
							ClientPrefs.gameplaySettings.set("practice", false);
						}
					case 3:
						if (ClientPrefs.EncoreUnlocked == false) {
							encoreUNLOCKED.alpha = 1;
							encoreLOCKED.alpha = 0;
							ClientPrefs.EncoreUnlocked = true;
						} else {
							encoreUNLOCKED.alpha = 0;
							encoreLOCKED.alpha = 1;
							ClientPrefs.EncoreUnlocked = false;
						}
					case 4:
						if (ClientPrefs.SoundTestUnlocked == false) {
							soundUNLOCKED.alpha = 1;
							soundLOCKED.alpha = 0;
							ClientPrefs.SoundTestUnlocked = true;
						} else {
							soundUNLOCKED.alpha = 0;
							soundLOCKED.alpha = 1;
							ClientPrefs.SoundTestUnlocked = false;
						}
					case 5:
						switch(ClientPrefs.storyProgressExe) {
							case 0:
								spTooS.alpha = 0;
								spYouCR.alpha = 1;
								spTripleT.alpha = 0;
								spFinalE.alpha = 0;
								spFaceOff.alpha = 0;
								spComplete.alpha = 0;
								ClientPrefs.storyProgressExe = 1;
							case 1:
								spTooS.alpha = 0;
								spYouCR.alpha = 0;
								spTripleT.alpha = 1;
								spFinalE.alpha = 0;
								spFaceOff.alpha = 0;
								spComplete.alpha = 0;
								ClientPrefs.storyProgressExe = 2;
							case 2:
								spTooS.alpha = 0;
								spYouCR.alpha = 0;
								spTripleT.alpha = 0;
								spFinalE.alpha = 1;
								spFaceOff.alpha = 0;
								spComplete.alpha = 0;
								ClientPrefs.storyProgressExe = 3;
							case 3:
								spTooS.alpha = 0;
								spYouCR.alpha = 0;
								spTripleT.alpha = 0;
								spFinalE.alpha = 0;
								spFaceOff.alpha = 1;
								spComplete.alpha = 0;
								ClientPrefs.storyProgressExe = 4;
							case 4:
								spTooS.alpha = 0;
								spYouCR.alpha = 0;
								spTripleT.alpha = 0;
								spFinalE.alpha = 0;
								spFaceOff.alpha = 0;
								spComplete.alpha = 1;
								ClientPrefs.storyProgressExe = 5;
							case 5:
								spTooS.alpha = 1;
								spYouCR.alpha = 0;
								spTripleT.alpha = 0;
								spFinalE.alpha = 0;
								spFaceOff.alpha = 0;
								spComplete.alpha = 0;
								ClientPrefs.storyProgressExe = 0;
						}
					case 6:
						switch(ClientPrefs.storyProgressAlt) {
							case 0:
								spAltCoulrophobia.alpha = 0;
								spAltBrokenH.alpha = 1;
								spAltTribal.alpha = 0;
								spAltGoddess.alpha = 0;
								spAltComplete.alpha = 0;
								ClientPrefs.storyProgressAlt = 1;
							case 1:
								spAltCoulrophobia.alpha = 0;
								spAltBrokenH.alpha = 0;
								spAltTribal.alpha = 1;
								spAltGoddess.alpha = 0;
								spAltComplete.alpha = 0;
								ClientPrefs.storyProgressAlt = 2;
							case 2:
								spAltCoulrophobia.alpha = 0;
								spAltBrokenH.alpha = 0;
								spAltTribal.alpha = 0;
								spAltGoddess.alpha = 1;
								spAltComplete.alpha = 0;
								ClientPrefs.storyProgressAlt = 3;
							case 3:
								spAltCoulrophobia.alpha = 0;
								spAltBrokenH.alpha = 0;
								spAltTribal.alpha = 0;
								spAltGoddess.alpha = 0;
								spAltComplete.alpha = 1;
								ClientPrefs.storyProgressAlt = 4;
							case 4:
								spAltCoulrophobia.alpha = 1;
								spAltBrokenH.alpha = 0;
								spAltTribal.alpha = 0;
								spAltGoddess.alpha = 0;
								spAltComplete.alpha = 0;
								ClientPrefs.storyProgressAlt = 0;
						}
					case 7:
						if (ClientPrefs.ShowExtrasCode == false) {
							codeHIDE.alpha = 0;
							codeSHOW.alpha = 1;
							ClientPrefs.ShowExtrasCode = true;
						} else {
							codeHIDE.alpha = 1;
							codeSHOW.alpha = 0;
							ClientPrefs.ShowExtrasCode = false;
						}
				}
			}
		}
	}
	
	function Select(oaoao:Int = 0, ?PlayTick:Bool = true, ?pressed:String = '', ?mouse:Bool = false) {
		if (PlayTick) FlxG.sound.play(Paths.sound('tick'), 0.4);
		
		if (!mouse) {
			if (pressed == 'nothing') {
				curSelected += oaoao;
				if (curSelected < 1)
					curSelected = 7;
				if (curSelected > 7)
					curSelected = 1;
			}
		} else {
			curSelected = oaoao;
		}
		
		if (pressed == 'right') {
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			if (curSelected == 1) {
				ClientPrefs.gameplaySettings.set("botplay", true);
			}
			if (curSelected == 2) {
				ClientPrefs.gameplaySettings.set("practice", true);
			}
			if (curSelected == 3) {
				ClientPrefs.EncoreUnlocked = true;
			}
			if (curSelected == 4) {
				ClientPrefs.SoundTestUnlocked = true;
			}
			if (curSelected == 5) {
				if (ClientPrefs.storyProgressExe == 0) {
					ClientPrefs.storyProgressExe = 1;
				} else {
					if (ClientPrefs.storyProgressExe == 1) {
						ClientPrefs.storyProgressExe = 2;
					} else {
						if (ClientPrefs.storyProgressExe == 2) {
							ClientPrefs.storyProgressExe = 3;
						} else {
							if (ClientPrefs.storyProgressExe == 3) {
								ClientPrefs.storyProgressExe = 4;
							} else {
								if (ClientPrefs.storyProgressExe == 4) {
									ClientPrefs.storyProgressExe = 5;
								}
							}
						}
					}
				}
			}
			if (curSelected == 6) {
				if (ClientPrefs.storyProgressAlt == 0) {
					ClientPrefs.storyProgressAlt = 1;
				} else {
					if (ClientPrefs.storyProgressAlt == 1) {
						ClientPrefs.storyProgressAlt = 2;
					} else {
						if (ClientPrefs.storyProgressAlt == 2) {
							ClientPrefs.storyProgressAlt = 3;
						} else {
							if (ClientPrefs.storyProgressAlt == 3) {
								ClientPrefs.storyProgressAlt = 4;
							}
						}
					}
				}
			}
			if (curSelected == 7) {
				ClientPrefs.ShowExtrasCode = true;
			}
		}
		
		if (pressed == 'left') {
			FlxG.sound.play(Paths.sound('tick'), 0.4);
			if (curSelected == 1) {
				ClientPrefs.gameplaySettings.set("botplay", false);
			}
			if (curSelected == 2) {
				ClientPrefs.gameplaySettings.set("practice", false);
			}
			if (curSelected == 3) {
				ClientPrefs.EncoreUnlocked = false;
			}
			if (curSelected == 4) {
				ClientPrefs.SoundTestUnlocked = false;
			}
			if (curSelected == 5) {
				if (ClientPrefs.storyProgressExe == 1) {
					ClientPrefs.storyProgressExe = 0;
				} else {
					if (ClientPrefs.storyProgressExe == 2) {
						ClientPrefs.storyProgressExe = 1;
					} else {
						if (ClientPrefs.storyProgressExe == 3) {
							ClientPrefs.storyProgressExe = 2;
						} else {
							if (ClientPrefs.storyProgressExe == 4) {
								ClientPrefs.storyProgressExe = 3;
							} else {
								if (ClientPrefs.storyProgressExe == 5) {
									ClientPrefs.storyProgressExe = 4;
								}
							}
						}
					}
				}
			}
			if (curSelected == 6) {
				if (ClientPrefs.storyProgressAlt == 1) {
					ClientPrefs.storyProgressAlt = 0;
				} else {
					if (ClientPrefs.storyProgressAlt == 2) {
						ClientPrefs.storyProgressAlt = 1;
					} else {
						if (ClientPrefs.storyProgressAlt == 3) {
							ClientPrefs.storyProgressAlt = 2;
						} else {
							if (ClientPrefs.storyProgressAlt == 4) {
								ClientPrefs.storyProgressAlt = 3;
							}
						}
					}
				}
			}
			if (curSelected == 7) {
				ClientPrefs.ShowExtrasCode = false;
			}
		}
		
		if (ClientPrefs.gameplaySettings.get("botplay") == false) { 
			botplayON.alpha = 0;
			botplayOFF.alpha = 1;
		} else {
			botplayON.alpha = 1;
			botplayOFF.alpha = 0;
		}
		
		if (ClientPrefs.gameplaySettings.get("practice") == false) { 
			practiceON.alpha = 0;
			practiceOFF.alpha = 1;
		} else {
			practiceON.alpha = 1;
			practiceOFF.alpha = 0;
		}
		
		if (ClientPrefs.EncoreUnlocked == false) {
			encoreUNLOCKED.alpha = 0;
			encoreLOCKED.alpha = 1;
		} else {
			encoreUNLOCKED.alpha = 1;
			encoreLOCKED.alpha = 0;
		}
		
		if (ClientPrefs.SoundTestUnlocked == false) {
			soundUNLOCKED.alpha = 0;
			soundLOCKED.alpha = 1;
		} else {
			soundUNLOCKED.alpha = 1;
			soundLOCKED.alpha = 0;
		}
		
		switch (ClientPrefs.storyProgressExe)
		{
			case 0:
				spTooS.alpha = 1;
				spYouCR.alpha = 0;
				spTripleT.alpha = 0;
				spFinalE.alpha = 0;
				spFaceOff.alpha = 0;
				spComplete.alpha = 0;
			case 1:
				spTooS.alpha = 0;
				spYouCR.alpha = 1;
				spTripleT.alpha = 0;
				spFinalE.alpha = 0;
				spFaceOff.alpha = 0;
				spComplete.alpha = 0;
			case 2:
				spTooS.alpha = 0;
				spYouCR.alpha = 0;
				spTripleT.alpha = 1;
				spFinalE.alpha = 0;
				spFaceOff.alpha = 0;
				spComplete.alpha = 0;
			case 3:
				spTooS.alpha = 0;
				spYouCR.alpha = 0;
				spTripleT.alpha = 0;
				spFinalE.alpha = 1;
				spFaceOff.alpha = 0;
				spComplete.alpha = 0;
			case 4:
				spTooS.alpha = 0;
				spYouCR.alpha = 0;
				spTripleT.alpha = 0;
				spFinalE.alpha = 0;
				spFaceOff.alpha = 1;
				spComplete.alpha = 0;
			case 5:
				spTooS.alpha = 0;
				spYouCR.alpha = 0;
				spTripleT.alpha = 0;
				spFinalE.alpha = 0;
				spFaceOff.alpha = 0;
				spComplete.alpha = 1;
		}
		
		switch (ClientPrefs.storyProgressAlt)
		{
			case 0:
				spAltCoulrophobia.alpha = 1;
				spAltBrokenH.alpha = 0;
				spAltTribal.alpha = 0;
				spAltGoddess.alpha = 0;
				spAltComplete.alpha = 0;
			case 1:
				spAltCoulrophobia.alpha = 0;
				spAltBrokenH.alpha = 1;
				spAltTribal.alpha = 0;
				spAltGoddess.alpha = 0;
				spAltComplete.alpha = 0;
			case 2:
				spAltCoulrophobia.alpha = 0;
				spAltBrokenH.alpha = 0;
				spAltTribal.alpha = 1;
				spAltGoddess.alpha = 0;
				spAltComplete.alpha = 0;
			case 3:
				spAltCoulrophobia.alpha = 0;
				spAltBrokenH.alpha = 0;
				spAltTribal.alpha = 0;
				spAltGoddess.alpha = 1;
				spAltComplete.alpha = 0;
			case 4:
				spAltCoulrophobia.alpha = 0;
				spAltBrokenH.alpha = 0;
				spAltTribal.alpha = 0;
				spAltGoddess.alpha = 0;
				spAltComplete.alpha = 1;
		}
		
		if (ClientPrefs.ShowExtrasCode == true) {
			codeHIDE.alpha = 0;
			codeSHOW.alpha = 1;
		} else {
			codeHIDE.alpha = 1;
			codeSHOW.alpha = 0;
		}
		
		if (curSelected == 1) {
			SelOne.alpha = 1;
			SelTwo.alpha = 0;
			SelThree.alpha = 0;
			SelFour.alpha = 0;
			SelFive.alpha = 0;
			SelSix.alpha = 0;
			SelSeven.alpha = 0;
			
			botplayON.color = 0xFF666666;
			botplayOFF.color = 0xFF666666;
			
			practiceON.color = 0xFFFFFFFF;
			practiceOFF.color = 0xFFFFFFFF;
			
			encoreUNLOCKED.color = 0xFFFFFFFF;
			encoreLOCKED.color = 0xFFFFFFFF;
			
			soundUNLOCKED.color = 0xFFFFFFFF;
			soundLOCKED.color = 0xFFFFFFFF;
			
			spTooS.color = 0xFFFFFFFF;
			spYouCR.color = 0xFFFFFFFF;
			spTripleT.color = 0xFFFFFFFF;
			spFinalE.color = 0xFFFFFFFF;
			spFaceOff.color = 0xFFFFFFFF;
			spComplete.color = 0xFFFFFFFF;
			
			spAltCoulrophobia.color = 0xFFFFFFFF;
			spAltBrokenH.color = 0xFFFFFFFF;
			spAltTribal.color = 0xFFFFFFFF;
			spAltGoddess.color = 0xFFFFFFFF;
			spAltComplete.color = 0xFFFFFFFF;
			
			codeHIDE.color = 0xFFFFFFFF;
			codeSHOW.color = 0xFFFFFFFF;
		}
		
		if (curSelected == 2) {
			SelOne.alpha = 0;
			SelTwo.alpha = 1;
			SelThree.alpha = 0;
			SelFour.alpha = 0;
			SelFive.alpha = 0;
			SelSix.alpha = 0;
			SelSeven.alpha = 0;
			
			botplayON.color = 0xFFFFFFFF;
			botplayOFF.color = 0xFFFFFFFF;
			
			practiceON.color = 0xFF666666;
			practiceOFF.color = 0xFF666666;
			
			encoreUNLOCKED.color = 0xFFFFFFFF;
			encoreLOCKED.color = 0xFFFFFFFF;
			
			soundUNLOCKED.color = 0xFFFFFFFF;
			soundLOCKED.color = 0xFFFFFFFF;
			
			spTooS.color = 0xFFFFFFFF;
			spYouCR.color = 0xFFFFFFFF;
			spTripleT.color = 0xFFFFFFFF;
			spFinalE.color = 0xFFFFFFFF;
			spFaceOff.color = 0xFFFFFFFF;
			spComplete.color = 0xFFFFFFFF;
			
			spAltCoulrophobia.color = 0xFFFFFFFF;
			spAltBrokenH.color = 0xFFFFFFFF;
			spAltTribal.color = 0xFFFFFFFF;
			spAltGoddess.color = 0xFFFFFFFF;
			spAltComplete.color = 0xFFFFFFFF;
			
			codeHIDE.color = 0xFFFFFFFF;
			codeSHOW.color = 0xFFFFFFFF;
		}
		
		if (curSelected == 3) {
			SelOne.alpha = 0;
			SelTwo.alpha = 0;
			SelThree.alpha = 1;
			SelFour.alpha = 0;
			SelFive.alpha = 0;
			SelSix.alpha = 0;
			SelSeven.alpha = 0;
			
			botplayON.color = 0xFFFFFFFF;
			botplayOFF.color = 0xFFFFFFFF;
			
			practiceON.color = 0xFFFFFFFF;
			practiceOFF.color = 0xFFFFFFFF;
			
			encoreUNLOCKED.color = 0xFF666666;
			encoreLOCKED.color = 0xFF666666;
			
			soundUNLOCKED.color = 0xFFFFFFFF;
			soundLOCKED.color = 0xFFFFFFFF;
			
			spTooS.color = 0xFFFFFFFF;
			spYouCR.color = 0xFFFFFFFF;
			spTripleT.color = 0xFFFFFFFF;
			spFinalE.color = 0xFFFFFFFF;
			spFaceOff.color = 0xFFFFFFFF;
			spComplete.color = 0xFFFFFFFF;
			
			spAltCoulrophobia.color = 0xFFFFFFFF;
			spAltBrokenH.color = 0xFFFFFFFF;
			spAltTribal.color = 0xFFFFFFFF;
			spAltGoddess.color = 0xFFFFFFFF;
			spAltComplete.color = 0xFFFFFFFF;
			
			codeHIDE.color = 0xFFFFFFFF;
			codeSHOW.color = 0xFFFFFFFF;
		}
		
		if (curSelected == 4) {
			SelOne.alpha = 0;
			SelTwo.alpha = 0;
			SelThree.alpha = 0;
			SelFour.alpha = 1;
			SelFive.alpha = 0;
			SelSix.alpha = 0;
			SelSeven.alpha = 0;
			
			botplayON.color = 0xFFFFFFFF;
			botplayOFF.color = 0xFFFFFFFF;
			
			practiceON.color = 0xFFFFFFFF;
			practiceOFF.color = 0xFFFFFFFF;
			
			encoreUNLOCKED.color = 0xFFFFFFFF;
			encoreLOCKED.color = 0xFFFFFFFF;
			
			soundUNLOCKED.color = 0xFF666666;
			soundLOCKED.color = 0xFF666666;
			
			spTooS.color = 0xFFFFFFFF;
			spYouCR.color = 0xFFFFFFFF;
			spTripleT.color = 0xFFFFFFFF;
			spFinalE.color = 0xFFFFFFFF;
			spFaceOff.color = 0xFFFFFFFF;
			spComplete.color = 0xFFFFFFFF;
			
			spAltCoulrophobia.color = 0xFFFFFFFF;
			spAltBrokenH.color = 0xFFFFFFFF;
			spAltTribal.color = 0xFFFFFFFF;
			spAltGoddess.color = 0xFFFFFFFF;
			spAltComplete.color = 0xFFFFFFFF;
			
			codeHIDE.color = 0xFFFFFFFF;
			codeSHOW.color = 0xFFFFFFFF;
		}
		
		if (curSelected == 5) {
			SelOne.alpha = 0;
			SelTwo.alpha = 0;
			SelThree.alpha = 0;
			SelFour.alpha = 0;
			SelFive.alpha = 1;
			SelSix.alpha = 0;
			SelSeven.alpha = 0;
			
			botplayON.color = 0xFFFFFFFF;
			botplayOFF.color = 0xFFFFFFFF;
			
			practiceON.color = 0xFFFFFFFF;
			practiceOFF.color = 0xFFFFFFFF;
			
			encoreUNLOCKED.color = 0xFFFFFFFF;
			encoreLOCKED.color = 0xFFFFFFFF;
			
			soundUNLOCKED.color = 0xFFFFFFFF;
			soundLOCKED.color = 0xFFFFFFFF;
			
			spTooS.color = 0xFF666666;
			spYouCR.color = 0xFF666666;
			spTripleT.color = 0xFF666666;
			spFinalE.color = 0xFF666666;
			spFaceOff.color = 0xFF666666;
			spComplete.color = 0xFF666666;

			spAltCoulrophobia.color = 0xFFFFFFFF;
			spAltBrokenH.color = 0xFFFFFFFF;
			spAltTribal.color = 0xFFFFFFFF;
			spAltGoddess.color = 0xFFFFFFFF;
			spAltComplete.color = 0xFFFFFFFF;
			
			codeHIDE.color = 0xFFFFFFFF;
			codeSHOW.color = 0xFFFFFFFF;
		}
		
		if (curSelected == 6) {
			SelOne.alpha = 0;
			SelTwo.alpha = 0;
			SelThree.alpha = 0;
			SelFour.alpha = 0;
			SelFive.alpha = 0;
			SelSix.alpha = 1;
			SelSeven.alpha = 0;
			
			botplayON.color = 0xFFFFFFFF;
			botplayOFF.color = 0xFFFFFFFF;
			
			practiceON.color = 0xFFFFFFFF;
			practiceOFF.color = 0xFFFFFFFF;
			
			encoreUNLOCKED.color = 0xFFFFFFFF;
			encoreLOCKED.color = 0xFFFFFFFF;
			
			soundUNLOCKED.color = 0xFFFFFFFF;
			soundLOCKED.color = 0xFFFFFFFF;
			
			spTooS.color = 0xFFFFFFFF;
			spYouCR.color = 0xFFFFFFFF;
			spTripleT.color = 0xFFFFFFFF;
			spFinalE.color = 0xFFFFFFFF;
			spFaceOff.color = 0xFFFFFFFF;
			spComplete.color = 0xFFFFFFFF;
			
			spAltCoulrophobia.color = 0xFF666666;
			spAltBrokenH.color = 0xFF666666;
			spAltTribal.color = 0xFF666666;
			spAltGoddess.color = 0xFF666666;
			spAltComplete.color = 0xFF666666;
			
			codeHIDE.color = 0xFFFFFFFF;
			codeSHOW.color = 0xFFFFFFFF;
		}
		
		if (curSelected == 7) {
			SelOne.alpha = 0;
			SelTwo.alpha = 0;
			SelThree.alpha = 0;
			SelFour.alpha = 0;
			SelFive.alpha = 0;
			SelSix.alpha = 0;
			SelSeven.alpha = 1;
			
			botplayON.color = 0xFFFFFFFF;
			botplayOFF.color = 0xFFFFFFFF;
			
			practiceON.color = 0xFFFFFFFF;
			practiceOFF.color = 0xFFFFFFFF;
			
			encoreUNLOCKED.color = 0xFFFFFFFF;
			encoreLOCKED.color = 0xFFFFFFFF;
			
			soundUNLOCKED.color = 0xFFFFFFFF;
			soundLOCKED.color = 0xFFFFFFFF;
			
			spTooS.color = 0xFFFFFFFF;
			spYouCR.color = 0xFFFFFFFF;
			spTripleT.color = 0xFFFFFFFF;
			spFinalE.color = 0xFFFFFFFF;
			spFaceOff.color = 0xFFFFFFFF;
			spComplete.color = 0xFFFFFFFF;
			
			spAltCoulrophobia.color = 0xFFFFFFFF;
			spAltBrokenH.color = 0xFFFFFFFF;
			spAltTribal.color = 0xFFFFFFFF;
			spAltGoddess.color = 0xFFFFFFFF;
			spAltComplete.color = 0xFFFFFFFF;
			
			codeHIDE.color = 0xFF666666;
			codeSHOW.color = 0xFF666666;
		}
	}
}