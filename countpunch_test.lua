minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	--initialise blockpunches as needed	
	--blockpunches = blockpunches or {}
	
	local puncher_name = puncher:get_player_name()
	mydata[puncher_name].blockpunches = mydata[puncher_name].blockpunches+1
	
	minetest.chat_send_all("Hey!! ".. puncher_name .." as punched ".. mydata[puncher_name].blockpunches .." blocks!!")		
	

end)
