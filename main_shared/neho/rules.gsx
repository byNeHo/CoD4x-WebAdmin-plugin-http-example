#include neho\functions;
init()
{
	level.delay_serv_rules = 2;
	self thread server_rules();
}

server_rules()
{	

	self endon("disconnect");

	svrrls = [];

	if (getDvar("rule_message_1")!=""){
		svrrls[0]=getDvar("rule_message_1");
	}
	if (getDvar("rule_message_2")!=""){
		svrrls[1]=getDvar("rule_message_2");
	}
	if (getDvar("rule_message_3")!=""){
		svrrls[2]=getDvar("rule_message_3");
	}
	if (getDvar("rule_message_4")!=""){
		svrrls[3]=getDvar("rule_message_4");
	}
	if (getDvar("rule_message_5")!=""){
		svrrls[4]=getDvar("rule_message_5");
	}
	if (getDvar("rule_message_6")!=""){
		svrrls[5]=getDvar("rule_message_6");
	}
	if (getDvar("rule_message_7")!=""){
		svrrls[6]=getDvar("rule_message_7");
	}
	if (getDvar("rule_message_8")!=""){
		svrrls[7]=getDvar("rule_message_8");
	}
	if (getDvar("rule_message_9")!=""){
		svrrls[8]=getDvar("rule_message_9");
	}
	if (getDvar("rule_message_10")!=""){
		svrrls[9]=getDvar("rule_message_10");
	}

	for(i = 0; i < svrrls.size; i++) {
		wait level.delay_serv_rules;
		if(getDvarInt("pm_cmd_rule")==1){
			tellClient (self, svrrls[i]);
		} else {
			sayClient (svrrls[i]);
		}
		
	};
}
