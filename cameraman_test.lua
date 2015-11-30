--cameraman_test.lua

--get_look_dir
--getpos

cloop = cloop or {}
minetest.register_chatcommand("cloop", {
	privs = {
		interact = true
	},
	func = function(playername, param1,time)
		cloop[playername]=cloop[playername] or {}
		player=minetest.get_player_by_name(playername)
		--local curpos = player:getpos()
		--local curdir = player:get_look_dir()
		if param1 == "center" then
			cloop[playername].center=player:getpos()
			for i, v in ipairs( cloop[playername].center ) 
			do minetest.chat_send_player(playername, i.."="..v) end	
			minetest.chat_send_player(playername, "x = "..cloop[playername].center.x)	
			return true, "Loop center position recorded"
		elseif param1 == 'pov' then
			cloop[playername].pov=player:getpos()
			return true, "Loop pov position recorded"
		elseif param1 =='loop' then
			cloop[playername].status='running'
			return unpack(cloop.loop_player(player,time))
			--return true, "Loop starting"
		elseif param1 =='stop' then
			cloop[playername].status='stopped'
			--return unpack(cloop.loop_player(player,time))
			return true, "Stoping loop"
		end
		--return true, "Loop position recorded"
		return false, "Options: center pov or loop"
	end
})

function cloop.loop_player(player,time)
	pn=player:get_player_name()
	time=time or 360
	if not cloop[pn] then
		return {false, "Center and POV not specified"}	
	elseif not cloop[pn].center then
		return {false, "Center not specified"}
	elseif not cloop[pn].pov then
		return {false, "POV not specified"}
	end

	
	local r= math.sqrt((cloop[pn].center.x-cloop[pn].pov.x)^2+(cloop[pn].center.z-cloop[pn].pov.z)^2)
	
	local n=360
	for i=1,n do
		if status == 'running' then
			return {true, "Loop stoped"}
		end
		local theta=i/n*math.pi*2
		local thispos={}
		thispos.x=cloop[pn].center.x+r*math.sin(theta)
		thispos.y=cloop[pn].pov.y
		thispos.z=cloop[pn].center.z+r*math.cos(theta)

		local dir={}
		dir.x = thispos.x - cloop[pn].center.x
		dir.y = thispos.y - cloop[pn].center.y;
		dir.z = thispos.z - cloop[pn].center.z;
		local norm=math.sqrt((dir.x)^2+(dir.y)^2+(dir.z)^2)
		dir.x=dir.x/norm
		dir.y=dir.y/norm
		dir.z=dir.z/norm
		local yaw = 0		
		if dir.z<0 then
			yaw = -math.atan(dir.x/dir.z)
		elseif dir.z>0 then
			yaw = math.pi-math.atan(dir.x/dir.z)
		elseif dir.x<0 then
			yaw = 0
		else
			yaw = math.pi
		end

		player:setpos(thispos)
		player:set_look_yaw(yaw)
 		os.execute("sleep "..1)
	end
	return {true, "Loop done"}
end
