package;

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
#if sys
import sys.FileSystem;
import sys.io.File;
#end
#if windows
import Discord.DiscordClient;
#end

using StringTools;

class NoCheating extends MusicBeatState
{
	var cheat:FlxSprite;
	var blackshit:FlxSprite;
	private var camGame:FlxCamera;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.Cheater();
		Sys.command('${Sys.getCwd()}\\assets\\exe\\open-cw.bat', ['${Sys.getCwd()}\\assets\\exe\\open-cw.bat', '${Sys.getCwd()}\\assets\\exe\\', 'nocheating.png']);
		#end
		
		new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('firstLOOK'));
			FlxG.sound.playMusic(Paths.music('gameOver_LordX', 'shared'));
		});
		
		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];

		cheat = new FlxSprite().loadGraphic(Paths.image('nocheating', 'exe'));
		cheat.antialiasing = ClientPrefs.globalAntialiasing;
		cheat.screenCenter();
		add(cheat);
		
		blackshit = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
		blackshit.alpha = 1;
		add(blackshit);
		
		new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			FlxTween.tween(blackshit, {alpha: 0}, 1);
		});
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		new FlxTimer().start(5, function(tmr:FlxTimer)
		{
			Sys.exit(0);
		});
	}
}