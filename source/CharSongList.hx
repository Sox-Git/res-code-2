package; 

class CharSongList 
{ 
	public static var data:Map<String,Array<String>> = [ 
		"majin" => ["endless", "endeavors"], 
		"lord x" => ["execution", "cycles", "hellbent", "fate", "judgement", "gatekeepers"], 
		"sunky" => ["milk"], 
		"melthog" => ["melting", "confronting"],
		"tails doll" => ["sunshine", "soulless"], 
		"fleetway" => ["chaos", "running-wild"/*, "heroes-and-villains" */], 
		"faker" => ["faker", "black-sun", "godspeed"],
		"sanic" => ["too-fest"], 
		"christmas" => ["missiletoe", "slaybells", "jingle-hells"],
		"fatal error" => ["fatality", "critical-error"], 
		"furnace" => ["prey", "fight-or-flight"], 
		"needlemouse" => ["relax", "round-a-bout", "spike-trap"], 
		"luther" => ["her-world"],
		"coldsteel" => ["personel", "personel-serious"], 
		"sh tails" => ["mania"],
		"demogri" => ["insidious", "haze", "marauder"],
		"xterion" => ["digitalized", "substantial"], 
		"devoid" => ["hollow", "empty"],
		"shp and genesys" => ["burning"],
		/* "sally alt" => ["agony"], */
		"chaotix" => ["my-horizon", "our-horizon"],
		"hog" => ["hedge", "manual-blast"],
		"curse" => ["malediction", "'choice-of-ending'"],
		"normal cd" => ["found-you"],
		"apollyon" => ["genesis", /*"proverbs",*/ "corinthians"/*, "revelations" */],
		"satanos" => ["perdition", "underworld"/*, "purgatory" */],
		"educator" => ["expulsion"],
		"no name" => ["forever-unnamed"], 
		"gameover" => ["too-far", "last-hope"],
		"requital" => ["forestall-desire"],
		"sl4sh" => ["b4cksl4sh"],
		"mono.bw" => ["color-blind"],
		"dsk" => ["miasma"],
		"omw" => ["universal-collapse", "planestrider"],
		"bratwurst" => ["life-and-death", "gods-will"],
		"nmi" => ["fake-baby"],
		"grimeware" => [/*"lurk", "skincrawler", */"envy"/*, "gorefest"*/],
		"exetior" => ["hellstorm", "sharpy-showdown"],
		"batman" => ["call-of-justice", "gotta-go"],
		"sonichu" => ["shocker", "extreme-zap"],
		"ugly sonic" => ["ugly"],
		"lumpy sonic" => ["frenzy"],
		"sonic.lmn" => ["soured"],
		"futagami" => ["animosity", "reunion"]
	]; 
	 
	public static var characters:Array<String> = [
		"majin", 
		"lord x",
		"sunky", 
		"melthog",
		"tails doll", 
		"fleetway", 
		"faker",
		"sanic", 
		"christmas",
		"fatal error", 
		"furnace",
		"needlemouse", 
		"luther",
		"coldsteel",
		"sh tails",
		"demogri", 
		"xterion", 
		"devoid",
		"shp and genesys",
		/* "sally alt", */
		"chaotix",
		"hog",
		"curse",
		"normal cd", 
		"apollyon",
		"satanos",
		"educator",
		"no name", 
		"gameover",
		"requital",
		"sl4sh",
		"mono.bw",
		"dsk",
		"omw",
		"bratwurst",
		"nmi",
		"grimeware",
		"exetior",
		"batman",
		"sonichu",
		"ugly sonic",
		"lumpy sonic",
		"sonic.lmn",
		"futagami"
	]; 
	
	public static var songToChar:Map<String,String>=[]; 
	
	public static function init() {
		songToChar.clear(); 
		for(character in data.keys()) { 
			var songs = data.get(character); 
			for(song in songs)songToChar.set(song,character); 
		}
	} 
	
     public static function getSongsByChar(char:String) { 
		if(data.exists(char))return data.get(char);
		return []; 
	} 
}