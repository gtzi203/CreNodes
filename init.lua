
--init

local modpath = minetest.get_modpath("crenodes")

S = minetest.get_translator(minetest.get_current_modname())

if minetest.get_modpath("default") then
    sound = default.node_sound_stone_defaults()

    glass = "default:glass"
    brick = "default:brick"
    lamp = "default:meselamp"
    steelblock = "default:steelblock"
    steel_ingot = "default:steel_ingot"
    copper_ingot = "default:copper_ingot"
elseif minetest.get_modpath("mcl_core") then
    sound = mcl_sounds.node_sound_stone_defaults()

    glass = "mcl_core:glass"
    brick = "mcl_core:brick_block"
    lamp = "mcl_nether:glowstone"
    steelblock = "mcl_core:ironblock"
    steel_ingot = "mcl_core:iron_ingot"
    copper_ingot = "mcl_copper:copper_ingot"
end

crenodes_breaking_tool_max_uses = 100

dofile(modpath .. "/barrier.lua")
dofile(modpath .. "/light.lua")
dofile(modpath .. "/light_switcher.lua")
dofile(modpath .. "/crenodes_breaking_tool.lua")
dofile(modpath .. "/crafts.lua")
