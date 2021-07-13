renew_plant = {}

renew_plant.S = minetest.get_translator("renew_plant")
renew_plant.modpath = minetest.get_modpath("renew_plant")

renew_plant.mtg = minetest.get_modpath("default") or nil
renew_plant.mcl = minetest.get_modpath("mcl_core") or nil

minetest.register_craftitem("renew_plant:plant", {
    description = renew_plant.S("Renewable Plant Fiber"),
    inventory_image = "renew_plant_plant1.png"
})

minetest.register_craftitem("renew_plant:plant_duo", {
    description = renew_plant.S("Renewable Plant Mend"),
    inventory_image = "renew_plant_plant2.png"
})

minetest.register_craftitem("renew_plant:plant_tri", {
    description = renew_plant.S("Renewable Plant Bond"),
    inventory_image = "renew_plant_plant3.png"
})

minetest.register_craft({
    type = "fuel",
    recipe = "renew_plant:plant",
    burntime = 40 -- 10 x https://github.com/minetest/minetest_game/blob/master/mods/default/crafting.lua#L655
})

minetest.register_craft({
    type = "fuel",
    recipe = "renew_plant:plant_duo",
    burntime = 75
})

minetest.register_craft({
    type = "fuel",
    recipe = "renew_plant:plant_tri",
    burntime = 145
})

local p1 = "renew_plant:plant"
local p2 = "renew_plant:plant_duo"
local p3 = "renew_plant:plant_tri"

minetest.register_craft({
    output = p1.." 1",
    recipe = {
        {"group:leaves", "group:leaves", "group:leaves"},
        {"group:leaves", "group:leaves", "group:leaves"},
        {"group:leaves", "group:leaves", "group:leaves"}
    }
})

minetest.register_craft({
    output = p2.." 1",
    recipe = {
        {p1, p1, p1},
        {p1, p1, p1},
        {p1, p1, p1}
    }
})

minetest.register_craft({
    output = p3.." 1",
    recipe = {
        {p2, p2, p2},
        {p2, p2, p2},
        {p2, p2, p2}
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "default:leaves 9",
    recipe = {
        p1
    }
})

minetest.register_craft({
    type = "shapeless",
    output = p1.." 9",
    recipe = {
        p2
    }
})

minetest.register_craft({
    type = "shapeless",
    output = p2.." 9",
    recipe = {
        p3
    }
})
