minetest.register_craftitem("didactic_mod:yellow_lemmon", {
	description = "Yellow Lemmon",
	inventory_image = "didactic_mod_item.png",
	on_use = minetest.item_eat(20)
})




minetest.register_node("didactic_mod:rubik", {
  description = "Rubik",
  tiles = {
    "didactic_mod_red.png",
    "didactic_mod_orange.png",
    "didactic_mod_yellow.png",
    "didactic_mod_white.png",
    "didactic_mod_blue.png",
    "didactic_mod_green.png"
  },
  paramtype2 = "facedir",
  groups = {cracky = 1},
  on_place = minetest.rotate_node,
})
minetest.register_craft({
	output = "didactic_mod:rubik 99",
	recipe = {
		{"", "default:dirt", ""},
		{"default:dirt", "default:dirt", "default:dirt"},
		{"", "default:dirt",  ""}
	}
})

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



-- Node will be called didactic_mod:block_<subname>
function didactic_mod.register_block(subname, recipeitem, groups, images, description, snds)
	minetest.register_node(":didactic_mod:block_" .. subname, {
		description = description.." block",
--		drawtype = "nodebox",
		drawtype = "mesh",
		mesh = "didactic_mod_block.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = snds,
--		node_box = {
--			type = "fixed",
--			fixed = {
--				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
--				{-0.5, 0, 0, 0.5, 0.5, 0.5},
--			},
--		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		on_place = minetest.rotate_node
	})

	minetest.register_craft({
		output = 'didactic_mod:block_' .. subname .. ' 6',
		recipe = {
			{"", "", ""},
			{recipeitem, "", ""},
			{recipeitem, recipeitem,""},
		},
	})
end



didactic_mod.register_block("grass", "default:dirt_with_grass",
	{choppy=2,oddly_breakable_by_hand=2,flammable=3},
	{"default_grass.png"},
	"Grass",
	didactic_mod.grass)

didactic_mod.register_block("cobble", "default:cobble",
	{choppy=2,oddly_breakable_by_hand=2,flammable=3},
	{"default_cobble.png"},
	"Cobble",
	didactic_mod.grass)

