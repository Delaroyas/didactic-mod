local function load_data(filename)
   local file = io.open(filename, "r")
   if file then
      local table = minetest.deserialize(file:read("*all"))
      file:close()
      if type(table) == "table" then
         return table
      end
   end   
end

local function save_data(filename, data)
   local file = io.open(filename, "w")
   if file then
      file:write(minetest.serialize(data))
      file:close()
   end
end


local function load_player_moddata(playername,modname) 
	filename=minetest.get_worldpath().."/"..modname.."_"..playername..".dat";
	local thisdata = load_data(filename) or {} -- loads file if it exists, or makes empty table
	minetest.chat_send_all(" Loaded:"..filename)
	return thisdata
end
local function save_player_moddata(playername,modname,mydata)
	
	filename=minetest.get_worldpath().."/"..modname.."_"..playername..".dat";
	save_data(filename, mydata)
	minetest.chat_send_all(" Saved:"..filename)
end





minetest.register_on_leaveplayer(function(player)
	local playername= player:get_player_name()
	minetest.chat_send_all(playername.." has left this awesome game.")
	save_player_moddata(playername,'mydata',mydata[playername])
end)

minetest.register_on_joinplayer(function(player)
	blockpunches = blockpunches or {}
	local playername= player:get_player_name()
	mydata=mydata or {}
	mydata[playername]=load_player_moddata(playername,'mydata') 
	mydata[playername].blockpunches=mydata[playername].blockpunches or 0 
	minetest.chat_send_all(playername.." has joined this awesome game.")
end)

minetest.register_on_shutdown(function()

for _,player in ipairs(minetest.get_connected_players()) do
	local playername = player:get_player_name()
	save_player_moddata(playername,'mydata',mydata[playername])
end


end)


