#include neho\functions;
#include neho\plugin_http;

init()
{
	level thread stats_messages();
}

stats_messages() {
	httpgetjson(setmyUrl()+"/stats/top_players", ::TopPlayersMsg);
	
}