minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	local puncher_name = puncher:get_player_name()
	if node.name == "default:brick" then
		local mypos = minetest.pos_to_string(pos) -- Sets variable to (X,Y,Z.. where Y is up) 
		minetest.chat_send_all("Hey!! ".. puncher_name .." is hitting me. I'm located at ".. mypos .." Send help!!")		
	end 
	if node.name == "default:desert_stonebrick" then
		local puncher_name = puncher:get_player_name()
		minetest.chat_send_player(puncher_name, "That's got to hurt!!")
	end

	--local draw=minetest.registered_nodes[node.name].drawtype
	--minetest.chat_send_player(puncher_name, "drawtype: " .. draw)
	--local draw = minetest.registered_nodes["simplyslopes:slope_cobble"].drawtype
	local thisnode=minetest.registered_nodes[node.name]
	for key,value in pairs(thisnode) 
		do		
		if (type(value) == "string") 
		then minetest.chat_send_player(puncher_name, key .. " = " .. value)
		else minetest.chat_send_player(puncher_name, key .. " not string")
		end
	 	
	end
end)
