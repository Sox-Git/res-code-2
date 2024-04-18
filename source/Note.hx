package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flash.display.BitmapData;
import editors.ChartingState;
import shaders.ColorSwap;
import editors.*;

using StringTools;

typedef EventNote = {
	strumTime:Float,
	event:String,
	value1:String,
	value2:String
}

class Note extends FlxSprite
{
	public var row:Int = 0;
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var ignoreNote:Bool = false;
	public var hitByOpponent:Bool = false;
	public var noteWasHit:Bool = false;
	public var prevNote:Note;
	public var noteSkin:String = 'normal';

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noteType(default, set):String = null;

	public var eventName:String = '';
	public var eventLength:Int = 0;
	public var eventVal1:String = '';
	public var eventVal2:String = '';

	public var colorSwap:ColorSwap;
	public var inEditor:Bool = false;
	public var gfNote:Bool = false;
	public var lateHitMult:Float = 1;
	private var earlyHitMult:Float = 0.5;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	// Lua shit
	public var noteSplashDisabled:Bool = false;
	public var noteSplashTexture:String = null;
	public var noteSplashHue:Float = 0;
	public var noteSplashSat:Float = 0;
	public var noteSplashBrt:Float = 0;

	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var offsetAngle:Float = 0;
	public var multAlpha:Float = 1;

	public var copyX:Bool = true;
	public var copyY:Bool = true;
	public var copyAngle:Bool = true;
	public var copyAlpha:Bool = true;

	public var hitHealth:Float = 0.023;
	public var missHealth:Float = 0.0475;
	public var rating:String = 'unknown';
	public var ratingMod:Float = 0; //9 = unknown, 0.25 = shit, 0.5 = bad, 0.75 = good, 1 = sick
	public var ratingDisabled:Bool = false;

	public var texture(default, set):String = null;

	public var noAnimation:Bool = false;
	public var hitCausesMiss:Bool = false;
	public var distance:Float = 2000; //plan on doing scroll directions soon -bb

	public var hitsoundDisabled:Bool = false;
	public var isRing:Bool = PlayState.SONG.isRing;

	private function set_texture(value:String) {
		texture = value;
		reloadNote(value);
		return value;
	}

	private function set_noteType(value:String):String {
		noteSplashTexture = PlayState.SONG.splashSkin;

		if(noteData > -1 && noteType != value) {
			switch(value) {
				case 'Hurt Note':
					ignoreNote = true;
					if (PlayState.instance.noteChangesFromTheStore)
						reloadNote('arrows/'+ClientPrefs.arrowSkin+'-HURT');
					else
						reloadNote('arrows/NOTE_assets-HURT');
					noteSplashTexture = 'HURTnoteSplashes';
					if(isSustainNote)
						missHealth = 0.1;
					else
						missHealth = 0.3;
					hitCausesMiss = true;
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
					
				case 'No Animation':
					if (PlayState.SONG.arrowSkin == 'PIXELNOTE_assets' || PlayState.instance.pixelNoteGenesis || PlayState.isPixelStage)
						reloadNote('PIXELNOTE_assets');
					noAnimation = true;
					
				case 'GF Sing':
					if (PlayState.SONG.arrowSkin == 'PIXELNOTE_assets' || PlayState.instance.pixelNoteGenesis || PlayState.isPixelStage)
						reloadNote('PIXELNOTE_assets');
					gfNote = true;
					
				case 'GF and BF':
					if (PlayState.SONG.arrowSkin == 'PIXELNOTE_assets' || PlayState.instance.pixelNoteGenesis || PlayState.isPixelStage)
						reloadNote('PIXELNOTE_assets');
					
				case 'GF and Dad':
					if (PlayState.SONG.arrowSkin == 'PIXELNOTE_assets' || PlayState.instance.pixelNoteGenesis || PlayState.isPixelStage)
						reloadNote('PIXELNOTE_assets');
					
				case 'Phantom Note':
					if (PlayState.instance.noteChangesFromTheStore)
						reloadNote('arrows/'+ClientPrefs.arrowSkin+'-PHANTOM');
					else
						reloadNote('arrows/NOTE_assets-PHANTOM');
					hitCausesMiss = true;
					ignoreNote = true;
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;

					
				case 'Static Note':
					if (PlayState.instance.noteChangesFromTheStore)
						reloadNote('arrows/'+ClientPrefs.arrowSkin+'-STATIC');
					else
						reloadNote('arrows/NOTE_assets-STATIC');
					hitCausesMiss = false;
					ignoreNote = false;
					if(isSustainNote) {
						missHealth = 0.05;
					} else {
						missHealth = 0.2;
					}
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;

					
				case 'Hex Note':
					if (PlayState.instance.noteChangesFromTheStore)
						reloadNote('arrows/'+ClientPrefs.arrowSkin+'-HEX');
					else
						reloadNote('arrows/NOTE_assets-HEX');
					hitCausesMiss = true;
					ignoreNote = true;
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;

					
				case 'Pixel Note':
					reloadNote('PIXELNOTE_assets');
					
				case 'Fatal Note':
					reloadNote('fatal-notes');
					hitCausesMiss = true;
					ignoreNote = true;
					missHealth = 0.3;
					offsetX -= 50;
					offsetY -= 60;
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;

			}
			noteType = value;
		}
		noteSplashHue = colorSwap.hue;
		noteSplashSat = colorSwap.saturation;
		noteSplashBrt = colorSwap.brightness;
		return value;
	}

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?inEditor:Bool = false, ?noteSkin:String = '')
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;
		this.inEditor = inEditor;
		this.noteSkin = noteSkin;

		x += (ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) + 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;
		if(!inEditor) this.strumTime += ClientPrefs.noteOffset;

		this.noteData = noteData;
		if(noteData > -1) {
			colorSwap = new ColorSwap();
			if (noteSkin != 'sunky') {
				if (PlayState.instance.noteChangesFromTheStore) {
					if (!ClientPrefs.arrowColorsRGB)
						shader = colorSwap.shader;
					else
						shader = PlayState.instance.rgbColorSwap.shader;
				} else {
					shader = colorSwap.shader;
				}
			} else {
				shader = colorSwap.shader;
			}
			texture = '';

			if(!isSustainNote) {
				var animToPlay:String = '';
				switch (noteData)
				{
					case 0:
						x += swagWidth * 0;
						animToPlay = 'purple';
					case 1:
						x += swagWidth * 1;
						animToPlay = 'blue';
					case 2:
						if (isRing) {
							x += swagWidth * 2;
							animToPlay = 'gold';
						} else {
							x += swagWidth * 2;
							animToPlay = 'green';
						}
					case 3:
						if (isRing) {
							x += swagWidth * 3;
							animToPlay = 'green';
						} else {
							x += swagWidth * 3;
							animToPlay = 'red';
						}
					case 4:
						if(isRing) {
							x += swagWidth * 4;
							animToPlay = 'red';
						}			
				}
				animation.play(animToPlay + 'Scroll');
			}
		}

		if (isSustainNote && prevNote != null) {
			alpha = 0.6;
			multAlpha = 0.6;
			hitsoundDisabled = true;
			if(ClientPrefs.downScroll && !PlayState.instance.offDownScroll) flipY = true;

			offsetX += width / 2;
			copyAngle = false;

			if (!isRing) {
				switch (noteData) {
					case 0:
						animation.play('purpleholdend');
					case 1:
						animation.play('blueholdend');
					case 2:
						animation.play('greenholdend');
					case 3:
						animation.play('redholdend');
				}
			} else {
				switch (noteData) {
					case 0:
						animation.play('purpleholdend');
					case 1:
						animation.play('blueholdend');
					case 2:
						animation.play('goldholdend');
					case 3:
						animation.play('greenholdend');
					case 4:
						animation.play('redholdend');
				}
			}
			updateHitbox();

			offsetX -= width / 2;

			if (PlayState.isPixelStage) offsetX += 30;

			if (prevNote.isSustainNote) {
				if (!isRing) {
					switch (prevNote.noteData) {
						case 0:
							prevNote.animation.play('purplehold');
						case 1:
							prevNote.animation.play('bluehold');
						case 2:
							prevNote.animation.play('greenhold');
						case 3:
							prevNote.animation.play('redhold');
					}
				} else {
					switch (prevNote.noteData) {
						case 0:
							prevNote.animation.play('purplehold');
						case 1:
							prevNote.animation.play('bluehold');
						case 2:
							prevNote.animation.play('goldhold');
						case 3:
							prevNote.animation.play('greenhold');
						case 4:
							prevNote.animation.play('redhold');
					}
				}
				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.05;
				if(PlayState.instance != null)
					prevNote.scale.y *= PlayState.instance.songSpeed;

				if(PlayState.isPixelStage) {
					prevNote.scale.y *= 1.19;
					prevNote.scale.y *= (6 / height); //Auto adjust note size
				}
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}


			if(PlayState.isPixelStage) {
				scale.y *= PlayState.daPixelZoom;
				updateHitbox();
			}
		} else if(!isSustainNote) {
			earlyHitMult = 1;
		}
		x += offsetX;
	}
	var lastNoteOffsetXForPixelAutoAdjusting:Float = 0;
	var lastNoteScaleToo:Float = 1;
	public var originalHeightForCalcs:Float = 6;
	function reloadNote(?sprite:String = '') {
		if(sprite == null) sprite = '';
		var skin:String = sprite;
		if(sprite.length < 1) {
			skin = PlayState.SONG.arrowSkin;
			if(skin == null || skin.length < 1) {
				var def:String='';
				var pref:String='';
				if (PlayState.instance.customNoteColors) pref = '-COLOR';
				
				if (!PlayState.instance.pixelNoteGenesis) {
					if (!PlayState.isPixelStage) {
						if (PlayState.instance.noteChangesFromTheStore)
							def = 'arrows/'+ClientPrefs.arrowSkin+pref;
						else
							def = 'arrows/NOTE_assets'+pref;
					} else {
						def = 'NOTE_assets';
					}
				} else {
					def = 'PIXELNOTE_assets';
				}
				
				skin = def;
				switch (noteSkin) {
                    case 'fatal':
                        skin = 'fatal';
                    case 'week6':
                        skin = 'week6';
                    case 'pixel':
                        skin = 'PIXELNOTE_assets';
					case 'sunky':
						skin = 'NOTE_SUNKEH';
				}
			}
		}

		var animName:String = null;
		if(animation.curAnim != null)
			animName = animation.curAnim.name;
			
		//trace('Note texture: '+texture+' | Note sprite: '+sprite+' | Note skin: '+skin);
		var lastScaleY:Float = scale.y;
		if(PlayState.isPixelStage) {
			if (sprite != 'fatal-notes') {
				if(isSustainNote) {
					loadGraphic(Paths.image('pixelUI/' + skin + 'ENDS'));
					width = width / 4;
					height = height / 2;
					originalHeightForCalcs = height;
					loadGraphic(Paths.image('pixelUI/' + skin + 'ENDS'), true, Math.floor(width), Math.floor(height));
				} else {
					loadGraphic(Paths.image('pixelUI/' + skin));
					width = width / 4;
					height = height / 5;
					loadGraphic(Paths.image('pixelUI/' + skin), true, Math.floor(width), Math.floor(height));
				}
				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				loadPixelNoteAnims();
				antialiasing = false;

				if(isSustainNote) {
					offsetX += lastNoteOffsetXForPixelAutoAdjusting;
					lastNoteOffsetXForPixelAutoAdjusting = (width - 7) * (PlayState.daPixelZoom / 2);
					offsetX -= lastNoteOffsetXForPixelAutoAdjusting;
				}
			} else {
				setGraphicSize(Std.int(PlayState.daPixelZoom));
				frames = Paths.getSparrowAtlas(skin);
				loadNoteAnims();
				antialiasing = false;
			}
		} else {
			frames = Paths.getSparrowAtlas(skin);
			loadNoteAnims();
			antialiasing = ClientPrefs.globalAntialiasing;
		}
		if(isSustainNote) {
			scale.y = lastScaleY;
		}
		updateHitbox();

		if(animName != null)
			animation.play(animName, true);

		if(inEditor) {
			setGraphicSize(ChartingState.GRID_SIZE, ChartingState.GRID_SIZE);
			updateHitbox();
		}
		switch (noteType) {
			case 'Hurt Note', 'Phantom Note', 'Static Note', 'Hex Note', 'Fatal Note':
			default:
				if (PlayState.instance.customNoteColors) {
					if (!ClientPrefs.arrowColorsRGB) {
						colorSwap.hue = PlayState.instance.customArrowColors[noteData % 4][0] / 360;
						colorSwap.saturation = PlayState.instance.customArrowColors[noteData % 4][1] / 100;
						colorSwap.brightness = PlayState.instance.customArrowColors[noteData % 4][2] / 100;
					}
				} else {
					if (PlayState.instance.noteChangesFromTheStore) {
						if (!ClientPrefs.arrowColorsRGB) {
							if (noteSkin != 'sunky') {
								colorSwap.hue = ClientPrefs.arrowHSV[noteData % 4][0] / 360;
								colorSwap.saturation = ClientPrefs.arrowHSV[noteData % 4][1] / 100;
								colorSwap.brightness = ClientPrefs.arrowHSV[noteData % 4][2] / 100;
							} else {
								colorSwap.hue = 0;
								colorSwap.saturation = 0;
								colorSwap.brightness = 0;
							}
						}
					} else {
						colorSwap.hue = 0;
						colorSwap.saturation = 0;
						colorSwap.brightness = 0;
					}
				}
		}
	}
	function loadNoteAnims() {
		animation.addByPrefix('greenScroll', 'green0');
		animation.addByPrefix('redScroll', 'red0');
		animation.addByPrefix('blueScroll', 'blue0');
		animation.addByPrefix('purpleScroll', 'purple0');
		if (isRing) animation.addByPrefix('goldScroll', 'gold0');

		if (isSustainNote) {
			animation.addByPrefix('purpleholdend', 'pruple end hold');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');
			if (isRing) animation.addByPrefix('goldholdend', 'red hold end');
			
			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');
			if (isRing) animation.addByPrefix('goldhold', 'red hold piece');
		}

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
	}

	function loadPixelNoteAnims() {
		if(isSustainNote) {
			animation.add('purpleholdend', [PURP_NOTE + 4]);
			animation.add('greenholdend', [GREEN_NOTE + 4]);
			animation.add('redholdend', [RED_NOTE + 4]);
			animation.add('blueholdend', [BLUE_NOTE + 4]);

			animation.add('purplehold', [PURP_NOTE]);
			animation.add('greenhold', [GREEN_NOTE]);
			animation.add('redhold', [RED_NOTE]);
			animation.add('bluehold', [BLUE_NOTE]);
		} else {
			animation.add('greenScroll', [GREEN_NOTE + 4]);
			animation.add('redScroll', [RED_NOTE + 4]);
			animation.add('blueScroll', [BLUE_NOTE + 4]);
			animation.add('purpleScroll', [PURP_NOTE + 4]);
		}
	}
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress) {
			// ok river
			if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * lateHitMult)
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		} else {
			canBeHit = false;

			if (strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult)) {
				if((isSustainNote && prevNote.wasGoodHit) || strumTime <= Conductor.songPosition)
					wasGoodHit = true;
			}
		}

		if (tooLate && !inEditor) {
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
