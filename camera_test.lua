minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
puncher:set_eye_offset( {x=0, y=15, z=0}, {x=-10, y=15, z=-5}) 	
end)


