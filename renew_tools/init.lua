renew_tools = {}

renew_tools.S = minetest.get_translator("renew_tools")
renew_tools.modpath = minetest.get_modpath("renew_tools")

renew_tools.mtg = minetest.get_modpath("default") or nil
renew_tools.mcl = minetest.get_modpath("mcl_core") or nil

-- The direct durability for the tools
renew_tools.uses = 365

-- The amount repaired per global step
renew_tools.factor = 36

-- Do we log when we repair? Used for debugging
renew_tools.log = false

-- Only support repairing tools when they are in the main inventory of the player
local function check_player(player, timer)
    local inv = minetest.get_inventory({type="player", name=player:get_player_name()})
    for i, stack in pairs(inv:get_list("main")) do
        if not stack:is_empty() then
            local name = stack:get_name()
            if name:sub(1,11) == "renew_tools" then
                if stack:get_wear() ~= 0 then
                    stack:add_wear( -renew_tools.factor )
                    inv:set_stack("main", i, stack)
                    if renew_tools.log == true then
                        minetest.log("action", "[renew_tools] ["..i.."] "..stack:get_wear())
                    end
                end
            end
        end
    end
end

if renew_tools.mtg then
    minetest.log("action", "[renew_tools] Detected MTG")
    dofile(renew_tools.modpath.."/mtg_support.lua")
elseif renew_tools.mcl then
    minetest.log("action", "[renew_tools] Detected MCL")
    dofile(renew_tools.modpath.."/mcl_support.lua")
else
    error("Expected either MTG or MineClone2")
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

minetest.log("action", "[renew_tools] Ready")
