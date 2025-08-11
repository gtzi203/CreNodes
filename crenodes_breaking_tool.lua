
--crenodes_breaking_tool

local crenodes_breaking_tool_enabled = minetest.settings:get_bool("crenodes.crenodes_breaking_tool_enabled") or false

if crenodes_breaking_tool_enabled then
	minetest.register_tool("crenodes:crenodes_breaking_tool", {
		description = S("CreNodes Breaking Tool")..S("@1This tool can be used to break CreNodes nodes in survival mode.", "\n"),
		inventory_image = "crenodes_crenodes_breaking_tool.png",
		wield_image = "crenodes_crenodes_breaking_tool.png^[transformR270",
		stack_max = 1,
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level = 1,
			damage_groups = {fleshy = 1}
		},
		groups = {pickaxe = 1}
	})
end
