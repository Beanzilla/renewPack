-- Armor
armor:register_armor(":renew_armor:helmet", {
    description = renew_armor.S("Renewable Helmet"),
    inventory_image = "renew_armor_inv_helmet.png",
    groups = {armor_head=1, armor_heal=renew_armor.heal+1, armor_use=renew_armor.uses, armor_fire=1},
    armor_groups = {fleshy=17},
    damage_groups = {cracky=2, snappy=1, choppy=1, level=3}
})

armor:register_armor(":renew_armor:chestplate", {
    description = renew_armor.S("Renewable Chestplate"),
    inventory_image = "renew_armor_inv_chestplate.png",
    groups = {armor_torso=1, armor_heal=renew_armor.heal+3, armor_use=renew_armor.uses, armor_fire=1},
    armor_groups = {fleshy=25},
    damage_groups = {cracky=2, snappy=1, choppy=1, level=3}
})

armor:register_armor(":renew_armor:leggings", {
    description = renew_armor.S("Renewable Leggings"),
    inventory_image = "renew_armor_inv_leggings.png",
    groups = {armor_legs=1, armor_heal=renew_armor.heal+2, armor_use=renew_armor.uses, armor_fire=1},
    armor_groups = {fleshy=20},
    damage_groups = {cracky=2, snappy=1, choppy=1, level=3}
})

armor:register_armor(":renew_armor:boots", {
    description = renew_armor.S("Renewable Boots"),
    inventory_image = "renew_armor_inv_boots.png",
    groups = {armor_feet=1, armor_heal=renew_armor.heal, armor_use=renew_armor.uses, armor_fire=1},
    armor_groups = {fleshy=15},
    damage_groups = {cracky=2, snappy=1, choppy=1, level=3}
})

local mat = "renew_plant:plant"

minetest.register_craft({
    output = "renew_armor:helmet",
    recipe = {
        {mat, mat, mat},
        {mat, "", mat}
    }
})

minetest.register_craft({
    output = "renew_armor:chestplate",
    recipe = {
        {mat, "", mat},
        {mat, mat, mat},
        {mat, mat, mat}
    }
})

minetest.register_craft({
    output = "renew_armor:leggings",
    recipe = {
        {mat, mat, mat},
        {mat, "", mat},
        {mat, "", mat}
    }
})

minetest.register_craft({
    output = "renew_armor:boots",
    recipe = {
        {mat, "", mat},
        {mat, "", mat}
    }
})
