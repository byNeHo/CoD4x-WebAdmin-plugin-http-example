#include neho\functions;
init()
{
	level.delay_serv_messages = getDvarInt("server_messages_delay");
	level thread server_messages();
}

server_messages()
{	

	self endon("disconnect");

	svrmsg = [];

	if (getDvar("serv_message_1")!=""){
		svrmsg[0]=getDvar("serv_message_1");
	}
	if (getDvar("serv_message_2")!=""){
		svrmsg[1]=getDvar("serv_message_2");
	}
	if (getDvar("serv_message_3")!=""){
		svrmsg[2]=getDvar("serv_message_3");
	}
	if (getDvar("serv_message_4")!=""){
		svrmsg[3]=getDvar("serv_message_4");
	}
	if (getDvar("serv_message_5")!=""){
		svrmsg[4]=getDvar("serv_message_5");
	}
	if (getDvar("serv_message_6")!=""){
		svrmsg[5]=getDvar("serv_message_6");
	}
	if (getDvar("serv_message_7")!=""){
		svrmsg[6]=getDvar("serv_message_7");
	}
	if (getDvar("serv_message_8")!=""){
		svrmsg[7]=getDvar("serv_message_8");
	}
	if (getDvar("serv_message_9")!=""){
		svrmsg[8]=getDvar("serv_message_9");
	}
	if (getDvar("serv_message_10")!=""){
		svrmsg[9]=getDvar("serv_message_10");
	}

	while(1)
	{
		for(i = 0; i < svrmsg.size; i++) {
			wait level.delay_serv_messages;
			sayClient(svrmsg[i]);
		};
	}
}

