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


-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("addcraft", {
	privs = {
		interact = true
	},
	func = function(playername)
	minetest.register_craft({
	output = "default:dirt_with_grass",
	recipe = {
		{"default:dirt", "default:dirt"},
	}
	})
end
})

-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("curve", {
	privs = {
		interact = true
	},
	func = function(playername)
		local N=50
		for pos=-N, N do
			height=20+round(10*math.sin(pos/N*2*math.pi))
		     minetest.set_node({x = pos, y = height, z = 0}, {name = "default:diamondblock"})
		end
	end
})

-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("gauss2", {
	privs = {
		interact = true
	},
	func = function(playername)
		player=minetest.get_player_by_name(playername)
		local curpos = player:getpos()
		local curblock =  player:get_wielded_item()
		curblock = curblock:get_name()

		local N=50
		for posx=-N, N do
			for posz=-N, N do
				height=round(curpos.y*math.exp(-(posx^2+posz^2)/200))
				if height>0 then
		     		minetest.set_node({x = posx+curpos.x, y = height, z = posz+curpos.z}, 
						  {name = curblock})
				minetest.set_node({x = posx+curpos.x, y = height-1, z = posz+curpos.z}, 
						  {name = curblock})
				end
			end
		end
	end
})


function round(x)
	return math.floor(x+.5)
end

