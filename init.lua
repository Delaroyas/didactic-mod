didactic_mod = {}

print("This file will be run at load time!")

dofile(minetest.get_modpath("didactic_mod").."/registers.lua")
--dofile(minetest.get_modpath("didactic_mod").."/camera_test.lua")
--dofile(minetest.get_modpath("didactic_mod").."/hud_test.lua")
dofile(minetest.get_modpath("didactic_mod").."/command_test.lua")

--onpunch: Unse only one of those:
dofile(minetest.get_modpath("didactic_mod").."/onpunch_test.lua")

--dofile(minetest.get_modpath("didactic_mod").."/countpunch_test.lua")
dofile(minetest.get_modpath("didactic_mod").."/dataio_test.lua")

dofile(minetest.get_modpath("didactic_mod").."/cameraman_test.lua")


