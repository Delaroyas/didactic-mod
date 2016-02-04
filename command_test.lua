-- Test to relaod this file ingame
minetest.register_chatcommand("reload", {
	privs = {
		interact = true
	},
	func = function(playername)
	 dofile(minetest.get_modpath("didactic_mod").."/command_test.lua")
	end
})

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
		buildGaussian(curpos,curblock)
		
	end
})

-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("circle", {
	privs = {
		interact = true
	},
	func = function(playername,radius)
		local radius=tonumber(radius)
		player=minetest.get_player_by_name(playername)
		local curpos = player:getpos()
		local curblock =  player:get_wielded_item()
		curblock = curblock:get_name()

		blocklist=traceCircle(radius)
		for ind,thispos in pairs(blocklist) do
			--local thisnode = minetest.get_node(thispos)
			minetest.set_node(addPosition(curpos,thispos) ,  {name = curblock})
			--buildGaussian(thispos,thisnode.name)
			N=ind
		end
		minetest.chat_send_player(playername,  " Found " .. N .. " nodes")
	end
})





function buildGaussian(curpos,curblock)
local N=50
		for posx=-N, N do
			for posz=-N, N do
				local height=round(curpos.y*math.exp(-(posx^2+posz^2)/200))
				while height>0 do
					local p={x = posx+curpos.x, y = height, z = posz+curpos.z}
					local block=minetest.get_node(p)
					if ( block.name=='air' or block.name=='ignore') then
		     			minetest.set_node(p,  {name = curblock})
						height=height-1
					else
						height=0
					end
				end
			end
		end

end


-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("chain", {
	privs = {
		interact = true
	},
	func = function(playername)
		player=minetest.get_player_by_name(playername)
		local curpos = findClosestBlock(player)
		
		if curpos==nil then
			return false, "Found notting but air"
		else
			local thisnode = minetest.get_node(curpos)
			minetest.chat_send_player(playername,  "Found : " .. thisnode.name )
		end

		blocklist=getNeighbors(curpos)
		for ind,thispos in pairs(blocklist) do
			local thisnode = minetest.get_node(thispos)
			
			buildGaussian(thispos,thisnode.name)
		end
		minetest.chat_send_player(playername,  " Found " .. ind .. " nodes")
	end
})

-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("carpet", {
	privs = {
		interact = true
	},
	func = function(playername,dim)
		local dim=tonumber(dim) or 2
		player=minetest.get_player_by_name(playername)
		local curpos = player:getpos()
		local N=3^dim
		--local H=0;
		local thispos={}
		material ={'default:stone','default:stonebrick','default:sandstone','default:stonebrick','default:desert_stonebrick'}
		material[0]='default:dirt_with_grass'
		for posx=1, N do
			thispos.x=curpos.x+posx
			for posz=1, N do
				thispos.z=curpos.z+posz
				local h=0				
				for s=1, N do
					scale=3^(s-1)
					if ( (math.ceil( posx/scale )%3)==2 and (math.ceil( posz/scale )%3)==2  ) then
						h=s
						
					end
				end
				for ypos=0,h do
					thispos.y=curpos.y+ypos
					minetest.set_node(thispos ,  {name =material[h]})
				end
				
			end
		end
		

	end
})



function getNeighbors(curpos)
blocklist={curpos}
newblocks={curpos}
found={}

ind=1
counter=0
delta=closeBlocks(1)
-- While new blocks are found
while not(next(newblocks) == nil) do
	indFound=0;
	-- Cheack all neibours of each new blocks
	for _,thisblock in pairs(newblocks) do 
		for _,thisoffset in pairs(delta) do 
			-- test for this neibour			
			test=addPosition(thisblock,thisoffset);
			block=minetest.get_node(test)
			-- if not air and not in blocklist			
			if not ( block.name=='air' or block.name=='ignore')then
				if not isItemInList(blocklist,test)   then
					--minetest.chat_send_all("Found " ..block.name)
					-- count it as a new block and put it in the list
					indFound=indFound+1
					found[indFound]=test
					ind=ind+1
					blocklist[ind]=test
				end
			end

			--failsafe... Dont go forever please...
			counter=counter+1
			if counter>100000 then
				minetest.chat_send_all(ind.." failsafe... Too many blocks, Dont go forever please...")
				return blocklist
			end
		end --for
	end-- for
	newblocks=found
	found={}
end-- while
minetest.chat_send_all(ind.." failsafe... Too many blocks Dont go forever please...")
return blocklist
end--function



function findClosestBlock(player)
	local curpos = player:getpos()
	local disp ={};
	for d=1,26 do
		disp = closeBlocks(d)
		for _,delta in pairs(disp) do 
				block=minetest.get_node(addPosition(curpos,delta))
				if not ( block.name=='air' ) then
					return addPosition(curpos,delta)
				end
		end
	end
	return nil
end

-- Test to add a craft with a command (ingame)
minetest.register_chatcommand("revolution", {
	privs = {
		interact = true
	},
	func = function(playername)
		local pos1 = worldedit.pos1[playername]
		local pos2 = worldedit.pos2[playername]
		local dir
		if pos1.x==pos2.x then
			dir ='z'
		else 
			dir ='x'
		end
		local stepr =1
		local limr =  pos2[dir]-pos1[dir]
		if limr<0 then
			stepr=-1
		end
		minetest.chat_send_all(limr)

		--local radius=math.sqrt((pos1.x-pos2.x)^2+(pos1.z-pos2.z)^2)
		player=minetest.get_player_by_name(playername)
		
		local floor=math.min(pos1.y,pos2.y)
		local limh2=math.abs(pos1.y-pos2.y)
		pos1.y=floor
		
		--local curpos = player:getpos()
		--local curblock =  player:get_wielded_item()
		--curblock = curblock:get_name()
		local offset= {x=0, y=0, z=0}
		local height= {x=0, y=0, z=0}
		for radius = limr,stepr,-stepr do
			
			blocklist=traceCircle(math.abs(radius))
			for h = 0,limh2 do
				offset.y=h 
				offset[dir]=radius
				height.y=h

				curblock = minetest.get_node(addPosition(pos1,offset))
				
				curpos=addPosition(pos1,height)

				--minetest.chat_send_all( curblock.name)

				for ind,thispos in pairs(blocklist) do
					minetest.set_node(addPosition(curpos,thispos) ,  curblock)
				end
			end
		end

	end
})



