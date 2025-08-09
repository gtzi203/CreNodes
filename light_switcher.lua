
--light_switcher

minetest.register_craftitem("crenodes:light_switcher", {
    description = S("Light Switcher")..S("@1[Rightclick] to increase light level@2[Leftclick] to decrease light level", "\n", "\n"),
    inventory_image = "crenodes_light_switcher.png",
    stack_max = 1,
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
