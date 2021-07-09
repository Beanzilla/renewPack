-- Assistant functions that really should have been placed into an API (Thus I have to lug it around)
local make_grass_path = function(itemstack, placer, pointed_thing)
	-- Use pointed node's on_rightclick function first, if present
	local node = minetest.get_node(pointed_thing.under)
	if placer and not placer:get_player_control().sneak then
		if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
			return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack) or itemstack
		end
	end

	-- Only make grass path if tool used on side or top of target node
	if pointed_thing.above.y < pointed_thing.under.y then
		return itemstack
	end

	if (minetest.get_item_group(node.name, "grass_block") == 1) then
		local above = table.copy(pointed_thing.under)
		above.y = above.y + 1
		if minetest.get_node(above).name == "air" then
			if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
				minetest.record_protection_violation(pointed_thing.under, placer:get_player_name())
				return itemstack
			end

			if not minetest.is_creative_enabled(placer:get_player_name()) then
				-- Add wear (as if digging a shovely node)
				local toolname = itemstack:get_name()
				local wear = mcl_autogroup.get_wear(toolname, "shovely")
				itemstack:add_wear(wear)
			end
			minetest.sound_play({name="default_grass_footstep", gain=1}, {pos = above}, true)
			minetest.swap_node(pointed_thing.under, {name="mcl_core:grass_path"})
		end
	end
	return itemstack
end

-- Assistant functions that really should have been placed into an API (Thus I have to lug it around)
local carve_pumpkin
if minetest.get_modpath("mcl_farming") then
	carve_pumpkin = function(itemstack, placer, pointed_thing)
		-- Use pointed node's on_rightclick function first, if present
		local node = minetest.get_node(pointed_thing.under)
		if placer and not placer:get_player_control().sneak then
			if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
				return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack) or itemstack
			end
		end

		-- Only carve pumpkin if used on side
		if pointed_thing.above.y ~= pointed_thing.under.y then
			return
		end
		if node.name == "mcl_farming:pumpkin" then
			if not minetest.is_creative_enabled(placer:get_player_name()) then
				-- Add wear (as if digging a shearsy node)
				local toolname = itemstack:get_name()
				local wear = mcl_autogroup.get_wear(toolname, "shearsy")
				itemstack:add_wear(wear)
			end
			minetest.sound_play({name="default_grass_footstep", gain=1}, {pos = pointed_thing.above}, true)
			local dir = vector.subtract(pointed_thing.under, pointed_thing.above)
			local param2 = minetest.dir_to_facedir(dir)
			minetest.swap_node(pointed_thing.under, {name="mcl_farming:pumpkin_face", param2 = param2})
			minetest.add_item(pointed_thing.above, "mcl_farming:pumpkin_seeds 4")
		end
		return itemstack
	end
end

-- Assistant functions that really should have been placed into an API (Thus I have to lug it around)
local make_stripped_trunk = function(itemstack, placer, pointed_thing)
    if pointed_thing.type ~= "node" then return end

    local node = minetest.get_node(pointed_thing.under)
    local noddef = minetest.registered_nodes[minetest.get_node(pointed_thing.under).name]

    if not placer:get_player_control().sneak and noddef.on_rightclick then
        return minetest.item_place(itemstack, placer, pointed_thing)
    end
    if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
        minetest.record_protection_violation(pointed_thing.under, placer:get_player_name())
        return itemstack
    end

    if noddef._mcl_stripped_varient == nil then
		return itemstack
	else
		minetest.swap_node(pointed_thing.under, {name=noddef._mcl_stripped_varient, param2=node.param2})
		if not minetest.is_creative_enabled(placer:get_player_name()) then
			-- Add wear (as if digging a axey node)
			local toolname = itemstack:get_name()
			local wear = mcl_autogroup.get_wear(toolname, "axey")
			itemstack:add_wear(wear)
		end
	end
    return itemstack
end

-- Assistant functions that really should have been placed into an API (Thus I have to lug it around)
local hoe_on_place_function = function(wear_divisor)
	return function(itemstack, user, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		local node = minetest.get_node(pointed_thing.under)
		if user and not user:get_player_control().sneak then
			if minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].on_rightclick then
				return minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, user, itemstack) or itemstack
			end
		end

		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			minetest.record_protection_violation(pointed_thing.under, user:get_player_name())
			return itemstack
		end

		if create_soil(pointed_thing.under, user:get_inventory()) then
			if not minetest.is_creative_enabled(user:get_player_name()) then
				itemstack:add_wear(65535/wear_divisor)
			end
			return itemstack
		end
	end
end

-- Pickaxe
minetest.register_tool("renew_tools:pick", {
    description = renew_tools.S("Renewable Pickaxe"),
    inventory_image = "renew_tools_pick.png",
    groups = { tool=1, pickaxe=1, dig_speed_class=5, enchantability=10 },
    tool_capabilities = {
        -- 1/1.2
        full_punch_interval = 0.83333333,
        max_drop_level=5,
        damage_groups = {fleshy=5},
        punch_attack_uses=renew_tools.uses,
    },
    sound = { breaks = "default_tool_breaks" },
    --_repair_material = "mcl_core:diamond",
    _mcl_toollike_wield = true,
    _mcl_diggroups = {
        pickaxey = { speed = 8, level = 5, uses=renew_tools.uses }
    },
})

-- Shovel
minetest.register_tool("renew_tools:shovel", {
    description = renew_tools.S("Renewable Shovel"),
    inventory_image = "renew_tools_shovel.png",
    groups = { tool=1, shovel=1, dig_speed_class=5, enchantability=10 },
    tool_capabilities = {
        full_punch_interval = 1,
        max_drop_level=5,
        damage_groups = {fleshy=5},
        punch_attack_uses=renew_tools.uses,
    },
    on_place = make_grass_path,
    sound = { breaks = "default_tool_breaks" },
    --_repair_material = "mcl_core:diamond",
    _mcl_toollike_wield = true,
    _mcl_diggroups = {
        shovely = { speed = 8, level = 5, uses=renew_tools.uses }
    },
})

-- Axe
minetest.register_tool("renew_tools:axe", {
    description = renew_tools.S("Renewable Axe"),
    inventory_image = "renew_tools_axe.png",
    groups = { tool=1, axe=1, dig_speed_class=5, enchantability=10 },
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=5,
        damage_groups = {fleshy=9},
        punch_attack_uses=renew_tools.uses,
    },
    on_place = make_stripped_trunk,
    sound = { breaks = "default_tool_breaks" },
    --_repair_material = "mcl_core:diamond",
    _mcl_toollike_wield = true,
    _mcl_diggroups = {
        axey = { speed = 8, level = 5, uses=renew_tools.uses }
    },
})

-- Sword
minetest.register_tool("renew_tools:sword", {
    description = renew_tools.S("Renewable Sword"),
    inventory_image = "renew_tools_sword.png",
    groups = { weapon=1, sword=1, dig_speed_class=5, enchantability=10 },
    tool_capabilities = {
        full_punch_interval = 0.625,
        max_drop_level=5,
        damage_groups = {fleshy=7},
        punch_attack_uses=renew_tools.uses,
    },
    sound = { breaks = "default_tool_breaks" },
    --_repair_material = "mcl_core:diamond",
    _mcl_toollike_wield = true,
    _mcl_diggroups = {
        swordy = { speed = 8, level = 5, uses=renew_tools.uses },
        swordy_cobweb = { speed = 8, level = 5, uses=renew_tools.uses }
    },
})

-- Hoe
minetest.register_tool("renew_tools:hoe", {
    description = renew_tools.S("Renewable Hoe"),
    _tt_help = renew_tools.S("Uses: "..renew_tools.uses),
    inventory_image = "renew_tools_hoe.png",
    on_place = hoe_on_place_function(0),
    groups = { tool=1, hoe=1, enchantability=10 },
    tool_capabilities = {
        full_punch_interval = 0.25,
        damage_groups = { fleshy = 1, },
        punch_attack_uses=renew_tools.uses,
    },
    _mcl_toollike_wield = true,
    _mcl_diggroups = {
        hoey = { speed = 8, level = 5, uses=renew_tools.uses }
    },
})

local mat = "renew_plant:plant"
local stk = "group:stick"

minetest.register_craft({
    output = "renew_tools:pick",
    recipe = {
        {mat, mat, mat},
        {"", stk, ""},
        {"", stk, ""}
    }
})

minetest.register_craft({
    output = "renew_tools:axe",
    recipe = {
        {mat, mat},
        {mat, stk},
        {"", stk}
    }
})

minetest.register_craft({
    output = "renew_tools:shovel",
    recipe = {
        {mat},
        {stk},
        {stk}
    }
})

minetest.register_craft({
    output = "renew_tools:sword",
    recipe = {
        {mat},
        {mat},
        {stk}
    }
})

minetest.register_craft({
    output = "renew_tools:hoe",
    recipe = {
        {mat, mat},
        {"", stk},
        {"", stk}
    }
})
