init() {
	addDvar( "cmd_fov", "int", 1, 0, 1 );
	addDvar( "cmd_fps", "int", 1, 0, 1 );
	addDvar( "cmd_promod", "int", 1, 0, 1 );
	addDvar( "cmd_icon", "int", 1, 0, 1 );

	addDvar( "cmd_fov_default", "int", 2, 0, 2 );
	addDvar( "cmd_fps_default", "int", 1, 0, 1 );
	addDvar( "cmd_promod_default", "int", 1, 0, 1 );
	addDvar( "cmd_icon_default", "int", 2, 0, 2 );

	addDvar( "cmd_playerinfo", "int", 2, 0, 2 );
	addDvar( "cmd_servers", "int", 2, 0, 2 );
	addDvar( "cmd_admins", "int", 2, 0, 2 );
	addDvar( "cmd_aliases", "int", 2, 0, 2 );
	addDvar( "cmd_banlist", "int", 2, 0, 2 );
	addDvar( "cmd_tempbanlist", "int", 2, 0, 2 );
	addDvar( "cmd_list", "int", 2, 0, 2 );
	addDvar( "cmd_help", "int", 2, 0, 2 );
	addDvar( "cmd_web", "int", 2, 0, 2 );
	addDvar( "cmd_jstats", "int", 2, 0, 2 );
	addDvar( "cmd_jtopstats", "int", 2, 0, 2 );
	addDvar( "cmd_rule", "int", 2, 0, 2 );
	addDvar( "pm_cmd_rule", "int", 1, 0, 1 );
	addDvar( "welcome_msg_type", "int", 2, 0, 2 );
	
	addDvar( "website", "string", "www.mysite.com" );
	
	addDvar( "server_messages", "int", 1, 0, 1 );
	addDvar( "julia_topstats_message", "int", 1, 0, 1 );
}

addDvar( dvarName, dvarType, dvarDefault, minValue, maxValue ) {
	dvarValue = "";
	if ( getdvar( dvarName ) == "" ) {
		dvarValue = dvarDefault;
		setDvar( dvarName, dvarValue );
	} else {
		switch ( dvarType ) {
			case "int":
				dvarValue = getDvarInt( dvarName );
				break;
				
			case "float":
				dvarValue = getdvarFloat( dvarName );
				break;
				
			case "string":
				dvarValue = getDvar( dvarName );
				break;
		}
	}

	if ( isDefined( minValue ) && dvarValue < minValue ) {
		dvarValue = minValue;
	}

	if ( isDefined( maxValue ) && dvarValue > maxValue ) {
		dvarValue = maxValue;
	}

	level.dvar[ dvarName ] = dvarValue;
}