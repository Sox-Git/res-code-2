package;

import openfl.filesystem.File;
import openfl.net.FileReference;
import openfl.events.Event;
import sys.FileSystem;

using StringTools;

class WinPaths
{
	inline static public function copyFileFromWinToFNF(From:String, To:String, ?mods:Bool = false, ?lib:String = 'preload')
	{
		var fileFrom:File = new File(From);
		var libStuff:String;
		switch(lib) {
			case 'shared': libStuff = '/shared/';
			case 'exe': libStuff = '/exe/';
			default: libStuff = '/';
		}
		var FullPathTo:String;
		if (mods)
			FullPathTo = 'mods/images/' + To;
		else
			FullPathTo = 'assets' + libStuff + 'images/' + To;
		trace("Copy From: " + From);
		trace("Copy To: " + FullPathTo);
		var fileTo:File = new File(FullPathTo);
		fileFrom.copyTo(fileTo, true);
	}
	
	inline static public function getDesktopFileNames(onlyFolders:Bool, onlyFiles:Bool, fullPath:Bool, fileExtension:Bool, exportIcons:Bool)
	{
		var desktop:File = File.desktopDirectory;
		var files:Array<File> = desktop.getDirectoryListing();
		var ArrayOfFileNames:Array<String> = [];
		for (i in 0...files.length) {
			if (i != files.length && ((onlyFolders && !onlyFiles && files[i].isDirectory) || (!onlyFolders && onlyFiles && !files[i].isDirectory) || (!onlyFolders && !onlyFiles))) {
				var file:String = files[i].nativePath; //Full file path [C:/Files/rose.png | C:/Files/rose.mp3 | C:/Files/rose.ogg]
				var Split:Array<String> = file.split("\\"); //If Split[4], file name with Extension [rose.png | rose.mp3 |rose.ogg]
				var FileExtension:String = 'Folder'; //Extension [.png | .mp3 | .ogg]
				var OnlyFileName:String = Split[4]; //File name without Extension [rose | rose | rose]
				var FilePathWithoutExtension:String = file; //File path without Extension [C:/Files/rose | C:/Files/rose | C:/Files/rose]
				if (!files[i].isDirectory) {
					FileExtension = '.' + Split[4].split(".")[Split[4].split(".").length-1];
					OnlyFileName = Split[4].replace(FileExtension, '');
					FilePathWithoutExtension = file.replace(FileExtension, '');
				}
				
				if (!ArrayOfFileNames.contains(file) && fullPath && fileExtension) //Full file path
					ArrayOfFileNames.push(file);
				if (!ArrayOfFileNames.contains(Split[4]) && !fullPath && fileExtension) //File name with Extension
					ArrayOfFileNames.push(Split[4]);
				if (!ArrayOfFileNames.contains(FilePathWithoutExtension) && fullPath && !fileExtension) //File path without Extension
					ArrayOfFileNames.push(FilePathWithoutExtension);
				if (!ArrayOfFileNames.contains(OnlyFileName) && !fullPath && !fileExtension) //File name without Extension
					ArrayOfFileNames.push(OnlyFileName);
				
				/*
				trace(
				'-----Desktop File Info ' + [OnlyFileName] + '-----
				File Name: ' + OnlyFileName + '
				File Name With Extension: ' + Split[4] + '
				File Extension: ' + FileExtension + '
				File Path Without Extension: ' + FilePathWithoutExtension + '
				File Path: ' + file + '
				'
				);
				*/
				
				if (exportIcons && !FileSystem.exists('mods/images/fatal-encore-icons/' + OnlyFileName + ".png"))
					Sys.command('${Sys.getCwd()}\\assets\\images\\bgs\\fatal-encore\\extracticon.exe', ["C:\\Users\\" + Main.PCuserName + "\\Desktop\\" + Split[4], '${Sys.getCwd()}\\mods\\images\\fatal-encore-icons\\' + OnlyFileName + ".png"]);
			}
		}
		trace(ArrayOfFileNames);
		return ArrayOfFileNames;
	}
}
