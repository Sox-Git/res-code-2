package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxState;
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
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop; 
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxObject;
import flixel.input.mouse.FlxMouseEventManager;
import openfl.display.BlendMode;
import lime.app.Application;
import flixel.math.FlxMath;

class Changelog extends MusicBeatState
{
	private var camGame:FlxCamera;
	var scrollBG:FlxBackdrop;
	var trianglesUP:FlxBackdrop;
	var trianglesDOWN:FlxBackdrop;
	
	var backplateInfo:FlxSprite;
	var backplate:FlxSprite;
	var descbg:FlxSprite;
	
	var verSel:Int = 0;
	var listScrolled:Int;
	
	var versions:Array<String> = [];
	var descOrChL:Array<String> = [];
	
	var thingGroup:FlxTypedSpriteGroup<FlxSprite>;
	var stickGroup:FlxTypedSpriteGroup<FlxSprite>;
	var verGroup:FlxTypedSpriteGroup<FlxSprite>;
	var newverGroup:FlxTypedSpriteGroup<FlxSprite>;
	var newverarrowsGroup:FlxTypedSpriteGroup<FlxSprite>;
	var versionsGroup:FlxTypedSpriteGroup<FlxSprite>;
	var descOrChLGroup:FlxTypedSpriteGroup<FlxSprite>;
	var verList:Array<FlxSprite> = [];
	
	var changelogSplash:FlxSprite;
	var descriptionSplash:FlxSprite;
	
	function isEven(value:Float) return value % 2 == 0;
	override function create() {
		#if desktop
		var rpcName:String = 'In Changelog Menu';
		if (TranslationLanguages.Text.exists(rpcName) && ClientPrefs.Language != 'English')
			rpcName = TranslationLanguages.Text[rpcName];
		DiscordClient.smallImageRpc = '';
		DiscordClient.imageRpc = 'icon';
		DiscordClient.changePresence(rpcName, null);
		#end
	
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];
		persistentUpdate = persistentDraw = true;
		super.create();
		
		FlxG.sound.playMusic(Paths.music('update-changelog'), 0);
		FlxG.sound.music.fadeIn(0.5, 0, 0.6);

		scrollBG = new FlxBackdrop(Paths.image('changelog/bg'), 1, 1, false, true);
		scrollBG.antialiasing = ClientPrefs.globalAntialiasing;
		scrollBG.screenCenter();
		add(scrollBG);
		
		trianglesUP = new FlxBackdrop(Paths.image('changelog/triangles-u'), 1, 1, true, false);
		trianglesUP.antialiasing = ClientPrefs.globalAntialiasing;
		add(trianglesUP);
		
		trianglesDOWN = new FlxBackdrop(Paths.image('changelog/triangles-d'), 1, 1, true, false);
		trianglesDOWN.antialiasing = ClientPrefs.globalAntialiasing;
		trianglesDOWN.y += 606;
		add(trianglesDOWN);
		
		descbg = new FlxSprite(523,101).makeGraphic(757, 625, 0xFF000000);
		descbg.alpha = 0;
		add(descbg);
		descOrChLGroup = new FlxTypedSpriteGroup<FlxSprite>();
		add(descOrChLGroup);
		
		backplate = new FlxSprite(0, 93).loadGraphic(Paths.image('changelog/backplate'));
		backplate.antialiasing = ClientPrefs.globalAntialiasing;
		backplate.scrollFactor.set();
		backplate.screenCenter(X);
		add(backplate);

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
		}
		info.request();
		
		thingGroup = new FlxTypedSpriteGroup<FlxSprite>();
		stickGroup = new FlxTypedSpriteGroup<FlxSprite>();
		verGroup = new FlxTypedSpriteGroup<FlxSprite>();
		newverarrowsGroup = new FlxTypedSpriteGroup<FlxSprite>();
		versionsGroup = new FlxTypedSpriteGroup<FlxSprite>();
		
		var yList:Int = 0;
		var ySelVer:Int = 0;
		var SelVerU:Bool = false;
		var verNotFound:Bool = false;
		var erasedSomeAndFound:Bool = false;
		var arrowsNewerDelay:Float = 0.0;
		for (i in 0...versions.length) {
			var thing = new FlxSprite(0,101+yList).makeGraphic(466, 71, 0xFFFF0000);
			if (isEven(i)) {
				thing.color = 0xFFCC2E2E;
				thing.blend = BlendMode.HARDLIGHT;
				thing.alpha = 0.25;
			} else {
				thing.color = 0xFF3D0E0E;
				thing.blend = BlendMode.DARKEN;
				thing.alpha = 0.2;
			}
			thing.screenCenter(X);
			thing.ID = i;
			FlxMouseEventManager.add(thing, null, null, verListMouse,null,false,true,false);
			verList.push(thing);
			thingGroup.add(thing);
		
			var stick = new FlxSprite(0,169+yList).makeGraphic(466, 9, 0xFF000000);
			stick.ID = i;
			stick.screenCenter(X);
			stickGroup.add(stick);
			
			var ver = new FlxText(0, 109+yList, FlxG.width, versions[i].split('<')[0]);
			ver.ID = i;
			ver.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 28, 0xFFFFFFFF, CENTER);
			ver.wordWrap = false;
			ver.autoSize = true;
			ver.screenCenter(X);
			ver.scrollFactor.set();
			verGroup.add(ver);
			
			var descChL = new FlxText(534, 113, 743, descOrChL[i].split('<')[0]);
			descChL.ID = i;
			descChL.setFormat(Paths.font("advanced.ttf"), 30, 0xFFFF0000, LEFT);
			descChL.scrollFactor.set();
			descChL.alpha = 0;
			descOrChLGroup.add(descChL);
			
			if (versions.contains('<' + Application.current.meta.get('version'))) {
				if (versions[i].split('<')[1] == Application.current.meta.get('version')) {
					SelVerU = true;
					verNotFound = false;
				}
			} else {
				if (!erasedSomeAndFound) {
					var vvvvv:String = Application.current.meta.get('version');
					for (x in 0...vvvvv.length) {
						if (vvvvv != versions[i].split('<')[1]) {
							trace('ver: ' + versions[i].split('<')[1] + ' != ' + vvvvv);
							if (vvvvv.length != 1) {
								vvvvv = vvvvv.substring(0, vvvvv.length - 1);
							} else {
								SelVerU = true;
								verNotFound = true;
							}
						} else {
							trace('found');
							ySelVer = yList;
							SelVerU = true;
							erasedSomeAndFound = true;
						}
					}
				}
			}
			
			if (versions[i].split('<')[1] > Application.current.meta.get('version')) {
				var arrow = new FlxSprite(0,94+yList).loadGraphic(Paths.image('changelog/new-ver'));
				arrow.antialiasing = ClientPrefs.globalAntialiasing;
				arrow.scrollFactor.set();
				arrow.screenCenter(X); 
				newverarrowsGroup.add(arrow);
				arrowsNewerDelay += 0.25;
			}
			
			if (!SelVerU) ySelVer += 77;
			yList += 77;
		}

		versionsGroup.add(thingGroup);
		versionsGroup.add(stickGroup);
		versionsGroup.add(verGroup);
		if (SelVerU) {
			if (verNotFound && Std.parseFloat(Application.current.meta.get('version')) >= Std.parseFloat(versions[versions.length-1].split('<')[1])) ySelVer = yList-77;
			if (verNotFound && Std.parseFloat(Application.current.meta.get('version')) <= 1.0) ySelVer = 0;
			var curVer = new FlxSprite(0, 85+ySelVer).loadGraphic(Paths.image('changelog/current-ver'));
			curVer.antialiasing = ClientPrefs.globalAntialiasing;
			curVer.scrollFactor.set();
			curVer.screenCenter(X);
			versionsGroup.add(curVer);
		}
		versionsGroup.add(newverarrowsGroup);
		add(versionsGroup);
		
		backplateInfo = new FlxSprite(0, 0).loadGraphic(Paths.image('changelog/update-info'));
		backplateInfo.antialiasing = ClientPrefs.globalAntialiasing;
		backplateInfo.scrollFactor.set();
		backplateInfo.screenCenter(X);
		add(backplateInfo);
		
		changelogSplash = new FlxSprite(985,0).loadGraphic(Paths.image('changelog/changelog'));
		changelogSplash.antialiasing = ClientPrefs.globalAntialiasing;
		changelogSplash.scrollFactor.set();
		changelogSplash.alpha = 0;
		add(changelogSplash);
		
		descriptionSplash = new FlxSprite(985,0).loadGraphic(Paths.image('changelog/description'));
		descriptionSplash.antialiasing = ClientPrefs.globalAntialiasing;
		descriptionSplash.scrollFactor.set();
		descriptionSplash.alpha = 0;
		add(descriptionSplash);
		
		selectVer(verSel);
	}

	function verListMouse(object:FlxObject) {
		if (object.ID != verSel && FlxG.mouse.overlaps(versionsGroup))
			selectVer(object.ID, true);
	}

	var doNotPressFast:Bool = false;
	var inDescOrCh:Bool = false;
	var holdTime:Float = 0;
	var yVarList = 0;
	override function update(elapsed:Float)
	{
		scrollBG.velocity.set(0, 35);
		trianglesUP.velocity.set(-35, 0);
		trianglesDOWN.velocity.set(35, 0);
		versionsGroup.y = FlxMath.lerp(versionsGroup.y, yVarList, CoolUtil.boundTo(elapsed * 12, 0, 1));
		
		if (!doNotPressFast) {
			for (i in 0...verList.length) {
				if ((verSel == i && FlxG.mouse.overlaps(verList[verSel])) && FlxG.mouse.overlaps(versionsGroup)) {
					if (FlxG.mouse.justReleased || FlxG.mouse.justPressedMiddle) {
						pressVer(verSel, true);
					}
				}
			}
			if (!FlxG.mouse.overlaps(versionsGroup)) {
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
				if (controls.UI_UP_P) {
					selectVer(-shiftMult);
					holdTime = 0;
				}
				if (controls.UI_DOWN_P) {
					selectVer(shiftMult);
					holdTime = 0;
				}
				if(controls.UI_DOWN || controls.UI_UP) {
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						selectVer((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
				}
				if(FlxG.mouse.wheel != 0) {
					selectVer(-shiftMult * FlxG.mouse.wheel);
					holdTime = 0;
				}
				if (FlxG.keys.justReleased.ENTER)
					pressVer(verSel, true);
			}
			if (controls.BACK || #if desktop FlxG.mouse.justPressedRight #else FlxG.android.justReleased.BACK #end) {
				if (inDescOrCh) {
					back();
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState());
				}
			}
		}
		
		super.update(elapsed);
	}
	
	function pressVer(sel:Int, mouse:Bool = false) {
		doNotPressFast = true;
		inDescOrCh = true;
		new FlxTimer().start(0.25, function(doNotPressFastTmr:FlxTimer) {doNotPressFast=false;});
		FlxTween.tween(versionsGroup, {x: -399}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(backplateInfo, {x: -25}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(backplate, {x: 0}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(descbg, {alpha: 0.7}, 0.25, {ease: FlxEase.quadInOut});
		if (descOrChL[sel].split('<')[1] == 'false') {
			FlxTween.tween(changelogSplash, {alpha: 1}, 0.25, {ease: FlxEase.quadInOut});
			FlxTween.tween(descriptionSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		} else {
			FlxTween.tween(changelogSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
			FlxTween.tween(descriptionSplash, {alpha: 1}, 0.25, {ease: FlxEase.quadInOut});
		}
		descOrChLGroup.forEach(function(spr:FlxSprite) {
			if (spr.ID == sel)
				FlxTween.tween(spr, {alpha: 1}, 0.25, {ease: FlxEase.quadInOut});
			else
				FlxTween.tween(spr, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		});
	}
	
	function back() {
		FlxG.sound.play(Paths.sound('cancelMenu'));
		doNotPressFast = true;
		inDescOrCh = false;
		new FlxTimer().start(0.25, function(backTmr:FlxTimer) {doNotPressFast=false;});
		FlxTween.tween(versionsGroup, {x: 0}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(backplateInfo, {x: 374}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(backplate, {x: 399}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(descbg, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(changelogSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		FlxTween.tween(descriptionSplash, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		descOrChLGroup.forEach(function(spr:FlxSprite) {
			FlxTween.tween(spr, {alpha: 0}, 0.25, {ease: FlxEase.quadInOut});
		});
	}
	
	function selectVer(verS:Int, mouse:Bool = false) {
		if (!mouse) {
			verSel += verS;
			if (verSel >= versions.length)
				verSel = 0;
			if (verSel < 0)
				verSel = versions.length-1;
		} else {
			if (verSel != verS) verSel = verS;
		}
		if (verSel <= versions.length-3 && versions.length > 7) {
			if (verSel > 5)
				yVarList = -77 * (verSel-5);
			else
				yVarList = 0;
		}
		thingGroup.forEach(function(spr:FlxSprite) {
			if (spr.ID == verSel) {
				spr.color = 0xFFFF0000;
				spr.blend = BlendMode.NORMAL;
				spr.alpha = 0.30;
			} else {
				if (isEven(spr.ID)) {
					spr.color = 0xFFCC2E2E;
					spr.blend = BlendMode.HARDLIGHT;
					spr.alpha = 0.10;
				} else {
					spr.color = 0xFF3D0E0E;
					spr.blend = BlendMode.MULTIPLY;
					spr.alpha = 0.15;
				}
			}
		});
		verGroup.forEach(function(spr:FlxSprite) {
			if (spr.ID == verSel) {
				spr.color = 0xFFFFFFFF;
				spr.alpha = 1;
			} else {
				spr.color = 0xFFFF5E5E;
				spr.alpha = 0.3;
			}
		});
	}
}