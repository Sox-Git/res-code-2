package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var isRing:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var player3:String; //deprecated, now replaced by gfVersion
	var gfVersion:String;
	
	var bfEncore:String;
	var gfEncore:String;
	var bfSkin:String;
	var gfSkin:String;
	
	var stage:String;

	var arrowSkin:String;
	var splashSkin:String;
	var validScore:Bool;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var isRing:Bool = false;
	public var arrowSkin:String;
	public var splashSkin:String;
	public var speed:Float = 1;
	public var stage:String;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var player3:String = 'gf'; //deprecated
	public var gfVersion:String = 'gf';
	
	public var bfEncore:String = 'bf-encore';
	public var gfEncore:String = 'GF_hedhehog';
	public var bfSkin:String = 'bf';
	public var gfSkin:String = 'gf';

	private static function onLoadJson(songJson:SwagSong) // Convert old charts to newest format
	{	
		if (PlayState.BFSkins || PlayState.BFEncoreSkins) {
			if (PlayState.BFSkins) {
				songJson.player1 = songJson.bfSkin;
			}
			if (PlayState.BFEncoreSkins) {
				songJson.player1 = songJson.bfEncore;
			}
		}
		
		if (PlayState.GFSkins || PlayState.GFEncoreSkins) {
			if (PlayState.GFSkins) {
				songJson.player3 = songJson.gfSkin;
				songJson.gfVersion = songJson.gfSkin;
			}
			if (PlayState.GFEncoreSkins) {
				songJson.player3 = songJson.gfEncore;
				songJson.gfVersion = songJson.gfEncore;
			}
		}
		
		if (!PlayState.GFSkins || !PlayState.GFEncoreSkins) {
			if (!PlayState.GFSkins) {
				if(songJson.gfVersion == null)
				{
					songJson.gfVersion = songJson.player3;
					songJson.gfSkin = songJson.gfVersion;
					songJson.player3 = null;
				} else {
					songJson.player3 = songJson.gfVersion;
					songJson.gfSkin = songJson.gfVersion;
				}
			}
			if (!PlayState.GFEncoreSkins) {
				if(songJson.gfVersion == null)
				{
					songJson.gfVersion = songJson.player3;
					songJson.gfEncore = songJson.gfVersion;
					songJson.player3 = null;
				} else {
					songJson.player3 = songJson.gfVersion;
					songJson.gfEncore = songJson.gfVersion;
				}
			}
		}
		
		if (!PlayState.BFSkins || !PlayState.BFEncoreSkins) {
			if (!PlayState.BFSkins) {
				songJson.player1 = songJson.player1;
				songJson.bfSkin = songJson.player1;
			}
			if (!PlayState.BFEncoreSkins) {
				songJson.player1 = songJson.player1;
				songJson.bfEncore = songJson.player1;
			}
		}
		
		if(songJson.events == null)
		{
			songJson.events = [];
			for (secNum in 0...songJson.notes.length)
			{
				var sec:SwagSection = songJson.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;
				while(i < len)
				{
					var note:Array<Dynamic> = notes[i];
					if(note[1] < 0)
					{
						songJson.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}
					else i++;
				}
			}
		}
	}

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var rawJson = null;
		
		var formattedFolder:String = Paths.formatToSongPath(folder);
		var formattedSong:String = Paths.formatToSongPath(jsonInput);
		#if MODS_ALLOWED
		var moddyFile:String = Paths.modsJson(formattedFolder + '/' + formattedSong);
		if(FileSystem.exists(moddyFile)) {
			rawJson = File.getContent(moddyFile).trim();
		}
		#end

		if(rawJson == null) {
			#if desktop
				#if sys
				rawJson = File.getContent(Paths.json(formattedFolder + '/' + formattedSong)).trim();
				#else
				rawJson = Assets.getText(Paths.json(formattedFolder + '/' + formattedSong)).trim();
				#end
			#else
				#if MODS_ALLOWED
				rawJson = File.getContent(SUtil.getPath() + Paths.json(formattedFolder + '/' + formattedSong)).trim();
				#else
				rawJson = Assets.getText(Paths.json(formattedFolder + '/' + formattedSong)).trim();
				#end
			#end
		}

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		// FIX THE CASTING ON WINDOWS/NATIVE
		// Windows???
		// trace(songData);

		// trace('LOADED FROM JSON: ' + songData.notes);
		/* 
			for (i in 0...songData.notes.length)
			{
				trace('LOADED FROM JSON: ' + songData.notes[i].sectionNotes);
				// songData.notes[i].sectionNotes = songData.notes[i].sectionNotes
			}

				daNotes = songData.notes;
				daSong = songData.song;
				daBpm = songData.bpm; */

		var songJson:SwagSong = parseJSONshit(rawJson);
		if(jsonInput != 'events') StageData.loadDirectory(songJson);
		onLoadJson(songJson);
		return songJson;
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
