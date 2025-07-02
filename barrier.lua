
--barrier

local S = minetest.get_translator(minetest.get_current_modname())
local barrier_particles = minetest.settings:get_bool("crenodes.barrier_particles") ~= false
local barrier_particle_update_time = minetest.settings:get("crenodes.barrier_particle_update_time") or 2
local barrier_crating_recipe = minetest.settings:get_bool("crenodes.barrier_crating_recipe") or false

minetest.register_lbm({
    name = "crenodes:barrier_particle_timer",
    nodenames = {"crenodes:barrier"},
    run_at_every_load = true,
    action = function(pos, node)
        minetest.get_node_timer(pos):start(0)
    end,
})

minetest.register_node("crenodes:barrier", {
    description = S("Barrier"),
    inventory_image = "crenodes_barrier.png",
  	wield_image = "crenodes_barrier.png",
    groups = {dig_immediate = 3},
    paramtype = "light",
    drawtype = "airlike",
    is_ground_content = false,
    sunlight_propagates = true,
    drop = "",
    sounds = default.node_sound_stone_defaults(),
    on_construct = function(pos)
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
        if barrier_particles then
            for _, player in ipairs(minetest.get_connected_players()) do
                itemstack = player:get_wielded_item()
                if itemstack:get_name() == "crenodes:barrier" then
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
                        minexptime = barrier_particle_update_time + 0.1,
                        maxexptime = barrier_particle_update_time + 0.1,
                        texture = "crenodes_barrier.png",
                        collisiondetection = false,
                        playername = player:get_player_name()
                    })
                end
            end
            minetest.get_node_timer(pos):start(barrier_particle_update_time)
        end
    end
})

if barrier_crating_recipe then
    minetest.register_craft({
    	output = "crenodes:barrier 4",
    	recipe = {
    		{"default:glass", "default:glass", "default:glass"},
    		{"default:glass", "default:brick", "default:glass"},
    		{"default:glass", "default:glass", "default:glass"},
    	}
    })
end
