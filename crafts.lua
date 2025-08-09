
--crafts

local barrier_crating_recipe = minetest.settings:get_bool("crenodes.barrier_crating_recipe") or false
local light_crating_recipes = minetest.settings:get_bool("crenodes.light_crating_recipes") or false
local light_switcher_crating_recipe = minetest.settings:get_bool("crenodes.light_switcher_crating_recipe") or false

if barrier_crating_recipe then
    minetest.register_craft({
    	output = "crenodes:barrier 4",
    	recipe = {
    		{glass, glass, glass},
    		{glass, brick, glass},
    		{glass, glass, glass},
    	}
    })
end

if light_crating_recipes then
    minetest.register_craft({
    	output = "crenodes:light_15 4",
    	recipe = {
    		{"", glass, ""},
    		{glass, lamp, glass},
    		{"", steelblock, ""},
    	}
    })
end

if light_switcher_crating_recipe then
    minetest.register_craft({
    	output = "crenodes:light_switcher 1",
    	recipe = {
    		{steel_ingot, lamp, steel_ingot},
    		{steel_ingot, copper_ingot, steel_ingot},
    		{steel_ingot, lamp, steel_ingot},
    	}
    })
end
