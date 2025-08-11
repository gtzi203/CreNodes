
--crafts

local barrier_crafting_recipe = minetest.settings:get_bool("crenodes.barrier_crafting_recipe") or false
local light_crafting_recipes = minetest.settings:get_bool("crenodes.light_crafting_recipes") or false
local light_switcher_crafting_recipe = minetest.settings:get_bool("crenodes.light_switcher_crafting_recipe") or false
local crenodes_breaking_tool_enabled = minetest.settings:get_bool("crenodes.crenodes_breaking_tool_enabled") or false
local crenodes_breaking_tool_crafting_recipe = minetest.settings:get_bool("crenodes.crenodes_breaking_tool_crafting_recipe") or false

if barrier_crafting_recipe then
    minetest.register_craft({
    	output = "crenodes:barrier 4",
    	recipe = {
    		{glass, glass, glass},
    		{glass, brick, glass},
    		{glass, glass, glass},
    	}
    })
end

if light_crafting_recipes then
    minetest.register_craft({
    	output = "crenodes:light_14 4",
    	recipe = {
    		{"", glass, ""},
    		{glass, lamp, glass},
    		{"", steelblock, ""},
    	}
    })
end

if light_switcher_crafting_recipe then
    minetest.register_craft({
    	output = "crenodes:light_switcher 1",
    	recipe = {
    		{steel_ingot, lamp, steel_ingot},
    		{steel_ingot, copper_ingot, steel_ingot},
    		{steel_ingot, lamp, steel_ingot},
    	}
    })
end

if crenodes_breaking_tool_enabled then
  if crenodes_breaking_tool_crafting_recipe then
      minetest.register_craft({
        output = "crenodes:crenodes_breaking_tool 1",
        recipe = {
          {steel_ingot, lamp, ""},
          {brick, copper_ingot, ""},
          {"", "", steel_ingot},
        }
      })
  end
end
