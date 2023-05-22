setmyUrl(){
	json_url = getDvar( "julia_json_url");
	juliakey = getDvar( "julia_identkey");
	return json_url+juliakey;
}

isInt(s) {
	for( i = 0; i < s.size; i++ ) {
		if( s[ i ] != "0" && !int( s[ i ] ) ) {
			return false;
		}
	}
	return true;
}

getAllPlayers() {
	return getEntArray( "player", "classname" );
}

getPlayerByGuid(guid) {
	if(guid.size > 8)
		guid = getSubStr(guid,guid.size-8,guid.size);
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++)
		if (getSubStr(players[i] getGuid(),24,32) == guid) 
			return players[i];
}

getPlayerByName(nickname) {
	players = getAllPlayers();
	for ( i = 0; i < players.size; i++ ) {
		if ( isSubStr( toLower(players[i].name), toLower(nickname) ) ) {
			return players[i];
		}
	}
}

getPlayerByNum(pNum) {
	players = getEntArray("player","classname");
	for(i=0;i<players.size;i++)
		if ( players[i] getEntityNumber() == int(pNum) ) 
			return players[i];
}

checkPlayerAdmin(){
	if( self.pers["isadminalready"] == true){
		return true;
	} else {
		return false;
	}
}

CheckPermission(){
	if( self.pers["isadminalready"] == true){
		return true;
	} else {
		return false;
	}
}

tellClient(ent, str) {
	exec( "tell " + ent getEntityNumber() + " " + str );
}

sayClient(str) {
	exec( "say "+ str );
}

tellUsageInfo(title, command, description){
	tellClient( self, title+":");
	wait 1;
	tellClient( self, command+" <user>");
	wait 1;
	tellClient( self, description);
	return;
}

findPlayerandExecute(value, http_link, http_callback_name){
	me = self;
	if (isInt(value)){
		player = getPlayerByNum( value );
	} else {
		player = getPlayerByName( value );
	}
	if( isDefined( player )){
		guid = player getGuid();
		return httpgetjson(http_link+guid, http_callback_name, me);
	} else {
		tellClient( self, "No player Found");
		return;
	}
}

//player welcome, player stats and checkadmin
findPlayerCheck(http_link, http_callback_name, player){
	player = self;
	if( isDefined( player )){
		pid = player getplayerid64();
		return httpgetjson(http_link+pid, http_callback_name, player);
	} else {
		tellClient( self, "^1Something is wrong in the CoD4xWebadmin!");
		return;
	}
}

listScriptCommand(cmd_name){
	cmd_name_config="cmd_"+cmd_name;
	if (isDefined(getDvar(cmd_name_config)) && getDvar(cmd_name_config)=="1"){
		return addscriptcommand( cmd_name, 1 );
	} else if (isDefined(getDvar(cmd_name_config)) && getDvar(cmd_name_config)=="2"){
		return addscriptcommand( cmd_name, 1 );
	} else {
		return;
	}
}

ScriptCommandEnabled(cmd_name){
	if (getDvar(cmd_name) == "1" ){
		if(!isDefined(self.pers["team"])) {
			tellClient(self, "Commands currently unavailable, please try again later");
			return;
		}
		return true;
	} else if (getDvar(cmd_name) == "2" ){
		if(!isDefined(self.pers["team"])) {
			tellClient(self, "Commands currently unavailable, please try again later");
			return;
		}
		
		if (checkPlayerAdmin()==true){
			return true;
		} else {
			tellClient(self, "You have ^1not enough Rights^7 to execute this Command!");
			return;
		}
	} else {
		return;
	}
}

WelcomeEnabled(cmd_name){
	if (getDvar(cmd_name) == "1" ){
		return true;
	} else if (getDvar(cmd_name) == "2" ){
		return true;
	} else {
		return;
	}
}

JuliaStatsEnabled(cmd_name){
	if (getDvar(cmd_name) == "1" ){
		return true;
	} else if (getDvar(cmd_name) == "2" ){
		return true;
	} else {
		return;
	}
}

Listplayers(){
	players = getAllPlayers();
	tellClient(self, "Num. ^0[^2SlotNum^0] ^7PlayerName");
	for ( i = 0; i < players.size; i++ ) {
		wait 2;
		num=i+1;
		tellClient(self, num+". ^0[^2"+players[i] getEntityNumber()+"^0] ^7"+players[i].name);
	}
	return;
}

CheckDvar(dvar_name){
	if (getDvarInt(dvar_name) == 1 ){
		return true;
	} else {
		return;
	}
}

listScriptCommandHelp(player,cmd_name,cmd_help_text){
	level.delay_help = 2;
	if (getDvarInt(cmd_name) == 1){
		tellClient(player, cmd_help_text);
		wait level.delay_help;
		return;
	} else if (getDvarInt(cmd_name) == 2 && checkPlayerAdmin()==true){
		tellClient(player, cmd_help_text);
		wait level.delay_help;
		return;
	} else {
		return;
	}
}

checkCommandPermission(){
	if (isDefined( self.pers["isadminalready"] ) && self.pers["isadminalready"]==true){
		return true;
	} else {
		return false;
	}
}
