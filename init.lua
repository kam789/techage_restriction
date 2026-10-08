minetest.register_privilege("techage",
    { description = "Able to use all techage machines.", give_to_singleplayer = false })

-- listed nodes require techage priv for placement
-- to add additional nodes, insert new entries into machine_list

local machine_list = {
    "techage:ta5_hl_tank",
    "techage:ta5_hl_chest",
    "techage:ta4_movecontroller",
    "techage:ta4_movecontroller2",
    "techage:ta4_turncontroller",
    "techage:ta5_flycontroller",
    "techage:t4_source",
    
}

minetest.register_on_mods_loaded(function()
    for machinecount = 1, #machine_list do
        if minetest.registered_items[machine_list[machinecount]] then
            minetest.override_item(machine_list[machinecount], {
                on_place = function(itemstack, placer, pointed_thing)
                    local can_mess = minetest.check_player_privs(placer.get_player_name(placer), { techage = true })
                    if not can_mess then
                        minetest.chat_send_player(placer:get_player_name(), "You're not allowed to use this, insufficient privs.")
                        return
                    end
                    return minetest.item_place(itemstack, placer, pointed_thing)
                end
            })
        end
    end
end)
