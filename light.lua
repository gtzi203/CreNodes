
--light node

local S = minetest.get_translator(minetest.get_current_modname())
local light_particles = minetest.settings:get_bool("crenodes.light_particles") ~= false
local light_particle_update_time = minetest.settings:get("crenodes.light_particle_update_time") or 2
local show_all_light_variants = minetest.settings:get_bool("crenodes.show_all_light_variants") ~= false
local light_crating_recipes = minetest.settings:get_bool("crenodes.light_crating_recipes") or false
if show_all_light_variants then
    local in_creative_inventory = 0
else
    local in_creative_inventory = 1
end

minetest.register_lbm({
    name = "crenodes:light_particle_timer",
    nodenames = {"crenodes:light"},
    run_at_every_load = true,
    action = function(pos, node)
        minetest.get_node_timer(pos):start(0)
    end,
})

for level = 1, 15, 1 do
    if show_all_light_variants == false and level == 15 then
        in_creative_inventory = 0
    end
    minetest.register_node("crenodes:light_"..level, {
        description = S("Light (Level @1)", level),
        inventory_image = "crenodes_light_"..level..".png",
        wield_image = "crenodes_light_"..level..".png",
        groups = {crenodes_light = 1, dig_immediate = 3, not_in_creative_inventory = in_creative_inventory},
        paramtype = "light",
        drawtype = "airlike",
        is_ground_content = false,
        sunlight_propagates = true,
        light_source = level,
        walkable = false,
        drop = "",
        sounds = default.node_sound_stone_defaults(),
        on_construct = function(pos)
            meta = minetest.get_meta(pos)
            meta:set_int("light_level", level)
            minetest.get_node_timer(pos):start(0)
        end,
        on_destruct = function(pos)
            minetest.get_node_timer(pos):stop()
        end,
        on_blast = function(pos, intensity)
            return {}
        end,
        can_dig = function(pos, player)
            player_name = player:get_player_name()
            return minetest.is_creative_enabled(player_name)
        end,
        on_timer = function(pos, elapsed)
            if light_particles then
                for _, player in ipairs(minetest.get_connected_players()) do
                    itemstack = player:get_wielded_item()
                    if itemstack:get_name() == "crenodes:light_"..level then
                        minetest.add_particlespawner({
                            amount = 1,
                            time = 0.1,
                            minpos = pos,
                            maxpos = pos,
                            minsize = 10,
                            maxsize = 10,
                            minvel = {x = 0, y = 0, z = 0},
                            maxvel = {x = 0, y = 0, z = 0},
                            minacc = {x = 0, y = 0, z = 0},
                            maxacc = {x = 0, y = 0, z = 0},
                            minexptime = light_particle_update_time + 0.1,
                            maxexptime = light_particle_update_time + 0.1,
                            texture = "crenodes_light_"..level..".png",
                            collisiondetection = false,
                            playername = player:get_player_name()
                        })
                    elseif itemstack:get_name() == "crenodes:light_switcher" then
                        minetest.add_particlespawner({
                            amount = 1,
                            time = 0.1,
                            minpos = pos,
                            maxpos = pos,
                            minsize = 10,
                            maxsize = 10,
                            minvel = {x = 0, y = 0, z = 0},
                            maxvel = {x = 0, y = 0, z = 0},
                            minacc = {x = 0, y = 0, z = 0},
                            maxacc = {x = 0, y = 0, z = 0},
                            minexptime = light_particle_update_time + 0.1,
                            maxexptime = light_particle_update_time + 0.1,
                            texture = "crenodes_light_level_"..level..".png",
                            collisiondetection = false,
                            playername = player:get_player_name()
                        })
                    end
                end
                minetest.get_node_timer(pos):start(light_particle_update_time)
            end
        end
    })
end

minetest.register_craftitem("crenodes:light_switcher", {
    description = S("Light Switcher@1[Rightclick] to increase light level@2[Leftclick] to decrease light level@3", "\n", "\n", "\n"),
    inventory_image = "crenodes_light_switcher.png",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing and pointed_thing.type == "node" then
            pos = pointed_thing.under
            node = minetest.get_node(pos)
            node_name = node.name
            meta = minetest.get_meta(pos)
            level = meta:get_int("light_level")
            if level > 1 then
                minetest.set_node(pos, {name = "crenodes:light_"..level - 1})
            end
        end
    end,
    on_place = function(itemstack, user, pointed_thing)
        if pointed_thing and pointed_thing.type == "node" then
            pos = pointed_thing.under
            node = minetest.get_node(pos)
            node_name = node.name
            meta = minetest.get_meta(pos)
            level = meta:get_int("light_level")
            if level < 15 and level ~= 0 then
                minetest.set_node(pos, {name = "crenodes:light_"..level + 1})
            end
        end
    end
})

if light_crating_recipes then
    minetest.register_craft({
    	output = "crenodes:light_15 4",
    	recipe = {
    		{"", "default:glass", ""},
    		{"default:glass", "default:meselamp", "default:glass"},
    		{"", "default:steelblock", ""},
    	}
    })

    minetest.register_craft({
    	output = "crenodes:light_switcher 1",
    	recipe = {
    		{"default:steel_ingot", "default:meselamp", "default:steel_ingot"},
    		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"},
    		{"default:steel_ingot", "default:meselamp", "default:steel_ingot"},
    	}
    })
end
