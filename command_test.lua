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


minetest.register_chatcommand("dumpdesc", {
	privs = {
		interact = true
	},
	func = function(playername, modname)
		local descriptions = {}
	
		ind=0
		for key,item in pairs(minetest.registered_items) do
			if item.name:find(modname)==1 then
				ind=ind+1
				--minetest.chat_send_player(playername, item.name .. " = " .. item.description)
				descriptions[ind] =  item.description 
			end		
		end

	local dump=''
	local previous=''
	for k,thisDesc in spairs(descriptions, function(t,a,b) return t[b] > t[a] end) do
		if not (thisDesc == previous) then
			dump = dump .. thisDesc .. " = \n"
			previous = thisDesc
		end
	    
	end
	filename=minetest.get_modpath(modname).."/locale/description_dump.txt"
       	file = io.open(filename, "w")
	file:write(dump)

		
	end
})



function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

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


