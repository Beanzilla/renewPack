local mcl_armor = rawget(_G, "mcl_armor") or nil

local mat = "renew_plant:plant"
local points = {
    head = 3,
    torso = 8,
    legs = 6,
    feet = 3,
}

minetest.register_tool("renew_armor:helmet", {
    description = renew_armor.S("Renewable Helmet"),
    _doc_items_longdesc = renew_armor.S("A self-repairing peice of armor"),
    _doc_items_usagehelp = mcl_armor.usage,
    inventory_image = "renew_armor_inv_helmet.png",
    groups = {armor_head = 1, combat_armor_head = 1, armor = 1, combat_armor = 1, mcl_armor_points = points.head, mcl_armor_toughness = 2, mcl_armor_uses=renew_armor.uses, enchantablility = 20},
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_diamond",
        _mcl_armor_unequip = "mcl_armor_unequip_diamond",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "head",
    _mcl_armor_texture = "renew_armor_helmet.png",
    _mcl_armor_preview = "renew_armor_helmet_preview.png",
})

minetest.register_tool("renew_armor:chestplate", {
    description = renew_armor.S("Renewable Chestplate"),
    _doc_items_longdesc = renew_armor.S("A self-repairing peice of armor"),
    _doc_items_usagehelp = mcl_armor.usage,
    inventory_image = "renew_armor_inv_chestplate.png",
    groups = {armor_torso = 1, combat_armor_torso = 1, armor = 1, combat_armor = 1, mcl_armor_points = points.torso, mcl_armor_toughness = 2, mcl_armor_uses=renew_armor.uses, enchantablility = 20},
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_diamond",
        _mcl_armor_unequip = "mcl_armor_unequip_diamond",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "torso",
    _mcl_armor_texture = "renew_armor_chestplate.png",
    _mcl_armor_preview = "renew_armor_chestplate_preview.png",
})

minetest.register_tool("renew_armor:leggings", {
    description = renew_armor.S("Renewable Leggings"),
    _doc_items_longdesc = renew_armor.S("A self-repairing peice of armor"),
    _doc_items_usagehelp = mcl_armor.usage,
    inventory_image = "renew_armor_inv_leggings.png",
    groups = {armor_legs = 1, combat_armor_legs = 1, armor = 1, combat_armor = 1, mcl_armor_points = points.legs, mcl_armor_toughness = 2, mcl_armor_uses=renew_armor.uses, enchantablility = 20},
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_diamond",
        _mcl_armor_unequip = "mcl_armor_unequip_diamond",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "legs",
    _mcl_armor_texture = "renew_armor_leggings.png",
    _mcl_armor_preview = "renew_armor_leggings_preview.png",
})

minetest.register_tool("renew_armor:boots", {
    description = renew_armor.S("Renewable Boots"),
    _doc_items_longdesc = renew_armor.S("A self-repairing peice of armor"),
    _doc_items_usagehelp = mcl_armor.usage,
    inventory_image = "renew_armor_inv_boots.png",
    groups = {armor_feet = 1, combat_armor_feet = 1, armor = 1, combat_armor = 1, mcl_armor_points = points.feet, mcl_armor_toughness = 2, mcl_armor_uses=renew_armor.uses, enchantablility = 20},
    sounds = {
        _mcl_armor_equip = "mcl_armor_equip_diamond",
        _mcl_armor_unequip = "mcl_armor_unequip_diamond",
    },
    on_place = mcl_armor.equip_on_use,
    on_secondary_use = mcl_armor.equip_on_use,
    _mcl_armor_element = "feet",
    _mcl_armor_texture = "renew_armor_boots.png",
    _mcl_armor_preview = "renew_armor_boots_preview.png",
})

minetest.register_craft({
    output = "renew_armor:helmet",
    recipe = {
        {mat, mat, mat},
        {mat, "", mat}
    },
})

minetest.register_craft({
    output = "renew_armor:chestplate",
    recipe = {
        {mat, "", mat},
        {mat, mat, mat},
        {mat, mat, mat}
    },
})

minetest.register_craft({
    output = "renew_armor:leggings",
    recipe = {
        {mat, mat, mat},
        {mat, "", mat},
        {mat, "", mat}
    },
})

minetest.register_craft({
    output = "renew_armor:boots",
    recipe = {
        {mat, "", mat},
        {mat, "", mat}
    },
})
