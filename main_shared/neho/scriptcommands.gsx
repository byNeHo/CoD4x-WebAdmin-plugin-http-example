#include neho\functions;
#include neho\plugin_http;

init() {
	listScriptCommand("servers");
	listScriptCommand("playerinfo");
	listScriptCommand("admins");
	listScriptCommand("aliases");
	listScriptCommand("banlist");
	listScriptCommand("tempbanlist");
	listScriptCommand("list");
	listScriptCommand("rule");
	listScriptCommand("web");
	listScriptCommand("help");
	listScriptCommand("jtopstats");
	listScriptCommand("jstats");

	level endon("game_ended");
	
	listScriptCommand("fov");
	listScriptCommand("fps");
	listScriptCommand("promod");
	listScriptCommand("icon");
}

commandHandler(cmd, arg) {

	self endon("disconnect");

	pid = self getplayerid64();
	
	player = self;

	switch(toLower( cmd ))
	{
		case "servers":
			if (isDefined(ScriptCommandEnabled("cmd_servers")) && ScriptCommandEnabled("cmd_servers")==true){
				httpgetjson(setmyUrl()+"/server/info", ::ServerInfo, player);
				return;
			};
			break;
		case "admins":
			if (isDefined(ScriptCommandEnabled("cmd_admins")) && ScriptCommandEnabled("cmd_admins")==true){
				if (checkCommandPermission()==true){
					httpgetjson(setmyUrl()+"/server/admins", ::ServerAdmins, player);
					return;
				} else {
					tellClient( player, "^7You have ^1No Rights^7 to execute this Command");
					return;
				}
			};
			break;
		case "playerinfo":
			if (isDefined(ScriptCommandEnabled("cmd_playerinfo")) && ScriptCommandEnabled("cmd_playerinfo")==true){
				if( isDefined( arg ) && arg != "" ) {
					findPlayerandExecute(arg, setmyUrl()+"/player/info/", ::PlayerInfo);
					return;
				} else {
					tellUsageInfo("Usage", "playerinfo", "Where user is one of the following: online-username | online-playerslot");
					return;
				}
			};
			break;
		case "aliases":
			if (isDefined(ScriptCommandEnabled("cmd_aliases")) && ScriptCommandEnabled("cmd_aliases")==true){
				if (checkCommandPermission()==true){
					if( isDefined( arg ) && arg != "" ) {
						findPlayerandExecute(arg, setmyUrl()+"/player/name-aliases/", ::PlayerAliases);
						return;
					} else {
						tellUsageInfo("Usage", "aliases", "Where user is one of the following: online-username | online-playerslot");
						return;
					}
				} else {
					tellClient( player, "^7You have ^1No Rights^7 to execute this Command");
					return;
				}
			};
			break;
		case "banlist":
			if (isDefined(ScriptCommandEnabled("cmd_banlist")) && ScriptCommandEnabled("cmd_banlist")==true){
				if (checkCommandPermission()==true){
					httpgetjson(setmyUrl()+"/banlist/permbans", ::PermBanList, player);
					return;
				} else {
					tellClient( player, "^7You have ^1No Rights^7 to execute this Command");
					return;
				}
			};
			break;
		case "tempbanlist":
			if (isDefined(ScriptCommandEnabled("cmd_tempbanlist")) && ScriptCommandEnabled("cmd_tempbanlist")==true){
				if (checkCommandPermission()==true){
					httpgetjson(setmyUrl()+"/banlist/tempbans", ::TempBanList, player);
					return;
				} else {
					tellClient( player, "^7You have ^1No Rights^7 to execute this Command");
					return;
				}
			};
			break;
		case "list":
			if (isDefined(ScriptCommandEnabled("cmd_list")) && ScriptCommandEnabled("cmd_list")==true){
				self thread Listplayers();
				return;
			};
			break;
		case "jstats":
			if (isDefined(ScriptCommandEnabled("cmd_jstats")) && ScriptCommandEnabled("cmd_jstats")==true){
				findPlayerCheck(setmyUrl()+"/stats/rank/", ::PlayerRank, player);
				return;
			};
			break;
		case "jtopstats":
			if (isDefined(ScriptCommandEnabled("cmd_jtopstats")) && ScriptCommandEnabled("cmd_jtopstats")==true){
				httpgetjson(setmyUrl()+"/stats/top_players", ::TopPlayers, player);
				return;
			};
			break;
		case "fps":
				if (ScriptCommandEnabled("cmd_fps")==true){
					if(self.pers[ "fullbright" ] == 1) {
						tellClient( self, "Fullbright | ^2ON");
						self setClientDvar( "r_fullbright", 1 );
						self setstat( 3160, 2 );
						self.pers[ "fullbright" ] = 2;

						if( self.pers[ "promodTweaks" ] == 2 ){
							tellClient( self, "Promod vision | ^1OFF");
							self SetClientDvars( "r_filmusetweaks", "0",
												 "r_filmTweakenable", "0" );
							self setstat( 3162, 1 );
							self.pers[ "promodTweaks" ] = 1;
							httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_fps\":2, \"player_promod\":1}",::PlayerPost);
						} else {
							httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_fps\":2}",::PlayerPost);
						}
					} else {
						tellClient( self, "Fullbright | ^1OFF");
						self setClientDvar( "r_fullbright", 0 );
						self setstat( 3160, 1 );
						self.pers[ "fullbright" ] = 1;
						httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_fps\":1}",::PlayerPost);
					}
					break;
				}

			case "fov":
				if (ScriptCommandEnabled("cmd_fov")==true){
					if( self.pers["fov"] == 3 ){
						tellClient( self, "Field of View Scale: ^11.125");
						self setClientDvar( "cg_fovscale", 1.125, "cg_fov", 80 );
						self setstat( 3161, 2 );
						self.pers[ "fov" ] = 2;
						httppostjson(setmyUrl()+"/player/info/update/"+pid,"{\"player_fov\":2}",::PlayerPost);
					} else if ( self.pers["fov"] == 1 ){
						tellClient( self, "Field of View Scale: ^11.25");
						self setClientDvar( "cg_fovscale", 1.25, "cg_fov", 80);
						self setstat( 3161, 3 );
						self.pers[ "fov" ] = 3;
						httppostjson(setmyUrl()+"/player/info/update/"+pid,"{\"player_fov\":3}",::PlayerPost);	
					} else if ( self.pers["fov"] == 2 ){
						tellClient( self, "Field of View Scale: ^11.0");
						self setClientDvar( "cg_fovscale", 1.0, "cg_fov", 65 );
						self setstat( 3161, 1 );
						self.pers[ "fov" ] = 1;
						httppostjson(setmyUrl()+"/player/info/update/"+pid,"{\"player_fov\":1}",::PlayerPost);
					}
					break;
				}

			case "promod":
				if (ScriptCommandEnabled("cmd_promod")==true){
					if( self.pers[ "promodTweaks" ] == 1 ) {
						tellClient( self, "Promod vision | ^2ON");
						self SetClientDvars( "r_filmTweakInvert", "0",
											 "r_filmTweakBrightness", "0",
											 "r_filmusetweaks", "1",
											 "r_filmTweakenable", "1",
											 "r_filmtweakLighttint", "0.8 0.8 1",
											 "r_filmTweakContrast", "1.2",
											 "r_filmTweakDesaturation", "0",
											 "r_filmTweakDarkTint", "1.8 1.8 2" );

						self setstat( 3162, 2 );
						self.pers[ "promodTweaks" ] = 2;
						
						if( self.pers[ "fullbright" ] == 2 )	{
							tellClient( self, "Fullbright | ^1OFF");
							self setClientDvar( "r_fullbright", 1 );
							self setstat( 3160, 1 );
							self.pers[ "fullbright" ] = 1;
							httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_promod\":2, \"player_fps\":1}",::PlayerPost);
						} else {
							httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_promod\":2}",::PlayerPost);
						}
					} else {
						tellClient( self, "Promod vision | ^1OFF");
						self SetClientDvars( "r_filmusetweaks", "0",
											 "r_filmTweakenable", "0"
						);
						self setstat( 3162, 1 );
						self.pers[ "promodTweaks" ] = 1;
						httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_promod\":1}",::PlayerPost);
					}
					break;
				}

			case "icon":
				if (ScriptCommandEnabled("cmd_icon")==true){
					if(self.pers[ "icon" ] == 3 ) {
						tellClient( self, "Plant Icon Size:^1 36");
						self setstat( 3164, 1 );
						self setClientDvar( "waypointiconheight", 36 );
						self setClientDvar( "waypointiconwidth", 36 );
						self.pers[ "icon" ] = 1;
						httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_icon\":1}",::PlayerPost);
					}
					else if(self.pers[ "icon" ] == 1)
					{
						tellClient( self, "Plant Icon Size:^1 24");
						self setstat( 3164, 2 );
						self setClientDvar( "waypointiconheight", 24 );
						self setClientDvar( "waypointiconwidth", 24 );
						self.pers[ "icon" ] = 2;
						httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_icon\":2}",::PlayerPost);
					}
					else if(self.pers[ "icon" ] == 2)
					{
						tellClient( self, "Plant Icon Size:^1 12");
						self setstat( 3164, 3 );
						self setClientDvar( "waypointiconheight", 12 );
						self setClientDvar( "waypointiconwidth", 12 );
						self.pers[ "icon" ] = 3;
						httppostjson(setmyUrl()+"/player/info/update/"+pid, "{\"player_icon\":3}",::PlayerPost);
					}
					break;
				}

			case "rule":
				if (ScriptCommandEnabled("cmd_rule")==true){
					self thread neho\rules::init();
				}
				break;
			case "help":
				if (ScriptCommandEnabled("cmd_help")==true){
					self thread neho\help::help_command();
				}
				break;

			case "web":
				if (ScriptCommandEnabled("cmd_web")==true){
					tellClient( self, "Visit Us "+getDvar("web_text"));
				}
				break;
			default:
				print( "You see me? Well ... :(\n" );
				break;
	}
}
