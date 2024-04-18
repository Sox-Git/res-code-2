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
import flixel.addons.display.FlxBackdrop; 
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxObject;
import flixel.input.mouse.FlxMouseEventManager;
import openfl.display.BlendMode;
import lime.app.Application;
import flixel.math.FlxMath;
import shaders.ColorSwap;

class Shop extends MusicBeatState
{
	private var camGame:FlxCamera;
	var bg:FlxBackdrop;
	var vg:FlxSprite;
	
	var colorsArrowLeft:FlxSprite;
	var colorsArrowDown:FlxSprite;
	var colorsArrowUp:FlxSprite;
	var colorsArrowRight:FlxSprite;
	
	var TabType:FlxSprite;
	var TabChooseBg:FlxSprite;
	var rgbSelected:FlxSprite;
	var selectedGreenBox:FlxSprite;
	var TabChooseLine:FlxSprite;
	
	var ring:FlxSprite;
	var amountOfRings:FlxText;
	
	var TypeChooseArrow:FlxSprite;
	var TypeChooseArrowIcon:FlxSprite;
	var TypeChooseColor:FlxSprite;
	var TypeChooseColorIcon:FlxSprite;
	var TypeChooseSplash:FlxSprite;
	var TypeChooseSplashIcon:FlxSprite;
	
	var curArrowsSkin:FlxSprite;
	var curArrowsSplash:FlxSprite;
	
	var selectedType:Int = 0;
	var selectedArrowPage:Int = 0;
	var selectedColorTabLeft:Int = 0;
	var selectedColorTabDown:Int = 0;
	var selectedColorTabUp:Int = 0;
	var selectedColorTabRight:Int = 0;
	
	var selectTabHitbox1:FlxSprite;
	var selectTabHitbox2:FlxSprite;
	var selectTabHitbox3:FlxSprite;
	var selectTabHitbox4:FlxSprite;
	var selectTabHitbox5:FlxSprite;
	var selectTabHitbox6:FlxSprite;
	var selectTabHitbox7:FlxSprite;
	var selectTabHitbox8:FlxSprite;
	var selectTabHitbox9:FlxSprite;
	
	var curArrowsSkinArray:FlxTypedSpriteGroup<FlxSprite>;
	var curArrowsSplashArray:FlxTypedSpriteGroup<FlxSprite>;
	var arrowColorsSelectSprites:FlxTypedSpriteGroup<FlxSprite>;
	
	var arrowsSkinArray:FlxTypedSpriteGroup<FlxSprite>;
	var arrowsSplashArray:FlxTypedSpriteGroup<FlxSprite>;
	var arrowsColorsArrayLeft:FlxTypedSpriteGroup<FlxSprite>;
	var arrowsColorsArrayDown:FlxTypedSpriteGroup<FlxSprite>;
	var arrowsColorsArrayUp:FlxTypedSpriteGroup<FlxSprite>;
	var arrowsColorsArrayRight:FlxTypedSpriteGroup<FlxSprite>;
	var arrowsColorsArrayLocks:FlxTypedSpriteGroup<FlxSprite>;
	var priceTxtArrowArray:FlxTypedSpriteGroup<FlxSprite>;
	var priceTxtSplashArray:FlxTypedSpriteGroup<FlxSprite>;
	var priceTxtColorArray:FlxTypedSpriteGroup<FlxSprite>;
	var priceListArray:FlxTypedSpriteGroup<FlxSprite>;
	var pressedButtonLines:FlxTypedSpriteGroup<FlxSprite>;
	var rgbButton:FlxSprite;
	
	var colorSwap:ColorSwap;
	var colorSwapLeft:ColorSwap;
	var colorSwapDown:ColorSwap;
	var colorSwapUp:ColorSwap;
	var colorSwapRight:ColorSwap;
	
	var previewMode:FlxTypedSpriteGroup<FlxSprite>;
	var previewLine:FlxSprite;
	var previewColorBoxLeft:FlxSprite;
	var previewColorBoxDown:FlxSprite;
	var previewColorBoxUp:FlxSprite;
	var previewColorBoxRight:FlxSprite;
	var previewArrowLeft:FlxSprite;
	var previewArrowDown:FlxSprite;
	var previewArrowUp:FlxSprite;
	var previewArrowRight:FlxSprite;
	
	var minusAmountOfRings:FlxText;
	var minusRings:Int = 0;
	var lerpAmountRings:Int = 0;
	var intendedAmountRings:Int = ClientPrefs.RingsAmount;
	var ringsAmo:Int = ClientPrefs.RingsAmount;
	
	var dontTouchAnything:Bool = true;
	
	var arrowSkins:Array<String> = ['NOTE_assets', 'note-skins/crystal/NOTE_assets', 'note-skins/fire/NOTE_assets', 'note-skins/spiky/NOTE_assets', 'note-skins/shard/NOTE_assets'];
	var splashSkins:Array<String> = ['noteSplashes', 'splash-skins/diamond/noteSplashes', 'splash-skins/electric/noteSplashes', 'splash-skins/sparkles/noteSplashes'];
	var colorSkins:Array<Array<Array<Int>>> = [
		[[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]], 
		[[-123, 0, 50], [-30, -30, 0], [35, -20, 0], [-150, -15, 20]],
		[[180, 15, 0], [-75, 30, 0], [10, -25, 0], [120, -5, 0]], 
		null
	];
	
	var itemPrice:Map<String,Int> = [ 
		"1-arrow" => 1290,
		"2-arrow" => 1370,
		"3-arrow" => 1490,
		"4-arrow" => 1435,
		"1-splash" => 820,
		"2-splash" => 410,
		"3-splash" => 800,
		"1-color" => 300,
		"2-color" => 270,
		"3-color" => 330,
		"4-color" => 1700
	];

	override function create() { //Lets do Some Shit Code :)
		#if desktop
		var rpcName:String = 'In Shop Menu';
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
		colorSwap = new ColorSwap();
		colorSwapLeft = new ColorSwap();
		colorSwapDown = new ColorSwap();
		colorSwapUp = new ColorSwap();
		colorSwapRight = new ColorSwap();
		
		bg = new FlxBackdrop(Paths.image('shop/bg'), 1, 1, true, true);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.screenCenter();
		add(bg);
		
		vg = new FlxSprite(0,0).loadGraphic(Paths.image('shop/vg'));
		vg.antialiasing = ClientPrefs.globalAntialiasing;
		add(vg);
		
		priceListArray = new FlxTypedSpriteGroup<FlxSprite>();
		arrowColorsSelectSprites = new FlxTypedSpriteGroup<FlxSprite>();
		
		colorsArrowLeft = new FlxSprite(1203,95).loadGraphic(Paths.image('shop/pages/left'));
		colorsArrowLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowColorsSelectSprites.add(colorsArrowLeft);
		
		colorsArrowDown = new FlxSprite(1203,154).loadGraphic(Paths.image('shop/pages/down'));
		colorsArrowDown.antialiasing = ClientPrefs.globalAntialiasing;
		arrowColorsSelectSprites.add(colorsArrowDown);
		
		colorsArrowUp = new FlxSprite(1203,213).loadGraphic(Paths.image('shop/pages/up'));
		colorsArrowUp.antialiasing = ClientPrefs.globalAntialiasing;
		arrowColorsSelectSprites.add(colorsArrowUp);
		
		colorsArrowRight = new FlxSprite(1203,272).loadGraphic(Paths.image('shop/pages/right'));
		colorsArrowRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowColorsSelectSprites.add(colorsArrowRight);
		
		priceListArray.add(arrowColorsSelectSprites);
		
		TabChooseBg = new FlxSprite(0,0).loadGraphic(Paths.image('shop/tab-choose-bg'));
		TabChooseBg.antialiasing = ClientPrefs.globalAntialiasing;
		priceListArray.add(TabChooseBg);
		
		var RGBChooseX:Int = 0;
		var RGBChooseY:Int = 0;
		for (i in 0...colorSkins.length) {
			if (colorSkins[i] == null) {
				rgbSelected	= new FlxSprite(617+RGBChooseX,73+RGBChooseY).loadGraphic(Paths.image('shop/rgb-selected'));
				rgbSelected.antialiasing = ClientPrefs.globalAntialiasing;
				priceListArray.add(rgbSelected);
			}
			if (i == 2 || i == 5)
				RGBChooseX = 0;
			else
				RGBChooseX += 195;
			if (i == 2 || i == 5) RGBChooseY += 195;
		}
		
		selectedGreenBox = new FlxSprite(617,73).makeGraphic(187, 187, 0xFF003305);
		priceListArray.add(selectedGreenBox);
		
		TabChooseLine = new FlxSprite(0,0).loadGraphic(Paths.image('shop/tab-choose-line'));
		TabChooseLine.antialiasing = ClientPrefs.globalAntialiasing;
		priceListArray.add(TabChooseLine);
		
		arrowsSkinArray = new FlxTypedSpriteGroup<FlxSprite>();
		arrowsSplashArray = new FlxTypedSpriteGroup<FlxSprite>();
		arrowsColorsArrayLeft = new FlxTypedSpriteGroup<FlxSprite>();
		arrowsColorsArrayDown = new FlxTypedSpriteGroup<FlxSprite>();
		arrowsColorsArrayUp = new FlxTypedSpriteGroup<FlxSprite>();
		arrowsColorsArrayRight = new FlxTypedSpriteGroup<FlxSprite>();
		arrowsColorsArrayLocks = new FlxTypedSpriteGroup<FlxSprite>();
		priceTxtArrowArray = new FlxTypedSpriteGroup<FlxSprite>();
		priceTxtSplashArray = new FlxTypedSpriteGroup<FlxSprite>();
		priceTxtColorArray = new FlxTypedSpriteGroup<FlxSprite>();
		
		var arrowsChooseX:Int = 0;
		var arrowsChooseY:Int = 0;
		for (i in 0...arrowSkins.length) {
			var arrowsChoose:FlxSprite = new FlxSprite(630+arrowsChooseX, 87+arrowsChooseY);
			arrowsChoose.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[i], 'shared');
			arrowsChoose.animation.addByIndices('idle', 'arrowRIGHT', [0], "", 1, true);
			arrowsChoose.animation.play('idle', false);
			arrowsChoose.angle = -90;
			arrowsChoose.scale.x = 1;
			arrowsChoose.scale.y = 1;
			arrowsChoose.antialiasing = ClientPrefs.globalAntialiasing;
			arrowsSkinArray.add(arrowsChoose);
			if (i == 2 || i == 5)
				arrowsChooseX = 0;
			else
				arrowsChooseX += 195;
			if (i == 2 || i == 5) arrowsChooseY += 195;
		}
		
		var splashesChooseX:Int = 0;
		var splashesChooseY:Int = 0;
		for (i in 0...splashSkins.length) {
			var splashChoose:FlxSprite = new FlxSprite(540+splashesChooseX, 32+splashesChooseY);
			splashChoose.frames = Paths.getSparrowAtlas('arrows/' + splashSkins[i], 'shared');
			splashChoose.animation.addByIndices('idle', 'note splash red 1', [0], "", 1, true);
			splashChoose.animation.play('idle', false);
			splashChoose.angle = -90;
			splashChoose.scale.x = 0.7;
			splashChoose.scale.y = 0.7;
			splashChoose.antialiasing = ClientPrefs.globalAntialiasing;
			arrowsSplashArray.add(splashChoose);
			if (i == 2 || i == 5)
				splashesChooseX = 0;
			else
				splashesChooseX += 195;
			if (i == 2 || i == 5) splashesChooseY += 195;
		}
		
		var colorChooseX:Int = 0;
		var colorChooseY:Int = 0;
		for (i in 0...colorSkins.length) {
			if (colorSkins[i] != null) {
				for (col in 0...4) {
					var arrow:String = '';
					var arrowX:Int = 0;
					var arrowY:Int = 0;
					switch (col) {
						case 0:
							arrow = 'purple0';
							arrowX = 0;
							arrowY = 50;
						case 1:
							arrow = 'blue0';
							arrowX = 50;
							arrowY = 100;
						case 2:
							arrow = 'green0';
							arrowX = 50;
							arrowY = 0;
						case 3:
							arrow = 'red0';
							arrowX = 100;
							arrowY = 50;
					}
				
					var colChangeLeft:ColorSwap;
					colChangeLeft = new ColorSwap();
					var colorChooseLeft:FlxSprite = new FlxSprite(583+colorChooseX, 40+colorChooseY);
					colorChooseLeft.frames = Paths.getSparrowAtlas('arrows/NOTE_assets', 'shared');
					colorChooseLeft.animation.addByPrefix('idle', arrow, 24, false);
					colorChooseLeft.animation.play('idle', false);
					colorChooseLeft.scale.x = 0.45;
					colorChooseLeft.scale.y = 0.45;
					colorChooseLeft.antialiasing = ClientPrefs.globalAntialiasing;
					arrowsColorsArrayLeft.add(colorChooseLeft);
					colorChooseLeft.shader = colChangeLeft.shader;
					colChangeLeft.hue = colorSkins[i][col][0] / 360;
					if (col != 0) {
						colChangeLeft.saturation = -1;
						colChangeLeft.brightness = -0.5;
					} else {
						colChangeLeft.saturation = colorSkins[i][col][1] / 100;
						colChangeLeft.brightness = colorSkins[i][col][2] / 100;
					}
					colorChooseLeft.x += arrowX;
					colorChooseLeft.y += arrowY;
					
					var colChangeDown:ColorSwap;
					colChangeDown = new ColorSwap();
					var colorChooseDown:FlxSprite = new FlxSprite(583+colorChooseX, 40+colorChooseY);
					colorChooseDown.frames = Paths.getSparrowAtlas('arrows/NOTE_assets', 'shared');
					colorChooseDown.animation.addByPrefix('idle', arrow, 24, false);
					colorChooseDown.animation.play('idle', false);
					colorChooseDown.scale.x = 0.45;
					colorChooseDown.scale.y = 0.45;
					colorChooseDown.antialiasing = ClientPrefs.globalAntialiasing;
					arrowsColorsArrayDown.add(colorChooseDown);
					colorChooseDown.shader = colChangeDown.shader;
					colChangeDown.hue = colorSkins[i][col][0] / 360;
					if (col != 1) {
						colChangeDown.saturation = -1;
						colChangeDown.brightness = -0.5;
					} else {
						colChangeDown.saturation = colorSkins[i][col][1] / 100;
						colChangeDown.brightness = colorSkins[i][col][2] / 100;
					}
					colorChooseDown.x += arrowX;
					colorChooseDown.y += arrowY;
					
					var colChangeUp:ColorSwap;
					colChangeUp = new ColorSwap();
					var colorChooseUp:FlxSprite = new FlxSprite(583+colorChooseX, 40+colorChooseY);
					colorChooseUp.frames = Paths.getSparrowAtlas('arrows/NOTE_assets', 'shared');
					colorChooseUp.animation.addByPrefix('idle', arrow, 24, false);
					colorChooseUp.animation.play('idle', false);
					colorChooseUp.scale.x = 0.45;
					colorChooseUp.scale.y = 0.45;
					colorChooseUp.antialiasing = ClientPrefs.globalAntialiasing;
					arrowsColorsArrayUp.add(colorChooseUp);
					colorChooseUp.shader = colChangeUp.shader;
					colChangeUp.hue = colorSkins[i][col][0] / 360;
					if (col != 2) {
						colChangeUp.saturation = -1;
						colChangeUp.brightness = -0.5;
					} else {
						colChangeUp.saturation = colorSkins[i][col][1] / 100;
						colChangeUp.brightness = colorSkins[i][col][2] / 100;
					}
					colorChooseUp.x += arrowX;
					colorChooseUp.y += arrowY;
					
					var colChangeRight:ColorSwap;
					colChangeRight = new ColorSwap();
					var colorChooseRight:FlxSprite = new FlxSprite(583+colorChooseX, 40+colorChooseY);
					colorChooseRight.frames = Paths.getSparrowAtlas('arrows/NOTE_assets', 'shared');
					colorChooseRight.animation.addByPrefix('idle', arrow, 24, false);
					colorChooseRight.animation.play('idle', false);
					colorChooseRight.scale.x = 0.45;
					colorChooseRight.scale.y = 0.45;
					colorChooseRight.antialiasing = ClientPrefs.globalAntialiasing;
					arrowsColorsArrayRight.add(colorChooseRight);
					colorChooseRight.shader = colChangeRight.shader;
					colChangeRight.hue = colorSkins[i][col][0] / 360;
					if (col != 3) {
						colChangeRight.saturation = -1;
						colChangeRight.brightness = -0.5;
					} else {
						colChangeRight.saturation = colorSkins[i][col][1] / 100;
						colChangeRight.brightness = colorSkins[i][col][2] / 100;
					}
					colorChooseRight.x += arrowX;
					colorChooseRight.y += arrowY;
				}
			} else {
				rgbButton = new FlxSprite(617+colorChooseX,73+colorChooseY).loadGraphic(Paths.image('shop/rgb'));
				rgbButton.antialiasing = ClientPrefs.globalAntialiasing;
			}
			if (i == 2 || i == 5)
				colorChooseX = 0;
			else
				colorChooseX += 195;
			if (i == 2 || i == 5) colorChooseY += 195;
		}

		var lockedX:Int = 195;
		var lockedY:Int = 0;
		for (i in 0...8) {
			var lock:FlxSprite = new FlxSprite(617+lockedX,73+lockedY).loadGraphic(Paths.image('shop/locked'));
			lock.antialiasing = ClientPrefs.globalAntialiasing;
			lock.ID = i;
			lock.color = 0xFF7F7F7F;
			arrowsColorsArrayLocks.add(lock);
			
			var ring:FlxSprite = new FlxSprite(594+lockedX, 91+lockedY);
			ring.frames = Paths.getSparrowAtlas('shop/ring');
			ring.animation.addByPrefix('idle', 'idle', 20, true);
			ring.animation.addByIndices('idle', 'idle', [5], "", 1, true);
			ring.animation.play('idle', true);
			ring.scale.x = 0.14;
			ring.scale.y = 0.14;
			ring.antialiasing = ClientPrefs.globalAntialiasing;
			ring.ID = i;
			arrowsColorsArrayLocks.add(ring);
			
			if (i == 1 || i == 4)
				lockedX = 0;
			else
				lockedX += 195;
			if (i == 1 || i == 4) lockedY += 195;
		}
		
		var priceTextX:Int = 195;
		var priceTextY:Int = 0;
		for (i in 0...8) {
			var priceTxtArrow:FlxText = new FlxText(698+priceTextX, 176+priceTextY, FlxG.width, '', 5);
			priceTxtArrow.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 11, FlxColor.WHITE, LEFT);
			priceTxtArrow.antialiasing = ClientPrefs.globalAntialiasing;
			priceTxtArrow.ID = i;
			priceTxtArrowArray.add(priceTxtArrow);
			if (itemPrice.exists(i+1 + '-arrow'))
				priceTxtArrow.text = Std.string(itemPrice.get(i+1 + '-arrow'));
			else
				priceTxtArrow.text = Std.string(0);
				
			var priceTxtSplash:FlxText = new FlxText(698+priceTextX, 176+priceTextY, FlxG.width, '', 5);
			priceTxtSplash.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 11, FlxColor.WHITE, LEFT);
			priceTxtSplash.antialiasing = ClientPrefs.globalAntialiasing;
			priceTxtSplash.ID = i;
			priceTxtSplashArray.add(priceTxtSplash);
			if (itemPrice.exists(i+1 + '-splash'))
				priceTxtSplash.text = Std.string(itemPrice.get(i+1 + '-splash'));
			else
				priceTxtSplash.text = Std.string(0);
			
			var priceTxtColor:FlxText = new FlxText(698+priceTextX, 176+priceTextY, FlxG.width, '', 5);
			priceTxtColor.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 11, FlxColor.WHITE, LEFT);
			priceTxtColor.antialiasing = ClientPrefs.globalAntialiasing;
			priceTxtColor.ID = i;
			priceTxtColorArray.add(priceTxtColor);
			if (itemPrice.exists(i+1 + '-color'))
				priceTxtColor.text = Std.string(itemPrice.get(i+1 + '-color'));
			else
				priceTxtColor.text = Std.string(0);
			
			if (i == 1 || i == 4)
				priceTextX = 0;
			else
				priceTextX += 195;
			if (i == 1 || i == 4) priceTextY += 195;
		}
		
		priceListArray.add(arrowsSkinArray);
		priceListArray.add(arrowsSplashArray);
		arrowsSplashArray.alpha = 0;
		priceListArray.add(arrowsColorsArrayLeft);
		arrowsColorsArrayLeft.alpha = 0;
		priceListArray.add(arrowsColorsArrayDown);
		arrowsColorsArrayDown.alpha = 0;
		priceListArray.add(arrowsColorsArrayUp);
		arrowsColorsArrayUp.alpha = 0;
		priceListArray.add(arrowsColorsArrayRight);
		arrowsColorsArrayRight.alpha = 0;
		priceListArray.add(rgbButton);
		rgbButton.alpha = 0;
		priceListArray.add(arrowsColorsArrayLocks);
		priceListArray.add(priceTxtArrowArray);
		priceListArray.add(priceTxtSplashArray);
		priceTxtSplashArray.alpha = 0;
		priceListArray.add(priceTxtColorArray);
		priceTxtColorArray.alpha = 0;
		add(priceListArray);
		
		ring = new FlxSprite(-60, -30);
		ring.frames = Paths.getSparrowAtlas('shop/ring');
		ring.animation.addByPrefix('idle', 'idle', 20, true);
		ring.animation.play('idle', true);
		ring.scale.x = 0.33;
		ring.scale.y = 0.33;
		ring.antialiasing = ClientPrefs.globalAntialiasing;
		add(ring);
		
		amountOfRings = new FlxText(60, 44, FlxG.width, Std.string(intendedAmountRings), 20);
		amountOfRings.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 20, FlxColor.WHITE, LEFT);
		amountOfRings.antialiasing = ClientPrefs.globalAntialiasing;
		add(amountOfRings);
		
		minusAmountOfRings = new FlxText(-1115, 19, FlxG.width, '', 13);
		minusAmountOfRings.setFormat(Paths.font("sonic-cd-menu-font.ttf"), 13, FlxColor.WHITE, RIGHT);
		minusAmountOfRings.antialiasing = ClientPrefs.globalAntialiasing;
		add(minusAmountOfRings);
		
		TabType = new FlxSprite(0,0).loadGraphic(Paths.image('shop/tab-type'));
		TabType.antialiasing = ClientPrefs.globalAntialiasing;
		add(TabType);
		
		TypeChooseArrow = new FlxSprite(110,129).loadGraphic(Paths.image('shop/type'));
		TypeChooseArrow.antialiasing = ClientPrefs.globalAntialiasing;
		add(TypeChooseArrow);
		TypeChooseSplash = new FlxSprite(237,129).loadGraphic(Paths.image('shop/type'));
		TypeChooseSplash.antialiasing = ClientPrefs.globalAntialiasing;
		add(TypeChooseSplash);
		TypeChooseColor = new FlxSprite(364,129).loadGraphic(Paths.image('shop/type'));
		TypeChooseColor.antialiasing = ClientPrefs.globalAntialiasing;
		add(TypeChooseColor);
		
		TypeChooseArrowIcon = new FlxSprite(110,129).loadGraphic(Paths.image('shop/icons/arrow'));
		TypeChooseArrowIcon.antialiasing = ClientPrefs.globalAntialiasing;
		add(TypeChooseArrowIcon);
		TypeChooseSplashIcon = new FlxSprite(237,129).loadGraphic(Paths.image('shop/icons/splash'));
		TypeChooseSplashIcon.antialiasing = ClientPrefs.globalAntialiasing;
		add(TypeChooseSplashIcon);
		TypeChooseColorIcon = new FlxSprite(364,129).loadGraphic(Paths.image('shop/icons/colors'));
		TypeChooseColorIcon.antialiasing = ClientPrefs.globalAntialiasing;
		add(TypeChooseColorIcon);
		
		curArrowsSkinArray = new FlxTypedSpriteGroup<FlxSprite>();
		curArrowsSplashArray = new FlxTypedSpriteGroup<FlxSprite>();
		add(curArrowsSkinArray);
		add(curArrowsSplashArray);
		
		curArrowsSkin = new FlxSprite(190, 350);
		curArrowsSkin.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		curArrowsSkin.animation.addByIndices('0-idle', 'arrowLEFT', [0], "", 1, true);
		curArrowsSkin.animation.addByIndices('1-idle', 'arrowDOWN', [0], "", 1, true);
		curArrowsSkin.animation.addByIndices('2-idle', 'arrowUP', [0], "", 1, true);
		curArrowsSkin.animation.addByIndices('3-idle', 'arrowRIGHT', [0], "", 1, true);
		curArrowsSkin.animation.addByPrefix('0-pressed', 'left confirm', 24, false);
		curArrowsSkin.animation.addByPrefix('1-pressed', 'down confirm', 24, false);
		curArrowsSkin.animation.addByPrefix('2-pressed', 'up confirm', 24, false);
		curArrowsSkin.animation.addByPrefix('3-pressed', 'right confirm', 24, false);
		curArrowsSkin.animation.play(Std.string(selectedArrowPage) + '-idle', false);
		curArrowsSkin.scale.x = 1.3;
		curArrowsSkin.scale.y = 1.3;
		curArrowsSkin.antialiasing = ClientPrefs.globalAntialiasing;
		curArrowsSkinArray.add(curArrowsSkin);
		curArrowsSkin.shader = colorSwap.shader;
		
		curArrowsSplash = new FlxSprite(85, 242);
		curArrowsSplash.frames = Paths.getSparrowAtlas('arrows/' + splashSkins[ClientPrefs.arrowsSplashNum], 'shared');
		curArrowsSplash.animation.addByPrefix('0-pressed', 'note splash purple 1', 24, false);
		curArrowsSplash.animation.addByPrefix('1-pressed', 'note splash blue 1', 24, false);
		curArrowsSplash.animation.addByPrefix('2-pressed', 'note splash green 1', 24, false);
		curArrowsSplash.animation.addByPrefix('3-pressed', 'note splash red 1', 24, false);
		curArrowsSplash.animation.play(Std.string(selectedArrowPage) + '-pressed', false);
		curArrowsSplash.scale.x = 1.3;
		curArrowsSplash.scale.y = 1.3;
		curArrowsSplash.antialiasing = ClientPrefs.globalAntialiasing;
		curArrowsSplash.alpha = 0;
		curArrowsSplashArray.add(curArrowsSplash);
		curArrowsSplash.shader = colorSwap.shader;
		
		previewMode = new FlxTypedSpriteGroup<FlxSprite>();
		pressedButtonLines = new FlxTypedSpriteGroup<FlxSprite>();
		add(previewMode);
		
		previewColorBoxLeft = new FlxSprite(215,41).loadGraphic(Paths.image('shop/preview/left'));
		previewColorBoxLeft.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewColorBoxLeft);
		previewColorBoxLeft.shader = colorSwapLeft.shader;
		
		previewColorBoxDown = new FlxSprite(285,41).loadGraphic(Paths.image('shop/preview/down'));
		previewColorBoxDown.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewColorBoxDown);
		previewColorBoxDown.shader = colorSwapDown.shader;
		
		previewColorBoxUp = new FlxSprite(355,41).loadGraphic(Paths.image('shop/preview/up'));
		previewColorBoxUp.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewColorBoxUp);
		previewColorBoxUp.shader = colorSwapUp.shader;
		
		previewColorBoxRight = new FlxSprite(425,41).loadGraphic(Paths.image('shop/preview/right'));
		previewColorBoxRight.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewColorBoxRight);
		previewColorBoxRight.shader = colorSwapRight.shader;
		
		previewArrowLeft = new FlxSprite(195, 21);
		previewArrowLeft.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowLeft.animation.addByPrefix('idle', 'purple0', 24, false);
		previewArrowLeft.animation.play('idle', false);
		previewArrowLeft.scale.x = 0.4;
		previewArrowLeft.scale.y = 0.4;
		previewArrowLeft.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowLeft);
		previewArrowLeft.shader = colorSwapLeft.shader;
		
		previewArrowDown = new FlxSprite(265, 21);
		previewArrowDown.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowDown.animation.addByPrefix('idle', 'blue0', 24, false);
		previewArrowDown.animation.play('idle', false);
		previewArrowDown.scale.x = 0.4;
		previewArrowDown.scale.y = 0.4;
		previewArrowDown.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowDown);
		previewArrowDown.shader = colorSwapDown.shader;
		
		previewArrowUp = new FlxSprite(335, 21);
		previewArrowUp.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowUp.animation.addByPrefix('idle', 'green0', 24, false);
		previewArrowUp.animation.play('idle', false);
		previewArrowUp.scale.x = 0.4;
		previewArrowUp.scale.y = 0.4;
		previewArrowUp.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowUp);
		previewArrowUp.shader = colorSwapUp.shader;
		
		previewArrowRight = new FlxSprite(405, 21);
		previewArrowRight.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowRight.animation.addByPrefix('idle', 'red0', 24, false);
		previewArrowRight.animation.play('idle', false);
		previewArrowRight.scale.x = 0.4;
		previewArrowRight.scale.y = 0.4;
		previewArrowRight.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowRight);
		previewArrowRight.shader = colorSwapRight.shader;
		
		previewMode.add(pressedButtonLines);
		previewLine = new FlxSprite(208,34).loadGraphic(Paths.image('shop/preview/line'));
		previewLine.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewLine);
		
		selectTabHitbox1 = new FlxSprite(617,73).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox1);
		selectTabHitbox2 = new FlxSprite(812,73).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox2);
		selectTabHitbox3 = new FlxSprite(1007,73).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox3);
		selectTabHitbox4 = new FlxSprite(617,268).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox4);
		selectTabHitbox5 = new FlxSprite(812,268).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox5);
		selectTabHitbox6 = new FlxSprite(1007,268).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox6);
		selectTabHitbox7 = new FlxSprite(617,463).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox7);
		selectTabHitbox8 = new FlxSprite(812,463).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox8);
		selectTabHitbox9 = new FlxSprite(1007,463).makeGraphic(187, 187, 0x00000000);
		add(selectTabHitbox9);
		
		selectBoxes();
		selectSmth('tab');
		selectSmth('type');
		selectSmth('page');
		changeSkinAndSplash();
		mouseOverlapBuy(0);
		
		new FlxTimer().start(1.5, function(DONTPRESS:FlxTimer) {
			dontTouchAnything = false;
		});
		
		super.create();
	}
	function selectBoxes() {
		switch (selectedType) {
			case 0:
				TypeChooseArrow.color = 0xFF00FF00;
				TypeChooseSplash.color = 0xFFFF0000;
				TypeChooseColor.color = 0xFFFF0000;
			case 1:
				TypeChooseArrow.color = 0xFFFF0000;
				TypeChooseSplash.color = 0xFF00FF00;
				TypeChooseColor.color = 0xFFFF0000;
			case 2:
				TypeChooseArrow.color = 0xFFFF0000;
				TypeChooseSplash.color = 0xFFFF0000;
				TypeChooseColor.color = 0xFF00FF00;
		}
		if (selectedType == 2) {
			colorsArrowLeft.alpha = 1;
			colorsArrowDown.alpha = 1;
			colorsArrowUp.alpha = 1;
			colorsArrowRight.alpha = 1;
			switch (selectedArrowPage) {
				case 0:
					colorsArrowLeft.color = 0xFFFFFFFF;
					colorsArrowDown.color = 0xFF555555;
					colorsArrowUp.color = 0xFF555555;
					colorsArrowRight.color = 0xFF555555;
				case 1:
					colorsArrowLeft.color = 0xFF555555;
					colorsArrowDown.color = 0xFFFFFFFF;
					colorsArrowUp.color = 0xFF555555;
					colorsArrowRight.color = 0xFF555555;
				case 2:
					colorsArrowLeft.color = 0xFF555555;
					colorsArrowDown.color = 0xFF555555;
					colorsArrowUp.color = 0xFFFFFFFF;
					colorsArrowRight.color = 0xFF555555;
				case 3:
					colorsArrowLeft.color = 0xFF555555;
					colorsArrowDown.color = 0xFF555555;
					colorsArrowUp.color = 0xFF555555;
					colorsArrowRight.color = 0xFFFFFFFF;
			}
		} else {
			colorsArrowLeft.alpha = 0;
			colorsArrowDown.alpha = 0;
			colorsArrowUp.alpha = 0;
			colorsArrowRight.alpha = 0;
		}
		var selectedThing:Int = 0;
		switch (selectedType) {
			case 0: selectedThing = ClientPrefs.arrowsSkinNum;
			case 1: selectedThing = ClientPrefs.arrowsSplashNum;
			case 2:
				switch (selectedArrowPage) {
					case 0: selectedThing = ClientPrefs.arrowsColorNumLeft;
					case 1: selectedThing = ClientPrefs.arrowsColorNumDown;
					case 2: selectedThing = ClientPrefs.arrowsColorNumUp;
					case 3: selectedThing = ClientPrefs.arrowsColorNumRight;
				}
		}
		if (ClientPrefs.arrowColorsRGB && selectedType == 2)
			rgbSelected.alpha = 1;
		else
			rgbSelected.alpha = 0;
		switch (selectedThing) {
			case 0:
				selectedGreenBox.x = 617;
				selectedGreenBox.y = 73;
			case 1:
				selectedGreenBox.x = 812;
				selectedGreenBox.y = 73;
			case 2:
				selectedGreenBox.x = 1007;
				selectedGreenBox.y = 73;
			case 3:
				selectedGreenBox.x = 617;
				selectedGreenBox.y = 268;
			case 4:
				selectedGreenBox.x = 812;
				selectedGreenBox.y = 268;
			case 5:
				selectedGreenBox.x = 1007;
				selectedGreenBox.y = 268;
			case 6:
				selectedGreenBox.x = 617;
				selectedGreenBox.y = 463;
			case 7:
				selectedGreenBox.x = 812;
				selectedGreenBox.y = 463;
			case 8:
				selectedGreenBox.x = 1007;
				selectedGreenBox.y = 463;
		}
	}
	
	function selectSmth(whatItIs:String = '') {
		var curNumOfLength:Int = 0;
		switch (selectedType) {
			case 0: curNumOfLength = arrowSkins.length;
			case 1: curNumOfLength = splashSkins.length;
			case 2: curNumOfLength = colorSkins.length;
		}
		switch (whatItIs) {
			case 'tab':		
				var selectedTab:Int = 0;
				switch (selectedType) {
					case 0: selectedTab = ClientPrefs.arrowsSkinNum;
					case 1: selectedTab = ClientPrefs.arrowsSplashNum;
					case 2:
						switch (selectedArrowPage) {
							case 0: selectedTab = ClientPrefs.arrowsColorNumLeft;
							case 1: selectedTab = ClientPrefs.arrowsColorNumDown;
							case 2: selectedTab = ClientPrefs.arrowsColorNumUp;
							case 3: selectedTab = ClientPrefs.arrowsColorNumRight;
						}
				}
				if (!dontTouchAnything) {
					if (FlxG.mouse.overlaps(selectTabHitbox1) && curNumOfLength>0) selectedTab = 0;
					if (FlxG.mouse.overlaps(selectTabHitbox2) && curNumOfLength>1) selectedTab = 1;
					if (FlxG.mouse.overlaps(selectTabHitbox3) && curNumOfLength>2) selectedTab = 2;
					if (FlxG.mouse.overlaps(selectTabHitbox4) && curNumOfLength>3) selectedTab = 3;
					if (FlxG.mouse.overlaps(selectTabHitbox5) && curNumOfLength>4) selectedTab = 4;
					if (FlxG.mouse.overlaps(selectTabHitbox6) && curNumOfLength>5) selectedTab = 5;
					if (FlxG.mouse.overlaps(selectTabHitbox7) && curNumOfLength>6) selectedTab = 6;
					if (FlxG.mouse.overlaps(selectTabHitbox8) && curNumOfLength>7) selectedTab = 7;
					if (FlxG.mouse.overlaps(selectTabHitbox9) && curNumOfLength>8) selectedTab = 8;
				}
				switch (selectedType) {
					case 0:
						if (ClientPrefs.boughtSkin.contains(selectedTab) || selectedTab == 0) {
							ClientPrefs.arrowsSkinNum = selectedTab;
							ClientPrefs.arrowSkin = arrowSkins[selectedTab];
						} else {
							if (ClientPrefs.RingsAmount >= minusRings) {
								ClientPrefs.boughtSkin.push(selectedTab);
								ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
								ringsAmo = ringsAmo-minusRings;
							} else {
								FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
							}
						}
					case 1:
						if (ClientPrefs.boughtSplash.contains(selectedTab) || selectedTab == 0) {
							ClientPrefs.arrowsSplashNum = selectedTab;
							ClientPrefs.arrowSplash = splashSkins[selectedTab];
						} else {
							if (ClientPrefs.RingsAmount >= minusRings) {
								ClientPrefs.boughtSplash.push(selectedTab);
								ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
								ringsAmo = ringsAmo-minusRings;
							} else {
								FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
							}
						}

					case 2:
						switch (selectedArrowPage) {
							case 0:
								if (ClientPrefs.boughtColor.contains(selectedTab) || selectedTab == 0) {
									ClientPrefs.arrowsColorNumLeft = selectedTab;
									if (colorSkins[ClientPrefs.arrowsColorNumLeft] != null)
										ClientPrefs.arrowHSV[0] = colorSkins[ClientPrefs.arrowsColorNumLeft][0];
									else
										ClientPrefs.arrowColorsRGB = !ClientPrefs.arrowColorsRGB;
								} else {
									if (ClientPrefs.RingsAmount >= minusRings) {
										ClientPrefs.boughtColor.push(selectedTab);
										ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
										ringsAmo = ringsAmo-minusRings;
									} else {
										FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
									}
								}
							case 1:
								if (ClientPrefs.boughtColor.contains(selectedTab) || selectedTab == 0) {
									ClientPrefs.arrowsColorNumDown = selectedTab;
									if (colorSkins[ClientPrefs.arrowsColorNumDown] != null)
										ClientPrefs.arrowHSV[1] = colorSkins[ClientPrefs.arrowsColorNumDown][1];
									else
										ClientPrefs.arrowColorsRGB = !ClientPrefs.arrowColorsRGB;
								} else {
									if (ClientPrefs.RingsAmount >= minusRings) {
										ClientPrefs.boughtColor.push(selectedTab);
										ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
										ringsAmo = ringsAmo-minusRings;
									} else {
										FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
									}
								}
							case 2:
								if (ClientPrefs.boughtColor.contains(selectedTab) || selectedTab == 0) {
									ClientPrefs.arrowsColorNumUp = selectedTab;
									if (colorSkins[ClientPrefs.arrowsColorNumUp] != null)
										ClientPrefs.arrowHSV[2] = colorSkins[ClientPrefs.arrowsColorNumUp][2];
									else
										ClientPrefs.arrowColorsRGB = !ClientPrefs.arrowColorsRGB;
								} else {
									if (ClientPrefs.RingsAmount >= minusRings) {
										ClientPrefs.boughtColor.push(selectedTab);
										ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
										ringsAmo = ringsAmo-minusRings;
									} else {
										FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
									}
								}
							case 3:
								if (ClientPrefs.boughtColor.contains(selectedTab) || selectedTab == 0) {
									ClientPrefs.arrowsColorNumRight = selectedTab;
									if (colorSkins[ClientPrefs.arrowsColorNumRight] != null)
										ClientPrefs.arrowHSV[3] = colorSkins[ClientPrefs.arrowsColorNumRight][3];
									else
										ClientPrefs.arrowColorsRGB = !ClientPrefs.arrowColorsRGB;
								} else {
									if (ClientPrefs.RingsAmount >= minusRings) {
										ClientPrefs.boughtColor.push(selectedTab);
										ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
										ringsAmo = ringsAmo-minusRings;
									} else {
										FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
									}
								}
						}
				}
				
			case 'tab-rgb':		
				var selectedTab:Int = 0;
				if (!dontTouchAnything) {
					if (FlxG.mouse.overlaps(selectTabHitbox1) && colorSkins.length>0) selectedTab = 0;
					if (FlxG.mouse.overlaps(selectTabHitbox2) && colorSkins.length>1) selectedTab = 1;
					if (FlxG.mouse.overlaps(selectTabHitbox3) && colorSkins.length>2) selectedTab = 2;
					if (FlxG.mouse.overlaps(selectTabHitbox4) && colorSkins.length>3) selectedTab = 3;
					if (FlxG.mouse.overlaps(selectTabHitbox5) && colorSkins.length>4) selectedTab = 4;
					if (FlxG.mouse.overlaps(selectTabHitbox6) && colorSkins.length>5) selectedTab = 5;
					if (FlxG.mouse.overlaps(selectTabHitbox7) && colorSkins.length>6) selectedTab = 6;
					if (FlxG.mouse.overlaps(selectTabHitbox8) && colorSkins.length>7) selectedTab = 7;
					if (FlxG.mouse.overlaps(selectTabHitbox9) && colorSkins.length>8) selectedTab = 8;
				}
			
				if (ClientPrefs.boughtColor.contains(selectedTab)) {
					ClientPrefs.arrowColorsRGB = !ClientPrefs.arrowColorsRGB;
				} else {
					if (ClientPrefs.RingsAmount >= minusRings) {
						ClientPrefs.boughtColor.push(selectedTab);
						ClientPrefs.RingsAmount = ClientPrefs.RingsAmount-minusRings;
						ringsAmo = ringsAmo-minusRings;
					} else {
						FlxG.sound.play(Paths.sound('deniedMOMENT'), 0.4);
					}
				}
				
			case 'type':
				switch (selectedType) {
					case 0:
						arrowsSkinArray.alpha = 1;
						arrowsSplashArray.alpha = 0;
					case 1:
						arrowsSkinArray.alpha = 0;
						arrowsSplashArray.alpha = 1;
					case 2:
						arrowsSkinArray.alpha = 0;
						arrowsSplashArray.alpha = 0;
				}
					
			case 'page':
				if (!dontTouchAnything) {
					if (FlxG.mouse.overlaps(colorsArrowLeft)) selectedArrowPage = 0;
					if (FlxG.mouse.overlaps(colorsArrowDown)) selectedArrowPage = 1;
					if (FlxG.mouse.overlaps(colorsArrowUp)) selectedArrowPage = 2;
					if (FlxG.mouse.overlaps(colorsArrowRight)) selectedArrowPage = 3;
				}
		}
		ClientPrefs.saveSettings();
		changeSkinAndSplash();
	}
	
	function changeSkinAndSplash() {
		if (selectedType == 2) {
			rgbButton.alpha = 1;
			switch (selectedArrowPage) {
				case 0:
					arrowsColorsArrayLeft.alpha = 1;
					arrowsColorsArrayDown.alpha = 0;
					arrowsColorsArrayUp.alpha = 0;
					arrowsColorsArrayRight.alpha = 0;
				case 1:
					arrowsColorsArrayLeft.alpha = 0;
					arrowsColorsArrayDown.alpha = 1;
					arrowsColorsArrayUp.alpha = 0;
					arrowsColorsArrayRight.alpha = 0;
				case 2:
					arrowsColorsArrayLeft.alpha = 0;
					arrowsColorsArrayDown.alpha = 0;
					arrowsColorsArrayUp.alpha = 1;
					arrowsColorsArrayRight.alpha = 0;
				case 3:
					arrowsColorsArrayLeft.alpha = 0;
					arrowsColorsArrayDown.alpha = 0;
					arrowsColorsArrayUp.alpha = 0;
					arrowsColorsArrayRight.alpha = 1;
			}
		} else {
			rgbButton.alpha = 0;
			arrowsColorsArrayLeft.alpha = 0;
			arrowsColorsArrayDown.alpha = 0;
			arrowsColorsArrayUp.alpha = 0;
			arrowsColorsArrayRight.alpha = 0;
		}
	
		curArrowsSkin.destroy();
		curArrowsSkin = new FlxSprite(190, 350);
		curArrowsSkin.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		curArrowsSkin.animation.addByIndices('0-idle', 'arrowLEFT', [0], "", 1, true);
		curArrowsSkin.animation.addByIndices('1-idle', 'arrowDOWN', [0], "", 1, true);
		curArrowsSkin.animation.addByIndices('2-idle', 'arrowUP', [0], "", 1, true);
		curArrowsSkin.animation.addByIndices('3-idle', 'arrowRIGHT', [0], "", 1, true);
		curArrowsSkin.animation.addByPrefix('0-pressed', 'left confirm', 24, false);
		curArrowsSkin.animation.addByPrefix('1-pressed', 'down confirm', 24, false);
		curArrowsSkin.animation.addByPrefix('2-pressed', 'up confirm', 24, false);
		curArrowsSkin.animation.addByPrefix('3-pressed', 'right confirm', 24, false);
		curArrowsSkin.animation.play(Std.string(selectedArrowPage) + '-idle', false);
		curArrowsSkin.scale.x = 1.3;
		curArrowsSkin.scale.y = 1.3;
		curArrowsSkin.antialiasing = ClientPrefs.globalAntialiasing;
		curArrowsSkinArray.add(curArrowsSkin);
		curArrowsSkin.shader = colorSwap.shader;
			
		curArrowsSplash.destroy();
		curArrowsSplash = new FlxSprite(85, 242);
		curArrowsSplash.frames = Paths.getSparrowAtlas('arrows/' + splashSkins[ClientPrefs.arrowsSplashNum], 'shared');
		curArrowsSplash.animation.addByPrefix('0-pressed', 'note splash purple 1', 24, false);
		curArrowsSplash.animation.addByPrefix('1-pressed', 'note splash blue 1', 24, false);
		curArrowsSplash.animation.addByPrefix('2-pressed', 'note splash green 1', 24, false);
		curArrowsSplash.animation.addByPrefix('3-pressed', 'note splash red 1', 24, false);
		curArrowsSplash.animation.play(Std.string(selectedArrowPage) + '-pressed', false);
		curArrowsSplash.scale.x = 1.3;
		curArrowsSplash.scale.y = 1.3;
		curArrowsSplash.antialiasing = ClientPrefs.globalAntialiasing;
		curArrowsSplash.alpha = 0;
		curArrowsSplashArray.add(curArrowsSplash);
		curArrowsSplash.shader = colorSwap.shader;
		
		previewArrowLeft.destroy();
		previewArrowLeft = new FlxSprite(170, -3);
		previewArrowLeft.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowLeft.animation.addByPrefix('idle', 'purple0', 24, false);
		previewArrowLeft.animation.play('idle', false);
		previewArrowLeft.scale.x = 0.35;
		previewArrowLeft.scale.y = 0.35;
		previewArrowLeft.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowLeft);
		previewArrowLeft.shader = colorSwapLeft.shader;
		
		previewArrowDown.destroy();
		previewArrowDown = new FlxSprite(240, -3);
		previewArrowDown.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowDown.animation.addByPrefix('idle', 'blue0', 24, false);
		previewArrowDown.animation.play('idle', false);
		previewArrowDown.scale.x = 0.35;
		previewArrowDown.scale.y = 0.35;
		previewArrowDown.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowDown);
		previewArrowDown.shader = colorSwapDown.shader;
		
		previewArrowUp.destroy();
		previewArrowUp = new FlxSprite(310, -3);
		previewArrowUp.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowUp.animation.addByPrefix('idle', 'green0', 24, false);
		previewArrowUp.animation.play('idle', false);
		previewArrowUp.scale.x = 0.35;
		previewArrowUp.scale.y = 0.35;
		previewArrowUp.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowUp);
		previewArrowUp.shader = colorSwapUp.shader;
		
		previewArrowRight.destroy();
		previewArrowRight = new FlxSprite(380, -3);
		previewArrowRight.frames = Paths.getSparrowAtlas('arrows/' + arrowSkins[ClientPrefs.arrowsSkinNum], 'shared');
		previewArrowRight.animation.addByPrefix('idle', 'red0', 24, false);
		previewArrowRight.animation.play('idle', false);
		previewArrowRight.scale.x = 0.35;
		previewArrowRight.scale.y = 0.35;
		previewArrowRight.antialiasing = ClientPrefs.globalAntialiasing;
		previewMode.add(previewArrowRight);
		previewArrowRight.shader = colorSwapRight.shader;
	}
	
	function mouseOverlapBuy(elapsed:Float) {
		var selHitbox:Int = 0;
		var curNumOfLength:Int = 0;
		
		if (FlxG.mouse.overlaps(selectTabHitbox1)) selHitbox = 0;
		if (FlxG.mouse.overlaps(selectTabHitbox2)) selHitbox = 1;
		if (FlxG.mouse.overlaps(selectTabHitbox3)) selHitbox = 2;
		if (FlxG.mouse.overlaps(selectTabHitbox4)) selHitbox = 3;
		if (FlxG.mouse.overlaps(selectTabHitbox5)) selHitbox = 4;
		if (FlxG.mouse.overlaps(selectTabHitbox6)) selHitbox = 5;
		if (FlxG.mouse.overlaps(selectTabHitbox7)) selHitbox = 6;
		if (FlxG.mouse.overlaps(selectTabHitbox8)) selHitbox = 7;
		if (FlxG.mouse.overlaps(selectTabHitbox9)) selHitbox = 8;
		switch (selectedType) {
			case 0:
				if (itemPrice.exists(Std.string(selHitbox) + '-arrow'))
					minusRings = itemPrice.get(Std.string(selHitbox) + '-arrow');
				else
					minusRings = 0;
				curNumOfLength = arrowSkins.length;
				
				arrowsColorsArrayLocks.forEach(function(spr:FlxSprite) {
					if (spr.ID+1 < arrowSkins.length) {
						if (ClientPrefs.boughtSkin.contains(spr.ID+1))
							spr.alpha = 0;
						else
							spr.alpha = 1;
					} else {
						spr.alpha = 0;
					}
				});
			case 1:
				if (itemPrice.exists(Std.string(selHitbox) + '-splash'))
					minusRings = itemPrice.get(Std.string(selHitbox) + '-splash');
				else
					minusRings = 0;
				curNumOfLength = splashSkins.length;
				
				arrowsColorsArrayLocks.forEach(function(spr:FlxSprite) {
					if (spr.ID+1 < splashSkins.length) {
						if (ClientPrefs.boughtSplash.contains(spr.ID+1))
							spr.alpha = 0;
						else
							spr.alpha = 1;
					} else {
						spr.alpha = 0;
					}
				});
			case 2:
				if (itemPrice.exists(Std.string(selHitbox) + '-color'))
					minusRings = itemPrice.get(Std.string(selHitbox) + '-color');
				else
					minusRings = 0;
				curNumOfLength = colorSkins.length;
				
				arrowsColorsArrayLocks.forEach(function(spr:FlxSprite) {
					if (spr.ID+1 < colorSkins.length) {
						if (ClientPrefs.boughtColor.contains(spr.ID+1))
							spr.alpha = 0;
						else
							spr.alpha = 1;
					} else {
						spr.alpha = 0;
					}
				});
		}
		
		if (selHitbox > curNumOfLength-1 || selHitbox == 0) {
			minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 35, CoolUtil.boundTo(elapsed * 30, 0, 1));
			minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 0, CoolUtil.boundTo(elapsed * 30, 0, 1));
			intendedAmountRings = ClientPrefs.RingsAmount;
			amountOfRings.color = 0xFFFFFFFF;
		} else { 
			switch (selectedType) {
				case 0:
					if (ClientPrefs.boughtSkin.contains(selHitbox) || selHitbox == 0) {
						minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 35, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 0, CoolUtil.boundTo(elapsed * 30, 0, 1));
						intendedAmountRings = ClientPrefs.RingsAmount;
						amountOfRings.color = 0xFFFFFFFF;
					} else {
						minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 19, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 1, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.text = '-' + minusRings;
						intendedAmountRings = ringsAmo-minusRings;
						if (ClientPrefs.RingsAmount >= minusRings)
							amountOfRings.color = 0xFF3FFF3F;
						else
							amountOfRings.color = 0xFFFF3F3F;
					}
				case 1:
					if (ClientPrefs.boughtSplash.contains(selHitbox) || selHitbox == 0) {
						minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 35, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 0, CoolUtil.boundTo(elapsed * 30, 0, 1));
						intendedAmountRings = ClientPrefs.RingsAmount;
						amountOfRings.color = 0xFFFFFFFF;
					} else {
						minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 19, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 1, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.text = '-' + minusRings;
						intendedAmountRings = ringsAmo-minusRings;
						if (ClientPrefs.RingsAmount >= minusRings)
							amountOfRings.color = 0xFF3FFF3F;
						else
							amountOfRings.color = 0xFFFF3F3F;
					}
				case 2:
					if (ClientPrefs.boughtColor.contains(selHitbox) || selHitbox == 0) {
						minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 35, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 0, CoolUtil.boundTo(elapsed * 30, 0, 1));
						intendedAmountRings = ClientPrefs.RingsAmount;
						amountOfRings.color = 0xFFFFFFFF;
					} else {
						minusAmountOfRings.y = FlxMath.lerp(minusAmountOfRings.y, 19, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.alpha = FlxMath.lerp(minusAmountOfRings.alpha, 1, CoolUtil.boundTo(elapsed * 30, 0, 1));
						minusAmountOfRings.text = '-' + minusRings;
						intendedAmountRings = ringsAmo-minusRings;
						if (ClientPrefs.RingsAmount >= minusRings)
							amountOfRings.color = 0xFF3FFF3F;
						else
							amountOfRings.color = 0xFFFF3F3F;
					}
			}
		}
	}

	function pressLines(pressed:String = '') {
		switch (pressed) {
			case 'left':
				var leftTweenY:FlxTween;
				var pressedLeft:FlxSprite = new FlxSprite(217,94).makeGraphic(61, 10, 0xFFFF63CB);
				pressedButtonLines.add(pressedLeft);
				pressedLeft.shader = colorSwapLeft.shader;
				leftTweenY = FlxTween.tween(pressedLeft, {y: -100}, 0.35, {
					onComplete: function(tLeft:FlxTween) {
						pressedLeft.destroy();
					}
				});
			case 'down':
				var downTweenY:FlxTween;
				var pressedDown:FlxSprite = new FlxSprite(287,94).makeGraphic(61, 10, 0xFF00FFFF);
				pressedButtonLines.add(pressedDown);
				pressedDown.shader = colorSwapDown.shader;
				downTweenY = FlxTween.tween(pressedDown, {y: -100}, 0.35, {
					onComplete: function(tDown:FlxTween) {
						pressedDown.destroy();
					}
				});
			case 'up':
				var upTweenY:FlxTween;
				var pressedUp:FlxSprite = new FlxSprite(357,94).makeGraphic(61, 10, 0xFF12FA05);
				pressedButtonLines.add(pressedUp);
				pressedUp.shader = colorSwapUp.shader;
				upTweenY = FlxTween.tween(pressedUp, {y: -100}, 0.35, {
					onComplete: function(tUp:FlxTween) {
						pressedUp.destroy();
					}
				});
			case 'right':
				var rightTweenY:FlxTween;
				var pressedRight:FlxSprite = new FlxSprite(427,94).makeGraphic(61, 10, 0xFFFF3A41);
				pressedButtonLines.add(pressedRight);
				pressedRight.shader = colorSwapRight.shader;
				rightTweenY = FlxTween.tween(pressedRight, {y: -100}, 0.35, {
					onComplete: function(tRight:FlxTween) {
						pressedRight.destroy();
					}
				});
		}
	}
	
	var RGBval:Int = 0;
	override function update(elapsed:Float) {
		bg.velocity.set(-50, 50);
		selectBoxes();
		mouseOverlapBuy(elapsed);
		lerpAmountRings = Math.floor(FlxMath.lerp(lerpAmountRings, intendedAmountRings, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		if (ringsAmo == intendedAmountRings && lerpAmountRings != ringsAmo)
			lerpAmountRings = intendedAmountRings;
		amountOfRings.text = Std.string(lerpAmountRings);

		priceTxtArrowArray.forEach(function(spr:FlxSprite) {
			if (spr.ID+1 < arrowSkins.length && selectedType == 0) {
				if (ClientPrefs.boughtSkin.contains(spr.ID+1))
					spr.alpha = 0;
				else
					spr.alpha = 1;
			} else {
				spr.alpha = 0;
			}
		});
		priceTxtSplashArray.forEach(function(spr:FlxSprite) {
			if (spr.ID+1 < splashSkins.length && selectedType == 1) {
				if (ClientPrefs.boughtSplash.contains(spr.ID+1))
					spr.alpha = 0;
				else
					spr.alpha = 1;
			} else {
				spr.alpha = 0;
			}
		});
		priceTxtColorArray.forEach(function(spr:FlxSprite) {
			if (spr.ID+1 < colorSkins.length && selectedType == 2) {
				if (ClientPrefs.boughtColor.contains(spr.ID+1))
					spr.alpha = 0;
				else
					spr.alpha = 1;
			} else {
				spr.alpha = 0;
			}
		});
		if (!ClientPrefs.arrowColorsRGB) {
			colorSwapLeft.hue = ClientPrefs.arrowHSV[0 % 4][0] / 360;
			colorSwapLeft.saturation = ClientPrefs.arrowHSV[0 % 4][1] / 100;
			colorSwapLeft.brightness = ClientPrefs.arrowHSV[0 % 4][2] / 100;
			colorSwapDown.hue = ClientPrefs.arrowHSV[1 % 4][0] / 360;
			colorSwapDown.saturation = ClientPrefs.arrowHSV[1 % 4][1] / 100;
			colorSwapDown.brightness = ClientPrefs.arrowHSV[1 % 4][2] / 100;
			colorSwapUp.hue = ClientPrefs.arrowHSV[2 % 4][0] / 360;
			colorSwapUp.saturation = ClientPrefs.arrowHSV[2 % 4][1] / 100;
			colorSwapUp.brightness = ClientPrefs.arrowHSV[2 % 4][2] / 100;
			colorSwapRight.hue = ClientPrefs.arrowHSV[3 % 4][0] / 360;
			colorSwapRight.saturation = ClientPrefs.arrowHSV[3 % 4][1] / 100;
			colorSwapRight.brightness = ClientPrefs.arrowHSV[3 % 4][2] / 100;
			colorSwap.hue = ClientPrefs.arrowHSV[selectedArrowPage % 4][0] / 360;
			colorSwap.saturation = ClientPrefs.arrowHSV[selectedArrowPage % 4][1] / 100;
			colorSwap.brightness = ClientPrefs.arrowHSV[selectedArrowPage % 4][2] / 100;
		} else {
			if (RGBval < 360)
				RGBval += 1;
			else if (RGBval >= 360)
				RGBval = -360;
			
			colorSwapLeft.hue = RGBval / 360;
			colorSwapDown.hue = RGBval / 360;
			colorSwapUp.hue = RGBval / 360;
			colorSwapRight.hue = RGBval / 360;
			colorSwap.hue = RGBval / 360;

			colorSwapLeft.saturation = 0;
			colorSwapLeft.brightness = 0;
			colorSwapDown.saturation = 0;
			colorSwapDown.brightness = 0;
			colorSwapUp.saturation = 0;
			colorSwapUp.brightness = 0;
			colorSwapRight.saturation = 0;
			colorSwapRight.brightness = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		}
		
		if (!dontTouchAnything) {
			if (FlxG.mouse.overlaps(TypeChooseArrow) && FlxG.mouse.justPressed)
				selectedType = 0;
			if (FlxG.mouse.overlaps(TypeChooseSplash) && FlxG.mouse.justPressed)
				selectedType = 1;
			if (FlxG.mouse.overlaps(TypeChooseColor) && FlxG.mouse.justPressed)
				selectedType = 2;
		}
		if (selectedType == 2)
			arrowColorsSelectSprites.alpha = 1;
		else
			arrowColorsSelectSprites.alpha = 0;
			
		if (!dontTouchAnything) {
			if ((FlxG.mouse.overlaps(TypeChooseArrow) || FlxG.mouse.overlaps(TypeChooseColor) || FlxG.mouse.overlaps(TypeChooseSplash)) && FlxG.mouse.justPressed)
				selectSmth('type');
			if (FlxG.mouse.overlaps(rgbButton) && selectedType == 2 && FlxG.mouse.justPressed) {
				selectSmth('tab-rgb');
			} else {
				if ((FlxG.mouse.overlaps(selectTabHitbox1) || FlxG.mouse.overlaps(selectTabHitbox2) || FlxG.mouse.overlaps(selectTabHitbox3) || FlxG.mouse.overlaps(selectTabHitbox4) || FlxG.mouse.overlaps(selectTabHitbox5) || FlxG.mouse.overlaps(selectTabHitbox6) || FlxG.mouse.overlaps(selectTabHitbox7) || FlxG.mouse.overlaps(selectTabHitbox8) || FlxG.mouse.overlaps(selectTabHitbox9)) && FlxG.mouse.justPressed)
					selectSmth('tab');
			}
			if ((FlxG.mouse.overlaps(colorsArrowLeft) || FlxG.mouse.overlaps(colorsArrowDown) || FlxG.mouse.overlaps(colorsArrowUp) || FlxG.mouse.overlaps(colorsArrowRight)) && FlxG.mouse.justPressed && selectedType == 2)
				selectSmth('page');
			
			if (controls.NOTE_LEFT)
				pressLines('left');
			if (controls.NOTE_DOWN)
				pressLines('down');
			if (controls.NOTE_UP)
				pressLines('up');
			if (controls.NOTE_RIGHT)
				pressLines('right');
			
			if ((FlxG.mouse.overlaps(curArrowsSkin) && FlxG.mouse.justPressed) || controls.NOTE_LEFT_P || controls.NOTE_DOWN_P || controls.NOTE_UP_P || controls.NOTE_RIGHT_P) {
				if (controls.NOTE_LEFT_P)
					selectedArrowPage = 0;
				if (controls.NOTE_DOWN_P)
					selectedArrowPage = 1;
				if (controls.NOTE_UP_P)
					selectedArrowPage = 2;
				if (controls.NOTE_RIGHT_P)
					selectedArrowPage = 3;
				changeSkinAndSplash();
				switch (selectedArrowPage) {
					case 0:
						curArrowsSkin.x = 145;
						curArrowsSkin.y = 302;
					case 1:
						curArrowsSkin.x = 142;
						curArrowsSkin.y = 298;
					case 2:
						curArrowsSkin.x = 140;
						curArrowsSkin.y = 300;
					case 3:
						curArrowsSkin.x = 145;
						curArrowsSkin.y = 299;
				}
				curArrowsSplash.alpha = 1;
				curArrowsSplash.animation.play(Std.string(selectedArrowPage) + '-pressed', true);
				curArrowsSkin.animation.play(Std.string(selectedArrowPage) + '-pressed', true);
			} else {
				if (curArrowsSkin.animation.curAnim.name == Std.string(selectedArrowPage) + '-pressed' && curArrowsSkin.animation.curAnim.curFrame == curArrowsSkin.animation.curAnim.frames.length-1) {
					curArrowsSkin.x = 190;
					curArrowsSkin.y = 350;
					curArrowsSplash.alpha = 0;
					curArrowsSkin.animation.play(Std.string(selectedArrowPage) + '-idle', true);
				}
			}
			
			if (controls.BACK) {
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
				ClientPrefs.saveSettings();
				MusicBeatState.switchState(new MainMenuState());
				dontTouchAnything = true;
			}
		}
	
		super.update(elapsed);
	}
}