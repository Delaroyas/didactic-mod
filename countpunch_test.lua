minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	--initialise blockpunches as needed	
	blockpunches = blockpunches or {}
	
	local puncher_name = puncher:get_player_name()
	blockpunches[puncher_name] = blockpunches[puncher_name] or 0
	blockpunches[puncher_name] = blockpunches[puncher_name]+1	
	local puncher_name = puncher:get_player_name()
		

	minetest.chat_send_all("Hey!! ".. puncher_name .." as punched ".. blockpunches[puncher_name] .." blocks!!")		
	

end)
