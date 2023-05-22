#include neho\functions;
#include neho\plugin_http;

init(){		
	thread neho\events::addConnectEvent( ::onConnect );
}

onConnect(){
	
	self endon( "disconnect" );
	dvar = "firstTime_" + self getEntityNumber();

	if( getDvar( dvar ) != self getPlayerID() ){
		self.pers[ "firstTime" ] = true;
		setDvar( dvar, self getPlayerID() );
	}

	if( !isDefined( self.pers[ "meleekills" ] ) )
	{
		self.pers[ "meleekills" ] = 0;
		self.pers[ "explosiveKills" ] = 0;
	}
	
	if( !isArray( self.pers[ "youVSfoe" ] ) )
	{
		self.pers[ "youVSfoe" ] = [];
		self.pers[ "youVSfoe" ][ "killedBy" ] = [];
		self.pers[ "youVSfoe" ][ "killed" ] = [];
	}

	self setClientDvar( "ui_ShowMenuOnly", "" );

	if( isDefined( self.pers[ "fov" ] ) || isDefined( self.pers[ "promodTweaks" ] ) || isDefined( self.pers[ "fullbright" ] ) || isDefined( self.pers[ "icon" ] ) || isDefined( self.pers[ "isadminalready" ] ) ){
		wait .5;
		self thread userSettings();
		// tellClient( self, "Fov:"+self.pers[ "fov" ]+", fullbright:"+self.pers[ "fullbright" ]+", promodTweaks:"+self.pers[ "promodTweaks" ]+", icon:"+self.pers[ "icon" ]);
	} else {
		wait .5;
		self thread GetPlayerVisions();
		wait .5;
		self thread CheckIfAdmin();
	}

	// On first spawn, once //
	self waittill("spawned_player");

		
	if( !isDefined(self.pers[ "firstSpawnTime" ])){
		self.pers[ "firstSpawnTime" ] = getTime();
	}
	
	if( !isDefined(game[ "firstPlayerSpawnTime" ])){
		game[ "firstPlayerSpawnTime" ] = true;
		game[ "firstSpawnTime" ] = self.pers[ "firstSpawnTime" ];
	}

	if(isDefined(WelcomeEnabled("welcome_msg_type"))){
		if( isDefined( self.pers[ "firstTime" ] ) ){
			self thread CheckIfAdmin();
			self thread welcome();
		}
	}	
}

welcome() {
	self endon( "disconnect" );

	dvar = "welcome_" + self getEntityNumber();
	
	// Player is already welcomed
	if( getDvar( dvar ) == self getPlayerID()){
		self.pers[ "welcomed" ] = true;
		return;
	}

	player = self;
	findPlayerCheck(setmyUrl()+"/player/info/", ::PlayerWelcome, player);
	setDvar( dvar, self getPlayerID() );
	wait 2;	
	findPlayerCheck(setmyUrl()+"/stats/rank/", ::PlayerRank, player);
	self.pers[ "welcomed" ] = true;
	self.pers[ "visionsettings" ]= true;
}

CheckIfAdmin() {
	self endon( "disconnect" );
	sid = self getsteamid64();
	if (sid!="0"){
		player = self;
		findPlayerCheck(setmyUrl()+"/player/check-admin/", ::PlayerIsAdmin, player);
	} else {
		dvar = "isadmin_" + self getEntityNumber();
		setDvar(dvar, self getPlayerID());
		self.pers["isadminalready"] = false;
	}
}

GetPlayerVisions() {
	self endon( "disconnect" );
	player = self;
	if (!isDefined(player.pers["isBot"]) || !player.pers["isBot"]){
		findPlayerCheck(setmyUrl()+"/player/info/", ::PlayerSettings, player);
	}
}


userSettings()
{
	// Late joiners might not have these set

	if (checkCommandPermission()==true){
		self.statusIcon = "rank_prestige10";
	}

	if( !isDefined( self.pers[ "fov" ] ) || !isDefined( self.pers[ "promodTweaks" ] ) || !isDefined( self.pers[ "fullbright" ] ) || !isDefined( self.pers[ "icon" ] ) ){
		self thread GetPlayerVisions();
		self thread CheckIfAdmin();
		return;
	} else {
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

		if( self.pers[ "fullbright" ] && self.pers[ "fullbright" ] != 1 ) {
			self setClientDvar( "r_fullbright", 1 );
		}
			
		waittillframeend;

		if( self.pers[ "promodTweaks" ] && self.pers[ "promodTweaks" ] == 2 ) {
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

		switch( self.pers[ "icon" ] )
		{
			case 1:
				self setClientDvar( "waypointiconheight", 36 );
				self setClientDvar( "waypointiconwidth", 36 );
				break;
			case 2:
				self setClientDvar( "waypointiconheight", 24 );
				self setClientDvar( "waypointiconwidth", 24 );
				break;
			case 3:
				self setClientDvar( "waypointiconheight", 12 );
				self setClientDvar( "waypointiconwidth", 12 );
				break;
			default:
				self setClientDvar( "waypointiconheight", 36 );
				self setClientDvar( "waypointiconwidth", 36 );
				break;
		}
	}
}