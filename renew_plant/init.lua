renew_plant = {}

renew_plant.S = minetest.get_translator("renew_plant")
renew_plant.modpath = minetest.get_modpath("renew_plant")

renew_plant.mtg = minetest.get_modpath("default") or nil
renew_plant.mcl = minetest.get_modpath("mcl_core") or nil

minetest.register_craftitem("renew_plant:plant", {
    description = renew_plant.S("Renewable Plant Fiber"),
    inventory_image = "renew_plant_plant1.png"
})

minetest.register_craft({
    type = "fuel",
    recipe = "renew_plant:plant",
    burntime = 40 -- 10 x https://github.com/minetest/minetest_game/blob/master/mods/default/crafting.lua#L655
})
local p1 = "renew_plant:plant"

minetest.register_craft({
    output = p1.." 1",
    recipe = {
        {"group:leaves", "group:leaves", "group:leaves"},
        {"group:leaves", "group:leaves", "group:leaves"},
        {"group:leaves", "group:leaves", "group:leaves"}
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "default:leaves 9",
    recipe = {
        p1
    }
})

local i_repl = rawget(_G, "item_replicator") or nil
if i_repl ~= nil then
    i_repl.add(p1, 1, 34)
end
