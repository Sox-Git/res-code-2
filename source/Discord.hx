package;

import Sys.sleep;
import discord_rpc.DiscordRpc;
import lime.app.Application;

#if LUA_ALLOWED
import llua.Lua;
import llua.State;
#end

using StringTools;

class DiscordClient
{
	public static var isInitialized:Bool = false;
	public static var imageRpc:String = 'icon';
	public static var smallImageRpc:String = '';
	public static var detailsRpc:String = '';
	public function new()
	{
		trace("Discord Client starting...");
		DiscordRpc.start({
			clientID: "1008647422576177212",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});
		trace("Discord Client started.");

		while (true)
		{
			DiscordRpc.process();
			sleep(2);
			//trace("Discord Client Update");
		}

		DiscordRpc.shutdown();
	}
	
	public static function shutdown()
	{
		DiscordRpc.shutdown();
	}
	
	static function onReady()
	{
		var rpcF:String = 'I AM GOD';
		var rpcS:String = 'JUST DIE';
		if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
			rpcF = TranslationLanguages.Text[rpcF];
		if (TranslationLanguages.Text.exists(rpcS) && ClientPrefs.Language != 'English')
			rpcS = TranslationLanguages.Text[rpcS];
	
		DiscordRpc.presence({
			details: rpcF,
			state: null,
			largeImageKey: 'scary',
			largeImageText: rpcS
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
		trace("Discord Client initialized");
		isInitialized = true;
	}

	public static function changePresence(?details:String = null, ?state:Null<String>, ?smallImageKey:String = null, ?hasStartTimestamp : Bool, ?endTimestamp: Float)
	{
		var rpcBy:String = 'By: Restoration Team';
		if (TranslationLanguages.Text.exists(rpcBy) && ClientPrefs.Language != 'English')
			rpcBy = TranslationLanguages.Text[rpcBy];
		if (details == null)
			details = detailsRpc;
		else
			detailsRpc = details;
			
		if (smallImageKey == null)
			smallImageKey = smallImageRpc;
		else
			smallImageRpc = smallImageKey;

		var startTimestamp:Float = if(hasStartTimestamp) Date.now().getTime() else 0;
		if (endTimestamp > 0)
		{
			endTimestamp = startTimestamp + endTimestamp;
		}
		DiscordRpc.presence({
			details: detailsRpc,
			state: state,
			largeImageKey: imageRpc,
			largeImageText: rpcBy+"("+Application.current.meta.get('version')+")",
			smallImageKey : smallImageRpc,
			startTimestamp : Std.int(startTimestamp / 1000),
			endTimestamp : Std.int(endTimestamp / 1000)
		});
	}

	public static function Cheater()
	{
		var rpcF:String = 'NO CHEATING';
		if (TranslationLanguages.Text.exists(rpcF) && ClientPrefs.Language != 'English')
			rpcF = TranslationLanguages.Text[rpcF];
		DiscordRpc.presence({
			details: ">:(",
			state: null,
			largeImageKey: 'cheat',
			largeImageText: rpcF,
			smallImageKey : null,
			startTimestamp : null,
			endTimestamp : null
		});
	}
	
	public static function SonicIntro()
	{
		DiscordRpc.presence({
			details: "...",
			state: null,
			largeImageKey: 'intro',
			largeImageText: '',
			smallImageKey : null,
			startTimestamp : null,
			endTimestamp : null
		});
	}
	
	public static function FinalCrash()
	{
		DiscordRpc.presence({
			details: "",
			state: null,
			largeImageKey: 'final',
			largeImageText: '',
			smallImageKey : null,
			startTimestamp : null,
			endTimestamp : null
		});
	}
	
	public static function STCutscene()
	{
		DiscordRpc.presence({
			details: "",
			state: null,
			largeImageKey: 'st',
			largeImageText: '',
			smallImageKey : null,
			startTimestamp : null,
			endTimestamp : null
		});
	}

	#if LUA_ALLOWED
	public static function addLuaCallbacks(lua:State) {
		Lua_helper.add_callback(lua, "changePresence", function(details:String, state:Null<String>, ?smallImageKey:String, ?hasStartTimestamp:Bool, ?endTimestamp:Float) {
			changePresence(details, state, smallImageKey, hasStartTimestamp, endTimestamp);
		});
	}
	#end
}
