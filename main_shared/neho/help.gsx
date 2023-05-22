#include neho\functions;
help_command()
{
	self endon("disconnect");
	player=self;
	
	listScriptCommandHelp(player, "cmd_fov", "^3!fov^7 - Change Fov");
	listScriptCommandHelp(player, "cmd_fps", "^3!fps^7 - Change FPS");
	listScriptCommandHelp(player, "cmd_promod", "^3!promod^7- Change Promod Vision");
	listScriptCommandHelp(player, "cmd_icon", "^3!icon^7 - Change Objective Icon Size");
	listScriptCommandHelp(player, "cmd_playerinfo", "^3!playerinfo^7 - Get Info from Player");
	listScriptCommandHelp(player, "cmd_servers", "^3!servers^7 - List all Servers");
	listScriptCommandHelp(player, "cmd_admins", "^3!admins^7 - List Server Admins");
	listScriptCommandHelp(player, "cmd_aliases", "^3!aliases^7 - Get players name aliases");
	listScriptCommandHelp(player, "cmd_banlist", "^3!banlist^7 - Get last 10 Bans");
	listScriptCommandHelp(player, "cmd_tempbanlist", "^3!tempbanlist^7 - Get last 10 Tempbans");
	listScriptCommandHelp(player, "cmd_list", "^3!list^7 - List all Players");
	listScriptCommandHelp(player, "cmd_help", "^3!help^7 - List all Commands");
	listScriptCommandHelp(player, "cmd_web", "^3!web^7 - Get the website URL");
	listScriptCommandHelp(player, "cmd_mapstats", "^3!mapstats^7 - Get top 3 Players on this Map");
	listScriptCommandHelp(player, "cmd_rule", "^3!rule^7 - Get Server Rules");
	listScriptCommandHelp(player, "cmd_jstats", "^3!jstats^7 - View your Julia stats");
	listScriptCommandHelp(player, "cmd_jtopstats", "^3!jtopstats^7 - Get the Top 3 Player on this Server");
}
