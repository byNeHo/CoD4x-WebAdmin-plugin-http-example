#include neho\player;
#include neho\functions;


GloballogicInit() {
	thread neho\dvars::init();
	thread neho\events::init();
}

startGameType()
{
	thread neho\scriptcommands::init();
	thread neho\player::init();

	if( level.dvar[ "server_messages" ] ){
		thread neho\messages::init();
	}
}
