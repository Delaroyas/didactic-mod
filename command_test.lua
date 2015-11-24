minetest.register_chatcommand("givenodes", {
	privs = {
		interact = true
	},
	func = function(playername, itemname, page)
		local ind=0;
		local iSize=32
		local page = page or 1
		minetest.chat_send_player(playername,  "Page = " .. page .. "(" .. type(page) ..")")
		for key,value in pairs(minetest.registered_nodes) do
			player=minetest.get_player_by_name(playername)
			if value.name:find(itemname)==1 then
				ind=ind+1;
				if ind > iSize*page then
				     return true, " Type '/givenodes ".. itemname .. " " .. (page+1) .. "' for the rest. "	
				elseif ind > iSize*(page-1) then
					player:get_inventory():add_item('main', value.name)
				end
				--minetest.chat_send_player(playername, key .. " = " .. value.name)
			end		
		end
		return true, " You have all the items !"
	end
})
