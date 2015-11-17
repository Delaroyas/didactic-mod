didactic_mod = {}

print("This file will be run at load time!")

dofile(minetest.get_modpath("didactic_mod").."/registers.lua")


dofile(minetest.get_modpath("didactic_mod").."/onpunch_test.lua")
