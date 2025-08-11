
--light node

local light_particles = minetest.settings:get_bool("crenodes.light_particles") ~= false
local light_particle_update_time = minetest.settings:get("crenodes.light_particle_update_time") or 0.1
local show_all_light_variants = minetest.settings:get_bool("crenodes.show_all_light_variants") ~= false
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

for level = 1, 14, 1 do
    if show_all_light_variants == false and level == 15 then
        in_creative_inventory = 0
    end
    minetest.register_node("crenodes:light_"..level, {
        description = S("Light (Level @1)", level),
        inventory_image = "crenodes_light_"..level..".png",
        wield_image = "crenodes_light_"..level..".png",
        groups = {dig_immediate = 3, not_in_creative_inventory = in_creative_inventory},
        paramtype = "light",
        drawtype = "airlike",
        is_ground_content = false,
        sunlight_propagates = true,
        light_source = level,
        walkable = false,
        drop = "crenodes:light_"..level,
        sounds = sound,
        on_construct = function(pos)
            meta = minetest.get_meta(pos)
            meta:set_int("light_level", level)
            minetest.get_node_timer(pos):start(0)
        end,
        on_dig = function(pos, node, digger)
          minetest.node_dig(pos, node, digger)
          local player_name = digger:get_player_name()
          if not minetest.is_creative_enabled(player_name) then
            local wield_item = digger:get_wielded_item()
            local tool_wear = math.floor(65535 / crenodes_breaking_tool_max_uses)
            if wield_item:get_name() == "crenodes:crenodes_breaking_tool" then
              wield_item:add_wear(tool_wear)
              digger:set_wielded_item(wield_item)
              if wield_item:get_wear() == 0 then
                minetest.sound_play("default_tool_breaks", {to_player = player_name})
              end
            end
          end
        end,
        on_destruct = function(pos, node, digger)
            minetest.get_node_timer(pos):stop()
        end,
        on_blast = function(pos, intensity)
            return {}
        end,
        can_dig = function(pos, player)
            local player_name = player:get_player_name()
            local wield_item = player:get_wielded_item()
            return minetest.is_creative_enabled(player_name) or wield_item:get_name() == "crenodes:crenodes_breaking_tool"
        end,
        on_timer = function(pos, elapsed)
            if light_particles then
                for _, player in ipairs(minetest.get_connected_players()) do
                    local itemstack = player:get_wielded_item()
                    if itemstack:get_name() == "crenodes:light_"..level or itemstack:get_name() == "crenodes:crenodes_breaking_tool" then
                        minetest.add_particlespawner({
                            amount = 1,
                            time = 0.01,
                            minpos = pos,
                            maxpos = pos,
                            minsize = 10,
                            maxsize = 10,
                            minvel = {x = 0, y = 0, z = 0},
                            maxvel = {x = 0, y = 0, z = 0},
                            minacc = {x = 0, y = 0, z = 0},
                            maxacc = {x = 0, y = 0, z = 0},
                            minexptime = light_particle_update_time + 0.12,
                            maxexptime = light_particle_update_time + 0.12,
                            texture = "crenodes_light_"..level..".png",
                            collisiondetection = false,
                            playername = player:get_player_name()
                        })
                    elseif itemstack:get_name() == "crenodes:light_switcher" then
                        minetest.add_particlespawner({
                            amount = 1,
                            time = 0.01,
                            minpos = pos,
                            maxpos = pos,
                            minsize = 10,
                            maxsize = 10,
                            minvel = {x = 0, y = 0, z = 0},
                            maxvel = {x = 0, y = 0, z = 0},
                            minacc = {x = 0, y = 0, z = 0},
                            maxacc = {x = 0, y = 0, z = 0},
                            minexptime = light_particle_update_time + 0.12,
                            maxexptime = light_particle_update_time + 0.12,
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
