#include neho\functions;

PlayerIsAdmin(handle){
	self endon( "disconnect" );

	dvar = "isadmin_" + self getEntityNumber();

	if (handle == 0){
		is_admin = 0;
		return;
	} else if (!handle){
		is_admin = 0;
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		is_admin = 0;
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		is_admin = 0;
		return;
	} else {
		is_admin = jsonGetInt(handle, "is_admin");
		jsonReleaseObject(handle);
	}

	wait 2;

	if (is_admin==1){
		setDvar(dvar, self getPlayerID());
		self.pers["isadminalready"] = true;
	} else {
		setDvar(dvar, self getPlayerID());
		self.pers["isadminalready"] = false;
	}
}

ServerInfo(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		wait 2;
		count = jsonGetInt(handle, "total");

		for(i=0;i<count;i++){
			ip = jsonGetString(handle, "results.servers."+i+".ip");
			port = jsonGetInt(handle, "results.servers."+i+".port");
			name = jsonGetString(handle, "results.servers."+i+".name");
			country = jsonGetString(handle, "results.servers."+i+".country");
			online_players = jsonGetString(handle, "results.servers."+i+".online_players");
			map_playing = jsonGetString(handle, "results.servers."+i+".map_playing");

			tellClient(self,"^2"+name);
			wait 2;
			tellClient(self,"Address: ^5"+ip+":"+port);
			wait 2;
			tellClient(self,"Location: ^5"+country);
			wait 2;
			tellClient(self,"Players: ^5"+online_players);
			wait 2;
			tellClient(self,"Map: ^5"+map_playing);
		}
		jsonReleaseObject(handle);
	}

	
}

ServerAdmins(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		wait 2;
		count = jsonGetInt(handle, "total");
		tellClient(self,"^7There are: ^3"+count+"^7 Server Admins");

		for(i=0;i<count;i++){
			power = jsonGetInt(handle, "results."+i+".local.user_role");
			name = jsonGetString(handle, "results."+i+".local.user_name");
			wait 2;
			tellClient(self,"^7"+name+"(^2"+power+"^7)");
		}

		jsonReleaseObject(handle);
	}
}


PlayerInfo(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		player_name = jsonGetString(handle, "results.player.player_name");
		player_guid = jsonGetString(handle, "results.player.player_guid");
		player_country = jsonGetString(handle, "results.player.player_country");
		player_city = jsonGetString(handle, "results.player.player_city");
		player_steam_id = jsonGetString(handle, "results.player.player_steam_id");
		is_admin = jsonGetInt(handle, "is_admin");

		switch(is_admin){
			case 0:
				return_admin = "^1No";					
				break;
			case 1:
				return_admin = "^2Yes";					
				break;
			default:
				return_admin = "^1No";
				break;
		}

		tellClient(self,"Name: ^5"+player_name);
		wait 2;
		if(checkPlayerAdmin()==true){
			wait 2;
			tellClient(self, "Server Admin: "+return_admin);
			wait 2;
			tellClient(self,"Guid: ^5"+player_guid);
			wait 2;
			tellClient(self,"SteamID: ^5"+player_steam_id);
			wait 2;
		}

		tellClient(self,"Country: ^5"+player_country);
		wait 2;
		tellClient(self,"City: ^5"+player_city);

		jsonReleaseObject(handle);
	}

	
}

PlayerWelcome(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		player_name = jsonGetString(handle, "results.player.player_name");
		player_country = jsonGetString(handle, "results.player.player_country");
		player_city = jsonGetString(handle, "results.player.player_city");

		if (isDefined(getDvar("welcome_msg_type")) && getDvar("welcome_msg_type")=="2"){
			if (isDefined(player_country)){
				wait 3;
				sayClient("Welcome^5 " + self.name + " ^7from ^5"+player_country+" ^7(^2"+player_city+"^7)");
			}			
		} else {
			if (isDefined(player_country)){
				wait 3;
				sayClient("Welcome^5 " + self.name + " ^7from ^5"+player_country);
			}
		}
		jsonReleaseObject(handle);
	}
}

PlayerAliases(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		count = jsonGetInt(handle, "count");

		for(i=0;i<count;i++){
			wait 2;
			name = jsonGetString(handle, "results."+i);
			tellClient(self,name);
		}
		jsonReleaseObject(handle);
	}
}

PermBanList(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		for(i=0;i<10;i++){
			player_name = jsonGetString(handle, "results.permbans."+i+".player_name");
			admin_name = jsonGetString(handle, "results.permbans."+i+".admin_name");
			wait 2;
			tellClient(self,"^1"+player_name+" ^7by ^5"+admin_name);
		}
		jsonReleaseObject(handle);
	}
}

TempBanList(handle){
	self endon( "disconnect" );
	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		i = 0;
		while(i < 10){
			wait 1;
			player_name = jsonGetString(handle, "results.tempbans."+i+".player_name");
			admin_command = jsonGetString(handle, "results.tempbans."+i+".admin_command");
			admin_name = jsonGetString(handle, "results.tempbans."+i+".admin_name");
			wait 1;

			switch(admin_command){
				case "tempban":
					return_command = "Tempban";					
					break;
				case "chat":
					return_command = "Chat Mute";					
					break;
				case "mute":
					return_command = "Voice Mute";					
					break;
				default:
					return_command = admin_command;
					break;
			}
				
			wait 1;
			tellClient(self,"^1"+player_name+" ^7(^3"+return_command+"^7) by ^5"+admin_name);
			i++;
		}
		jsonReleaseObject(handle);
	}
}

PlayerSettings(handle){

	self endon( "disconnect" );

	if (handle == 0){
		player_fov = level.dvar[ "cmd_fov_default" ];
		player_fps = level.dvar[ "cmd_fps_default" ];
		player_promod = level.dvar[ "cmd_promod_default" ];
		player_icon = level.dvar[ "cmd_icon_default" ];
		return;
	} 
	if (!handle){
		player_fov = level.dvar[ "cmd_fov_default" ];
		player_fps = level.dvar[ "cmd_fps_default" ];
		player_promod = level.dvar[ "cmd_promod_default" ];
		player_icon = level.dvar[ "cmd_icon_default" ];
		return;
	} 
	if(jsonGetString( handle, "status" ) != "okay"){
		player_fov = level.dvar[ "cmd_fov_default" ];
		player_fps = level.dvar[ "cmd_fps_default" ];
		player_promod = level.dvar[ "cmd_promod_default" ];
		player_icon = level.dvar[ "cmd_icon_default" ];
		return;
	} 
	if(jsonGetString( handle, "status" ) == "no_results" ){
		player_fov = level.dvar[ "cmd_fov_default" ];
		player_fps = level.dvar[ "cmd_fps_default" ];
		player_promod = level.dvar[ "cmd_promod_default" ];
		player_icon = level.dvar[ "cmd_icon_default" ];
		return;
	}

	player_fov = jsonGetInt(handle, "results.player.player_fov");
	player_fps = jsonGetInt(handle, "results.player.player_fps");
	player_promod = jsonGetInt(handle, "results.player.player_promod");
	player_icon = jsonGetInt(handle, "results.player.player_icon");
	

	waittillframeend;

	if( level.dvar[ "promod_sniper" ] ){
		self setClientDvars( "player_breath_gasp_lerp", "0",
						 	 "player_breath_gasp_time", "0",
							 "player_breath_gasp_scale", "0", 
							 "cg_drawBreathHint", "0" );
	}
	
	waittillframeend;

	if( !isDefined( self.pers[ "fullbright" ] ) ) {
		self.pers[ "fullbright" ] = player_fps;
	}
	if( !isDefined( self.pers[ "fov" ] ) ) {
		self.pers[ "fov" ] = player_fov;
	}
	if( !isDefined( self.pers[ "promodTweaks" ] ) ) {
		self.pers[ "promodTweaks" ] = player_promod;
	}
	if( !isDefined( self.pers[ "icon" ] ) ) {
		self.pers[ "icon" ] = player_icon;
	}

	waittillframeend;

	switch( self.pers[ "fov" ] ) {
		case 1:
			self setClientDvar( "cg_fovscale", 1.0, "cg_fov", 65 );
			break;
		case 2:
			self setClientDvar( "cg_fovscale", 1.125, "cg_fov", 80 );
			break;
		case 3:
			self setClientDvar( "cg_fovscale", 1.25, "cg_fov", 80 );
			break;
		default:
			break;
	}

	waittillframeend;
	
	if( isDefined( self.pers[ "fullbright" ] ) && self.pers[ "fullbright" ] == 2 ) {
		self setClientDvar( "r_fullbright", 1 );
	}

	waittillframeend;

	if( isDefined( self.pers[ "promodTweaks" ] ) && self.pers[ "promodTweaks" ] == 2 ) {
		self SetClientDvars(
			"r_filmTweakInvert", "0",
			"r_filmTweakBrightness", "0",
			"r_filmusetweaks", "1",
			"r_filmTweakenable", "1",
 			"r_filmtweakLighttint", "0.8 0.8 1",
  			"r_filmTweakContrast", "1.2",
  			"r_filmTweakDesaturation", "0",
  			"r_filmTweakDarkTint", "1.8 1.8 2"
  		);
	} else {
		self SetClientDvars( "r_filmusetweaks", "0", "r_filmTweakenable", "0" );
	}

	waittillframeend;

	if( !isDefined( self.pers[ "icon" ] ) && self.pers[ "icon" ] )
		return;

	switch( self.pers[ "icon" ] )
	{
		case 1:
			self setClientDvar( "waypointiconheight", 36, "waypointiconwidth", 36 );
			break;
		case 2:
			self setClientDvar( "waypointiconheight", 24, "waypointiconwidth", 24 );
			break;
		case 3:
			self setClientDvar( "waypointiconheight", 12, "waypointiconwidth", 12 );
			break;
		default:
			self setClientDvar( "waypointiconheight", 36, "waypointiconwidth", 36 );
			break;
	}

	jsonReleaseObject(handle);
}

PlayerPost(handle){
	self endon( "disconnect" );
	level endon("game_ended");
	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		jsonreleaseobject(handle);
	}
}


TopPlayers(handle){
	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		tellClient(self, "^5Julia Stats, ^2Top 3 ^5Players");
		wait 2;
		count = jsonGetInt(handle, "total");
		for(i=0;i<count;i++){
			player_name = jsonGetString(handle, "top_players."+i+".player_name");
			player_kills = jsonGetInt(handle, "top_players."+i+".player_kills");
			rank = i+1;
			tellClient(self, "^3#"+rank+" "+player_name+" ^7Kills: ^2"+player_kills);
			wait 2;
		}
		jsonReleaseObject(handle);
	}
}

PlayerRank(handle){
	self endon( "disconnect" );

	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		rank = jsonGetInt(handle, "rank");
		kills = jsonGetInt(handle, "kills");
		deaths = jsonGetInt(handle, "deaths");

		if (isDefined(rank) && isDefined(kills) && isDefined(deaths)){
			tellClient(self, "^7Server Rank: ^3"+rank+" ^7 Kills: ^2"+kills+"^7 Deaths: ^1"+deaths);
		}
		jsonReleaseObject(handle);
	}
}

TopPlayersMsg(handle){
	if (handle == 0){
		return;
	} else if (!handle){
		return;
	} else if(jsonGetString( handle, "status" ) != "okay"){
		return;
	} else if(jsonGetString( handle, "status" ) == "no_results" ){
		return;
	} else {
		sayClient("^5Julia Stats, ^2Top 3 ^5Players");
		wait 2;
		count = jsonGetInt(handle, "total");
		for(i=0;i<count;i++){

			player_name = jsonGetString(handle, "top_players."+i+".player_name");
			player_kills = jsonGetInt(handle, "top_players."+i+".player_kills");
			rank = i+1;
			if (isDefined(rank) && isDefined(player_name) && isDefined(player_kills)){
				sayClient("^3#"+rank+" ^7Playername: ^3"+player_name+" ^7Kills: ^2"+player_kills);
				wait 2;
			}
			
		}
		jsonReleaseObject(handle);
	}
}
