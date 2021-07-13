-- Pickaxe
minetest.register_tool("renew_tools:pick", {
    description = renew_tools.S("Renewable Pickaxe"),
    inventory_image = "renew_tools_pick.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level=3,
        groupcaps={
            cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=renew_tools.uses, maxlevel=3},
        },
        damage_groups = {fleshy=5},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {pickaxe = 1}
})

-- Shovel
minetest.register_tool("renew_tools:shovel", {
    description = renew_tools.S("Renewable Shovel"),
    inventory_image = "renew_tools_shovel.png",
    wield_image = "renew_tools_shovel.png^[transformR90",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=1,
        groupcaps={
            crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=renew_tools.uses, maxlevel=3},
        },
        damage_groups = {fleshy=4},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {shovel = 1}
})

-- Axe
minetest.register_tool("renew_tools:axe", {
    description = renew_tools.S("Renewable Axe"),
    inventory_image = "renew_tools_axe.png",
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level=1,
        groupcaps={
            choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=renew_tools.uses, maxlevel=3},
        },
        damage_groups = {fleshy=7},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {axe = 1}
})

-- Sword
minetest.register_tool("renew_tools:sword", {
    description = renew_tools.S("Renewable Sword"),
    inventory_image = "renew_tools_sword.png",
    tool_capabilities = {
        full_punch_interval = 0.7,
        max_drop_level=1,
        groupcaps={
            snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=renew_tools.uses, maxlevel=3},
        },
        damage_groups = {fleshy=8},
    },
    sound = {breaks = "default_tool_breaks"},
    groups = {sword = 1}
})

local mat = "renew_plant:plant_tri"
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

-- Hoe
if minetest.get_modpath("farming") or nil then
    local farming = rawget(_G, "farming") or nil
    farming.register_hoe(":renew_tools:hoe", {
        description = renew_tools.S("Renewable Hoe"),
        inventory_image = "renew_tools_hoe.png",
        max_uses=renew_tools.uses,
        material = "renew_tools:renew_plant",
        groups = {hoe = 1}
    })
end
