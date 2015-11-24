minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)

local player=minetest.get_player_by_name("singleplayer")
if player==nil 
then  minetest.chat_send_all("singleplayer Not Found")
elseif player.name==nil
then minetest.chat_send_all("Name is empty")
else 
minetest.chat_send_all(player.name.."!!! You are here!")
end

end)


--[[
player:hud_add({
    hud_elem_type = "statbar",
    position = {x=0,y=1},
    size = "",
    text = "ui_heart_bg.png",
    number = 20,
    alignment = {x=0,y=1},
    offset = {x=0, y=-32},
})
health_hud[name] = player:hud_add({
    hud_elem_type = "statbar",
    position = {x=0,y=1},
    size = "",
    text = "ui_heart_fg.png",
    number = player:get_hp(),
    alignment = {x=0,y=1},
    offset = {x=0, y=-32},
})
--]]
