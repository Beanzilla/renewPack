renew_armor = {}

renew_armor.S = minetest.get_translator("renew_armor")
renew_armor.modpath = minetest.get_modpath("renew_armor")

renew_armor.mtg = minetest.get_modpath("default") or nil
renew_armor.mcl = minetest.get_modpath("mcl_core") or nil
renew_armor.da_armor = minetest.get_modpath("3d_armor") or nil

-- The direct durability for the armors
renew_armor.uses = 365
renew_armor.heal = 1

-- The amount repaired per global step
renew_armor.factor = 35

-- Do we log that we did something? (Specifically used for debug
renew_armor.log = false

-- Only support repairing armor when the player is wearing it
local function check_player(player, timer)
    if renew_armor.mtg and renew_armor.da_armor then
	    local _, armor_inv = armor.get_valid_player(armor, player, "[renew_armor]")
        if not armor_inv then return end

        for i, stack in pairs(armor_inv:get_list("armor")) do
            if not stack:is_empty() then
                local name = stack:get_name()
                if name:sub(1, 11) == "renew_armor" then
                    if stack:get_wear() ~= 0 then
                        armor:damage(player, i, stack, -renew_armor.factor)
                        if renew_armor.log == true then
                            minetest.log("action", "[renew_armor] ["..i.."] "..stack:get_wear())
                        end
                    end
                end
            end
        end
    elseif renew_armor.mcl then
        local inv = minetest.get_inventory({type="player", name=player:get_player_name()})
        for i, stack in pairs(inv:get_list("armor")) do
            if not stack:is_empty() then
                local name = stack:get_name()
                if name:sub(1,11) == "renew_armor" then
                    if stack:get_wear() ~= 0 then
                        stack:add_wear( -renew_tools.factor )
                        inv:set_stack("armor", i, stack)
                        if renew_armor.log == true then
                            minetest.log("action", "[renew_armor] mcl ["..i.."] "..stack:get_wear())
                        end
                    end
                end
            end
        end
    end
end

if renew_armor.mtg and renew_armor.da_armor then
    minetest.log("action", "[renew_armor] Detected MTG with 3d_armor")
    dofile(renew_armor.modpath.."/mtg_support.lua")
elseif renew_armor.mcl then
    minetest.log("action", "[renew_armor] Detected MCL")
    dofile(renew_armor.modpath.."/mcl_support.lua")
else
    error("Expected MTG with 3d_armor or MineClone2")
end

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 2 then
        for _, player in ipairs(minetest.get_connected_players()) do
            check_player(player, timer)
        end
        timer = 0
    end
end)

minetest.log("action", "[renew_armor] Ready")