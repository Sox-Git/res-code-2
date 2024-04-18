package options;

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
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop; 
import Controls;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class ControlsNewState extends MusicBeatState
{
	#if mobile
		var descText:FlxText;
		var descBox:FlxSprite;
	#end
	
	private var camGame:FlxCamera;
	var bg:FlxBackdrop;
	var window:FlxSprite;
	var FGup:FlxBackdrop;
	var FGdown:FlxBackdrop;
	var contr:FlxSprite;
	
	var NoteLEFT:FlxText;
	var NoteLEFTF:FlxText;
	var NoteLEFTS:FlxText;
	var NoteDOWN:FlxText;
	var NoteDOWNF:FlxText;
	var NoteDOWNS:FlxText;
	var NoteUP:FlxText;
	var NoteUPF:FlxText;
	var NoteUPS:FlxText;
	var NoteRIGHT:FlxText;
	var NoteRIGHTF:FlxText;
	var NoteRIGHTS:FlxText;
	var NoteSPECIAL:FlxText;
	var NoteSPECIALF:FlxText;
	var NoteSPECIALS:FlxText;
	
	var UILEFT:FlxText;
	var UILEFTF:FlxText;
	var UILEFTS:FlxText;
	var UIDOWN:FlxText;
	var UIDOWNF:FlxText;
	var UIDOWNS:FlxText;
	var UIUP:FlxText;
	var UIUPF:FlxText;
	var UIUPS:FlxText;
	var UIRIGHT:FlxText;
	var UIRIGHTF:FlxText;
	var UIRIGHTS:FlxText;
	
	var VolMUTE:FlxText;
	var VolMUTEF:FlxText;
	var VolMUTES:FlxText;
	var VolUP:FlxText;
	var VolUPF:FlxText;
	var VolUPS:FlxText;
	var VolDOWN:FlxText;
	var VolDOWNF:FlxText;
	var VolDOWNS:FlxText;
	var DEBUGO:FlxText;
	var DEBUGOF:FlxText;
	var DEBUGOS:FlxText;
	var DEBUGT:FlxText;
	var DEBUGTF:FlxText;
	var DEBUGTS:FlxText;
	
	var RESET:FlxText;
	var RESETF:FlxText;
	var RESETS:FlxText;
	var ACCEPT:FlxText;
	var ACCEPTF:FlxText;
	var ACCEPTS:FlxText;
	var BACK:FlxText;
	var BACKF:FlxText;
	var BACKS:FlxText;
	var PAUSE:FlxText;
	var PAUSEF:FlxText;
	var PAUSES:FlxText;
	
	var box:FlxSprite;
	var five:FlxSprite;
	var four:FlxSprite;
	var three:FlxSprite;
	var two:FlxSprite;
	var one:FlxSprite;
	var zero:FlxSprite;
	
	var curSelected:Int = 0;
	var keyPressed:Array<FlxKey>;
	var keyP:Int;
	var TimerOne:FlxTimer = null;
	var TimerTwo:FlxTimer = null;
	var TimerReset:FlxTimer = null;
	var FuckingTimer:FlxTimer = null;
	var rebindingKey:Bool = false;
	var changing:Bool = false;
	var ResetNooo:Bool = false;
	var ResetTimer:Float = 1.5;
	var fuckIt:Bool = false;
	var fuckYou:Bool = false;
	var ResTimeOut:Bool = false;
	
	var FuckingTimerFIVE:FlxTimer = null;
	var FuckingTimerFOUR:FlxTimer = null;
	var FuckingTimerTHREE:FlxTimer = null;
	var FuckingTimerTWO:FlxTimer = null;
	var FuckingTimerONE:FlxTimer = null;
	var FuckingTimerZERO:FlxTimer = null;
	
	var blackScreen:FlxSprite;
	var locked:Bool = true;
	
	override function create()
	{
		#if desktop
		var rpcName:String = 'In Options Menu (Controls)';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.imageRpc = 'options-controls';
		DiscordClient.changePresence(rpcName, null);
		#end
		
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		
		bg = new FlxBackdrop(Paths.image('options/main/bg'), 1, 1, false, true);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);
		
		window = new FlxSprite(0, 0).loadGraphic(Paths.image('options/main/window'));
		window.antialiasing = ClientPrefs.globalAntialiasing;
		window.scrollFactor.set();
		window.screenCenter();
		add(window);
		
		FGup = new FlxBackdrop(Paths.image('options/main/fg-up'), 1, 1, true, false);
		FGup.antialiasing = ClientPrefs.globalAntialiasing;
		FGup.screenCenter();
		add(FGup);
		
		FGdown = new FlxBackdrop(Paths.image('options/main/fg-down'), 1, 1, true, false);
		FGdown.antialiasing = ClientPrefs.globalAntialiasing;
		FGdown.screenCenter();
		add(FGdown);
		
		contr = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls'));
		contr.antialiasing = ClientPrefs.globalAntialiasing;
		contr.scrollFactor.set();
		contr.screenCenter();
		add(contr);
		
		//Notes
		NoteLEFT = new FlxText(200, 138, FlxG.width, "LEFT");
		NoteLEFT.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		NoteLEFT.scrollFactor.set();
		NoteLEFT.borderSize = 1.25;
		add(NoteLEFT);
		
		NoteLEFTF = new FlxText(-250, 138, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_left')[0] + ' ]');
		NoteLEFTF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteLEFTF.scrollFactor.set();
		NoteLEFTF.borderSize = 1.25;
		add(NoteLEFTF);
		
		NoteLEFTS = new FlxText(-100, 138, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_left')[1] + ' ]');
		NoteLEFTS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteLEFTS.scrollFactor.set();
		NoteLEFTS.borderSize = 1.25;
		add(NoteLEFTS);
		
		
		NoteDOWN = new FlxText(200, 175, FlxG.width, "DOWN");
		NoteDOWN.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		NoteDOWN.scrollFactor.set();
		NoteDOWN.borderSize = 1.25;
		add(NoteDOWN);
		
		NoteDOWNF = new FlxText(-250, 175, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_down')[0] + ' ]');
		NoteDOWNF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteDOWNF.scrollFactor.set();
		NoteDOWNF.borderSize = 1.25;
		add(NoteDOWNF);
		
		NoteDOWNS = new FlxText(-100, 175, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_down')[1] + ' ]');
		NoteDOWNS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteDOWNS.scrollFactor.set();
		NoteDOWNS.borderSize = 1.25;
		add(NoteDOWNS);
		
		
		NoteUP = new FlxText(200, 212, FlxG.width, "UP");
		NoteUP.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		NoteUP.scrollFactor.set();
		NoteUP.borderSize = 1.25;
		add(NoteUP);
		
		NoteUPF = new FlxText(-250, 212, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_up')[0] + ' ]');
		NoteUPF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteUPF.scrollFactor.set();
		NoteUPF.borderSize = 1.25;
		add(NoteUPF);
		
		NoteUPS = new FlxText(-100, 212, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_up')[1] + ' ]');
		NoteUPS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteUPS.scrollFactor.set();
		NoteUPS.borderSize = 1.25;
		add(NoteUPS);
		
		
		NoteRIGHT = new FlxText(200, 249, FlxG.width, "RIGHT");
		NoteRIGHT.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		NoteRIGHT.scrollFactor.set();
		NoteRIGHT.borderSize = 1.25;
		add(NoteRIGHT);
		
		NoteRIGHTF = new FlxText(-250, 249, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_right')[0] + ' ]');
		NoteRIGHTF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteRIGHTF.scrollFactor.set();
		NoteRIGHTF.borderSize = 1.25;
		add(NoteRIGHTF);
		
		NoteRIGHTS = new FlxText(-100, 249, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_right')[1] + ' ]');
		NoteRIGHTS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteRIGHTS.scrollFactor.set();
		NoteRIGHTS.borderSize = 1.25;
		add(NoteRIGHTS);
		
		
		NoteSPECIAL = new FlxText(200, 286, FlxG.width, "SPECIAL");
		NoteSPECIAL.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		NoteSPECIAL.scrollFactor.set();
		NoteSPECIAL.borderSize = 1.25;
		add(NoteSPECIAL);
		
		NoteSPECIALF = new FlxText(-250, 286, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_ring')[0] + ' ]');
		NoteSPECIALF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteSPECIALF.scrollFactor.set();
		NoteSPECIALF.borderSize = 1.25;
		add(NoteSPECIALF);
		
		NoteSPECIALS = new FlxText(-100, 286, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('note_ring')[1] + ' ]');
		NoteSPECIALS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		NoteSPECIALS.scrollFactor.set();
		NoteSPECIALS.borderSize = 1.25;
		add(NoteSPECIALS);
		
		//UI
		UILEFT = new FlxText(660, 138, FlxG.width, "LEFT");
		UILEFT.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		UILEFT.scrollFactor.set();
		UILEFT.borderSize = 1.25;
		add(UILEFT);
		
		UILEFTF = new FlxText(210, 138, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_left')[0] + ' ]');
		UILEFTF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UILEFTF.scrollFactor.set();
		UILEFTF.borderSize = 1.25;
		add(UILEFTF);
		
		UILEFTS = new FlxText(360, 138, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_left')[1] + ' ]');
		UILEFTS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UILEFTS.scrollFactor.set();
		UILEFTS.borderSize = 1.25;
		add(UILEFTS);
		
		
		UIDOWN = new FlxText(660, 175, FlxG.width, "DOWN");
		UIDOWN.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		UIDOWN.scrollFactor.set();
		UIDOWN.borderSize = 1.25;
		add(UIDOWN);
		
		UIDOWNF = new FlxText(210, 175, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_down')[0] + ' ]');
		UIDOWNF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UIDOWNF.scrollFactor.set();
		UIDOWNF.borderSize = 1.25;
		add(UIDOWNF);
		
		UIDOWNS = new FlxText(360, 175, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_down')[1] + ' ]');
		UIDOWNS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UIDOWNS.scrollFactor.set();
		UIDOWNS.borderSize = 1.25;
		add(UIDOWNS);
		
		
		UIUP = new FlxText(660, 212, FlxG.width, "UP");
		UIUP.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		UIUP.scrollFactor.set();
		UIUP.borderSize = 1.25;
		add(UIUP);
		
		UIUPF = new FlxText(210, 212, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_up')[0] + ' ]');
		UIUPF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UIUPF.scrollFactor.set();
		UIUPF.borderSize = 1.25;
		add(UIUPF);
		
		UIUPS = new FlxText(360, 212, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_up')[1] + ' ]');
		UIUPS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UIUPS.scrollFactor.set();
		UIUPS.borderSize = 1.25;
		add(UIUPS);
		
		
		UIRIGHT = new FlxText(660, 249, FlxG.width, "RIGHT");
		UIRIGHT.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		UIRIGHT.scrollFactor.set();
		UIRIGHT.borderSize = 1.25;
		add(UIRIGHT);
		
		UIRIGHTF = new FlxText(210, 249, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_right')[0] + ' ]');
		UIRIGHTF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UIRIGHTF.scrollFactor.set();
		UIRIGHTF.borderSize = 1.25;
		add(UIRIGHTF);
		
		UIRIGHTS = new FlxText(360, 249, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('ui_right')[1] + ' ]');
		UIRIGHTS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		UIRIGHTS.scrollFactor.set();
		UIRIGHTS.borderSize = 1.25;
		add(UIRIGHTS);
		
		//MISC
		VolMUTE = new FlxText(200, 380, FlxG.width, "VOL.MUTE");
		VolMUTE.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		VolMUTE.scrollFactor.set();
		VolMUTE.borderSize = 1.25;
		add(VolMUTE);
		
		VolMUTEF = new FlxText(-250, 380, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('volume_mute')[0] + ' ]');
		VolMUTEF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		VolMUTEF.scrollFactor.set();
		VolMUTEF.borderSize = 1.25;
		add(VolMUTEF);
		
		VolMUTES = new FlxText(-100, 380, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('volume_mute')[1] + ' ]');
		VolMUTES.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		VolMUTES.scrollFactor.set();
		VolMUTES.borderSize = 1.25;
		add(VolMUTES);
		
		
		VolUP = new FlxText(200, 417, FlxG.width, "VOL.U");
		VolUP.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		VolUP.scrollFactor.set();
		VolUP.borderSize = 1.25;
		add(VolUP);
		
		VolUPF = new FlxText(-250, 417, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('volume_up')[0] + ' ]');
		VolUPF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		VolUPF.scrollFactor.set();
		VolUPF.borderSize = 1.25;
		add(VolUPF);
		
		VolUPS = new FlxText(-100, 417, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('volume_up')[1] + ' ]');
		VolUPS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		VolUPS.scrollFactor.set();
		VolUPS.borderSize = 1.25;
		add(VolUPS);
		
		
		VolDOWN = new FlxText(200, 454, FlxG.width, "VOL.D");
		VolDOWN.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		VolDOWN.scrollFactor.set();
		VolDOWN.borderSize = 1.25;
		add(VolDOWN);
		
		VolDOWNF = new FlxText(-250, 454, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('volume_down')[0] + ' ]');
		VolDOWNF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		VolDOWNF.scrollFactor.set();
		VolDOWNF.borderSize = 1.25;
		add(VolDOWNF);
		
		VolDOWNS = new FlxText(-100, 454, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('volume_down')[1] + ' ]');
		VolDOWNS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		VolDOWNS.scrollFactor.set();
		VolDOWNS.borderSize = 1.25;
		add(VolDOWNS);
		
		
		DEBUGO = new FlxText(200, 491, FlxG.width, "DEBUG 1");
		DEBUGO.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		DEBUGO.scrollFactor.set();
		DEBUGO.borderSize = 1.25;
		add(DEBUGO);
		
		DEBUGOF = new FlxText(-250, 491, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('debug_1')[0] + ' ]');
		DEBUGOF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		DEBUGOF.scrollFactor.set();
		DEBUGOF.borderSize = 1.25;
		add(DEBUGOF);
		
		DEBUGOS = new FlxText(-100, 491, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('debug_1')[1] + ' ]');
		DEBUGOS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		DEBUGOS.scrollFactor.set();
		DEBUGOS.borderSize = 1.25;
		add(DEBUGOS);
		
		
		DEBUGT = new FlxText(200, 528, FlxG.width, "DEBUG 2");
		DEBUGT.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		DEBUGT.scrollFactor.set();
		DEBUGT.borderSize = 1.25;
		add(DEBUGT);
		
		DEBUGTF = new FlxText(-250, 528, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('debug_2')[0] + ' ]');
		DEBUGTF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		DEBUGTF.scrollFactor.set();
		DEBUGTF.borderSize = 1.25;
		add(DEBUGTF);
		
		DEBUGTS = new FlxText(-100, 528, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('debug_2')[1] + ' ]');
		DEBUGTS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		DEBUGTS.scrollFactor.set();
		DEBUGTS.borderSize = 1.25;
		add(DEBUGTS);
		
		
		//OTHER
		RESET = new FlxText(660, 380, FlxG.width, "RESET");
		RESET.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		RESET.scrollFactor.set();
		RESET.borderSize = 1.25;
		add(RESET);
		
		RESETF = new FlxText(210, 380, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('reset')[0] + ' ]');
		RESETF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		RESETF.scrollFactor.set();
		RESETF.borderSize = 1.25;
		add(RESETF);
		
		RESETS = new FlxText(360, 380, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('reset')[1] + ' ]');
		RESETS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		RESETS.scrollFactor.set();
		RESETS.borderSize = 1.25;
		add(RESETS);
		
		
		ACCEPT = new FlxText(660, 417, FlxG.width, "ACCEPT");
		ACCEPT.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		ACCEPT.scrollFactor.set();
		ACCEPT.borderSize = 1.25;
		add(ACCEPT);
		
		ACCEPTF = new FlxText(210, 417, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('accept')[0] + ' ]');
		ACCEPTF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		ACCEPTF.scrollFactor.set();
		ACCEPTF.borderSize = 1.25;
		add(ACCEPTF);
		
		ACCEPTS = new FlxText(360, 417, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('accept')[1] + ' ]');
		ACCEPTS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		ACCEPTS.scrollFactor.set();
		ACCEPTS.borderSize = 1.25;
		add(ACCEPTS);
		
		
		BACK = new FlxText(660, 454, FlxG.width, "BACK");
		BACK.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		BACK.scrollFactor.set();
		BACK.borderSize = 1.25;
		add(BACK);
		
		BACKF = new FlxText(210, 454, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('back')[0] + ' ]');
		BACKF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		BACKF.scrollFactor.set();
		BACKF.borderSize = 1.25;
		add(BACKF);
		
		BACKS = new FlxText(360, 454, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('back')[1] + ' ]');
		BACKS.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		BACKS.scrollFactor.set();
		BACKS.borderSize = 1.25;
		add(BACKS);
		
		
		PAUSE = new FlxText(660, 491, FlxG.width, "PAUSE");
		PAUSE.setFormat(Paths.font("advanced.ttf"), 35, 0xFFFFFFFF, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF262626);
		PAUSE.scrollFactor.set();
		PAUSE.borderSize = 1.25;
		add(PAUSE);
		
		PAUSEF = new FlxText(210, 491, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('pause')[0] + ' ]');
		PAUSEF.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		PAUSEF.scrollFactor.set();
		PAUSEF.borderSize = 1.25;
		add(PAUSEF);
		
		PAUSES = new FlxText(360, 491, FlxG.width, '[ ' + ClientPrefs.keyBinds.get('pause')[1] + ' ]');
		PAUSES.setFormat(Paths.font("advanced.ttf"), 35, 0xFFB400FF, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		PAUSES.scrollFactor.set();
		PAUSES.borderSize = 1.25;
		add(PAUSES);
		
		
		box = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/box'));
		box.antialiasing = ClientPrefs.globalAntialiasing;
		box.scrollFactor.set();
		box.screenCenter();
		add(box);
		
		five = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/5'));
		five.antialiasing = ClientPrefs.globalAntialiasing;
		five.scrollFactor.set();
		five.screenCenter();
		add(five);
		
		four = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/4'));
		four.antialiasing = ClientPrefs.globalAntialiasing;
		four.scrollFactor.set();
		four.screenCenter();
		add(four);
		
		three = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/3'));
		three.antialiasing = ClientPrefs.globalAntialiasing;
		three.scrollFactor.set();
		three.screenCenter();
		add(three);
		
		two = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/2'));
		two.antialiasing = ClientPrefs.globalAntialiasing;
		two.scrollFactor.set();
		two.screenCenter();
		add(two);
		
		one = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/1'));
		one.antialiasing = ClientPrefs.globalAntialiasing;
		one.scrollFactor.set();
		one.screenCenter();
		add(one);
		
		zero = new FlxSprite(0, 0).loadGraphic(Paths.image('options/controls-reset-timeout/0'));
		zero.antialiasing = ClientPrefs.globalAntialiasing;
		zero.scrollFactor.set();
		zero.screenCenter();
		add(zero);
		
		box.alpha = 0;
		five.alpha = 0;
		four.alpha = 0;
		three.alpha = 0;
		two.alpha = 0;
		one.alpha = 0;
		zero.alpha = 0;
		
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.scrollFactor.set();
		blackScreen.screenCenter(X);
		add(blackScreen);
		FlxTween.tween(blackScreen, {alpha: 0}, 0.25, {onComplete: function(twn:FlxTween) {
			locked = false;
		}});
		
		Select(0, false);
		
		#if mobile
			descBox = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
			descBox.alpha = 0.6;
			add(descBox);
			
			descText = new FlxText(50, 315, 1200, "IF YOU'RE NOT USING PHYSICAL KEYBOARD, GO BACK(PRESS/RELEASE MOBILE BACK)", 15);
			descText.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 15, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			descText.scrollFactor.set();
			descText.borderSize = 2.4;
			descText.antialiasing = ClientPrefs.globalAntialiasing;
			add(descText);
			
			descText.screenCenter(Y);
			descText.y += 315;
			
			descBox.setPosition(descText.x - 10, descText.y - 10);
			descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
			descBox.updateHitbox();
		#end
		
		super.create();
	}
	
	function Select(change:Int = 0, ?playSound:Bool = true)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected = change;
		if (fuckIt) fuckIt = false;
	
		NoteLEFTF.color = 0xFFB400FF;
		NoteLEFTS.color = 0xFFB400FF;
		NoteDOWNF.color = 0xFFB400FF;
		NoteDOWNS.color = 0xFFB400FF;
		NoteUPF.color = 0xFFB400FF;
		NoteUPS.color = 0xFFB400FF;
		NoteRIGHTF.color = 0xFFB400FF;
		NoteRIGHTS.color = 0xFFB400FF;
		NoteSPECIALF.color = 0xFFB400FF;
		NoteSPECIALS.color = 0xFFB400FF;
		
		UILEFTF.color = 0xFFB400FF;
		UILEFTS.color = 0xFFB400FF;
		UIDOWNF.color = 0xFFB400FF;
		UIDOWNS.color = 0xFFB400FF;
		UIUPF.color = 0xFFB400FF;
		UIUPS.color = 0xFFB400FF;
		UIRIGHTF.color = 0xFFB400FF;
		UIRIGHTS.color = 0xFFB400FF;
				
		VolMUTEF.color = 0xFFB400FF;
		VolMUTES.color = 0xFFB400FF;
		VolUPF.color = 0xFFB400FF;
		VolUPS.color = 0xFFB400FF;
		VolDOWNF.color = 0xFFB400FF;
		VolDOWNS.color = 0xFFB400FF;
		DEBUGOF.color = 0xFFB400FF;
		DEBUGOS.color = 0xFFB400FF;
		DEBUGTF.color = 0xFFB400FF;
		DEBUGTS.color = 0xFFB400FF;
				
		RESETF.color = 0xFFB400FF;
		RESETS.color = 0xFFB400FF;
		ACCEPTF.color = 0xFFB400FF;
		ACCEPTS.color = 0xFFB400FF;
		BACKF.color = 0xFFB400FF;
		BACKS.color = 0xFFB400FF;
		PAUSEF.color = 0xFFB400FF;
		PAUSES.color = 0xFFB400FF;
	
		switch(curSelected) {
			case 0: NoteLEFTF.color = 0xFFFFD700;
			case 1: NoteLEFTS.color = 0xFFFFD700;
			case 2: NoteDOWNF.color = 0xFFFFD700;
			case 3: NoteDOWNS.color = 0xFFFFD700;
			case 4: NoteUPF.color = 0xFFFFD700;
			case 5: NoteUPS.color = 0xFFFFD700;
			case 6: NoteRIGHTF.color = 0xFFFFD700;
			case 7: NoteRIGHTS.color = 0xFFFFD700;
			case 8: NoteSPECIALF.color = 0xFFFFD700;
			case 9: NoteSPECIALS.color = 0xFFFFD700;
			case 10: UILEFTF.color = 0xFFFFD700;
			case 11: UILEFTS.color = 0xFFFFD700;
			case 12: UIDOWNF.color = 0xFFFFD700;
			case 13: UIDOWNS.color = 0xFFFFD700;
			case 14: UIUPF.color = 0xFFFFD700;
			case 15: UIUPS.color = 0xFFFFD700;
			case 16: UIRIGHTF.color = 0xFFFFD700;
			case 17: UIRIGHTS.color = 0xFFFFD700;
			case 18: VolMUTEF.color = 0xFFFFD700;
			case 19: VolMUTES.color = 0xFFFFD700;
			case 20: VolUPF.color = 0xFFFFD700;
			case 21: VolUPS.color = 0xFFFFD700;
			case 22: VolDOWNF.color = 0xFFFFD700;
			case 23: VolDOWNS.color = 0xFFFFD700;
			case 24: DEBUGOF.color = 0xFFFFD700;
			case 25: DEBUGOS.color = 0xFFFFD700;
			case 26: DEBUGTF.color = 0xFFFFD700;
			case 27: DEBUGTS.color = 0xFFFFD700;
			case 28: RESETF.color = 0xFFFFD700;
			case 29: RESETS.color = 0xFFFFD700;
			case 30: ACCEPTF.color = 0xFFFFD700;
			case 31: ACCEPTS.color = 0xFFFFD700;
			case 32: BACKF.color = 0xFFFFD700;
			case 33: BACKS.color = 0xFFFFD700;
			case 34: PAUSEF.color = 0xFFFFD700;
			case 35: PAUSES.color = 0xFFFFD700;
		}
	}
	
	function changeBind(?bind:Bool = false)
	{
		if (bind) rebindingKey = true;
		if (bind) changing = true;
		if (rebindingKey && changing) {
			NoteLEFTF.color = 0xFF292929;
			NoteLEFTS.color = 0xFF292929;
			NoteDOWNF.color = 0xFF292929;
			NoteDOWNS.color = 0xFF292929;
			NoteUPF.color = 0xFF292929;
			NoteUPS.color = 0xFF292929;
			NoteRIGHTF.color = 0xFF292929;
			NoteRIGHTS.color = 0xFF292929;
			NoteSPECIALF.color = 0xFF292929;
			NoteSPECIALS.color = 0xFF292929;
			
			UILEFTF.color = 0xFF292929;
			UILEFTS.color = 0xFF292929;
			UIDOWNF.color = 0xFF292929;
			UIDOWNS.color = 0xFF292929;
			UIUPF.color = 0xFF292929;
			UIUPS.color = 0xFF292929;
			UIRIGHTF.color = 0xFF292929;
			UIRIGHTS.color = 0xFF292929;
					
			VolMUTEF.color = 0xFF292929;
			VolMUTES.color = 0xFF292929;
			VolUPF.color = 0xFF292929;
			VolUPS.color = 0xFF292929;
			VolDOWNF.color = 0xFF292929;
			VolDOWNS.color = 0xFF292929;
			DEBUGOF.color = 0xFF292929;
			DEBUGOS.color = 0xFF292929;
			DEBUGTF.color = 0xFF292929;
			DEBUGTS.color = 0xFF292929;
					
			RESETF.color = 0xFF292929;
			RESETS.color = 0xFF292929;
			ACCEPTF.color = 0xFF292929;
			ACCEPTS.color = 0xFF292929;
			BACKF.color = 0xFF292929;
			BACKS.color = 0xFF292929;
			PAUSEF.color = 0xFF292929;
			PAUSES.color = 0xFF292929;
			
			switch(curSelected) {
				case 0: NoteLEFTF.color = 0xFFFFD700;
				case 1: NoteLEFTS.color = 0xFFFFD700;
				case 2: NoteDOWNF.color = 0xFFFFD700;
				case 3: NoteDOWNS.color = 0xFFFFD700;
				case 4: NoteUPF.color = 0xFFFFD700;
				case 5: NoteUPS.color = 0xFFFFD700;
				case 6: NoteRIGHTF.color = 0xFFFFD700;
				case 7: NoteRIGHTS.color = 0xFFFFD700;
				case 8: NoteSPECIALF.color = 0xFFFFD700;
				case 9: NoteSPECIALS.color = 0xFFFFD700;
				case 10: UILEFTF.color = 0xFFFFD700;
				case 11: UILEFTS.color = 0xFFFFD700;
				case 12: UIDOWNF.color = 0xFFFFD700;
				case 13: UIDOWNS.color = 0xFFFFD700;
				case 14: UIUPF.color = 0xFFFFD700;
				case 15: UIUPS.color = 0xFFFFD700;
				case 16: UIRIGHTF.color = 0xFFFFD700;
				case 17: UIRIGHTS.color = 0xFFFFD700;
				case 18: VolMUTEF.color = 0xFFFFD700;
				case 19: VolMUTES.color = 0xFFFFD700;
				case 20: VolUPF.color = 0xFFFFD700;
				case 21: VolUPS.color = 0xFFFFD700;
				case 22: VolDOWNF.color = 0xFFFFD700;
				case 23: VolDOWNS.color = 0xFFFFD700;
				case 24: DEBUGOF.color = 0xFFFFD700;
				case 25: DEBUGOS.color = 0xFFFFD700;
				case 26: DEBUGTF.color = 0xFFFFD700;
				case 27: DEBUGTS.color = 0xFFFFD700;
				case 28: RESETF.color = 0xFFFFD700;
				case 29: RESETS.color = 0xFFFFD700;
				case 30: ACCEPTF.color = 0xFFFFD700;
				case 31: ACCEPTS.color = 0xFFFFD700;
				case 32: BACKF.color = 0xFFFFD700;
				case 33: BACKS.color = 0xFFFFD700;
				case 34: PAUSEF.color = 0xFFFFD700;
				case 35: PAUSES.color = 0xFFFFD700;
			}
			TimerOne = new FlxTimer().start(0.4, function(tmro:FlxTimer) {
				switch(curSelected) {
					case 0: NoteLEFTF.color = 0xFFB400FF;
					case 1: NoteLEFTS.color = 0xFFB400FF;
					case 2: NoteDOWNF.color = 0xFFB400FF;
					case 3: NoteDOWNS.color = 0xFFB400FF;
					case 4: NoteUPF.color = 0xFFB400FF;
					case 5: NoteUPS.color = 0xFFB400FF;
					case 6: NoteRIGHTF.color = 0xFFB400FF;
					case 7: NoteRIGHTS.color = 0xFFB400FF;
					case 8: NoteSPECIALF.color = 0xFFB400FF;
					case 9: NoteSPECIALS.color = 0xFFB400FF;
					case 10: UILEFTF.color = 0xFFB400FF;
					case 11: UILEFTS.color = 0xFFB400FF;
					case 12: UIDOWNF.color = 0xFFB400FF;
					case 13: UIDOWNS.color = 0xFFB400FF;
					case 14: UIUPF.color = 0xFFB400FF;
					case 15: UIUPS.color = 0xFFB400FF;
					case 16: UIRIGHTF.color = 0xFFB400FF;
					case 17: UIRIGHTS.color = 0xFFB400FF;
					case 18: VolMUTEF.color = 0xFFB400FF;
					case 19: VolMUTES.color = 0xFFB400FF;
					case 20: VolUPF.color = 0xFFB400FF;
					case 21: VolUPS.color = 0xFFB400FF;
					case 22: VolDOWNF.color = 0xFFB400FF;
					case 23: VolDOWNS.color = 0xFFB400FF;
					case 24: DEBUGOF.color = 0xFFB400FF;
					case 25: DEBUGOS.color = 0xFFB400FF;
					case 26: DEBUGTF.color = 0xFFB400FF;
					case 27: DEBUGTS.color = 0xFFB400FF;
					case 28: RESETF.color = 0xFFB400FF;
					case 29: RESETS.color = 0xFFB400FF;
					case 30: ACCEPTF.color = 0xFFB400FF;
					case 31: ACCEPTS.color = 0xFFB400FF;
					case 32: BACKF.color = 0xFFB400FF;
					case 33: BACKS.color = 0xFFB400FF;
					case 34: PAUSEF.color = 0xFFB400FF;
					case 35: PAUSES.color = 0xFFB400FF;
				}
				TimerTwo = new FlxTimer().start(0.4, function(tmrt:FlxTimer) {
					changeBind();
				});
			});
		} else {
			bind = false;
			rebindingKey = false;
			changing = false;
		}
	}
	
	function Reset(?fr:Bool = false, ?time = 1.5)
	{
		time = ResetTimer/2;
		fuckYou = true;
		if (fr) ResetNooo = true;
		if (ResetNooo) {
			NoteLEFTF.color = 0xFF3D0000;
			NoteLEFTS.color = 0xFF3D0000;
			NoteDOWNF.color = 0xFF3D0000;
			NoteDOWNS.color = 0xFF3D0000;
			NoteUPF.color = 0xFF3D0000;
			NoteUPS.color = 0xFF3D0000;
			NoteRIGHTF.color = 0xFF3D0000;
			NoteRIGHTS.color = 0xFF3D0000;
			NoteSPECIALF.color = 0xFF3D0000;
			NoteSPECIALS.color = 0xFF3D0000;
			
			UILEFTF.color = 0xFF3D0000;
			UILEFTS.color = 0xFF3D0000;
			UIDOWNF.color = 0xFF3D0000;
			UIDOWNS.color = 0xFF3D0000;
			UIUPF.color = 0xFF3D0000;
			UIUPS.color = 0xFF3D0000;
			UIRIGHTF.color = 0xFF3D0000;
			UIRIGHTS.color = 0xFF3D0000;
					
			VolMUTEF.color = 0xFF3D0000;
			VolMUTES.color = 0xFF3D0000;
			VolUPF.color = 0xFF3D0000;
			VolUPS.color = 0xFF3D0000;
			VolDOWNF.color = 0xFF3D0000;
			VolDOWNS.color = 0xFF3D0000;
			DEBUGOF.color = 0xFF3D0000;
			DEBUGOS.color = 0xFF3D0000;
			DEBUGTF.color = 0xFF3D0000;
			DEBUGTS.color = 0xFF3D0000;
					
			RESETF.color = 0xFF3D0000;
			RESETS.color = 0xFF3D0000;
			ACCEPTF.color = 0xFF3D0000;
			ACCEPTS.color = 0xFF3D0000;
			BACKF.color = 0xFF3D0000;
			BACKS.color = 0xFF3D0000;
			PAUSEF.color = 0xFF3D0000;
			PAUSES.color = 0xFF3D0000;
			
			TimerReset = new FlxTimer().start(time, function(tmrdo:FlxTimer) {
				ResetTimer -= 0.15;
				NoteLEFTF.color = 0xFFFF0000;
				NoteLEFTS.color = 0xFFFF0000;
				NoteDOWNF.color = 0xFFFF0000;
				NoteDOWNS.color = 0xFFFF0000;
				NoteUPF.color = 0xFFFF0000;
				NoteUPS.color = 0xFFFF0000;
				NoteRIGHTF.color = 0xFFFF0000;
				NoteRIGHTS.color = 0xFFFF0000;
				NoteSPECIALF.color = 0xFFFF0000;
				NoteSPECIALS.color = 0xFFFF0000;
				
				UILEFTF.color = 0xFFFF0000;
				UILEFTS.color = 0xFFFF0000;
				UIDOWNF.color = 0xFFFF0000;
				UIDOWNS.color = 0xFFFF0000;
				UIUPF.color = 0xFFFF0000;
				UIUPS.color = 0xFFFF0000;
				UIRIGHTF.color = 0xFFFF0000;
				UIRIGHTS.color = 0xFFFF0000;
						
				VolMUTEF.color = 0xFFFF0000;
				VolMUTES.color = 0xFFFF0000;
				VolUPF.color = 0xFFFF0000;
				VolUPS.color = 0xFFFF0000;
				VolDOWNF.color = 0xFFFF0000;
				VolDOWNS.color = 0xFFFF0000;
				DEBUGOF.color = 0xFFFF0000;
				DEBUGOS.color = 0xFFFF0000;
				DEBUGTF.color = 0xFFFF0000;
				DEBUGTS.color = 0xFFFF0000;
						
				RESETF.color = 0xFFFF0000;
				RESETS.color = 0xFFFF0000;
				ACCEPTF.color = 0xFFFF0000;
				ACCEPTS.color = 0xFFFF0000;
				BACKF.color = 0xFFFF0000;
				BACKS.color = 0xFFFF0000;
				PAUSEF.color = 0xFFFF0000;
				PAUSES.color = 0xFFFF0000;
				
				TimerTwo = new FlxTimer().start(time, function(tmrt:FlxTimer) { Reset(true); });
			});
		}
	}
	
	function TextUpd()
	{
		NoteLEFTF.text = '[ ' + ClientPrefs.keyBinds.get('note_left')[0] + ' ]';
		NoteLEFTS.text = '[ ' + ClientPrefs.keyBinds.get('note_left')[1] + ' ]';
		NoteDOWNF.text = '[ ' + ClientPrefs.keyBinds.get('note_down')[0] + ' ]';
		NoteDOWNS.text = '[ ' + ClientPrefs.keyBinds.get('note_down')[1] + ' ]';
		NoteUPF.text = '[ ' + ClientPrefs.keyBinds.get('note_up')[0] + ' ]';
		NoteUPS.text = '[ ' + ClientPrefs.keyBinds.get('note_up')[1] + ' ]';
		NoteRIGHTF.text = '[ ' + ClientPrefs.keyBinds.get('note_right')[0] + ' ]';
		NoteRIGHTS.text = '[ ' + ClientPrefs.keyBinds.get('note_right')[1] + ' ]';
		NoteSPECIALF.text = '[ ' + ClientPrefs.keyBinds.get('note_ring')[0] + ' ]';
		NoteSPECIALS.text = '[ ' + ClientPrefs.keyBinds.get('note_ring')[1] + ' ]';
		UILEFTF.text = '[ ' + ClientPrefs.keyBinds.get('ui_left')[0] + ' ]';
		UILEFTS.text = '[ ' + ClientPrefs.keyBinds.get('ui_left')[1] + ' ]';
		UIDOWNF.text = '[ ' + ClientPrefs.keyBinds.get('ui_down')[0] + ' ]';
		UIDOWNS.text = '[ ' + ClientPrefs.keyBinds.get('ui_down')[1] + ' ]';
		UIUPF.text = '[ ' + ClientPrefs.keyBinds.get('ui_up')[0] + ' ]';
		UIUPS.text = '[ ' + ClientPrefs.keyBinds.get('ui_up')[1] + ' ]';
		UIRIGHTF.text = '[ ' + ClientPrefs.keyBinds.get('ui_right')[0] + ' ]';
		UIRIGHTS.text = '[ ' + ClientPrefs.keyBinds.get('ui_right')[1] + ' ]';
		VolMUTEF.text = '[ ' + ClientPrefs.keyBinds.get('volume_mute')[0] + ' ]';
		VolMUTES.text = '[ ' + ClientPrefs.keyBinds.get('volume_mute')[1] + ' ]';
		VolUPF.text = '[ ' + ClientPrefs.keyBinds.get('volume_up')[0] + ' ]';
		VolUPS.text = '[ ' + ClientPrefs.keyBinds.get('volume_up')[1] + ' ]';
		VolDOWNF.text = '[ ' + ClientPrefs.keyBinds.get('volume_down')[0] + ' ]';
		VolDOWNS.text = '[ ' + ClientPrefs.keyBinds.get('volume_down')[1] + ' ]';
		DEBUGOF.text = '[ ' + ClientPrefs.keyBinds.get('debug_1')[0] + ' ]';
		DEBUGOS.text = '[ ' + ClientPrefs.keyBinds.get('debug_1')[1] + ' ]';
		DEBUGTF.text = '[ ' + ClientPrefs.keyBinds.get('debug_2')[0] + ' ]';
		DEBUGTS.text = '[ ' + ClientPrefs.keyBinds.get('debug_2')[1] + ' ]';
		RESETF.text = '[ ' + ClientPrefs.keyBinds.get('reset')[0] + ' ]';
		RESETS.text = '[ ' + ClientPrefs.keyBinds.get('reset')[1] + ' ]';
		ACCEPTF.text = '[ ' + ClientPrefs.keyBinds.get('accept')[0] + ' ]';
		ACCEPTS.text = '[ ' + ClientPrefs.keyBinds.get('accept')[1] + ' ]';
		BACKF.text = '[ ' + ClientPrefs.keyBinds.get('back')[0] + ' ]';
		BACKS.text = '[ ' + ClientPrefs.keyBinds.get('back')[1] + ' ]';
		PAUSEF.text = '[ ' + ClientPrefs.keyBinds.get('pause')[0] + ' ]';
		PAUSES.text = '[ ' + ClientPrefs.keyBinds.get('pause')[1] + ' ]';
	}
	
	function TimeOut()
	{
		box.alpha = 1;
		five.alpha = 1;
		four.alpha = 0;
		three.alpha = 0;
		two.alpha = 0;
		one.alpha = 0;
		zero.alpha = 0;
		ResTimeOut = true;
		if (FuckingTimerFIVE != null) FuckingTimerFIVE.cancel();
		if (FuckingTimerFOUR != null) FuckingTimerFOUR.cancel();
		if (FuckingTimerTHREE != null) FuckingTimerTHREE.cancel();
		if (FuckingTimerTWO != null) FuckingTimerTWO.cancel();
		if (FuckingTimerONE != null) FuckingTimerONE.cancel();
		if (FuckingTimerZERO != null) FuckingTimerZERO.cancel();
		
		FuckingTimerFIVE = new FlxTimer().start(1, function(fivet:FlxTimer)
		{
			five.alpha = 0;
			four.alpha = 1;
			FuckingTimerFOUR = new FlxTimer().start(1, function(fourt:FlxTimer)
			{
				four.alpha = 0;
				three.alpha = 1;
				FuckingTimerTHREE = new FlxTimer().start(1, function(threet:FlxTimer)
				{
					three.alpha = 0;
					two.alpha = 1;
					FuckingTimerTWO = new FlxTimer().start(1, function(twot:FlxTimer)
					{
						two.alpha = 0;
						one.alpha = 1;
						FuckingTimerONE = new FlxTimer().start(1, function(onet:FlxTimer)
						{
							one.alpha = 0;
							zero.alpha = 1;
							FuckingTimerZERO = new FlxTimer().start(1, function(zerot:FlxTimer)
							{
								box.alpha = 0;
								zero.alpha = 0;
								ResTimeOut = false;
							});
						});
					});
				});
			});
		});
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		bg.velocity.set(0, 50);
		FGup.velocity.set(-50, 0);
		FGdown.velocity.set(50, 0);
		TextUpd();
		
		if (!locked) {
			if (!rebindingKey) {
				if (!ResTimeOut) {
					if (FlxG.keys.justPressed.R)
					{
						fuckIt = true;
						if (!fuckYou) Reset(true);
						var counter = 0;
						FuckingTimer = new FlxTimer().start(0.825, function(rst:FlxTimer)
						{
							counter += 1;
							if (counter == 10) {
								ClientPrefs.keyBinds = ClientPrefs.defaultKeys.copy();
								TimerReset.cancel();
								if (fuckIt) Select(curSelected, false);
								ResetNooo = false;
								ResetTimer = 1.5;
								fuckYou = false;
								FuckingTimer.cancel();
								TimeOut();
							}
							if (FlxG.keys.pressed.R) FuckingTimer.reset();
						});
					} else {
						if (ResetNooo && FlxG.keys.justReleased.R) {
							if (TimerReset != null) TimerReset.cancel();
							if (TimerOne != null) TimerOne.cancel();
							if (TimerTwo != null) TimerTwo.cancel();
							ResetNooo = false;
							ResetTimer = 1.5;
							fuckYou = false;
							FuckingTimer.cancel();
							if (fuckIt) Select(curSelected, false);
							TimeOut();
						}
					}
				}
				if ((#if mobile FlxG.android.justReleased.BACK || #end controls.BACK || FlxG.mouse.justPressedRight) && !ResetNooo) {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					ClientPrefs.reloadControls();
					ClientPrefs.saveSettings();
					FlxTween.tween(blackScreen, {alpha: 1}, 0.25, {onComplete: function(twn:FlxTween) {
						MusicBeatState.switchState(new OptionsNewState());
					}});
					new FlxTimer().start(0.015, function(kkkk:FlxTimer) { locked = true; });
				}
				if (controls.UI_LEFT_P && !ResetNooo) {
					switch(curSelected) {
						case 1: Select(0);
						case 3: Select(2);
						case 5: Select(4);
						case 7: Select(6);
						case 9: Select(8);
						
						case 11: Select(10);
						case 13: Select(12);
						case 15: Select(14);
						case 17: Select(16);
						
						case 19: Select(18);
						case 21: Select(20);
						case 23: Select(22);
						case 25: Select(24);
						case 27: Select(26);
						
						case 29: Select(28);
						case 31: Select(30);
						case 33: Select(32);
						case 35: Select(34);
						
						case 10: Select(1);
						case 12: Select(3);
						case 14: Select(5);
						case 16: Select(7);
						
						case 28: Select(19);
						case 30: Select(21);
						case 32: Select(23);
						case 34: Select(25);
					}
				}
				if (controls.UI_DOWN_P && !ResetNooo) {
					switch(curSelected) {
						case 1: Select(3);
						case 3: Select(5);
						case 5: Select(7);
						case 7: Select(9);
						case 9: Select(19);
						case 19: Select(21);
						case 21: Select(23);
						case 23: Select(25);
						case 25: Select(27);
						
						case 0: Select(2);
						case 2: Select(4);
						case 4: Select(6);
						case 6: Select(8);
						case 8: Select(18);
						case 18: Select(20);
						case 20: Select(22);
						case 22: Select(24);
						case 24: Select(26);
						
						case 10: Select(12);
						case 12: Select(14);
						case 14: Select(16);
						case 16: Select(28);
						case 28: Select(30);
						case 30: Select(32);
						case 32: Select(34);
						
						case 11: Select(13);
						case 13: Select(15);
						case 15: Select(17);
						case 17: Select(29);
						case 29: Select(31);
						case 31: Select(33);
						case 33: Select(35);
					}
				}
				if (controls.UI_UP_P && !ResetNooo) {
					switch(curSelected) {
						case 3: Select(1);
						case 5: Select(3);
						case 7: Select(5);
						case 9: Select(7);
						case 19: Select(9);
						case 21: Select(19);
						case 23: Select(21);
						case 25: Select(23);
						case 27: Select(25);
						
						case 2: Select(0);
						case 4: Select(2);
						case 6: Select(4);
						case 8: Select(6);
						case 18: Select(8);
						case 20: Select(18);
						case 22: Select(20);
						case 24: Select(22);
						case 26: Select(24);
						
						case 12: Select(10);
						case 14: Select(12);
						case 16: Select(14);
						case 28: Select(16);
						case 30: Select(28);
						case 32: Select(30);
						case 34: Select(32);
						
						case 13: Select(11);
						case 15: Select(13);
						case 17: Select(15);
						case 29: Select(17);
						case 31: Select(29);
						case 33: Select(31);
						case 35: Select(33);
					}
				}
				if (controls.UI_RIGHT_P && !ResetNooo) {
					switch(curSelected) {
						case 0: Select(1);
						case 2: Select(3);
						case 4: Select(5);
						case 6: Select(7);
						case 8: Select(9);
						
						case 10: Select(11);
						case 12: Select(13);
						case 14: Select(15);
						case 16: Select(17);
						
						case 18: Select(19);
						case 20: Select(21);
						case 22: Select(23);
						case 24: Select(25);
						case 26: Select(27);
						
						case 28: Select(29);
						case 30: Select(31);
						case 32: Select(33);
						case 34: Select(35);
						
						case 1: Select(10);
						case 3: Select(12);
						case 5: Select(14);
						case 7: Select(16);
						case 9: Select(16);
						
						case 19: Select(28);
						case 21: Select(30);
						case 23: Select(32);
						case 25: Select(25);
						case 27: Select(34);
					}
				}
				if (controls.ACCEPT && !changing && !ResetNooo) changeBind(true);
			} else {
				switch(curSelected) {
					case 0: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('note_left')[1]];
					case 1: keyPressed = [ClientPrefs.keyBinds.get('note_left')[0], FlxG.keys.firstJustPressed()];
					case 2: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('note_down')[1]];
					case 3: keyPressed = [ClientPrefs.keyBinds.get('note_down')[0], FlxG.keys.firstJustPressed()];
					case 4: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('note_up')[1]];
					case 5: keyPressed = [ClientPrefs.keyBinds.get('note_up')[0], FlxG.keys.firstJustPressed()];
					case 6: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('note_right')[1]];
					case 7: keyPressed = [ClientPrefs.keyBinds.get('note_right')[0], FlxG.keys.firstJustPressed()];
					case 8: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('note_ring')[1]];
					case 9: keyPressed = [ClientPrefs.keyBinds.get('note_ring')[0], FlxG.keys.firstJustPressed()];
					case 10: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('ui_left')[1]];
					case 11: keyPressed = [ClientPrefs.keyBinds.get('ui_left')[0], FlxG.keys.firstJustPressed()];
					case 12: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('ui_down')[1]];
					case 13: keyPressed = [ClientPrefs.keyBinds.get('ui_down')[0], FlxG.keys.firstJustPressed()];
					case 14: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('ui_up')[1]];
					case 15: keyPressed = [ClientPrefs.keyBinds.get('ui_up')[0], FlxG.keys.firstJustPressed()];
					case 16: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('ui_right')[1]];
					case 17: keyPressed = [ClientPrefs.keyBinds.get('ui_right')[0], FlxG.keys.firstJustPressed()];
					case 18: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('volume_mute')[1]];
					case 19: keyPressed = [ClientPrefs.keyBinds.get('volume_mute')[0], FlxG.keys.firstJustPressed()];
					case 20: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('volume_up')[1]];
					case 21: keyPressed = [ClientPrefs.keyBinds.get('volume_up')[0], FlxG.keys.firstJustPressed()];
					case 22: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('volume_down')[1]];
					case 23: keyPressed = [ClientPrefs.keyBinds.get('volume_down')[0], FlxG.keys.firstJustPressed()];
					case 24: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('debug_1')[1]];
					case 25: keyPressed = [ClientPrefs.keyBinds.get('debug_1')[0], FlxG.keys.firstJustPressed()];
					case 26: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('debug_2')[1]];
					case 27: keyPressed = [ClientPrefs.keyBinds.get('debug_2')[0], FlxG.keys.firstJustPressed()];
					case 28: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('reset')[1]];
					case 29: keyPressed = [ClientPrefs.keyBinds.get('reset')[0], FlxG.keys.firstJustPressed()];
					case 30: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('accept')[1]];
					case 31: keyPressed = [ClientPrefs.keyBinds.get('accept')[0], FlxG.keys.firstJustPressed()];
					case 32: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('back')[1]];
					case 33: keyPressed = [ClientPrefs.keyBinds.get('back')[0], FlxG.keys.firstJustPressed()];
					case 34: keyPressed = [FlxG.keys.firstJustPressed(), ClientPrefs.keyBinds.get('pause')[1]];
					case 35: keyPressed = [ClientPrefs.keyBinds.get('pause')[0], FlxG.keys.firstJustPressed()];
				}
				
				keyP = FlxG.keys.firstJustPressed();
				if (keyP > -1) {
					switch(curSelected) {
						case 0: ClientPrefs.keyBinds.set('note_left', keyPressed);
						case 1: ClientPrefs.keyBinds.set('note_left', keyPressed);
						case 2: ClientPrefs.keyBinds.set('note_down', keyPressed);
						case 3: ClientPrefs.keyBinds.set('note_down', keyPressed);
						case 4: ClientPrefs.keyBinds.set('note_up', keyPressed);
						case 5: ClientPrefs.keyBinds.set('note_up', keyPressed);
						case 6: ClientPrefs.keyBinds.set('note_right', keyPressed);
						case 7: ClientPrefs.keyBinds.set('note_right', keyPressed);
						case 8: ClientPrefs.keyBinds.set('note_ring', keyPressed);
						case 9: ClientPrefs.keyBinds.set('note_ring', keyPressed);
						case 10: ClientPrefs.keyBinds.set('ui_left', keyPressed);
						case 11: ClientPrefs.keyBinds.set('ui_left', keyPressed);
						case 12: ClientPrefs.keyBinds.set('ui_down', keyPressed);
						case 13: ClientPrefs.keyBinds.set('ui_down', keyPressed);
						case 14: ClientPrefs.keyBinds.set('ui_up', keyPressed);
						case 15: ClientPrefs.keyBinds.set('ui_up', keyPressed);
						case 16: ClientPrefs.keyBinds.set('ui_right', keyPressed);
						case 17: ClientPrefs.keyBinds.set('ui_right', keyPressed);
						case 18: ClientPrefs.keyBinds.set('volume_mute', keyPressed);
						case 19: ClientPrefs.keyBinds.set('volume_mute', keyPressed);
						case 20: ClientPrefs.keyBinds.set('volume_up', keyPressed);
						case 21: ClientPrefs.keyBinds.set('volume_up', keyPressed);
						case 22: ClientPrefs.keyBinds.set('volume_down', keyPressed);
						case 23: ClientPrefs.keyBinds.set('volume_down', keyPressed);
						case 24: ClientPrefs.keyBinds.set('debug_1', keyPressed);
						case 25: ClientPrefs.keyBinds.set('debug_1', keyPressed);
						case 26: ClientPrefs.keyBinds.set('debug_2', keyPressed);
						case 27: ClientPrefs.keyBinds.set('debug_2', keyPressed);
						case 28: ClientPrefs.keyBinds.set('reset', keyPressed);
						case 29: ClientPrefs.keyBinds.set('reset', keyPressed);
						case 30: ClientPrefs.keyBinds.set('accept', keyPressed);
						case 31: ClientPrefs.keyBinds.set('accept', keyPressed);
						case 32: ClientPrefs.keyBinds.set('back', keyPressed);
						case 33: ClientPrefs.keyBinds.set('back', keyPressed);
						case 34: ClientPrefs.keyBinds.set('pause', keyPressed);
						case 35: ClientPrefs.keyBinds.set('pause', keyPressed);
					}
					if (TimerOne != null) TimerOne.cancel();
					if (TimerTwo != null) TimerTwo.cancel();
					Select(curSelected, false);
					keyPressed = [];
					keyP = -1;
					changing = false;
					rebindingKey = false;
				}
			}
		}
	}
}