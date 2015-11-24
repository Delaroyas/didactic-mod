minetest.register_chatcommand("giveitems", {
	privs = {
		interact = true
	},
	func = function(playername, modname, page)
		local ind=0;
		local iSize=32

	modpagei = modpagei or {}
	
	modpagei[modname] = modpagei[modname] or 0
	modpagei[modname] = modpagei[modname]+1

		local page = modpagei[modname]


		minetest.chat_send_player(playername,  "Page = " .. page .. "(" .. type(page) ..")")
		player=minetest.get_player_by_name(playername)
		for key,item in pairs(minetest.registered_items) do
			if item.name:find(modname)==1 then
				ind=ind+1;
				if ind > iSize*page then
				     return true, " Type '/giveitems ".. modname .. " " .. (page+1) .. "' for the rest. "	
				elseif ind > iSize*(page-1) then
					player:get_inventory():add_item('main', item.name)
				end
				--minetest.chat_send_player(playername, key .. " = " .. item.name)
			end		
		end
		modpagei[modname]=nil
		return true, " You have all the items !"
		
	end
})

--[[ May be obsolete, giveitems gives blocs and items...

minetest.register_chatcommand("givenodes", {
	privs = {
		interact = true
	},
	func = function(playername, modname, page)
		local ind=0;
		local iSize=32

	modpage = modpage or {}
	
	modpage[modname] = modpage[modname] or 0
	modpage[modname] = modpage[modname]+1

		local page = modpage[modname]


		minetest.chat_send_player(playername,  "Page = " .. page .. "(" .. type(page) ..")")
		player=minetest.get_player_by_name(playername)
					
		for key,item in pairs(minetest.registered_nodes) do
			if item.name:find(modname)==1 then
				ind=ind+1;
				if ind > iSize*page then
				     return true, " Type '/givenodes ".. modname .. " " .. (page+1) .. "' for the rest. "	
				elseif ind > iSize*(page-1) then
					player:get_inventory():add_item('main', item.name)
				end
				--minetest.chat_send_player(playername, key .. " = " .. item.name)
			end		
		end
		modpagei[modname]=nil
		return true, " You have all the nodes !"

	end
})
--]]


