renew_plant = {}

renew_plant.S = minetest.get_translator("renew_plant")
renew_plant.modpath = minetest.get_modpath("renew_plant")

renew_plant.mtg = minetest.get_modpath("default") or nil
renew_plant.mcl = minetest.get_modpath("mcl_core") or nil

minetest.register_craftitem("renew_plant:plant", {
    description = renew_plant.S("Renewable Plant Fiber"),
    inventory_image = "renew_plant_plant.png"
})

minetest.register_craft({
    type = "fuel",
    recipe = "renew_plant:plant",
    burntime = 40 -- 10 x https://github.com/minetest/minetest_game/blob/master/mods/default/crafting.lua#L655
})

minetest.register_craft({
    output = "renew_plant:plant 1",
    recipe = {
        {"group:leaves", "group:leaves", "group:leaves"},
        {"group:leaves", "group:leaves", "group:leaves"},
        {"group:leaves", "group:leaves", "group:leaves"}
    }
})
